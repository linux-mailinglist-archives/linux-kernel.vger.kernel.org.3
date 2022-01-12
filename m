Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E685F48C897
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 17:38:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349975AbiALQiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 11:38:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343550AbiALQiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 11:38:12 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02E49C06173F
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 08:38:12 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id h23so4400714iol.11
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 08:38:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=y+e/Abjluh2qjRwXoFE5SuEjr/IJUMHa4m2SRSbbLfw=;
        b=yQXlUaU5PjJ3upop3OQQrfIPE66U+P7AdW2r2E8KWDXkCVoNmaLXah5I47DQmRdnxt
         QoHW4Srchizm4cIZcGbuReX47iXxEXcIgVDflYNInJEnKTaSg5ex5RMXpcknbM6SXIcB
         jKv4/CVpZGUzrgT+MU1AwIOlt608U4NOUNKkRTMQMTP1LMvuZcYRduih7aZM1I2ursME
         vAkpN3YzakKnN1VtcHdb974JxZePFYFLomcoi2iIai1KztBXVlxs4rrphCGvYcAzNDf/
         wVztaNNMDlhn52m0GK2RkG1wWlVjBapJOGdLlYReQiDLuV/K8zKqSxmdXqA7D39dOay/
         lcJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=y+e/Abjluh2qjRwXoFE5SuEjr/IJUMHa4m2SRSbbLfw=;
        b=ZswYrW2UJfN/r5CgI1s3B+7q9syNrKggzdbsONUr/6TVnax7285btsebzRL0i3688E
         H/7ZrEXky5V63LuiABp2GWK6gZXdNoXgoF89UhzEl2qs4g7A4OIvEo25qHWIyE2jUZJk
         aQyaFosQXjYMeX2XH9bGZwIotyD3i9CnRAbIXTq6r/jOAYrLSpuRhMx+yXGdcGyQbV52
         QModk2+wXXpbDWG6Rek5HoCVbxSDaCzOW77xwOIpznT9j3/qLRTAEcPV0/Tbwldn8s3q
         ntntawb3e5XM34L5wPDJZRQqgmvRXh8OMK/95hkz9GEcmEiZoKyORovbKlakYHAEDMg7
         Oxxw==
X-Gm-Message-State: AOAM531Fs1vkF5w8SkLb52N1QOucoG0YNPFryAIygVeS1dUnzb1Ot0x8
        BV6EG1+8ycXOlR8pCnaAU4qX5o4z61U74Q==
X-Google-Smtp-Source: ABdhPJzYpvaOJB0ObtsV0unjGXy+MdZ/MElQVoxlvGyY+OnkoRdm6x0nD0Wz3u1/4rtc+6Xi44CeUg==
X-Received: by 2002:a05:6602:168e:: with SMTP id s14mr283215iow.202.1642005491161;
        Wed, 12 Jan 2022 08:38:11 -0800 (PST)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id t6sm201750iov.39.2022.01.12.08.38.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jan 2022 08:38:10 -0800 (PST)
Subject: Re: [PATCH -next v4] blk-mq: fix tag_get wait task can't be awakened
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     John Garry <john.garry@huawei.com>,
        QiuLaibin <qiulaibin@huawei.com>, ming.lei@redhat.com,
        martin.petersen@oracle.com, hare@suse.de,
        johannes.thumshirn@wdc.com, bvanassche@acm.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220111140216.1858823-1-qiulaibin@huawei.com>
 <Yd2Q6LyJUDAU54Dt@smile.fi.intel.com>
 <d7f51067-f5a8-e78c-5ece-c1ef132b9b9a@huawei.com>
 <Yd7J4XbkdIm52bVw@smile.fi.intel.com>
 <3d386998-d810-5036-a87e-50aba9f56639@huawei.com>
 <Yd7n7xA9ecF1/0DK@smile.fi.intel.com>
 <03a3bece-12d7-6732-9b80-a008a86320ba@kernel.dk>
 <Yd8B6F/6fW5DqxOl@smile.fi.intel.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <579f4be1-889a-3740-fa85-ca652ed3b2ae@kernel.dk>
Date:   Wed, 12 Jan 2022 09:38:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <Yd8B6F/6fW5DqxOl@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/12/22 9:29 AM, Andy Shevchenko wrote:
> On Wed, Jan 12, 2022 at 08:37:34AM -0700, Jens Axboe wrote:
>> On 1/12/22 7:38 AM, Andy Shevchenko wrote:
>>> On Wed, Jan 12, 2022 at 12:51:13PM +0000, John Garry wrote:
>>>> On 12/01/2022 12:30, Andy Shevchenko wrote:
>>>>>>>> +		if (test_bit(QUEUE_FLAG_HCTX_ACTIVE, &q->queue_flags) ||
>>>>>>>> +		    test_and_set_bit(QUEUE_FLAG_HCTX_ACTIVE, &q->queue_flags)) {
>>>>>>> Whoever wrote this code did too much defensive programming, because the first
>>>>>>> conditional doesn't make much sense here. Am I right?
>>>>>>>
>>>>>> I think because this judgement is in the general IO process, there are also
>>>>>> some performance considerations here.
>>>>> I didn't buy this. Is there any better argument why you need redundant
>>>>> test_bit() call?
>>>>
>>>> I think that the idea is that test_bit() is fast and test_and_set_bit() is
>>>> slow; as such, if we generally expect the bit to be set, then there is no
>>>> need to do the slower test_and_set_bit() always.
>>>
>>> It doesn't sound thought through solution, the bit can be flipped in
>>> between, so what is this all about? Maybe missing proper serialization
>>> somewhere else?
>>
>> You need to work on your communication a bit - if there's a piece of
>> code you don't understand, maybe try being a bit less aggressive about
>> it? Otherwise people tend to just ignore you rather than explain it.
> 
> Sure. Thanks for below explanations, btw.
> 
>> test_bit() is a lot faster than a test_and_set_bit(), and there's no
>> need to run the latter if the former returns true. This is a pretty
>> common optimization, particularly if the majority of the calls end up
>> having the bit set already.
> 
> I don't see how it may give optimization here generally speaking.
> If we know that bit is _often_ is set, than of course it sounds
> like opportunistic win. Otherwise, it may have the opposite effect.
> 
> I.o.w. without knowing the statistics of the bit being set/clear it's
> hard to say if it's optimization or waste of the (CPU) resources.

It doesn't really matter that much, the test_bit() is essentially free
compared to the test and set. Which means that in practice there's
little downside, and the upsides on when the bit is set is pretty big.

This technique has proven very useful in other spots, only downside is
really that there's no general helper to do this. That would also help
the readability.

-- 
Jens Axboe

