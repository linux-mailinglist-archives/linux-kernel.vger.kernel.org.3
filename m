Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53580507AC5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 22:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357630AbiDSUME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 16:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356787AbiDSUL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 16:11:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C0C23B54F;
        Tue, 19 Apr 2022 13:08:40 -0700 (PDT)
Date:   Tue, 19 Apr 2022 20:08:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650398919;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=grdZ2Oj3dJxAOhhOQTQGSWoAAOMuLN+PO2IJmd9VYYM=;
        b=v27tyKEUBnENDrLRPaDLsD54L7GX3SmOk9GFPA5WudXbZWulZqo/8XyJvBdMplD9x3HoTm
        1CQ0i2kD5ZWWA2z79jhvsESbSaUqgEEeWRN0UBdsEzM+u6wPpJQ5SDHBV/wLV6shK2U0yO
        +KEmV6NsffXhEwmd2RS3yxtEG6UuNc2/G1g3DvYGvKUGIoE8ryMtkuyWW1Hukw3Xj5GWIP
        xCXGncsQii9D04N/m3sxHnlr8psf6tI0FjLvSeYeM+NoAaMc3NXTtoeaeKrJ8hYNEBmpC8
        9xKhLQ+Ok0TzaGdbmxSc8o/TzoAmFY0JENibJs0bJ20kblMHHK2oxDvPjNsdaA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650398919;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=grdZ2Oj3dJxAOhhOQTQGSWoAAOMuLN+PO2IJmd9VYYM=;
        b=p8cG9SdylvLJ+/5xZV6v/RzSIaErT090VmEn6rv9iAXbmdQTqtWrYl/kggl05n6y92xlnh
        UXG9TpYkC2OFGADQ==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/uaccess: Add ENDBR to __put_user_nocheck*()
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <207f02177a23031091d1a608de6049a9e5e8ff80.1650300597.git.jpoimboe@redhat.com>
References: <207f02177a23031091d1a608de6049a9e5e8ff80.1650300597.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Message-ID: <165039891783.4207.3884581753436962797.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     7a00829f8ac3f76b3a3aa5c28ce4ddfd2f977bbe
Gitweb:        https://git.kernel.org/tip/7a00829f8ac3f76b3a3aa5c28ce4ddfd2f977bbe
Author:        Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate:    Mon, 18 Apr 2022 09:50:24 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 19 Apr 2022 21:58:49 +02:00

x86/uaccess: Add ENDBR to __put_user_nocheck*()

The __put_user_nocheck*() inner labels are exported, so in keeping with
the "allow exported functions to be indirectly called" policy, add
ENDBR.

Fixes: ed53a0d97192 ("x86/alternative: Use .ibt_endbr_seal to seal indirect calls")
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/207f02177a23031091d1a608de6049a9e5e8ff80.1650300597.git.jpoimboe@redhat.com
---
 arch/x86/lib/putuser.S | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/lib/putuser.S b/arch/x86/lib/putuser.S
index ecb2049..b7dfd60 100644
--- a/arch/x86/lib/putuser.S
+++ b/arch/x86/lib/putuser.S
@@ -48,6 +48,7 @@ SYM_FUNC_START(__put_user_1)
 	cmp %_ASM_BX,%_ASM_CX
 	jae .Lbad_put_user
 SYM_INNER_LABEL(__put_user_nocheck_1, SYM_L_GLOBAL)
+	ENDBR
 	ASM_STAC
 1:	movb %al,(%_ASM_CX)
 	xor %ecx,%ecx
@@ -62,6 +63,7 @@ SYM_FUNC_START(__put_user_2)
 	cmp %_ASM_BX,%_ASM_CX
 	jae .Lbad_put_user
 SYM_INNER_LABEL(__put_user_nocheck_2, SYM_L_GLOBAL)
+	ENDBR
 	ASM_STAC
 2:	movw %ax,(%_ASM_CX)
 	xor %ecx,%ecx
@@ -76,6 +78,7 @@ SYM_FUNC_START(__put_user_4)
 	cmp %_ASM_BX,%_ASM_CX
 	jae .Lbad_put_user
 SYM_INNER_LABEL(__put_user_nocheck_4, SYM_L_GLOBAL)
+	ENDBR
 	ASM_STAC
 3:	movl %eax,(%_ASM_CX)
 	xor %ecx,%ecx
@@ -90,6 +93,7 @@ SYM_FUNC_START(__put_user_8)
 	cmp %_ASM_BX,%_ASM_CX
 	jae .Lbad_put_user
 SYM_INNER_LABEL(__put_user_nocheck_8, SYM_L_GLOBAL)
+	ENDBR
 	ASM_STAC
 4:	mov %_ASM_AX,(%_ASM_CX)
 #ifdef CONFIG_X86_32
