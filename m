Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE5EC527079
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 12:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbiENKEu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 06:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231617AbiENKEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 06:04:41 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E9D2637
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 03:03:58 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id bu29so18383563lfb.0
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 03:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :content-language:content-transfer-encoding;
        bh=xfGH7d9M+x2+711lYJq6dNzhfL2xV2ypgN6UlY8zPuQ=;
        b=tVDgUvtEZbtsXq0yASPJBk44tkyY3+TX3n57eSI26CosMagiGXhU+FPPcqQsjOvRUQ
         ztsoDFZnbqnod5BVopH6Q7dBP0zinWsyK4mmoWjlP4y4xaJonfG5MBAD7FvKliHVmY7W
         VFAgt54Yk8KNDKvgH4mUAJYs2koXdnlkZQ2CZhM4Gz4UjuSdSBiXP+qghzozHbcIICke
         MquSG9kOABaHxI/LoWUbzXi0I7O7TTgjyU9c6QRzYvEyQCuvILl7dzyMorL1cWfd3vGV
         L/CtxXXE5R4AFeLQlXbe4Ojv/n8nXkc236It6i8cNyIdYPNxuYI6zmKT6QbE6jwkLIRg
         +TPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:content-language:content-transfer-encoding;
        bh=xfGH7d9M+x2+711lYJq6dNzhfL2xV2ypgN6UlY8zPuQ=;
        b=6IOAB9stLOncMyQjdj4dSyMmTQE83MZoWYOUSzSobMXNODiNlnXWI+uStCCCSEzR1c
         8Ud0WK6RnquW6dF3xzftKXneA5O7kzqfxGEM8RShRIuodQxUsuHzIChDPSIY8oufAOnO
         E46LTLXdeZcWQ3hAdYu5ej+r6HQj7ng36mZl9DNjyuQgMOORb5DRxmWIWiePM7EHCUV2
         lqFsUx1eKm223MNji/Jw0KKSCOHNjyNoEfGaWa3Fix9IM+u44GVH87WIGLptIxRaEcVc
         OTOfTSXeMdzy7HKhRdIO9BYPo/wVV0UwGNTyzX1YbR/9g9W/HU7QXl17++bs97AY+PkG
         bAqA==
X-Gm-Message-State: AOAM531Vx2P0u1OmNNlDdq4f+6gYKBXIsIwroH2bxydvcsxJ104q45Hb
        HeHfZq3vxwUc/ksMWVDb6UFUSDSbYjRTHQ==
X-Google-Smtp-Source: ABdhPJzcfsV/VSVjA3O7pbqjXkFndQmlTxNXJgNFfOjrmU6QKPUnekYizK14EWFd7jvQSY6P0CUHig==
X-Received: by 2002:a05:6512:33a7:b0:472:481b:9d6c with SMTP id i7-20020a05651233a700b00472481b9d6cmr6344386lfg.451.1652522636409;
        Sat, 14 May 2022 03:03:56 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.177])
        by smtp.gmail.com with ESMTPSA id d20-20020a2e3314000000b0024f3d1daeacsm789123ljc.52.2022.05.14.03.03.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 May 2022 03:03:56 -0700 (PDT)
Message-ID: <e3251f58-fd47-9b94-387b-ab641a773dd7@openvz.org>
Date:   Sat, 14 May 2022 13:03:54 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
From:   Vasily Averin <vvs@openvz.org>
Subject: [PATCH] blk-mq: use force attribute for blk_status_t casts
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc:     kernel@openvz.org, linux-kernel@vger.kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes sparse warnings:
block/blk-mq.c:1163:36: sparse:
 warning: cast from restricted blk_status_t
block/blk-mq.c:1251:17: sparse:
 warning: cast to restricted blk_status_t

Signed-off-by: Vasily Averin <vvs@openvz.org>
---
 block/blk-mq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 84d749511f55..1b887f2d4a19 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1160,7 +1160,7 @@ static void blk_end_sync_rq(struct request *rq, blk_status_t error)
 {
 	struct completion *waiting = rq->end_io_data;
 
-	rq->end_io_data = (void *)(uintptr_t)error;
+	rq->end_io_data = (void *)(__force uintptr_t)error;
 
 	/*
 	 * complete last, if this is a stack request the process (and thus
@@ -1248,7 +1248,7 @@ blk_status_t blk_execute_rq(struct request *rq, bool at_head)
 	else
 		wait_for_completion_io(&wait);
 
-	return (blk_status_t)(uintptr_t)rq->end_io_data;
+	return (__force blk_status_t)(uintptr_t)rq->end_io_data;
 }
 EXPORT_SYMBOL(blk_execute_rq);
 
-- 
2.31.1

