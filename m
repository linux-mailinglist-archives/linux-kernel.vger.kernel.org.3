Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBD245992FD
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 04:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242263AbiHSCMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 22:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236204AbiHSCMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 22:12:39 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D24DD777
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 19:12:37 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VMdxGnC_1660875154;
Received: from 30.240.99.21(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0VMdxGnC_1660875154)
          by smtp.aliyun-inc.com;
          Fri, 19 Aug 2022 10:12:35 +0800
Message-ID: <5c1c4b01-5ada-5c25-7181-a6f6c2c1f6ed@linux.alibaba.com>
Date:   Fri, 19 Aug 2022 10:12:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.1.0
Subject: Re: [PATCH V2 1/2] mm/damon/lru_sort: Move target memory region check
 to head of func
To:     SeongJae Park <sj@kernel.org>
Cc:     akpm@linux-foundation.org, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220818171145.51607-1-sj@kernel.org>
From:   haoxin <xhao@linux.alibaba.com>
In-Reply-To: <20220818171145.51607-1-sj@kernel.org>
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


在 2022/8/19 上午1:11, SeongJae Park 写道:
> Hi Xin,
>
>
> On Thu, 18 Aug 2022 18:57:31 +0800 Xin Hao <xhao@linux.alibaba.com> wrote:
>
>> In damon_lru_sort_apply_parameters(), if "monitor_region_start"
>> and "monitor_region_end" is not a valid physical address range,
>> There no need to run the remainder codes in it.
> The function, 'damon_lru_sort_apply_parameters()', checks validity of
> parameters and construct the DAMON context one by one.  For example,
> 'damon_set_attrs()' returns an error if the parameters are invalid.  So the
> intended flow is,
>
> 1. check DAMON attributes parameters,
> 2. apply DAMON attributes parameters,
> 3. check scheme parameters,
> 4. apply scheme parameters,
> 5. check target region parameters, and
> 6. apply target region parameters.
>
> Therefore what this patch does is making the target regions validity check to
> be done earlier than validity checks of other parameters.  There is no special
> reason to check the region earlier than others.  Also, this change makes the
> flow of the function a little bit weird in my humble opinion, as the flow will
> be
>
> 1. check target region parameters,
> 2. check DAMON attributes parameters,
> 3. apply DAMON attributes parameters,
> 4. check scheme parameters,
> 5. apply scheme parameters, and
> 6. apply target region parameters.

Ok, understand what you mean,   my fix looks ugly,  buy any apply above 
are not not necessary if one of them checks failed, why not check all 
fisrt and then apply them, like this:

1. check target region parameters,

2. check DAMON attributes parameters,

3. check scheme parameters,

>
> So I'd argue this patch seems not really needed, sorry.
>
>
> Thanks,
> SJ
>
> [...]
