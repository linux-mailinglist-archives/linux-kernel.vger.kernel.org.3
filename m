Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9667C4A00DA
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 20:27:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350928AbiA1T14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 14:27:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350969AbiA1T1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 14:27:52 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7097C061747
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 11:27:52 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id r144so8984873iod.9
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 11:27:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=44YundMarG4oJcqLVS+4O9jZDmTBDcQhSRUVkk3ZKW4=;
        b=nzXb4/P8PZ7yZyUUX6bta1uJ4avIKH+OTNZMoILFmYcqEFNTBgCmKiROLNV0+OmkXy
         Yy+iYbgFPQ7Sn9NwzwQ/PEjvsGe7KRpuNDASfopAeJS+786MEYBKUr01VYv5Gn8dOGpv
         FRyacLGvPbb0F4gGtmZtTw63lbdst8ml+siXk5Ld2C8fUyRe4y3JrjdR+yAbbA7AJ6H7
         T6unhvbXrf4FS1WhU6yBTa6D4XqXNBiO21JWt6qS6askgA6Ejac1T5gML9kvI0ybrUEK
         YGlHGbdDw6XCPqwIQoL+p0TVEO9cUclnfkWNzaRJjE1iOtvYJnFFjCOGugLrXBqwv4e5
         DJ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=44YundMarG4oJcqLVS+4O9jZDmTBDcQhSRUVkk3ZKW4=;
        b=Gygx2cAllz/S2ebzIyDrS/dPvORP8ie9IJ2q3oVcvtv6653fQKDOdeHi+6ofWkwvWs
         JezqpGuoHZCczKKkW8tJTOnGCek8Odc+Ye1TKrpwd7WpntuyhsPmXP2R4DGHLERvk8NO
         9AIe/ONFXRIeFg24Ilyf51B5nXcPHiwTC7FN3fXH7X1OSATk17/Giq5wFht3XbhyYoNk
         75C9kOaijqhpHxxIjicWbQ8oyfVtPJnkSkGImRsHkIo2atXRPknucG06S1R66En4A7ud
         XPizA3B+BcXVHxltTZLBujBsLNQ3N7tW4ZOMbjC0mFdcUNB1qP2wiAnZC2U+45cUxZqK
         cvWg==
X-Gm-Message-State: AOAM532yLd/YqQ9Gsvvo85+t8xPclJw/ukS+vpeimZLqVn2bFLbPNce7
        Trgk/4K+XUd0n+1CKlCdRSGbMa+ZASL6VA==
X-Google-Smtp-Source: ABdhPJzhXpKSu2j/L+GkIRRKLGEUPojlVErrSaziaJZFmqKOhpHYVxkyreeIw017Nn31RLvC+FDtSw==
X-Received: by 2002:a6b:4115:: with SMTP id n21mr5719126ioa.155.1643398071772;
        Fri, 28 Jan 2022 11:27:51 -0800 (PST)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id h13sm14552819ili.31.2022.01.28.11.27.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jan 2022 11:27:51 -0800 (PST)
Subject: Re: [PATCH v2 0/3] block, bfq: minor cleanup and fix
From:   Jens Axboe <axboe@kernel.dk>
To:     Yu Kuai <yukuai3@huawei.com>, paolo.valente@linaro.org,
        jack@suse.cz, tj@kernel.org
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        yi.zhang@huawei.com, linux-kernel@vger.kernel.org
References: <20211231032354.793092-1-yukuai3@huawei.com>
 <164338111974.263985.3933987922467783334.b4-ty@kernel.dk>
Message-ID: <2579c500-549f-ff04-d1e1-6cf3db10b428@kernel.dk>
Date:   Fri, 28 Jan 2022 12:27:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <164338111974.263985.3933987922467783334.b4-ty@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/28/22 7:45 AM, Jens Axboe wrote:
> On Fri, 31 Dec 2021 11:23:51 +0800, Yu Kuai wrote:
>> Chagnes in v2:
>>  - add comment in patch 2
>>  - remove patch 4, since the problem do not exist.
>>
>> Yu Kuai (3):
>>   block, bfq: cleanup bfq_bfqq_to_bfqg()
>>   block, bfq: avoid moving bfqq to it's parent bfqg
>>   block, bfq: don't move oom_bfqq
>>
>> [...]
> 
> Applied, thanks!
> 
> [1/3] block, bfq: cleanup bfq_bfqq_to_bfqg()
>       commit: a9c77f6ec0b566439182a10b64dd3e60a0408849
> [2/3] block, bfq: avoid moving bfqq to it's parent bfqg
>       commit: 36ad7fe0ec7485ee435f7a40452c7a58598779d4
> [3/3] block, bfq: don't move oom_bfqq
>       commit: a0b98e6fba18a40aa9672cc3e0abf980456f3ae6

For all those pings, this patchset sure didn't see a lot of compiles:

block/bfq-cgroup.c: In function ‘bfq_bfqq_move’:
block/bfq-cgroup.c:648:40: error: implicit declaration of function ‘bfq_group’; did you mean ‘bfqq_group’? [-Werror=implicit-function-declaration]
  648 |         struct bfq_group *old_parent = bfq_group(bfqq);
      |                                        ^~~~~~~~~
      |                                        bfqq_group
block/bfq-cgroup.c:648:40: error: initialization of ‘struct bfq_group *’ from ‘int’ makes pointer from integer without a cast [-Werror=int-conversion]
cc1: all warnings being treated as errors
make[1]: *** [scripts/Makefile.build:288: block/bfq-cgroup.o] Error 1
make: *** [Makefile:1831: block] Error 2

Dropped.

-- 
Jens Axboe

