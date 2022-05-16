Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C42735281B0
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 12:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242393AbiEPKTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 06:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233754AbiEPKTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 06:19:23 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25576DEC3
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 03:19:20 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id i24so13608136pfa.7
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 03:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bW4la66s2/2Qkl9P/hRh2ka24n+8uceXtWH8mz/xliY=;
        b=DlU+GBh2MfUhs6P6NuaPTzAk6CnKaIU25rlLqVbf9TmS7k560BONygkGBXfcGN1PWU
         kiWPLIo6SQsYDD9On2cXonZktr/+RT+wBt2rKAprhyW7b7JO0f9jLHo8Y35iiL75zySQ
         31HspQ7f9eOwvYMS1wd6418OCzJQpRKB3vJ72yz3UtDzYQBxdCBKlEQ0khnRe4FG++HD
         HzOGGsKQlLaNL2OKEXI0D7D9rOJywmDc+GcsAtJFxyjnOSe407rX9Vl7B/qbaWWEabVZ
         JI7sAX2aZN6LE7qPplxJztRNY87BGCg+GRukXatvKdLUfrl+II7xje4xZdHa6WFcWtK3
         QZiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bW4la66s2/2Qkl9P/hRh2ka24n+8uceXtWH8mz/xliY=;
        b=tedeg99gKwo/GY0b9r15IU2gS+e4nnN2c082uvw0yZbRuh1jwFLH7fzO7nwiecLEfS
         zfKCDqdiFVv4xUXND77tADZMe7I8ZSN4faa1VVYEisnWTJKy8ABVMlUlUSANbTrWdTK6
         YFO0N3My1KXynAd0b0igVeacc8HU9XgQvONqh+XCYRceCeq5G43QuEwi75gLSiD6u1bF
         ooIiIZTyZoZuPOIucjYm5g6xZvfta7kYEm5+UNUy18B6gmynyMHjrZhfSge2eWZcMK/m
         qV3nO/0QTNhudAt0/hd3rQjvsedGkXfNi0n12ssw4mI0IZ3Fhker4fhpAaJT9eLoJzJP
         I8Cw==
X-Gm-Message-State: AOAM5328e7ZsiziiS0eD50YDj0ySbG+Ai5G8i9vKrsbfBp/59bTAiU22
        lclyE8ZfM6lfC/gwTLQSFgwSS2Fu9dZ5eA==
X-Google-Smtp-Source: ABdhPJwIkvqG1MyMUXgY2WtuJDubBjCrD5lZ9usKKsCWanfaWY6veeD8QGmqb1vDcZJoENug8S59rg==
X-Received: by 2002:a63:2b05:0:b0:3c2:3ed1:5fa9 with SMTP id r5-20020a632b05000000b003c23ed15fa9mr14676453pgr.220.1652696359590;
        Mon, 16 May 2022 03:19:19 -0700 (PDT)
Received: from C02CV1DAMD6P.bytedance.net ([139.177.225.240])
        by smtp.gmail.com with ESMTPSA id x14-20020a170902820e00b0015e8d4eb1efsm2509699pln.57.2022.05.16.03.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 03:19:19 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     tj@kernel.org, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com, songmuchun@bytedance.com,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH] blk-iocos: fix inuse clamp when iocg deactivate or free
Date:   Mon, 16 May 2022 18:19:09 +0800
Message-Id: <20220516101909.99768-1-zhouchengming@bytedance.com>
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

For an active leaf node, its inuse shouldn't be zero or exceed
its active, but it's not true when deactivate idle iocg or delete
iocg in ioc_pd_free().

Although inuse of 1 is very small, it could cause noticeable hwi
decrease in the long running server. So we'd better fix it.

And check iocg->child_active_sum is enough for inner iocg, remove
the needless list_empty check by the way.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 block/blk-iocost.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 2570732b92d1..84374ebcc402 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -1073,11 +1073,11 @@ static void __propagate_weights(struct ioc_gq *iocg, u32 active, u32 inuse,
 	 * @active. An active internal node's inuse is solely determined by the
 	 * inuse to active ratio of its children regardless of @inuse.
 	 */
-	if (list_empty(&iocg->active_list) && iocg->child_active_sum) {
+	if (iocg->child_active_sum) {
 		inuse = DIV64_U64_ROUND_UP(active * iocg->child_inuse_sum,
 					   iocg->child_active_sum);
 	} else {
-		inuse = clamp_t(u32, inuse, 1, active);
+		inuse = clamp_t(u32, inuse, 0, active);
 	}
 
 	iocg->last_inuse = iocg->inuse;
-- 
2.36.1

