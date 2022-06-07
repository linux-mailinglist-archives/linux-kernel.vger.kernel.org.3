Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7BD53FC6F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 12:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242168AbiFGKyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 06:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242292AbiFGKuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 06:50:10 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 820D795DC2;
        Tue,  7 Jun 2022 03:49:51 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 3DAA71F897;
        Tue,  7 Jun 2022 10:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1654598990; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kIlGFpRdqi/r23NjSL1vHxJ/SCU+uwLNQKsTOEUYnLQ=;
        b=TJs9qVt1bHYAdZIrzBKTWt82dJcKKOGxwK8T/NTOq4B3QS6srdt6NjWypiyVlSyCftRlpI
        KmTpwe4ruVMpAFf7z2VwQS7lEOwcNdZ2cqBb9WqBTl7gQrBRzJLrljXi4A1rhnfop243wX
        GCieeKgh4xTlO35Nm/qOEeLHv/vKY+Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1654598990;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kIlGFpRdqi/r23NjSL1vHxJ/SCU+uwLNQKsTOEUYnLQ=;
        b=yDnhnhM+3kpk3tPoZ00Y/aHhjR6hdWNYpjZ4OSNnZogPZ/1I3L3zfW8eOfpcLGEU9cIwfI
        6jqhJLByaeG66YAQ==
