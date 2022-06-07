Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A27DF53FC5F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 12:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239689AbiFGKwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 06:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242336AbiFGKuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 06:50:13 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76628F6888;
        Tue,  7 Jun 2022 03:49:56 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D74AE21B80;
        Tue,  7 Jun 2022 10:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1654598993; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vAuvNGT8GIUBHEgm1CsQlxMPBqlOhBEQduBX+HRxYW8=;
        b=e8DqGxd7R1I6XulkITmb9Rrvah3CUl9O+RDzQygbH8KGWu9CkKYZaXPHrp03Q6r0gGyO0V
        zUfNr6mHfEO/qOdt5U2crX3JSWGyUXl3zrNXDZxYUWZlfddaB1GY+inks430UU1BywBe9d
        TOy42Iw9nqoDoe8OR7VESCuSfgUg6vU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1654598993;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vAuvNGT8GIUBHEgm1CsQlxMPBqlOhBEQduBX+HRxYW8=;
        b=RW6LaxACpvuX2ZRQuxpO9zRNSXNuXkTxFKahBlfgwC3oxtZ00Di7udlUefUHBJn025Wb50
        dAkiOwFGzCEjJSBw==
Received: from localhost.localdomain (unknown [10.100.201.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id B13742C142;
        Tue,  7 Jun 2022 10:49:53 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 21/36] tty/vt: consolemap: saner variable names in conv_uni_to_pc()
Date:   Tue,  7 Jun 2022 12:49:31 +0200
Message-Id: <20220607104946.18710-21-jslaby@suse.cz>
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

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/vt/consolemap.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/vt/consolemap.c b/drivers/tty/vt/consolemap.c
index 3763a73706b2..374b1ba20635 100644
--- a/drivers/tty/vt/consolemap.c
+++ b/drivers/tty/vt/consolemap.c
@@ -852,10 +852,9 @@ int conv_uni_to_8bit(u32 uni)
 int
 conv_uni_to_pc(struct vc_data *conp, long ucs) 
 {
-	int h;
-	u16 **p1, *p2;
-	struct uni_pagedict *p;
-  
+	struct uni_pagedict *dict;
+	u16 **dir, *row, glyph;
+
 	/* Only 16-bit codes supported at this time */
 	if (ucs > 0xffff)
 		return -4;		/* Not found */
@@ -874,11 +873,11 @@ conv_uni_to_pc(struct vc_data *conp, long ucs)
 	if (!*conp->vc_uni_pagedir_loc)
 		return -3;
 
-	p = *conp->vc_uni_pagedir_loc;
-	if ((p1 = p->uni_pgdir[UNI_DIR(ucs)]) &&
-	    (p2 = p1[UNI_ROW(ucs)]) &&
-	    (h = p2[UNI_GLYPH(ucs)]) < MAX_GLYPH)
-		return h;
+	dict = *conp->vc_uni_pagedir_loc;
+	if ((dir = dict->uni_pgdir[UNI_DIR(ucs)]) &&
+	    (row = dir[UNI_ROW(ucs)]) &&
+	    (glyph = row[UNI_GLYPH(ucs)]) < MAX_GLYPH)
+		return glyph;
 
 	return -4;		/* not found */
 }
-- 
2.36.1

