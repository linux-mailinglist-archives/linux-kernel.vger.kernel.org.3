Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEA8856AAAC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 20:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236309AbiGGS3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 14:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236323AbiGGS2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 14:28:43 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFCE860506;
        Thu,  7 Jul 2022 11:27:57 -0700 (PDT)
Date:   Thu, 07 Jul 2022 18:27:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1657218476;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vi1GN9osGpN/3n9/qUIli+GO5N/T/5v+3TUUHMnWvU4=;
        b=lZxDwhov3xKCTPv8NT3Jry3C8YHsnUkgFeOYBB7K80nj5UnacHjz1o/gk0aZjFadyXKdPB
        DSdPI8j53VmOCLpSCwR1Ozj4jZRmZZMO4MMmvukDOWRstQPFyAwOfoDSi+rVC14PjBqvRx
        w0J/189q4aD+j0RwLdteFgmPWTbr3tDeUP86yg685hsjfMQJMaHRbLmfADONbVzabEsUtE
        Z6g8s0Itus3TDEtcfoYFYJLxrt3ZqHaWeM6Qr2dWLXrH9dwnYI5zRhp3Zbc2KN5CRDcfwR
        YE66aJThHv1EJ8uQjNc6HUBjzxWbJ7J8Xw/Poj5XK2ohLpZBQeqZWiSGuIYulw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1657218476;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vi1GN9osGpN/3n9/qUIli+GO5N/T/5v+3TUUHMnWvU4=;
        b=iY3G8KAmNoujT+/hRq8HZZ3oGCas4E3dmWfdnC+95SFO61TFTefK4b4jG1YglPa2D0c35M
        Zr5r7+HkQddBPEBQ==
From:   "tip-bot2 for Reinette Chatre" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] x86/sgx: Add wrapper for SGX2 EMODT function
Cc:     Reinette Chatre <reinette.chatre@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Cdba63a8c0db1d510b940beee1ba2a8207efeb1f1=2E16521?=
 =?utf-8?q?37848=2Egit=2Ereinette=2Echatre=40intel=2Ecom=3E?=
References: =?utf-8?q?=3Cdba63a8c0db1d510b940beee1ba2a8207efeb1f1=2E165213?=
 =?utf-8?q?7848=2Egit=2Ereinette=2Echatre=40intel=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <165721847528.15455.14399026156187962464.tip-bot2@tip-bot2>
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

Commit-ID:     09b38d0b412dbf8922b3dc33103c1a1257519ab9
Gitweb:        https://git.kernel.org/tip/09b38d0b412dbf8922b3dc33103c1a1257519ab9
Author:        Reinette Chatre <reinette.chatre@intel.com>
AuthorDate:    Tue, 10 May 2022 11:08:39 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 07 Jul 2022 10:13:01 -07:00

x86/sgx: Add wrapper for SGX2 EMODT function

Add a wrapper for the EMODT ENCLS leaf function used to
change the type of an enclave page as maintained in the
SGX hardware's Enclave Page Cache Map (EPCM).

EMODT:
1) Updates the EPCM page type of the enclave page.
2) Sets the MODIFIED bit in the EPCM entry of the enclave page.
   This bit is reset by the enclave by invoking ENCLU leaf
   function EACCEPT or EACCEPTCOPY.

Access from within the enclave to the enclave page is not possible
while the MODIFIED bit is set.

After changing the enclave page type by issuing EMODT the kernel
needs to collaborate with the hardware to ensure that no logical
processor continues to hold a reference to the changed page. This
is required to ensure no required security checks are circumvented
and is required for the enclave's EACCEPT/EACCEPTCOPY to succeed.
Ensuring that no references to the changed page remain is
accomplished with the ETRACK flow.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Link: https://lkml.kernel.org/r/dba63a8c0db1d510b940beee1ba2a8207efeb1f1.1652137848.git.reinette.chatre@intel.com
---
 arch/x86/kernel/cpu/sgx/encls.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/kernel/cpu/sgx/encls.h b/arch/x86/kernel/cpu/sgx/encls.h
index 2b09191..7a1ecf7 100644
--- a/arch/x86/kernel/cpu/sgx/encls.h
+++ b/arch/x86/kernel/cpu/sgx/encls.h
@@ -221,4 +221,10 @@ static inline int __emodpr(struct sgx_secinfo *secinfo, void *addr)
 	return __encls_ret_2(EMODPR, secinfo, addr);
 }
 
+/* Change the type of an EPC page. */
+static inline int __emodt(struct sgx_secinfo *secinfo, void *addr)
+{
+	return __encls_ret_2(EMODT, secinfo, addr);
+}
+
 #endif /* _X86_ENCLS_H */
