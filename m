Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B98B856AA9C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 20:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236681AbiGGS3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 14:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236516AbiGGS22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 14:28:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC16760502;
        Thu,  7 Jul 2022 11:27:56 -0700 (PDT)
Date:   Thu, 07 Jul 2022 18:27:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1657218475;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Oi1Hg98n2ZVxk6VNddLlKw4sOPD4VKafLeFcF39/poo=;
        b=LKMgm7wPWqX0GbjqlOkEfeexLNXJohJbQFOR7IvqCVCwoU40fIRH5bg7WUokwOmhw/Vyx9
        mQQPbRt4t3Yr2GhF02m6TnzCzBVt69zbbg6KCMWqx5QGPk4Xo5klulb5x+rxrWkPU0kz/R
        BDNn8S03lNm65HJkAyD/d4cOxGFOhAtb71Jy0i/jekNxiOD7MZfesBzo6uTk2xEhjrYY5+
        JYULiA5UEmD3MjJqhMjckr20EDih6T/hOIg1jNjWWGTNao95XpFvcp/oKg/vPsPYnJncOq
        jXDbvH5Qh4z9XBMpmZjvEIQz7YoEr9gg0X1wMSMih/Q+TvhiAzXxKyYxaVLCJQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1657218475;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Oi1Hg98n2ZVxk6VNddLlKw4sOPD4VKafLeFcF39/poo=;
        b=KKwk9yT+iJi1rznxYOVbKK43k2yi0MidbEHJY09+CFQnWgrXV9dCxsf4+z6mCOhFYbJdR7
        1Mj788tYcaIg8ZCA==
From:   "tip-bot2 for Reinette Chatre" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] x86/sgx: Add wrapper for SGX2 EAUG function
Cc:     Reinette Chatre <reinette.chatre@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C97a46754fe4764e908651df63694fb760f783d6e=2E16521?=
 =?utf-8?q?37848=2Egit=2Ereinette=2Echatre=40intel=2Ecom=3E?=
References: =?utf-8?q?=3C97a46754fe4764e908651df63694fb760f783d6e=2E165213?=
 =?utf-8?q?7848=2Egit=2Ereinette=2Echatre=40intel=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <165721847437.15455.4958993264391652710.tip-bot2@tip-bot2>
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

Commit-ID:     61416b294af02e4747554c0d1b28d436a4a537d2
Gitweb:        https://git.kernel.org/tip/61416b294af02e4747554c0d1b28d436a4a537d2
Author:        Reinette Chatre <reinette.chatre@intel.com>
AuthorDate:    Tue, 10 May 2022 11:08:40 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 07 Jul 2022 10:13:01 -07:00

x86/sgx: Add wrapper for SGX2 EAUG function

Add a wrapper for the EAUG ENCLS leaf function used to
add a page to an initialized enclave.

EAUG:
1) Stores all properties of the new enclave page in the SGX
   hardware's Enclave Page Cache Map (EPCM).
2) Sets the PENDING bit in the EPCM entry of the enclave page.
   This bit is cleared by the enclave by invoking ENCLU leaf
   function EACCEPT or EACCEPTCOPY.

Access from within the enclave to the new enclave page is not
possible until the PENDING bit is cleared.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Link: https://lkml.kernel.org/r/97a46754fe4764e908651df63694fb760f783d6e.1652137848.git.reinette.chatre@intel.com
---
 arch/x86/kernel/cpu/sgx/encls.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/kernel/cpu/sgx/encls.h b/arch/x86/kernel/cpu/sgx/encls.h
index 7a1ecf7..99004b0 100644
--- a/arch/x86/kernel/cpu/sgx/encls.h
+++ b/arch/x86/kernel/cpu/sgx/encls.h
@@ -227,4 +227,10 @@ static inline int __emodt(struct sgx_secinfo *secinfo, void *addr)
 	return __encls_ret_2(EMODT, secinfo, addr);
 }
 
+/* Zero a page of EPC memory and add it to an initialized enclave. */
+static inline int __eaug(struct sgx_pageinfo *pginfo, void *addr)
+{
+	return __encls_2(EAUG, pginfo, addr);
+}
+
 #endif /* _X86_ENCLS_H */
