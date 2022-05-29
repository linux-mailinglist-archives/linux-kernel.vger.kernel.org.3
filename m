Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72A53536FDE
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 08:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbiE2F42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 01:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbiE2F4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 01:56:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 458036B0A2
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 22:56:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D5E5D60DD6
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 05:56:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D9FCC34119;
        Sun, 29 May 2022 05:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653803778;
        bh=ILHcOL+VeOJQPjhcWAot4jRYCJb0WUQYJb7FOE03RaI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NEWte+aAbfP1T1fPvnc0T551Ldf4jdMQjn0IxlI/JX9lDizQ+nVHQhs+900J1AnxV
         clyZb9JohlaRK/lZIWHFoyBZJWddRdY6bU09JYQbB0Orl9D3ApGdCUdGE6DiooH+0l
         +VHde9X8ixHF3xexJ1XCP9rUNkRJtLgS5uZfLvNbq39FGwz97nIrMNm77qOdmAfI67
         HOj/PYJGB2kPLaSO6Pgurm4FJStC+CnlHbiK05AGcZTasizRzp/2tXYVHnMSZc0msc
         6FiVC/ZPvjesP2gOJBno1Qv0t9XmCuu2HYGLqGkSkJ//ldMuusg5yL/US+n9AnUdPK
         p7eHU0e+0WHVQ==
From:   Gao Xiang <xiang@kernel.org>
To:     linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 2/3] erofs: get rid of label `restart_now'
Date:   Sun, 29 May 2022 13:54:24 +0800
Message-Id: <20220529055425.226363-3-xiang@kernel.org>
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

Simplify this part of code. No logic changes.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/zdata.c | 33 ++++++++++++++-------------------
 1 file changed, 14 insertions(+), 19 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 4fd66a66c5f9..6dd858f94e44 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -643,28 +643,23 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 repeat:
 	cur = end - 1;
 
-	/* lucky, within the range of the current map_blocks */
-	if (offset + cur >= map->m_la &&
-	    offset + cur < map->m_la + map->m_llen) {
+	if (offset + cur < map->m_la ||
+	    offset + cur >= map->m_la + map->m_llen) {
+		erofs_dbg("out-of-range map @ pos %llu", offset + cur);
+
+		if (z_erofs_collector_end(fe))
+			fe->backmost = false;
+		map->m_la = offset + cur;
+		map->m_llen = 0;
+		err = z_erofs_map_blocks_iter(inode, map, 0);
+		if (err)
+			goto err_out;
+	} else {
+		if (fe->pcl)
+			goto hitted;
 		/* didn't get a valid pcluster previously (very rare) */
-		if (!fe->pcl)
-			goto restart_now;
-		goto hitted;
 	}
 
-	/* go ahead the next map_blocks */
-	erofs_dbg("%s: [out-of-range] pos %llu", __func__, offset + cur);
-
-	if (z_erofs_collector_end(fe))
-		fe->backmost = false;
-
-	map->m_la = offset + cur;
-	map->m_llen = 0;
-	err = z_erofs_map_blocks_iter(inode, map, 0);
-	if (err)
-		goto err_out;
-
-restart_now:
 	if (!(map->m_flags & EROFS_MAP_MAPPED))
 		goto hitted;
 
-- 
2.30.2

