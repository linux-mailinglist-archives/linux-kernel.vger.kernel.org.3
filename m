Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE8C74FBAF9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 13:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344196AbiDKLeE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 07:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233448AbiDKLeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 07:34:02 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0AD6427E7;
        Mon, 11 Apr 2022 04:31:48 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id z6-20020a17090a398600b001cb9fca3210so2646733pjb.1;
        Mon, 11 Apr 2022 04:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5V9gANNP78HNk46P8d3IKzU6YI+VocisWdMkFLXxFjQ=;
        b=CVQ3e85XziFIEiQW6RqB5TnDiKtN9UtIw/6JmrZ01HhRNhtc0hbECRF8Pc0Hub0xOa
         5jenQYTb0bOhWTF6FWmZWdY0upF1exYK0dF862UKo+yBIDEMJsY+fpdaNVGpnePbW3Oz
         KTAYAO2rkqmrfPBtCBahSN1DSWSn9RHCRjWxh81NhvnSeIMozQLcrPDOyMUVOgMkGHka
         PzojPx8aXXtiyQ/ZKnaZMRzxgpVPwlkqetzg9HGhUWHQViUbCtStQzp5tdRpB5dGQmpe
         k19IzVMc8+xbzKqiRBHpLBAPk02vOuUSMirNNJob2X8DvD/cauXhArMjqPzH3+Xo8s5L
         Wr1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5V9gANNP78HNk46P8d3IKzU6YI+VocisWdMkFLXxFjQ=;
        b=MbhTFe4vu3u8b393mBpwSdd3U4TqDqPB62oWw2tC+D2fqMmnTk3yVZX8nTjnUwlu/N
         Jgnpz0EM8vFtQlZzEshyQwUlX2Tb0Lzv2f5cLZMjbu4r/aBKPE96N1KNXIUo4dd/BlRR
         IZF3Sw8wQvvGamG6BHKYagpV3QL+u5EpEa59H7PmbWB4KVULuafsMIqBws5mwHavIpD/
         M5W80ZnwRdBcEmHfSSEov/VoReON6VU2G4euKRhGpVOx+79J/WfrcVkFwk3MrgvHykKt
         aCwiJpp49D+Pw29AKmm4ZPbZyR/a0ixPEifP/Pm3uicOPEvWt4semPczMigNHTnwvw2m
         fsNg==
X-Gm-Message-State: AOAM532uTv5cwXuaXNMgYRf0i6rR1gnMu4on0NG6bMxQY6TCEwW4JC5S
        5njnJlCUcjO03duT3I42s10=
X-Google-Smtp-Source: ABdhPJzCRcCgGhH5kklWc3sLB+hpcv6p1s2+3KaE2JXE4OHXf/WVQLhmducaPpJKwulC0f9FBxm2Dg==
X-Received: by 2002:a17:90a:d083:b0:1c9:94bb:732d with SMTP id k3-20020a17090ad08300b001c994bb732dmr36393061pju.106.1649676708426;
        Mon, 11 Apr 2022 04:31:48 -0700 (PDT)
Received: from localhost ([166.111.139.106])
        by smtp.gmail.com with ESMTPSA id y30-20020a056a001c9e00b004fa9246adcbsm33587529pfw.144.2022.04.11.04.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 04:31:47 -0700 (PDT)
From:   Zixuan Fu <r33s3n6@gmail.com>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        baijiaju1990@gmail.com, Zixuan Fu <r33s3n6@gmail.com>,
        TOTE Robot <oslab@tsinghua.edu.cn>
Subject: [PATCH] fs: xfs: fix possible NULL pointer dereference in xfs_rw_bdev()
Date:   Mon, 11 Apr 2022 19:31:45 +0800
Message-Id: <20220411113145.797121-1-r33s3n6@gmail.com>
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
return NULL. In this case, the variable "bio" in xfs_rw_bdev() would be
NULL and then it is dereferenced in "bio_set_dev(bio, bdev)".

The failure log is listed as follows:

[   16.009947] BUG: kernel NULL pointer dereference, address: 0000000000000015
...
[   16.012406] RIP: 0010:bio_set_dev+0x76/0x160 [xfs]
...
[   16.017773] Call Trace:
[   16.017925]  <TASK>
[   16.018065]  xfs_rw_bdev+0x29e/0x9f0 [xfs]
[   16.018396]  ? _raw_spin_unlock_irqrestore+0x3c/0x70
[   16.018697]  xlog_do_io+0x183/0x4a0 [xfs]
[   16.019019]  xlog_bwrite+0x73/0xc0 [xfs]
[   16.019333]  xlog_write_log_records+0x457/0x5c0 [xfs]
[   16.019723]  xlog_clear_stale_blocks+0x2d1/0x430 [xfs]
[   16.020107]  xlog_find_tail+0x63d/0xb60 [xfs]
[   16.020447]  xlog_recover+0x77/0x650 [xfs]
[   16.021101]  xfs_log_mount+0x720/0xcf0 [xfs]
[   16.021437]  xfs_mountfs+0xf0c/0x2440 [xfs]
[   16.021767]  xfs_fs_fill_super+0x1eaa/0x21e0 [xfs]
[   16.022132]  get_tree_bdev+0x3c3/0x5f0
[   16.022361]  ? xfs_fs_warn_deprecated+0x100/0x100 [xfs]
[   16.022750]  xfs_fs_get_tree+0x68/0xb0 [xfs]
[   16.023090]  vfs_get_tree+0x81/0x220
[   16.023308]  path_mount+0x1061/0x2340
[   16.023532]  ? kasan_quarantine_put+0x2c/0x1a0
[   16.023804]  ? slab_free_freelist_hook+0xde/0x160
[   16.024087]  ? mark_mounts_for_expiry+0x410/0x410
[   16.024370]  ? user_path_at_empty+0xf6/0x160
[   16.024629]  ? kmem_cache_free+0xb8/0x1a0
[   16.024876]  ? user_path_at_empty+0xf6/0x160
[   16.025134]  __se_sys_mount+0x217/0x2b0
[   16.025367]  ? __x64_sys_mount+0xd0/0xd0
[   16.025605]  ? exit_to_user_mode_prepare+0x32/0x130
[   16.025899]  do_syscall_64+0x41/0x90
[   16.026116]  entry_SYSCALL_64_after_hwframe+0x44/0xae
...
[   16.030310]  </TASK>

This patch adds a NULL check of "bio" and return -ENOMEM if it's NULL.

Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
Signed-off-by: Zixuan Fu <r33s3n6@gmail.com>
---
 fs/xfs/xfs_bio_io.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/xfs/xfs_bio_io.c b/fs/xfs/xfs_bio_io.c
index ae4345b37621..37887029a6c7 100644
--- a/fs/xfs/xfs_bio_io.c
+++ b/fs/xfs/xfs_bio_io.c
@@ -28,6 +28,8 @@ xfs_rw_bdev(
 
 	bio = bio_alloc(bdev, bio_max_vecs(left), op | REQ_META | REQ_SYNC,
 			GFP_KERNEL);
+	if (!bio)
+		return -ENOMEM;
 	bio->bi_iter.bi_sector = sector;
 
 	do {
-- 
2.25.1

