Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76F1E546C64
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 20:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346315AbiFJSc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 14:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233646AbiFJScw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 14:32:52 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 274F337AA5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 11:32:51 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id o6so18351326plg.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 11:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wBbbnyxAp776PF/MoHr2OTyzExEVGSOzu1ia9Yc3H1I=;
        b=Q5B2LvQMun4KV1/iBHtpnFzF8ZF0cRO+ulZr7uc4CBP6lDhcOHhHZpvnirmdt8SUYQ
         B/n612LXFpiD5oBtzSVEmggJzllxcE4RLtC1+R5BBsOJIimuG+euZamHED1O37WzcUwM
         QxYw2NwMHWuQ6NGVB/Vmnn7xP2uKMLJ1zOLcK/zUBVzUrtcglzny7vBmKS3ainZ1DNNF
         lixEshxk6vsx6SO8N/2aNvpkRbaLmD0GbpJa8Cnd7nnrIOxA2y2tbL9N1p5IGH3YRKPg
         Y3QmytvOStuLhIHv3NT4Cxgc9wFNnIB5XxZv/VRUq5SxbSGeSXpI4eWyjqGvkx17Do6g
         VFrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wBbbnyxAp776PF/MoHr2OTyzExEVGSOzu1ia9Yc3H1I=;
        b=hp7E4lhd3vB0jS354e49bnu5XAbjFhK3GEb7tQpiuDvrPNXHmulhOqugnwiF3F0K2O
         Kscdg0xvHuiMWMbSmKBFZRU6JhmPs1v6AP+hAiTS8BY1bv1Pks4cBx1J9JZcx0EwPJqs
         wwSp6pajdSKlP59WpFIRH8x/uk4kFMFJie27J8utdcsKUsvgxG7vzJAMUPqW2GkPbm8W
         RTTO/BoEPEdTag9v1kgCZlhIU6nmAV/jdztPHtlGd8jGhyNn9JC9aLYIMjC/MwyYd976
         bje661uv2V/+lwbNPzvR0J4B1Vz9VMs+Bi7UE4rqFhlLSg2RIZlq3Tn/oWWvENE11/aP
         LzPw==
X-Gm-Message-State: AOAM533ckuhBDxuSOzm8ymf+GkYzF1jUNftbyJH4v0yaGx9VlueOmTOY
        8909zOT9raTLLnrPvViyYsvSBUYFLWw=
X-Google-Smtp-Source: ABdhPJwSAuNuM9jqLVqZXSAsYNlqY0zT0OmxOY2NN+1B/MwSfK6lo2bq+uZCH+VLXZNb6OzPO/5XIA==
X-Received: by 2002:a17:90a:7841:b0:1ea:3f61:7673 with SMTP id y1-20020a17090a784100b001ea3f617673mr1041199pjl.110.1654885970124;
        Fri, 10 Jun 2022 11:32:50 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com ([2620:15c:211:201:9407:3889:1417:db63])
        by smtp.gmail.com with ESMTPSA id w15-20020a1709026f0f00b001677d4a9654sm23086plk.265.2022.06.10.11.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 11:32:49 -0700 (PDT)
From:   Daeho Jeong <daeho43@gmail.com>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
Subject: [PATCH] f2fs: fix iostat related lock protection
Date:   Fri, 10 Jun 2022 11:32:40 -0700
Message-Id: <20220610183240.2269085-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
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

From: Daeho Jeong <daehojeong@google.com>

Made iostat related locks safe to be called from irq context again.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fs/f2fs/iostat.c | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/fs/f2fs/iostat.c b/fs/f2fs/iostat.c
index be599f31d3c4..d84c5f6cc09d 100644
--- a/fs/f2fs/iostat.c
+++ b/fs/f2fs/iostat.c
@@ -91,8 +91,9 @@ static inline void __record_iostat_latency(struct f2fs_sb_info *sbi)
 	unsigned int cnt;
 	struct f2fs_iostat_latency iostat_lat[MAX_IO_TYPE][NR_PAGE_TYPE];
 	struct iostat_lat_info *io_lat = sbi->iostat_io_lat;
+	unsigned long flags;
 
-	spin_lock_bh(&sbi->iostat_lat_lock);
+	spin_lock_irqsave(&sbi->iostat_lat_lock, flags);
 	for (idx = 0; idx < MAX_IO_TYPE; idx++) {
 		for (io = 0; io < NR_PAGE_TYPE; io++) {
 			cnt = io_lat->bio_cnt[idx][io];
@@ -106,7 +107,7 @@ static inline void __record_iostat_latency(struct f2fs_sb_info *sbi)
 			io_lat->bio_cnt[idx][io] = 0;
 		}
 	}
