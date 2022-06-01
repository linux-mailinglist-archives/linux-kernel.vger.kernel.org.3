Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86498539DA2
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 08:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350087AbiFAG7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 02:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350055AbiFAG6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 02:58:53 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F341C2AC4A
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 23:58:51 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 81F9023A;
        Tue, 31 May 2022 23:58:51 -0700 (PDT)
Received: from [10.162.40.45] (unknown [10.162.40.45])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4B29C3F73D;
        Tue, 31 May 2022 23:58:47 -0700 (PDT)
Message-ID: <294314f1-d306-0eb9-059c-f10cb79b9e76@arm.com>
Date:   Wed, 1 Jun 2022 12:28:44 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFC PATCH 1/3] hugetlb: skip to end of PT page mapping when pte
 not present
Content-Language: en-US
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Michal Hocko <mhocko@suse.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        James Houghton <jthoughton@google.com>,
        Mina Almasry <almasrymina@google.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20220527225849.284839-1-mike.kravetz@oracle.com>
 <20220527225849.284839-2-mike.kravetz@oracle.com>
 <YpUhe6BSfflOVz7b@xz-m1.local> <YpV3qrSHGsIuvifX@FVFYT0MHHV2J.googleapis.com>
 <95bd9375-36d2-7e34-83a8-d9eedfe70956@oracle.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <95bd9375-36d2-7e34-83a8-d9eedfe70956@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/31/22 22:35, Mike Kravetz wrote:
> On 5/30/22 19:04, Muchun Song wrote:
>> On Mon, May 30, 2022 at 03:56:43PM -0400, Peter Xu wrote:
>>> Hi, Mike,
>>>
>>> On Fri, May 27, 2022 at 03:58:47PM -0700, Mike Kravetz wrote:
>>>> +unsigned long hugetlb_mask_last_hp(struct hstate *h)
>>>> +{
>>>> +	unsigned long hp_size = huge_page_size(h);
>>>> +
>>>> +	if (hp_size == P4D_SIZE)
>>>> +		return PGDIR_SIZE - P4D_SIZE;
>>>> +	else if (hp_size == PUD_SIZE)
>>>> +		return P4D_SIZE - PUD_SIZE;
>>>> +	else if (hp_size == PMD_SIZE)
>>>> +		return PUD_SIZE - PMD_SIZE;
>>>> +
>>>> +	return ~(0);
>>>> +}
>>>
>>> How about:
>>>
>>> unsigned long hugetlb_mask_last_hp(struct hstate *h)
>>> {
>>> 	unsigned long hp_size = huge_page_size(h);
>>>
>>> 	return hp_size * (PTRS_PER_PTE - 1);
>>> }
>>>
>>
>> +1
>>  
> 
> 
> I like this as well, but I wonder if we should put something like the
> following in just to be safe.
> 
> BUILD_BUG_ON(PTRS_PER_PTE != PTRS_PER_PMD);
> BUILD_BUG_ON(PTRS_PER_PTE != PTRS_PER_PUD);
> BUILD_BUG_ON(PTRS_PER_PTE != PTRS_PER_P4D);
Exactly, assuming that PTRS_PER_PTE entries are present per page table page for
all supported HugeTLB levels might be bit risky, particularly for the top level.
Hence rather than all these additional BUILD_BUG_ON() checks for using standard
page table page entries i.e PTRS_PER_PTE, it might be better to just stick with
the original check either via 'if else' as proposed or better with a switch case.
