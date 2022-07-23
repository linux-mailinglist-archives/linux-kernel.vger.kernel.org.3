Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C45DA57EB81
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 04:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236896AbiGWCOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 22:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235826AbiGWCOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 22:14:37 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F304F7697E;
        Fri, 22 Jul 2022 19:14:35 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LqVC62XznzWf1x;
        Sat, 23 Jul 2022 10:10:42 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 23 Jul 2022 10:14:32 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 23 Jul 2022 10:14:31 +0800
Subject: Re: [PATCH] nbd: add missing definition of pr_fmt
To:     Yu Kuai <yukuai1@huaweicloud.com>, Joe Perches <joe@perches.com>,
        <josef@toxicpanda.com>, <axboe@kernel.dk>, <houtao1@huawei.com>
CC:     <linux-block@vger.kernel.org>, <nbd@other.debian.org>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>
References: <20220706093320.1962871-1-yukuai1@huaweicloud.com>
 <853a5164-78cf-1ccb-8e18-cff5b5bce4ff@huaweicloud.com>
 <49a8099eb7dd01e9d2d190056171341d87cd442b.camel@perches.com>
 <0dba2f0c-ba02-853e-60e7-873eabedcd80@huaweicloud.com>
From:   Yu Kuai <yukuai3@huawei.com>
Message-ID: <4e6a80cb-63fa-660c-8acf-f25062800238@huawei.com>
Date:   Sat, 23 Jul 2022 10:14:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <0dba2f0c-ba02-853e-60e7-873eabedcd80@huaweicloud.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

在 2022/07/20 19:46, Yu Kuai 写道:
> Hi !
> 
> 在 2022/07/18 22:32, Joe Perches 写道:
>> On Mon, 2022-07-18 at 21:52 +0800, Yu Kuai wrote:
>>> 在 2022/07/06 17:33, Yu Kuai 写道:
>>>> From: Yu Kuai <yukuai3@huawei.com>
>>>>
>>>> commit 1243172d5894 ("nbd: use pr_err to output error message") tries
>>>> to define pr_fmt and use short pr_err() to output error message,
>>>> however, the definition is missed.
>>> friendly ping ...
>> []
>>>> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
>> []
>>>> @@ -44,6 +44,9 @@
>>>>    #include <linux/nbd-netlink.h>
>>>>    #include <net/genetlink.h>
>>>> +#undef pr_fmt
>>>> +#define pr_fmt(fmt) "nbd: " fmt
>>>> +

I tried to remove the #undef:

--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -44,7 +44,6 @@
  #include <linux/nbd-netlink.h>
  #include <net/genetlink.h>

  #define pr_fmt(fmt) "nbd: " fmt

And then following warning is triggered:

drivers/block/nbd.c:47: warning: "pr_fmt" redefined
    47 | #define pr_fmt(fmt) "nbd: " fmt

It semms that keeping that #undef is the right thing to do.

Thanks,
Kuai
>> Typically, this #define is place before all #include lines
>> so there is no need for an #undef
> 
> Thanks for you advice, I'll do that in v2.
> 
> Kuai
> 
> .
> 
