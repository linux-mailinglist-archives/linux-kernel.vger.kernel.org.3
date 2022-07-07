Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEAD656AAA6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 20:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236635AbiGGS3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 14:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236493AbiGGS2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 14:28:24 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF615C9E4;
        Thu,  7 Jul 2022 11:27:52 -0700 (PDT)
Date:   Thu, 07 Jul 2022 18:27:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1657218470;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+Y33QAhKMbA+5sspJ9aPd9aS/ZB1RYXTZ1BtcwTqOKk=;
        b=0/bUvXVRE8KIp6y1eEzgUnfw2EFVV3lNr4wgNAtq5PQQHFLTMXCRsJd00PHnZNUNfL8rQL
        0lo0UVHieQ0B6OtgoVu753ShoY4OotaoZa4Vz2eVyGmcXiqWlFWi2EXbUArr79RMQgnKUQ
        l2be/g+0W+bA54aRHn3LF2RrLXcCDS9v2B0NvWyYiZhbw6sxnG9LqRXe+Pi9EylamrfV2z
        YZ8zoInuChO9sBO+qfX9GVeeUDn+mnWucQW/snD6tpkOQTuH/3vBS1YEDvoVF2egg9XiQ/
        uuG0bQOvRpi2v8Em01R13zABEMFTt9eZWbr3FzBkvMstCUAbnKwTHwTCiIAZwg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1657218470;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+Y33QAhKMbA+5sspJ9aPd9aS/ZB1RYXTZ1BtcwTqOKk=;
        b=Watmujoa3j2SDC+szd/JdOGW750Q1OQCuzWpz198WmAqnPw+jBDm3E3yug55+HX8y7jqpg
        p2x7eadMCz6FnVAQ==
From:   "tip-bot2 for Reinette Chatre" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] x86/sgx: Make sgx_ipi_cb() available internally
Cc:     Reinette Chatre <reinette.chatre@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C1179ed4a9c3c1c2abf49d51bfcf2c30b493181cc=2E16521?=
 =?utf-8?q?37848=2Egit=2Ereinette=2Echatre=40intel=2Ecom=3E?=
References: =?utf-8?q?=3C1179ed4a9c3c1c2abf49d51bfcf2c30b493181cc=2E165213?=
 =?utf-8?q?7848=2Egit=2Ereinette=2Echatre=40intel=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <165721846964.15455.11648914792270697532.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/sgx branch of tip:

Commit-ID:     c7c6a8a61b0066ba7e891783032dc2a7873c6dc7
Gitweb:        https://git.kernel.org/tip/c7c6a8a61b0066ba7e891783032dc2a7873c6dc7
Author:        Reinette Chatre <reinette.chatre@intel.com>
AuthorDate:    Tue, 10 May 2022 11:08:45 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 07 Jul 2022 10:13:02 -07:00

x86/sgx: Make sgx_ipi_cb() available internally

The ETRACK function followed by an IPI to all CPUs within an enclave
is a common pattern with more frequent use in support of SGX2.

Make the (empty) IPI callback function available internally in
preparation for usage by SGX2.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Link: https://lkml.kernel.org/r/1179ed4a9c3c1c2abf49d51bfcf2c30b493181cc.1652137848.git.reinette.chatre@intel.com
---
 arch/x86/kernel/cpu/sgx/main.c | 2 +-
 arch/x86/kernel/cpu/sgx/sgx.h  | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index 9df2221..180ad84 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -174,7 +174,7 @@ static int __sgx_encl_ewb(struct sgx_epc_page *epc_page, void *va_slot,
 	return ret;
 }
 
-static void sgx_ipi_cb(void *info)
+void sgx_ipi_cb(void *info)
 {
 }
 
diff --git a/arch/x86/kernel/cpu/sgx/sgx.h b/arch/x86/kernel/cpu/sgx/sgx.h
index 0f17def..b30cee4 100644
--- a/arch/x86/kernel/cpu/sgx/sgx.h
+++ b/arch/x86/kernel/cpu/sgx/sgx.h
@@ -90,6 +90,8 @@ void sgx_mark_page_reclaimable(struct sgx_epc_page *page);
 int sgx_unmark_page_reclaimable(struct sgx_epc_page *page);
 struct sgx_epc_page *sgx_alloc_epc_page(void *owner, bool reclaim);
 
+void sgx_ipi_cb(void *info);
+
 #ifdef CONFIG_X86_SGX_KVM
 int __init sgx_vepc_init(void);
 #else
