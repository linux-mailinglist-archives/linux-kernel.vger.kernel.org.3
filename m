Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91A5D53FC24
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 12:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233955AbiFGKuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 06:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242299AbiFGKuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 06:50:10 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D15E2F5D0A;
        Tue,  7 Jun 2022 03:49:52 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 404F421B72;
        Tue,  7 Jun 2022 10:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1654598991; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tVqBK3m3laHxkdWX6Mqm/9egdXttb3XupQn5X0C/tnM=;
        b=rLu8WTuqqJoKSpUmQnrOJpShcRXxQt+OciOCuCHpv84OEdjTx165JL7rZRgMEuqMOOoh5+
        JNrpWvN03so/zhcfh6j1oQUARFIbiGLu24IeA2ox9Gsjzc3Ow5IXcYQquU+wNidPqP8OxJ
        z3pCQpGys75o9XlrFjk6bazMkdz0bJk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1654598991;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tVqBK3m3laHxkdWX6Mqm/9egdXttb3XupQn5X0C/tnM=;
        b=JUs5NO4JvN1IZkFMSDqblsQhEqGtaIjhaCurpsj7YkY6FSzuRhirPWk1/yxhpxnmOusWCw
        6G2SPbGcAWr7i0AA==
Received: from localhost.localdomain (unknown [10.100.201.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 1962F2C143;
        Tue,  7 Jun 2022 10:49:51 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 08/36] tty/vt: consolemap: one line = one statement
Date:   Tue,  7 Jun 2022 12:49:18 +0200
Message-Id: <20220607104946.18710-8-jslaby@suse.cz>
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

Some lines combine more statements on one line. This makes the code hard
to follow. Do it properly in the "one line = one statement" fashion.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/vt/consolemap.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/vt/consolemap.c b/drivers/tty/vt/consolemap.c
index 157c7f936294..f97081e01b71 100644
--- a/drivers/tty/vt/consolemap.c
+++ b/drivers/tty/vt/consolemap.c
@@ -215,12 +215,14 @@ static void set_inverse_transl(struct vc_data *conp, struct uni_pagedict *p, int
 	unsigned short *t = translations[i];
 	unsigned char *q;
 	
-	if (!p) return;
+	if (!p)
+		return;
 	q = p->inverse_translations[i];
 
 	if (!q) {
 		q = p->inverse_translations[i] = kmalloc(MAX_GLYPH, GFP_KERNEL);
-		if (!q) return;
+		if (!q)
+			return;
 	}
 	memset(q, 0, MAX_GLYPH);
 
@@ -240,7 +242,8 @@ static void set_inverse_trans_unicode(struct vc_data *conp,
 	u16 **p1, *p2;
 	u16 *q;
 
-	if (!p) return;
+	if (!p)
+		return;
 	q = p->inverse_trans_unicode;
 	if (!q) {
 		q = p->inverse_trans_unicode =
@@ -412,7 +415,8 @@ static void con_release_unimap(struct uni_pagedict *p)
 	u16 **p1;
 	int i, j;
 
-	if (p == dflt) dflt = NULL;  
+	if (p == dflt)
+		dflt = NULL;
 	for (i = 0; i < UNI_DIRS; i++) {
 		p1 = p->uni_pgdir[i];
 		if (p1 != NULL) {
@@ -458,7 +462,8 @@ static int con_unify_unimap(struct vc_data *conp, struct uni_pagedict *p)
 			continue;
 		for (j = 0; j < UNI_DIRS; j++) {
 			u16 **p1, **q1;
-			p1 = p->uni_pgdir[j]; q1 = q->uni_pgdir[j];
+			p1 = p->uni_pgdir[j];
+			q1 = q->uni_pgdir[j];
 			if (!p1 && !q1)
 				continue;
 			if (!p1 || !q1)
@@ -492,19 +497,23 @@ con_insert_unipair(struct uni_pagedict *p, u_short unicode, u_short fontpos)
 	int i, n;
 	u16 **p1, *p2;
 
-	p1 = p->uni_pgdir[n = unicode >> 11];
+	n = unicode >> 11;
+	p1 = p->uni_pgdir[n];
 	if (!p1) {
 		p1 = p->uni_pgdir[n] = kmalloc_array(UNI_DIR_ROWS,
 						     sizeof(u16 *), GFP_KERNEL);
-		if (!p1) return -ENOMEM;
+		if (!p1)
+			return -ENOMEM;
 		for (i = 0; i < UNI_DIR_ROWS; i++)
 			p1[i] = NULL;
 	}
 
-	p2 = p1[n = (unicode >> 6) & 0x1f];
+	n = (unicode >> 6) & 0x1f;
+	p2 = p1[n];
 	if (!p2) {
 		p2 = p1[n] = kmalloc_array(UNI_ROW_GLYPHS, sizeof(u16), GFP_KERNEL);
-		if (!p2) return -ENOMEM;
+		if (!p2)
+			return -ENOMEM;
 		/* No glyphs for the characters (yet) */
 		memset(p2, 0xff, UNI_ROW_GLYPHS * sizeof(u16));
 	}
@@ -532,7 +541,8 @@ static int con_do_clear_unimap(struct vc_data *vc)
 		q->refcount=1;
 		*vc->vc_uni_pagedir_loc = q;
 	} else {
-		if (p == dflt) dflt = NULL;
+		if (p == dflt)
+			dflt = NULL;
 		p->refcount++;
 		p->sum = 0;
 		con_release_unimap(p);
-- 
2.36.1

