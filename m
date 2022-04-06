Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05C354F6DAC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 00:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236925AbiDFWK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 18:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbiDFWKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 18:10:23 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 71BB312D0B6;
        Wed,  6 Apr 2022 15:08:25 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3B69112FC;
        Wed,  6 Apr 2022 15:08:25 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.57.9.217])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4CC4A3F5A1;
        Wed,  6 Apr 2022 15:08:23 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     lukasz.luba@arm.com, dietmar.eggemann@arm.com,
        viresh.kumar@linaro.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        amit.kachhap@gmail.com, linux-pm@vger.kernel.org
Subject: [RFC PATCH v3 0/5] Introduce Cpufreq Active Stats
Date:   Wed,  6 Apr 2022 23:08:04 +0100
Message-Id: <20220406220809.22555-1-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This is the 3rd version of patch set which tries to address issues which are
due to missing proper information about CPU performance in time.

The issue description:
1. "Cpufreq statistics cover the time when CPUs are in idle states, so they
   are not suitable for certain purposes, like thermal control." Rafael [2]
2. Thermal governor Intelligent Power Allocation (IPA) has to estimate power,
   for the last period, e.g. 100ms, for each CPU in the Cluster, to grant new
   power and set max possible frequency. Currently in some cases it gets big
   error, when the frequency of CPU changed in the middle. It is due to the
   fact that IPA reads the current frequency for the CPU, not aware of all
   other frequencies which were actively (not in idle) used in the last 100ms.

This code focuses on tracking the events of idle entry/exit for each CPU
and combine them with the frequency tracked statistics inside internal
statistics arrays (per-CPU). In the old cpufreq stats we have one shared
statistics array for the policy (all CPUs) and not take into account
periods when each CPU was in idle.

Sometimes the IPA error between old estimation signal and reality is quite
big (>50%).

changelog:
v3:
- moved the core implementation into the cpufreq and not
  creating a new framework (as sugested by Rafael)
- updated all function names and APIs
v2 [1]


Regards,
Lukasz Luba

[1] https://lore.kernel.org/all/20210706131828.22309-1-lukasz.luba@arm.com/
[2] https://lore.kernel.org/all/CAJZ5v0gzpfT__EyrVuZSr32ms7-YJZw7qEok0WZECv1iDRRvWA@mail.gmail.com/

Lukasz Luba (5):
  cpufreq: stats: Introduce Cpufreq Active Stats
  cpuidle: Add Cpufreq Active Stats calls tracking idle entry/exit
  thermal: Add interface to cooling devices to handle governor change
  thermal: power allocator: Prepare power actors and calm down when not
    used
  thermal: cpufreq_cooling: Improve power estimation using Cpufreq
    Active Stats

 MAINTAINERS                           |   2 +-
 drivers/cpufreq/cpufreq_stats.c       | 872 ++++++++++++++++++++++++++
 drivers/cpuidle/cpuidle.c             |   5 +
 drivers/thermal/cpufreq_cooling.c     | 131 ++++
 drivers/thermal/gov_power_allocator.c |  71 +++
 include/linux/cpufreq_stats.h         | 131 ++++
 include/linux/thermal.h               |   1 +
 7 files changed, 1212 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/cpufreq_stats.h

-- 
2.17.1