-	spin_unlock_bh(&sbi->iostat_lat_lock);
+	spin_unlock_irqrestore(&sbi->iostat_lat_lock, flags);
 
 	trace_f2fs_iostat_latency(sbi, iostat_lat);
 }
@@ -115,14 +116,15 @@ static inline void f2fs_record_iostat(struct f2fs_sb_info *sbi)
 {
 	unsigned long long iostat_diff[NR_IO_TYPE];
 	int i;
+	unsigned long flags;
 
 	if (time_is_after_jiffies(sbi->iostat_next_period))
 		return;
 
 	/* Need double check under the lock */
-	spin_lock_bh(&sbi->iostat_lock);
+	spin_lock_irqsave(&sbi->iostat_lock, flags);
 	if (time_is_after_jiffies(sbi->iostat_next_period)) {
-		spin_unlock_bh(&sbi->iostat_lock);
+		spin_unlock_irqrestore(&sbi->iostat_lock, flags);
 		return;
 	}
 	sbi->iostat_next_period = jiffies +
@@ -133,7 +135,7 @@ static inline void f2fs_record_iostat(struct f2fs_sb_info *sbi)
 				sbi->prev_rw_iostat[i];
 		sbi->prev_rw_iostat[i] = sbi->rw_iostat[i];
 	}
-	spin_unlock_bh(&sbi->iostat_lock);
+	spin_unlock_irqrestore(&sbi->iostat_lock, flags);
 
 	trace_f2fs_iostat(sbi, iostat_diff);
 
@@ -145,25 +147,27 @@ void f2fs_reset_iostat(struct f2fs_sb_info *sbi)
 	struct iostat_lat_info *io_lat = sbi->iostat_io_lat;
 	int i;
 
-	spin_lock_bh(&sbi->iostat_lock);
+	spin_lock_irq(&sbi->iostat_lock);
 	for (i = 0; i < NR_IO_TYPE; i++) {
 		sbi->rw_iostat[i] = 0;
 		sbi->prev_rw_iostat[i] = 0;
 	}
-	spin_unlock_bh(&sbi->iostat_lock);
+	spin_unlock_irq(&sbi->iostat_lock);
 
-	spin_lock_bh(&sbi->iostat_lat_lock);
+	spin_lock_irq(&sbi->iostat_lat_lock);
 	memset(io_lat, 0, sizeof(struct iostat_lat_info));
-	spin_unlock_bh(&sbi->iostat_lat_lock);
+	spin_unlock_irq(&sbi->iostat_lat_lock);
 }
 
 void f2fs_update_iostat(struct f2fs_sb_info *sbi,
 			enum iostat_type type, unsigned long long io_bytes)
 {
+	unsigned long flags;
+
 	if (!sbi->iostat_enable)
 		return;
 
-	spin_lock_bh(&sbi->iostat_lock);
+	spin_lock_irqsave(&sbi->iostat_lock, flags);
 	sbi->rw_iostat[type] += io_bytes;
 
 	if (type == APP_BUFFERED_IO || type == APP_DIRECT_IO)
@@ -172,7 +176,7 @@ void f2fs_update_iostat(struct f2fs_sb_info *sbi,
 	if (type == APP_BUFFERED_READ_IO || type == APP_DIRECT_READ_IO)
 		sbi->rw_iostat[APP_READ_IO] += io_bytes;
 
-	spin_unlock_bh(&sbi->iostat_lock);
+	spin_unlock_irqrestore(&sbi->iostat_lock, flags);
 
 	f2fs_record_iostat(sbi);
 }
@@ -185,6 +189,7 @@ static inline void __update_iostat_latency(struct bio_iostat_ctx *iostat_ctx,
 	struct f2fs_sb_info *sbi = iostat_ctx->sbi;
 	struct iostat_lat_info *io_lat = sbi->iostat_io_lat;
 	int idx;
+	unsigned long flags;
 
 	if (!sbi->iostat_enable)
 		return;
@@ -202,12 +207,12 @@ static inline void __update_iostat_latency(struct bio_iostat_ctx *iostat_ctx,
 			idx = WRITE_ASYNC_IO;
 	}
 
-	spin_lock_bh(&sbi->iostat_lat_lock);
+	spin_lock_irqsave(&sbi->iostat_lat_lock, flags);
 	io_lat->sum_lat[idx][iotype] += ts_diff;
 	io_lat->bio_cnt[idx][iotype]++;
 	if (ts_diff > io_lat->peak_lat[idx][iotype])
 		io_lat->peak_lat[idx][iotype] = ts_diff;
-	spin_unlock_bh(&sbi->iostat_lat_lock);
+	spin_unlock_irqrestore(&sbi->iostat_lat_lock, flags);
 }
 
 void iostat_update_and_unbind_ctx(struct bio *bio, int rw)
-- 
2.36.1.476.g0c4daa206d-goog

