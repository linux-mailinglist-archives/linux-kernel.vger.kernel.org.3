Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 070D94F6B99
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 22:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbiDFUuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 16:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232223AbiDFUuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 16:50:11 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 970983C43A9
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 12:05:35 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id qh7so6167790ejb.11
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 12:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WBo84nT6kplZvgHB/vdnS5/ZWvTiH4Rb4kDlRvn9tbE=;
        b=dCGktYBy5F1Zx0GypibmKeIOPcSKF5c1cY/Ymuk0WBP7hPMGCDgjNRpbJMaQmdUOcr
         gYSZr4Xhd5VbpijEI6kF2oECiMU2X6ZhLOtNRD8gJAwspNro6z6CEGPcE2dgt9XRiIkC
         wc/rLKlbEyJFdPr5AQHhwjk5wu39+KKg9427rtjmOLKqwEvjkX7pMAL6+nV2iEtorSWX
         QFP2g5iOxpD+6UCmitRVP30PgKOdhyq37ownMQEIANHhWgmGXh4+02nZFUFFjYzZhkm0
         +qi0Vs00ytlIggtFPN3+Qo5e9UzGuCw2MtSPOYYY3lYKpQwCtfO6cInsqiDo+9v+dmy3
         MWcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WBo84nT6kplZvgHB/vdnS5/ZWvTiH4Rb4kDlRvn9tbE=;
        b=shKWP3ar7J3y5hLgYb+lS1LYh7aqX8BsCsekaLgTNdQfItSv+6xLZnc1YlcLtUbi9S
         ppC3ZA15FfecnbXkEnPkiInVNEaG+vcaSPcKlJQ9X9kNprzmrM7ORQDAMGHKp33jvXjT
         5FHdFGeMvAByvD+GXN314k62bJa8jOEy/VFO31Gf8+0DU+ee17JZPCJOQZnmJIyUhIah
         9t6Y+98DtMHNCWwSMM14NIMNX8AeCbonOAFyhAKH568rr2Z9DRMLZczk7oZLnr2L3bKl
         x901cuqGHFH9Oy4JHHh1HZa5fo1BnEuRBzM1mWRclLgDk+VFGj23HtvKWRc3mTLqJNqe
         TE+w==
X-Gm-Message-State: AOAM532a5oxWniGgM2YSDzhq1JC6OJ/+wtBcMVl+uUoLVDdfHzvakP4w
        JR/DHkETrc5eeTOJY7u/jZ/auQ==
X-Google-Smtp-Source: ABdhPJyTsMFP8wBllOYfilYBbOCNHenhYc+BnrBSgdiicw0iXsw0UvHmIIMoOuvBBoLpOu2XvVZrfg==
X-Received: by 2002:a17:907:6ea7:b0:6df:c5a2:89ca with SMTP id sh39-20020a1709076ea700b006dfc5a289camr9769965ejc.18.1649271934152;
        Wed, 06 Apr 2022 12:05:34 -0700 (PDT)
Received: from localhost (85-127-190-169.dsl.dynamic.surfer.at. [85.127.190.169])
        by smtp.gmail.com with ESMTPSA id hr38-20020a1709073fa600b006e0280f3bbdsm6914682ejc.110.2022.04.06.12.05.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 12:05:33 -0700 (PDT)
From:   =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        linux-block@vger.kernel.org,
        =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph@boehmwalder.at>,
        =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
Subject: [PATCH 3/3] drbd: set QUEUE_FLAG_STABLE_WRITES
Date:   Wed,  6 Apr 2022 21:04:45 +0200
Message-Id: <20220406190445.1937206-4-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220406190445.1937206-1-christoph.boehmwalder@linbit.com>
References: <20220406190445.1937206-1-christoph.boehmwalder@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christoph Böhmwalder <christoph@boehmwalder.at>

We want our pages not to change while they are being written.

Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 drivers/block/drbd/drbd_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index d6dfa286ddb3..4b0b25cc916e 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -2719,6 +2719,7 @@ enum drbd_ret_code drbd_create_device(struct drbd_config_context *adm_ctx, unsig
 	sprintf(disk->disk_name, "drbd%d", minor);
 	disk->private_data = device;
 
+	blk_queue_flag_set(QUEUE_FLAG_STABLE_WRITES, disk->queue);
 	blk_queue_write_cache(disk->queue, true, true);
 	/* Setting the max_hw_sectors to an odd value of 8kibyte here
 	   This triggers a max_bio_size message upon first attach or connect */
-- 
2.35.1

