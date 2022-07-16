Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F336D577259
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 01:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233108AbiGPXTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 19:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233181AbiGPXS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 19:18:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FD8A23169
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 16:17:56 -0700 (PDT)
Message-ID: <20220716230954.275034921@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1658013474;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=+SkAT0acTC0wg1yKNmaNDVW/Hce09Uo6dKJ0RMDncd4=;
        b=aKc9I7OgvEqVoDkW5CNTiUQMmwvpRljeGAji+oG/7jY60IhW1W9F/Ji/geM4sPnAh7BtJ2
        ErbWyHKRmwVHQ5K7OjpYEH5hYvLA+A2pt9qAsY83IpIkF2g3b1VeKlYhbCNqASToiomPuU
        JhTyzo4CgoIOzLz3VSwRvVi4J43pDoLJbOC+3Pb/oeMSS/HcqfVILer47yWZrjYIBTN2sG
        vfubuFBjSCTOkyKPlwPaF/eRbHiYy9M0eq+5HEHG/CfxZ8Ylt+zoonCU1ZmRNAyYLzkoiq
        5yToAgCRVvwre1aV0H2CfarYkKhDyIvQwwu5KihO4lPt+jqzcEdDL9jiJSy7Tw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1658013474;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=+SkAT0acTC0wg1yKNmaNDVW/Hce09Uo6dKJ0RMDncd4=;
        b=l7zjZpIBEHlZtAneeNEraYRsIexxqaruRu5iviVajpqxakq7ZBcQgqgGvhChbitdD1YSNp
        JkWSBuDvqWGGSACw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Johannes Wikner <kwikner@ethz.ch>,
        Alyssa Milburn <alyssa.milburn@linux.intel.com>,
        Jann Horn <jannh@google.com>, "H.J. Lu" <hjl.tools@gmail.com>,
        Joao Moreira <joao.moreira@intel.com>,
        Joseph Nuzman <joseph.nuzman@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [patch 27/38] x86/asm: Provide ALTERNATIVE_3
References: <20220716230344.239749011@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 17 Jul 2022 01:17:53 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

Fairly straight forward adaptation/extention of ALTERNATIVE_2.

Required for call depth tracking.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/alternative.h |   33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -367,6 +367,7 @@ static inline int alternatives_text_rese
 #define old_len			141b-140b
 #define new_len1		144f-143f
 #define new_len2		145f-144f
+#define new_len3		146f-145f
 
 /*
  * gas compatible max based on the idea from:
@@ -374,7 +375,8 @@ static inline int alternatives_text_rese
  *
  * The additional "-" is needed because gas uses a "true" value of -1.
  */
-#define alt_max_short(a, b)	((a) ^ (((a) ^ (b)) & -(-((a) < (b)))))
+#define alt_max_2(a, b)		((a) ^ (((a) ^ (b)) & -(-((a) < (b)))))
+#define alt_max_3(a, b, c)	(alt_max_2(alt_max_2(a, b), c))
 
 
 /*
@@ -386,8 +388,8 @@ static inline int alternatives_text_rese
 140:
 	\oldinstr
 141:
-	.skip -((alt_max_short(new_len1, new_len2) - (old_len)) > 0) * \
-		(alt_max_short(new_len1, new_len2) - (old_len)),0x90
+	.skip -((alt_max_2(new_len1, new_len2) - (old_len)) > 0) * \
+		(alt_max_2(new_len1, new_len2) - (old_len)),0x90
 142:
 
 	.pushsection .altinstructions,"a"
@@ -404,6 +406,31 @@ static inline int alternatives_text_rese
 	.popsection
 .endm
 
+.macro ALTERNATIVE_3 oldinstr, newinstr1, feature1, newinstr2, feature2, newinstr3, feature3
+140:
+	\oldinstr
+141:
+	.skip -((alt_max_3(new_len1, new_len2, new_len3) - (old_len)) > 0) * \
+		(alt_max_3(new_len1, new_len2, new_len3) - (old_len)),0x90
+142:
+
+	.pushsection .altinstructions,"a"
+	altinstruction_entry 140b,143f,\feature1,142b-140b,144f-143f
+	altinstruction_entry 140b,144f,\feature2,142b-140b,145f-144f
+	altinstruction_entry 140b,145f,\feature3,142b-140b,146f-145f
+	.popsection
+
+	.pushsection .altinstr_replacement,"ax"
+143:
+	\newinstr1
+144:
+	\newinstr2
+145:
+	\newinstr3
+146:
+	.popsection
+.endm
+
 /* If @feature is set, patch in @newinstr_yes, otherwise @newinstr_no. */
 #define ALTERNATIVE_TERNARY(oldinstr, feature, newinstr_yes, newinstr_no) \
 	ALTERNATIVE_2 oldinstr, newinstr_no, X86_FEATURE_ALWAYS,	\

