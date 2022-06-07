Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D31653FC72
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 12:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242282AbiFGKyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 06:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242349AbiFGKuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 06:50:13 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9399F689F;
        Tue,  7 Jun 2022 03:49:57 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 5ACD721B8E;
        Tue,  7 Jun 2022 10:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1654598996; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U12vaN07tMbir+CSUyLMivkjwEefcl65rD6pOKKdm9c=;
        b=F/L9TBTY5tknDWI6szxW97FuvBpcLp6AlUhIZ0VmUfhTuI4MS3Z95/VmsF8uwRZkxOgZpW
        hdCp88AGcNS/ivUwgktQUB9SCWhsL8i+EFllLZdfFDnBk/FzLqtIEPM7UsfS7jZK54gG3O
        GTngjbkT9ep6pC9JWuTXztNHOM1Tyq4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1654598996;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U12vaN07tMbir+CSUyLMivkjwEefcl65rD6pOKKdm9c=;
        b=s0k0Qe3kTynqUjFIeVoh7lY+bT5mjpI2EgulA0k3AinRqs5BGpgPUnl/UizK1AaMmMWAYx
        9O0VZJWOesjShfAw==
Received: from localhost.localdomain (unknown [10.100.201.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 32E492C142;
        Tue,  7 Jun 2022 10:49:56 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 33/36] tty/vt: consolemap: change refcount only if needed in con_do_clear_unimap()
Date:   Tue,  7 Jun 2022 12:49:43 +0200
Message-Id: <20220607104946.18710-33-jslaby@suse.cz>
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

con_do_clear_unimap() currently decreases and increases refcount of old
dictionary in a back and forth fashion. This makes the code really hard
to follow. Decrease the refcount only if everything went well and we
really allocated a new one and decoupled from the old dictionary.

I sincerelly hope I did not make a mistake in this (ill) logic.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/vt/consolemap.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/vt/consolemap.c b/drivers/tty/vt/consolemap.c
index 01b7e49f1f91..4d8efe74315c 100644
--- a/drivers/tty/vt/consolemap.c
+++ b/drivers/tty/vt/consolemap.c
@@ -535,22 +535,23 @@ static int con_do_clear_unimap(struct vc_data *vc)
 {
 	struct uni_pagedict *old = *vc->vc_uni_pagedir_loc;
 
-	if (!old || --old->refcount) {
+	if (!old || old->refcount > 1) {
 		struct uni_pagedict *new = kzalloc(sizeof(*new), GFP_KERNEL);
-		if (!new) {
-			if (old)
-				old->refcount++;
+		if (!new)
 			return -ENOMEM;
-		}
+
 		new->refcount = 1;
 		*vc->vc_uni_pagedir_loc = new;
+
+		if (old)
+			old->refcount--;
 	} else {
 		if (old == dflt)
 			dflt = NULL;
-		old->refcount++;
 		old->sum = 0;
 		con_release_unimap(old);
 	}
+
 	return 0;
 }
 
-- 
2.36.1

