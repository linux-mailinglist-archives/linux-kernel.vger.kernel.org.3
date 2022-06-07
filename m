Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E214D53FC4E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 12:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242001AbiFGKvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 06:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242347AbiFGKuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 06:50:13 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7975CF6899;
        Tue,  7 Jun 2022 03:49:57 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id B81A221B8D;
        Tue,  7 Jun 2022 10:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1654598995; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7BjPVmtbFq5FUh/IYXJ3D58IxbsAq5TORJTTrDD3fbU=;
        b=VkAAy1RmE1oWgv3H/cPacGJ/jJB1kSC9snCj8LRUMz2eij1wVId7XPkqWpl+9GrP6drEEu
        +96JFNGbPYst+/fgjDsYdiohARFqXhy8I770lzkNZE7NAizgJjkDOnzjh0YLvZsDQVsOHS
        kJjpYrXUvwfd14f68k/jkH3Y+qGQU5k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1654598995;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7BjPVmtbFq5FUh/IYXJ3D58IxbsAq5TORJTTrDD3fbU=;
        b=J3N3m7w6ZGUGH5IiVGAXq0kBfcxVD+q7vEu4W/saz87rL6FJ6fCB4riavoEXukLZBlu3MJ
        tcuXQDy7OzyuHRCQ==
Received: from localhost.localdomain (unknown [10.100.201.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 904A62C141;
        Tue,  7 Jun 2022 10:49:55 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 30/36] tty/vt: consolemap: saner variable names in con_set_default_unimap()
Date:   Tue,  7 Jun 2022 12:49:40 +0200
Message-Id: <20220607104946.18710-30-jslaby@suse.cz>
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
 drivers/tty/vt/consolemap.c | 43 +++++++++++++++++++------------------
 1 file changed, 22 insertions(+), 21 deletions(-)

diff --git a/drivers/tty/vt/consolemap.c b/drivers/tty/vt/consolemap.c
index 65c83f9228e9..8abf114b6c68 100644
--- a/drivers/tty/vt/consolemap.c
+++ b/drivers/tty/vt/consolemap.c
@@ -694,49 +694,50 @@ int con_set_unimap(struct vc_data *vc, ushort ct, struct unipair __user *list)
  */
 int con_set_default_unimap(struct vc_data *vc)
 {
-	int i, j, err = 0, err1;
-	u16 *q;
-	struct uni_pagedict *p;
+	struct uni_pagedict *dict;
+	unsigned int fontpos, count;
+	int err = 0, err1;
+	u16 *dfont;
 
 	if (dflt) {
-		p = *vc->vc_uni_pagedir_loc;
-		if (p == dflt)
+		dict = *vc->vc_uni_pagedir_loc;
+		if (dict == dflt)
 			return 0;
 
 		dflt->refcount++;
 		*vc->vc_uni_pagedir_loc = dflt;
-		if (p && !--p->refcount) {
-			con_release_unimap(p);
-			kfree(p);
+		if (dict && !--dict->refcount) {
+			con_release_unimap(dict);
+			kfree(dict);
 		}
 		return 0;
 	}
-	
+
 	/* The default font is always 256 characters */
 
 	err = con_do_clear_unimap(vc);
 	if (err)
 		return err;
-    
-	p = *vc->vc_uni_pagedir_loc;
-	q = dfont_unitable;
-	
-	for (i = 0; i < 256; i++)
-		for (j = dfont_unicount[i]; j; j--) {
-			err1 = con_insert_unipair(p, *(q++), i);
+
+	dict = *vc->vc_uni_pagedir_loc;
+	dfont = dfont_unitable;
+
+	for (fontpos = 0; fontpos < 256U; fontpos++)
+		for (count = dfont_unicount[fontpos]; count; count--) {
+			err1 = con_insert_unipair(dict, *(dfont++), fontpos);
 			if (err1)
 				err = err1;
 		}
-			
-	if (con_unify_unimap(vc, p)) {
+
+	if (con_unify_unimap(vc, dict)) {
 		dflt = *vc->vc_uni_pagedir_loc;
 		return err;
 	}
 
 	for (enum translation_map m = FIRST_MAP; m <= LAST_MAP; m++)
-		set_inverse_transl(vc, p, m);	/* Update all inverse translations */
-	set_inverse_trans_unicode(vc, p);
-	dflt = p;
+		set_inverse_transl(vc, dict, m);
+	set_inverse_trans_unicode(vc, dict);
+	dflt = dict;
 	return err;
 }
 EXPORT_SYMBOL(con_set_default_unimap);
-- 
2.36.1

