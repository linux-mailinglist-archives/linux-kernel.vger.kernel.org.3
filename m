Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 168015B2866
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 23:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbiIHVUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 17:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbiIHVUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 17:20:03 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A6372B7A
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 14:19:58 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id l6so9944656ilk.13
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 14:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=W7BcbWZFGTPcuazjR/BNB1mMCuppDikRbnJ5pIj0+mw=;
        b=zct8VMknboCOyI370q4FuKwfLFJDP4DKP7Dzw3NgHOsjWpbiPGC6UL6bSWKmh5m+uf
         d7sv03n80KdoYX4wIyRG1tCeUA6QWtjYkFZvOt6Ymk8pkCe2XcQfgU+/SLKk8VKc5Bdh
         3+gsO01fxWrEPpPpPTziAipX4dfPx8cHTGLhTaPMczzQ476Z3EYEnIU00hNWbE00lMJV
         qFt8mTvTRDvHD9CQploYoXv3UqnB+7vXDyWAREeVKz54I4fpI5vXou3ltLVWiQN85vKy
         GseviYdFNem3vIOVxEWzaHseaNNkPPUQlG81PP8RJJGRW8HLRJYvw++AB64hQtcYJQJi
         NgTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=W7BcbWZFGTPcuazjR/BNB1mMCuppDikRbnJ5pIj0+mw=;
        b=OHIw+5zitywKX8YWUVc3Ks6+gFoJr543xU8UdN1cvsojzFUQjO1sCD/6gHxhf9L7oK
         igqSaEv1FS00yWLAOzsQVbbBQllb3VzbSgyhbVOmQFw52rD8JdQhBKUfkuWsaSucdyiI
         6LquabkSMXqYIpYGOxqupZX0SnoDObiBEwBphsTN7YpOQA25Rf9F8XFKf10Bi2Ks77O/
         qo6cSnSM56AqffTzgs2A9rc02D0Y3+oBXQIkYiZ3K3RLoe6GTzc2bijcLoLuDJyPfKAy
         zbImaO7SFlr9/x/5fVtP5gbqGEJR2LV2ghJDagywwj3d/UKrt/Pam1sPP1eH1DLMyJx+
         tFVw==
X-Gm-Message-State: ACgBeo2zwX3+/bZSgbOQWT7HJY2sD6xIgUpENis2WhOOg7HvgdtHESMF
        B/4Ue7JRAcCWJ2rCeLHxzZl/LQ==
X-Google-Smtp-Source: AA6agR6xEtGucm4Kbo1Ls2x0QBrOK545GLZ5CdZfNi/eKMOiPoK+6vDdl9JG8UncSe+4M0wnAKi82w==
X-Received: by 2002:a05:6e02:1a45:b0:2f0:4b56:e5f3 with SMTP id u5-20020a056e021a4500b002f04b56e5f3mr2873087ilv.76.1662671997011;
        Thu, 08 Sep 2022 14:19:57 -0700 (PDT)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id q204-20020a6b2ad5000000b00685a7cccd2csm1440371ioq.45.2022.09.08.14.19.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 14:19:56 -0700 (PDT)
Message-ID: <995450c5-a4f2-d2d1-8a44-569726eb7231@kernel.dk>
Date:   Thu, 8 Sep 2022 15:19:55 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH] relay: replay_file_open(): NULL ptr deref in CPU hotplugs
Content-Language: en-US
To:     "Yichun Zhang (agentzh)" <yichun@openresty.com>,
        linux-fsdevel@vger.kernel.org
Cc:     Colin Ian King <colin.i.king@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
References: <20220908211731.11534-1-yichun@openresty.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220908211731.11534-1-yichun@openresty.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/8/22 3:17 PM, Yichun Zhang (agentzh) wrote:
> CPU hotplug may introduce race conditions. We reproduced kernel panics
> due to this NULL ptr deref error when doing frequent random CPU hotplugs
> in a KVM guest.
> 
> Signed-off-by: Yichun Zhang (agentzh) <yichun@openresty.com>
> ---
>  kernel/relay.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/relay.c b/kernel/relay.c
> index 6a611e779e95..2db69fd527d1 100644
> --- a/kernel/relay.c
> +++ b/kernel/relay.c
> @@ -816,6 +816,9 @@ EXPORT_SYMBOL_GPL(relay_flush);
>  static int relay_file_open(struct inode *inode, struct file *filp)
>  {
>  	struct rchan_buf *buf = inode->i_private;
> +	if (unlikely(buf == NULL))
> +		return -ENOENT;
> +
>  	kref_get(&buf->kref);
>  	filp->private_data = buf;

If it can go away before open is called, what prevents it from going
away after that check but before kref_get() is called?

-- 
Jens Axboe


