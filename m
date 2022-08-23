Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EBDE59E5EC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 17:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241826AbiHWPXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 11:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244744AbiHWPQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 11:16:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2523B1D0D85
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 03:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661250772;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=/7B7tsXp66/9aCmeuLAxDC7tXxat0QsJzIWKfv9VwQc=;
        b=hopomMNDlOL4WxzqAhtFz8/GuK/d8Dxnt21+F4E3ZZZA2yWtB7jOkM8/udgVuHg8KNhMIi
        nI/Vp+JnCoPE459Tu9bUvOO4JcX+G2K2B4NaaDa2yxfxEZFFQQxsdi9+GblsR5ffGO60yX
        Lp10dLXTPVLNSyVa3CQMJfd4VLmTGmA=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-500-5K4sABfaORqWDyxRGvgR1g-1; Tue, 23 Aug 2022 06:32:51 -0400
X-MC-Unique: 5K4sABfaORqWDyxRGvgR1g-1
Received: by mail-pl1-f198.google.com with SMTP id x7-20020a170902ec8700b00172eaf25822so3511115plg.12
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 03:32:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=/7B7tsXp66/9aCmeuLAxDC7tXxat0QsJzIWKfv9VwQc=;
        b=xkzQFunCfxSzsQdW2H3bt42F/tbsLY9UGp/xSk8fYcjJ7LeMA3nc/sIJEwqxIyFluZ
         oYp5j2yj0dy36tr1HyycHG48lchCoktiKcwFaZxHdq/WLRHSo7zj0w6iXK8GXpQY14Z5
         CApENeCZX/3xYkf8FT2uSKw0E2joO1QuWsFAReVb1VfkTvw4G6sbbyubdRnVPFpg7YcB
         1S6EacZ3Bt7hV0Juj589Z3OkLfa28ynGMbB/nTRYtHK3U2kK4DrVCY5wHPjstAxWktuv
         SW6HiSmPey/fsXvxf303F54qIzzwyFq352dVVMNcTNN/w+rdnHT8JFjctAtkqV2vcNL1
         HOLg==
X-Gm-Message-State: ACgBeo2cv7vcv5+ZRkl0fVraBycmw6AT0KQy1cwqYUDFJW/ncEkaNWll
        h+HfeEWnzfSpNlvWNf97GqSCtNQXDkc/kvS7tD64ISBXUgBVSU31WBARHBqBAW9Iug6sOW8KPqG
        PzvTjR55GzpWrN4gMDfQ3xojb
X-Received: by 2002:a17:90b:388e:b0:1fb:62c1:9cb7 with SMTP id mu14-20020a17090b388e00b001fb62c19cb7mr2376264pjb.207.1661250770091;
        Tue, 23 Aug 2022 03:32:50 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6iUm2WmP1VFW5pKsIifzT1lsCFYmGmekjg+OIP+inBS9uOxw2yUraGZCxAbxxhzTwSWAiNsA==
X-Received: by 2002:a17:90b:388e:b0:1fb:62c1:9cb7 with SMTP id mu14-20020a17090b388e00b001fb62c19cb7mr2376248pjb.207.1661250769833;
        Tue, 23 Aug 2022 03:32:49 -0700 (PDT)
Received: from xps13.. ([240d:1a:c0d:9f00:4f2f:926a:23dd:8588])
        by smtp.gmail.com with ESMTPSA id u6-20020a170902e5c600b0016d88dc7745sm10128914plf.259.2022.08.23.03.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 03:32:49 -0700 (PDT)
From:   Shigeru Yoshida <syoshida@redhat.com>
To:     almaz.alexandrovich@paragon-software.com
Cc:     ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org,
        Shigeru Yoshida <syoshida@redhat.com>,
        syzbot+9d67170b20e8f94351c8@syzkaller.appspotmail.com
Subject: [PATCH] fs/ntfs3: Fix memory leak on ntfs_fill_super() error path
Date:   Tue, 23 Aug 2022 19:32:05 +0900
Message-Id: <20220823103205.1380235-1-syoshida@redhat.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot reported kmemleak as below:

BUG: memory leak
unreferenced object 0xffff8880122f1540 (size 32):
  comm "a.out", pid 6664, jiffies 4294939771 (age 25.500s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 ed ff ed ff 00 00 00 00  ................
  backtrace:
    [<ffffffff81b16052>] ntfs_init_fs_context+0x22/0x1c0
    [<ffffffff8164aaa7>] alloc_fs_context+0x217/0x430
    [<ffffffff81626dd4>] path_mount+0x704/0x1080
    [<ffffffff81627e7c>] __x64_sys_mount+0x18c/0x1d0
    [<ffffffff84593e14>] do_syscall_64+0x34/0xb0
    [<ffffffff84600087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

This patch fixes this issue by freeing mount options on error path of
ntfs_fill_super().

Reported-by: syzbot+9d67170b20e8f94351c8@syzkaller.appspotmail.com
Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
---
 fs/ntfs3/super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index 47012c9bf505..c0e45f170701 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -1281,6 +1281,7 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	 * Free resources here.
 	 * ntfs_fs_free will be called with fc->s_fs_info = NULL
 	 */
+	put_mount_options(sbi->options);
 	put_ntfs(sbi);
 	sb->s_fs_info = NULL;
 
-- 
2.37.2

