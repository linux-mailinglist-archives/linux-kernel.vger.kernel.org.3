Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8F8577255
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 01:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232279AbiGPXRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 19:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233027AbiGPXRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 19:17:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0017C22BF8
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 16:17:29 -0700 (PDT)
Message-ID: <20220716230953.326426616@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1658013448;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=gtD1bYCGdHrGTPvqbbT1WQIkd3q5mX14d2yTGTsEWIY=;
        b=lrQq7zg12vfL/fN+uWktN47xduM1mb9mGBRJv3iMxtvBOgIMIhDsVpJkxRMmE2tf9NZTBT
        ZKGuaXKuEn0KXxwHmVi+tAO+zWMmNbQArFmCpxa9fF1V4uGRcQshj/kSZla/lsaBHEAetk
        uwC0ADPf7B27lXUJUueshlIaqi0gp9Khexp9baNI55GajgJ0eH0C6IoU7MwKZXD3htOCDg
        C7VQsv7X4eMPSgV1X9mv3coV2VYVk9N9H4QJHOL2l3gb9mOzNC9iXnig0D0YuI395ld1za
        jfXEqOajTsPvbTBF3JuyF0cB5BpmSjAhvjqRkIOXc+sFn/z1dqtzIO4U4DuE1w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1658013448;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=gtD1bYCGdHrGTPvqbbT1WQIkd3q5mX14d2yTGTsEWIY=;
        b=hgFT98BVliI+NewUNQtK7EJ65UB1bY1yMvjI0qVxyd5uxSQhe9bl/1q9f/swB7jITiOGEE
        5yJTOqW/Ptk2F4Dw==
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
Subject: [patch 11/38] objtool: Allow STT_NOTYPE -> STT_FUNC+0 tail-calls
References: <20220716230344.239749011@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 17 Jul 2022 01:17:27 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow STT_NOTYPE to tail-call into STT_FUNC, per definition STT_NOTYPE
is not a sub-function of the STT_FUNC.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 tools/objtool/check.c |   29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1420,6 +1420,16 @@ static void add_return_call(struct objto
 
 static bool same_function(struct instruction *insn1, struct instruction *insn2)
 {
+	if (!insn1->func && !insn2->func)
+		return true;
+
+	/* Allow STT_NOTYPE -> STT_FUNC+0 tail-calls */
+	if (!insn1->func && insn1->func != insn2->func)
+		return false;
+
+	if (!insn2->func)
+		return true;
+
 	return insn1->func->pfunc == insn2->func->pfunc;
 }
 
@@ -1537,18 +1547,19 @@ static int add_jump_destinations(struct
 			    strstr(jump_dest->func->name, ".cold")) {
 				insn->func->cfunc = jump_dest->func;
 				jump_dest->func->pfunc = insn->func;
-
-			} else if (!same_function(insn, jump_dest) &&
-				   is_first_func_insn(file, jump_dest)) {
-				/*
-				 * Internal sibling call without reloc or with
-				 * STT_SECTION reloc.
-				 */
-				add_call_dest(file, insn, jump_dest->func, true);
-				continue;
 			}
 		}
 
+		if (!same_function(insn, jump_dest) &&
+		    is_first_func_insn(file, jump_dest)) {
+			/*
+			 * Internal sibling call without reloc or with
+			 * STT_SECTION reloc.
+			 */
+			add_call_dest(file, insn, jump_dest->func, true);
+			continue;
+		}
+
 		insn->jump_dest = jump_dest;
 	}
 

