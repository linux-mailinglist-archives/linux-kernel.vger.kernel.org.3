Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF07953FC66
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 12:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242089AbiFGKxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 06:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242355AbiFGKuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 06:50:13 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C6BA98082;
        Tue,  7 Jun 2022 03:49:58 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 8DE4321B90;
        Tue,  7 Jun 2022 10:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1654598996; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AXypnZ6WiOHqzvp/v6LGuwBn5wjho0Mmkh86mIUkjHw=;
        b=iymZZzRT6ektOXS6WmPFqBb2sWExFC9jHmUcqZRXg9dlHyNEemUrI317Fyu9VdrV/BgJsB
        2RCEmenLDX7I7PVaXM88T45QeTQohw330Du92NZ31lHtMp/hv8acoATYCP7oLDjfd1RSd6
        HGSWULbzEDacRZpteIWHai/rUpgcx/I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1654598996;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AXypnZ6WiOHqzvp/v6LGuwBn5wjho0Mmkh86mIUkjHw=;
        b=ZwpZvrTWbfmaG8uoQTsM4on+nmTg+UJVYBHEJ7DTnsOhJSkzh358FJSJSUtrDFLukLDj9G
        gzNwyWLyyDD/XkBA==
Received: from localhost.localdomain (unknown [10.100.201.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 65C092C141;
        Tue,  7 Jun 2022 10:49:56 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 34/36] tty/vt: consolemap: extract con_allocate_new() from con_do_clear_unimap()
Date:   Tue,  7 Jun 2022 12:49:44 +0200
Message-Id: <20220607104946.18710-34-jslaby@suse.cz>
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

The first part of con_do_clear_unimap() is needed on another place, so
extract it to a separate function called con_allocate_new(). It will be
used once more in the next patch.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/vt/consolemap.c | 38 ++++++++++++++++++++++---------------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/drivers/tty/vt/consolemap.c b/drivers/tty/vt/consolemap.c
index 4d8efe74315c..14d3fbff015c 100644
--- a/drivers/tty/vt/consolemap.c
+++ b/drivers/tty/vt/consolemap.c
@@ -530,27 +530,35 @@ con_insert_unipair(struct uni_pagedict *p, u_short unicode, u_short fontpos)
 	return 0;
 }
 
+static int con_allocate_new(struct vc_data *vc)
+{
+	struct uni_pagedict *new, *old = *vc->vc_uni_pagedir_loc;
+
+	new = kzalloc(sizeof(*new), GFP_KERNEL);
+	if (!new)
+		return -ENOMEM;
+
+	new->refcount = 1;
+	*vc->vc_uni_pagedir_loc = new;
+
+	if (old)
+		old->refcount--;
+
+	return 0;
+}
+
 /* Caller must hold the lock */
 static int con_do_clear_unimap(struct vc_data *vc)
 {
 	struct uni_pagedict *old = *vc->vc_uni_pagedir_loc;
 
-	if (!old || old->refcount > 1) {
-		struct uni_pagedict *new = kzalloc(sizeof(*new), GFP_KERNEL);
-		if (!new)
-			return -ENOMEM;
-
-		new->refcount = 1;
-		*vc->vc_uni_pagedir_loc = new;
+	if (!old || old->refcount > 1)
+		return con_allocate_new(vc);
 
-		if (old)
-			old->refcount--;
-	} else {
-		if (old == dflt)
-			dflt = NULL;
-		old->sum = 0;
-		con_release_unimap(old);
-	}
+	if (old == dflt)
+		dflt = NULL;
+	old->sum = 0;
+	con_release_unimap(old);
 
 	return 0;
 }
-- 
2.36.1

