Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74F0A54ACDE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 11:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238187AbiFNJFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 05:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbiFNJFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 05:05:31 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 35A0C3AA4C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 02:05:30 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id EAD0B1E80D8F;
        Tue, 14 Jun 2022 17:04:09 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id v_qootENoztc; Tue, 14 Jun 2022 17:04:07 +0800 (CST)
Received: from ubuntu.localdomain (unknown [101.228.248.65])
        (Authenticated sender: yuzhe@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id B07121E80D5E;
        Tue, 14 Jun 2022 17:04:06 +0800 (CST)
From:   Yu Zhe <yuzhe@nfschina.com>
To:     jaharkes@cs.cmu.edu
Cc:     coda@cs.cmu.edu, codalist@coda.cs.cmu.edu,
        linux-kernel@vger.kernel.org, liqiong@nfschina.com,
        Yu Zhe <yuzhe@nfschina.com>
Subject: [PATCH] coda: remove unnecessary type castings
Date:   Tue, 14 Jun 2022 02:05:24 -0700
Message-Id: <20220614090524.794770-1-yuzhe@nfschina.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unnecessary void* type castings.

Signed-off-by: Yu Zhe <yuzhe@nfschina.com>
---
 fs/coda/cnode.c | 4 ++--
 fs/coda/inode.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/coda/cnode.c b/fs/coda/cnode.c
index 62a3d2565c26..4d789180e867 100644
--- a/fs/coda/cnode.c
+++ b/fs/coda/cnode.c
@@ -44,14 +44,14 @@ static void coda_fill_inode(struct inode *inode, struct coda_vattr *attr)
 
 static int coda_test_inode(struct inode *inode, void *data)
 {
-	struct CodaFid *fid = (struct CodaFid *)data;
+	struct CodaFid *fid = data;
 	struct coda_inode_info *cii = ITOC(inode);
 	return coda_fideq(&cii->c_fid, fid);
 }
 
 static int coda_set_inode(struct inode *inode, void *data)
 {
-	struct CodaFid *fid = (struct CodaFid *)data;
+	struct CodaFid *fid = data;
 	struct coda_inode_info *cii = ITOC(inode);
 	cii->c_fid = *fid;
 	return 0;
diff --git a/fs/coda/inode.c b/fs/coda/inode.c
index 2185328b65c7..59ef5c5afc59 100644
--- a/fs/coda/inode.c
+++ b/fs/coda/inode.c
@@ -61,7 +61,7 @@ static void coda_free_inode(struct inode *inode)
 
 static void init_once(void *foo)
 {
-	struct coda_inode_info *ei = (struct coda_inode_info *) foo;
+	struct coda_inode_info *ei = foo;
 
 	inode_init_once(&ei->vfs_inode);
 }
-- 
2.25.1

