Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1470353FC56
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 12:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242123AbiFGKwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 06:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242346AbiFGKuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 06:50:13 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A34F6893;
        Tue,  7 Jun 2022 03:49:56 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id E88ED21B72;
        Tue,  7 Jun 2022 10:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1654598994; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=svEHwKLJrEVnuM7ZxhcTEu5gs1yk5tIH982vrALTIaI=;
        b=PSsWiJPvPRYMSFKJhf4ZXMPi/Sfl7k1bmFpQNE4C9PTsqW0Er5qMYV0cIy2plKuvII1qOO
        eGLjm/iVpkqFm4CUZ1bvaZ+yWflHJEHKIXsu061fQLMziLEjXuCdNXnckXY5r/kVlyKk1j
        xLuIcf528jqbOjuDDa9quu4V1yAPxiA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1654598994;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=svEHwKLJrEVnuM7ZxhcTEu5gs1yk5tIH982vrALTIaI=;
        b=d0Z40dPoRmjGv2JPZvPe776hr+RJ03dCJk+Af7Hj/cQl5WrmQAvlV9KffgRkUSPP15QO2P
        GBxL6cMiH6e0zQCw==
Received: from localhost.localdomain (unknown [10.100.201.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C13DB2C141;
        Tue,  7 Jun 2022 10:49:54 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 26/36] tty/vt: consolemap: saner variable names in con_release_unimap()
Date:   Tue,  7 Jun 2022 12:49:36 +0200
Message-Id: <20220607104946.18710-26-jslaby@suse.cz>
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
 drivers/tty/vt/consolemap.c | 34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/drivers/tty/vt/consolemap.c b/drivers/tty/vt/consolemap.c
index 7e353455945d..255d4e92a9d0 100644
--- a/drivers/tty/vt/consolemap.c
+++ b/drivers/tty/vt/consolemap.c
@@ -415,28 +415,30 @@ int con_get_trans_new(ushort __user * arg)
 extern u8 dfont_unicount[];	/* Defined in console_defmap.c */
 extern u16 dfont_unitable[];
 
-static void con_release_unimap(struct uni_pagedict *p)
+static void con_release_unimap(struct uni_pagedict *dict)
 {
-	u16 **p1;
-	int i, j;
+	unsigned int d, r;
 
-	if (p == dflt)
+	if (dict == dflt)
 		dflt = NULL;
-	for (i = 0; i < UNI_DIRS; i++) {
-		p1 = p->uni_pgdir[i];
-		if (p1 != NULL) {
-			for (j = 0; j < UNI_DIR_ROWS; j++)
-				kfree(p1[j]);
-			kfree(p1);
+
+	for (d = 0; d < UNI_DIRS; d++) {
+		u16 **dir = dict->uni_pgdir[d];
+		if (dir != NULL) {
+			for (r = 0; r < UNI_DIR_ROWS; r++)
+				kfree(dir[r]);
+			kfree(dir);
 		}
-		p->uni_pgdir[i] = NULL;
+		dict->uni_pgdir[d] = NULL;
 	}
-	for (i = 0; i < ARRAY_SIZE(p->inverse_translations); i++) {
-		kfree(p->inverse_translations[i]);
-		p->inverse_translations[i] = NULL;
+
+	for (r = 0; r < ARRAY_SIZE(dict->inverse_translations); r++) {
+		kfree(dict->inverse_translations[r]);
+		dict->inverse_translations[r] = NULL;
 	}
-	kfree(p->inverse_trans_unicode);
-	p->inverse_trans_unicode = NULL;
+
+	kfree(dict->inverse_trans_unicode);
+	dict->inverse_trans_unicode = NULL;
 }
 
 /* Caller must hold the console lock */
-- 
2.36.1

