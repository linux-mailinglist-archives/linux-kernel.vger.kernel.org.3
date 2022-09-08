Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2C595B1232
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 03:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbiIHBn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 21:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbiIHBn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 21:43:57 -0400
Received: from out199-15.us.a.mail.aliyun.com (out199-15.us.a.mail.aliyun.com [47.90.199.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20797C7435
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 18:43:55 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R221e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VP.zpTy_1662601430;
Received: from 30.240.97.117(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0VP.zpTy_1662601430)
          by smtp.aliyun-inc.com;
          Thu, 08 Sep 2022 09:43:52 +0800
Message-ID: <c0a1e773-7dcf-0e27-95d8-beda673baac7@linux.alibaba.com>
Date:   Thu, 8 Sep 2022 09:43:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.1.2
Subject: Re: [PATCH] mm/damon: Remove duplicate get_monitoring_region()
 definitions
To:     SeongJae Park <sj@kernel.org>
Cc:     akpm@linux-foundation.org, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220907205911.62483-1-sj@kernel.org>
From:   haoxin <xhao@linux.alibaba.com>
In-Reply-To: <20220907205911.62483-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-14.1 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/9/8 上午4:59, SeongJae Park 写道:
> On Wed, 7 Sep 2022 17:27:12 +0000 SeongJae Park <sj@kernel.org> wrote:
>
> [...]
>>> diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
>>> index b1335de200e7..01938f33038d 100644
>>> --- a/mm/damon/ops-common.c
>>> +++ b/mm/damon/ops-common.c
>>> @@ -172,3 +172,31 @@ int damon_hot_score(struct damon_ctx *c, struct damon_region *r,
>>>
>>>   	return hotness;
>>>   }
>>> +
>>> +static inline int walk_system_ram(struct resource *res, void *arg)
>>> +{
>>> +	struct damon_addr_range *a = arg;
>>> +
>>> +	if (a->end - a->start < resource_size(res)) {
>>> +		a->start = res->start;
>>> +		a->end = res->end;
>>> +	}
>>> +	return 0;
>>> +}
>>> +
>>> +/*
>>> + * Find biggest 'System RAM' resource and store its start and end address in
>>> + * @start and @end, respectively.  If no System RAM is found, returns false.
>>> + */
>>> +bool get_monitoring_region(unsigned long *start, unsigned long *end)
>>> +{
>>> +	struct damon_addr_range arg = {};
>>> +
>>> +	walk_system_ram_res(0, ULONG_MAX, &arg, walk_system_ram);
>>> +	if (arg.end <= arg.start)
>>> +		return false;
>>> +
>>> +	*start = arg.start;
>>> +	*end = arg.end;
>>> +	return true;
>>> +}
>> 'ops-common.c' is for code that common in monitoring operations
>> implementations.  I'd prefer to have yet another source file for the DAMON
>> modules including reclaim and lru_sort, say, 'modules-common.c'.
> Or, putting it in damon/core.c might make more sense.
Ok,  i will fix them in my next patch, thanks.
>
>
> Thanks,
> SJ
>
> [...]
