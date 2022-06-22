Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96F735540FE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 05:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356637AbiFVDo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 23:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356633AbiFVDou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 23:44:50 -0400
Received: from ZXSHCAS2.zhaoxin.com (ZXSHCAS2.zhaoxin.com [210.0.225.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A0E3055C;
        Tue, 21 Jun 2022 20:44:48 -0700 (PDT)
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHCAS2.zhaoxin.com
 (10.28.252.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.27; Wed, 22 Jun
 2022 11:29:44 +0800
Received: from [10.32.56.37] (10.32.56.37) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.27; Wed, 22 Jun
 2022 11:29:42 +0800
To:     <rafael@kernel.org>, <len.brown@intel.com>, <pavel@ucw.cz>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <CobeChen@zhaoxin.com>, <TimGuo@zhaoxin.com>,
        <LindaChai@zhaoxin.com>, <LeoLiu@zhaoxin.com>
From:   Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
Subject: [PATCH] x86/cstate: Add Zhaoxin ACPI Cx FFH MWAIT support
Message-ID: <bccae278-e735-4681-cb3a-41359e42032b@zhaoxin.com>
Date:   Wed, 22 Jun 2022 11:29:41 +0800
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

Recent Zhaoxin CPUs support X86_FEATURE_MWAIT that implies the
MONITOR/MWAIT instructions can be used for ACPI Cx state. The BIOS
declares Cx state in _CST object to use FFH on Zhaoxin systems. So
let function ffh_cstate_init() support Zhaoxin too.

Signed-off-by: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
---
  arch/x86/kernel/acpi/cstate.c | 4 +++-
  1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/acpi/cstate.c b/arch/x86/kernel/acpi/cstate.c
index 7945eae..d4185e1 100644
--- a/arch/x86/kernel/acpi/cstate.c
+++ b/arch/x86/kernel/acpi/cstate.c
@@ -213,7 +213,9 @@ static int __init ffh_cstate_init(void)

  	if (c->x86_vendor != X86_VENDOR_INTEL &&
  	    c->x86_vendor != X86_VENDOR_AMD &&
-	    c->x86_vendor != X86_VENDOR_HYGON)
+	    c->x86_vendor != X86_VENDOR_HYGON &&
+	    c->x86_vendor != X86_VENDOR_CENTAUR &&
+	    c->x86_vendor != X86_VENDOR_ZHAOXIN)
  		return -1;

  	cpu_cstate_entry = alloc_percpu(struct cstate_entry);
-- 
2.7.4
