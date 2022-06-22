Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 511305540FA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 05:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356612AbiFVDo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 23:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232276AbiFVDo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 23:44:26 -0400
X-Greylist: delayed 903 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 21 Jun 2022 20:44:25 PDT
Received: from ZXSHCAS2.zhaoxin.com (ZXSHCAS2.zhaoxin.com [210.0.225.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 051E519C03;
        Tue, 21 Jun 2022 20:44:24 -0700 (PDT)
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHCAS2.zhaoxin.com
 (10.28.252.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.27; Wed, 22 Jun
 2022 11:29:10 +0800
Received: from [10.32.56.37] (10.32.56.37) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.27; Wed, 22 Jun
 2022 11:29:09 +0800
To:     <rafael@kernel.org>, <viresh.kumar@linaro.org>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <CobeChen@zhaoxin.com>, <TimGuo@zhaoxin.com>,
        <LindaChai@zhaoxin.com>, <LeoLiu@zhaoxin.com>
From:   Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
Subject: [PATCH] cpufreq: Add Zhaoxin turbo boost control interface support
Message-ID: <8b748cc6-09c9-081c-c0c5-2e75f017b032@zhaoxin.com>
Date:   Wed, 22 Jun 2022 11:29:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.32.56.37]
X-ClientProxiedBy: ZXSHCAS1.zhaoxin.com (10.28.252.161) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recent Zhaoxin CPUs support X86_FEATURE_IDA and the turbo boost can
be dynamically enabled or disabled through MSR 0x1a0[38] in the same
way as Intel. So add turbo boost control support for Zhaoxin too.

Signed-off-by: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
---
  drivers/cpufreq/acpi-cpufreq.c | 4 ++++
  1 file changed, 4 insertions(+)

diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index 3d514b8..1bb2b90 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -78,6 +78,8 @@ static bool boost_state(unsigned int cpu)

  	switch (boot_cpu_data.x86_vendor) {
  	case X86_VENDOR_INTEL:
+	case X86_VENDOR_CENTAUR:
+	case X86_VENDOR_ZHAOXIN:
  		rdmsr_on_cpu(cpu, MSR_IA32_MISC_ENABLE, &lo, &hi);
  		msr = lo | ((u64)hi << 32);
  		return !(msr & MSR_IA32_MISC_ENABLE_TURBO_DISABLE);
@@ -97,6 +99,8 @@ static int boost_set_msr(bool enable)

  	switch (boot_cpu_data.x86_vendor) {
  	case X86_VENDOR_INTEL:
+	case X86_VENDOR_CENTAUR:
+	case X86_VENDOR_ZHAOXIN:
  		msr_addr = MSR_IA32_MISC_ENABLE;
  		msr_mask = MSR_IA32_MISC_ENABLE_TURBO_DISABLE;
  		break;
-- 
2.7.4
