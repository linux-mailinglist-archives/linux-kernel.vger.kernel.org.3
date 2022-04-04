Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B83F44F1E57
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 00:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381051AbiDDWHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 18:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379675AbiDDRss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 13:48:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 068242E9CD;
        Mon,  4 Apr 2022 10:46:51 -0700 (PDT)
Date:   Mon, 04 Apr 2022 17:46:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649094410;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wJBenbDWedPtd9MAznsgJpCiB+SUlSLxMzf0WLmp1dA=;
        b=p2KehHnmGlk02itz5eVOD5ncMFXrOshvbTPOt7fFyaHsOCTbRUP9Q7y0BnYDDwfPP/1/u3
        r2sBcIibkfmwt0AGijg3fC2GBjBTtqiKkVCpCOwMEiuk8X0Daur5VJ9SkPJJ7IdjtyIvRC
        rsit98WjzgEe8OdCUq7MiNKivFJHQSfkwiKiEECp7GQtU6QB4wqJ+Wt5weN7I5znsC26HZ
        bFFUUU7jvgZZqWBrq1/CB9PtzerVmcagg0CLDxQs6ZTBXqIJ8VADHyf98J+xvIojH7pWkl
        dCGZ/Le+X1dj7KMQyb3KFv71pLqBvyVbn6UvwfRMuUKRsdkE4z2fUy6NOzDJLg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649094410;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wJBenbDWedPtd9MAznsgJpCiB+SUlSLxMzf0WLmp1dA=;
        b=xIpwR38qxOUcyaXrcgvEGlsWwg2wMDVl7ZEl07Z+M0wyVM1xkICyN+vmwpcZ4MiRpyrAL2
        CNu4015it3f96pCg==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] x86/kvm/svm: Force-inline GHCB accessors
Cc:     Borislav Petkov <bp@suse.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220324183607.31717-3-bp@alien8.de>
References: <20220324183607.31717-3-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <164909440907.389.708776734897898729.tip-bot2@tip-bot2>
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

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     6b91ec4ad290a808a894e7d3448eb82d0b8ef8d5
Gitweb:        https://git.kernel.org/tip/6b91ec4ad290a808a894e7d3448eb82d0b8ef8d5
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Wed, 23 Mar 2022 21:52:44 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 04 Apr 2022 10:13:20 +02:00

x86/kvm/svm: Force-inline GHCB accessors

In order to fix:

  vmlinux.o: warning: objtool: __sev_es_nmi_complete()+0x4c: call to ghcb_set_sw_exit_code() leaves .noinstr.text section

Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220324183607.31717-3-bp@alien8.de
---
 arch/x86/include/asm/svm.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
index f70a510..e255039 100644
--- a/arch/x86/include/asm/svm.h
+++ b/arch/x86/include/asm/svm.h
@@ -444,23 +444,23 @@ struct vmcb {
 	(offsetof(struct vmcb_save_area, field) / sizeof(u64))
 
 #define DEFINE_GHCB_ACCESSORS(field)						\
-	static inline bool ghcb_##field##_is_valid(const struct ghcb *ghcb)	\
+	static __always_inline bool ghcb_##field##_is_valid(const struct ghcb *ghcb) \
 	{									\
 		return test_bit(GHCB_BITMAP_IDX(field),				\
 				(unsigned long *)&ghcb->save.valid_bitmap);	\
 	}									\
 										\
-	static inline u64 ghcb_get_##field(struct ghcb *ghcb)			\
+	static __always_inline u64 ghcb_get_##field(struct ghcb *ghcb)		\
 	{									\
 		return ghcb->save.field;					\
 	}									\
 										\
-	static inline u64 ghcb_get_##field##_if_valid(struct ghcb *ghcb)	\
+	static __always_inline u64 ghcb_get_##field##_if_valid(struct ghcb *ghcb) \
 	{									\
 		return ghcb_##field##_is_valid(ghcb) ? ghcb->save.field : 0;	\
 	}									\
 										\
-	static inline void ghcb_set_##field(struct ghcb *ghcb, u64 value)	\
+	static __always_inline void ghcb_set_##field(struct ghcb *ghcb, u64 value) \
 	{									\
 		__set_bit(GHCB_BITMAP_IDX(field),				\
 			  (unsigned long *)&ghcb->save.valid_bitmap);		\
