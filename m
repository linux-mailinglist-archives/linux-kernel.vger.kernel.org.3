Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C710259932F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 04:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245308AbiHSCsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 22:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240319AbiHSCsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 22:48:03 -0400
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA3E2CCE01
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 19:48:01 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VMe73D-_1660877278;
Received: from 30.240.99.21(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0VMe73D-_1660877278)
          by smtp.aliyun-inc.com;
          Fri, 19 Aug 2022 10:47:59 +0800
Message-ID: <c0c5c013-9355-c394-afff-ed25b0c456b8@linux.alibaba.com>
Date:   Fri, 19 Aug 2022 10:47:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.1.0
Subject: Re: [PATCH V2 1/2] mm/damon/lru_sort: Move target memory region check
 to head of func
To:     SeongJae Park <sj@kernel.org>
Cc:     akpm@linux-foundation.org, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220819022850.52236-1-sj@kernel.org>
From:   haoxin <xhao@linux.alibaba.com>
In-Reply-To: <20220819022850.52236-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/8/19 上午10:28, SeongJae Park 写道:
> Hi Xin,
>
>> 在 2022/8/19 上午1:11, SeongJae Park 写道:
>>> Hi Xin,
>>>
>>>
>>> On Thu, 18 Aug 2022 18:57:31 +0800 Xin Hao <xhao@linux.alibaba.com> wrote:
>>>
>>>> In damon_lru_sort_apply_parameters(), if "monitor_region_start"
>>>> and "monitor_region_end" is not a valid physical address range,
>>>> There no need to run the remainder codes in it.
>>> The function, 'damon_lru_sort_apply_parameters()', checks validity of
>>> parameters and construct the DAMON context one by one.  For example,
>>> 'damon_set_attrs()' returns an error if the parameters are invalid.  So the
>>> intended flow is,
>>>
>>> 1. check DAMON attributes parameters,
>>> 2. apply DAMON attributes parameters,
>>> 3. check scheme parameters,
>>> 4. apply scheme parameters,
>>> 5. check target region parameters, and
>>> 6. apply target region parameters.
>>>
>>> Therefore what this patch does is making the target regions validity check to
>>> be done earlier than validity checks of other parameters.  There is no special
>>> reason to check the region earlier than others.  Also, this change makes the
>>> flow of the function a little bit weird in my humble opinion, as the flow will
>>> be
>>>
>>> 1. check target region parameters,
>>> 2. check DAMON attributes parameters,
>>> 3. apply DAMON attributes parameters,
>>> 4. check scheme parameters,
>>> 5. apply scheme parameters, and
>>> 6. apply target region parameters.
>> Ok, understand what you mean,   my fix looks ugly,  buy any apply above
>> are not not necessary if one of them checks failed, why not check all
>> fisrt and then apply them, like this:
>>
>> 1. check target region parameters,
>>
>> 2. check DAMON attributes parameters,
>>
>> 3. check scheme parameters,
> The parameter values could be changed by users after the check, so we should
> cache those somewhere anyway.  In other words, we cache those in the DAMON
> context.  Therefore I think the above works were not totally waste of the time.
> Also, because the parameters applying functions like 'damon_set_attrs()' does
> the check and applying of the parameters together, I feel like current flow is
> natural.

Ok,  Thank you for your detailed  explain, just keep it. but there still 
a problem in damon_lru_sort_apply_parameters

if (!monitor_region_start && !monitor_region_end &&
		!get_monitoring_region(&monitor_region_start,
			&monitor_region_end))

if (!monitor_region_start || !monitor_region_end ||
		!get_monitoring_region(&monitor_region_start,
			&monitor_region_end))

the '&&' should fix to '||',  anyone checks fail, it should return ?






>
