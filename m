Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3381253A4C3
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 14:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353019AbiFAMV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 08:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243225AbiFAMVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 08:21:21 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 527925D5FD
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 05:21:19 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id u18so1654410plb.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 05:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cvyMZ32vWUq0PQ25pSdJ7F9z18j1tkrk0X4DK0wb+pM=;
        b=kxnZ7vRN+WQqWOB5MR7wfAgarJxLA8uLDRHyri1tlk0f3K2IslXSjPSWuFg5pMnFdh
         HDprEkLHaoZeQty7cXur4ieJIQFBwHlhllSwX0QHPN5RZ18H+aLarpAS4eTynppFq7tr
         8u6ndn8SaZbl57XrVoqT3djuazguIoR19fS3i/SyMs63WJtK++FLs/FpvVbyFjEW6dY5
         r3+JiisF0irEv6sMXMqmLlQvAsAwuK6WoHky9FPY8nBi/NWIgEfT9T+kg2uW+emFntPh
         Uq361otGJ8ZZOo4bGCiX/3ngHRQ/ra8xFDjVDh2xuWumlHmfa+nBgNtDMNJ2pZEVshRR
         lOnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cvyMZ32vWUq0PQ25pSdJ7F9z18j1tkrk0X4DK0wb+pM=;
        b=Gglq3D4nEUEiYQjlLMykEWRa7ei+FUkUXWgZh4SftFfUe+kdoXqOzcQzmuGFf6k7QE
         XErAtF5WnhuTQTkgGnFvw74HqT4xq3BW+BSKvqbNuv85hbQhERuzAJ3/5vsSWYloNDb+
         NZQspoUIO3IyY8VTg4rz5ypEVQrxRQzehBhDGVjSsHDwwm7kcrhrYHjS1HPnFiAV8LZq
         bZDNkEeQMHWxLnP7nnWVSWMYYeSilpvLIrLQm6buYqYmki2GP1SIVTJf+k2Q4v3aq0At
         Zd4Jv/SRVWmrT33Uksj91/49H1NiHVe+86EQqAcVogRfZ8Hah52xceeT43JGW0Jb8k7J
         vW+w==
X-Gm-Message-State: AOAM533CiWtfCGQnOo69wlEfW4r2tkO2mKOi8+DYNco+va8ngXNZLE8D
        M/E3eD6q4KdGG6stlDoJTqKZ0w==
X-Google-Smtp-Source: ABdhPJxGNOmMnzBvygoNU/XIaL9fFEvwZd9o7+MdRm17YWKvByOJnl3tUA+d8dJYE9JdwafzFEa25A==
X-Received: by 2002:a17:90b:4c47:b0:1df:ad5b:e32e with SMTP id np7-20020a17090b4c4700b001dfad5be32emr33826198pjb.59.1654086078831;
        Wed, 01 Jun 2022 05:21:18 -0700 (PDT)
Received: from C02CV1DAMD6P.bytedance.net ([139.177.225.231])
        by smtp.gmail.com with ESMTPSA id ij24-20020a170902ab5800b0015e8d4eb1f7sm1427535plb.65.2022.06.01.05.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 05:21:18 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     tj@kernel.org, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH 1/2] blk-iocost: factor out iocg_deactivate()
Date:   Wed,  1 Jun 2022 20:20:06 +0800
Message-Id: <20220601122007.1057-1-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch factor out iocg deactivation into a separate function:
iocg_deactivate(). No functional changes.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 block/blk-iocost.c | 59 ++++++++++++++++++++++++++--------------------
 1 file changed, 33 insertions(+), 26 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 33a11ba971ea..b1f2305e8032 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -1322,6 +1322,37 @@ static bool iocg_activate(struct ioc_gq *iocg, struct ioc_now *now)
 	return false;
 }
 
+static void iocg_deactivate(struct ioc_gq *iocg, struct ioc_now *now)
+{
+	struct ioc *ioc = iocg->ioc;
+	u64 vtime = atomic64_read(&iocg->vtime);
+	s64 excess;
+
+	lockdep_assert_held(&ioc->lock);
+	lockdep_assert_held(&iocg->waitq.lock);
+
+	/*
+	 * @iocg has been inactive for a full duration and will
+	 * have a high budget. Account anything above target as
+	 * error and throw away. On reactivation, it'll start
+	 * with the target budget.
+	 */
+	excess = now->vnow - vtime - ioc->margins.target;
+	if (excess > 0) {
+		u32 old_hwi;
+
+		current_hweight(iocg, NULL, &old_hwi);
+		ioc->vtime_err -= div64_u64(excess * old_hwi,
+					    WEIGHT_ONE);
+	}
+
+	TRACE_IOCG_PATH(iocg_idle, iocg, now,
+			atomic64_read(&iocg->active_period),
+			atomic64_read(&ioc->cur_period), vtime);
+	__propagate_weights(iocg, 0, 0, false, now);
+	list_del_init(&iocg->active_list);
+}
+
 static bool iocg_kick_delay(struct ioc_gq *iocg, struct ioc_now *now)
 {
 	struct ioc *ioc = iocg->ioc;
@@ -2165,32 +2196,8 @@ static int ioc_check_iocgs(struct ioc *ioc, struct ioc_now *now)
 			iocg_kick_waitq(iocg, true, now);
 			if (iocg->abs_vdebt || iocg->delay)
 				nr_debtors++;
-		} else if (iocg_is_idle(iocg)) {
-			/* no waiter and idle, deactivate */
-			u64 vtime = atomic64_read(&iocg->vtime);
-			s64 excess;
-
-			/*
-			 * @iocg has been inactive for a full duration and will
-			 * have a high budget. Account anything above target as
-			 * error and throw away. On reactivation, it'll start
-			 * with the target budget.
-			 */
-			excess = now->vnow - vtime - ioc->margins.target;
-			if (excess > 0) {
-				u32 old_hwi;
-
-				current_hweight(iocg, NULL, &old_hwi);
-				ioc->vtime_err -= div64_u64(excess * old_hwi,
-							    WEIGHT_ONE);
-			}
-
-			TRACE_IOCG_PATH(iocg_idle, iocg, now,
-					atomic64_read(&iocg->active_period),
-					atomic64_read(&ioc->cur_period), vtime);
-			__propagate_weights(iocg, 0, 0, false, now);
-			list_del_init(&iocg->active_list);
-		}
+		} else if (iocg_is_idle(iocg))
+			iocg_deactivate(iocg, now);
 
 		spin_unlock(&iocg->waitq.lock);
 	}
-- 
2.36.1

