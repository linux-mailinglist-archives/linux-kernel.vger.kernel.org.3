Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2DF53FC70
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 12:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242275AbiFGKyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 06:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242313AbiFGKuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 06:50:10 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 828CCF5D34;
        Tue,  7 Jun 2022 03:49:54 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D5B4021B78;
        Tue,  7 Jun 2022 10:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1654598991; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vkDLozHQjLYfHBDZqicJVo3LA96Q1s4R4wwO6dvm1h4=;
        b=N+H/HpOMg/6bjGe5Lwwe/WwlrYkke7mgo058ZDLb12N3hVazqlG9n56LSFFV/vsPOvIqRZ
        7TdisUGMVi5FU7nRaIcHZiOG7jR/fgNcxxlaWic8wgzUE5l3QtjVxEIoAkMYLW+p2ics1k
        XZa6ufCXnGPD74llktEvePtkJfm9PnE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1654598991;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vkDLozHQjLYfHBDZqicJVo3LA96Q1s4R4wwO6dvm1h4=;
        b=rggp6BQOFraJ3olZtOEATpoaicmhWWObJll56nAdRVDXqGbuwbAs35BwrJCztWWgPYrZQr
        FLk55eW5LU5bL+AQ==
Received: from localhost.localdomain (unknown [10.100.201.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id ADD9C2C141;
        Tue,  7 Jun 2022 10:49:51 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 11/36] tty/vt: consolemap: zero uni_pgdir using kcalloc()
Date:   Tue,  7 Jun 2022 12:49:21 +0200
Message-Id: <20220607104946.18710-11-jslaby@suse.cz>
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

The newly allocated p->uni_pgdir[n] is initialized to NULLs right after
a kmalloc_array() allocation. Combine these two using kcalloc().

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/vt/consolemap.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/vt/consolemap.c b/drivers/tty/vt/consolemap.c
index e5fd225e87bd..097ab7d01f8b 100644
--- a/drivers/tty/vt/consolemap.c
+++ b/drivers/tty/vt/consolemap.c
@@ -499,18 +499,16 @@ static int con_unify_unimap(struct vc_data *conp, struct uni_pagedict *p)
 static int
 con_insert_unipair(struct uni_pagedict *p, u_short unicode, u_short fontpos)
 {
-	int i, n;
+	int n;
 	u16 **p1, *p2;
 
 	n = UNI_DIR(unicode);
 	p1 = p->uni_pgdir[n];
 	if (!p1) {
-		p1 = p->uni_pgdir[n] = kmalloc_array(UNI_DIR_ROWS,
-						     sizeof(u16 *), GFP_KERNEL);
+		p1 = p->uni_pgdir[n] = kcalloc(UNI_DIR_ROWS, sizeof(u16 *),
+				GFP_KERNEL);
 		if (!p1)
 			return -ENOMEM;
-		for (i = 0; i < UNI_DIR_ROWS; i++)
-			p1[i] = NULL;
 	}
 
 	n = UNI_ROW(unicode);
-- 
2.36.1

