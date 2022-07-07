Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAE6856AAA0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 20:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236700AbiGGS36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 14:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236576AbiGGS2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 14:28:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD94660511;
        Thu,  7 Jul 2022 11:27:58 -0700 (PDT)
Date:   Thu, 07 Jul 2022 18:27:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1657218477;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jwtPlhM35LM7nDSyFOg66QMla3oka7aRpyi0MGAzZdQ=;
        b=DoYxZPjSLGCCPeCgQCjEvYPhuYHtELnJzj5WmBTVuY2o1astSG5hqNXTan/R+XgI4GOFfV
        lhc0VpHjnTg4n9KwRIwRu0kIOsYNkUZDjjoKyiBhpwg0OCpzmMJiJfKTbdy7QauO8X0a0C
        7CTXnW6wOMxvBpsT9LZWNwEy+s14G7hRZ+0er5SkZfs52ApFN5tmZ3ceD4BGErpiDrrLnv
        2BthYetsJnwjqbKUBqGPK+TXGXSAW0SqZ8d4Zj/7xIcD2N8N8cKp8f2R4Rj3wafSmJlNx3
        NLDOXEGd+k+NbELB/0k1XJQengcpEEjSRW5SPsZZ7G/D39G8RsCb/8sFWI+uNA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1657218477;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jwtPlhM35LM7nDSyFOg66QMla3oka7aRpyi0MGAzZdQ=;
        b=b2zZMwKj5R4eo25J9r7aJnODMftiEfQkAhlENlQlg172DsB9liEWOko2mBCViTVghNJ2z6
        WAfPB7/WmRdTy0Aw==
From:   "tip-bot2 for Reinette Chatre" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] x86/sgx: Add wrapper for SGX2 EMODPR function
Cc:     Reinette Chatre <reinette.chatre@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Cd15e7a769e13e4ca671fa2d0a0d3e3aec5aedbd4=2E16521?=
 =?utf-8?q?37848=2Egit=2Ereinette=2Echatre=40intel=2Ecom=3E?=
References: =?utf-8?q?=3Cd15e7a769e13e4ca671fa2d0a0d3e3aec5aedbd4=2E165213?=
 =?utf-8?q?7848=2Egit=2Ereinette=2Echatre=40intel=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <165721847620.15455.9683978736205178450.tip-bot2@tip-bot2>
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

Commit-ID:     0fb2126db8414e0206960febb3e4a116439c69dd
Gitweb:        https://git.kernel.org/tip/0fb2126db8414e0206960febb3e4a116439c69dd
Author:        Reinette Chatre <reinette.chatre@intel.com>
AuthorDate:    Tue, 10 May 2022 11:08:38 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 07 Jul 2022 10:13:01 -07:00

x86/sgx: Add wrapper for SGX2 EMODPR function

Add a wrapper for the EMODPR ENCLS leaf function used to
restrict enclave page permissions as maintained in the
SGX hardware's Enclave Page Cache Map (EPCM).

EMODPR:
1) Updates the EPCM permissions of an enclave page by treating
   the new permissions as a mask. Supplying a value that attempts
   to relax EPCM permissions has no effect on EPCM permissions
   (PR bit, see below, is changed).
2) Sets the PR bit in the EPCM entry of the enclave page to
   indicate that permission restriction is in progress. The bit
   is reset by the enclave by invoking ENCLU leaf function
   EACCEPT or EACCEPTCOPY.

The enclave may access the page throughout the entire process
if conforming to the EPCM permissions for the enclave page.

After performing the permission restriction by issuing EMODPR
the kernel needs to collaborate with the hardware to ensure that
all logical processors sees the new restricted permissions. This
is required for the enclave's EACCEPT/EACCEPTCOPY to succeed and
is accomplished with the ETRACK flow.

Expand enum sgx_return_code with the possible EMODPR return
values.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Link: https://lkml.kernel.org/r/d15e7a769e13e4ca671fa2d0a0d3e3aec5aedbd4.1652137848.git.reinette.chatre@intel.com
---
 arch/x86/include/asm/sgx.h      | 5 +++++
 arch/x86/kernel/cpu/sgx/encls.h | 6 ++++++
 2 files changed, 11 insertions(+)

diff --git a/arch/x86/include/asm/sgx.h b/arch/x86/include/asm/sgx.h
index 3f9334e..d67810b 100644
--- a/arch/x86/include/asm/sgx.h
+++ b/arch/x86/include/asm/sgx.h
@@ -65,17 +65,22 @@ enum sgx_encls_function {
 
 /**
  * enum sgx_return_code - The return code type for ENCLS, ENCLU and ENCLV
+ * %SGX_EPC_PAGE_CONFLICT:	Page is being written by other ENCLS function.
  * %SGX_NOT_TRACKED:		Previous ETRACK's shootdown sequence has not
  *				been completed yet.
  * %SGX_CHILD_PRESENT		SECS has child pages present in the EPC.
  * %SGX_INVALID_EINITTOKEN:	EINITTOKEN is invalid and enclave signer's
  *				public key does not match IA32_SGXLEPUBKEYHASH.
+ * %SGX_PAGE_NOT_MODIFIABLE:	The EPC page cannot be modified because it
+ *				is in the PENDING or MODIFIED state.
  * %SGX_UNMASKED_EVENT:		An unmasked event, e.g. INTR, was received
  */
 enum sgx_return_code {
+	SGX_EPC_PAGE_CONFLICT		= 7,
 	SGX_NOT_TRACKED			= 11,
 	SGX_CHILD_PRESENT		= 13,
 	SGX_INVALID_EINITTOKEN		= 16,
+	SGX_PAGE_NOT_MODIFIABLE		= 20,
 	SGX_UNMASKED_EVENT		= 128,
 };
 
diff --git a/arch/x86/kernel/cpu/sgx/encls.h b/arch/x86/kernel/cpu/sgx/encls.h
index 0e22fa8..2b09191 100644
--- a/arch/x86/kernel/cpu/sgx/encls.h
+++ b/arch/x86/kernel/cpu/sgx/encls.h
@@ -215,4 +215,10 @@ static inline int __ewb(struct sgx_pageinfo *pginfo, void *addr,
 	return __encls_ret_3(EWB, pginfo, addr, va);
 }
 
+/* Restrict the EPCM permissions of an EPC page. */
+static inline int __emodpr(struct sgx_secinfo *secinfo, void *addr)
+{
+	return __encls_ret_2(EMODPR, secinfo, addr);
+}
+
 #endif /* _X86_ENCLS_H */
