Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C912F53FC3A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 12:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241974AbiFGKvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 06:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242321AbiFGKuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 06:50:10 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82DA0F5D39;
        Tue,  7 Jun 2022 03:49:54 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 4298721B7D;
        Tue,  7 Jun 2022 10:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1654598992; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6pM4n+yw9yyaOEqb2V/b1hd+CDwZd6lz0M7nlrv4fz0=;
        b=Y/9z7X6nwtQ0Mze3uemYH0+Djj6DO3BBBrgnYsa5m66FGOQqXOK6oSkyG9G7CK3jbGP577
        YdRdNiyt0RAx1hg0KjeuaM9Iy/EXmWuO9ukxQoNZuTA+xjkzF7NiqpTCg9VIIwMz1LETkD
        T0GNo/3w0QuixCtzejPe1CNSL1ngnmY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1654598992;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6pM4n+yw9yyaOEqb2V/b1hd+CDwZd6lz0M7nlrv4fz0=;
        b=zBcL/ICiZXApOemCd6Lkd9+OrrLGNVbgAcRVKvO0SSkwqj2ByKDaShNKGBr5fd5B+DJSrW
        AT8CNKFVF5kUQWBw==
Received: from localhost.localdomain (unknown [10.100.201.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 1B1412C141;
        Tue,  7 Jun 2022 10:49:52 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 13/36] tty/vt: consolemap: make con_set_unimap() more readable
Date:   Tue,  7 Jun 2022 12:49:23 +0200
Message-Id: <20220607104946.18710-13-jslaby@suse.cz>
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

The indentation was completely broken in con_set_unimap(). Reorder the
code using 'if (!cond) continue;'s so that the code makes sense. Not
that it is perfect now, but it can be followed at least. More cleanup to
come. And remove all those useless whitespaces at the EOLs too.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/vt/consolemap.c | 42 ++++++++++++++++++++-----------------
 1 file changed, 23 insertions(+), 19 deletions(-)

diff --git a/drivers/tty/vt/consolemap.c b/drivers/tty/vt/consolemap.c
index 79a62dcca046..3730a1c0f223 100644
--- a/drivers/tty/vt/consolemap.c
+++ b/drivers/tty/vt/consolemap.c
@@ -580,23 +580,21 @@ int con_set_unimap(struct vc_data *vc, ushort ct, struct unipair __user *list)
 
 	/* Save original vc_unipagdir_loc in case we allocate a new one */
 	p = *vc->vc_uni_pagedir_loc;
-
 	if (!p) {
 		err = -EINVAL;
-
 		goto out_unlock;
 	}
-	
+
 	if (p->refcount > 1) {
 		int j, k;
 		u16 **p1, *p2, l;
-		
+
 		err1 = con_do_clear_unimap(vc);
 		if (err1) {
 			err = err1;
 			goto out_unlock;
 		}
-		
+
 		/*
 		 * Since refcount was > 1, con_clear_unimap() allocated a
 		 * a new uni_pagedict for this vc.  Re: p != q
@@ -611,13 +609,26 @@ int con_set_unimap(struct vc_data *vc, ushort ct, struct unipair __user *list)
 		 */
 		l = 0;		/* unicode value */
 		for (i = 0; i < UNI_DIRS; i++) {
-		p1 = p->uni_pgdir[i];
-		if (p1)
+			p1 = p->uni_pgdir[i];
+			if (!p1) {
+				/* Account for empty table */
+				l += UNI_DIR_ROWS * UNI_ROW_GLYPHS;
+				continue;
+			}
+
 			for (j = 0; j < UNI_DIR_ROWS; j++) {
-			p2 = p1[j];
-			if (p2) {
-				for (k = 0; k < UNI_ROW_GLYPHS; k++, l++)
-				if (p2[k] != 0xffff) {
+				p2 = p1[j];
+				if (!p2) {
+					/*
+					 * Account for row of 64 empty entries
+					 */
+					l += UNI_ROW_GLYPHS;
+					continue;
+				}
+
+				for (k = 0; k < UNI_ROW_GLYPHS; k++, l++) {
+					if (p2[k] == 0xffff)
+						continue;
 					/*
 					 * Found one, copy entry for unicode
 					 * l with fontpos value p2[k].
@@ -632,15 +643,8 @@ int con_set_unimap(struct vc_data *vc, ushort ct, struct unipair __user *list)
 						goto out_unlock;
 					}
 				}
-			} else {
-				/* Account for row of 64 empty entries */
-				l += UNI_ROW_GLYPHS;
 			}
 		}
-		else
-			/* Account for empty table */
-			l += UNI_DIR_ROWS * UNI_ROW_GLYPHS;
-		}
 
 		/*
 		 * Finished copying font table, set vc_uni_pagedir to new table
@@ -658,7 +662,7 @@ int con_set_unimap(struct vc_data *vc, ushort ct, struct unipair __user *list)
 		if (err1)
 			err = err1;
 	}
-	
+
 	/*
 	 * Merge with fontmaps of any other virtual consoles.
 	 */
-- 
2.36.1

