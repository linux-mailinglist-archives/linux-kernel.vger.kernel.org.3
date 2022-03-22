Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE4844E3C3D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 11:13:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232830AbiCVKOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 06:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232816AbiCVKOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 06:14:40 -0400
Received: from mail.meizu.com (edge01.meizu.com [14.29.68.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9EBA6304
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 03:13:08 -0700 (PDT)
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by mz-mail04.meizu.com
 (172.16.1.16) with Microsoft SMTP Server (TLS) id 14.3.487.0; Tue, 22 Mar
 2022 18:13:10 +0800
Received: from meizu.meizu.com (172.16.137.70) by IT-EXMB-1-125.meizu.com
 (172.16.1.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Tue, 22 Mar
 2022 18:13:06 +0800
From:   Haowen Bai <baihaowen@meizu.com>
To:     <richard@nod.at>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        "Haowen Bai" <baihaowen@meizu.com>
Subject: [PATCH] fs: ubifs: use NULL instead of using plain integer as pointer
Date:   Tue, 22 Mar 2022 18:13:04 +0800
Message-ID: <1647943984-1646-1-git-send-email-baihaowen@meizu.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.16.137.70]
X-ClientProxiedBy: IT-EXMB-1-126.meizu.com (172.16.1.126) To
 IT-EXMB-1-125.meizu.com (172.16.1.125)
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes the following sparse warnings:
fs/ubifs/xattr.c:680:58: warning: Using plain integer as NULL pointer

Signed-off-by: Haowen Bai <baihaowen@meizu.com>
---
 fs/ubifs/xattr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ubifs/xattr.c b/fs/ubifs/xattr.c
index e4f193e..e4c4761 100644
--- a/fs/ubifs/xattr.c
+++ b/fs/ubifs/xattr.c
@@ -677,7 +677,7 @@ int ubifs_init_security(struct inode *dentry, struct inode *inode,
 	int err;
 
 	err = security_inode_init_security(inode, dentry, qstr,
-					   &init_xattrs, 0);
+					   &init_xattrs, NULL);
 	if (err) {
 		struct ubifs_info *c = dentry->i_sb->s_fs_info;
 		ubifs_err(c, "cannot initialize security for inode %lu, error %d",
-- 
2.7.4

