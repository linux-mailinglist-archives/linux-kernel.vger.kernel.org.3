Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1E6557F0D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 17:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232101AbiFWPyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 11:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbiFWPyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 11:54:04 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0944E36B67
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 08:54:03 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id r20so8149959wra.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 08:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qmKNiEIYg43PRKcgMsCwOiMbNOijTgjI9sHdcMaEUrM=;
        b=k/dvGPiZh9R8Hr+Gj5mmKyM7sWtdvrAuUTus62tZM3deRCqhkgc1IGm/ZGosDpcITI
         Mar50qLk4Pv3WY2YfcMAUEBaPt0Pfc5rglmibE44yGIa1tfd+80oItL/cx0l6Ir93HpZ
         PAbL8LoaLGCuQXIxoiJqH7Z+6moMrojBSrfCXEvCrWIZnS+KZkFpBGs6ayUhjmjblzce
         K06p4y5PoN2taIwYM+VSAFSzSCcy6rMnBXGjZXFJMg5Ut/sCxa9T1QYAYzGZ85nP4vPp
         pxJq3PYtOgprCgZXCoY8xTHlzsIuWLtk7RRl0D80mRy/fR7dJpOhxsDRGkdgfXYgsM7a
         AV3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qmKNiEIYg43PRKcgMsCwOiMbNOijTgjI9sHdcMaEUrM=;
        b=FUPkTJqFdKMOhkPd9UkYtZJniXREsXTXXeyYwr4dC7NydWXGjXTx/BDcQ+jSxi+0FF
         0IthqG8hLmcEERNnnnOcqvaAs3rRkMAiaRO3gEkLwWLdbBktY0KA6ad72gapUXXhQyha
         kRI7G7qnuW460LJUzsIB/GQD5dL+WZRmoG+SCUdsWGPihXIN999RcTkUwRnQhbyfXHb+
         03GGr8/1CUwucTx4TaArseW+CW0gpnNUSDQa0nMlXQQ8NahkqYPQ+ws2vgQtXFRsMr4r
         Yge8Jmac7Qr9EULpuMBAC0KS73qmHdDD+ub6RuGD7j1PjUlmDPNTvGI0LILRzGvJvdno
         hVBw==
X-Gm-Message-State: AJIora/4QKbNdaPkJPjBqGXim/pi23A/aOzzCGkjt5dcBWbqYaCK3Je6
        6Cj6ZQdCHC7g0wfTwRyCzeB32Q==
X-Google-Smtp-Source: AGRyM1tlDKB4//vnmD35H76Yze2SgIUp5Sn7QaGS0tOiDDh2Fck0ueeOS0nGGJd0GklRKcYQ6EO1AQ==
X-Received: by 2002:a5d:43cd:0:b0:21b:8e53:befe with SMTP id v13-20020a5d43cd000000b0021b8e53befemr8659922wrr.255.1655999642537;
        Thu, 23 Jun 2022 08:54:02 -0700 (PDT)
Received: from OPPO-A74.station (net-37-182-48-184.cust.vodafonedsl.it. [37.182.48.184])
        by smtp.gmail.com with ESMTPSA id n10-20020adffe0a000000b0021b5861eaf7sm20650830wrr.3.2022.06.23.08.54.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Jun 2022 08:54:02 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        jack@suse.cz, andrea.righi@canonical.com, glen.valante@linaro.org,
        arie.vanderhoeven@seagate.com, Davide Zini <davidezini2@gmail.com>,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH 8/8] block, bfq: balance I/O injection among underutilized actuators
Date:   Thu, 23 Jun 2022 17:53:35 +0200
Message-Id: <20220623155335.6147-9-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220623155335.6147-1-paolo.valente@linaro.org>
References: <20220623155335.6147-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Davide Zini <davidezini2@gmail.com>

Upon the invocation of its dispatch function, BFQ returns the next I/O
request of the in-service bfq_queue, unless some exception holds. One
such exception is that there is some underutilized actuator, different
from the actuator for which the in-service queue contains I/O, and
that some other bfq_queue happens to contain I/O for such an
actuator. In this case, the next I/O request of the latter bfq_queue,
and not of the in-service bfq_queue, is returned (I/O is injected from
that bfq_queue). To find such an actuator, a linear scan, in
increasing index order, is performed among actuators.

Performing a linear scan entails a prioritization among actuators: an
underutilized actuator may be considered for injection only if all
actuators with a lower index are currently fully utilized, or if there
is no pending I/O for any lower-index actuator that happens to be
underutilized.

This commits breaks this prioritization and tends to distribute
injection uniformly across actuators. This is obtained by adding the
following condition to the linear scan: even if an actuator A is
underutilized, A is however skipped if its load is higher than that of
the next actuator.

Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
Signed-off-by: Davide Zini <davidezini2@gmail.com>
---
 block/bfq-iosched.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 80eb7d542b70..ee113d1b949f 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -4799,17 +4799,25 @@ struct bfq_queue *bfq_find_active_bfqq_for_actuator(struct bfq_data *bfqd,
 
 /*
  * Perform a linear scan of each actuator, until an actuator is found
- * for which the following two conditions hold: the load of the
- * actuator is below the threshold (see comments on actuator_load_threshold
- * for details), and there is a queue that contains I/O for that
- * actuator. On success, return that queue.
+ * for which the following three conditions hold: the load of the
+ * actuator is below the threshold (see comments on
+ * actuator_load_threshold for details) and lower than that of the
+ * next actuator (comments on this extra condition below), and there
+ * is a queue that contains I/O for that actuator. On success, return
+ * that queue.
+ *
+ * Performing a plain linear scan entails a prioritization among
+ * actuators. The extra condition above breaks this prioritization and
+ * tends to distribute injection uniformly across actuators.
  */
 struct bfq_queue *bfq_find_bfqq_for_underused_actuator(struct bfq_data *bfqd)
 {
 	int i;
 
 	for (i = 0 ; i < bfqd->num_ia_ranges; i++)
-		if (bfqd->rq_in_driver[i] < bfqd->actuator_load_threshold) {
+		if (bfqd->rq_in_driver[i] < bfqd->actuator_load_threshold &&
+		    (i == bfqd->num_ia_ranges - 1 ||
+		     bfqd->rq_in_driver[i] < bfqd->rq_in_driver[i+1])) {
 			struct bfq_queue *bfqq =
 				bfq_find_active_bfqq_for_actuator(bfqd, i);
 
-- 
2.20.1

