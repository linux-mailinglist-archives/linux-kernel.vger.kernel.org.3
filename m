Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA3F4FE6B6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 19:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358051AbiDLRTo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 13:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350218AbiDLRTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 13:19:37 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C175D517FC;
        Tue, 12 Apr 2022 10:17:10 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id t25so33331111lfg.7;
        Tue, 12 Apr 2022 10:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=URuYojkxV6WW5KduaZwbvyQpA/mj+9RW5XKOSq85tII=;
        b=QYt1UC5IFgQjZ6sZdp7YECBm2g6b2CPrjGdVmz2lkTrU0xl+cv2UsXHIc8lKFFLGYw
         HC3krv4I4D5hfLgh31O11/Twa1I0DudLbkuwGieLgQqy6Nxd2QUu5rf0IYT7jFQFI/Lr
         zcSSIYsp5S5ugQ+NBSFDYs8MSvBiWTrjlNc8SqLTX8Mkt3jl6Ng/YNoD8s/IwpNynQvZ
         FNWjwHR1dMq9TB5qXfhqZUdH3dKjiAgTyU5aMeEevKKJdO7mKA4Uh+cYeZjX3jdy5rc6
         gg1vlpQ4+dnjx+tQRnf2UAtUiN+VFowZ64IlZknWiBDsRmBJndnf24Zjr5PCgVjJIWp/
         7TbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=URuYojkxV6WW5KduaZwbvyQpA/mj+9RW5XKOSq85tII=;
        b=3D1fWZnUinLaB+sdEmFKbRWoo7uO6arpVHlsI2qcPs2n80az7aL8x//ZexB4to7Dcb
         M1zGOWWFF09SSBlHVXEXaNzKWbXs26B+i1e1HBISRiNy+YsJKzNSG4CNP2zXIsNaMx5a
         Oi7PyEFUvVYu6XfWUrRT1V1VnqQn9PUXGJwoHAQjxErmtn5k3qI+S7x/6HEYnQkQzcAZ
         D3WKuTVqo8d+FpDs1oMhXUuENJ5HzxgyUwQt4paMDmJ7hr+DZ3lZclFF2aAdd8QyjB9e
         EwEjtZydV+Ingsv9qbQ96dZRzJuL+wrms5EuF6vCTwgjhOpMxxAnk7+zllCPTxBfli6o
         ikpQ==
X-Gm-Message-State: AOAM5316wtQmVQLTq2VoqPH2bqXqnCefPZ5eBymSoctuN0k0xEamCIql
        v8V9NX26Alb8eqi6VDbbKAo=
X-Google-Smtp-Source: ABdhPJwh5oXNeEM8ojAPGe+8gV/lp2WDXe5fQBude/NLBc3HOVhukRH79ibF7/MEJpGMZ5ajzRsqrw==
X-Received: by 2002:a05:6512:2214:b0:44a:348a:d6d with SMTP id h20-20020a056512221400b0044a348a0d6dmr25654107lfu.506.1649783829102;
        Tue, 12 Apr 2022 10:17:09 -0700 (PDT)
Received: from morzel-asus.lan (static-91-225-135-18.devs.futuro.pl. [91.225.135.18])
        by smtp.gmail.com with ESMTPSA id m2-20020a05651202e200b0046ba665cd6dsm723928lfq.141.2022.04.12.10.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 10:17:08 -0700 (PDT)
From:   Michal Orzel <michalorzel.eng@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>
Cc:     Michal Orzel <michalorzel.eng@gmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [PATCH v2 2/5] block/blk-map: Remove redundant assignment
Date:   Tue, 12 Apr 2022 19:16:48 +0200
Message-Id: <20220412171651.19812-2-michalorzel.eng@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220412171651.19812-1-michalorzel.eng@gmail.com>
References: <20220412171651.19812-1-michalorzel.eng@gmail.com>
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

Get rid of redundant assignment to a variable ret from function
bio_map_user_iov as it is being assigned a value that is never read.
It is being re-assigned in the first instruction after the while loop

Reported by clang-tidy [deadcode.DeadStores]

Signed-off-by: Michal Orzel <michalorzel.eng@gmail.com>
---
Changes since v1:
-move the change into a separate patch
-add analysis
---
 block/blk-map.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/block/blk-map.c b/block/blk-map.c
index c7f71d83eff1..fa72e63e18c2 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -260,10 +260,9 @@ static int bio_map_user_iov(struct request *rq, struct iov_iter *iter,
 
 		npages = DIV_ROUND_UP(offs + bytes, PAGE_SIZE);
 
-		if (unlikely(offs & queue_dma_alignment(rq->q))) {
-			ret = -EINVAL;
+		if (unlikely(offs & queue_dma_alignment(rq->q)))
 			j = 0;
-		} else {
+		else {
 			for (j = 0; j < npages; j++) {
 				struct page *page = pages[j];
 				unsigned int n = PAGE_SIZE - offs;
-- 
2.25.1

