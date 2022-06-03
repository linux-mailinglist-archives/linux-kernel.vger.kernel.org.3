Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7499F53C759
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 11:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240195AbiFCJUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 05:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238037AbiFCJUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 05:20:33 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C74639BB8
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 02:20:32 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id q12-20020a17090a304c00b001e2d4fb0eb4so11619743pjl.4
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 02:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UykfvYjlf7bvVyVseQjF4b1jZehVgSGcJDthryDCCdM=;
        b=GQlDWNcBH22gsxvCgLiQgBK0KC160zwjEpmvxZyYvG1hQdsazHvzGx+J5xSIRJ9gJV
         83O1qhac3t9NZBhPAhyF4e5yt6r6qkrNcbaIc2+PiRNd3TqZttBQe5GrBICglc63YqS/
         qgOOKMyLf2QMe2m+CotXP9LR5xlXTkwyUUvTvFRSaVhoUQz+8Sfvrit0+7TmH+PvoaQK
         20bfRDhL2SV2fJwIt6dbVqx8Fhq70DrIx6x67BjhAT4Agwkmbi4RSywvbtzHfeS5pNeN
         n98eUfMhiIbhHMedn0hkATA7Lqoz6lhuWypUXK8lLEVJp0upQ+Xub43UBOfc72OWqiMQ
         eV+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UykfvYjlf7bvVyVseQjF4b1jZehVgSGcJDthryDCCdM=;
        b=md+8oDqdQetc1yBdm0IbmM3++fBYzxFzsBEjzxBH8wdZiKbnkqLPtsHfNHzlZItU9b
         wFUOoNk5kXNMEHfeZG46VpcQ6Lchf6qBSnV/4h/tRn5xO+icVeM8JqQRPZnw9bUzgw2c
         Fxs4wYkDnZKBW0xewncCumNeVeIHk8oVErLVNDPYOKXenl+NuTLUmxHKwJDsklyS1XYU
         8Nv1+GGyu3FYDCS0+DYbBz+F9ND3fV+vJ5kId/Mwbx5Q8kipmaXXzt7GbQTnUTyglsr+
         orAeZE3EskroRRpEnktR8egii8+avosODeUbYpCPyZRuLfb557G25o/3ybUcPCTlfkgq
         JT9g==
X-Gm-Message-State: AOAM5304UuyZHG+ojRVDs/V1EJ4IwrtNTsum+/nl5l7Nt4/abim75fL2
        re3MkXlJIRs+5xjLj3rJr/+QXg==
X-Google-Smtp-Source: ABdhPJyHXTG46vJ/jfWD3+5X15s3UYa9sHBAl19PPMnZbtnYxTK2zxUHtJlW3Sr/OdW10N8Hf2xS0w==
X-Received: by 2002:a17:902:ebc8:b0:15f:417c:288b with SMTP id p8-20020a170902ebc800b0015f417c288bmr9506411plg.14.1654248031897;
        Fri, 03 Jun 2022 02:20:31 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.247])
        by smtp.gmail.com with ESMTPSA id ji20-20020a170903325400b0015e8d4eb2d1sm684260plb.283.2022.06.03.02.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 02:20:31 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     tj@kernel.org, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH] blk-iocost: fix lagging in-flight IOs detection
Date:   Fri,  3 Jun 2022 17:20:24 +0800
Message-Id: <20220603092024.49273-1-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since latency Qos detection doesn't account for IOs which
are in-flight for longer than a period, we detect them by
comparing vdone against period start. If lagging behind
IOs from past periods, don't increase vrate, but don't let
cmds which take a very long time pin lagging for too long.

The current code compares vdone against (vnow - period_vtime),
which is thought to be the period start. But the earliest
period start should be (vnow - period_vtime - margins.target).

And we will slide forward vtime and vdone on each period timer,
so we can't depend on vtime to check if the iocg has pinned
lagging for longer than MAX_LAGGING_PERIODS.

This patch adds lagging_periods in iocg to record how long
the iocg has pinned lagging, will not be thought as lagging
if longer than MAX_LAGGING_PERIODS.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
v2:
 - add lagging_periods to check very long lagging iocg.
---
 block/blk-iocost.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 33a11ba971ea..998bb38ffb37 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -541,6 +541,8 @@ struct ioc_gq {
 	u64				indebt_since;
 	u64				indelay_since;
 
+	int				lagging_periods;
+
 	/* this iocg's depth in the hierarchy and ancestors including self */
 	int				level;
 	struct ioc_gq			*ancestors[];
@@ -2257,10 +2259,13 @@ static void ioc_timer_fn(struct timer_list *timer)
 		if ((ppm_rthr != MILLION || ppm_wthr != MILLION) &&
 		    !atomic_read(&iocg_to_blkg(iocg)->use_delay) &&
 		    time_after64(vtime, vdone) &&
-		    time_after64(vtime, now.vnow -
-				 MAX_LAGGING_PERIODS * period_vtime) &&
-		    time_before64(vdone, now.vnow - period_vtime))
-			nr_lagging++;
+		    time_before64(vdone, ioc->period_at_vtime - ioc->margins.target)) {
+			if (iocg->lagging_periods < MAX_LAGGING_PERIODS) {
+				nr_lagging++;
+				iocg->lagging_periods++;
+			}
+		} else if (iocg->lagging_periods)
+			iocg->lagging_periods = 0;
 
 		/*
 		 * Determine absolute usage factoring in in-flight IOs to avoid
-- 
2.36.1

