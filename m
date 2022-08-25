Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04BD55A0AE4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 10:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238871AbiHYH6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 03:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234610AbiHYH6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 03:58:42 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2A129DB47
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 00:58:40 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R621e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VNCWwDS_1661414314;
Received: from 30.97.48.44(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VNCWwDS_1661414314)
          by smtp.aliyun-inc.com;
          Thu, 25 Aug 2022 15:58:35 +0800
Message-ID: <3c381602-26ea-883c-859a-4007cb7cb289@linux.alibaba.com>
Date:   Thu, 25 Aug 2022 15:58:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 1/5] mm/hugetlb: fix races when looking up a CONT-PTE
 size hugetlb page
To:     David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1661240170.git.baolin.wang@linux.alibaba.com>
 <0e5d92da043d147a867f634b17acbcc97a7f0e64.1661240170.git.baolin.wang@linux.alibaba.com>
 <4c24b891-04ce-2608-79d2-a75dc236533f@redhat.com>
 <376d2e0a-d28a-984b-903c-1f6451b04a15@linux.alibaba.com>
 <7d4e7f47-30a5-3cc6-dc9f-aa89120847d8@redhat.com> <YwVo7xSO+VebkIfQ@monkey>
 <64669c0a-4a6e-f034-a15b-c4a8deea9e5d@linux.alibaba.com>
 <7ee73879-e402-9175-eae8-41471d80d59e@redhat.com>
 <f7544713-d856-0875-41dd-52a5c27ba015@linux.alibaba.com>
 <Ywa1jp/6naTmUh42@monkey>
 <f3ee3581-5d0b-f564-7016-783a0d91fea2@linux.alibaba.com>
 <50703dda-bbee-7484-97ff-87d6ea75bf80@redhat.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <50703dda-bbee-7484-97ff-87d6ea75bf80@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/25/2022 3:10 PM, David Hildenbrand wrote:
> 
>>> +		/*
>>> +		 * try_grab_page() should always succeed here, because we hold
>>> +		 * the ptl lock and have verified pte_present().
>>> +		 */
>>> +		if (WARN_ON_ONCE(!try_grab_page(page, flags))) {
>>> +			page = NULL;
>>> +			goto out;
>>> +		}
>>> +	} else {
>>
>> Should add FOLL_MIGRATION validation before waiting a migration entry.
> 
> We really only need FOLL_MIGRATION for KSM. As hugetlb pages cannot be
> KSM pages, we don't need this.
> 
> Actually, I do have patches in the works that rip out FOLL_MIGRATION
> completely by adjusting KSM code.
> 
> So let's try to not add dead code (although it would make sense for
> feature completeness as is -- but then, FOLL_MIGRATION really needs to go).

Make sense. Thanks for your explanation.
