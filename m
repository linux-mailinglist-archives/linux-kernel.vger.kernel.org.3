Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 905A453FC68
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 12:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242193AbiFGKxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 06:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242334AbiFGKuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 06:50:12 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76C66F688E;
        Tue,  7 Jun 2022 03:49:56 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id B55BE21B6C;
        Tue,  7 Jun 2022 10:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1654598994; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kE/e52gf6PU49DNTpvcmbCDC+7FBB2x/Z/QZnWeXVvU=;
        b=reDPmAqB/Eftd81vXmctj4JMzGodNaDF6c9fOUNApQJ2TLMqhKieYpxaTLYoGa0TMShwas
        nLnOD42n6IPsRkTps9roaRcu2adKeRuPygKrlXbgm97d2vqSvsJM2WDe2vMI9hkx231H3M
        2JFqtlzFKhFcNL83/ES7x1g4Wv7njQQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1654598994;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kE/e52gf6PU49DNTpvcmbCDC+7FBB2x/Z/QZnWeXVvU=;
        b=fsCFMdpbqLPAMCUACRWfyiY4KC6U3SUMZZHkhgp/VZ4ZeULIm8bAd/k0YkbMhAmGF4T52D
        fvR5Y9sBgxnAS2Cg==
Received: from localhost.localdomain (unknown [10.100.201.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 8D8662C142;
        Tue,  7 Jun 2022 10:49:54 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 25/36] tty/vt: consolemap: saner variable names in con_unshare_unimap()
Date:   Tue,  7 Jun 2022 12:49:35 +0200
Message-Id: <20220607104946.18710-25-jslaby@suse.cz>
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

The function uses too vague variable names like i, j, k for iterators, p,
q, p1, p2 for pointers etc.

Rename all these, so that it is clear what is going on:
- dict: for dictionaries.
- d, r, g: for dir, row, glyph iterators -- these are unsigned now.
- dir, row: for directory and row pointers.
- glyph: for the glyph.
- and so on...

This is a lot of shuffling, but the result pays off, IMO.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/vt/consolemap.c | 51 ++++++++++++++++++-------------------
 1 file changed, 25 insertions(+), 26 deletions(-)

diff --git a/drivers/tty/vt/consolemap.c b/drivers/tty/vt/consolemap.c
index 456aed3f717c..7e353455945d 100644
--- a/drivers/tty/vt/consolemap.c
+++ b/drivers/tty/vt/consolemap.c
@@ -562,12 +562,12 @@ int con_clear_unimap(struct vc_data *vc)
 }
 
 static struct uni_pagedict *con_unshare_unimap(struct vc_data *vc,
-		struct uni_pagedict *p)
+		struct uni_pagedict *old)
 {
-	struct uni_pagedict *q;
-	u16 **p1, *p2, l;
+	struct uni_pagedict *new;
+	unsigned int d, r, g;
 	int ret;
-	int i, j, k;
+	u16 uni = 0;
 
 	ret = con_do_clear_unimap(vc);
 	if (ret)
@@ -575,52 +575,51 @@ static struct uni_pagedict *con_unshare_unimap(struct vc_data *vc,
 
 	/*
 	 * Since refcount was > 1, con_clear_unimap() allocated a new
-	 * uni_pagedict for this vc.  Re: p != q
+	 * uni_pagedict for this vc.  Re: old != new
 	 */
-	q = *vc->vc_uni_pagedir_loc;
+	new = *vc->vc_uni_pagedir_loc;
 
 	/*
 	 * uni_pgdir is a 32*32*64 table with rows allocated when its first
 	 * entry is added. The unicode value must still be incremented for
-	 * empty rows. We are copying entries from "p" (old) to "q" (new).
+	 * empty rows. We are copying entries from "old" to "new".
 	 */
-	l = 0;		/* unicode value */
-	for (i = 0; i < UNI_DIRS; i++) {
-		p1 = p->uni_pgdir[i];
-		if (!p1) {
+	for (d = 0; d < UNI_DIRS; d++) {
+		u16 **dir = old->uni_pgdir[d];
+		if (!dir) {
 			/* Account for empty table */
-			l += UNI_DIR_ROWS * UNI_ROW_GLYPHS;
+			uni += UNI_DIR_ROWS * UNI_ROW_GLYPHS;
 			continue;
 		}
 
-		for (j = 0; j < UNI_DIR_ROWS; j++) {
-			p2 = p1[j];
-			if (!p2) {
+		for (r = 0; r < UNI_DIR_ROWS; r++) {
+			u16 *row = dir[r];
+			if (!row) {
 				/* Account for row of 64 empty entries */
-				l += UNI_ROW_GLYPHS;
+				uni += UNI_ROW_GLYPHS;
 				continue;
 			}
 
-			for (k = 0; k < UNI_ROW_GLYPHS; k++, l++) {
-				if (p2[k] == 0xffff)
+			for (g = 0; g < UNI_ROW_GLYPHS; g++, uni++) {
+				if (row[g] == 0xffff)
 					continue;
 				/*
-				 * Found one, copy entry for unicode l with
-				 * fontpos value p2[k].
+				 * Found one, copy entry for unicode uni with
+				 * fontpos value row[g].
 				 */
-				ret = con_insert_unipair(q, l, p2[k]);
+				ret = con_insert_unipair(new, uni, row[g]);
 				if (ret) {
-					p->refcount++;
-					*vc->vc_uni_pagedir_loc = p;
-					con_release_unimap(q);
-					kfree(q);
+					old->refcount++;
+					*vc->vc_uni_pagedir_loc = old;
+					con_release_unimap(new);
+					kfree(new);
 					return ERR_PTR(ret);
 				}
 			}
 		}
 	}
 
-	return q;
+	return new;
 }
 
 int con_set_unimap(struct vc_data *vc, ushort ct, struct unipair __user *list)
-- 
2.36.1

