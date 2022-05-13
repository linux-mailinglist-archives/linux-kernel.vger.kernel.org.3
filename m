Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 407B65262B3
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 15:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380598AbiEMNNr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 09:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232625AbiEMNNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 09:13:41 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E0750B1F
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 06:13:38 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id fu47so6753417qtb.5
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 06:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6+gNOUaWkd0Bt/JIZ8SDZDMjw5UUXZsqOvLbfnJqY8g=;
        b=XQFCZfhm7ewTc4XGGTXLDs4ORqJoIOmN58pp/aiyNiZn+4KQD1n6GurSxpZnIeHGle
         BHgljDzcb8IocKVAna6UfJsdoy3zR4xntjetc9xE+ggJfXqHnFMAtZZ2uXcUAwnJpXM4
         z71gIN4Kf3+6Mn/A63t1Hqxn3h5n4ioP20D9p71dlE7v5cFGM4zcQkOi7DROx9Wfe2AN
         L9qYy/9ImbchcWiAdMnPMP1D3jFrgOf98pEoGnR7dsYj8g90ZIRsjjl42tE0GcZLl37n
         db9DftV4Q3/mGZbH/epzsq/QZAHrmL6njW81VxjaZZ2AakSkhIjFmysB8xqF/PjD1wvi
         bqOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6+gNOUaWkd0Bt/JIZ8SDZDMjw5UUXZsqOvLbfnJqY8g=;
        b=J46UvqMLx12Vrn204q7P9BeU1eiwrNXhu1ipJDZOZxUyBtGsYZcN021hMsYjyci6O/
         xIFQrjUyNcilyXzGIJ6WAkCPrp4C8Ib3D5+amcMFeywJSoslqeILzywZn2M9Lzr3X4nD
         VxSBbZv9VTmMWHTcUN32fhVuc1xpyeOBzvPEf2qR+DCWGPX6Isbzjsu+TXfiUzeGs3bn
         sDzjJfxOhuGxTScbQOgg6N9suGjFJUtLwmY+qz9urgh6orBt7aszpBPyvj/cq9B9LKuf
         Ef3kmjIp5dRpsorqhZ2LosOs2kvyPUedTcD/UInz10vvsZYri6sou3ulW3mmh02clELp
         z3XQ==
X-Gm-Message-State: AOAM5312KC4wLX1RPpOAcwENI3QJPR/2JjM6QjEgJJHYEhqxLsr1OGZI
        tYlH4P6vki0Fq3VeiWos1zxbsw==
X-Google-Smtp-Source: ABdhPJwxT4heqZ/ZkYzHC2358zLSs+/kN7c2zraegXVpNi+Urh+gSE1Rj4PwtEzzhr8yWY34ktzoUA==
X-Received: by 2002:ac8:7f0d:0:b0:2f3:cd9e:c2ea with SMTP id f13-20020ac87f0d000000b002f3cd9ec2eamr4447513qtk.590.1652447617290;
        Fri, 13 May 2022 06:13:37 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id q19-20020ac87353000000b002f39b99f67esm1445845qtp.24.2022.05.13.06.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 06:13:36 -0700 (PDT)
Date:   Fri, 13 May 2022 09:13:35 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Matthew Ruffell <matthew.ruffell@canonical.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        nbd <nbd@other.debian.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>, yukuai3@huawei.com
Subject: Re: [PROBLEM] nbd requests become stuck when devices watched by
 inotify emit udev uevent changes
Message-ID: <Yn5Zf6lONff1AoOA@localhost.localdomain>
References: <20220422054224.19527-1-matthew.ruffell@canonical.com>
 <CAEzrpqe=LD3DQcEeLXmmFuq7cX_dAQ6DOCuJYWBoZWKKTmoTzA@mail.gmail.com>
 <CAKAwkKt3yMOOW3NXcE91WkGr+8xj050CYP2pLoQVHt_2wXq=-w@mail.gmail.com>
 <CAKAwkKvfFn18RjupuqGpx4QeAiMYKSq7QUTd3wEL=pkZ+BENpQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKAwkKvfFn18RjupuqGpx4QeAiMYKSq7QUTd3wEL=pkZ+BENpQ@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2022 at 02:56:18PM +1200, Matthew Ruffell wrote:
> Hi Josef,
> 
> Just a friendly ping, I am more than happy to test a patch, if you send it
> inline in the email, since the pastebin you used expired after 1 day, and I
> couldn't access it.
> 
> I came across and tested Yu Kuai's patches [1][2] which are for the same issue,
> and they indeed fix the hang. Thank you Yu.
> 
> [1] nbd: don't clear 'NBD_CMD_INFLIGHT' flag if request is not completed
> https://lists.debian.org/nbd/2022/04/msg00212.html
> 
> [2] nbd: fix io hung while disconnecting device
> https://lists.debian.org/nbd/2022/04/msg00207.html
> 
> I am also happy to test any patches to fix the I/O errors.
>

Sorry, you caught me on vacation before and I forgot to reply.  Here's part one
of the patch I wanted you to try which fixes the io hung part.  Thanks,

Josef

 
From 0a6123520380cb84de8ccefcccc5f112bce5efb6 Mon Sep 17 00:00:00 2001
Message-Id: <0a6123520380cb84de8ccefcccc5f112bce5efb6.1652447517.git.josef@toxicpanda.com>
From: Josef Bacik <josef@toxicpanda.com>
Date: Sat, 23 Apr 2022 23:51:23 -0400
Subject: [PATCH] timeout thing

---
 drivers/block/nbd.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 526389351784..ab365c0e9c04 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1314,7 +1314,10 @@ static void nbd_config_put(struct nbd_device *nbd)
 		kfree(nbd->config);
 		nbd->config = NULL;
 
-		nbd->tag_set.timeout = 0;
+		/* Reset our timeout to something sane. */
+		nbd->tag_set.timeout = 30 * HZ;
+		blk_queue_rq_timeout(nbd->disk->queue, 30 * HZ);
+
 		nbd->disk->queue->limits.discard_granularity = 0;
 		nbd->disk->queue->limits.discard_alignment = 0;
 		blk_queue_max_discard_sectors(nbd->disk->queue, 0);
-- 
2.26.3

