Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9964153FC50
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 12:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241765AbiFGKvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 06:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242325AbiFGKuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 06:50:11 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E809F6881;
        Tue,  7 Jun 2022 03:49:54 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 7935B1F964;
        Tue,  7 Jun 2022 10:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1654598993; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1hbW7LAMSWPFFvQo9SXzst8G4PLSLAnSzN6f/MhxufY=;
        b=v0v2rCi7rHXmmtAbqHXBHEBwIzFmpUuYXVs1/QCs2Jd9vJFf+NoP7efLYyOXbhEW1dkivF
        qrtxJXe7tAhFA1NtgjO2DdnHdqVV1tFTccyYtD4dHt81PXhzbgokm9dckDJSNFrmtF7NO8
        elc/xX6ZRHxOPsHT7l0IjdjLZyiF8MY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1654598993;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1hbW7LAMSWPFFvQo9SXzst8G4PLSLAnSzN6f/MhxufY=;
        b=64N79qI+JzjsfY+d5+9jOkzNpRcVMGu5PR/C4VLl5DzCwB44sGZqy9tZF0E44ws5Bd+yTa
        h6dz1VzVBLjgCVDg==
Received: from localhost.localdomain (unknown [10.100.201.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 5396F2C142;
        Tue,  7 Jun 2022 10:49:53 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 19/36] tty/vt: consolemap: extract dict unsharing to con_unshare_unimap()
Date:   Tue,  7 Jun 2022 12:49:29 +0200
Message-Id: <20220607104946.18710-19-jslaby@suse.cz>
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

The code in con_set_unimap() is too nested. Extract its obvious part
into a separate function and name it after what the code does:
con_unshare_unimap().

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/vt/consolemap.c | 133 ++++++++++++++++++------------------
 1 file changed, 68 insertions(+), 65 deletions(-)

diff --git a/drivers/tty/vt/consolemap.c b/drivers/tty/vt/consolemap.c
index 733795a3dc68..eb5b4b519baf 100644
--- a/drivers/tty/vt/consolemap.c
+++ b/drivers/tty/vt/consolemap.c
@@ -562,11 +562,73 @@ int con_clear_unimap(struct vc_data *vc)
 	console_unlock();
 	return ret;
 }
-	
+
+static struct uni_pagedict *con_unshare_unimap(struct vc_data *vc,
+		struct uni_pagedict *p)
+{
+	struct uni_pagedict *q;
+	u16 **p1, *p2, l;
+	int ret;
+	int i, j, k;
+
+	ret = con_do_clear_unimap(vc);
+	if (ret)
+		return ERR_PTR(ret);
+
+	/*
+	 * Since refcount was > 1, con_clear_unimap() allocated a new
+	 * uni_pagedict for this vc.  Re: p != q
+	 */
+	q = *vc->vc_uni_pagedir_loc;
+
+	/*
+	 * uni_pgdir is a 32*32*64 table with rows allocated when its first
+	 * entry is added. The unicode value must still be incremented for
+	 * empty rows. We are copying entries from "p" (old) to "q" (new).
+	 */
+	l = 0;		/* unicode value */
+	for (i = 0; i < UNI_DIRS; i++) {
+		p1 = p->uni_pgdir[i];
+		if (!p1) {
+			/* Account for empty table */
+			l += UNI_DIR_ROWS * UNI_ROW_GLYPHS;
+			continue;
+		}
+
+		for (j = 0; j < UNI_DIR_ROWS; j++) {
+			p2 = p1[j];
+			if (!p2) {
+				/* Account for row of 64 empty entries */
+				l += UNI_ROW_GLYPHS;
+				continue;
+			}
+
+			for (k = 0; k < UNI_ROW_GLYPHS; k++, l++) {
+				if (p2[k] == 0xffff)
+					continue;
+				/*
+				 * Found one, copy entry for unicode l with
+				 * fontpos value p2[k].
+				 */
+				ret = con_insert_unipair(q, l, p2[k]);
+				if (ret) {
+					p->refcount++;
+					*vc->vc_uni_pagedir_loc = p;
+					con_release_unimap(q);
+					kfree(q);
+					return ERR_PTR(ret);
+				}
+			}
+		}
+	}
+
+	return q;
+}
+
 int con_set_unimap(struct vc_data *vc, ushort ct, struct unipair __user *list)
 {
-	int err = 0, err1, i;
-	struct uni_pagedict *p, *q;
+	int err = 0, err1;
+	struct uni_pagedict *p;
 	struct unipair *unilist, *plist;
 
 	if (!ct)
@@ -586,70 +648,11 @@ int con_set_unimap(struct vc_data *vc, ushort ct, struct unipair __user *list)
 	}
 
 	if (p->refcount > 1) {
-		int j, k;
-		u16 **p1, *p2, l;
-
-		err1 = con_do_clear_unimap(vc);
-		if (err1) {
-			err = err1;
+		p = con_unshare_unimap(vc, p);
+		if (IS_ERR(p)) {
+			err = PTR_ERR(p);
 			goto out_unlock;
 		}
-
-		/*
-		 * Since refcount was > 1, con_clear_unimap() allocated a
-		 * a new uni_pagedict for this vc.  Re: p != q
-		 */
-		q = *vc->vc_uni_pagedir_loc;
-
-		/*
-		 * uni_pgdir is a 32*32*64 table with rows allocated
-		 * when its first entry is added.  The unicode value must
-		 * still be incremented for empty rows.  We are copying
-		 * entries from "p" (old) to "q" (new).
-		 */
-		l = 0;		/* unicode value */
-		for (i = 0; i < UNI_DIRS; i++) {
-			p1 = p->uni_pgdir[i];
-			if (!p1) {
-				/* Account for empty table */
-				l += UNI_DIR_ROWS * UNI_ROW_GLYPHS;
-				continue;
-			}
-
-			for (j = 0; j < UNI_DIR_ROWS; j++) {
-				p2 = p1[j];
-				if (!p2) {
-					/*
-					 * Account for row of 64 empty entries
-					 */
-					l += UNI_ROW_GLYPHS;
-					continue;
-				}
-
-				for (k = 0; k < UNI_ROW_GLYPHS; k++, l++) {
-					if (p2[k] == 0xffff)
-						continue;
-					/*
-					 * Found one, copy entry for unicode
-					 * l with fontpos value p2[k].
-					 */
-					err1 = con_insert_unipair(q, l, p2[k]);
-					if (err1) {
-						p->refcount++;
-						*vc->vc_uni_pagedir_loc = p;
-						con_release_unimap(q);
-						kfree(q);
-						err = err1;
-						goto out_unlock;
-					}
-				}
-			}
-		}
-
-		/*
-		 * Finished copying font table, set vc_uni_pagedir to new table
-		 */
-		p = q;
 	} else if (p == dflt) {
 		dflt = NULL;
 	}
-- 
2.36.1

