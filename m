Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4F1F4AB5F3
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 08:49:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234611AbiBGHnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 02:43:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244580AbiBGHie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 02:38:34 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C42D7C043185;
        Sun,  6 Feb 2022 23:38:33 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 54CBFD6E;
        Sun,  6 Feb 2022 23:30:47 -0800 (PST)
Received: from e123648.arm.com (unknown [10.57.15.201])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 49E2B3F73B;
        Sun,  6 Feb 2022 23:30:45 -0800 (PST)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     amit.kachhap@gmail.com, daniel.lezcano@linaro.org,
        viresh.kumar@linaro.org, rafael@kernel.org, amitk@kernel.org,
        rui.zhang@intel.com, dietmar.eggemann@arm.com, lukasz.luba@arm.com,
        Pierre.Gondois@arm.com
Subject: [PATCH 0/2] Ignore Energy Model with abstract scale in IPA and DTPM
Date:   Mon,  7 Feb 2022 07:30:34 +0000
Message-Id: <20220207073036.14901-1-lukasz.luba@arm.com>
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

The Energy Model supports abstract scale power values. This might cause
issues for some mechanisms like thermal governor IPA or DTPM, which
expect that all devices provide sane power values. This patch set prevents
from registering such devices for IPA and DTPM.

Regards,
Lukasz

Lukasz Luba (2):
  thermal: cooling: Check Energy Model type in cpufreq_cooling and
    devfreq_cooling
  powercap: DTPM: Check Energy Model type for power values scale

 drivers/powercap/dtpm_cpu.c       |  2 +-
 drivers/thermal/cpufreq_cooling.c |  2 +-
 drivers/thermal/devfreq_cooling.c | 16 +++++++++++++---
 3 files changed, 15 insertions(+), 5 deletions(-)

-- 
2.17.1

