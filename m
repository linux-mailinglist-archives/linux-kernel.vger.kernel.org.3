Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 394684FC802
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 01:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232177AbiDKXNd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 19:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231752AbiDKXNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 19:13:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8BFC212ACD
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 16:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649718665;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0ZCQd9ke2KAWwc19bl0zzlVfHby01VezJ6qx5ncoRec=;
        b=WQIMFIZxcJN/KX+OdPdpSmYw1iDX3Rgz+/jmZnjPAdpPcM7YTDy60CS7Y9EXlY7vVQO4yp
        kbvLOg6BYc6d2vdO3UU7hIxC4NjtFiVxiVNGmkhcxjYRsgELl9SDg5BMyOjeCuOV3aLdNc
        Jr3iL8SkeBWoa/N5dUxFCDJsPOzgps4=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-184-_SeYdMwzN0ubioKLE2ifIA-1; Mon, 11 Apr 2022 19:11:04 -0400
X-MC-Unique: _SeYdMwzN0ubioKLE2ifIA-1
Received: by mail-qv1-f69.google.com with SMTP id ke15-20020a056214300f00b00443efe3fe65so16908304qvb.14
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 16:11:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0ZCQd9ke2KAWwc19bl0zzlVfHby01VezJ6qx5ncoRec=;
        b=lNkJnDf0FJ3G7bFwFMbcKnUhSc2b0rOgI7LiE0nmBkFQU8vOiWjwvK7ZK1x3mpgvNK
         K6KwSde5CgZAREkMo5v+inPjSrNLYo7PZ3ZrR6sh6CggKzPMB9lWBvsmoZl5JM7t3bU+
         0Z4QSpS1Kp1M344PYaqXgA+LMh+KpCmoqNH3BHyZyFYWntdWAiGhB4lputwekhniG51A
         FPqwtXNbxO9ANJophKZJPF5Akr5nzeMhlGh6pLqjMEZ/04G/jQUz392GKQBEXYRd2lBu
         tfzlQ7OsgTw2fO9/jIznutiBJNyyn+77PPteHaA5vt4ddxXJHxDUvcTepoVGEPVtIeBk
         DzvQ==
X-Gm-Message-State: AOAM531O3exl+a6NLx7Ne1hfpcF859i8WUTebGxgR5JyXjWO3L6qm/vE
        HqDUG1dJ7auUBejVXfrao6LDAIAoCG4HJXsnbA7tJnrkbP6fMN/xTiagUpYtao4Pg47YguVIReX
        THlJtgbDjcW1nnJT7O4G2LVEu
X-Received: by 2002:ac8:4c9a:0:b0:2ed:f0a:77c4 with SMTP id j26-20020ac84c9a000000b002ed0f0a77c4mr1350331qtv.376.1649718663874;
        Mon, 11 Apr 2022 16:11:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwyDp3MjtsqHgRu/Usu7o4b+HfnrxhC+MSZPW3gRfG7MKn4igSsZZTAsstnRNG/fRkx69Vwrw==
X-Received: by 2002:ac8:4c9a:0:b0:2ed:f0a:77c4 with SMTP id j26-20020ac84c9a000000b002ed0f0a77c4mr1350318qtv.376.1649718663554;
        Mon, 11 Apr 2022 16:11:03 -0700 (PDT)
Received: from treble.redhat.com ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id c3-20020ac87d83000000b002e1d1b3df15sm27243500qtd.44.2022.04.11.16.11.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 16:11:03 -0700 (PDT)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] objtool: Fix sibling call detection in alternatives
Date:   Mon, 11 Apr 2022 16:10:31 -0700
Message-Id: <c02e0a0a2a4286b5f848d17c77fdcb7e0caf709c.1649718562.git.jpoimboe@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1649718562.git.jpoimboe@redhat.com>
References: <cover.1649718562.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 tools/objtool/check.c | 36 +++++++++++++++++-------------------
 1 file changed, 17 insertions(+), 19 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 6f492789c8c0..0f5d3de30e0d 100644
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
 
-- 
2.34.1

