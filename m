Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 109EE5502CD
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 06:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233247AbiFRERm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 00:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiFRERi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 00:17:38 -0400
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15E89D74
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 21:17:36 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VGi26k0_1655525852;
Received: from 30.13.184.185(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VGi26k0_1655525852)
          by smtp.aliyun-inc.com;
          Sat, 18 Jun 2022 12:17:33 +0800
Message-ID: <73715d55-288a-beb0-bb98-210a9233d25a@linux.alibaba.com>
Date:   Sat, 18 Jun 2022 12:17:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] arm64/hugetlb: Simplify the huge_ptep_set_access_flags()
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     will@kernel.org, mike.kravetz@oracle.com, songmuchun@bytedance.com,
        anshuman.khandual@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <d81f1c3215000d0f238900dbfa0a0976d8d00cd3.1653470369.git.baolin.wang@linux.alibaba.com>
 <Yqy97gXI4Nqb7dYo@arm.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <Yqy97gXI4Nqb7dYo@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-12.1 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/18/2022 1:46 AM, Catalin Marinas wrote:
> On Wed, May 25, 2022 at 06:31:09PM +0800, Baolin Wang wrote:
>> After commit bc5dfb4fd7bd ("arm64/hugetlb: Implement arm64 specific
>> huge_ptep_get()"), the arm64 specific huge_ptep_get() will always
>> consider the subpages' dirty and young state for CONT-PTE/PMD hugetlb,
>> so there is no need to check them again when setting the access flags
>> for CONT-PTE/PMD hugetlb in huge_ptep_set_access_flags().
>>
>> Meanwhile this also fixes an issue when users want to make the CONT-PTE/PMD
>> hugetlb's pte entry old, which will be failed to make the pte entry old
>> since the original code will always consider the subpages' young state
>> if the subpages' young state is set. For example, we will make the
>> CONT-PTE/PMD hugetlb pte entry old in DAMON to monitoring the accesses,
>> but we'll failed to monitoring the actual accesses of the CONT-PTE/PMD
>> hugetlb page, due to we can not make its pte old.
>>
>> Thus remove the code considering the subpages' dirty and young state in
>> huge_ptep_set_access_flags() to fix this issue and simplify the function.
> 
> The ptep_set_access_flags() semantics (non-huge) never clear the access
> flag, so mkold is not allowed. I think damon_hugetlb_mkold() is wrong in
> assuming that huge_ptep_set_access_flags() allows a young->old huge pte
> transition.

After reading the code carefully, yes, you are right. Seems I need 
change to use set_huge_pte_at() to make the huge pte old. Thanks.

By the way, after changing to use set_huge_pte_at() in the 
damon_hugetlb_mkold(), it seems to me that we still do not need to get 
the subpages' dirty and young state again in 
huge_ptep_set_access_flags(). How do you think?
