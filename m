Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D473353FC4A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 12:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241759AbiFGKva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 06:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242314AbiFGKuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 06:50:10 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82802F5D33;
        Tue,  7 Jun 2022 03:49:54 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 13F0921B79;
        Tue,  7 Jun 2022 10:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1654598992; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F3O8pK7reIxPoFRnMcI5fdMHJz2FqzvY3j9G6Q+mnLQ=;
        b=t2QPgyVvjdgXeqXuDziaytbgnFFz5I8nZZInxLQBJXXUq1tjx1SQlY/rXXYAkWxJcOp9Cv
        9/kRsBx2GYI+9pTTFBbYB6SyOPoCbW9SYLOzZ4zK4D5lkDkDz6zy8QZO8xEKfEchWY8OL2
        OJLj8XkwUoYZCRUYH9DfsbnqY0e5FRg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1654598992;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F3O8pK7reIxPoFRnMcI5fdMHJz2FqzvY3j9G6Q+mnLQ=;
        b=gofPsuTjRg4Rolez1n0h25U+DGKsnt7PRWwcFSkLXoBZ5ms/gy5+M45qqcfAYRtHOktf99
        M4m7/3IehZ3tudCQ==
Received: from localhost.localdomain (unknown [10.100.201.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id DD8AD2C142;
        Tue,  7 Jun 2022 10:49:51 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 12/36] tty/vt: consolemap: use sizeof(*pointer) instead of sizeof(type)
Date:   Tue,  7 Jun 2022 12:49:22 +0200
Message-Id: <20220607104946.18710-12-jslaby@suse.cz>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220607104946.18710-1-jslaby@suse.cz>
References: <20220607104946.18710-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is preferred to use sizeof(*pointer) instead of sizeof(type). First,
the type of the variable can change and one needs not change the former
(unlike the latter). Second, the latter is error-prone due to (u16),
(u16 *), and (u16 **) mixture here.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/vt/consolemap.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/tty/vt/consolemap.c b/drivers/tty/vt/consolemap.c
index 097ab7d01f8b..79a62dcca046 100644
--- a/drivers/tty/vt/consolemap.c
+++ b/drivers/tty/vt/consolemap.c
@@ -251,12 +251,12 @@ static void set_inverse_trans_unicode(struct vc_data *conp,
 		return;
 	q = p->inverse_trans_unicode;
 	if (!q) {
-		q = p->inverse_trans_unicode =
-			kmalloc_array(MAX_GLYPH, sizeof(u16), GFP_KERNEL);
+		q = p->inverse_trans_unicode = kmalloc_array(MAX_GLYPH,
+				sizeof(*q), GFP_KERNEL);
 		if (!q)
 			return;
 	}
-	memset(q, 0, MAX_GLYPH * sizeof(u16));
+	memset(q, 0, MAX_GLYPH * sizeof(*q));
 
 	for (i = 0; i < UNI_DIRS; i++) {
 		p1 = p->uni_pgdir[i];
@@ -478,8 +478,8 @@ static int con_unify_unimap(struct vc_data *conp, struct uni_pagedict *p)
 					continue;
 				if (!p1[k] || !q1[k])
 					break;
-				if (memcmp(p1[k], q1[k],
-						UNI_ROW_GLYPHS * sizeof(u16)))
+				if (memcmp(p1[k], q1[k], UNI_ROW_GLYPHS *
+							sizeof(*p1[k])))
 					break;
 			}
 			if (k < UNI_DIR_ROWS)
@@ -505,7 +505,7 @@ con_insert_unipair(struct uni_pagedict *p, u_short unicode, u_short fontpos)
 	n = UNI_DIR(unicode);
 	p1 = p->uni_pgdir[n];
 	if (!p1) {
-		p1 = p->uni_pgdir[n] = kcalloc(UNI_DIR_ROWS, sizeof(u16 *),
+		p1 = p->uni_pgdir[n] = kcalloc(UNI_DIR_ROWS, sizeof(*p1),
 				GFP_KERNEL);
 		if (!p1)
 			return -ENOMEM;
@@ -514,11 +514,12 @@ con_insert_unipair(struct uni_pagedict *p, u_short unicode, u_short fontpos)
 	n = UNI_ROW(unicode);
 	p2 = p1[n];
 	if (!p2) {
-		p2 = p1[n] = kmalloc_array(UNI_ROW_GLYPHS, sizeof(u16), GFP_KERNEL);
+		p2 = p1[n] = kmalloc_array(UNI_ROW_GLYPHS, sizeof(*p2),
+				GFP_KERNEL);
 		if (!p2)
 			return -ENOMEM;
 		/* No glyphs for the characters (yet) */
-		memset(p2, 0xff, UNI_ROW_GLYPHS * sizeof(u16));
+		memset(p2, 0xff, UNI_ROW_GLYPHS * sizeof(*p2));
 	}
 
 	p2[UNI_GLYPH(unicode)] = fontpos;
@@ -571,7 +572,7 @@ int con_set_unimap(struct vc_data *vc, ushort ct, struct unipair __user *list)
 	if (!ct)
 		return 0;
 
-	unilist = vmemdup_user(list, array_size(sizeof(struct unipair), ct));
+	unilist = vmemdup_user(list, array_size(sizeof(*unilist), ct));
 	if (IS_ERR(unilist))
 		return PTR_ERR(unilist);
 
@@ -771,7 +772,7 @@ int con_get_unimap(struct vc_data *vc, ushort ct, ushort __user *uct, struct uni
 	struct uni_pagedict *p;
 	struct unipair *unilist;
 
-	unilist = kvmalloc_array(ct, sizeof(struct unipair), GFP_KERNEL);
+	unilist = kvmalloc_array(ct, sizeof(*unilist), GFP_KERNEL);
 	if (!unilist)
 		return -ENOMEM;
 
@@ -800,7 +801,7 @@ int con_get_unimap(struct vc_data *vc, ushort ct, ushort __user *uct, struct uni
 		}
 	}
 	console_unlock();
-	if (copy_to_user(list, unilist, min(ect, ct) * sizeof(struct unipair)))
+	if (copy_to_user(list, unilist, min(ect, ct) * sizeof(*unilist)))
 		ret = -EFAULT;
 	put_user(ect, uct);
 	kvfree(unilist);
-- 
2.36.1

