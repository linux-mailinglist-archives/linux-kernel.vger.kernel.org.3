Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B50B4B7CE3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 02:56:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241521AbiBPBoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 20:44:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232045AbiBPBoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 20:44:06 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FFCDF9F87;
        Tue, 15 Feb 2022 17:43:55 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id v22so113389pgb.0;
        Tue, 15 Feb 2022 17:43:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=sBqUWhLOfuM8cBn3lZB8mcgooapXqw9+iXRzpDONfss=;
        b=dymwFmpaLlKaD8KQHESLM/vl6g21Sp8Hh+P713+oiTlY0cWoyycIgUIr18vyqFtSbQ
         E9TvVJJB6F/fNWWH4iAbAHrekHqNqlEPzo71gu5Y2iasY4zRZyLwZxaKMqYmpCCJW6c4
         x1yFI/XzE/OESW5MYzyzuwyI0GAGaFJBxynoQ6nphNOMtzUJ2AGesrZdWlC4LrACBudK
         6g2zF5xFb4dQt71JH8AS9h4sXotdYIcvN4zcX3KKjLVOlJe3LLF8/tQ8w+QXiV2v3/4F
         T6ssXzB+7HzAkQ1PFYiGyQLUfuIAlkD5hiFNJ2PJdb0dX97SevkLTVsLvpZpWwe2RE8b
         X70g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=sBqUWhLOfuM8cBn3lZB8mcgooapXqw9+iXRzpDONfss=;
        b=sGk0D+ZEneUeSxhdVT9edo1HtSzzmpv5ph9QDG3h+7lpIcqayRKjD5vzyLhDuLTDSr
         vcDtE7vfVnFt68dxvB82WZchTyzhdeB8EraCECRtTuXTsBYOsTokWmoaDZ5HKilLQNoY
         X7xNYmNxFuExgZLC4QkHeRNlavtaKw+reEsb+Nw51DgaUcA3K6oMnb4AbruABjh0Gy+h
         A7V7CtK7rp67PAkkr8j7qkLGBSRFlp/kJ2KmEaDQy4FsWEEggp/S7sLM5SRe+NyGBV/3
         79uLh88D2JhBIu2ZghNbQZ/ELmyTllwVfGhqQN56MN35g5ZfMGSI5lsZsT6J/jgbquwj
         Q8CQ==
X-Gm-Message-State: AOAM5305Z+abvOUhj744yltATcGGiCbwBtZWguK6haIcBNflnGdhnUCk
        zvWgMtwXnX3VhapfZOOniqI=
X-Google-Smtp-Source: ABdhPJwVMIlANY5aAEF+dk+PoYSnulrEFdguTx0c5fdN/FjfUIno85D2VmPNOXmm/cnjCDwyptIiaA==
X-Received: by 2002:a05:6a00:8d1:b0:4c9:f1a0:e0d0 with SMTP id s17-20020a056a0008d100b004c9f1a0e0d0mr781604pfu.53.1644975834859;
        Tue, 15 Feb 2022 17:43:54 -0800 (PST)
Received: from [172.20.119.15] ([61.16.102.73])
        by smtp.gmail.com with ESMTPSA id n5sm3759862pgt.22.2022.02.15.17.43.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Feb 2022 17:43:54 -0800 (PST)
Message-ID: <82a67141-7b4f-1254-4622-74bfd19a541d@gmail.com>
Date:   Wed, 16 Feb 2022 09:43:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.0
Subject: Re: [RFC V2 0/6] blk: make blk-rq-qos policies pluggable and modular
Content-Language: en-US
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc:     "hch@infradead.org" <hch@infradead.org>,
        Josef Bacik <jbacik@fb.com>, Tejun Heo <tj@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
References: <20220215123705.58968-1-jianchao.wan9@gmail.com>
 <44f86e8d-45f4-f40e-bc8b-00aa4f488f3a@nvidia.com>
From:   Wang Jianchao <jianchao.wan9@gmail.com>
In-Reply-To: <44f86e8d-45f4-f40e-bc8b-00aa4f488f3a@nvidia.com>
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



On 2022/2/15 9:01 下午, Chaitanya Kulkarni wrote:
> Wang Jianchao (Kuaishou),
> 
> On 2/15/22 04:36, Wang Jianchao (Kuaishou) wrote:
>> Hi Jens
>>
>> blk-rq-qos is a standalone framework out of io-sched and can be used to
>> control or observe the IO progress in block-layer with hooks. blk-rq-qos
>> is a great design but right now, it is totally fixed and built-in and shut
>> out peoples who want to use it with external module.
>>
>> This patchset attempts to make blk-rq-qos framework pluggable and modular.
>> Then we can update the blk-rq-qos policy module w/o stopping the IO workload.
>> And it is more convenient to introduce new policy on old machines w/o udgrade
>> kernel. And we can close all of the blk-rq-qos policy if we needn't any of
>> them. At the moment, the request_queue.rqos list is empty, we needn't to
>> waste cpu cyles on them.
>>
>>
> 
> Please write tests in blktests [1] to cover the code that we are
> changing in this commit.
> 
> -ck
> 
> [1] https://github.com/osandov/blktests
> 

Yes, I will send out next

Thanks
Jianchao
