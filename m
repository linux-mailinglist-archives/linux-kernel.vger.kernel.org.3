Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7EF251E23E
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 01:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377145AbiEFW1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 18:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350292AbiEFW1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 18:27:19 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6190747066
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 15:23:32 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id v10so7137328pgl.11
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 15:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=bQeusQtiIQTrk2ZgH2dBYFeZ0i4dvp2O1iwsKg+hU0U=;
        b=NxJhpCy+SP3Ka8ewEpH1clLBW8XMdH+yZjoVHxhVRQ2yy9MJqWEdzT204ft8gOvs5e
         4BmycVG9glwY3k8nJw75QNkoJAoktOFblrZi9rsENb/vFaFgBe2wscptEu2VTBbrxjLW
         q/Z8MITZL9pVQq7GyKxeS2EBqF1ZbIVlwCnr9nwHtWOHQ/VLJi6PkXN8g6rheDpdHCfg
         eeg9TFkTrGch2YSV8pFoG2IAVfDODcqI3WeawzpY6zUW3OzXEVqDp1zuVzEmbim9jCTd
         sqk3hBiY60X+niIszukI9E+vKia4eKtMRgPQcK4Aj2cFKGw7LiFO8uzWkvZcsdvxv7tE
         /gmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=bQeusQtiIQTrk2ZgH2dBYFeZ0i4dvp2O1iwsKg+hU0U=;
        b=onmkr/5LTlwYxJNgVPK4WXJ0aumLvCQDEl8tLhwjIEyDzu27jjKD4z/wi0qikdRoOn
         WuvhkKEFl7MlnTfk0mVhdGM2rsDRTKXK6Z8UXBLGomI4VKRuwQf4nwUFuyRQWN1/i0PG
         zWfbs+X4WLBAuF4Vgtfkj4tk4dpPu0fE4F335MRtFAHm37Bbte2toCEdnbckTIjjsAva
         4AgCTBw1+nqdV1wuScsuMuCeX+naw/22bra1KtnazqKOWynjRZyENM+WiWYQSSFn4C6s
         WV+7sCdMPNC76ttMScSPYRVsqFW7QyumXiR3KIYPb3plBOVR/wfkg2ZMAQi1tGYZJTuH
         zpQA==
X-Gm-Message-State: AOAM532jAxOp1tDge8cKpEhTClO6EvdY1h8Ic4TkKxlmZhq18peiLR2K
        c7ytGoAMks89ORLrefK1JG8EFg==
X-Google-Smtp-Source: ABdhPJxM5R1ryAs2VQlGEpU/WX9KsBXK7e7/PznQ1F7qwsU29rndvcUvz0/dnm/nbYu1frJAgqCSXQ==
X-Received: by 2002:aa7:84d1:0:b0:510:8796:4f38 with SMTP id x17-20020aa784d1000000b0051087964f38mr3289040pfn.8.1651875811461;
        Fri, 06 May 2022 15:23:31 -0700 (PDT)
Received: from [192.168.4.166] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id j2-20020a17090276c200b0015e8da1fb07sm2247413plt.127.2022.05.06.15.23.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 May 2022 15:23:31 -0700 (PDT)
Message-ID: <9157fe69-b5d4-2478-7a0d-e037b5550168@kernel.dk>
Date:   Fri, 6 May 2022 16:23:30 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 0/5] fast poll multishot mode
Content-Language: en-US
To:     Hao Xu <haoxu.linux@gmail.com>, io-uring@vger.kernel.org
Cc:     Pavel Begunkov <asml.silence@gmail.com>,
        linux-kernel@vger.kernel.org
References: <20220506070102.26032-1-haoxu.linux@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220506070102.26032-1-haoxu.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/6/22 1:00 AM, Hao Xu wrote:
> Let multishot support multishot mode, currently only add accept as its
> first comsumer.
> theoretical analysis:
>   1) when connections come in fast
>     - singleshot:
>               add accept sqe(userpsace) --> accept inline
>                               ^                 |
>                               |-----------------|
>     - multishot:
>              add accept sqe(userspace) --> accept inline
>                                               ^     |
>                                               |--*--|
> 
>     we do accept repeatedly in * place until get EAGAIN
> 
>   2) when connections come in at a low pressure
>     similar thing like 1), we reduce a lot of userspace-kernel context
>     switch and useless vfs_poll()
> 
> 
> tests:
> Did some tests, which goes in this way:
> 
>   server    client(multiple)
>   accept    connect
>   read      write
>   write     read
>   close     close
> 
> Basically, raise up a number of clients(on same machine with server) to
> connect to the server, and then write some data to it, the server will
> write those data back to the client after it receives them, and then
> close the connection after write return. Then the client will read the
> data and then close the connection. Here I test 10000 clients connect
> one server, data size 128 bytes. And each client has a go routine for
> it, so they come to the server in short time.
> test 20 times before/after this patchset, time spent:(unit cycle, which
> is the return value of clock())
> before:
>   1930136+1940725+1907981+1947601+1923812+1928226+1911087+1905897+1941075
>   +1934374+1906614+1912504+1949110+1908790+1909951+1941672+1969525+1934984
>   +1934226+1914385)/20.0 = 1927633.75
> after:
>   1858905+1917104+1895455+1963963+1892706+1889208+1874175+1904753+1874112
>   +1874985+1882706+1884642+1864694+1906508+1916150+1924250+1869060+1889506
>   +1871324+1940803)/20.0 = 1894750.45
> 
> (1927633.75 - 1894750.45) / 1927633.75 = 1.65%
> 
> 
> A liburing test is here:
> https://github.com/HowHsu/liburing/blob/multishot_accept/test/accept.c

Wish I had seen that, I wrote my own! But maybe that's good, you tend to
find other issues through that.

Anyway, works for me in testing, and I can see this being a nice win for
accept intensive workloads. I pushed a bunch of cleanup patches that
should just get folded in. Can you fold them into your patches and
address the other feedback, and post a v3? I pushed the test branch
here:

https://git.kernel.dk/cgit/linux-block/log/?h=fastpoll-mshot

-- 
Jens Axboe

