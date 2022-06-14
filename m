Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 416EC54AB50
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 09:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355503AbiFNH5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 03:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355259AbiFNH5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 03:57:17 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B49423F32A;
        Tue, 14 Jun 2022 00:57:16 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 1038E21B76;
        Tue, 14 Jun 2022 07:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655193435; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W1m3uV8jfn8loGjnEyIsZxOjd/loIhb8RwYKGBl8ER0=;
        b=a7GcL3nmYA7Wmijw+ENE1MyYHXQqhcpo6+96j7rOaWb1b9qwa6xmVGMNa+yKCET4QA6G93
        zMFsya4ExIfxQFbEuHIHspqwETkfSTFK0LQh0PJuDI9LcnDclMNdgehGQfEXof2OWzORHb
        8lI5p7A7wQCA9R3NKKAyg0GVeyQJbT4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655193435;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W1m3uV8jfn8loGjnEyIsZxOjd/loIhb8RwYKGBl8ER0=;
        b=ku1pyfwQE7rsCRCt/59Hi+5WyWannyBxzkFpsF7Tyi/e0duQ+nQV1SAMs4P1TH3S7E99Kv
        um8TsokUbzJFqeBQ==
Received: from localhost.localdomain (unknown [10.100.201.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id DC4EB2C143;
        Tue, 14 Jun 2022 07:57:14 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 2/7] tty/vt: consolemap: remove unused parameter from set_inverse_trans_unicode()
Date:   Tue, 14 Jun 2022 09:57:08 +0200
Message-Id: <20220614075713.32767-2-jslaby@suse.cz>
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

conp is unused in set_inverse_trans_unicode(), remove it.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/vt/consolemap.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/vt/consolemap.c b/drivers/tty/vt/consolemap.c
index 8aa7a48b3647..a7507c5c3154 100644
--- a/drivers/tty/vt/consolemap.c
+++ b/drivers/tty/vt/consolemap.c
@@ -241,8 +241,7 @@ static void set_inverse_transl(struct vc_data *conp, struct uni_pagedict *p,
 	}
 }
 
-static void set_inverse_trans_unicode(struct vc_data *conp,
-				      struct uni_pagedict *p)
+static void set_inverse_trans_unicode(struct uni_pagedict *p)
 {
 	unsigned int d, r, g;
 	u16 *inv;
@@ -327,7 +326,7 @@ static void update_user_maps(void)
 		p = *vc_cons[i].d->vc_uni_pagedir_loc;
 		if (p && p != q) {
 			set_inverse_transl(vc_cons[i].d, p, USER_MAP);
-			set_inverse_trans_unicode(vc_cons[i].d, p);
+			set_inverse_trans_unicode(p);
 			q = p;
 		}
 	}
@@ -678,7 +677,7 @@ int con_set_unimap(struct vc_data *vc, ushort ct, struct unipair __user *list)
 
 	for (enum translation_map m = FIRST_MAP; m <= LAST_MAP; m++)
 		set_inverse_transl(vc, dict, m);
-	set_inverse_trans_unicode(vc, dict);
+	set_inverse_trans_unicode(dict);
 
 out_unlock:
 	console_unlock();
@@ -741,7 +740,7 @@ int con_set_default_unimap(struct vc_data *vc)
 
 	for (enum translation_map m = FIRST_MAP; m <= LAST_MAP; m++)
 		set_inverse_transl(vc, dict, m);
-	set_inverse_trans_unicode(vc, dict);
+	set_inverse_trans_unicode(dict);
 	dflt = dict;
 	return err;
 }
-- 
2.36.1

