Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDFDE59B22E
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 07:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbiHUFyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 01:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbiHUFyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 01:54:31 -0400
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D85618E1F
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 22:54:27 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R981e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VMmZtHX_1661061264;
Received: from 30.15.206.157(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VMmZtHX_1661061264)
          by smtp.aliyun-inc.com;
          Sun, 21 Aug 2022 13:54:25 +0800
Message-ID: <8b4fc8cc-23c0-8629-1225-eefcbab1f039@linux.alibaba.com>
Date:   Sun, 21 Aug 2022 13:54:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 0/3] Fix some issues when looking up hugetlb page
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1660902741.git.baolin.wang@linux.alibaba.com>
 <YwAl948ny7AZEfT1@monkey>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <YwAl948ny7AZEfT1@monkey>
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



On 8/20/2022 8:08 AM, Mike Kravetz wrote:
> On 08/19/22 18:12, Baolin Wang wrote:
>> Hi,
>>
>> On ARM64 architecture, it can support CONT-PTE/PMD size hugetlb. When
>> looking up hugetlb page by follow_page(), we will hold the incorrect
>> pte/pmd lock for the CONT-PTE/PMD size hugetlb page, which will make
>> the pte/pmd entry unstable even under the lock and cause some potential
>> race issues. So considering the CONT-PTE/PMD size hugetlb, this patch set
>> changes to use the correct function to get the correct pte/pmd entry lock
>> to make the pte/pmd entry stable.
> 
> Thank you for looking at this.
> 
> I often get confused by arm64 CONT-PTE/PMD layout, so my understanding may be
> wrong.  Can we use the PMD page lock for locking both CONT-PTE and CONT-PMD
> entries?  Again, I may be confused by the CONT-* page table layout, but it
> seems these would all be referenced via that same PMD page of the page table.
> Or, perhaps CONT-PMD can span multiple PMD pages?

Good point. CONT-PMD can not span multiple PMD pages, so I think 
CONT-PMD can use PMD pagetable page lock, but CONT-PTE also can not span 
multiple PTE pagetable page lock, so I think CONT-PTE can use the PTE 
pagetable page lock to get a fine grained lock.

I will add CONT-PTE and CONT-PMD case in huge_pte_lockptr() in next 
version. Thanks for your comment.

> If we can use PMD page for locking, this would be much finer grain that
> lock in the mm.
