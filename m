Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4481453FC67
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 12:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238118AbiFGKx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 06:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242322AbiFGKuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 06:50:11 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E2FF5D3C;
        Tue,  7 Jun 2022 03:49:54 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 183541F95B;
        Tue,  7 Jun 2022 10:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1654598993; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/4in//erUPaeZ/LLhoWUH9O7N6aXbPv13xWT4obOKy8=;
        b=RkJxa/Ql+nz1JcPYyqkohI/Vt6OtxG85g//6dRSsgdiHbXG3asaQ3t/PecH0tLl/JVXoPI
        TUUNyC99TX4a8UXaAOSLwmcnol2/l/rwcw3D7TUmaumaXhum0lbSS9kvlkN7tfVWyRdVnU
        k8KFDhI570Kk6HgD4P2NE56kNWg9xI4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1654598993;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/4in//erUPaeZ/LLhoWUH9O7N6aXbPv13xWT4obOKy8=;
        b=H9wrUWYjFdafL6rda5zXR60rh+NWTQP20tXw5gWy3hTP7KIn9C5NQSNjjgR4mECdjUlbpO
        YTntSNl5zg472ZDw==
Received: from localhost.localdomain (unknown [10.100.201.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id DF45D2C145;
        Tue,  7 Jun 2022 10:49:52 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 17/36] tty/vt: consolemap: introduce enum translation_map and use it
Date:   Tue,  7 Jun 2022 12:49:27 +0200
Message-Id: <20220607104946.18710-17-jslaby@suse.cz>
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

Again, instead of magic constants in the code, declare an enum and be a
little bit more explicit. Both in the translations definition and in the
loops etc.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/vt/consolemap.c | 39 +++++++++++++++++++------------------
 include/linux/consolemap.h  | 18 +++++++++++------
 2 files changed, 32 insertions(+), 25 deletions(-)

diff --git a/drivers/tty/vt/consolemap.c b/drivers/tty/vt/consolemap.c
index 92b5dddb00d9..80536687acef 100644
--- a/drivers/tty/vt/consolemap.c
+++ b/drivers/tty/vt/consolemap.c
@@ -38,7 +38,7 @@
 
 static unsigned short translations[][256] = {
   /* 8-bit Latin-1 mapped to Unicode -- trivial mapping */
-  {
+  [LAT1_MAP] = {
     0x0000, 0x0001, 0x0002, 0x0003, 0x0004, 0x0005, 0x0006, 0x0007,
     0x0008, 0x0009, 0x000a, 0x000b, 0x000c, 0x000d, 0x000e, 0x000f,
     0x0010, 0x0011, 0x0012, 0x0013, 0x0014, 0x0015, 0x0016, 0x0017,
@@ -71,9 +71,9 @@ static unsigned short translations[][256] = {
     0x00e8, 0x00e9, 0x00ea, 0x00eb, 0x00ec, 0x00ed, 0x00ee, 0x00ef,
     0x00f0, 0x00f1, 0x00f2, 0x00f3, 0x00f4, 0x00f5, 0x00f6, 0x00f7,
     0x00f8, 0x00f9, 0x00fa, 0x00fb, 0x00fc, 0x00fd, 0x00fe, 0x00ff
-  }, 
+  },
   /* VT100 graphics mapped to Unicode */
-  {
+  [GRAF_MAP] = {
     0x0000, 0x0001, 0x0002, 0x0003, 0x0004, 0x0005, 0x0006, 0x0007,
     0x0008, 0x0009, 0x000a, 0x000b, 0x000c, 0x000d, 0x000e, 0x000f,
     0x0010, 0x0011, 0x0012, 0x0013, 0x0014, 0x0015, 0x0016, 0x0017,
@@ -108,8 +108,8 @@ static unsigned short translations[][256] = {
     0x00f8, 0x00f9, 0x00fa, 0x00fb, 0x00fc, 0x00fd, 0x00fe, 0x00ff
   },
   /* IBM Codepage 437 mapped to Unicode */
-  {
-    0x0000, 0x263a, 0x263b, 0x2665, 0x2666, 0x2663, 0x2660, 0x2022, 
+  [IBMPC_MAP] = {
+    0x0000, 0x263a, 0x263b, 0x2665, 0x2666, 0x2663, 0x2660, 0x2022,
     0x25d8, 0x25cb, 0x25d9, 0x2642, 0x2640, 0x266a, 0x266b, 0x263c,
     0x25b6, 0x25c0, 0x2195, 0x203c, 0x00b6, 0x00a7, 0x25ac, 0x21a8,
     0x2191, 0x2193, 0x2192, 0x2190, 0x221f, 0x2194, 0x25b2, 0x25bc,
@@ -141,9 +141,9 @@ static unsigned short translations[][256] = {
     0x03a6, 0x0398, 0x03a9, 0x03b4, 0x221e, 0x03c6, 0x03b5, 0x2229,
     0x2261, 0x00b1, 0x2265, 0x2264, 0x2320, 0x2321, 0x00f7, 0x2248,
     0x00b0, 0x2219, 0x00b7, 0x221a, 0x207f, 0x00b2, 0x25a0, 0x00a0
-  }, 
+  },
   /* User mapping -- default to codes for direct font mapping */
-  {
+  [USER_MAP] = {
     0xf000, 0xf001, 0xf002, 0xf003, 0xf004, 0xf005, 0xf006, 0xf007,
     0xf008, 0xf009, 0xf00a, 0xf00b, 0xf00c, 0xf00d, 0xf00e, 0xf00f,
     0xf010, 0xf011, 0xf012, 0xf013, 0xf014, 0xf015, 0xf016, 0xf017,
@@ -184,7 +184,7 @@ static unsigned short translations[][256] = {
 
 #define MAX_GLYPH 512		/* Max possible glyph value */
 
-static int inv_translate[MAX_NR_CONSOLES];
+static enum translation_map inv_translate[MAX_NR_CONSOLES];
 
 #define UNI_DIRS	32U
 #define UNI_DIR_ROWS	32U
@@ -208,24 +208,25 @@ struct uni_pagedict {
 	u16		**uni_pgdir[UNI_DIRS];
 	unsigned long	refcount;
 	unsigned long	sum;
-	unsigned char	*inverse_translations[4];
+	unsigned char	*inverse_translations[LAST_MAP + 1];
 	u16		*inverse_trans_unicode;
 };
 
 static struct uni_pagedict *dflt;
 
-static void set_inverse_transl(struct vc_data *conp, struct uni_pagedict *p, int i)
+static void set_inverse_transl(struct vc_data *conp, struct uni_pagedict *p,
+	       enum translation_map m)
 {
 	int j, glyph;
-	unsigned short *t = translations[i];
+	unsigned short *t = translations[m];
 	unsigned char *q;
 	
 	if (!p)
 		return;
-	q = p->inverse_translations[i];
+	q = p->inverse_translations[m];
 
 	if (!q) {
-		q = p->inverse_translations[i] = kmalloc(MAX_GLYPH, GFP_KERNEL);
+		q = p->inverse_translations[m] = kmalloc(MAX_GLYPH, GFP_KERNEL);
 		if (!q)
 			return;
 	}
@@ -276,7 +277,7 @@ static void set_inverse_trans_unicode(struct vc_data *conp,
 	}
 }
 
-unsigned short *set_translate(int m, struct vc_data *vc)
+unsigned short *set_translate(enum translation_map m, struct vc_data *vc)
 {
 	inv_translate[vc->vc_num] = m;
 	return translations[m];
@@ -292,7 +293,7 @@ unsigned short *set_translate(int m, struct vc_data *vc)
 u16 inverse_translate(const struct vc_data *conp, u16 glyph, bool use_unicode)
 {
 	struct uni_pagedict *p;
-	int m;
+	enum translation_map m;
 
 	if (glyph >= MAX_GLYPH)
 		return 0;
@@ -669,8 +670,8 @@ int con_set_unimap(struct vc_data *vc, ushort ct, struct unipair __user *list)
 	if (con_unify_unimap(vc, p))
 		goto out_unlock;
 
-	for (i = 0; i <= 3; i++)
-		set_inverse_transl(vc, p, i); /* Update inverse translations */
+	for (enum translation_map m = FIRST_MAP; m <= LAST_MAP; m++)
+		set_inverse_transl(vc, p, m); /* Update inverse translations */
 	set_inverse_trans_unicode(vc, p);
 
 out_unlock:
@@ -731,8 +732,8 @@ int con_set_default_unimap(struct vc_data *vc)
 		return err;
 	}
 
-	for (i = 0; i <= 3; i++)
-		set_inverse_transl(vc, p, i);	/* Update all inverse translations */
+	for (enum translation_map m = FIRST_MAP; m <= LAST_MAP; m++)
+		set_inverse_transl(vc, p, m);	/* Update all inverse translations */
 	set_inverse_trans_unicode(vc, p);
 	dflt = p;
 	return err;
diff --git a/include/linux/consolemap.h b/include/linux/consolemap.h
index 1ff2bf55eb85..c35db4896c37 100644
--- a/include/linux/consolemap.h
+++ b/include/linux/consolemap.h
@@ -7,10 +7,15 @@
 #ifndef __LINUX_CONSOLEMAP_H__
 #define __LINUX_CONSOLEMAP_H__
 
-#define LAT1_MAP 0
-#define GRAF_MAP 1
-#define IBMPC_MAP 2
-#define USER_MAP 3
+enum translation_map {
+	LAT1_MAP,
+	GRAF_MAP,
+	IBMPC_MAP,
+	USER_MAP,
+
+	FIRST_MAP = LAT1_MAP,
+	LAST_MAP = USER_MAP,
+};
 
 #include <linux/types.h>
 
@@ -18,7 +23,7 @@ struct vc_data;
 
 #ifdef CONFIG_CONSOLE_TRANSLATIONS
 u16 inverse_translate(const struct vc_data *conp, u16 glyph, bool use_unicode);
-unsigned short *set_translate(int m, struct vc_data *vc);
+unsigned short *set_translate(enum translation_map m, struct vc_data *vc);
 int conv_uni_to_pc(struct vc_data *conp, long ucs);
 u32 conv_8bit_to_uni(unsigned char c);
 int conv_uni_to_8bit(u32 uni);
@@ -30,7 +35,8 @@ static inline u16 inverse_translate(const struct vc_data *conp, u16 glyph,
 	return glyph;
 }
 
-static inline unsigned short *set_translate(int m, struct vc_data *vc)
+static inline unsigned short *set_translate(enum translation_map m,
+		struct vc_data *vc)
 {
 	return NULL;
 }
-- 
2.36.1

