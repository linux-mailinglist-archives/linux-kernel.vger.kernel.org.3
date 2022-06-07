Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED12153FC6C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 12:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242114AbiFGKxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 06:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242344AbiFGKuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 06:50:13 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0902F6892;
        Tue,  7 Jun 2022 03:49:56 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 53E9D1F975;
        Tue,  7 Jun 2022 10:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1654598995; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jGuyYfR3xrhwVD96qOXCK+oM3bpU5xT+JbiivgZ/87A=;
        b=A5RebowsptA6JoT6dBBO/u2bV9uCEubqdJBBwjGMYV/nk9SPoJuRN+Vk7vuuSjo7tbkgVv
        g2hJDHJu+DDz+FxC/r+DXqKpYat40e1qlNoK/j7ZCFCr4pYE3bNrEVpj3SV6QcaEdj4se4
        jn8UVdWqQFx2sOAJzhofyGp2g7IYrfc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1654598995;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jGuyYfR3xrhwVD96qOXCK+oM3bpU5xT+JbiivgZ/87A=;
        b=I6VDfcbmBnTuhbfRpBI5m+M7DVAj1hl0NObf0WfgDfAPJo23WXlx/0w1+6AEBca6vALrF/
        cKSD7VWXLSG6Q9CQ==
Received: from localhost.localdomain (unknown [10.100.201.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 2C5CB2C141;
        Tue,  7 Jun 2022 10:49:55 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 28/36] tty/vt: consolemap: saner variable names in con_get_unimap()
Date:   Tue,  7 Jun 2022 12:49:38 +0200
Message-Id: <20220607104946.18710-28-jslaby@suse.cz>
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

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/vt/consolemap.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/tty/vt/consolemap.c b/drivers/tty/vt/consolemap.c
index dcbeb38a3a0a..b8f2acb6e388 100644
--- a/drivers/tty/vt/consolemap.c
+++ b/drivers/tty/vt/consolemap.c
@@ -773,11 +773,11 @@ EXPORT_SYMBOL(con_copy_unimap);
 int con_get_unimap(struct vc_data *vc, ushort ct, ushort __user *uct,
 		struct unipair __user *list)
 {
-	int i, j, k, ret = 0;
 	ushort ect;
-	u16 **p1, *p2;
-	struct uni_pagedict *p;
+	struct uni_pagedict *dict;
 	struct unipair *unilist;
+	unsigned int d, r, g;
+	int ret = 0;
 
 	unilist = kvmalloc_array(ct, sizeof(*unilist), GFP_KERNEL);
 	if (!unilist)
@@ -786,26 +786,26 @@ int con_get_unimap(struct vc_data *vc, ushort ct, ushort __user *uct,
 	console_lock();
 
 	ect = 0;
-	p = *vc->vc_uni_pagedir_loc;
-	if (!p)
+	dict = *vc->vc_uni_pagedir_loc;
+	if (!dict)
 		goto unlock;
 
-	for (i = 0; i < UNI_DIRS; i++) {
-		p1 = p->uni_pgdir[i];
-		if (!p1)
+	for (d = 0; d < UNI_DIRS; d++) {
+		u16 **dir = dict->uni_pgdir[d];
+		if (!dir)
 			continue;
 
-		for (j = 0; j < UNI_DIR_ROWS; j++, p1++) {
-			p2 = *p1;
-			if (!p2)
+		for (r = 0; r < UNI_DIR_ROWS; r++) {
+			u16 *row = dir[r];
+			if (!row)
 				continue;
 
-			for (k = 0; k < UNI_ROW_GLYPHS; k++, p2++) {
-				if (*p2 >= MAX_GLYPH)
+			for (g = 0; g < UNI_ROW_GLYPHS; g++, row++) {
+				if (*row >= MAX_GLYPH)
 					continue;
 				if (ect < ct) {
-					unilist[ect].unicode = UNI(i, j, k);
-					unilist[ect].fontpos = *p2;
+					unilist[ect].unicode = UNI(d, r, g);
+					unilist[ect].fontpos = *row;
 				}
 				ect++;
 			}
-- 
2.36.1

