Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90CD253FC54
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 12:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242040AbiFGKwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 06:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242302AbiFGKuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 06:50:10 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6079CF5D07;
        Tue,  7 Jun 2022 03:49:52 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 0FE471F920;
        Tue,  7 Jun 2022 10:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1654598991; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GIRg8u/CQs8pHF7oNp/S2oS01P+PnK8CbWWnzHzlD1Q=;
        b=TndR4eVOagDCdgGuQdHnEu5qFh/L+7MtYAG2FRyNA6T2QY8enB+H4p81jHr8tLM4qg7XY/
        jgSe90fjtOlrCAZPVHOuGve5InrxHZB+y9cWKexeZln4igWyFcZeH2uuiZhgBqrN8ju1ry
        MpvS9i/eX7N04ulAUae9W1Tn/RvThaI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1654598991;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GIRg8u/CQs8pHF7oNp/S2oS01P+PnK8CbWWnzHzlD1Q=;
        b=HQaBZ2HDYcia1aRkO4v/8vyAprJOXKSqMSFSTFioKbn16SP5IIlOqchoQEge3ZVpyVn3km
        a45Qem1WkF3sJcCQ==
Received: from localhost.localdomain (unknown [10.100.201.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id DCF902C142;
        Tue,  7 Jun 2022 10:49:50 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 07/36] tty/vt: consolemap: make parameters of inverse_translate() saner
Date:   Tue,  7 Jun 2022 12:49:17 +0200
Message-Id: <20220607104946.18710-7-jslaby@suse.cz>
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

- int use_unicode -> bool: it's used as bool at some places already, so
  make it explicit.
- int glyph -> u16: every caller passes a u16 in. So make it explicit
  too. And remove a negative check from inverse_translate() as it never
  could be negative.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/accessibility/braille/braille_console.c | 2 +-
 drivers/accessibility/speakup/main.c            | 2 +-
 drivers/tty/vt/consolemap.c                     | 4 ++--
 drivers/tty/vt/selection.c                      | 3 ++-
 drivers/tty/vt/vt.c                             | 2 +-
 include/linux/consolemap.h                      | 6 +++---
 6 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/accessibility/braille/braille_console.c b/drivers/accessibility/braille/braille_console.c
index fdc6b593f500..c4d54a5326b1 100644
--- a/drivers/accessibility/braille/braille_console.c
+++ b/drivers/accessibility/braille/braille_console.c
@@ -131,7 +131,7 @@ static void vc_refresh(struct vc_data *vc)
 	for (i = 0; i < WIDTH; i++) {
 		u16 glyph = screen_glyph(vc,
 				2 * (vc_x + i) + vc_y * vc->vc_size_row);
-		buf[i] = inverse_translate(vc, glyph, 1);
+		buf[i] = inverse_translate(vc, glyph, true);
 	}
 	braille_write(buf);
 }
diff --git a/drivers/accessibility/speakup/main.c b/drivers/accessibility/speakup/main.c
index d726537fa16c..f52265293482 100644
--- a/drivers/accessibility/speakup/main.c
+++ b/drivers/accessibility/speakup/main.c
@@ -470,7 +470,7 @@ static u16 get_char(struct vc_data *vc, u16 *pos, u_char *attribs)
 			c |= 0x100;
 		}
 
-		ch = inverse_translate(vc, c, 1);
+		ch = inverse_translate(vc, c, true);
 		*attribs = (w & 0xff00) >> 8;
 	}
 	return ch;
diff --git a/drivers/tty/vt/consolemap.c b/drivers/tty/vt/consolemap.c
index fb61158f4dc6..157c7f936294 100644
--- a/drivers/tty/vt/consolemap.c
+++ b/drivers/tty/vt/consolemap.c
@@ -281,12 +281,12 @@ unsigned short *set_translate(int m, struct vc_data *vc)
  *    was active.
  * Still, it is now possible to a certain extent to cut and paste non-ASCII.
  */
-u16 inverse_translate(const struct vc_data *conp, int glyph, int use_unicode)
+u16 inverse_translate(const struct vc_data *conp, u16 glyph, bool use_unicode)
 {
 	struct uni_pagedict *p;
 	int m;
 
-	if (glyph < 0 || glyph >= MAX_GLYPH)
+	if (glyph >= MAX_GLYPH)
 		return 0;
 
 	p = *conp->vc_uni_pagedir_loc;
diff --git a/drivers/tty/vt/selection.c b/drivers/tty/vt/selection.c
index f7755e73696e..6ef22f01cc51 100644
--- a/drivers/tty/vt/selection.c
+++ b/drivers/tty/vt/selection.c
@@ -68,7 +68,8 @@ sel_pos(int n, bool unicode)
 {
 	if (unicode)
 		return screen_glyph_unicode(vc_sel.cons, n / 2);
-	return inverse_translate(vc_sel.cons, screen_glyph(vc_sel.cons, n), 0);
+	return inverse_translate(vc_sel.cons, screen_glyph(vc_sel.cons, n),
+			false);
 }
 
 /**
diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index f8c87c4d7399..1ea1c11c42fd 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -4741,7 +4741,7 @@ u32 screen_glyph_unicode(const struct vc_data *vc, int n)
 
 	if (uniscr)
 		return uniscr->lines[n / vc->vc_cols][n % vc->vc_cols];
-	return inverse_translate(vc, screen_glyph(vc, n * 2), 1);
+	return inverse_translate(vc, screen_glyph(vc, n * 2), true);
 }
 EXPORT_SYMBOL_GPL(screen_glyph_unicode);
 
diff --git a/include/linux/consolemap.h b/include/linux/consolemap.h
index 98171dbed51f..1ff2bf55eb85 100644
--- a/include/linux/consolemap.h
+++ b/include/linux/consolemap.h
@@ -17,15 +17,15 @@
 struct vc_data;
 
 #ifdef CONFIG_CONSOLE_TRANSLATIONS
-u16 inverse_translate(const struct vc_data *conp, int glyph, int use_unicode);
+u16 inverse_translate(const struct vc_data *conp, u16 glyph, bool use_unicode);
 unsigned short *set_translate(int m, struct vc_data *vc);
 int conv_uni_to_pc(struct vc_data *conp, long ucs);
 u32 conv_8bit_to_uni(unsigned char c);
 int conv_uni_to_8bit(u32 uni);
 void console_map_init(void);
 #else
-static inline u16 inverse_translate(const struct vc_data *conp, int glyph,
-		int use_unicode)
+static inline u16 inverse_translate(const struct vc_data *conp, u16 glyph,
+		bool use_unicode)
 {
 	return glyph;
 }
-- 
2.36.1

