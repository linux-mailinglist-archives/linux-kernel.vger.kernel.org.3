Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9294853FC51
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 12:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242016AbiFGKvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 06:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242351AbiFGKuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 06:50:13 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61521F6898;
        Tue,  7 Jun 2022 03:49:57 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 8686721B74;
        Tue,  7 Jun 2022 10:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1654598995; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UBkLx6OpAAkFK5B4Y/1k3Klxk50MQ+pw4Aa6aNHUTOQ=;
        b=Jpi2nceKQl4f2z0D63iOmMDqOzE27OpBm7zcRWRbAO4Dxip202xIBAVMbAWeTvLWzsGkQx
        dtTkcb8D3bU6sLOMUGkjxbjI6MPnKrdzfhZsd8Tiq2XL7Qe8Hbzh2nI2wuoOlFolHRGiOY
        MhA0+VAr3l8241ZwUOv4r7YnfGkrj1g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1654598995;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UBkLx6OpAAkFK5B4Y/1k3Klxk50MQ+pw4Aa6aNHUTOQ=;
        b=6ZbQzuK1UHUfsMhI8MRVsL92PPTer4JIYiMKMf7dXNrWDYBRmJudTSvsyanxuxlhtDH4ZP
        pOnwcDKPqdviEoCA==
Received: from localhost.localdomain (unknown [10.100.201.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 5EB0B2C142;
        Tue,  7 Jun 2022 10:49:55 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 29/36] tty/vt: consolemap: saner variable names in con_set_unimap()
Date:   Tue,  7 Jun 2022 12:49:39 +0200
Message-Id: <20220607104946.18710-29-jslaby@suse.cz>
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
 drivers/tty/vt/consolemap.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/vt/consolemap.c b/drivers/tty/vt/consolemap.c
index b8f2acb6e388..65c83f9228e9 100644
--- a/drivers/tty/vt/consolemap.c
+++ b/drivers/tty/vt/consolemap.c
@@ -627,7 +627,7 @@ static struct uni_pagedict *con_unshare_unimap(struct vc_data *vc,
 int con_set_unimap(struct vc_data *vc, ushort ct, struct unipair __user *list)
 {
 	int err = 0, err1;
-	struct uni_pagedict *p;
+	struct uni_pagedict *dict;
 	struct unipair *unilist, *plist;
 
 	if (!ct)
@@ -640,19 +640,19 @@ int con_set_unimap(struct vc_data *vc, ushort ct, struct unipair __user *list)
 	console_lock();
 
 	/* Save original vc_unipagdir_loc in case we allocate a new one */
-	p = *vc->vc_uni_pagedir_loc;
-	if (!p) {
+	dict = *vc->vc_uni_pagedir_loc;
+	if (!dict) {
 		err = -EINVAL;
 		goto out_unlock;
 	}
 
-	if (p->refcount > 1) {
-		p = con_unshare_unimap(vc, p);
-		if (IS_ERR(p)) {
-			err = PTR_ERR(p);
+	if (dict->refcount > 1) {
+		dict = con_unshare_unimap(vc, dict);
+		if (IS_ERR(dict)) {
+			err = PTR_ERR(dict);
 			goto out_unlock;
 		}
-	} else if (p == dflt) {
+	} else if (dict == dflt) {
 		dflt = NULL;
 	}
 
@@ -660,7 +660,7 @@ int con_set_unimap(struct vc_data *vc, ushort ct, struct unipair __user *list)
 	 * Insert user specified unicode pairs into new table.
 	 */
 	for (plist = unilist; ct; ct--, plist++) {
-		err1 = con_insert_unipair(p, plist->unicode, plist->fontpos);
+		err1 = con_insert_unipair(dict, plist->unicode, plist->fontpos);
 		if (err1)
 			err = err1;
 	}
@@ -668,12 +668,12 @@ int con_set_unimap(struct vc_data *vc, ushort ct, struct unipair __user *list)
 	/*
 	 * Merge with fontmaps of any other virtual consoles.
 	 */
-	if (con_unify_unimap(vc, p))
+	if (con_unify_unimap(vc, dict))
 		goto out_unlock;
 
 	for (enum translation_map m = FIRST_MAP; m <= LAST_MAP; m++)
-		set_inverse_transl(vc, p, m); /* Update inverse translations */
-	set_inverse_trans_unicode(vc, p);
+		set_inverse_transl(vc, dict, m);
+	set_inverse_trans_unicode(vc, dict);
 
 out_unlock:
 	console_unlock();
-- 
2.36.1

