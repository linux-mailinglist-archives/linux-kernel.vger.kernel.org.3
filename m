Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFF3459B211
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 07:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbiHUFWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 01:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiHUFWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 01:22:36 -0400
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25BF727CFF
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 22:22:34 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R371e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VMmQyAN_1661059349;
Received: from 30.15.206.157(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VMmQyAN_1661059349)
          by smtp.aliyun-inc.com;
          Sun, 21 Aug 2022 13:22:30 +0800
Message-ID: <162b6039-bfb9-7dac-e72e-be946ea0621f@linux.alibaba.com>
Date:   Sun, 21 Aug 2022 13:22:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 1/2] mm/damon: validate if the pmd entry is present
 before accessing
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     sj@kernel.org, muchun.song@linux.dev, mike.kravetz@oracle.com,
        damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <58b1d1f5fbda7db49ca886d9ef6783e3dcbbbc98.1660805030.git.baolin.wang@linux.alibaba.com>
 <20220820141702.e731f2aade5da8cbe0c78cba@linux-foundation.org>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20220820141702.e731f2aade5da8cbe0c78cba@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/21/2022 5:17 AM, Andrew Morton wrote:
> On Thu, 18 Aug 2022 15:37:43 +0800 Baolin Wang <baolin.wang@linux.alibaba.com> wrote:
> 
>> The pmd_huge() is used to validate if the pmd entry is mapped by a huge
>> page, also including the case of non-present (migration or hwpoisoned)
>> pmd entry on arm64 or x86 architectures. That means the pmd_pfn() can
>> not get the correct pfn number for the non-present pmd entry, which
>> will cause damon_get_page() to get an incorrect page struct (also
>> may be NULL by pfn_to_online_page()) to make the access statistics
>> incorrect.
>>
>> Moreover it does not make sense that we still waste time to get the
>> page of the non-present entry, just treat it as not-accessed and skip it,
>> that keeps consistent with non-present pte level entry.
>>
>> Thus adding a pmd entry present validation to fix above issues.
>>
> 
> Do we have a Fixes: for this?

OK, should be:
Fixes: 3f49584b262c ("mm/damon: implement primitives for the virtual 
memory address spaces")

> What are the user-visible runtime effects of the bug?  "make the access
> statistics incorrect" is rather vague.

"access statistics incorrect" means that the DAMON may make incorrect 
decision according to the incorrect statistics, for example, DAMON may 
can not reclaim cold page in time due to this cold page was regarded as 
accessed mistakenly if DAMOS_PAGEOUT operation is specified.

> Do we feel that a cc:stable is warranted?

Though this is not a regular case, I think this patch is suitable to be 
backported to cover this unusual case. So please help to add a stable 
tag when you apply this patch, or please let me know if you want a new 
version with adding Fixes and stable tags. Thanks.
