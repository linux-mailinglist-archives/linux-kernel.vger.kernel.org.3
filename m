Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E22B04B8FC9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 19:01:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237391AbiBPSCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 13:02:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230424AbiBPSCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 13:02:00 -0500
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0022D1EC57;
        Wed, 16 Feb 2022 10:01:47 -0800 (PST)
Received: by mail-pf1-f172.google.com with SMTP id g1so2781284pfv.1;
        Wed, 16 Feb 2022 10:01:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=EVx53SM1NvCfLrA4EvRitzfi4tzZhaUbaYRbzF2qQ08=;
        b=oBswWGhQTsL6gU9yHBpYNCGtaRPEQxTia1/Ba1hD1669MJ5cNfMRJmkwcBXnIfKMKo
         o2/g83CAAsme+gRSHJB4GhbOoXMZx1qOOdpdvJnV7rHpvmpN7jk2D3M/9hxWB8BV8BBE
         oFz3dhogyLyUrgT6f1SBJ1Xlt+ALzIa29iqPTqOZzadbk0ysPEGPge4sxXrLURHCXifT
         jqowXz8EmX1+lZcTR569jq66927sb8bz3uR8GK9ZRGZ6FKCsOKCHOycHLYMHvfOb7pDx
         ZhZ+4ZghF5OpWLd3xHwdD6k6kww/mIWS2Kg1mm8J0Aq2e9yc1abfbYijXal9TPRz0qXQ
         WUKw==
X-Gm-Message-State: AOAM533EGtwq+E6JLKNeCGM378h7+Yh8THEn55W5D6n5x/Gh2vhvF2pb
        47QYNXyss/IwPXGXXFt7VgU=
X-Google-Smtp-Source: ABdhPJzvcW70UDpYPenN+Q7RqDmEQY5lZoXe33JAoOVcS7kSSFaIFSmzyGSeSKdn3I4YI/sHGhUdmg==
X-Received: by 2002:a63:f94a:0:b0:372:b168:1aff with SMTP id q10-20020a63f94a000000b00372b1681affmr3190648pgk.441.1645034507207;
        Wed, 16 Feb 2022 10:01:47 -0800 (PST)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id 11sm20449011pja.36.2022.02.16.10.01.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Feb 2022 10:01:46 -0800 (PST)
Message-ID: <306b80f7-1185-17b8-fb85-7241823681d0@acm.org>
Date:   Wed, 16 Feb 2022 10:01:43 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [RFC V2 5/6] blk-ioprio: make ioprio pluggable and modular
Content-Language: en-US
To:     Wang Jianchao <jianchao.wan9@gmail.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     hch@infradead.org, Josef Bacik <jbacik@fb.com>,
        Tejun Heo <tj@kernel.org>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220215123705.58968-1-jianchao.wan9@gmail.com>
 <20220215123705.58968-6-jianchao.wan9@gmail.com>
 <cb5677fc-01ac-f97f-ccf8-eb91505ad0e3@acm.org>
 <0608cd82-89c6-8fba-d06b-fdef9c53114f@gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <0608cd82-89c6-8fba-d06b-fdef9c53114f@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/15/22 18:09, Wang Jianchao wrote:
> On 2022/2/16 5:26 上午, Bart Van Assche wrote:
>> On 2/15/22 04:37, Wang Jianchao (Kuaishou) wrote:
>>> diff --git a/block/Makefile b/block/Makefile
>>> index f38eaa612929..f6a3995af285 100644
>>> --- a/block/Makefile
>>> +++ b/block/Makefile
>>> @@ -17,7 +17,8 @@ obj-$(CONFIG_BLK_DEV_BSGLIB)    += bsg-lib.o
>>>    obj-$(CONFIG_BLK_CGROUP)    += blk-cgroup.o
>>>    obj-$(CONFIG_BLK_CGROUP_RWSTAT)    += blk-cgroup-rwstat.o
>>>    obj-$(CONFIG_BLK_DEV_THROTTLING)    += blk-throttle.o
>>> -obj-$(CONFIG_BLK_CGROUP_IOPRIO)    += blk-ioprio.o
>>> +io-prio-y             := blk-ioprio.o
>>> +obj-$(CONFIG_BLK_CGROUP_IOPRIO)    += io-prio.o
>>>    obj-$(CONFIG_BLK_CGROUP_IOLATENCY)    += blk-iolatency.o
>>>    obj-$(CONFIG_BLK_CGROUP_IOCOST)    += blk-iocost.o
>>>    obj-$(CONFIG_MQ_IOSCHED_DEADLINE)    += mq-deadline.o
>>
>> Is the above change really necessary?
> 
> Except for making maintaining easier on a running system, removing a
> rqos policy module with cgroup supporting can release a blk-cgroup
> policy slots. As BLKCG_MAX_POLS, the max slots number is fixed now.

It seems like my question was not clear? What I meant is that I think 
that the above changes are not necessary to build blk-ioprio as a kernel 
module.

Thanks,

Bart.
