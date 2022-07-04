Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD98565374
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 13:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233702AbiGDL2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 07:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233427AbiGDL21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 07:28:27 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 00FDA559E;
        Mon,  4 Jul 2022 04:28:27 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 19717D6E;
        Mon,  4 Jul 2022 04:28:27 -0700 (PDT)
Received: from pierre123.arm.com (unknown [10.57.41.108])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 328E93F66F;
        Mon,  4 Jul 2022 04:28:24 -0700 (PDT)
From:   Pierre Gondois <pierre.gondois@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ionela.Voinescu@arm.com, Dietmar.Eggemann@arm.com,
        Pierre Gondois <pierre.gondois@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v2 0/4] qcom-cpufreq-hw LMH irq/hotplug interractions
Date:   Mon,  4 Jul 2022 13:27:35 +0200
Message-Id: <20220704112739.3020516-1-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2:
- Rebased on v5.19-rc5
- Changed irq checks from '< 0' to '<= 0' to be aligned

The patch-set was tested on a rb5 with an old firmware version:
UEFI Ver    : 5.0.210817.BOOT.XF.3.2-00354-SM8250-1
Build Info  : 64b Aug 17 2021 23:35:39

commit ffd6cc92ab9c ("arm64: dts: qcom: sm8250: add description of dcvsh
interrupts")
enables DCVS (Dynamic Clock and Voltage Scaling) for sm8250 chips
(so rb5 included). As no LMH (Limits Management Hardware) interrupts
were seen, the firmware used for testing should not be able support
them.

This patch-set should still contain relevant modifications regarding
LMH interrupts and CPU hotplug. Still, it would be good to test
it on a platform which actually uses LMH interrupts.

Pierre Gondois (4):
  cpufreq: qcom-hw: Reset cancel_throttle when policy is re-enabled
  cpufreq: qcom-hw: Disable LMH irq when disabling policy
  cpufreq: qcom-hw: Remove deprecated irq_set_affinity_hint() call
  cpufreq: Change order of online() CB and policy->cpus modification

 drivers/cpufreq/cpufreq.c         |  6 +++---
 drivers/cpufreq/qcom-cpufreq-hw.c | 11 ++++++++---
 2 files changed, 11 insertions(+), 6 deletions(-)

-- 
2.25.1

