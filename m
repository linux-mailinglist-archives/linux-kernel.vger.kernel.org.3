Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB000571F02
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 17:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbiGLPZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 11:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232986AbiGLPY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 11:24:57 -0400
Received: from mail-m971.mail.163.com (mail-m971.mail.163.com [123.126.97.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 48ED15C9EE;
        Tue, 12 Jul 2022 08:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=G+z5b
        nYslAb/L5CvdEE281XrI0AtqzAgEbcezhR5z/g=; b=of5oPnfq0ElM4u3Gp0z1i
        H6x9dcdaHbpeBh69qyBYQnJumYC0pdTof2nv3tDiWNCBJI1Ds78hDK1D3AuCWwGF
        g8HTkld/63jjyU8LfwTJoKBk+FBMvPH37FIw2dWOHj67/lPR3/D+x2SS3tPRTbGy
        fjcETL9HHU3Fir0f7JuGiQ=
Received: from localhost.localdomain (unknown [123.58.221.99])
        by smtp1 (Coremail) with SMTP id GdxpCgDnQqXpkc1iayuaNw--.2084S2;
        Tue, 12 Jul 2022 23:23:24 +0800 (CST)
From:   williamsukatube@163.com
To:     linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     miklos@szeredi.hu, William Dean <williamsukatube@gmail.com>,
        Hacash Robot <hacashRobot@santino.com>
Subject: [PATCH -next] ovl: clean up comparsions to NULL
Date:   Tue, 12 Jul 2022 23:23:18 +0800
Message-Id: <20220712152318.2649819-1-williamsukatube@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GdxpCgDnQqXpkc1iayuaNw--.2084S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7AF4rKry3ur1xWFy3KFyUZFb_yoW8CFWUpF
        WxCa4rt34rX347ZF1SyF4q9Fy5X395GF47J348uwsFv395Ww4rAryjy3WjqF9rAFWrurWa
        vanYgry5Ja1kZF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07b1GYLUUUUU=
X-Originating-IP: [123.58.221.99]
X-CM-SenderInfo: xzlozx5dpv3yxdwxuvi6rwjhhfrp/xtbB0Aw8g2EsrUTQrwAAs4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: William Dean <williamsukatube@gmail.com>

Clean up comparsions to NULL, simplify as follows:
if (x == NULL) -> if (!x)

Reported-by: Hacash Robot <hacashRobot@santino.com>
Signed-off-by: William Dean <williamsukatube@gmail.com>
---
 fs/overlayfs/readdir.c | 6 +++---
 fs/overlayfs/super.c   | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
index 78f62cc1797b..953ff22d825c 100644
--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -182,7 +182,7 @@ static int ovl_cache_entry_add_rb(struct ovl_readdir_data *rdd,
 		return 0;
 
 	p = ovl_cache_entry_new(rdd, name, len, ino, d_type);
-	if (p == NULL) {
+	if (!p) {
 		rdd->err = -ENOMEM;
 		return -ENOMEM;
 	}
@@ -205,7 +205,7 @@ static int ovl_fill_lowest(struct ovl_readdir_data *rdd,
 		list_move_tail(&p->l_node, &rdd->middle);
 	} else {
 		p = ovl_cache_entry_new(rdd, name, namelen, ino, d_type);
-		if (p == NULL)
+		if (!p)
 			rdd->err = -ENOMEM;
 		else
 			list_add_tail(&p->l_node, &rdd->middle);
@@ -538,7 +538,7 @@ static int ovl_fill_plain(struct dir_context *ctx, const char *name,
 
 	rdd->count++;
 	p = ovl_cache_entry_new(rdd, name, namelen, ino, d_type);
-	if (p == NULL) {
+	if (!p) {
 		rdd->err = -ENOMEM;
 		return -ENOMEM;
 	}
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index e0a2e0468ee7..a474cb8040b2 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -468,7 +468,7 @@ static char *ovl_next_opt(char **s)
 	char *sbegin = *s;
 	char *p;
 
-	if (sbegin == NULL)
+	if (!sbegin)
 		return NULL;
 
 	for (p = sbegin; *p; p++) {
@@ -2186,7 +2186,7 @@ static int __init ovl_init(void)
 					     (SLAB_RECLAIM_ACCOUNT|
 					      SLAB_MEM_SPREAD|SLAB_ACCOUNT),
 					     ovl_inode_init_once);
-	if (ovl_inode_cachep == NULL)
+	if (!ovl_inode_cachep)
 		return -ENOMEM;
 
 	err = ovl_aio_request_cache_init();
-- 
2.25.1

