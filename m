Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05D735A101E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 14:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240967AbiHYMPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 08:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231283AbiHYMPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 08:15:52 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E870AA3F7;
        Thu, 25 Aug 2022 05:15:49 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id t129so853931pfb.6;
        Thu, 25 Aug 2022 05:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=r+Amz+aPgRhl9MBfv0RiLErGeDCO34GYmLYtuobzAJA=;
        b=nmXzyfklRW2sNU4RVV+ZuP8ICw9a6TvWinqn0d0SsX2NhNLE6ZcsLrfYYeBRCWQqZG
         2CyXojQqloKK0TW7FfKaE3CvuOGcNqDH88EqgIjf3IfTYmQP4coCaITVnivpv/q1IXlA
         Sdm9Lfhx5FhUYF8gNiwMOohL7lAaWmM27oQPp2Mu8rahw0hAr9+QKUF+rXtHA+ibjLry
         GT/rGgdRgPmlGUJyzxTzSs161zKC3f7qD7hL0z2VFme8oVZ9/bOkuat17ib03CnA96yL
         aDGCtDwG55uTstcBthcgF1SNwUcYRVFUkSGGSE/liG8iwSJi3vwWnbvJRJvugD7TMeQs
         M2Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=r+Amz+aPgRhl9MBfv0RiLErGeDCO34GYmLYtuobzAJA=;
        b=dNW15CFczVxufeDEvbHb4Pjv99+bZSGzExKuGCMsgUuIjJe8TQx6UGmyMdTtS2mOzt
         c+5VLIdaVjJ9fKvDoTtIUNBnTTiGzl48XucMCZuYONArie2IMo6dp6pPBC8C/DMP6yiF
         tsdJq72DkRuD8OXWmDdHfgBRFPVs0B3Jfia57PqJLdXc4WRw3S7l1K5hy/rl8w4lyJx3
         KkpHnxQpd737NryWI2xvvnXo4YvrizY7DCt+l2tCY3rk5foTxhA5sr64r0jycmAuCIOf
         BeFqB/qI7mxKWGpblXFwelcUrlCBE/lvFocg2/CS24j5ffcDrYIsnMBry5zQb4f8IDv4
         JODQ==
X-Gm-Message-State: ACgBeo0OFwcaUbuTWyG6vdny+xsHpeLYxEY1ESw2/x65aTfZY38aeqnd
        9deKjKWVztpfY6AmVmbviHk=
X-Google-Smtp-Source: AA6agR6oHu15mLQHAuRG+8ZBcFSAbKtoW4X/sn5ORDK3RepenZohRzmjXlerTOW6cFPGScxOUmSOLQ==
X-Received: by 2002:a63:8a43:0:b0:42b:347d:4ad7 with SMTP id y64-20020a638a43000000b0042b347d4ad7mr3029960pgd.188.1661429748763;
        Thu, 25 Aug 2022 05:15:48 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id qe2-20020a17090b4f8200b001f510175984sm3363717pjb.41.2022.08.25.05.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 05:15:48 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: yang.yang29@zte.com.cn
To:     bsingharora@gmail.com, akpm@linux-foundation.org,
        iamjoonsoo.kim@lge.com
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yang Yang <yang.yang29@zte.com.cn>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>,
        wangyong <wang.yong12@zte.com.cn>
Subject: [PATCH] block: count submission time as thrashing delay for delayacct
Date:   Thu, 25 Aug 2022 12:14:28 +0000
Message-Id: <20220825121427.236333-1-yang.yang29@zte.com.cn>
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

From: Yang Yang <yang.yang29@zte.com.cn>

PSI tracks the time system waiting for refaulting pages(or called
thrashing) spent on submitting the IO[1]. Delayacct also tracks
thrashing, but we failed to update it accordingly.

And we then have the ability to detect re-entrance of thrashing
accounting for delayacct[2], so we complete the accounting now.
This will make the thrashing accounting more accurate specifically
when device is congested or the submitting cgroup IO-throttled.

[1] commit b8e24a9300b0 ("block: annotate refault stalls from IO submission")
[2] commit 317bdccd67b2 ("delayacct: support re-entrance detection of thrashing accounting")

Signed-off-by: Yang Yang (CGEL ZTE) <yang.yang29@zte.com.cn>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: Ran Xiaokai (CGEL ZTE) <ran.xiaokai@zte.com.cn>
Cc: wangyong (CGEL ZTE) <wang.yong12@zte.com.cn>
---
 block/blk-core.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index a0d1104c5590..d722ead0557f 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -41,6 +41,7 @@
 #include <linux/part_stat.h>
 #include <linux/sched/sysctl.h>
 #include <linux/blk-crypto.h>
+#include <linux/delayacct.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/block.h>
@@ -831,16 +832,19 @@ void submit_bio(struct bio *bio)
 
 	/*
 	 * If we're reading data that is part of the userspace workingset, count
-	 * submission time as memory stall.  When the device is congested, or
-	 * the submitting cgroup IO-throttled, submission can be a significant
+	 * submission time as memory stall and delay. When the device is congested,
+	 * or the submitting cgroup IO-throttled, submission can be a significant
 	 * part of overall IO time.
 	 */
 	if (unlikely(bio_op(bio) == REQ_OP_READ &&
 	    bio_flagged(bio, BIO_WORKINGSET))) {
 		unsigned long pflags;
+		bool in_thrashing;
 
+		delayacct_thrashing_start(&in_thrashing);
 		psi_memstall_enter(&pflags);
 		submit_bio_noacct(bio);
+		delayacct_thrashing_end(&in_thrashing);
 		psi_memstall_leave(&pflags);
 		return;
 	}
-- 
2.25.1

