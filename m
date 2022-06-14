Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0CCE54AB56
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 10:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355427AbiFNH6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 03:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355700AbiFNH6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 03:58:09 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E14193FBEA;
        Tue, 14 Jun 2022 00:57:39 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 422CA1F929;
        Tue, 14 Jun 2022 07:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655193435; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eT7LmTn7OJ2NKmXWsimUkp6REt30L893JqiHOWuDEj4=;
        b=aAIgh2T1rKe5Pd5QHYwQFTEaW3EHpBZXm2HkNJRIkzNalFJvrLL5/Uhtqkk20P9TOUq1Ju
        LBaiulmsungNbgc6tES/gk1Znor1lG/7dnpTGjUCbEYaCDZtoa9EA7x90m7IQehZYzGhR4
        pSJ01P+Bcng/mx/1U+skq6/FqhFA7E8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655193435;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eT7LmTn7OJ2NKmXWsimUkp6REt30L893JqiHOWuDEj4=;
        b=0hzZA8+8ZaQF1lKdwzTlsfdVngCJJDlQF/xxTRawIJj0+WhD0e3RTfjSfFDheZ9FRgwezc
        npGessqlsngJ/SDQ==
Received: from localhost.localdomain (unknown [10.100.201.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 1ACDE2C142;
        Tue, 14 Jun 2022 07:57:15 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 3/7] tty/vt: consolemap: saner variable names in set_inverse_trans_unicode()
Date:   Tue, 14 Jun 2022 09:57:09 +0200
Message-Id: <20220614075713.32767-3-jslaby@suse.cz>
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

The function still uses too vague parameter name after commit
50c92a1b2d50 (tty/vt: consolemap: saner variable names in
set_inverse_trans_unicode()).

So use "dict" instead of "p" for that parameter too.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/vt/consolemap.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/vt/consolemap.c b/drivers/tty/vt/consolemap.c
index a7507c5c3154..a69dfda8e3d0 100644
--- a/drivers/tty/vt/consolemap.c
+++ b/drivers/tty/vt/consolemap.c
@@ -241,17 +241,17 @@ static void set_inverse_transl(struct vc_data *conp, struct uni_pagedict *p,
 	}
 }
 
-static void set_inverse_trans_unicode(struct uni_pagedict *p)
+static void set_inverse_trans_unicode(struct uni_pagedict *dict)
 {
 	unsigned int d, r, g;
 	u16 *inv;
 
-	if (!p)
+	if (!dict)
 		return;
 
-	inv = p->inverse_trans_unicode;
+	inv = dict->inverse_trans_unicode;
 	if (!inv) {
-		inv = p->inverse_trans_unicode = kmalloc_array(MAX_GLYPH,
+		inv = dict->inverse_trans_unicode = kmalloc_array(MAX_GLYPH,
 				sizeof(*inv), GFP_KERNEL);
 		if (!inv)
 			return;
@@ -259,7 +259,7 @@ static void set_inverse_trans_unicode(struct uni_pagedict *p)
 	memset(inv, 0, MAX_GLYPH * sizeof(*inv));
 
 	for (d = 0; d < UNI_DIRS; d++) {
-		u16 **dir = p->uni_pgdir[d];
+		u16 **dir = dict->uni_pgdir[d];
 		if (!dir)
 			continue;
 		for (r = 0; r < UNI_DIR_ROWS; r++) {
-- 
2.36.1

