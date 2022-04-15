Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 292E0502786
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 11:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351823AbiDOJox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 05:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233838AbiDOJov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 05:44:51 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A019BAC056;
        Fri, 15 Apr 2022 02:42:22 -0700 (PDT)
Date:   Fri, 15 Apr 2022 09:42:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650015741;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TzfZgH2CpYL1WXpv7y3pqSWAMrDt8KsmWhxyBSsv7e4=;
        b=4fZMWsd7dScKZvzIA0nuWdtRbT8Rm4HssOnMjP83EH5ikwxFoX1+/HUex/U2mgp3aOp09b
        NzA2StEX4rDrsCSQjDb1W43+rLkf+Go3OwYQ2y3i65vjoe6/SSBeBAZ66LLoS85ASmi3Vf
        gMp9i2SyI3rxJRuu5NCmWQ17kbHSRJXit46BO5mKCrWMwsSqWlpVC1dEzhSI3fZSG+pdGg
        3ObYL/Sl8IAM+oVwRoVHRqd2FXp1jtxr6OyBOQDAPvGiIP4iQNiVYAy8iKY8P3LkkJTqzo
        qIry9OcuFZfMijENYK9KZZJPoCO4d1MwjAjDM4S/yAE7Dkmv2l/6AkvrbM2kbw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650015741;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TzfZgH2CpYL1WXpv7y3pqSWAMrDt8KsmWhxyBSsv7e4=;
        b=Oh9Fatgm2Hn4SMAKGmFveiqA78ZEZ5ZU8AFCdHu+YZajhHjw/I/+uYvc/4JA3gu5JRlrhN
        eBWQqvMkiN+fybAw==
From:   "tip-bot2 for Brian Gerst" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/asm: Merge load_gs_index()
Cc:     Brian Gerst <brgerst@gmail.com>, Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220325153953.162643-5-brgerst@gmail.com>
References: <20220325153953.162643-5-brgerst@gmail.com>
MIME-Version: 1.0
Message-ID: <165001573943.4207.9341858824402363883.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     203d8919a9eda5d1bc68ac3cd7637588334c9dc1
Gitweb:        https://git.kernel.org/tip/203d8919a9eda5d1bc68ac3cd7637588334c9dc1
Author:        Brian Gerst <brgerst@gmail.com>
AuthorDate:    Fri, 25 Mar 2022 11:39:53 -04:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 14 Apr 2022 14:15:54 +02:00

x86/asm: Merge load_gs_index()

Merge the 32- and 64-bit implementations of load_gs_index().

Signed-off-by: Brian Gerst <brgerst@gmail.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Andy Lutomirski <luto@kernel.org>
Link: https://lore.kernel.org/r/20220325153953.162643-5-brgerst@gmail.com
---
 arch/x86/include/asm/segment.h       | 7 -------
 arch/x86/include/asm/special_insns.h | 7 ++++---
 2 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/segment.h b/arch/x86/include/asm/segment.h
index 617b366..2e7890d 100644
--- a/arch/x86/include/asm/segment.h
+++ b/arch/x86/include/asm/segment.h
@@ -350,13 +350,6 @@ static inline void __loadsegment_fs(unsigned short value)
 #define savesegment(seg, value)				\
 	asm("mov %%" #seg ",%0":"=r" (value) : : "memory")
 
-/*
- * x86-32 user GS accessors.  This is ugly and could do with some cleaning up.
- */
-#ifdef CONFIG_X86_32
-# define load_gs_index(v)		loadsegment(gs, (v))
-#endif	/* X86_32 */
-
 #endif /* !__ASSEMBLY__ */
 #endif /* __KERNEL__ */
 
diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index 68c257a..45b18eb 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -184,14 +184,15 @@ static inline void wbinvd(void)
 	native_wbinvd();
 }
 
-#ifdef CONFIG_X86_64
 
 static inline void load_gs_index(unsigned int selector)
 {
+#ifdef CONFIG_X86_64
 	native_load_gs_index(selector);
-}
-
+#else
+	loadsegment(gs, selector);
 #endif
+}
 
 #endif /* CONFIG_PARAVIRT_XXL */
 
