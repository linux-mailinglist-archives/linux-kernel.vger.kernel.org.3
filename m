Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2684FB9F0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 12:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345736AbiDKKsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 06:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345729AbiDKKsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 06:48:03 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBEE4186FB
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 03:45:49 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 2so14897075pjw.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 03:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cgk0yjKGyZZ3WohS+RmN42unOs/YYInKeZtRcK9rHyc=;
        b=gR7aCeFK8v+Ud8TJUkbFoMyayQnEYDODrBnCfGbeG+zb/RynV+cSpzceKrCZ5wMykZ
         dmJ1GCm/a3zMbg2EZrRMFm9rFK6SfVp585WTnBPAGnRhFkFdxq/Fi6o8ahj9YNhlKa1k
         tYejK/UOqD1IWv4LiIG72TIA0oT0endbHK/XAj4Qt5hlG//asSja7TYXrYOdBaV+iH83
         Rs25nlpMwGJPWu+zM9ND3b8btzxciDcXgK4kFstlGu73V49WeVebIlsbvkHUSjbBsKeA
         VtuJyupg7BJOt8WIbFjM8OU8zt8gOg2WqRrHL9HNKC9GbrXj+kAibXOjG67rBu6KlGvW
         V1mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cgk0yjKGyZZ3WohS+RmN42unOs/YYInKeZtRcK9rHyc=;
        b=D8mypGMFuMAjnn3tquaOFUSTvRkOftjG4QzpvBmXfebBnmZzeDucU0qo6QKd8SH+hv
         ydxmp31dUjGX7AL7KHVsXct96VaY92rSlPUUKLTu+2S1NERuk0oF/K1j0GnMzhK0oTjs
         3RA9ptwhBR1/MLvY9EWPW/sT/GiFST90sUK213XQ4xCrpD8KiOM7339gcuykxYEnjYH8
         +CZHYlFJOQyF5PZoeGmrjdp4jMQMAQl8z+aF1CB+wHJ61xXVPAlDA08b6UsPJ5mRL1su
         7E4OI72F1H/Jt9vVDhRMPoD5iGammYXzwUGRDfX7t7UCyls/IXjpmkNGCsNb4jDBicke
         xZ1A==
X-Gm-Message-State: AOAM530VqZYhKEtTwGYQ/25MwrxfY65eQXasBFYPilzzBs8Zpj5vkBg1
        WzkHZ6xEUcGnhrQalMrD7tU=
X-Google-Smtp-Source: ABdhPJzw3WifQ58vmxssYy00TXa8ner2CIBlECSTkKcTdxtfk4IL9t+EkZ1GK3YfBLY9hzTzhgfAFA==
X-Received: by 2002:a17:902:e74c:b0:158:5c47:9181 with SMTP id p12-20020a170902e74c00b001585c479181mr5317652plf.144.1649673949337;
        Mon, 11 Apr 2022 03:45:49 -0700 (PDT)
Received: from fuzzserver.tsinghua.edu.cn ([166.111.139.106])
        by smtp.gmail.com with ESMTPSA id s10-20020a63a30a000000b003987eaef296sm29086232pge.44.2022.04.11.03.45.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 03:45:48 -0700 (PDT)
From:   Zixuan Fu <r33s3n6@gmail.com>
To:     shaggy@kernel.org
Cc:     jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        baijiaju1990@gmail.com, Zixuan Fu <r33s3n6@gmail.com>,
        TOTE Robot <oslab@tsinghua.edu.cn>
Subject: [PATCH] fs: jfs: fix possible NULL pointer dereference in dbFree()
Date:   Mon, 11 Apr 2022 18:45:34 +0800
Message-Id: <20220411104534.744772-1-r33s3n6@gmail.com>
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

In our fault-injection testing, the variable "nblocks" in dbFree() can be
zero when kmalloc_array() fails in dtSearch(). In this case, the variable
 "mp" in dbFree() would be NULL and then it is dereferenced in 
"write_metapage(mp)".

The failure log is listed as follows:

[   13.824137] BUG: kernel NULL pointer dereference, address: 0000000000000020
...
[   13.827416] RIP: 0010:dbFree+0x5f7/0x910 [jfs]
[   13.834341] Call Trace:
[   13.834540]  <TASK>
[   13.834713]  txFreeMap+0x7b4/0xb10 [jfs]
[   13.835038]  txUpdateMap+0x311/0x650 [jfs]
[   13.835375]  jfs_lazycommit+0x5f2/0xc70 [jfs]
[   13.835726]  ? sched_dynamic_update+0x1b0/0x1b0
[   13.836092]  kthread+0x3c2/0x4a0
[   13.836355]  ? txLockFree+0x160/0x160 [jfs]
[   13.836763]  ? kthread_unuse_mm+0x160/0x160
[   13.837106]  ret_from_fork+0x1f/0x30
[   13.837402]  </TASK>
...

This patch adds a NULL check of "mp" before "write_metapage(mp)" is called.

Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
Signed-off-by: Zixuan Fu <r33s3n6@gmail.com>
---
 fs/jfs/jfs_dmap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
index d8502f4989d9..e75f31b81d63 100644
--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -385,7 +385,8 @@ int dbFree(struct inode *ip, s64 blkno, s64 nblocks)
 	}
 
 	/* write the last buffer. */
-	write_metapage(mp);
+	if (mp)
+		write_metapage(mp);
 
 	IREAD_UNLOCK(ipbmap);
 
-- 
2.25.1

