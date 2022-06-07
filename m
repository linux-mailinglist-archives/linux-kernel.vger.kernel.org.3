Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89E9F53FC75
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 12:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242301AbiFGKyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 06:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242343AbiFGKuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 06:50:13 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76CF4F688F;
        Tue,  7 Jun 2022 03:49:56 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 5088F21B8B;
        Tue,  7 Jun 2022 10:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1654598994; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xMyZQRrXKtJochWB7+xsGtil/6dW4kBEoZgfCPMyREI=;
        b=c6POMQ1ZHRZ7N+amluupGEghN5rWqQ8Kc+FXi0uvbaTothz4CAuqd3dzj5NkqJkY07SJSR
        ET2cxU4ItRyEVeX4+wjRFNaNImRPHWp8mGuSLiocj0WV/aZD6SilCK45ix7dLjhYz9CuYK
        6KhUR3c7DGPgMcmXZYwsZzrCBnFYdC0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1654598994;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xMyZQRrXKtJochWB7+xsGtil/6dW4kBEoZgfCPMyREI=;
        b=gPUycg+0rWUOl8es/5KCJA4BDQj4QeYwfgkFWPuHIs0HbE4XOYbzT44LxGGmHxZcZZ1mQF
        P1S4Ab2+kkK5kABg==
Received: from localhost.localdomain (unknown [10.100.201.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 28A352C143;
        Tue,  7 Jun 2022 10:49:54 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 23/36] tty/vt: consolemap: saner variable names in con_unify_unimap()
Date:   Tue,  7 Jun 2022 12:49:33 +0200
Message-Id: <20220607104946.18710-23-jslaby@suse.cz>
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
 drivers/tty/vt/consolemap.c | 49 ++++++++++++++++++-------------------
 1 file changed, 24 insertions(+), 25 deletions(-)

diff --git a/drivers/tty/vt/consolemap.c b/drivers/tty/vt/consolemap.c
index 2454a4395722..cbdc73605148 100644
--- a/drivers/tty/vt/consolemap.c
+++ b/drivers/tty/vt/consolemap.c
@@ -454,42 +454,41 @@ void con_free_unimap(struct vc_data *vc)
 	kfree(p);
 }
   
-static int con_unify_unimap(struct vc_data *conp, struct uni_pagedict *p)
+static int con_unify_unimap(struct vc_data *conp, struct uni_pagedict *dict1)
 {
-	int i, j, k;
-	struct uni_pagedict *q;
-	
-	for (i = 0; i < MAX_NR_CONSOLES; i++) {
-		if (!vc_cons_allocated(i))
+	struct uni_pagedict *dict2;
+	unsigned int cons, d, r;
+
+	for (cons = 0; cons < MAX_NR_CONSOLES; cons++) {
+		if (!vc_cons_allocated(cons))
 			continue;
-		q = *vc_cons[i].d->vc_uni_pagedir_loc;
-		if (!q || q == p || q->sum != p->sum)
+		dict2 = *vc_cons[cons].d->vc_uni_pagedir_loc;
+		if (!dict2 || dict2 == dict1 || dict2->sum != dict1->sum)
 			continue;
-		for (j = 0; j < UNI_DIRS; j++) {
-			u16 **p1, **q1;
-			p1 = p->uni_pgdir[j];
-			q1 = q->uni_pgdir[j];
-			if (!p1 && !q1)
+		for (d = 0; d < UNI_DIRS; d++) {
+			u16 **dir1 = dict1->uni_pgdir[d];
+			u16 **dir2 = dict2->uni_pgdir[d];
+			if (!dir1 && !dir2)
 				continue;
-			if (!p1 || !q1)
+			if (!dir1 || !dir2)
 				break;
-			for (k = 0; k < UNI_DIR_ROWS; k++) {
-				if (!p1[k] && !q1[k])
+			for (r = 0; r < UNI_DIR_ROWS; r++) {
+				if (!dir1[r] && !dir2[r])
 					continue;
-				if (!p1[k] || !q1[k])
+				if (!dir1[r] || !dir2[r])
 					break;
-				if (memcmp(p1[k], q1[k], UNI_ROW_GLYPHS *
-							sizeof(*p1[k])))
+				if (memcmp(dir1[r], dir2[r], UNI_ROW_GLYPHS *
+							sizeof(*dir1[r])))
 					break;
 			}
-			if (k < UNI_DIR_ROWS)
+			if (r < UNI_DIR_ROWS)
 				break;
 		}
-		if (j == UNI_DIRS) {
-			q->refcount++;
-			*conp->vc_uni_pagedir_loc = q;
-			con_release_unimap(p);
-			kfree(p);
+		if (d == UNI_DIRS) {
+			dict2->refcount++;
+			*conp->vc_uni_pagedir_loc = dict2;
+			con_release_unimap(dict1);
+			kfree(dict1);
 			return 1;
 		}
 	}
-- 
2.36.1

