Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 518DD507AAF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 22:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357017AbiDSULX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 16:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356718AbiDSULR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 16:11:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07B1338798;
        Tue, 19 Apr 2022 13:08:34 -0700 (PDT)
Date:   Tue, 19 Apr 2022 20:08:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650398912;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jS39wpLI1AVOcECw+O89J4y1kZyGZ+Z2JK9khIdZGG4=;
        b=klLcSLaiaLtnV9h1m6Drjma27lzvsZ8MLgPYEna05Kzq9dMT95QT0cNPN5VaUFrh+mdX55
        Xx+9FV/Xjj83bqdeTiHtEKUEhhfSWYkgHJ+GONRypqwt5hplO4X/5opkb0zZVAi8SMAIfZ
        RTHBuPcrzsaDkQk2KIfODIczazeGULvtM4l1s2yBV48dd5HKs5gmD9HziSr6OnE4guS/p9
        bY8gWViDmpSvK8PB7Qimo3Htd6sVoGp+Eq7fCBeZfJzgZPR1/e8PGRWtVZOKvUcG9ekfUa
        yLV1rFTFC0WOP3GcMZCBI/RHmC7VLluVAapSkL1sRxCnmUFhJqAOrWUEtNXglg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650398912;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jS39wpLI1AVOcECw+O89J4y1kZyGZ+Z2JK9khIdZGG4=;
        b=lU2oFFZwHkMPSth7H7DvL2FlsXZJr3R/vskt8RGF4i+Wh19BusU7qr62CRHSTM3/wW9r2p
        VKfKKS7KCnFVA9CQ==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/urgent] objtool: Fix sibling call detection in alternatives
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <c02e0a0a2a4286b5f848d17c77fdcb7e0caf709c.1649718562.git.jpoimboe@redhat.com>
References: <c02e0a0a2a4286b5f848d17c77fdcb7e0caf709c.1649718562.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Message-ID: <165039891155.4207.6965870240273186525.tip-bot2@tip-bot2>
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

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     34c861e806478ac2ea4032721defbf1d6967df08
Gitweb:        https://git.kernel.org/tip/34c861e806478ac2ea4032721defbf1d6967df08
Author:        Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate:    Mon, 11 Apr 2022 16:10:31 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 19 Apr 2022 21:58:53 +02:00

objtool: Fix sibling call detection in alternatives

In add_jump_destinations(), sibling call detection requires 'insn->func'
to be valid.  But alternative instructions get their 'func' set in
handle_group_alt(), which runs *after* add_jump_destinations().  So
sibling calls in alternatives code don't get properly detected.

Fix that by changing the initialization order: call
add_special_section_alts() *before* add_jump_destinations().

This also means the special case for a missing 'jump_dest' in
add_jump_destinations() can be removed, as it has already been dealt
with.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/c02e0a0a2a4286b5f848d17c77fdcb7e0caf709c.1649718562.git.jpoimboe@redhat.com
---
 tools/objtool/check.c | 36 +++++++++++++++++-------------------
 1 file changed, 17 insertions(+), 19 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 6f49278..0f5d3de 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1277,6 +1277,13 @@ static int add_jump_destinations(struct objtool_file *file)
 	unsigned long dest_off;
 
 	for_each_insn(file, insn) {
+		if (insn->jump_dest) {
+			/*
+			 * handle_group_alt() may have previously set
+			 * 'jump_dest' for some alternatives.
+			 */
+			continue;
+		}
 		if (!is_static_jump(insn))
 			continue;
 
@@ -1308,15 +1315,6 @@ static int add_jump_destinations(struct objtool_file *file)
 
 		jump_dest = find_insn(file, dest_sec, dest_off);
 		if (!jump_dest) {
-
-			/*
-			 * This is a special case where an alt instruction
-			 * jumps past the end of the section.  These are
-			 * handled later in handle_group_alt().
-			 */
-			if (!strcmp(insn->sec->name, ".altinstr_replacement"))
-				continue;
-
 			WARN_FUNC("can't find jump dest instruction at %s+0x%lx",
 				  insn->sec, insn->offset, dest_sec->name,
 				  dest_off);
@@ -1549,13 +1547,13 @@ static int handle_group_alt(struct objtool_file *file,
 			continue;
 
 		dest_off = arch_jump_destination(insn);
-		if (dest_off == special_alt->new_off + special_alt->new_len)
+		if (dest_off == special_alt->new_off + special_alt->new_len) {
 			insn->jump_dest = next_insn_same_sec(file, last_orig_insn);
-
-		if (!insn->jump_dest) {
-			WARN_FUNC("can't find alternative jump destination",
-				  insn->sec, insn->offset);
-			return -1;
+			if (!insn->jump_dest) {
+				WARN_FUNC("can't find alternative jump destination",
+					  insn->sec, insn->offset);
+				return -1;
+			}
 		}
 	}
 
@@ -2254,14 +2252,14 @@ static int decode_sections(struct objtool_file *file)
 		return ret;
 
 	/*
-	 * Must be before add_special_section_alts() as that depends on
-	 * jump_dest being set.
+	 * Must be before add_jump_destinations(), which depends on 'func'
+	 * being set for alternatives, to enable proper sibling call detection.
 	 */
-	ret = add_jump_destinations(file);
+	ret = add_special_section_alts(file);
 	if (ret)
 		return ret;
 
-	ret = add_special_section_alts(file);
+	ret = add_jump_destinations(file);
 	if (ret)
 		return ret;
 
