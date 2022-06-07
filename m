Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8391E53FC65
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 12:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242201AbiFGKxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 06:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242353AbiFGKuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 06:50:13 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61170F6897;
        Tue,  7 Jun 2022 03:49:57 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id EA7031F947;
        Tue,  7 Jun 2022 10:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1654598995; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TYXEgGSmBKnTAkY/V7QSuiBpgMnCA5uwfbLthPmGdqE=;
        b=kPzm4skJqEmN1vPLn6azl3mO3qnxbvdgrLjGNiP6pZ3ifLu6o/ULXGCO1xDwwEX/cNm+0A
        99CYrcAkBSspZhmX0yjf8mWCPkg40/Or8onKqlE1bvsKLoEAqzHNqMhgcY2Kn/NHAJHebx
        4esLIfe73Do9VVWX4NZcV8TeUmYf8go=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1654598995;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TYXEgGSmBKnTAkY/V7QSuiBpgMnCA5uwfbLthPmGdqE=;
        b=9Oo/5GJaotCJ/iziXWU1cJ25NGAc8pXKVPcV11LmwszO0UcrOvB/ha/A2xFGVCFQCrdvNg
        57RCSlru58s0u5Cg==
Received: from localhost.localdomain (unknown [10.100.201.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C37D62C142;
        Tue,  7 Jun 2022 10:49:55 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 31/36] tty/vt: consolemap: make conv_uni_to_pc() more readable
Date:   Tue,  7 Jun 2022 12:49:41 +0200
Message-Id: <20220607104946.18710-31-jslaby@suse.cz>
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

1) Fetch *conp->vc_uni_pagedir_loc first and do the NULL check on the local
   variable.
2) Decouple the large "if" into few smaller "if"s.
3) Remove a \n from the definition line.

This makes the code more readable.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/vt/consolemap.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/vt/consolemap.c b/drivers/tty/vt/consolemap.c
index 8abf114b6c68..a9b497ffb346 100644
--- a/drivers/tty/vt/consolemap.c
+++ b/drivers/tty/vt/consolemap.c
@@ -849,8 +849,7 @@ int conv_uni_to_8bit(u32 uni)
 	return -1;
 }
 
-int
-conv_uni_to_pc(struct vc_data *conp, long ucs) 
+int conv_uni_to_pc(struct vc_data *conp, long ucs)
 {
 	struct uni_pagedict *dict;
 	u16 **dir, *row, glyph;
@@ -869,17 +868,24 @@ conv_uni_to_pc(struct vc_data *conp, long ucs)
 	 */
 	else if ((ucs & ~UNI_DIRECT_MASK) == UNI_DIRECT_BASE)
 		return ucs & UNI_DIRECT_MASK;
-  
-	if (!*conp->vc_uni_pagedir_loc)
-		return -3;
 
 	dict = *conp->vc_uni_pagedir_loc;
-	if ((dir = dict->uni_pgdir[UNI_DIR(ucs)]) &&
-	    (row = dir[UNI_ROW(ucs)]) &&
-	    (glyph = row[UNI_GLYPH(ucs)]) < MAX_GLYPH)
-		return glyph;
+	if (!dict)
+		return -3;
+
+	dir = dict->uni_pgdir[UNI_DIR(ucs)];
+	if (!dir)
+		return -4;
+
+	row = dir[UNI_ROW(ucs)];
+	if (!row)
+		return -4;
+
+	glyph = row[UNI_GLYPH(ucs)];
+	if (glyph >= MAX_GLYPH)
+		return -4;
 
-	return -4;		/* not found */
+	return glyph;
 }
 
 /*
-- 
2.36.1

