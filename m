Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED1B554ACE3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 11:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351346AbiFNJGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 05:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239456AbiFNJFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 05:05:43 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94DE33D4AC;
        Tue, 14 Jun 2022 02:05:42 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 53A451F935;
        Tue, 14 Jun 2022 09:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655197541; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HDq66hKzlbSU13apIN/KRzKQB6pSsthPwOlVeYmmgX4=;
        b=i5XXfXcY7gd+O5XAGxGUbj6tEAYyzNkelJTm77qgUExjT6x8u4RQQsRHlr3hQrp5I5Rg8e
        Qwl6bwShlIeiwf7jDiQITNSEpQbVrb4LPLMdqFXQRIQAhcph/2VHCQ65/vRG0dOf3BKqDI
        BHeC6YwfvbU0E2X2D4xTMK828ll2foU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655197541;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HDq66hKzlbSU13apIN/KRzKQB6pSsthPwOlVeYmmgX4=;
        b=bSehLvoSByNIVVh580PYnSg6tcy75UArfiGchYkxS9q93FX53zt8SUXe7O4B9LEMelpjcp
        lTnN7hUXyG7RVVBg==
Received: from localhost.localdomain (unknown [10.100.201.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 28E6F2C141;
        Tue, 14 Jun 2022 09:05:41 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 4/8] tty/vt: consolemap: saner variable names in set_inverse_transl()
Date:   Tue, 14 Jun 2022 11:05:33 +0200
Message-Id: <20220614090537.15557-4-jslaby@suse.cz>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220614090537.15557-1-jslaby@suse.cz>
References: <20220614075713.32767-1-jslaby@suse.cz>
 <20220614090537.15557-1-jslaby@suse.cz>
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

The function uses too vague variable names like i, j, k for iterators, p,
q, p1, p2 for pointers etc.

Rename all these, so that it is clear what is going on:
- dict: for dictionaries.
- d, r, g: for dir, row, glyph iterators -- these are unsigned now.
- dir, row: for directory and row pointers.
- glyph: for the glyph.
- and so on...

This is a lot of shuffling, but the result pays off, IMO.

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/vt/consolemap.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/tty/vt/consolemap.c b/drivers/tty/vt/consolemap.c
index 55fb466361c1..3d0e10dac6d9 100644
--- a/drivers/tty/vt/consolemap.c
+++ b/drivers/tty/vt/consolemap.c
@@ -214,29 +214,29 @@ struct uni_pagedict {
 
 static struct uni_pagedict *dflt;
 
-static void set_inverse_transl(struct vc_data *conp, struct uni_pagedict *p,
+static void set_inverse_transl(struct vc_data *conp, struct uni_pagedict *dict,
 	       enum translation_map m)
 {
-	int j, glyph;
 	unsigned short *t = translations[m];
-	unsigned char *q;
+	unsigned char *inv;
 
-	if (!p)
+	if (!dict)
 		return;
-	q = p->inverse_translations[m];
+	inv = dict->inverse_translations[m];
 
-	if (!q) {
-		q = p->inverse_translations[m] = kmalloc(MAX_GLYPH, GFP_KERNEL);
-		if (!q)
+	if (!inv) {
+		inv = dict->inverse_translations[m] = kmalloc(MAX_GLYPH,
+				GFP_KERNEL);
+		if (!inv)
 			return;
 	}
-	memset(q, 0, MAX_GLYPH);
+	memset(inv, 0, MAX_GLYPH);
 
-	for (j = 0; j < ARRAY_SIZE(translations[m]); j++) {
-		glyph = conv_uni_to_pc(conp, t[j]);
-		if (glyph >= 0 && glyph < MAX_GLYPH && q[glyph] < 32) {
+	for (unsigned int ch = 0; ch < ARRAY_SIZE(translations[m]); ch++) {
+		int glyph = conv_uni_to_pc(conp, t[ch]);
+		if (glyph >= 0 && glyph < MAX_GLYPH && inv[glyph] < 32) {
 			/* prefer '-' above SHY etc. */
-			q[glyph] = j;
+			inv[glyph] = ch;
 		}
 	}
 }
-- 
2.36.1

