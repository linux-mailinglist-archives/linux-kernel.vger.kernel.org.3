Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14CB853FC53
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 12:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241968AbiFGKv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 06:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242294AbiFGKuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 06:50:10 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA4B0F5D2A;
        Tue,  7 Jun 2022 03:49:53 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 73DCE1F947;
        Tue,  7 Jun 2022 10:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1654598992; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ohnEP+nL9zu+kNTfASALTCtdfLwjHJjIIFhCV5IA58Y=;
        b=Hlu7nuWNt1KpOwffhiJvZKwcOG+9vO7ERJ9M0dZaRgj8BWHvVQGfaCzKxDMgJzghFat9bA
        iRe/paj+V5JeXN3sVi1lMhaqiOoDs/dS9aX4CCB54koBgTw/6iTplRb7mlwWaJX2z577sC
        eKDwFwCv8CSH1H5m3aeLJdUjW+bMfPM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1654598992;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ohnEP+nL9zu+kNTfASALTCtdfLwjHJjIIFhCV5IA58Y=;
        b=WjSj9fnbevFuPhVZDk+B8mwuUOoQCi6cYGOhJ85qzH9vksdNNloReGNrSpdppzqrIA0zlc
        FJDtZe0UYFCvsUAw==
Received: from localhost.localdomain (unknown [10.100.201.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 4C3172C142;
        Tue,  7 Jun 2022 10:49:52 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 14/36] tty/vt: consolemap: make con_get_unimap() more readable
Date:   Tue,  7 Jun 2022 12:49:24 +0200
Message-Id: <20220607104946.18710-14-jslaby@suse.cz>
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

The indentation is completely broken in con_get_unimap(). Reorder the
code using "if (!cond) continue;"s so that the code makes sense. Switch
also the "p" assignment and add a short path using goto. This makes the
code readable again.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/vt/consolemap.c | 38 +++++++++++++++++++++----------------
 1 file changed, 22 insertions(+), 16 deletions(-)

diff --git a/drivers/tty/vt/consolemap.c b/drivers/tty/vt/consolemap.c
index 3730a1c0f223..84c8043a36d0 100644
--- a/drivers/tty/vt/consolemap.c
+++ b/drivers/tty/vt/consolemap.c
@@ -768,7 +768,8 @@ EXPORT_SYMBOL(con_copy_unimap);
  *	Read the console unicode data for this console. Called from the ioctl
  *	handlers.
  */
-int con_get_unimap(struct vc_data *vc, ushort ct, ushort __user *uct, struct unipair __user *list)
+int con_get_unimap(struct vc_data *vc, ushort ct, ushort __user *uct,
+		struct unipair __user *list)
 {
 	int i, j, k, ret = 0;
 	ushort ect;
@@ -783,27 +784,32 @@ int con_get_unimap(struct vc_data *vc, ushort ct, ushort __user *uct, struct uni
 	console_lock();
 
 	ect = 0;
-	if (*vc->vc_uni_pagedir_loc) {
-		p = *vc->vc_uni_pagedir_loc;
-		for (i = 0; i < UNI_DIRS; i++) {
+	p = *vc->vc_uni_pagedir_loc;
+	if (!p)
+		goto unlock;
+
+	for (i = 0; i < UNI_DIRS; i++) {
 		p1 = p->uni_pgdir[i];
-		if (p1)
-			for (j = 0; j < UNI_DIR_ROWS; j++) {
+		if (!p1)
+			continue;
+
+		for (j = 0; j < UNI_DIR_ROWS; j++) {
 			p2 = *(p1++);
-			if (p2)
-				for (k = 0; k < UNI_ROW_GLYPHS; k++, p2++) {
-					if (*p2 >= MAX_GLYPH)
-						continue;
-					if (ect < ct) {
-						unilist[ect].unicode =
-							UNI(i, j, k);
-						unilist[ect].fontpos = *p2;
-					}
-					ect++;
+			if (!p2)
+				continue;
+
+			for (k = 0; k < UNI_ROW_GLYPHS; k++, p2++) {
+				if (*p2 >= MAX_GLYPH)
+					continue;
+				if (ect < ct) {
+					unilist[ect].unicode = UNI(i, j, k);
+					unilist[ect].fontpos = *p2;
 				}
+				ect++;
 			}
 		}
 	}
+unlock:
 	console_unlock();
 	if (copy_to_user(list, unilist, min(ect, ct) * sizeof(*unilist)))
 		ret = -EFAULT;
-- 
2.36.1

