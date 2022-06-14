Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B74B54A84E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 06:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237741AbiFNErb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 00:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237137AbiFNErZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 00:47:25 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 490F825D2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 21:47:23 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id r1so6791435plo.10
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 21:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5x24wcoZLy60C4V6qqBlV8yjrlN4lvCBwUUm7SMMskg=;
        b=S+kBJOM5he9vqHt4nGu5s3ieVT63/VfE3eDWB+riit4ao7KJ8K5/8h/MVmbsTlqUj/
         WAi2EathAkRGzkUjYjUYTEm8s0nZD7B9pQGk6uirSUoyalVq2+Ig8Y8IE6Q8/+3bpmTm
         mBnEYC37/PPXGwRVKNFlSHeJVEX95yQk8VVV0LQ7wolTW62LSKYuAnoniKXQ7VeS2TkL
         Py2Z8rBGttnxvesyGysFJHSIQ6AcPCUHBmftBxyQRtC4tgAg4OOYfq8vl43zxIQk8gVK
         Xt83xGGdkSKPmdz3zoKqUahAO+HZNqAsPk0SWWrIlsrTvwe7NmJ9SQAvPaeI4fNT5tPt
         SUQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5x24wcoZLy60C4V6qqBlV8yjrlN4lvCBwUUm7SMMskg=;
        b=jsJOwR+d13CTngJ47Iw8OL0FQXjZqMFs1Gtz6+z++aGkc8fQsdSsAZfVWnfcmPy2FQ
         iqEMKxTuWgapPOTxrexLQjFDCyuVun2u5mx73EJfvy5OudjnGETw/SqO6OZpeIoavRwL
         lkZg9B1Fjj8jB5wh11Tw5WipgrsILpRHGikHJrwm5+Ip2yAtEaLadnVc27hho+9RVJKP
         kBiumN+/zY0Mf/cP6LGDro/T8q2Chj9RgfCIsjJJWIp40uZ2DxvelssmW4oZzmhh2vZd
         Lg/qU/6GcQ3g0+WASJdFaswc+B1Np3F9u+2w5oRklFuCKPIJoZZJRM8paKjs4zA3rLZf
         JLIg==
X-Gm-Message-State: AOAM533mBKY/9/jGkP/TbCi6BEHeBc0W2BMJ4m38+njMDekS+PxrkJuB
        NbtJrD9uWtHJC4CS9Sqn5iGMeg==
X-Google-Smtp-Source: ABdhPJzmOo7I9AwFFk5wSFL3fr25zTCJ91yKbcbcQxih7dUz8lgAf6OyEUoocpDXLgGzZyN9t4U4Ag==
X-Received: by 2002:a17:902:ec83:b0:168:e5ad:8071 with SMTP id x3-20020a170902ec8300b00168e5ad8071mr2587430plg.102.1655182042780;
        Mon, 13 Jun 2022 21:47:22 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id u20-20020a62d454000000b00518285976cdsm6312948pfl.9.2022.06.13.21.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 21:47:22 -0700 (PDT)
From:   Jinke Han <hanjinke.666@bytedance.com>
X-Google-Original-From: Jinke Han <hnajinke.666@bytedance>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        hanjinke.666@bytedance.com
Subject: [PATCH] ext4: fix trim range leak
Date:   Tue, 14 Jun 2022 12:46:47 +0800
Message-Id: <20220614044647.21846-1-hanjinke.666@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: hanjinke <hanjinke.666@bytedance.com>

When release group lock, a large number of blocks may be alloc from
the group(e.g. not from the rest of target trim range). This may
lead end of the loop and leave the rest of trim range unprocessed.

Signed-off-by: hanjinke <hanjinke.666@bytedance.com>
---
 fs/ext4/mballoc.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 9f12f29bc346..45eb9ee20947 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -6345,14 +6345,13 @@ static int ext4_try_to_trim_range(struct super_block *sb,
 __acquires(ext4_group_lock_ptr(sb, e4b->bd_group))
 __releases(ext4_group_lock_ptr(sb, e4b->bd_group))
 {
-	ext4_grpblk_t next, count, free_count;
+	ext4_grpblk_t next, count;
 	void *bitmap;
 
 	bitmap = e4b->bd_bitmap;
 	start = (e4b->bd_info->bb_first_free > start) ?
 		e4b->bd_info->bb_first_free : start;
 	count = 0;
-	free_count = 0;
 
 	while (start <= max) {
 		start = mb_find_next_zero_bit(bitmap, max + 1, start);
@@ -6367,7 +6366,6 @@ __releases(ext4_group_lock_ptr(sb, e4b->bd_group))
 				break;
 			count += next - start;
 		}
-		free_count += next - start;
 		start = next + 1;
 
 		if (fatal_signal_pending(current)) {
@@ -6381,8 +6379,6 @@ __releases(ext4_group_lock_ptr(sb, e4b->bd_group))
 			ext4_lock_group(sb, e4b->bd_group);
 		}
 
-		if ((e4b->bd_info->bb_free - free_count) < minblocks)
-			break;
 	}
 
 	return count;
-- 
2.20.1

