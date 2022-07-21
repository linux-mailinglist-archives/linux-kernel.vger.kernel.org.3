Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD75C57C29A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 05:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbiGUDS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 23:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiGUDS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 23:18:56 -0400
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 664885A17D
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 20:18:55 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VJzWb5G_1658373523;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VJzWb5G_1658373523)
          by smtp.aliyun-inc.com;
          Thu, 21 Jul 2022 11:18:52 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     almaz.alexandrovich@paragon-software.com
Cc:     ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] fs/ntfs3: Remove unused function wnd_bits
Date:   Thu, 21 Jul 2022 11:18:41 +0800
Message-Id: <20220721031841.24571-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the function wnd_bits is defined but not called in any file, it is
a useless function, and we delete it in view of the brevity of the code.

Remove some warnings found by running scripts/kernel-doc, which is
caused by using 'make W=1'.

fs/ntfs3/bitmap.c:54:19: warning: unused function 'wnd_bits' [-Wunused-function].

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 fs/ntfs3/bitmap.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/fs/ntfs3/bitmap.c b/fs/ntfs3/bitmap.c
index e3b5680fd516..177c5bc53373 100644
--- a/fs/ntfs3/bitmap.c
+++ b/fs/ntfs3/bitmap.c
@@ -51,11 +51,6 @@ void ntfs3_exit_bitmap(void)
 	kmem_cache_destroy(ntfs_enode_cachep);
 }
 
-static inline u32 wnd_bits(const struct wnd_bitmap *wnd, size_t i)
-{
-	return i + 1 == wnd->nwnd ? wnd->bits_last : wnd->sb->s_blocksize * 8;
-}
-
 /*
  * wnd_scan
  *
-- 
2.20.1.7.g153144c

