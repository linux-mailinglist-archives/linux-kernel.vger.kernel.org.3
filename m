Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE6F153FC52
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 12:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241925AbiFGKvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 06:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242301AbiFGKuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 06:50:10 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 518CE954B2;
        Tue,  7 Jun 2022 03:49:51 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 0D2D121B50;
        Tue,  7 Jun 2022 10:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1654598990; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5kqrpCsOLVF1AxkwdvubO7QiXGz3rf1+uN85hfJNgUs=;
        b=K0DxCYS/o7vfIURqXOqEnt435OI3SpcPOha7QszEXDI7ZX5vn5ngl4TM8+G8NbPoTada0d
        Sw9PRYzFcJZNB7HmPzywiwVKZOSUQ7loTu7aJx8ilkHfnalIPFlc9w7nrcNk1aWYrRglHJ
        WGMvv8SfTpPUn5UmV4Jp/mb85cds8uA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1654598990;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5kqrpCsOLVF1AxkwdvubO7QiXGz3rf1+uN85hfJNgUs=;
        b=XXgq5+fxy56sn4gWEjMmC2YLUTQCibwGuQgsget+cSHhaFzp3x8UG7qbRdE/UZZyuW8V6r
        T8zfiDvR74W6P1DQ==
Received: from localhost.localdomain (unknown [10.100.201.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id D41722C142;
        Tue,  7 Jun 2022 10:49:49 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 02/36] tty/vt: consolemap: rename and document struct uni_pagedir
Date:   Tue,  7 Jun 2022 12:49:12 +0200
Message-Id: <20220607104946.18710-2-jslaby@suse.cz>
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

struct uni_pagedir contains 32 unicode page directories, so the name of
the structure is a bit misleading. Rename the structure to uni_pagedict,
so it looks like this:
struct uni_pagedict
  -> 32 page dirs
     -> 32 rows
       -> 64 glyphs

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/vt/consolemap.c    | 47 ++++++++++++++++++++--------------
 drivers/video/console/vgacon.c |  4 +--
 include/linux/console_struct.h |  6 ++---
 3 files changed, 33 insertions(+), 24 deletions(-)

diff --git a/drivers/tty/vt/consolemap.c b/drivers/tty/vt/consolemap.c
index 839d75d1a6c0..5acafeea9afc 100644
--- a/drivers/tty/vt/consolemap.c
+++ b/drivers/tty/vt/consolemap.c
@@ -186,17 +186,26 @@ static unsigned short translations[][256] = {
 
 static int inv_translate[MAX_NR_CONSOLES];
 
-struct uni_pagedir {
-	u16 		**uni_pgdir[32];
+/**
+ * struct uni_pagedict -- unicode directory
+ *
+ * @uni_pgdir: 32*32*64 table with glyphs
+ * @refcount: reference count of this structure
+ * @sum: checksum
+ * @inverse_translations: best-effort inverse mapping
+ * @inverse_trans_unicode: best-effort inverse mapping to unicode
+ */
+struct uni_pagedict {
+	u16		**uni_pgdir[32];
 	unsigned long	refcount;
 	unsigned long	sum;
 	unsigned char	*inverse_translations[4];
 	u16		*inverse_trans_unicode;
 };
 
-static struct uni_pagedir *dflt;
+static struct uni_pagedict *dflt;
 
-static void set_inverse_transl(struct vc_data *conp, struct uni_pagedir *p, int i)
+static void set_inverse_transl(struct vc_data *conp, struct uni_pagedict *p, int i)
 {
 	int j, glyph;
 	unsigned short *t = translations[i];
@@ -221,7 +230,7 @@ static void set_inverse_transl(struct vc_data *conp, struct uni_pagedir *p, int
 }
 
 static void set_inverse_trans_unicode(struct vc_data *conp,
-				      struct uni_pagedir *p)
+				      struct uni_pagedict *p)
 {
 	int i, j, k, glyph;
 	u16 **p1, *p2;
@@ -270,7 +279,7 @@ unsigned short *set_translate(int m, struct vc_data *vc)
  */
 u16 inverse_translate(const struct vc_data *conp, int glyph, int use_unicode)
 {
-	struct uni_pagedir *p;
+	struct uni_pagedict *p;
 	int m;
 	if (glyph < 0 || glyph >= MAX_GLYPH)
 		return 0;
@@ -297,7 +306,7 @@ EXPORT_SYMBOL_GPL(inverse_translate);
 static void update_user_maps(void)
 {
 	int i;
-	struct uni_pagedir *p, *q = NULL;
+	struct uni_pagedict *p, *q = NULL;
 	
 	for (i = 0; i < MAX_NR_CONSOLES; i++) {
 		if (!vc_cons_allocated(i))
@@ -393,7 +402,7 @@ int con_get_trans_new(ushort __user * arg)
 extern u8 dfont_unicount[];	/* Defined in console_defmap.c */
 extern u16 dfont_unitable[];
 
-static void con_release_unimap(struct uni_pagedir *p)
+static void con_release_unimap(struct uni_pagedict *p)
 {
 	u16 **p1;
 	int i, j;
@@ -419,7 +428,7 @@ static void con_release_unimap(struct uni_pagedir *p)
 /* Caller must hold the console lock */
 void con_free_unimap(struct vc_data *vc)
 {
-	struct uni_pagedir *p;
+	struct uni_pagedict *p;
 
 	p = *vc->vc_uni_pagedir_loc;
 	if (!p)
@@ -431,10 +440,10 @@ void con_free_unimap(struct vc_data *vc)
 	kfree(p);
 }
   
-static int con_unify_unimap(struct vc_data *conp, struct uni_pagedir *p)
+static int con_unify_unimap(struct vc_data *conp, struct uni_pagedict *p)
 {
 	int i, j, k;
-	struct uni_pagedir *q;
+	struct uni_pagedict *q;
 	
 	for (i = 0; i < MAX_NR_CONSOLES; i++) {
 		if (!vc_cons_allocated(i))
@@ -472,7 +481,7 @@ static int con_unify_unimap(struct vc_data *conp, struct uni_pagedir *p)
 }
 
 static int
-con_insert_unipair(struct uni_pagedir *p, u_short unicode, u_short fontpos)
+con_insert_unipair(struct uni_pagedict *p, u_short unicode, u_short fontpos)
 {
 	int i, n;
 	u16 **p1, *p2;
@@ -503,7 +512,7 @@ con_insert_unipair(struct uni_pagedir *p, u_short unicode, u_short fontpos)
 /* Caller must hold the lock */
 static int con_do_clear_unimap(struct vc_data *vc)
 {
-	struct uni_pagedir *p, *q;
+	struct uni_pagedict *p, *q;
 
 	p = *vc->vc_uni_pagedir_loc;
 	if (!p || --p->refcount) {
@@ -536,7 +545,7 @@ int con_clear_unimap(struct vc_data *vc)
 int con_set_unimap(struct vc_data *vc, ushort ct, struct unipair __user *list)
 {
 	int err = 0, err1, i;
-	struct uni_pagedir *p, *q;
+	struct uni_pagedict *p, *q;
 	struct unipair *unilist, *plist;
 
 	if (!ct)
@@ -569,7 +578,7 @@ int con_set_unimap(struct vc_data *vc, ushort ct, struct unipair __user *list)
 		
 		/*
 		 * Since refcount was > 1, con_clear_unimap() allocated a
-		 * a new uni_pagedir for this vc.  Re: p != q
+		 * a new uni_pagedict for this vc.  Re: p != q
 		 */
 		q = *vc->vc_uni_pagedir_loc;
 
@@ -660,7 +669,7 @@ int con_set_default_unimap(struct vc_data *vc)
 {
 	int i, j, err = 0, err1;
 	u16 *q;
-	struct uni_pagedir *p;
+	struct uni_pagedict *p;
 
 	if (dflt) {
 		p = *vc->vc_uni_pagedir_loc;
@@ -714,7 +723,7 @@ EXPORT_SYMBOL(con_set_default_unimap);
  */
 int con_copy_unimap(struct vc_data *dst_vc, struct vc_data *src_vc)
 {
-	struct uni_pagedir *q;
+	struct uni_pagedict *q;
 
 	if (!*src_vc->vc_uni_pagedir_loc)
 		return -EINVAL;
@@ -739,7 +748,7 @@ int con_get_unimap(struct vc_data *vc, ushort ct, ushort __user *uct, struct uni
 	int i, j, k, ret = 0;
 	ushort ect;
 	u16 **p1, *p2;
-	struct uni_pagedir *p;
+	struct uni_pagedict *p;
 	struct unipair *unilist;
 
 	unilist = kvmalloc_array(ct, sizeof(struct unipair), GFP_KERNEL);
@@ -810,7 +819,7 @@ conv_uni_to_pc(struct vc_data *conp, long ucs)
 {
 	int h;
 	u16 **p1, *p2;
-	struct uni_pagedir *p;
+	struct uni_pagedict *p;
   
 	/* Only 16-bit codes supported at this time */
 	if (ucs > 0xffff)
diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgacon.c
index 576612f18d59..058a78b8dbcf 100644
--- a/drivers/video/console/vgacon.c
+++ b/drivers/video/console/vgacon.c
@@ -75,7 +75,7 @@ static void vgacon_scrolldelta(struct vc_data *c, int lines);
 static int vgacon_set_origin(struct vc_data *c);
 static void vgacon_save_screen(struct vc_data *c);
 static void vgacon_invert_region(struct vc_data *c, u16 * p, int count);
-static struct uni_pagedir *vgacon_uni_pagedir;
+static struct uni_pagedict *vgacon_uni_pagedir;
 static int vgacon_refcount;
 
 /* Description of the hardware situation */
@@ -342,7 +342,7 @@ static const char *vgacon_startup(void)
 
 static void vgacon_init(struct vc_data *c, int init)
 {
-	struct uni_pagedir *p;
+	struct uni_pagedict *p;
 
 	/*
 	 * We cannot be loaded as a module, therefore init will be 1
diff --git a/include/linux/console_struct.h b/include/linux/console_struct.h
index d5b9c8d40c18..f75033f0277f 100644
--- a/include/linux/console_struct.h
+++ b/include/linux/console_struct.h
@@ -17,7 +17,7 @@
 #include <linux/vt.h>
 #include <linux/workqueue.h>
 
-struct uni_pagedir;
+struct uni_pagedict;
 struct uni_screen;
 
 #define NPAR 16
@@ -157,8 +157,8 @@ struct vc_data {
 	unsigned int	vc_bell_duration;	/* Console bell duration */
 	unsigned short	vc_cur_blink_ms;	/* Cursor blink duration */
 	struct vc_data **vc_display_fg;		/* [!] Ptr to var holding fg console for this display */
-	struct uni_pagedir *vc_uni_pagedir;
-	struct uni_pagedir **vc_uni_pagedir_loc; /* [!] Location of uni_pagedir variable for this console */
+	struct uni_pagedict *vc_uni_pagedir;
+	struct uni_pagedict **vc_uni_pagedir_loc; /* [!] Location of uni_pagedict variable for this console */
 	struct uni_screen *vc_uni_screen;	/* unicode screen content */
 	/* additional information is in vt_kern.h */
 };
-- 
2.36.1

