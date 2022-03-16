Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71CE54DBB5E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 00:52:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350119AbiCPXxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 19:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbiCPXxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 19:53:42 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D17EEDA6;
        Wed, 16 Mar 2022 16:52:23 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4DA3F1476;
        Wed, 16 Mar 2022 16:52:23 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.57.19.225])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 61BC43F766;
        Wed, 16 Mar 2022 16:52:20 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     lukasz.luba@arm.com, dietmar.eggemann@arm.com,
        Pierre.Gondois@arm.com, ionela.voinescu@arm.com,
        viresh.kumar@linaro.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
        mka@chromium.org, nm@ti.com, sboyd@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, cristian.marussi@arm.com,
        sudeep.holla@arm.com, matthias.bgg@gmail.com
Subject: [0/8] Introduce support for artificial Energy Model
Date:   Wed, 16 Mar 2022 23:52:03 +0000
Message-Id: <20220316235211.29370-1-lukasz.luba@arm.com>
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

This patch set adds new callback and support for artificial Energy Model (EM).
The new EMs have artificially generated performance states.
Such EMs can be created from lean information sources, such
as the relative energy efficiency between CPUs. The ACPI based
platforms provide this information
(ACPI 6.4, s5.2.12.14 'GIC CPU Interface (GICC) Structure'
'Processor Power efficiency Class' field).

Artificial EMs might require to directly provide the 'cost' of
the generated performance state. This patch set adds a new callback
.get_cost() for this. The EM framework does not force any model
or formula, it's up to the platform code.

Artificial EMs aim to leverage the Energy Aware Scheduler
(EAS). Other frameworks relying on performance states
information (i.e. IPA/DTPM) must be informed of the
EM type and might be prevented from using it. This patch
sets also does this by introducing a new flag:
EM_PERF_DOMAIN_ARTIFICIAL.

The patch set is based on current linux-next, where some
changes to OPP & EM are queuing.

The patch set also contains (patch 7/8 and patch 8/8) logic which prevents
two EM's client frameworks from using this new EM type. Some other approach,
using 'milli-watts', has been proposed and discussed, but refused [1].
This new flag is more precised and should not leave space for
wrong interpretation.

Shortly after this patch set you will see a patch set implementing the
platform code and registering this new EM.

Regards,
Lukasz Luba

[1] https://lore.kernel.org/linux-pm/20220207073036.14901-1-lukasz.luba@arm.com/

Lukasz Luba (7):
  PM: EM: Add .get_cost() callback
  PM: EM: Use the new .get_cost() callback while registering EM
  PM: EM: Change the order of arguments in the .active_power() callback
  PM: EM: Remove old debugfs files and print all 'flags'
  Documentation: EM: Add artificial EM registration description
  thermal: cooling: Check Energy Model type in cpufreq_cooling and
    devfreq_cooling
  powercap: DTPM: Check for Energy Model type

Pierre Gondois (1):
  PM: EM: Add artificial EM flag

 Documentation/power/energy-model.rst  | 24 +++++++++-
 drivers/cpufreq/mediatek-cpufreq-hw.c |  4 +-
 drivers/cpufreq/scmi-cpufreq.c        |  4 +-
 drivers/opp/of.c                      |  6 +--
 drivers/powercap/dtpm_cpu.c           |  2 +-
 drivers/thermal/cpufreq_cooling.c     |  2 +-
 drivers/thermal/devfreq_cooling.c     |  8 ++--
 include/linux/energy_model.h          | 35 +++++++++++++--
 kernel/power/energy_model.c           | 63 +++++++++++++++------------
 9 files changed, 101 insertions(+), 47 deletions(-)

-- 
2.17.1

