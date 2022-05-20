Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF1A52E171
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 02:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243354AbiETA4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 20:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232272AbiETA4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 20:56:16 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3CD25C673
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 17:56:13 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id v10so6431298pgl.11
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 17:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Qy8eyoRBs5yiXN/0GtfHHCv3AARvpVaJFYQDrp6RKOY=;
        b=XGlUl+vgzpkRfgpMDhJgwQZC6kR5/4tdm4wA2PIaxiG0hGaN3czYewWNsHuDgL3C62
         oBr1Wbyp1AvsGW3iqafovjH27t9GVZ4m2uZCNL23WcN3hLqkPZ4cbURlnD6sI1kulhz5
         QeGMg19wur7zvpqZq4cFPbcepIWQd46FJLKKZDrO+Cx3j7jZKZXAJm5gtQ6T3NIwqNj4
         5qih06f7naHne7RiCSS9LplZau5WDsRVqXSEV2e0CXDscAjnyEmMP98ckbEyVzK1Caju
         QQIw/IE9NE0ycqkhFmmh2EIhQIxz98lfHwdf5/8aVOAyLu62HxBotAFDRnlMZPbwHTwy
         QtEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Qy8eyoRBs5yiXN/0GtfHHCv3AARvpVaJFYQDrp6RKOY=;
        b=da35ZKUHoud2ybhhZyP8U9Mq0G/uRRb43OqSF0aR6G1bKhKbMp+50e1A/YFG5uYUzT
         7uICnNJtgml/rSkniKzuNRssoHDnZDrF0EIrk1yS4KIC1Ugp/kdmc57t2cwcCWP4vqHQ
         HShuTcuGEFVStgfmD+uEo+8ny/vmN6nT2ErJeqOwa+nj1bAuCA+dRn9n8UynvLGoXJFl
         DyjYBzZ46moKkXgjKluozOZvmAQUyTufzSejZIUpNkeApOu3eNOgZUL5PkYWPyL9RhIF
         a2xqmCE4P5uQ0102ZezDRyDUDF/vI61sTrZYdQh/OERloWvhWbwUaG4iy4i0/Zv1vT5L
         yOag==
X-Gm-Message-State: AOAM531ou+qlIOWs8ii0ZoG9zmbnAA3ar8u6c/Y6eko0G1Nfa7OLWPcz
        3FJ8tu549JXbTEQNr6xULNfuNg==
X-Google-Smtp-Source: ABdhPJxGsQmGgAr8PyOeWJcAzFBJt+e/lqccNiHlbdTt0s5rCTuNMGwg3zdeH+aPwBVHI8CWjHYOSw==
X-Received: by 2002:a63:5a01:0:b0:3d8:22cb:9224 with SMTP id o1-20020a635a01000000b003d822cb9224mr6175648pgb.548.1653008173301;
        Thu, 19 May 2022 17:56:13 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id b2-20020aa78702000000b0050dc76281fcsm275308pfo.214.2022.05.19.17.56.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 May 2022 17:56:12 -0700 (PDT)
Message-ID: <84d073aa-9937-1a58-dd7a-b1828874c21a@kernel.dk>
Date:   Thu, 19 May 2022 18:56:12 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCHSET 0/2] Fix splice from random/urandom
Content-Language: en-US
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, Christoph Hellwig <hch@lst.de>,
        LKML <linux-kernel@vger.kernel.org>
References: <YoajCafKmgUbbaY0@zx2c4.com>
 <a6c843ff-a3d7-ce6a-4e99-70968834a02a@kernel.dk> <YobPB27Ozl7uqUEu@zx2c4.com>
 <3553b935-0aca-3d3e-2495-12288f601b53@kernel.dk>
 <CAHmME9riX+YuqSVp64bhy=nX08_7d-m8es82BHy2qh-oWkqa8Q@mail.gmail.com>
 <aa7ae20c-a2d7-4959-b5fb-efe7b56294f1@kernel.dk>
 <CAHmME9oLPxzsnRezFPFVssmedOQUi2E9NWFbakEe92=Hdk1QuQ@mail.gmail.com>
 <03c7d6c9-0c86-d4b6-357d-d51be0143c80@kernel.dk>
 <CAHmME9qVQNkx-0J8rq_0ZVaSR+-eEgOUtcZhvq5dAY4-kJxSAA@mail.gmail.com>
 <13899409-e81b-8689-3380-249de46c0b6f@kernel.dk> <YobldmDn6pU9mr4f@zx2c4.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <YobldmDn6pU9mr4f@zx2c4.com>
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

On 5/19/22 6:48 PM, Jason A. Donenfeld wrote:
> Hi Jens,
> 
> On Thu, May 19, 2022 at 06:02:55PM -0600, Jens Axboe wrote:
>> On 5/19/22 6:00 PM, Jason A. Donenfeld wrote:
>>> Hi Jens,
>>>
>>> On Fri, May 20, 2022 at 1:57 AM Jens Axboe <axboe@kernel.dk> wrote:
>>>>
>>>> On 5/19/22 5:27 PM, Jason A. Donenfeld wrote:
>>>>> Hi Jens,
>>>>>
>>>>> On Fri, May 20, 2022 at 1:25 AM Jens Axboe <axboe@kernel.dk> wrote:
>>>>>> I'll leave that to you :-)
>>>>>
>>>>> Alright, I'll have a look. Which one do I want here? This series adds
>>>>> splice_read/splice_write. The new thing would be sendpage? Or
>>>>> copy_file_range? Or something else?
>>>>
>>>> For copying kernel memory? It's really the same thing, you just
>>>> initialize the iter as an ITER_KVEC instead. The nice thing about the
>>>> iov_iter iterator that it then hides that for you, call the same copy
>>>> in/out helpers for it.
>>>
>>> Err, maybe we're talking about different things? I was thinking about
>>> the plumbing to make splice/sendfile work on non-pipes.
>>
>> Ah I see. sendfile() just uses splice() internally, so that'll work
>> (again) with my changes. splice(), by definition, either moves to and
>> from a pipe. Hence one of the fds must be a pipe. Does that answer the
>> question?
> 
> sendfile() returns -EINVAL even with your patches. Only splicing to pipes
> seems to work.

Huh, that really should work. Are you trying to sendfile() to random? If
so, you need that last write_iter patch too, and add the splice_write as
I mentioned.

-- 
Jens Axboe

