Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D55453FC5A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 12:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242152AbiFGKwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 06:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242342AbiFGKuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 06:50:13 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A91F688C;
        Tue,  7 Jun 2022 03:49:56 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 244A01F96A;
        Tue,  7 Jun 2022 10:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1654598995; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u0OBd4FJp4rAtSJ07Ca5FRHYHuKGM4DCFcxJjBDCqZs=;
        b=gy9PKgle/OHcalCVMv/nTn9v2SfVFbPezg5xwoe1LUyTRaZaew97mRgzVWnX24IvPqgqcI
        HDU1OBQ7knFYhiGxpcKgKVRHau4vy5DY6y7G9ABtVPnFB7Lov8/iSMDCK4Kt8vGLl3BqMC
        8uUdCbBiuCQVVcTj12uP4472IvED+78=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1654598995;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u0OBd4FJp4rAtSJ07Ca5FRHYHuKGM4DCFcxJjBDCqZs=;
        b=EqLiFcBVr6tbMnopA5NN75TGmjUhjOIFfkJeNAmNjnUltW/wZmWxikbaNm1VtgwU6kLHW4
        x9sncdv14Li7IQDg==
Received: from localhost.localdomain (unknown [10.100.201.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id F2BBF2C142;
        Tue,  7 Jun 2022 10:49:54 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 27/36] tty/vt: consolemap: saner variable names in con_copy_unimap()
Date:   Tue,  7 Jun 2022 12:49:37 +0200
Message-Id: <20220607104946.18710-27-jslaby@suse.cz>
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
 drivers/tty/vt/consolemap.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/vt/consolemap.c b/drivers/tty/vt/consolemap.c
index 255d4e92a9d0..dcbeb38a3a0a 100644
--- a/drivers/tty/vt/consolemap.c
+++ b/drivers/tty/vt/consolemap.c
@@ -750,16 +750,16 @@ EXPORT_SYMBOL(con_set_default_unimap);
  */
 int con_copy_unimap(struct vc_data *dst_vc, struct vc_data *src_vc)
 {
-	struct uni_pagedict *q;
+	struct uni_pagedict *src;
 
 	if (!*src_vc->vc_uni_pagedir_loc)
 		return -EINVAL;
 	if (*dst_vc->vc_uni_pagedir_loc == *src_vc->vc_uni_pagedir_loc)
 		return 0;
 	con_free_unimap(dst_vc);
-	q = *src_vc->vc_uni_pagedir_loc;
-	q->refcount++;
-	*dst_vc->vc_uni_pagedir_loc = q;
+	src = *src_vc->vc_uni_pagedir_loc;
+	src->refcount++;
+	*dst_vc->vc_uni_pagedir_loc = src;
 	return 0;
 }
 EXPORT_SYMBOL(con_copy_unimap);
-- 
2.36.1

