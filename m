Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D4BB53071F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 03:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349024AbiEWBYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 21:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233111AbiEWBYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 21:24:41 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 125F4DFA5
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 18:24:40 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id u15so12314284pfi.3
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 18:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=oximGdL85AdyYM4EyrHBMR8JY42eOGAKAouksms98f0=;
        b=pxJ2UZmJRrY2NLXz4OLAZ67pT7PJyixhai/tBlwrwNUjBRr2Udq+056WLiclqUMvTB
         4wcC8pgS+GP0WO+CZHJMuYGwNxuusVHJFZiD7vp9f8RQ/myi6BbozzuhsWIBOopwlrL/
         kWN6Qlngaz8YJjX+3Qe5O1hpgPiR7WpgMJpewWQIplVVcjOxnX+QXsMGe3StX+4ZQpZF
         4s7aK6xqj7cPwtpRBin3N0DduqOlwrwLGhDAXaIblyfx5wSap5mPaGLJoMjrYt4qz3aU
         VkmLiY+dEYPkpbAFKIlrO5EhGWlNWrOC74rEqzgx3wQPO5mjKBV46fHwvHeL73yt89bu
         YLCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=oximGdL85AdyYM4EyrHBMR8JY42eOGAKAouksms98f0=;
        b=Kued7E+mTy/K21iV9fXyZTyNn5C9bWcTS2ZR28rWC7ml6bmwyLA0/xkaZrN/yUpnmu
         NG9NFkTx0I6laLsgsvg38Qe4fSv1hdc2Mav6irocz+eNDgQjp0H39pRi1/818vk8jfvU
         pAnHGHadXiI74ajCy6Lnb1w+t8GkKgPtHpikiZyCIS7lKHyH573kMVQVVGT1vU9z0vxi
         OCriAwNEj/PDi0XMWycSclJ1XGldGswhDR04/SjF9s/t3cxSIiK+eSy5dGydnqgjEoRV
         OkEH9cCS75FFK+Q1ZYawXBH9UwO8aeWk8KsnKAk1RH3Y4ENBKGLuAJ+8LgB1tXswLM/I
         ULng==
X-Gm-Message-State: AOAM530fYal9peVKpr9xdH2Y0gACiOejzxk2u+Z11v87zA+w24PqrEfr
        kO3Rer/POKrB9v/JvEz8t+GScQ==
X-Google-Smtp-Source: ABdhPJylwLfBUUYnWSOWSv13Eee2jo+ut/I0y5+pZB7Awa3MmYJZPro0Ta7eXHvl/qGL9ZOpoU506A==
X-Received: by 2002:a63:f518:0:b0:3fa:6f09:aac5 with SMTP id w24-20020a63f518000000b003fa6f09aac5mr947876pgh.515.1653269079511;
        Sun, 22 May 2022 18:24:39 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id u12-20020a170902a60c00b00161a16f0050sm3713018plq.222.2022.05.22.18.24.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 May 2022 18:24:39 -0700 (PDT)
Message-ID: <b32ed748-a141-862c-ed35-debb474962ed@kernel.dk>
Date:   Sun, 22 May 2022 19:24:37 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH -next v5 0/3] support concurrent sync io for bfq on a
 specail occasion
Content-Language: en-US
To:     "yukuai (C)" <yukuai3@huawei.com>, paolo.valente@linaro.org
Cc:     jack@suse.cz, tj@kernel.org, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
References: <20220428120837.3737765-1-yukuai3@huawei.com>
 <d50df657-d859-79cf-c292-412eaa383d2c@huawei.com>
 <61b67d5e-829c-8130-7bda-81615d654829@huawei.com>
 <81411289-e13c-20f5-df63-c059babca57a@huawei.com>
 <d5a90a08-1ac6-587a-e900-0436bd45543a@kernel.dk>
 <55919e29-1f22-e8aa-f3d2-08c57d9e1c22@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <55919e29-1f22-e8aa-f3d2-08c57d9e1c22@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/22/22 7:10 PM, yukuai (C) wrote:
> ? 2022/05/21 20:21, Jens Axboe ??:
>> On 5/21/22 1:22 AM, yukuai (C) wrote:
>>> ? 2022/05/14 17:29, yukuai (C) ??:
>>>> ? 2022/05/05 9:00, yukuai (C) ??:
>>>>> Hi, Paolo
>>>>>
>>>>> Can you take a look at this patchset? It has been quite a long time
>>>>> since we spotted this problem...
>>>>>
>>>>
>>>> friendly ping ...
>>> friendly ping ...
>>
>> I can't speak for Paolo, but I've mentioned before that the majority
>> of your messages end up in my spam. That's still the case, in fact
>> I just marked maybe 10 of them as not spam.
>>
>> You really need to get this issued sorted out, or you will continue
>> to have patches ignore because folks may simply not see them.
>>
> Hi,
> 
> Thanks for your notice.
> 
> Is it just me or do you see someone else's messages from *huawei.com
> end up in spam? I tried to seek help from our IT support, however, they
> didn't find anything unusual...

Not sure, I think it's just you. It may be the name as well "yukuai (C)"
probably makes gmail think it's not a real name? Or maybe it's the
yukuai3 in the email? Pure speculation on my side.

-- 
Jens Axboe

