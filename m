Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCA4A53FC69
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 12:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242033AbiFGKxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 06:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242326AbiFGKuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 06:50:11 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D8718DDCB;
        Tue,  7 Jun 2022 03:49:56 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id A8A2721B50;
        Tue,  7 Jun 2022 10:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1654598993; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xszV0wDet51uzfYewjVpAIGcIlTNyJ4ffBlfEFxN+pQ=;
        b=s8e6cFMIb+YAaZ0xT5meI/t6QsJ4a1eZBHZvoFRHwICpJc6mHUf7hXVZEYbrNEjiELRZsm
        LS1plcZ8PKson33eOEqK/vtaMJNCXgMOVqoldjx1E1pcSxPRYL5Joz4hg5OD4+DV8B+hos
        qCfkpguRmGLivgq83xOFYAGq0Gl5o7w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1654598993;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xszV0wDet51uzfYewjVpAIGcIlTNyJ4ffBlfEFxN+pQ=;
        b=+Fx+HrkC1fG8gSFZOHtYdZp1bsVknYAKXWdt+oqQQPFOBKM/bzIC1dUbcFfht813pyZ83J
        V9OCyUt0wl9nkNDw==
Received: from localhost.localdomain (unknown [10.100.201.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 80FBE2C141;
        Tue,  7 Jun 2022 10:49:53 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 20/36] tty/vt: consolemap: saner variable names in set_inverse_trans_unicode()
Date:   Tue,  7 Jun 2022 12:49:30 +0200
Message-Id: <20220607104946.18710-20-jslaby@suse.cz>
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
 drivers/tty/vt/consolemap.c | 38 ++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/tty/vt/consolemap.c b/drivers/tty/vt/consolemap.c
index eb5b4b519baf..3763a73706b2 100644
--- a/drivers/tty/vt/consolemap.c
+++ b/drivers/tty/vt/consolemap.c
@@ -244,33 +244,33 @@ static void set_inverse_transl(struct vc_data *conp, struct uni_pagedict *p,
 static void set_inverse_trans_unicode(struct vc_data *conp,
 				      struct uni_pagedict *p)
 {
-	int i, j, k;
-	u16 **p1, *p2;
-	u16 *q;
+	unsigned int d, r, g;
+	u16 *inv;
 
 	if (!p)
 		return;
-	q = p->inverse_trans_unicode;
-	if (!q) {
-		q = p->inverse_trans_unicode = kmalloc_array(MAX_GLYPH,
-				sizeof(*q), GFP_KERNEL);
-		if (!q)
+
+	inv = p->inverse_trans_unicode;
+	if (!inv) {
+		inv = p->inverse_trans_unicode = kmalloc_array(MAX_GLYPH,
+				sizeof(*inv), GFP_KERNEL);
+		if (!inv)
 			return;
 	}
-	memset(q, 0, MAX_GLYPH * sizeof(*q));
+	memset(inv, 0, MAX_GLYPH * sizeof(*inv));
 
-	for (i = 0; i < UNI_DIRS; i++) {
-		p1 = p->uni_pgdir[i];
-		if (!p1)
+	for (d = 0; d < UNI_DIRS; d++) {
+		u16 **dir = p->uni_pgdir[d];
+		if (!dir)
 			continue;
-		for (j = 0; j < UNI_DIR_ROWS; j++) {
-			p2 = p1[j];
-			if (!p2)
+		for (r = 0; r < UNI_DIR_ROWS; r++) {
+			u16 *row = dir[r];
+			if (!row)
 				continue;
-			for (k = 0; k < UNI_ROW_GLYPHS; k++) {
-				u16 glyph = p2[k];
-				if (glyph < MAX_GLYPH && q[glyph] < 32)
-					q[glyph] = UNI(i, j, k);
+			for (g = 0; g < UNI_ROW_GLYPHS; g++) {
+				u16 glyph = row[g];
+				if (glyph < MAX_GLYPH && inv[glyph] < 32)
+					inv[glyph] = UNI(d, r, g);
 			}
 		}
 	}
-- 
2.36.1

