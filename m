Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11165546211
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 11:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347642AbiFJJ1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 05:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349202AbiFJJ1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 05:27:12 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F86A2F662;
        Fri, 10 Jun 2022 02:25:04 -0700 (PDT)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4LKFsj5FkDz9sxF;
        Fri, 10 Jun 2022 17:24:41 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.58) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 10 Jun 2022 17:25:02 +0800
From:   Xiu Jianfeng <xiujianfeng@huawei.com>
To:     <casey@schaufler-ca.com>, <jmorris@namei.org>, <serge@hallyn.com>
CC:     <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] smack: Remove the redundant lsm_inode_alloc
Date:   Fri, 10 Jun 2022 17:23:07 +0800
Message-ID: <20220610092307.30311-1-xiujianfeng@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.58]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's not possible for inode->i_security to be NULL here because every
inode will call inode_init_always and then lsm_inode_alloc to alloc
memory for inode->security, this is what LSM infrastructure management
do, so remove this redundant code.

Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
---
 security/smack/smack_lsm.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 6207762dbdb1..001831458fa2 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -766,13 +766,6 @@ static int smack_set_mnt_opts(struct super_block *sb,
 	if (sp->smk_flags & SMK_SB_INITIALIZED)
 		return 0;
 
-	if (inode->i_security == NULL) {
-		int rc = lsm_inode_alloc(inode);
-
-		if (rc)
-			return rc;
-	}
-
 	if (!smack_privileged(CAP_MAC_ADMIN)) {
 		/*
 		 * Unprivileged mounts don't get to specify Smack values.
-- 
2.17.1

