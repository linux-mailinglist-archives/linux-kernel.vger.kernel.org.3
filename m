Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5574511754
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 14:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233303AbiD0L7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 07:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233310AbiD0L7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 07:59:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B6143121D;
        Wed, 27 Apr 2022 04:56:26 -0700 (PDT)
Date:   Wed, 27 Apr 2022 11:56:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651060585;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IddAXshVgMNCP9JFdlFoYWmAbyPtf8OxhZZPaT9sJqY=;
        b=VWlcUPX7w/PFnRIgMOUt5f0eN/V4zjIULMcIWwxSKzqf3YmevyMGxvO0s7F8c3Fltvslqc
        DHmB3nXOoeE/Xgq+o+x4zYH7hm2q4Mfr6XoCs936JNv77GV7v6vJD+AAU6aXlo5C9faoOv
        zmdeVUAR1UbztJDC0dux66hTdKYm2yryKEnJ8l8vEsVRVZE5AQdc7RixW+3OhZoAzdg63Z
        subp0XWECrAgT9G2X2qybcHMg8VYurHEPfPnczz8O6zlz+8exWu+gZQfW5xF0kOMdMfuXm
        OtF0xjKIGqnQBPUtnxOwCToH8X2fNqD8WKrp/081fJKmrxGRG7q6iD5D8XnVuw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651060585;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IddAXshVgMNCP9JFdlFoYWmAbyPtf8OxhZZPaT9sJqY=;
        b=K9vZEZD98KBotYE3nv3RM5LMNwOf1T4DVAwe0hi6yOECxtPwlPuosnJyISA4yJz+FaxHLf
        FlogdWxYCB1OU4AA==
From:   "tip-bot2 for Michael Roth" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/sev: Add missing __init annotations to SEV init routines
Cc:     Borislav Petkov <bp@suse.de>, Michael Roth <michael.roth@amd.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220422135624.114172-2-michael.roth@amd.com>
References: <20220422135624.114172-2-michael.roth@amd.com>
MIME-Version: 1.0
Message-ID: <165106058382.4207.3592489487323661828.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     75d359ec4141b013727022a663762931f69e6510
Gitweb:        https://git.kernel.org/tip/75d359ec4141b013727022a663762931f69e6510
Author:        Michael Roth <michael.roth@amd.com>
AuthorDate:    Fri, 22 Apr 2022 08:56:23 -05:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 27 Apr 2022 13:31:36 +02:00

x86/sev: Add missing __init annotations to SEV init routines

Currently, get_secrets_page() is only reachable from the following call
chain:

  __init snp_init_platform_device():
    get_secrets_page()

so mark it as __init as well. This is also needed since it calls
early_memremap(), which is also an __init routine.

Similarly, get_jump_table_addr() is only reachable from the following
call chain:

  __init setup_real_mode():
    sme_sev_setup_real_mode():
      sev_es_setup_ap_jump_table():
        get_jump_table_addr()

so mark get_jump_table_addr() and everything up that call chain as
__init as well. This is also needed since future patches will add a
call to get_secrets_page(), which needs to be __init due to the reasons
stated above.

Suggested-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20220422135624.114172-2-michael.roth@amd.com
---
 arch/x86/kernel/sev.c    | 6 +++---
 arch/x86/realmode/init.c | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 2fa87a0..b7fd191 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -558,7 +558,7 @@ void noinstr __sev_es_nmi_complete(void)
 	__sev_put_ghcb(&state);
 }
 
-static u64 get_jump_table_addr(void)
+static u64 __init get_jump_table_addr(void)
 {
 	struct ghcb_state state;
 	unsigned long flags;
@@ -1077,7 +1077,7 @@ void snp_set_wakeup_secondary_cpu(void)
 	apic->wakeup_secondary_cpu = wakeup_cpu_via_vmgexit;
 }
 
-int sev_es_setup_ap_jump_table(struct real_mode_header *rmh)
+int __init sev_es_setup_ap_jump_table(struct real_mode_header *rmh)
 {
 	u16 startup_cs, startup_ip;
 	phys_addr_t jump_table_pa;
@@ -2171,7 +2171,7 @@ static struct platform_device sev_guest_device = {
 	.id		= -1,
 };
 
-static u64 get_secrets_page(void)
+static u64 __init get_secrets_page(void)
 {
 	u64 pa_data = boot_params.cc_blob_address;
 	struct cc_blob_sev_info info;
diff --git a/arch/x86/realmode/init.c b/arch/x86/realmode/init.c
index c5e29db..41d7669 100644
--- a/arch/x86/realmode/init.c
+++ b/arch/x86/realmode/init.c
@@ -67,7 +67,7 @@ void __init reserve_real_mode(void)
 	memblock_reserve(0, SZ_1M);
 }
 
-static void sme_sev_setup_real_mode(struct trampoline_header *th)
+static void __init sme_sev_setup_real_mode(struct trampoline_header *th)
 {
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 	if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT))
