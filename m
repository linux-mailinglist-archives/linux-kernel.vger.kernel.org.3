Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F029752E0B3
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 01:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343690AbiESXoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 19:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343682AbiESXoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 19:44:14 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B79DB042E
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 16:44:13 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id o13-20020a17090a9f8d00b001df3fc52ea7so10036066pjp.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 16:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=gz19fXcyvIXAl3oGhMxQAf+ufRc1Vu/yCr1pjqtWYnw=;
        b=cEzhwuqns0Ti+qp+lGOzuo/YHGa90yGUqi/zDyTaJ7/+wDu9n2uicln2Gr4T7AkB7G
         BVdcFEMBjWCpSQrU/TsfSqbIBE7PkrWzTv5q9QH3Jta1KAHQuidtVTCAKfDYCFXC5EDh
         ucUAEjjXZ7tdG3ZUCOsr3RUmPsv2LfhGFQFe+ie+YXJ34tnJFCODnxtlLYSJUlvSylua
         hAaCRKS4yoSpj7Q4+GwiF2JNieEv9wTHujeaQfJw+kkfMCyWrdJM7/P+6LNantZ6BfEp
         iAb+fAmFjvJX5UAx0dsxvNx/0j/93asAvZPoADIPbHT5naMmKqwUlurr47NGpUEXb8v4
         g33g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=gz19fXcyvIXAl3oGhMxQAf+ufRc1Vu/yCr1pjqtWYnw=;
        b=i4fDYUcej1pAy9X3Lm9QanS1y/mc9AyAMiVZCxHtdfKzmMjBM6Rg9Q+60Hh3Zo+ZSS
         TtnTyJlVcjM4M36xwTZKNzamdQqu9HnNRejyuXbT2z9hdkjOZoG2kAoFmsvlasMFYs/N
         25UO7WXIpTRzM1CD9MyUAdmnL9Ft2GSoTE67khZsERloom2Wt3bospIdjf6rlQvMBQji
         TFxLrR/1kjVEOSfcaUKhHtZw2yRuN28Hi1ToEtPyeJKA0xa3mhFxQwn6rjPbHjnuHcXF
         i+79PiNHhExLL9pxgHyXjNWvxeZF+R0FR5qoMlp8qChhYOPlupg0jCpCmJs2YqK397sP
         TJ6A==
X-Gm-Message-State: AOAM530Iy+zZXnEvqEQXBAOi3ldcNHmAVmWUI+EvTShWwkULJP8kyMZR
        he1pwKG+1TsA0lQtmgpn4E7dpw==
X-Google-Smtp-Source: ABdhPJwA+eGStKH/9DXOLfi6FBwqui0ASR5GQhJkzlEjCyIf0wjGR/UldJwHTn91xl0T2IGUdSxqhA==
X-Received: by 2002:a17:90b:3806:b0:1df:99ce:d142 with SMTP id mq6-20020a17090b380600b001df99ced142mr7618845pjb.241.1653003853140;
        Thu, 19 May 2022 16:44:13 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id x9-20020a17090a6b4900b001df313f6628sm366247pjl.21.2022.05.19.16.44.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 May 2022 16:44:12 -0700 (PDT)
Message-ID: <340465ab-4157-8051-d66f-9093b80dc653@kernel.dk>
Date:   Thu, 19 May 2022 17:44:11 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCHSET 0/2] Fix splice from random/urandom
Content-Language: en-US
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, Christoph Hellwig <hch@lst.de>,
        LKML <linux-kernel@vger.kernel.org>
References: <20220519193133.194138-1-axboe@kernel.dk>
 <YoajCafKmgUbbaY0@zx2c4.com> <a6c843ff-a3d7-ce6a-4e99-70968834a02a@kernel.dk>
 <8e6c98d4-03e9-3eb5-3d4e-b9a9faeb677a@kernel.dk> <YobPfgkzGrNPDDFI@zx2c4.com>
 <60b82026-9c46-16ea-d9fa-05eb96ae2218@kernel.dk>
 <CAHmME9rdJ=Pa=KOY6voryiHffWSkRKxC75+Wz-xoQOpowObwWw@mail.gmail.com>
 <3bcbfde4-3247-b4ff-9a7c-963a9a510703@kernel.dk> <YobVLs3mpEFjJCh3@zx2c4.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <YobVLs3mpEFjJCh3@zx2c4.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/19/22 5:39 PM, Jason A. Donenfeld wrote:
> Hi Jens,
> 
> On Thu, May 19, 2022 at 05:33:01PM -0600, Jens Axboe wrote:
>> On 5/19/22 5:25 PM, Jason A. Donenfeld wrote:
>>> Hi Jens,
>>>
>>> On Fri, May 20, 2022 at 1:22 AM Jens Axboe <axboe@kernel.dk> wrote:
>>>> I can certainly do the write side too. To fix this regression, I just
>>>> valued doing read_iter first and I'd hate to hold that up to do the
>>>> write side too. I'll do the write side later today, but let's keep them
>>>> separate.
>>>
>>> Excellent, thanks. I plan to queue these up all in a row.
>>
>> Built and tested v2, just sent it out. Note that it deviates from your
>> proposal a bit since with that we lost the
>>
>> if (!len)
>> 	break;
>>
>> check, which is kind of important if you ever want to be done :-)
> 
> Heh, noticed that too, thanks.

:-)

>> I'll do the write_iter side, but as mentioned, I'd prefer to keep it
>> separate from this patchset as this one fixes a real regression that we
>> need to get backported too.
>  
> No problem. Because of all the flux in random.c lately, I've been
> preparing a massive backports branch, 2 branches actually, so I'll make
> sure this is in there. Backport concern aside, though, I'll look for
> your write_iter patch today. Thanks a bunch for doing this.

Sounds great, thanks - write patch has been sent out too.

-- 
Jens Axboe

