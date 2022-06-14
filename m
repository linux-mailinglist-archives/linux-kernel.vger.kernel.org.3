Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16E1354AB57
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 10:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355553AbiFNH5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 03:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355376AbiFNH5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 03:57:18 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 603083F880;
        Tue, 14 Jun 2022 00:57:17 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id DEF5221B79;
        Tue, 14 Jun 2022 07:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655193435; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2AxZ7ba4vFf6anCtaU0j/Fe8d5VkOuAG9PEieormBNI=;
        b=3JuFNGuqvtS5bQENM1CYXk8i6UueJdqzglMD4fxagmgpRQnWKwy92D8l1Vv2YYDxV+VIpj
        QcX6RkhGFAoXmBEcF8igr2E+d/BjbotBA0rMDfSTbT4FqGToBQC8bXLTUENbG3rJOvJTYW
        JrXrchmPsI1dOTs+Qw3uSAltJFtZBLE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655193435;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2AxZ7ba4vFf6anCtaU0j/Fe8d5VkOuAG9PEieormBNI=;
        b=Y/zz/+9A8qdco5Y6wHyTF8jZhtg/MWow8HSTDQ61pxXynoLtExZU1/h2+fI7AWSXSi0wqc
        +7NPjNXF0Hc1X5Cg==
Received: from localhost.localdomain (unknown [10.100.201.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 814482C141;
        Tue, 14 Jun 2022 07:57:15 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 5/7] tty/vt: consolemap: rename struct vc_data::vc_uni_pagedir*
Date:   Tue, 14 Jun 2022 09:57:11 +0200
Message-Id: <20220614075713.32767-5-jslaby@suse.cz>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220614075713.32767-1-jslaby@suse.cz>
References: <20220614075713.32767-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

As a follow-up to the commit 4173f018aae1 (tty/vt: consolemap: rename
and document struct uni_pagedir), rename also the members of struct
vc_data. I.e. pagedir -> pagedict. And while touching all the places,
remove also the unnecessary vc_ prefix.

Suggested-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/vt/consolemap.c             | 46 ++++++++++++-------------
 drivers/tty/vt/vt.c                     |  8 ++---
 drivers/usb/misc/sisusbvga/sisusb_con.c |  2 +-
 drivers/video/console/vgacon.c          |  8 ++---
 drivers/video/fbdev/core/fbcon.c        |  8 ++---
 include/linux/console_struct.h          |  4 +--
 6 files changed, 38 insertions(+), 38 deletions(-)

diff --git a/drivers/tty/vt/consolemap.c b/drivers/tty/vt/consolemap.c
index 3d0e10dac6d9..16d0d8f04f0e 100644
--- a/drivers/tty/vt/consolemap.c
+++ b/drivers/tty/vt/consolemap.c
@@ -296,7 +296,7 @@ u16 inverse_translate(const struct vc_data *conp, u16 glyph, bool use_unicode)
 	if (glyph >= MAX_GLYPH)
 		return 0;
 
-	p = *conp->vc_uni_pagedir_loc;
+	p = *conp->uni_pagedict_loc;
 	if (!p)
 		return glyph;
 
@@ -323,7 +323,7 @@ static void update_user_maps(void)
 	for (i = 0; i < MAX_NR_CONSOLES; i++) {
 		if (!vc_cons_allocated(i))
 			continue;
-		p = *vc_cons[i].d->vc_uni_pagedir_loc;
+		p = *vc_cons[i].d->uni_pagedict_loc;
 		if (p && p != q) {
 			set_inverse_transl(vc_cons[i].d, p, USER_MAP);
 			set_inverse_trans_unicode(p);
@@ -445,10 +445,10 @@ void con_free_unimap(struct vc_data *vc)
 {
 	struct uni_pagedict *p;
 
-	p = *vc->vc_uni_pagedir_loc;
+	p = *vc->uni_pagedict_loc;
 	if (!p)
 		return;
-	*vc->vc_uni_pagedir_loc = NULL;
+	*vc->uni_pagedict_loc = NULL;
 	if (--p->refcount)
 		return;
 	con_release_unimap(p);
@@ -463,7 +463,7 @@ static int con_unify_unimap(struct vc_data *conp, struct uni_pagedict *dict1)
 	for (cons = 0; cons < MAX_NR_CONSOLES; cons++) {
 		if (!vc_cons_allocated(cons))
 			continue;
-		dict2 = *vc_cons[cons].d->vc_uni_pagedir_loc;
+		dict2 = *vc_cons[cons].d->uni_pagedict_loc;
 		if (!dict2 || dict2 == dict1 || dict2->sum != dict1->sum)
 			continue;
 		for (d = 0; d < UNI_DIRS; d++) {
@@ -487,7 +487,7 @@ static int con_unify_unimap(struct vc_data *conp, struct uni_pagedict *dict1)
 		}
 		if (d == UNI_DIRS) {
 			dict2->refcount++;
-			*conp->vc_uni_pagedir_loc = dict2;
+			*conp->uni_pagedict_loc = dict2;
 			con_release_unimap(dict1);
 			kfree(dict1);
 			return 1;
@@ -531,14 +531,14 @@ con_insert_unipair(struct uni_pagedict *p, u_short unicode, u_short fontpos)
 
 static int con_allocate_new(struct vc_data *vc)
 {
-	struct uni_pagedict *new, *old = *vc->vc_uni_pagedir_loc;
+	struct uni_pagedict *new, *old = *vc->uni_pagedict_loc;
 
 	new = kzalloc(sizeof(*new), GFP_KERNEL);
 	if (!new)
 		return -ENOMEM;
 
 	new->refcount = 1;
-	*vc->vc_uni_pagedir_loc = new;
+	*vc->uni_pagedict_loc = new;
 
 	if (old)
 		old->refcount--;
@@ -549,7 +549,7 @@ static int con_allocate_new(struct vc_data *vc)
 /* Caller must hold the lock */
 static int con_do_clear_unimap(struct vc_data *vc)
 {
-	struct uni_pagedict *old = *vc->vc_uni_pagedir_loc;
+	struct uni_pagedict *old = *vc->uni_pagedict_loc;
 
 	if (!old || old->refcount > 1)
 		return con_allocate_new(vc);
@@ -583,7 +583,7 @@ static struct uni_pagedict *con_unshare_unimap(struct vc_data *vc,
 	if (ret)
 		return ERR_PTR(ret);
 
-	new = *vc->vc_uni_pagedir_loc;
+	new = *vc->uni_pagedict_loc;
 
 	/*
 	 * uni_pgdir is a 32*32*64 table with rows allocated when its first
@@ -616,7 +616,7 @@ static struct uni_pagedict *con_unshare_unimap(struct vc_data *vc,
 				ret = con_insert_unipair(new, uni, row[g]);
 				if (ret) {
 					old->refcount++;
-					*vc->vc_uni_pagedir_loc = old;
+					*vc->uni_pagedict_loc = old;
 					con_release_unimap(new);
 					kfree(new);
 					return ERR_PTR(ret);
@@ -644,7 +644,7 @@ int con_set_unimap(struct vc_data *vc, ushort ct, struct unipair __user *list)
 	console_lock();
 
 	/* Save original vc_unipagdir_loc in case we allocate a new one */
-	dict = *vc->vc_uni_pagedir_loc;
+	dict = *vc->uni_pagedict_loc;
 	if (!dict) {
 		err = -EINVAL;
 		goto out_unlock;
@@ -704,12 +704,12 @@ int con_set_default_unimap(struct vc_data *vc)
 	u16 *dfont;
 
 	if (dflt) {
-		dict = *vc->vc_uni_pagedir_loc;
+		dict = *vc->uni_pagedict_loc;
 		if (dict == dflt)
 			return 0;
 
 		dflt->refcount++;
-		*vc->vc_uni_pagedir_loc = dflt;
+		*vc->uni_pagedict_loc = dflt;
 		if (dict && !--dict->refcount) {
 			con_release_unimap(dict);
 			kfree(dict);
@@ -723,7 +723,7 @@ int con_set_default_unimap(struct vc_data *vc)
 	if (err)
 		return err;
 
-	dict = *vc->vc_uni_pagedir_loc;
+	dict = *vc->uni_pagedict_loc;
 	dfont = dfont_unitable;
 
 	for (fontpos = 0; fontpos < 256U; fontpos++)
@@ -734,7 +734,7 @@ int con_set_default_unimap(struct vc_data *vc)
 		}
 
 	if (con_unify_unimap(vc, dict)) {
-		dflt = *vc->vc_uni_pagedir_loc;
+		dflt = *vc->uni_pagedict_loc;
 		return err;
 	}
 
@@ -757,14 +757,14 @@ int con_copy_unimap(struct vc_data *dst_vc, struct vc_data *src_vc)
 {
 	struct uni_pagedict *src;
 
-	if (!*src_vc->vc_uni_pagedir_loc)
+	if (!*src_vc->uni_pagedict_loc)
 		return -EINVAL;
-	if (*dst_vc->vc_uni_pagedir_loc == *src_vc->vc_uni_pagedir_loc)
+	if (*dst_vc->uni_pagedict_loc == *src_vc->uni_pagedict_loc)
 		return 0;
 	con_free_unimap(dst_vc);
-	src = *src_vc->vc_uni_pagedir_loc;
+	src = *src_vc->uni_pagedict_loc;
 	src->refcount++;
-	*dst_vc->vc_uni_pagedir_loc = src;
+	*dst_vc->uni_pagedict_loc = src;
 	return 0;
 }
 EXPORT_SYMBOL(con_copy_unimap);
@@ -791,7 +791,7 @@ int con_get_unimap(struct vc_data *vc, ushort ct, ushort __user *uct,
 	console_lock();
 
 	ect = 0;
-	dict = *vc->vc_uni_pagedir_loc;
+	dict = *vc->uni_pagedict_loc;
 	if (!dict)
 		goto unlock;
 
@@ -873,7 +873,7 @@ int conv_uni_to_pc(struct vc_data *conp, long ucs)
 	else if ((ucs & ~UNI_DIRECT_MASK) == UNI_DIRECT_BASE)
 		return ucs & UNI_DIRECT_MASK;
 
-	dict = *conp->vc_uni_pagedir_loc;
+	dict = *conp->uni_pagedict_loc;
 	if (!dict)
 		return -3;
 
@@ -903,7 +903,7 @@ console_map_init(void)
 	int i;
 
 	for (i = 0; i < MAX_NR_CONSOLES; i++)
-		if (vc_cons_allocated(i) && !*vc_cons[i].d->vc_uni_pagedir_loc)
+		if (vc_cons_allocated(i) && !*vc_cons[i].d->uni_pagedict_loc)
 			con_set_default_unimap(vc_cons[i].d);
 }
 
diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index c718b0d01e3d..1899b8a5d73e 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -1063,10 +1063,10 @@ static void visual_init(struct vc_data *vc, int num, int init)
 	__module_get(vc->vc_sw->owner);
 	vc->vc_num = num;
 	vc->vc_display_fg = &master_display_fg;
-	if (vc->vc_uni_pagedir_loc)
+	if (vc->uni_pagedict_loc)
 		con_free_unimap(vc);
-	vc->vc_uni_pagedir_loc = &vc->vc_uni_pagedir;
-	vc->vc_uni_pagedir = NULL;
+	vc->uni_pagedict_loc = &vc->uni_pagedict;
+	vc->uni_pagedict = NULL;
 	vc->vc_hi_font_mask = 0;
 	vc->vc_complement_mask = 0;
 	vc->vc_can_do_color = 0;
@@ -1136,7 +1136,7 @@ int vc_allocate(unsigned int currcons)	/* return 0 on success */
 
 	visual_init(vc, currcons, 1);
 
-	if (!*vc->vc_uni_pagedir_loc)
+	if (!*vc->uni_pagedict_loc)
 		con_set_default_unimap(vc);
 
 	err = -EINVAL;
diff --git a/drivers/usb/misc/sisusbvga/sisusb_con.c b/drivers/usb/misc/sisusbvga/sisusb_con.c
index dfa0d5ce6012..fcb95fb639e0 100644
--- a/drivers/usb/misc/sisusbvga/sisusb_con.c
+++ b/drivers/usb/misc/sisusbvga/sisusb_con.c
@@ -248,7 +248,7 @@ sisusbcon_init(struct vc_data *c, int init)
 	 */
 	kref_get(&sisusb->kref);
 
-	if (!*c->vc_uni_pagedir_loc)
+	if (!*c->uni_pagedict_loc)
 		con_set_default_unimap(c);
 
 	mutex_unlock(&sisusb->lock);
diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgacon.c
index 058a78b8dbcf..fcdf017e2665 100644
--- a/drivers/video/console/vgacon.c
+++ b/drivers/video/console/vgacon.c
@@ -367,10 +367,10 @@ static void vgacon_init(struct vc_data *c, int init)
 	c->vc_complement_mask = 0x7700;
 	if (vga_512_chars)
 		c->vc_hi_font_mask = 0x0800;
-	p = *c->vc_uni_pagedir_loc;
-	if (c->vc_uni_pagedir_loc != &vgacon_uni_pagedir) {
+	p = *c->uni_pagedict_loc;
+	if (c->uni_pagedict_loc != &vgacon_uni_pagedir) {
 		con_free_unimap(c);
-		c->vc_uni_pagedir_loc = &vgacon_uni_pagedir;
+		c->uni_pagedict_loc = &vgacon_uni_pagedir;
 		vgacon_refcount++;
 	}
 	if (!vgacon_uni_pagedir && p)
@@ -392,7 +392,7 @@ static void vgacon_deinit(struct vc_data *c)
 
 	if (!--vgacon_refcount)
 		con_free_unimap(c);
-	c->vc_uni_pagedir_loc = &c->vc_uni_pagedir;
+	c->uni_pagedict_loc = &c->uni_pagedict;
 	con_set_default_unimap(c);
 }
 
diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 1be8aa9f8074..238a136c0e11 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -1060,9 +1060,9 @@ static void fbcon_init(struct vc_data *vc, int init)
 			vc->vc_complement_mask <<= 1;
 	}
 
-	if (!*svc->vc_uni_pagedir_loc)
+	if (!*svc->uni_pagedict_loc)
 		con_set_default_unimap(svc);
-	if (!*vc->vc_uni_pagedir_loc)
+	if (!*vc->uni_pagedict_loc)
 		con_copy_unimap(vc, svc);
 
 	ops = info->fbcon_par;
@@ -1384,9 +1384,9 @@ static void fbcon_set_disp(struct fb_info *info, struct fb_var_screeninfo *var,
 			vc->vc_complement_mask <<= 1;
 	}
 
-	if (!*svc->vc_uni_pagedir_loc)
+	if (!*svc->uni_pagedict_loc)
 		con_set_default_unimap(svc);
-	if (!*vc->vc_uni_pagedir_loc)
+	if (!*vc->uni_pagedict_loc)
 		con_copy_unimap(vc, svc);
 
 	cols = FBCON_SWAP(ops->rotate, info->var.xres, info->var.yres);
diff --git a/include/linux/console_struct.h b/include/linux/console_struct.h
index f75033f0277f..1518568aaf0f 100644
--- a/include/linux/console_struct.h
+++ b/include/linux/console_struct.h
@@ -157,8 +157,8 @@ struct vc_data {
 	unsigned int	vc_bell_duration;	/* Console bell duration */
 	unsigned short	vc_cur_blink_ms;	/* Cursor blink duration */
 	struct vc_data **vc_display_fg;		/* [!] Ptr to var holding fg console for this display */
-	struct uni_pagedict *vc_uni_pagedir;
-	struct uni_pagedict **vc_uni_pagedir_loc; /* [!] Location of uni_pagedict variable for this console */
+	struct uni_pagedict *uni_pagedict;
+	struct uni_pagedict **uni_pagedict_loc; /* [!] Location of uni_pagedict variable for this console */
 	struct uni_screen *vc_uni_screen;	/* unicode screen content */
 	/* additional information is in vt_kern.h */
 };
-- 
2.36.1

