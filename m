Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA2F353FC2C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 12:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241712AbiFGKu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 06:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242317AbiFGKuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 06:50:10 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBF5DF5D2D;
        Tue,  7 Jun 2022 03:49:53 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id A412521B74;
        Tue,  7 Jun 2022 10:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1654598991; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yHXv1W0yms3pLjsfFsLZlzWkz4tUdT8hPb32nt+N+2E=;
        b=gwdvAaDXADOv56F8UlwFd0hepS6YqmANqyx1bDJy9pBQfzYbUlvxHR8iGh8XOfgP7qUK1M
        j0MATSZCQBeHAf71TOY2GoAIkclbKSstQc8LCk0tf0qboxxojdKW5n9zgvzqEiLqkQC37I
        5JGFLmceygaJ1GGKyIhoq/qiaQIs7jg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1654598991;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yHXv1W0yms3pLjsfFsLZlzWkz4tUdT8hPb32nt+N+2E=;
        b=u8uuKWHZPNh+l5aomCi3qe/cZdViIqictqEv81VGBWNGem8TnQVq7jWglZXVzdggXPCLqu
        dHIst/eBuiKfGOBQ==
Received: from localhost.localdomain (unknown [10.100.201.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 7B5DB2C142;
        Tue,  7 Jun 2022 10:49:51 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 10/36] tty/vt: consolemap: introduce UNI_*() macros
Date:   Tue,  7 Jun 2022 12:49:20 +0200
Message-Id: <20220607104946.18710-10-jslaby@suse.cz>
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

The code currently does shift, OR, and AND logic directly in the code.
It is not much obvious what happens there. Therefore define four macros
for that purpose and use them in the code. We use GENMASK() so that it
is clear which bits serve what purpose:
- UNI_GLYPH: bits  0.. 5
- UNI_ROW:   bits  6..10
- UNI_DIR:   bits 11..31

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/vt/consolemap.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/vt/consolemap.c b/drivers/tty/vt/consolemap.c
index 016c1a0b4290..e5fd225e87bd 100644
--- a/drivers/tty/vt/consolemap.c
+++ b/drivers/tty/vt/consolemap.c
@@ -190,6 +190,11 @@ static int inv_translate[MAX_NR_CONSOLES];
 #define UNI_DIR_ROWS	32U
 #define UNI_ROW_GLYPHS	64U
 
+#define UNI_DIR(uni)		( (uni)                   >> 11)
+#define UNI_ROW(uni)		(((uni) & GENMASK(10, 6)) >>  6)
+#define UNI_GLYPH(uni)		( (uni) & GENMASK( 5, 0))
+#define UNI(dir, row, glyph)	(((dir) << 11) | ((row) << 6) | (glyph))
+
 /**
  * struct uni_pagedict -- unicode directory
  *
@@ -265,7 +270,7 @@ static void set_inverse_trans_unicode(struct vc_data *conp,
 				glyph = p2[k];
 				if (glyph >= 0 && glyph < MAX_GLYPH
 					       && q[glyph] < 32)
-					q[glyph] = (i << 11) | (j << 6) | k;
+					q[glyph] = UNI(i, j, k);
 			}
 		}
 	}
@@ -497,7 +502,7 @@ con_insert_unipair(struct uni_pagedict *p, u_short unicode, u_short fontpos)
 	int i, n;
 	u16 **p1, *p2;
 
-	n = unicode >> 11;
+	n = UNI_DIR(unicode);
 	p1 = p->uni_pgdir[n];
 	if (!p1) {
 		p1 = p->uni_pgdir[n] = kmalloc_array(UNI_DIR_ROWS,
@@ -508,7 +513,7 @@ con_insert_unipair(struct uni_pagedict *p, u_short unicode, u_short fontpos)
 			p1[i] = NULL;
 	}
 
-	n = (unicode >> 6) & 0x1f;
+	n = UNI_ROW(unicode);
 	p2 = p1[n];
 	if (!p2) {
 		p2 = p1[n] = kmalloc_array(UNI_ROW_GLYPHS, sizeof(u16), GFP_KERNEL);
@@ -518,7 +523,7 @@ con_insert_unipair(struct uni_pagedict *p, u_short unicode, u_short fontpos)
 		memset(p2, 0xff, UNI_ROW_GLYPHS * sizeof(u16));
 	}
 
-	p2[unicode & 0x3f] = fontpos;
+	p2[UNI_GLYPH(unicode)] = fontpos;
 	
 	p->sum += (fontpos << 20U) + unicode;
 
@@ -788,7 +793,7 @@ int con_get_unimap(struct vc_data *vc, ushort ct, ushort __user *uct, struct uni
 						continue;
 					if (ect < ct) {
 						unilist[ect].unicode =
-							(i<<11) | (j<<6) | k;
+							UNI(i, j, k);
 						unilist[ect].fontpos = *p2;
 					}
 					ect++;
@@ -857,9 +862,9 @@ conv_uni_to_pc(struct vc_data *conp, long ucs)
 		return -3;
 
 	p = *conp->vc_uni_pagedir_loc;
-	if ((p1 = p->uni_pgdir[ucs >> 11]) &&
-	    (p2 = p1[(ucs >> 6) & 0x1f]) &&
-	    (h = p2[ucs & 0x3f]) < MAX_GLYPH)
+	if ((p1 = p->uni_pgdir[UNI_DIR(ucs)]) &&
+	    (p2 = p1[UNI_ROW(ucs)]) &&
+	    (h = p2[UNI_GLYPH(ucs)]) < MAX_GLYPH)
 		return h;
 
 	return -4;		/* not found */
-- 
2.36.1

