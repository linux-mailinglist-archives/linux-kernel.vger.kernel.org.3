Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3FA526EF2
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 09:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbiENDAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 23:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231477AbiENC6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 22:58:49 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E452E434B
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 18:41:33 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0VD5SDVr_1652492488;
Received: from 30.236.14.33(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VD5SDVr_1652492488)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 14 May 2022 09:41:29 +0800
Message-ID: <30e805ba-cf4d-c13c-8d34-e1b2d9e77dae@linux.alibaba.com>
Date:   Sat, 14 May 2022 09:42:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2 1/2] arm64/hugetlb: Use ptep_get() to get the pte value
 of a huge page
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        catalin.marinas@arm.com, will@kernel.org
Cc:     mike.kravetz@oracle.com, akpm@linux-foundation.org,
        songmuchun@bytedance.com, willy@infradead.org,
        christophe.leroy@csgroup.eu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <cover.1652411252.git.baolin.wang@linux.alibaba.com>
 <d3d60680508486ecb48ae639cfd3911009275710.1652411252.git.baolin.wang@linux.alibaba.com>
 <88e02de3-c87e-2728-d980-da0e70a58102@arm.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <88e02de3-c87e-2728-d980-da0e70a58102@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-12.8 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/13/2022 6:50 PM, Anshuman Khandual wrote:
> 
> 
> On 5/13/22 09:07, Baolin Wang wrote:
>> The original huge_ptep_get() on ARM64 is just a wrapper of ptep_get(),
> 
> Right, as arm64 does not enable __HAVE_ARCH_HUGE_PTEP_GET.
> 
>> which will not take into account any contig-PTEs dirty and access bits.
> 
> As expected being operating on a single table entry.
> 
>> Meanwhile we will implement a new ARM64-specific huge_ptep_get()
>> interface in following patch, which will take into account any contig-PTEs
>> dirty and access bits. To keep the same efficient logics to get the pte
> 
> s/logics/logic

Will fix.

> 
>> value, change to use ptep_get() as a preparation.
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> Reviewed-by: Muchun Song <songmuchun@bytedance.com>
> 
> LGTM
> 
> Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

Thanks.
