Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8931256526C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 12:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233904AbiGDKdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 06:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233285AbiGDKd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 06:33:28 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2EE122DDD
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 03:33:24 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id EBAE81E80C95;
        Mon,  4 Jul 2022 18:31:27 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id B6zNf4pYHTqg; Mon,  4 Jul 2022 18:31:25 +0800 (CST)
Received: from node1.localdomain (unknown [219.141.250.2])
        (Authenticated sender: kunyu@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 3532F1E80C90;
        Mon,  4 Jul 2022 18:31:25 +0800 (CST)
From:   Li kunyu <kunyu@nfschina.com>
To:     almaz.alexandrovich@paragon-software.com
Cc:     ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org,
        Li kunyu <kunyu@nfschina.com>
Subject: [PATCH] fs/ntfs3/indx: Remove unnecessary 'NULL' values from Pointer
Date:   Mon,  4 Jul 2022 18:31:13 +0800
Message-Id: <20220704103113.5529-1-kunyu@nfschina.com>
X-Mailer: git-send-email 2.18.2
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pointer variables allocate memory first, and then judge. There is no
need to initialize the assignment.

Signed-off-by: Li kunyu <kunyu@nfschina.com>
---
 fs/ntfs3/index.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ntfs3/index.c b/fs/ntfs3/index.c
index 6f81e3a49abf..b5c92b6ce01c 100644
--- a/fs/ntfs3/index.c
+++ b/fs/ntfs3/index.c
@@ -1685,8 +1685,8 @@ indx_insert_into_buffer(struct ntfs_index *indx, struct ntfs_inode *ni,
 {
 	int err;
 	const struct NTFS_DE *sp;
-	struct NTFS_DE *e, *de_t, *up_e = NULL;
-	struct indx_node *n2 = NULL;
+	struct NTFS_DE *e, *de_t, *up_e;
+	struct indx_node *n2;
 	struct indx_node *n1 = fnd->nodes[level];
 	struct INDEX_HDR *hdr1 = &n1->index->ihdr;
 	struct INDEX_HDR *hdr2;
-- 
2.18.2

