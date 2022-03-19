Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EFE14DE664
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 07:20:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242261AbiCSGVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 02:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242252AbiCSGVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 02:21:35 -0400
X-Greylist: delayed 570 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 18 Mar 2022 23:20:14 PDT
Received: from mail-m17671.qiye.163.com (mail-m17671.qiye.163.com [59.111.176.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 914BE97298
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 23:20:14 -0700 (PDT)
Received: from localhost.localdomain (unknown [183.6.116.60])
        by mail-m17671.qiye.163.com (Hmail) with ESMTPA id 42C0F2E0023;
        Sat, 19 Mar 2022 14:10:41 +0800 (CST)
From:   Yi Li <yili@winhong.com>
To:     linux-kernel@vger.kernel.org
Cc:     yilikernel@gmail.com, joseph.qi@linux.alibaba.com,
        jlbec@evilplan.org, mark@fasheh.com, ocfs2-devel@oss.oracle.com,
        Yi Li <yili@winhong.com>
Subject: [PATCH] ocfs2: refactor the noqueue_attempted
Date:   Sat, 19 Mar 2022 14:10:28 +0800
Message-Id: <20220319061028.3152-1-yili@winhong.com>
X-Mailer: git-send-email 2.25.3
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZCBgUCR5ZQVlLVUtZV1
        kWDxoPAgseWUFZKDYvK1lXWShZQUhPN1dZLVlBSVdZDwkaFQgSH1lBWUMYGRhWH05IGhofQkpDTE
        NLVRMBExYaEhckFA4PWVdZFhoPEhUdFFlBWU9LSFVKSktISkNVS1kG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PDo6Iio5Fj4CDRoKTyo2FRcI
        NxwaCUNVSlVKTU9MTUxLSU9KTUNDVTMWGhIXVQISFxI7DBIVExQVHFUYFBZFWVdZEgtZQVlKQ0hV
        TVVKSk1VTUtZV1kIAVlBSk1CTzcG
X-HM-Tid: 0a7fa0cca8aeda56kuws42c0f2e0023
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable noqueue_attempted just set when DLM_LKF_NOQUEUE.
refactor the code.

Signed-off-by: Yi Li <yili@winhong.com>
---
 fs/ocfs2/dlmglue.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/ocfs2/dlmglue.c b/fs/ocfs2/dlmglue.c
index 801e60bab955..6315757c164d 100644
--- a/fs/ocfs2/dlmglue.c
+++ b/fs/ocfs2/dlmglue.c
@@ -1547,12 +1547,11 @@ static int __ocfs2_cluster_lock(struct ocfs2_super *osb,
 	}
 
 	if (level > lockres->l_level) {
-		if (noqueue_attempted > 0) {
+		if (noqueue_attempted) {
 			ret = -EAGAIN;
 			goto unlock;
 		}
-		if (lkm_flags & DLM_LKF_NOQUEUE)
-			noqueue_attempted = 1;
+		noqueue_attempted = lkm_flags & DLM_LKF_NOQUEUE;
 
 		if (lockres->l_action != OCFS2_AST_INVALID)
 			mlog(ML_ERROR, "lockres %s has action %u pending\n",
-- 
2.25.3

