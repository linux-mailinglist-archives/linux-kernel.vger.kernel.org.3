Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDBEF48C754
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 16:38:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354682AbiALPhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 10:37:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354675AbiALPhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 10:37:41 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 846DFC061756
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 07:37:41 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id v6so4189244iom.6
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 07:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MT99N4Q2sFal4BV16Y2DBXC/G/wrM662hqSWy6/EPAQ=;
        b=D0S0R5BWdXP7WT4Jxia2RzF8E3yxC0WXj9P3O+YnVLnHhqSIQ2JW+5kY2dPh1PPR/Y
         7W1Tpbiu75Q/Fu3jQIkni3pTXyji2vObSu6rhv6ChCEDRL+stBsobpCCNra3vUD3ifxK
         AfFN1QmWvS9AZYTgmmNLcRFmC5G1oRummR9Qqm7eg0HogVm2JM7xvQu5RonTlRvEMHP5
         ULvw+lrRwa2Xaq/Y52RC6SOEdsdDpclOBFCFbJjmEcO9xmq6SgMr6J2CHG1cLxczqp5k
         O4w/FrdFAWlbwpGG73aM772tslqT+oTwNdEOtU5vqfjttquEwj8SVtyp4vw8VFdaEF9B
         hkuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MT99N4Q2sFal4BV16Y2DBXC/G/wrM662hqSWy6/EPAQ=;
        b=dmxm9OrLoRhvxd6UFKq9rZ4xXeb+6iH0/fDtuF72bOjsFSPAArRpB2gw2qhB68pt2Q
         QyMxd/w1KMrUs0JqTXkMgjilb7OrU9/4iZKM/cjZKWNjwaYDFuOfe98dPAhgixjq6DYd
         cHjLVrs3cod0wC5m47rnrFWipXGEz5AlSEIf9useNMADe8/1o3/nLustgXzmDJf8pqO+
         E9vRR77ddpErPFZoye2aLFIj0jF5CVPAhDjEN7vK/NeDHp49Ll7B/Ll5Nj8ZCkyoPX+p
         ZEBNoK0w6C7UXImxsBIg8NBUhUzvGjiZ9ajuSOj33upUrBpDPEL2Umw0aNtQL+oNXEEc
         UeOQ==
X-Gm-Message-State: AOAM533UO75BKECkBIdpAAHZyuyXKZpv8+V9Jod3RLtMlKNznxoiSk/R
        VB8oj8EvAiGlPsFcV2eoKnbLxDRjNGJUPg==
X-Google-Smtp-Source: ABdhPJxJdvuaZ19Y7sMdEg69RcgJIpnlbIXBJQAvPiqtQRRRwcBkrb+bQomtuKkXuGoodyXSRYGuHQ==
X-Received: by 2002:a6b:fd08:: with SMTP id c8mr129589ioi.184.1642001860721;
        Wed, 12 Jan 2022 07:37:40 -0800 (PST)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id a11sm62043ilj.33.2022.01.12.07.37.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jan 2022 07:37:40 -0800 (PST)
Subject: Re: [PATCH -next v4] blk-mq: fix tag_get wait task can't be awakened
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        John Garry <john.garry@huawei.com>
Cc:     QiuLaibin <qiulaibin@huawei.com>, ming.lei@redhat.com,
        martin.petersen@oracle.com, hare@suse.de,
        johannes.thumshirn@wdc.com, bvanassche@acm.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220111140216.1858823-1-qiulaibin@huawei.com>
 <Yd2Q6LyJUDAU54Dt@smile.fi.intel.com>
 <d7f51067-f5a8-e78c-5ece-c1ef132b9b9a@huawei.com>
 <Yd7J4XbkdIm52bVw@smile.fi.intel.com>
 <3d386998-d810-5036-a87e-50aba9f56639@huawei.com>
 <Yd7n7xA9ecF1/0DK@smile.fi.intel.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <03a3bece-12d7-6732-9b80-a008a86320ba@kernel.dk>
Date:   Wed, 12 Jan 2022 08:37:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <Yd7n7xA9ecF1/0DK@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/12/22 7:38 AM, Andy Shevchenko wrote:
> On Wed, Jan 12, 2022 at 12:51:13PM +0000, John Garry wrote:
>> On 12/01/2022 12:30, Andy Shevchenko wrote:
>>>>>> +		if (test_bit(QUEUE_FLAG_HCTX_ACTIVE, &q->queue_flags) ||
>>>>>> +		    test_and_set_bit(QUEUE_FLAG_HCTX_ACTIVE, &q->queue_flags)) {
>>>>> Whoever wrote this code did too much defensive programming, because the first
>>>>> conditional doesn't make much sense here. Am I right?
>>>>>
>>>> I think because this judgement is in the general IO process, there are also
>>>> some performance considerations here.
>>> I didn't buy this. Is there any better argument why you need redundant
>>> test_bit() call?
>>
>> I think that the idea is that test_bit() is fast and test_and_set_bit() is
>> slow; as such, if we generally expect the bit to be set, then there is no
>> need to do the slower test_and_set_bit() always.
> 
> It doesn't sound thought through solution, the bit can be flipped in
> between, so what is this all about? Maybe missing proper serialization
> somewhere else?

You need to work on your communication a bit - if there's a piece of
code you don't understand, maybe try being a bit less aggressive about
it? Otherwise people tend to just ignore you rather than explain it.

test_bit() is a lot faster than a test_and_set_bit(), and there's no
need to run the latter if the former returns true. This is a pretty
common optimization, particularly if the majority of the calls end up
having the bit set already.

Can the bit be flipped right after? Certainly! Can that happen if just
test_and_set_bit() is used? Of course! This isn't a critical section
with a lock, it's a piece of state. And guarding the RMW operation with
a test first doesn't change that one bit.

-- 
Jens Axboe

