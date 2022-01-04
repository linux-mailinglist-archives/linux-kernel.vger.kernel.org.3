Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 689D2483A9B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 03:35:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232299AbiADCfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 21:35:12 -0500
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:36124 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232285AbiADCfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 21:35:11 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0V0nqwQd_1641263708;
Received: from 30.21.164.36(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0V0nqwQd_1641263708)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 04 Jan 2022 10:35:09 +0800
Message-ID: <bc873789-e025-8366-88a8-f3dadcdd9db9@linux.alibaba.com>
Date:   Tue, 4 Jan 2022 10:36:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v3] mm/damon: Add access checking for hugetlb pages
To:     SeongJae Park <sj@kernel.org>
Cc:     akpm@linux-foundation.org, mike.kravetz@oracle.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20211230181919.1588-1-sj@kernel.org>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20211230181919.1588-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi SeongJae,

On 12/31/2021 2:19 AM, SeongJae Park wrote:
> On Thu, 30 Dec 2021 16:20:28 +0800 Baolin Wang <baolin.wang@linux.alibaba.com> wrote:
> 
>> The process's VMAs can be mapped by hugetlb page, but now the DAMON
>> did not implement the access checking for hugetlb pte, so we can not
>> get the actual access count like below if a process VMAs were mapped
>> by hugetlb.
>>
>> damon_aggregated: target_id=18446614368406014464 nr_regions=12 4194304-5476352: 0 545
>> damon_aggregated: target_id=18446614368406014464 nr_regions=12 140662370467840-140662372970496: 0 545
>> damon_aggregated: target_id=18446614368406014464 nr_regions=12 140662372970496-140662375460864: 0 545
>> damon_aggregated: target_id=18446614368406014464 nr_regions=12 140662375460864-140662377951232: 0 545
>> damon_aggregated: target_id=18446614368406014464 nr_regions=12 140662377951232-140662380449792: 0 545
>> damon_aggregated: target_id=18446614368406014464 nr_regions=12 140662380449792-140662382944256: 0 545
>> ......
>>
>> Thus this patch adds hugetlb access checking support, with this patch
>> we can see below VMA mapped by hugetlb access count.
>>
>> damon_aggregated: target_id=18446613056935405824 nr_regions=12 140296486649856-140296489914368: 1 3
>> damon_aggregated: target_id=18446613056935405824 nr_regions=12 140296489914368-140296492978176: 1 3
>> damon_aggregated: target_id=18446613056935405824 nr_regions=12 140296492978176-140296495439872: 1 3
>> damon_aggregated: target_id=18446613056935405824 nr_regions=12 140296495439872-140296498311168: 1 3
>> damon_aggregated: target_id=18446613056935405824 nr_regions=12 140296498311168-140296501198848: 1 3
>> damon_aggregated: target_id=18446613056935405824 nr_regions=12 140296501198848-140296504320000: 1 3
>> damon_aggregated: target_id=18446613056935405824 nr_regions=12 140296504320000-140296507568128: 1 2
>> ......
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> 
> In addition to unwrapping program outputs in commit message, I personally
> prefer indenting those with 4 spaces[1], but I wouldn't bother you for such a
> trivial thing.  Thank you for this patch!

I noticed your comments before, but I still think the message line is 
too long to unreadable. Anyway thanks for your reviewing.

> 
> Reviewed-by: SeongJae Park <sj@kernel.org>
> 
> [1] https://lore.kernel.org/linux-mm/17421c73-2124-63c2-1925-dcea5c976711@linux.alibaba.co
