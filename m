Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 001695540FC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 05:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232276AbiFVDoq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 23:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356635AbiFVDoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 23:44:38 -0400
Received: from ZXSHCAS1.zhaoxin.com (ZXSHCAS1.zhaoxin.com [210.0.225.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA01F31239
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 20:44:36 -0700 (PDT)
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHCAS1.zhaoxin.com
 (10.28.252.161) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.27; Wed, 22 Jun
 2022 11:29:32 +0800
Received: from [10.32.56.37] (10.32.56.37) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.27; Wed, 22 Jun
 2022 11:29:30 +0800
To:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <linux-kernel@vger.kernel.org>, <TonyWWang-oc@zhaoxin.com>
From:   Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
Subject: [PATCH] ACPI: processor: Add Zhaoxin ACPI _PDC evaluate support
CC:     <CobeChen@zhaoxin.com>, <TimGuo@zhaoxin.com>,
        <LindaChai@zhaoxin.com>, <LeoLiu@zhaoxin.com>
Message-ID: <899dbac4-0fd5-fff9-912d-f801921c6f6a@zhaoxin.com>
Date:   Wed, 22 Jun 2022 11:29:29 +0800
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

Recent Zhaoxin platforms support ACPI _PDC object, so add Zhaoxin
CPU vendor support in the function arch_has_acpi_pdc().

Signed-off-by: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
---
  arch/x86/include/asm/acpi.h | 3 ++-
  1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/acpi.h b/arch/x86/include/asm/acpi.h
index 65064d9..b719745 100644
--- a/arch/x86/include/asm/acpi.h
+++ b/arch/x86/include/asm/acpi.h
@@ -89,7 +89,8 @@ static inline bool arch_has_acpi_pdc(void)
  {
  	struct cpuinfo_x86 *c = &cpu_data(0);
  	return (c->x86_vendor == X86_VENDOR_INTEL ||
-		c->x86_vendor == X86_VENDOR_CENTAUR);
+		c->x86_vendor == X86_VENDOR_CENTAUR ||
+		c->x86_vendor == X86_VENDOR_ZHAOXIN);
  }

  static inline void arch_acpi_set_pdc_bits(u32 *buf)
-- 
2.7.4
