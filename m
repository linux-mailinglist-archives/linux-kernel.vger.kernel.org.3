Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 735C850270D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 10:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351531AbiDOIwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 04:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232347AbiDOIwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 04:52:12 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0461C1EEFA
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 01:49:43 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R901e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VA6o-rv_1650012574;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VA6o-rv_1650012574)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 15 Apr 2022 16:49:40 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     jaegeuk@kernel.org
Cc:     chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] f2fs: Fix signedness bugs in f2fs_gc_pinned_control functions
Date:   Fri, 15 Apr 2022 16:49:31 +0800
Message-Id: <20220415084931.49880-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following smatch warning:

fs/f2fs/gc.c:688 f2fs_gc_pinned_control() warn: signedness bug returning
'(-16)'.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 fs/f2fs/gc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 34c097a7821d..4c8ce02a815b 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -679,7 +679,7 @@ static void f2fs_unpin_all_sections(struct f2fs_sb_info *sbi, bool enable)
 	DIRTY_I(sbi)->enable_pin_section = enable;
 }
 
-static bool f2fs_gc_pinned_control(struct inode *inode, int gc_type,
+static int f2fs_gc_pinned_control(struct inode *inode, int gc_type,
 							unsigned int segno)
 {
 	if (!f2fs_is_pinned_file(inode))
-- 
2.20.1.7.g153144c

