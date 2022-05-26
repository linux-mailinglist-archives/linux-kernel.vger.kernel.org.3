Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D523F535676
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 01:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237770AbiEZXnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 19:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239878AbiEZXnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 19:43:35 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87EEA28725
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 16:43:34 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id a9so2542889pgv.12
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 16:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=LVT+hnAFEArODTLjjL6u957Oo8LFMcs8Kqe5NqWbyq0=;
        b=50hwK5Xdsh8uEqJ/XEkV/OV3UKXNHFz0lvEkauUBLEMmhAHpB2I1ZJDnIaewr8qiVI
         ur+pSBNRGjLPzB3v5Xo8zCb2Njei+xAtlPYL7d6CM2xdqjK145tL17zb2MjQAkU+glSt
         IBqx0NtBPgM7tpTnWyCRWijLZzv2Unn5dh1FhMlEWqW2fDtS1OVG9yMZqLynaVpSCwNW
         Ymt8MwkTBQ4RJHE8m453cTATa3GYAGlqS254D124yOv+BR6lD+RkZ+SSqLokLtIBl4uz
         4amiI4oh13Y2e/KHe4T53m+puWtOEeDEvowWW+S9eua1YxkTcbpGG+054W+/FaBvyAcF
         Ipag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=LVT+hnAFEArODTLjjL6u957Oo8LFMcs8Kqe5NqWbyq0=;
        b=DtkGyMMyANkEQ/UXyApK15lTUSMgkbDG0IYtqmnFO3O/hzpvpdt1/0NY3CvrhM4pMu
         gpWPK9g+JPFT2Q+dmSYFzCJlqal1PT6MkkyqHrumHdQ5Ob8JCK+n3gCbw/zY0FZVdflM
         746fn2mofZ/NWRM6JGuCMAoiY5xUYYmknLqRabL10rICEU6OfZHh/i2pzAIQ0UsDbsFi
         26nyAZXai0kd8Ph82P+VJLUK3sgWQYaBWkykGoDp4cO8FuxbAkAcbKnnhBTfoM/NSlgO
         UXTUyDWEfCLwHsPdEUDR+KhhTOaWGvP23Rg2SYLmCkAw6dCfNM3nMVgapV5rW4Dp2iun
         OZlg==
X-Gm-Message-State: AOAM531xQJUtKVmiOXpuvW2XRsUjDPYLNodE7iU9vkOC+iZAh0icNupr
        83jVFjZRNaGYh+2Y5uGfzGDuAP+NO/L63A==
X-Google-Smtp-Source: ABdhPJyAS/kjg2C00QbkfvCAuSDQJgvx0IkWdvaLJ7VQSQaTmaTuPrel1QRS5EoXASHMELn4xvaiWw==
X-Received: by 2002:a62:ae19:0:b0:518:db6a:5b85 with SMTP id q25-20020a62ae19000000b00518db6a5b85mr13085709pff.61.1653608613048;
        Thu, 26 May 2022 16:43:33 -0700 (PDT)
Received: from ?IPV6:2409:8a28:e6d:c000:9d26:281f:3d89:5507? ([2409:8a28:e6d:c000:9d26:281f:3d89:5507])
        by smtp.gmail.com with ESMTPSA id i5-20020a17090332c500b00161b797fc42sm2247016plr.106.2022.05.26.16.43.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 May 2022 16:43:32 -0700 (PDT)
Message-ID: <d7309ffb-ee19-6097-9f0d-5b811e14e8b7@bytedance.com>
Date:   Fri, 27 May 2022 07:43:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.1
Subject: Re: [Phishing Risk] [External] Re: [PATCH] blk-iocost: fix false
 positive lagging
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220526133554.21079-1-zhouchengming@bytedance.com>
 <Yo+8K9MrFMl59BGj@slm.duckdns.org>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <Yo+8K9MrFMl59BGj@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 2022/5/27 01:43, Tejun Heo wrote:
> Hello,
> 
> On Thu, May 26, 2022 at 09:35:54PM +0800, Chengming Zhou wrote:
>> I found many false positive lagging during iocost test.
>>
>> Since iocg->vtime will be advanced to (vnow - margins.target)
>> in hweight_after_donation(), which called throw away excess,
>> the iocg->done_vtime will also be advanced that much.
>>
>>        period_at_vtime  <--period_vtime-->  vnow
>>               |                              |
>>   --------------------------------------------------->
>>         |<--->|
>>      margins.target
>>         |->
>>   vtime, done_vtime
> 
> All it does is shifting the vtime (and done_vtime) within the current window
> so that we don't build up budget too lage a budget possibly spanning
> multiple periods. 

Yes, this is necessary. Suppose in the last timer, the iocg doesn't have inflights
and have excess, then iocg->vtime = iocg->done_vtime = (period_at_vtime - margins.target)

> The lagging detection is supposed to detect IOs which are
> issued two+ periods ago which didn't finish in the last period. So, I don't

Yes, I understand.

> think the above sliding up the window affects that detection given that the
> lagging detection is done before the window sliding. All it's checking is
> whether there still are in-flight IOs which were issued two+ windows ago, so
> how the last window has been fast forwarded shouldn't affect the detection,
> no?

Right, the lagging detection is done before the window sliding in this period timer.
The conditions that it checks vtime, done_vtime have been slided in the last timer.

time_after64(vtime, vdone) &&
time_after64(vtime, now.vnow - MAX_LAGGING_PERIODS * period_vtime) &&
time_before64(vdone, now.vnow - period_vtime)

The first condition says it has some inflights, the second condition is always true
if vtime has been slided in the last timer, the third condition will be true if the
cost of io completed since last timer < ioc->margins.target.

So I think it doesn't check correctly whether it has inflights that were issued two+
windows ago.

Thanks.

> 
> Thanks.
> 
