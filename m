Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3704FBB03
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 13:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343808AbiDKLfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 07:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237098AbiDKLfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 07:35:22 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED3644553D;
        Mon, 11 Apr 2022 04:33:08 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id q142so13896771pgq.9;
        Mon, 11 Apr 2022 04:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d0G3ixB92qwgTA41l9ocNesTRW2JojJDnB4Iqey5Sio=;
        b=JBamKgIpJ9LTPyhHtA1OgmkyWh2tNfbjhdN8ot8D8DsgIwVwZrY5XmLlM0PXOFYeuY
         9OvT+ROOBccpeVNtxmvscgur2ymuxDF8ZGzeanTP3Tleta5BUZzYQ/h6D6/r8Ze4rf16
         53OOxHgZ7SUnf6fw41tnlNkUukfOYihOLQI0Q8WGJEjgNUVycKz32caBKRKBZogKd3gp
         rDO7ep3AUbMA913Rhw+raJxuIF0WBey+9UalrRMUv5PpkDfVLnoPssdGN73m6GUr3RFu
         Hyj7aUAYhBJL7/szsLpv61IbpjBDsktDTKdkTzdDhT7OVIsiXDOJ5g9kIrsaf8tG8lb0
         PkDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d0G3ixB92qwgTA41l9ocNesTRW2JojJDnB4Iqey5Sio=;
        b=aXGoyRxFtv+l+eZ57tP9RhN7ZaqKBELRAi086wh2eMZ7yFheZh0mKYtQshnR/u75j0
         hxDPXjxiremmpnrWSf0db2PILvMhgPD1CdNhprqW6ryIW1rCuxeVNBd1bnTOGx7FnjuZ
         f5+fkhiUdV3nuhUiTUH0YleUgiG7yTlpLPpFdi127iY/ujL0skFqBa8VLTr6EUI0BgNg
         yZMorj2gjlKHa8zWpi0eo53u/CL7ic6AVO+Vugym1iwRfbzQBof3mhyIBRMkGH0i1Ki0
         NacaHHI96Q6QKKrazW5XTMJGGaS6fXfCrmARsRdczeVG5IlrLa+PrBnIWqiZiidI3b5R
         qqSg==
X-Gm-Message-State: AOAM532ckXIIZaOQNjio4E+MF2tlrfLw7nNFjgD2uh+b2rGHQ3wGQNkA
        iYcY4B+wmxctgQagFr88Gh0=
X-Google-Smtp-Source: ABdhPJzlTUGEvYEO6cs4FWwL/g97zUiBYkIVYPfvOf7CBaVSJDSltEFU7/WCEt9uBFk7WjSXO5Bomw==
X-Received: by 2002:a63:de45:0:b0:39c:c255:b30 with SMTP id y5-20020a63de45000000b0039cc2550b30mr18470548pgi.82.1649676788451;
        Mon, 11 Apr 2022 04:33:08 -0700 (PDT)
Received: from localhost ([166.111.139.106])
        by smtp.gmail.com with ESMTPSA id x5-20020aa79a45000000b00505c1ab148esm3697360pfj.131.2022.04.11.04.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 04:33:07 -0700 (PDT)
From:   Zixuan Fu <r33s3n6@gmail.com>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        baijiaju1990@gmail.com, Zixuan Fu <r33s3n6@gmail.com>,
        TOTE Robot <oslab@tsinghua.edu.cn>
Subject: [PATCH] fs: xfs: fix possible NULL pointer dereference in xfs_buf_ioapply_map()
Date:   Mon, 11 Apr 2022 19:32:50 +0800
Message-Id: <20220411113250.797833-1-r33s3n6@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In our fault-injection testing, bio_alloc() may fail with low memory and
return NULL. In this case, the variable "bio" in xfs_buf_ioapply_map()
would be NULL and then it is dereferenced by the next instruction
"bio->bi_iter.bi_sector".