Received: from localhost.localdomain (unknown [10.100.201.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 166382C143;
        Tue,  7 Jun 2022 10:49:50 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 03/36] tty/vt: consolemap: define UNI_* macros for constants
Date:   Tue,  7 Jun 2022 12:49:13 +0200
Message-Id: <20220607104946.18710-3-jslaby@suse.cz>
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

The code uses constants for sizes of dictionary substructures on many
places. Define 3 macros and use them in the code, so that loop bounds,
local variables and the dictionary always match. (And the loop bounds
are obvious now too.)

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/vt/consolemap.c | 54 ++++++++++++++++++++-----------------
 1 file changed, 30 insertions(+), 24 deletions(-)

diff --git a/drivers/tty/vt/consolemap.c b/drivers/tty/vt/consolemap.c
index 5acafeea9afc..15aa10ff87ad 100644
--- a/drivers/tty/vt/consolemap.c
+++ b/drivers/tty/vt/consolemap.c
@@ -186,6 +186,10 @@ static unsigned short translations[][256] = {
 
 static int inv_translate[MAX_NR_CONSOLES];
 
+#define UNI_DIRS	32U
+#define UNI_DIR_ROWS	32U
+#define UNI_ROW_GLYPHS	64U
+
 /**
  * struct uni_pagedict -- unicode directory
  *
@@ -196,7 +200,7 @@ static int inv_translate[MAX_NR_CONSOLES];
  * @inverse_trans_unicode: best-effort inverse mapping to unicode
  */
 struct uni_pagedict {
-	u16		**uni_pgdir[32];
+	u16		**uni_pgdir[UNI_DIRS];
 	unsigned long	refcount;
 	unsigned long	sum;
 	unsigned char	*inverse_translations[4];
@@ -246,15 +250,15 @@ static void set_inverse_trans_unicode(struct vc_data *conp,
 	}
 	memset(q, 0, MAX_GLYPH * sizeof(u16));
 
-	for (i = 0; i < 32; i++) {
+	for (i = 0; i < UNI_DIRS; i++) {
 		p1 = p->uni_pgdir[i];
 		if (!p1)
 			continue;
-		for (j = 0; j < 32; j++) {
+		for (j = 0; j < UNI_DIR_ROWS; j++) {
 			p2 = p1[j];
 			if (!p2)
 				continue;
-			for (k = 0; k < 64; k++) {
+			for (k = 0; k < UNI_ROW_GLYPHS; k++) {
 				glyph = p2[k];
 				if (glyph >= 0 && glyph < MAX_GLYPH
 					       && q[glyph] < 32)
@@ -408,10 +412,10 @@ static void con_release_unimap(struct uni_pagedict *p)
 	int i, j;
 
 	if (p == dflt) dflt = NULL;  
-	for (i = 0; i < 32; i++) {
+	for (i = 0; i < UNI_DIRS; i++) {
 		p1 = p->uni_pgdir[i];
 		if (p1 != NULL) {
-			for (j = 0; j < 32; j++)
+			for (j = 0; j < UNI_DIR_ROWS; j++)
 				kfree(p1[j]);
 			kfree(p1);
 		}
@@ -451,25 +455,26 @@ static int con_unify_unimap(struct vc_data *conp, struct uni_pagedict *p)
 		q = *vc_cons[i].d->vc_uni_pagedir_loc;
 		if (!q || q == p || q->sum != p->sum)
 			continue;
-		for (j = 0; j < 32; j++) {
+		for (j = 0; j < UNI_DIRS; j++) {
 			u16 **p1, **q1;
 			p1 = p->uni_pgdir[j]; q1 = q->uni_pgdir[j];
 			if (!p1 && !q1)
 				continue;
 			if (!p1 || !q1)
 				break;
-			for (k = 0; k < 32; k++) {
+			for (k = 0; k < UNI_DIR_ROWS; k++) {
 				if (!p1[k] && !q1[k])
 					continue;
 				if (!p1[k] || !q1[k])
 					break;
-				if (memcmp(p1[k], q1[k], 64*sizeof(u16)))
+				if (memcmp(p1[k], q1[k],
+						UNI_ROW_GLYPHS * sizeof(u16)))
 					break;
 			}
-			if (k < 32)
+			if (k < UNI_DIR_ROWS)
 				break;
 		}
-		if (j == 32) {
+		if (j == UNI_DIRS) {
 			q->refcount++;
 			*conp->vc_uni_pagedir_loc = q;
 			con_release_unimap(p);
@@ -488,18 +493,19 @@ con_insert_unipair(struct uni_pagedict *p, u_short unicode, u_short fontpos)
 
 	p1 = p->uni_pgdir[n = unicode >> 11];
 	if (!p1) {
-		p1 = p->uni_pgdir[n] = kmalloc_array(32, sizeof(u16 *),
-						     GFP_KERNEL);
+		p1 = p->uni_pgdir[n] = kmalloc_array(UNI_DIR_ROWS,
+						     sizeof(u16 *), GFP_KERNEL);
 		if (!p1) return -ENOMEM;
-		for (i = 0; i < 32; i++)
+		for (i = 0; i < UNI_DIR_ROWS; i++)
 			p1[i] = NULL;
 	}
 
 	p2 = p1[n = (unicode >> 6) & 0x1f];
 	if (!p2) {
-		p2 = p1[n] = kmalloc_array(64, sizeof(u16), GFP_KERNEL);
+		p2 = p1[n] = kmalloc_array(UNI_ROW_GLYPHS, sizeof(u16), GFP_KERNEL);
 		if (!p2) return -ENOMEM;
-		memset(p2, 0xff, 64*sizeof(u16)); /* No glyphs for the characters (yet) */
+		/* No glyphs for the characters (yet) */
+		memset(p2, 0xff, UNI_ROW_GLYPHS * sizeof(u16));
 	}
 
 	p2[unicode & 0x3f] = fontpos;
@@ -589,13 +595,13 @@ int con_set_unimap(struct vc_data *vc, ushort ct, struct unipair __user *list)
 		 * entries from "p" (old) to "q" (new).
 		 */
 		l = 0;		/* unicode value */
-		for (i = 0; i < 32; i++) {
+		for (i = 0; i < UNI_DIRS; i++) {
 		p1 = p->uni_pgdir[i];
 		if (p1)
-			for (j = 0; j < 32; j++) {
+			for (j = 0; j < UNI_DIR_ROWS; j++) {
 			p2 = p1[j];
 			if (p2) {
-				for (k = 0; k < 64; k++, l++)
+				for (k = 0; k < UNI_ROW_GLYPHS; k++, l++)
 				if (p2[k] != 0xffff) {
 					/*
 					 * Found one, copy entry for unicode
@@ -613,12 +619,12 @@ int con_set_unimap(struct vc_data *vc, ushort ct, struct unipair __user *list)
 				}
 			} else {
 				/* Account for row of 64 empty entries */
-				l += 64;
+				l += UNI_ROW_GLYPHS;
 			}
 		}
 		else
 			/* Account for empty table */
-			l += 32 * 64;
+			l += UNI_DIR_ROWS * UNI_ROW_GLYPHS;
 		}
 
 		/*
@@ -760,13 +766,13 @@ int con_get_unimap(struct vc_data *vc, ushort ct, ushort __user *uct, struct uni
 	ect = 0;
 	if (*vc->vc_uni_pagedir_loc) {
 		p = *vc->vc_uni_pagedir_loc;
-		for (i = 0; i < 32; i++) {
+		for (i = 0; i < UNI_DIRS; i++) {
 		p1 = p->uni_pgdir[i];
 		if (p1)
-			for (j = 0; j < 32; j++) {
+			for (j = 0; j < UNI_DIR_ROWS; j++) {
 			p2 = *(p1++);
 			if (p2)
-				for (k = 0; k < 64; k++, p2++) {
+				for (k = 0; k < UNI_ROW_GLYPHS; k++, p2++) {
 					if (*p2 >= MAX_GLYPH)
 						continue;
 					if (ect < ct) {
-- 
2.36.1

