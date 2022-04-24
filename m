Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB9350D0FA
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 12:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238985AbiDXKGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 06:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236724AbiDXKF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 06:05:59 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2444C16FAF2
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 03:02:57 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R571e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VB0eh7g_1650794574;
Received: from 30.39.210.25(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VB0eh7g_1650794574)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 24 Apr 2022 18:02:54 +0800
Message-ID: <4526be44-696b-9719-5a00-6002f61aec01@linux.alibaba.com>
Date:   Sun, 24 Apr 2022 18:03:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] mm: hugetlb: Add missing cache flushing in
 hugetlb_unshare_all_pmds()
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     akpm@linux-foundation.org, mike.kravetz@oracle.com,
        peterx@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <419b0e777c9e6d1454dcd906e0f5b752a736d335.1650781755.git.baolin.wang@linux.alibaba.com>
 <YmT//huUbFX+KHcy@FVFYT0MHHV2J.usts.net>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <YmT//huUbFX+KHcy@FVFYT0MHHV2J.usts.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-11.8 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/24/2022 3:45 PM, Muchun Song wrote:
> On Sun, Apr 24, 2022 at 02:33:19PM +0800, Baolin Wang wrote:
>> Missed calling flush_cache_range() before removing the sharing PMD entrires,
>> otherwise data consistence issue may be occurred on some architectures whose
>> caches are strict and require a virtual–>physical translation to exist for
>> a virtual address. Thus add it.
>>
>> Fixes: 6dfeaff93be1 ("hugetlb/userfaultfd: unshare all pmds for hugetlbfs when register wp")
>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> 
> CONFIG_ARCH_WANT_HUGE_PMD_SHARE is only definded on riscv, arm64 and
> x86.  All of them do not have a VIVT cache.  In others words,
> flush_cache_range() is null on those architectures. So I suspect
> in practice this does not cause any issue.  It is better to
> clarify this in commit log.

Yes, just from code inspection and to keep same behaviors when unmapping 
sharing PMD entrires in case more architectures can support 
CONFIG_ARCH_WANT_HUGE_PMD_SHARE in future. Will update the commit 
message in next version.

> 
> Anyway:
> 
> Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.
