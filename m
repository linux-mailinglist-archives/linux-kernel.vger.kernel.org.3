Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A64C6552D40
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 10:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346734AbiFUImv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 04:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231418AbiFUImt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 04:42:49 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B566526128;
        Tue, 21 Jun 2022 01:42:48 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id g16-20020a17090a7d1000b001ea9f820449so12994282pjl.5;
        Tue, 21 Jun 2022 01:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BXsLSrPEBOdi1z9Ti6DCxwcO5PjEZPzcVOSiTfdD/4Y=;
        b=c9Q7RdRfYibGX0zXagNXxxUcf3zgcJuKk+tTK6EHNafaMjJ4OghPXN8tK5dVm9fx1p
         VazlTYGHPVnFg7D2zo0bhIyWcx3BlCaYLB1J/yY8wcTz01s96SB1b8hfeXouMCZRUH9v
         /qPNj8aXK7eK7mxVI7KDZgLHB/mhoX/eqkHev6P7VjnKL4FuXFdnn3jhOWzO24kGjLuu
         2FLu1HhJIMuXdRBIri5xqXRLOLxk/mlXjCjABvUQAeVVlguPMdODohOd6tr6Ll7cyfBJ
         KcZHLBiJs4GN3Bweq356hPAPzSW+Zm/8c/uOiQgwzOeMa8pzdQDS3B5W8QJMQzdEf+vw
         pMaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BXsLSrPEBOdi1z9Ti6DCxwcO5PjEZPzcVOSiTfdD/4Y=;
        b=yH+pCvs8Gd0ts5iTcMvBr3Vteqdv1pL3dHmZmHOuQEq4AwQxiQmtivD+ZcpQ6hVJiR
         6rDAXX6j4LS8vor9uwWygQd0WVpeLosHNnO5ctssTnVo071hB3lr+homcRggCP1g9HyD
         vwOsB14p6uz3Xm6yNregdfPSWBXFg2y60grbItSHC3eBPlEXcxsgZNtxXNKL8j4SLztU
         j0+RKpe4FF7I1CEV9ncJAO0eAIrIH+3lzta553/SsDp9bfTBoP1axopcRbb3fRPqq3TM
         DdzYGddAB+vWQEKQZX1JdOELFx5at997L0xUBpY7P43D7KAAPmz56VP68DUyqL6KenDF
         v1gA==
X-Gm-Message-State: AJIora+L1c0NiYh4j6jaKkmd7UNzxZS+/M1BpmNAaenmZEhoRCnY3Lgp
        2AWj2QRvmspCd76wtCp/VcI=
X-Google-Smtp-Source: AGRyM1vN3ljCDQ8WMbISJSPrI9LgB/bE64nxkJtqABPk2gUGrZJRvKUggQYqlxfBp6/JMzIoAhGYtg==
X-Received: by 2002:a17:90b:180b:b0:1e3:2871:6be3 with SMTP id lw11-20020a17090b180b00b001e328716be3mr31188459pjb.85.1655800968203;
        Tue, 21 Jun 2022 01:42:48 -0700 (PDT)
Received: from localhost.localdomain ([178.173.230.211])
        by smtp.gmail.com with ESMTPSA id y18-20020a62b512000000b0051e7b6e8b12sm4509082pfe.11.2022.06.21.01.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 01:42:47 -0700 (PDT)
From:   Shida Zhang <starzhangzsd@gmail.com>
X-Google-Original-From: Shida Zhang <zhangshida@kylinos.cn>
To:     djwong@kernel.org, dchinner@redhat.com
Cc:     zhangshida@kylinos.cn, starzhangzsd@gmail.com,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: [PATCH v3] xfs: add check before calling xfs_mod_fdblocks
Date:   Tue, 21 Jun 2022 16:42:38 +0800
Message-Id: <20220621084238.1235880-1-zhangshida@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Checks are missing when delta equals 0 in __xfs_ag_resv_free() and
__xfs_ag_resv_init().

the case that the delta equals 0 is reachable with the command
sequence below:

 # mkfs.xfs -f /dev/sdb5
 # mount /dev/sdb5 /mnt/scratch/

where /dev/sdb5 is my disk for test. And if the patch below is
applied:

====
xfs_mod_freecounter(
        if (rsvd)
                ASSERT(has_resv_pool);

+       if (delta == 0)
+               dump_stack();
+
        if (delta > 0) {
                /*
                 * If the reserve pool is depleted, put blocks back into it
====

the following stack will be shown in the message:

=>  xfs_mod_freecounter+0x84/0x2b8
=>  __xfs_ag_resv_free+0xc4/0x188
=>  xfs_ag_resv_free+0x24/0x50
=>  xfs_fs_unreserve_ag_blocks+0x40/0x160
=>  xfs_mountfs+0x500/0x900
=>  xfs_fs_fill_super+0x3d8/0x810
=>  get_tree_bdev+0x164/0x258
=>  xfs_fs_get_tree+0x20/0x30
=>  vfs_get_tree+0x30/0xf8
=>  path_mount+0x3c4/0xa58
=>  do_mount+0x74/0x98

=>  xfs_mod_freecounter+0x84/0x2b8
=>  __xfs_ag_resv_init+0x64/0x1d0
=>  xfs_ag_resv_init+0x108/0x1c8
=>  xfs_fs_reserve_ag_blocks+0x4c/0x110
=>  xfs_mountfs+0x57c/0x900
=>  xfs_fs_fill_super+0x3d8/0x810
=>  get_tree_bdev+0x164/0x258
=>  xfs_fs_get_tree+0x20/0x30
=>  vfs_get_tree+0x30/0xf8
=>  path_mount+0x3c4/0xa58
=>  do_mount+0x74/0x98

After applying this patch, we can avoid to call xfs_mod_fdblocks when
delta equals 0.

Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
---
 Changes from v1:
 -Add checks before calling xfs_mod_fdblocks instead.
 Changes from v2:
 -Rephrase the commit description.

 fs/xfs/libxfs/xfs_ag_resv.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_ag_resv.c b/fs/xfs/libxfs/xfs_ag_resv.c
index fe94058d4e9e..c8fa032e4b00 100644
--- a/fs/xfs/libxfs/xfs_ag_resv.c
+++ b/fs/xfs/libxfs/xfs_ag_resv.c
@@ -149,7 +149,12 @@ __xfs_ag_resv_free(
 		oldresv = resv->ar_orig_reserved;
 	else
 		oldresv = resv->ar_reserved;
-	error = xfs_mod_fdblocks(pag->pag_mount, oldresv, true);
+
+	if (oldresv)
+		error = xfs_mod_fdblocks(pag->pag_mount, oldresv, true);
+	else
+		error = 0;
+
 	resv->ar_reserved = 0;
 	resv->ar_asked = 0;
 	resv->ar_orig_reserved = 0;
@@ -215,8 +220,13 @@ __xfs_ag_resv_init(
 
 	if (XFS_TEST_ERROR(false, mp, XFS_ERRTAG_AG_RESV_FAIL))
 		error = -ENOSPC;
-	else
-		error = xfs_mod_fdblocks(mp, -(int64_t)hidden_space, true);
+	else {
+		error = 0;
+		if (hidden_space)
+			error = xfs_mod_fdblocks(mp, -(int64_t)hidden_space,
+						true);
+	}
+
 	if (error) {
 		trace_xfs_ag_resv_init_error(pag->pag_mount, pag->pag_agno,
 				error, _RET_IP_);
-- 
2.25.1

