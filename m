Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1401D530C08
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 11:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232310AbiEWIwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 04:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232281AbiEWIwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 04:52:04 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3BAF20F4D;
        Mon, 23 May 2022 01:52:02 -0700 (PDT)
To:     darrick.wong@oracle.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1653295920;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=p6JOuyT3DSojfUixE8gaeIKjisvo2m+Tz2TF4gr0GZo=;
        b=M9vZ4/4mZO4gAUxBz5VrBszq9zvFM+CnIkIkEVmhn9/Yl5JBhNm1vDsAR2xSjnNs+JVqm4
        35ugDJtwDA7hM71OUSEveydyQ6UXgeEYzr0VdaMDuy2OypNeVlY+baRfyBVhDYCN3CHdOS
        59f1WG9EIW70VTUVsqR5FxKM54h8O8U=
Cc:     linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Jackie Liu <liu.yun@linux.dev>
Subject: [BUG report] security_inode_alloc return -ENOMEM let xfs shutdown
Message-ID: <5a3a9cdc-33c3-4196-b8f7-bfec485eae5b@linux.dev>
Date:   Mon, 23 May 2022 16:51:50 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Maintainer and developer.

    Syzkaller report an filesystem shutdown for me, It's very easy to
trigger and also exists on the latest kernel version 5.18-rc7.

dmesg shows:

[  285.725893] FAULT_INJECTION: forcing a failure.
                name failslab, interval 1, probability 0, space 0, times 0
[  285.729625] CPU: 7 PID: 18034 Comm: syz-executor Not tainted 
4.19.90-43+ #7
[  285.731420] Source Version: b62cabdd86181d386998660ebf34ca653addd6c9
[  285.733051] Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 
02/06/2015
[  285.734796] Call trace:
[  285.735614]  dump_backtrace+0x0/0x3e0
[  285.736609]  show_stack+0x2c/0x38
[  285.737525]  dump_stack+0x164/0x1fc
[  285.738489]  should_fail+0x5c0/0x688
[  285.739555]  __should_failslab+0x118/0x180
[  285.740725]  should_failslab+0x2c/0x78
[  285.741808]  kmem_cache_alloc_trace+0x270/0x410
[  285.743120]  security_inode_alloc+0x100/0x1a8
[  285.744356]  inode_init_always+0x48c/0xa28
[  285.745524]  xfs_iget_cache_hit+0x9c0/0x2f28
[  285.746739]  xfs_iget+0x33c/0x9e0
[  285.747708]  xfs_ialloc+0x218/0x11c0
[  285.748752]  xfs_dir_ialloc+0xe8/0x480
[  285.749832]  xfs_create+0x5bc/0x1220
[  285.750871]  xfs_generic_create+0x42c/0x568
[  285.752053]  xfs_vn_mknod+0x48/0x58
[  285.753067]  xfs_vn_create+0x40/0x50
[  285.754106]  lookup_open+0x960/0x1580
[  285.755176]  do_last+0xd44/0x2180
[  285.756149]  path_openat+0x1a0/0x6d0
[  285.757187]  do_filp_open+0x14c/0x208
[  285.758245]  do_sys_open+0x340/0x470
[  285.759289]  __arm64_sys_openat+0x98/0xd8
[  285.760438]  el0_svc_common+0x230/0x3f0
[  285.761541]  el0_svc_handler+0x144/0x1a8
[  285.762674]  el0_svc+0x8/0x1b0
[  285.763737] security_inode_alloc:796
[  285.764733] inode_init_always:202
[  285.765669] xfs_create:1213
[  285.766485] XFS (dm-0): Internal error xfs_trans_cancel at line 1046 
of file fs/xfs/xfs_trans.c.  Caller xfs_create+0x700/0x1220
[  285.769503] CPU: 7 PID: 18034 Comm: syz-executor Not tainted 
4.19.90-43+ #7
[  285.771275] Source Version: b62cabdd86181d386998660ebf34ca653addd6c9
[  285.772892] Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 
02/06/2015
[  285.774625] Call trace:
[  285.775335]  dump_backtrace+0x0/0x3e0
[  285.776324]  show_stack+0x2c/0x38
[  285.777236]  dump_stack+0x164/0x1fc
[  285.778188]  xfs_error_report+0xdc/0xe0
[  285.779292]  xfs_trans_cancel+0x490/0x878
[  285.780439]  xfs_create+0x700/0x1220
[  285.781477]  xfs_generic_create+0x42c/0x568
[  285.782673]  xfs_vn_mknod+0x48/0x58
[  285.783687]  xfs_vn_create+0x40/0x50
[  285.784724]  lookup_open+0x960/0x1580
[  285.785782]  do_last+0xd44/0x2180
[  285.786760]  path_openat+0x1a0/0x6d0
[  285.787791]  do_filp_open+0x14c/0x208
[  285.788844]  do_sys_open+0x340/0x470
[  285.789880]  __arm64_sys_openat+0x98/0xd8
[  285.791039]  el0_svc_common+0x230/0x3f0
[  285.792139]  el0_svc_handler+0x144/0x1a8
[  285.793260]  el0_svc+0x8/0x1b0
[  285.794283] XFS (dm-0): xfs_do_force_shutdown(0x8) called from line 
1047 of file fs/xfs/xfs_trans.c.  Return address = 00000000a4a366b9
[  285.816187] XFS (dm-0): Corruption of in-memory data detected. 
Shutting down filesystem
[  285.818476] XFS (dm-0): Please umount the filesystem and rectify the 
problem(s)

I found that it is not allowed to fail when alloc xfs_inode in
xfs_inode_alloc , but allow inode_init_always to report -ENOMEM?

inode_init_always is not failed by security_inode_alloc.

I have test the patch:

diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
index ceee27b70384..609ad96e29e9 100644
--- a/fs/xfs/xfs_icache.c
+++ b/fs/xfs/xfs_icache.c
@@ -43,12 +43,14 @@ xfs_inode_alloc(
          * code up to do this anyway.
          */
         ip = kmem_zone_alloc(xfs_inode_zone, KM_SLEEP);
-       if (!ip)
-               return NULL;
-       if (inode_init_always(mp->m_super, VFS_I(ip))) {
-               kmem_zone_free(xfs_inode_zone, ip);
+       if (!ip) {
+               pr_err("%s:%d\n", __func__, __LINE__);
                 return NULL;
         }
+       while (inode_init_always(mp->m_super, VFS_I(ip)) != 0) {
+               pr_err("%s:%d\n", __func__, __LINE__);
+               pr_err("111\n");
+       }

         /* VFS doesn't initialise i_mode! */
         VFS_I(ip)->i_mode = 0;
@@ -280,7 +282,7 @@ xfs_reinit_inode(
         struct xfs_mount        *mp,
         struct inode            *inode)
  {
-       int             error;
+       int             error = 0;
         uint32_t        nlink = inode->i_nlink;
         uint32_t        generation = inode->i_generation;
         uint64_t        version = inode_peek_iversion(inode);
@@ -289,7 +291,7 @@ xfs_reinit_inode(
         kuid_t          uid = inode->i_uid;
         kgid_t          gid = inode->i_gid;

-       error = inode_init_always(mp->m_super, inode);
+       while (inode_init_always(mp->m_super, inode) != 0);

         set_nlink(inode, nlink);
         inode->i_generation = generation;

syzkaller works fine.

Does anyone help me, Any suggestion is welcome.

--
BR, Jackie Liu
