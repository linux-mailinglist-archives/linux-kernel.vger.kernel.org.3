Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 575EC53FC5E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 12:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242160AbiFGKwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 06:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242327AbiFGKuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 06:50:11 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A174BF6883;
        Tue,  7 Jun 2022 03:49:55 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 1BE921F96B;
        Tue,  7 Jun 2022 10:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1654598994; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hwJN12YthJDU68146kZR92ohRxVhV3gfadQ2wuLghrY=;
        b=CzOfiWKOtfKCtczyrahDtSNYT3k667QMXzRhAeHuEIkKWCO1LwJ8ATyNQgFsofAVhaKqPS
        a76CWd2+iqQkKJ1xKIQXik0vFB5dN4jy5g9n/wgwXjLCD8zCPvViED5B2owYmLxYRNZHJ1
        Z6ASmDAiuy57Rdz/AySNpRRZp7GGzyc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1654598994;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hwJN12YthJDU68146kZR92ohRxVhV3gfadQ2wuLghrY=;
        b=Iwyzx20Ck8XWeNIU8HrCR9EV1vq00WngGvumW05utsEzXxJO16hhPIPNM7qBatnroZ2LcE
        MTup8zK5JWyegrDQ==
Received: from localhost.localdomain (unknown [10.100.201.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id E4B552C141;
        Tue,  7 Jun 2022 10:49:53 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 22/36] tty/vt: consolemap: saner variable names in con_insert_unipair()
Date:   Tue,  7 Jun 2022 12:49:32 +0200
Message-Id: <20220607104946.18710-22-jslaby@suse.cz>
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
 drivers/tty/vt/consolemap.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/tty/vt/consolemap.c b/drivers/tty/vt/consolemap.c
index 374b1ba20635..2454a4395722 100644
--- a/drivers/tty/vt/consolemap.c
+++ b/drivers/tty/vt/consolemap.c
@@ -499,31 +499,31 @@ static int con_unify_unimap(struct vc_data *conp, struct uni_pagedict *p)
 static int
 con_insert_unipair(struct uni_pagedict *p, u_short unicode, u_short fontpos)
 {
-	int n;
-	u16 **p1, *p2;
+	u16 **dir, *row;
+	unsigned int n;
 
 	n = UNI_DIR(unicode);
-	p1 = p->uni_pgdir[n];
-	if (!p1) {
-		p1 = p->uni_pgdir[n] = kcalloc(UNI_DIR_ROWS, sizeof(*p1),
+	dir = p->uni_pgdir[n];
+	if (!dir) {
+		dir = p->uni_pgdir[n] = kcalloc(UNI_DIR_ROWS, sizeof(*dir),
 				GFP_KERNEL);
-		if (!p1)
+		if (!dir)
 			return -ENOMEM;
 	}
 
 	n = UNI_ROW(unicode);
-	p2 = p1[n];
-	if (!p2) {
-		p2 = p1[n] = kmalloc_array(UNI_ROW_GLYPHS, sizeof(*p2),
+	row = dir[n];
+	if (!row) {
+		row = dir[n] = kmalloc_array(UNI_ROW_GLYPHS, sizeof(*row),
 				GFP_KERNEL);
-		if (!p2)
+		if (!row)
 			return -ENOMEM;
 		/* No glyphs for the characters (yet) */
-		memset(p2, 0xff, UNI_ROW_GLYPHS * sizeof(*p2));
+		memset(row, 0xff, UNI_ROW_GLYPHS * sizeof(*row));
 	}
 
-	p2[UNI_GLYPH(unicode)] = fontpos;
-	
+	row[UNI_GLYPH(unicode)] = fontpos;
+
 	p->sum += (fontpos << 20U) + unicode;
 
 	return 0;
-- 
2.36.1

