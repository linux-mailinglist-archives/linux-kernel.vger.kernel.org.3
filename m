Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD8644F2180
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 06:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbiDECqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 22:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbiDECqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 22:46:11 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 800FD37BA2E;
        Mon,  4 Apr 2022 18:51:53 -0700 (PDT)
Date:   Mon, 04 Apr 2022 23:57:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649116661;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5xJqt6HFPzkzv5UcTuTc/+VNPIr1xBZCX9CZQWo2oqs=;
        b=C3eTuKfK8nQ6bIy62qT8fMTq+c/WF2XqFJi7HALMoqVgysAVI+oitv53xXdEyT3jFICxtE
        4n5/H8KPcjyAsh3S5n23ldsMB0Dj1FggTfo+GjivNzPumVbqGLrjSknvZTdIGHkfv93lEH
        kvDzJIzMJnN8EFqhbOQ9hgCcq3CKiaWsDViEzr/AwFe33HwgtKapIqHyS/RiJNFzQObd+E
        J0la+G8mQFBRkxPu1Xr42bTAHNFtY8vsfGMnKg+oxMVrNkBCmbH8fS6eDZ3ORuNey5izyK
        3bP7aPMO+Yv0jncgxfCFID9HOQbzKacIrwjQsNo/Gq6LQN9MbLf/D/DFFiDSJg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649116661;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5xJqt6HFPzkzv5UcTuTc/+VNPIr1xBZCX9CZQWo2oqs=;
        b=Z2pE5QAnGXnT2YEUQacnOmwxE/CxDTzTebK1CgF+Hwbcse7ol/tlYYCqNlWaGGjwT1AGVr
        T7TEVLEMQ43vQbCA==
From:   "tip-bot2 for Ira Weiny" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/pkeys: Clean up arch_set_user_pkey_access()
 declaration
Cc:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220331180554.2945884-1-ira.weiny@intel.com>
References: <20220331180554.2945884-1-ira.weiny@intel.com>
MIME-Version: 1.0
Message-ID: <164911666067.389.6810895631188554028.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     70431c63d7ed31baf18b0083ba5473274363a174
Gitweb:        https://git.kernel.org/tip/70431c63d7ed31baf18b0083ba5473274363a174
Author:        Ira Weiny <ira.weiny@intel.com>
AuthorDate:    Thu, 31 Mar 2022 11:05:54 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Mon, 04 Apr 2022 15:58:24 -07:00

x86/pkeys: Clean up arch_set_user_pkey_access() declaration

arch_set_user_pkey_access() was declared two times in the header.

Remove the 2nd declaration.

Suggested-by: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lkml.kernel.org/r/20220331180554.2945884-1-ira.weiny@intel.com
---
 arch/x86/include/asm/pkeys.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/include/asm/pkeys.h b/arch/x86/include/asm/pkeys.h
index 1d5f14a..9c53053 100644
--- a/arch/x86/include/asm/pkeys.h
+++ b/arch/x86/include/asm/pkeys.h
@@ -118,8 +118,6 @@ int mm_pkey_free(struct mm_struct *mm, int pkey)
 	return 0;
 }
 
-extern int arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
-		unsigned long init_val);
 extern int __arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
 		unsigned long init_val);
 
