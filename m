Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC03E536FDD
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 08:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbiE2F5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 01:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbiE2F4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 01:56:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 069816B0A2
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 22:56:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9687B60DED
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 05:56:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D742C3411C;
        Sun, 29 May 2022 05:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653803781;
        bh=IJu+gkphhFylVDsQzhP8KOtGyF6aW9neo4uSaI2lipk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gXUTrQO6ZFLlgIQrh39yuohMijrv1AGoz4cZf4mzpmJgJNKBlnTG1oFJ7gNnRkKGL
         +Ls9+4ziGmn3YWT+tngfnuZxDnRk9IkOZcDigGgivbo9yRCd7Ea/bFEAW7wwY5XISi
         DtFlDDC5lJM3B+4R+esdPxurYgqs5L+cnDdjB8d9ztAlbSYALIHgBNW7Fv4FU6Edcf
         k/tEMelO8S/J0kl19Yq5xMh5xSZ4dJBarecR2BREdvz/4fd9L5YAEo2z2UZ5jDkpGf
         zZSNozKaVsc72uFiFG+Drn2Vtd0OLKE4ONw0zf1mHuhkqf39awJrEOCnJlwK0oeDm6
         3M1jT8Ud4GB9A==
From:   Gao Xiang <xiang@kernel.org>
To:     linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 3/3] erofs: simplify z_erofs_pcluster_readmore()
Date:   Sun, 29 May 2022 13:54:25 +0800
Message-Id: <20220529055425.226363-4-xiang@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220529055425.226363-1-xiang@kernel.org>
References: <20220529055425.226363-1-xiang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gao Xiang <hsiangkao@linux.alibaba.com>

Get rid of unnecessary label `skip'. No logic changes.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/zdata.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 6dd858f94e44..b33fb64b3393 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1436,22 +1436,19 @@ static void z_erofs_pcluster_readmore(struct z_erofs_decompress_frontend *f,
 		struct page *page;
 
 		page = erofs_grab_cache_page_nowait(inode->i_mapping, index);
-		if (!page)
-			goto skip;
-
-		if (PageUptodate(page)) {
-			unlock_page(page);
+		if (page) {
+			if (PageUptodate(page)) {
+				unlock_page(page);
+			} else {
+				err = z_erofs_do_read_page(f, page, pagepool);
+				if (err)
+					erofs_err(inode->i_sb,
+						  "readmore error at page %lu @ nid %llu",
+						  index, EROFS_I(inode)->nid);
+			}
 			put_page(page);
-			goto skip;
 		}
 
-		err = z_erofs_do_read_page(f, page, pagepool);
-		if (err)
-			erofs_err(inode->i_sb,
-				  "readmore error at page %lu @ nid %llu",
-				  index, EROFS_I(inode)->nid);
-		put_page(page);
-skip:
 		if (cur < PAGE_SIZE)
 			break;
 		cur = (index << PAGE_SHIFT) - 1;
-- 
2.30.2

