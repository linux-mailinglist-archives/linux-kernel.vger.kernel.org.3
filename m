Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0BE24C3B62
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 03:02:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236657AbiBYCDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 21:03:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236479AbiBYCDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 21:03:15 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B75A85974;
        Thu, 24 Feb 2022 18:02:44 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id m22so3595420pja.0;
        Thu, 24 Feb 2022 18:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=wZjioodKc5i2UrY3alN+TPIIALpLSLRR0tr9ny9WIyo=;
        b=Nx7NMD8qU/NXptOn+9dkF9Ix+eBmtRTZuRzKcblBxcw8keIKBEAvgcGmbo3f9Z/02/
         mNBM2w/uJjC55vSY6b5c4lM7swcdOZ+YnMU9EZBDNk/sH9nWELAl23eoR3UCiWcEn5q/
         FTl2iboXT1YQUWtU259SWugCJZZFZBLHNVkWPWrWbNqG312ulxwDh2jdbynvL8098PNd
         P5ykxJOohSup/GMBw1YoE9GUupu5Lfz8VsYebmGdet/jIFpZap8Ax01gofNvW6568K5Z
         Kd7MDaSnAl3ROb6n9ailuF53EviYpBNT/4HFgTsInY71wF8NGmJMNXJA5r5fKrEYtNU5
         W/Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=wZjioodKc5i2UrY3alN+TPIIALpLSLRR0tr9ny9WIyo=;
        b=AG6XMhNtwzGStyBme3a+w7OMWZOZowCSEST8GuXC8GAt+Y5jZQheio529ixK+b+KZ/
         h6UIIrCo6fpsD8+DXDsYc7QlD6fY/BjKAqP7J52W+uEXJPzYQHTtf5c+iHLFwNe5z/Lc
         fkFOVJfyWbNeJTLmsjklRhT0vqe9e63eGqqNulfcMUJaqYnwBxpp9RfjIAeEWsf416ph
         s2WunsodAcC3kcPtYeGJakAhBcpTSy4Q6EwXgFTnynguChfiFCDH/JBejQ0bCFqSB0PY
         FSfJgD4I/gVdj6QReA9fNdNiasR5NzLdo1j2X4dC1BrLGgHR4my8aty4DbGYp9SaWEow
         W5bQ==
X-Gm-Message-State: AOAM530zsJ68k5mDGfUIcKC6YrObujsLHlbnncN4wgkV+ihTD+x676DR
        0vgXu0JdZrfghoxkvwsLEN4=
X-Google-Smtp-Source: ABdhPJz05a2c5otlXDdIezkGb/k5WVIEc7aPtxwPaqdwdxj4146BHHVrCUDpiFd5fDCwNViZIwPfbw==
X-Received: by 2002:a17:90a:aa83:b0:1b9:7c62:61e5 with SMTP id l3-20020a17090aaa8300b001b97c6261e5mr946319pjq.118.1645754563771;
        Thu, 24 Feb 2022 18:02:43 -0800 (PST)
Received: from [172.20.119.15] ([61.16.102.72])
        by smtp.gmail.com with ESMTPSA id d25-20020a639919000000b00364f999aed5sm730865pge.20.2022.02.24.18.02.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Feb 2022 18:02:43 -0800 (PST)
Message-ID: <54557a1a-94b5-9f75-61f9-90991d5ff409@gmail.com>
Date:   Fri, 25 Feb 2022 10:02:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [RFC V4 1/6] blk: prepare to make blk-rq-qos pluggable and
 modular
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Josef Bacik <jbacik@fb.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220217031349.98561-1-jianchao.wan9@gmail.com>
 <20220217031349.98561-2-jianchao.wan9@gmail.com>
 <YhUbCH+dhKkgMirE@slm.duckdns.org>
 <2e17c058-8917-4a37-896e-1093446339f6@gmail.com>
 <39db454d-ca30-fb42-3d72-899efa34fb78@gmail.com>
 <YhapCurbiI21WYmm@slm.duckdns.org>
 <efd94670-9d6d-5651-358c-2f88646298cd@gmail.com>
 <Yhbod7pJ1X4CGhEZ@slm.duckdns.org>
 <7489a7f8-2589-29de-1c95-b99d1d9b1850@gmail.com>
 <Yhe38VnBq7VzUBAV@slm.duckdns.org>
From:   Wang Jianchao <jianchao.wan9@gmail.com>
In-Reply-To: <Yhe38VnBq7VzUBAV@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/2/25 12:53 上午, Tejun Heo wrote:
> On Thu, Feb 24, 2022 at 10:50:22AM +0800, Wang Jianchao wrote:
>> Yes, right now, every policy has their own way to turn off, but we always need to
>> iterate the rqos list and enter into the policy's callback to check it. And every
>> blkio cgroup needs to allocate memory for it even we don't use it.
>>
>> I don't this patchset is adding a new layer, but blk-rq-qos layer has been already
>> there , we just add a unified interface to open/close the policies.
> 
> We're talking in circles. We already know when a policy is inactive. If it
> sits in hot path in that state, take it off whatever gets iterated in hot
> path and put it back on when it actually gets enabled. The same goes for
> memory allocation. If there's substantial amount of memory allocted while
> not used, make that dynamic and trigger it when the policy starts getting
> used. It makes no sense to add another enable/disable interface on top.
>
It can make things more complicated if we does as above...

> FWIW, please consider the series nacked on this side.

Anyway, thanks so much for all of your comment ;)

Regards
Jianchao