The failure log is listed as follows:

[   11.929658] BUG: kernel NULL pointer dereference, address: 0000000000000015
...
[   11.932963] RIP: 0010:xfs_buf_ioapply_map+0x2cc/0x6f0 [xfs]
...
[   11.940043] Call Trace:
[   11.940247]  <TASK>
[   11.940416]  ? _raw_spin_unlock_irqrestore+0x3c/0x70
[   11.940827]  _xfs_buf_ioapply+0x134/0x4d0 [xfs]
[   11.941256]  __xfs_buf_submit+0x585/0x7a0 [xfs]
[   11.941684]  ? _xfs_buf_read+0xb7/0x120 [xfs]
[   11.942127]  _xfs_buf_read+0xb7/0x120 [xfs]
[   11.942535]  xfs_buf_read_map+0x1ba/0x650 [xfs]
[   11.942981]  ? xfs_read_agf+0x163/0x260 [xfs]
[   11.943394]  xfs_trans_read_buf_map+0x37c/0x850 [xfs]
[   11.943883]  ? xfs_read_agf+0x163/0x260 [xfs]
[   11.944306]  ? xfs_read_agf+0x163/0x260 [xfs]
[   11.944725]  xfs_read_agf+0x163/0x260 [xfs]
[   11.945141]  xfs_alloc_read_agf+0xc5/0x480 [xfs]
[   11.945574]  xfs_alloc_pagf_init+0x89/0x150 [xfs]
[   11.946037]  xfs_ag_resv_init+0x14b/0x5c0 [xfs]
[   11.946471]  xfs_fs_reserve_ag_blocks+0xf3/0x290 [xfs]
[   11.946961]  xfs_mountfs+0x2298/0x2440 [xfs]
[   11.947372]  xfs_fs_fill_super+0x1eaa/0x21e0 [xfs]
[   11.947840]  get_tree_bdev+0x3c3/0x5f0
[   11.948136]  ? xfs_fs_warn_deprecated+0x100/0x100 [xfs]
[   11.948633]  xfs_fs_get_tree+0x68/0xb0 [xfs]
[   11.949056]  vfs_get_tree+0x81/0x220
[   11.949336]  path_mount+0x1061/0x2340
[   11.949619]  ? kasan_quarantine_put+0x2c/0x1a0
[   11.949991]  ? slab_free_freelist_hook+0xde/0x160
[   11.950360]  ? mark_mounts_for_expiry+0x410/0x410
[   11.950729]  ? user_path_at_empty+0xf6/0x160
[   11.951072]  ? kmem_cache_free+0xb8/0x1a0
[   11.951384]  ? user_path_at_empty+0xf6/0x160
[   11.951717]  __se_sys_mount+0x217/0x2b0
[   11.952001]  ? __x64_sys_mount+0xd0/0xd0
[   11.952277]  ? exit_to_user_mode_prepare+0x32/0x130
[   11.952664]  do_syscall_64+0x41/0x90
[   11.952960]  entry_SYSCALL_64_after_hwframe+0x44/0xae
...
[   11.958483]  </TASK>

This patch adds a NULL check of "bio" and return immediately if it's NULL.

Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
Signed-off-by: Zixuan Fu <r33s3n6@gmail.com>
---
 fs/xfs/xfs_buf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
index e1afb9e503e1..1be98503b538 100644
--- a/fs/xfs/xfs_buf.c
+++ b/fs/xfs/xfs_buf.c
@@ -1447,6 +1447,9 @@ xfs_buf_ioapply_map(
 	nr_pages = bio_max_segs(total_nr_pages);
 
 	bio = bio_alloc(bp->b_target->bt_bdev, nr_pages, op, GFP_NOIO);
+	if (!bio)
+		return;
+
 	bio->bi_iter.bi_sector = sector;
 	bio->bi_end_io = xfs_buf_bio_end_io;
 	bio->bi_private = bp;
-- 
2.25.1

