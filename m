Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 312715A0049
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 19:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240058AbiHXRW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 13:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236466AbiHXRW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 13:22:26 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E92178BC8
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 10:22:25 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id y187so13944357iof.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 10:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=cArEez+iyhPNFExoXKwtv/rgNsqnWR4F7zdnGCmBTLE=;
        b=Cz0OMOG2KlaDqzJVf7seld1yxIYXd1wK0FRfZTNMQan/+Vo1r5usU8adBCsIQBQyvV
         lJtWGqGEOfUZ84X9XvQP11YwAT9TQkFTMR1a77WmhD88gSjZxE2lARZqa2tKI7Tg5LrR
         ZU7Y140ovm7mTlBjGpVQzaswTLjhuJE43g5UWzqCalZAgMu+SjYNw2KPbov10EG42F6S
         Mh01nqw2aQWATzyrTYxjkX421EoxV3yWmCtBvW5Xd8Vnnb7MtVZu/BFLkF4jsjQLp0BN
         oRn368CacOCSpRcGlMeatGkLp4my+o4dwKv1HXCeI5WaqWYuxCEaeQPkXxn32s2IIP4J
         uW4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=cArEez+iyhPNFExoXKwtv/rgNsqnWR4F7zdnGCmBTLE=;
        b=lYPf0+/L9ntYOmb3Wnbbrgim8AhyYUJj/dFGsRiZu2pUWE4ezp0Sb0HG1Eo+XsqY0Q
         ++pJvyPLudxa2kD+7dlhYBHPoyT0a8pP0F1p8LNJzREx/1jNZgTFp+sBPcjMz0A7V6/P
         nX6eGouLi5ZFac+MynmGPtxLYjExEkMUc1HvTyOQ5fIsK5hByNhHU7GG5wIGDVRIpDd1
         pner3wocnUBPflF1qtCfm7AEW13Q21cFAt32JzAUsE9xTZ3LmRZI5HzcVb7yF3DHO761
         IaDHvvRlE0eGmZJAx4wbFNFBtLyMa1QCUDDRjQh/u2x2fmSZ/KGo3djS2ZYYsuidxx7m
         Mx3Q==
X-Gm-Message-State: ACgBeo2UD+4nwcrFebU0LxKGDybkO6FvnvcCixdJ9oJYK3RIMHLsBXve
        YQTNt62v84aNWunzKvk+l3vRtQ==
X-Google-Smtp-Source: AA6agR47l8rGvGyPbNE0ykY7lMWgM/Ie6WdsvXnvRw/EDK0N5rPf+e53hKORGDBoasrYxAj32ZJ2ag==
X-Received: by 2002:a6b:5d0f:0:b0:688:6559:7a00 with SMTP id r15-20020a6b5d0f000000b0068865597a00mr45571iob.42.1661361744484;
        Wed, 24 Aug 2022 10:22:24 -0700 (PDT)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id y6-20020a927d06000000b002dd6c2cf81dsm1218598ilc.36.2022.08.24.10.22.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Aug 2022 10:22:24 -0700 (PDT)
Message-ID: <62db011a-aa17-1a46-ed38-806e5f9646a3@kernel.dk>
Date:   Wed, 24 Aug 2022 11:22:23 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [syzbot] general protection fault in __io_sync_cancel
Content-Language: en-US
To:     syzbot <syzbot+bf76847df5f7359c9e09@syzkaller.appspotmail.com>,
        asml.silence@gmail.com, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <000000000000d63d1505e6ffe433@google.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <000000000000d63d1505e6ffe433@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/24/22 11:20 AM, syzbot wrote:
> Hello,
> 
> syzbot tried to test the proposed patch but the build/boot failed:

Gah, that's the virtio-net issue that got fixed, not related. Maybe test
this one on master:

diff --git a/io_uring/cancel.c b/io_uring/cancel.c
index e4e1dc0325f0..5fc5d3e80fcb 100644
--- a/io_uring/cancel.c
+++ b/io_uring/cancel.c
@@ -218,7 +218,7 @@ static int __io_sync_cancel(struct io_uring_task *tctx,
 	    (cd->flags & IORING_ASYNC_CANCEL_FD_FIXED)) {
 		unsigned long file_ptr;
 
-		if (unlikely(fd > ctx->nr_user_files))
+		if (unlikely(fd >= ctx->nr_user_files))
 			return -EBADF;
 		fd = array_index_nospec(fd, ctx->nr_user_files);
 		file_ptr = io_fixed_file_slot(&ctx->file_table, fd)->file_ptr;

-- 
Jens Axboe
