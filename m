Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC95B54AB4F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 09:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355439AbiFNH53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 03:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355349AbiFNH5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 03:57:17 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EF073EF09;
        Tue, 14 Jun 2022 00:57:17 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 7601A21B78;
        Tue, 14 Jun 2022 07:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655193435; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B5jITEF6jGNSmURoJ3ZqRd0vmVezLnMjwrXRByfoLFo=;
        b=KqdkrHJZtLVm+STH8I26W9WXSLVCuX7WS4n/A2b1abNg/7g3b+3OwMN+/MdaDxx3HlhrFJ
        brcum8/Dci/bi/4c/rFeWZRvoXbkhVxLcGyL18WR0a4bsWoo+KxWzoHYZ+yB0F3uAlnKDO
        rdsY37y5KNfaxypa8VyGCPB+4QlzdMg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655193435;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B5jITEF6jGNSmURoJ3ZqRd0vmVezLnMjwrXRByfoLFo=;
        b=CSgapXMNDgCQLYjB9mj9UAy6wFrMYouZLsrU9NrSXAPbjNIYez2xwF3+l7zzK0JV5uZC3w
        ldaT7z+8bKsKaaBQ==
Received: from localhost.localdomain (unknown [10.100.201.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 4DB742C145;
        Tue, 14 Jun 2022 07:57:15 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 4/7] tty/vt: consolemap: saner variable names in set_inverse_transl()
Date:   Tue, 14 Jun 2022 09:57:10 +0200
Message-Id: <20220614075713.32767-4-jslaby@suse.cz>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220614075713.32767-1-jslaby@suse.cz>
References: <20220614075713.32767-1-jslaby@suse.cz>
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
index a69dfda8e3d0..3d0e10dac6d9 100644
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
 
-	for (j = 0; j < ARRAY_SIZE(translations[i]); j++) {
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

