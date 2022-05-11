Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61CC45228E7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 03:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234986AbiEKBXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 21:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiEKBXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 21:23:39 -0400
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CEF9994C4
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 18:23:35 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R421e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0VCt7iBt_1652232209;
Received: from 30.30.99.144(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VCt7iBt_1652232209)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 11 May 2022 09:23:31 +0800
Message-ID: <278d1d30-a7ad-11df-5242-5472a841a3b3@linux.alibaba.com>
Date:   Wed, 11 May 2022 09:24:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 1/2] arm64/hugetlb: Use ptep_get() to get the pte value of
 a huge page
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, mike.kravetz@oracle.com,
        akpm@linux-foundation.org, willy@infradead.org,
        anshuman.khandual@arm.com, christophe.leroy@csgroup.eu,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <cover.1652180088.git.baolin.wang@linux.alibaba.com>
 <6aabddaf4cae5ae2205c3a7df9b9e15dbd61b641.1652180088.git.baolin.wang@linux.alibaba.com>
 <YnqK+Hah0wzMvT1p@FVFYT0MHHV2J.usts.net>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <YnqK+Hah0wzMvT1p@FVFYT0MHHV2J.usts.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.8 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/10/2022 11:55 PM, Muchun Song wrote:
> On Tue, May 10, 2022 at 07:12:52PM +0800, Baolin Wang wrote:
>> The original huge_ptep_get() on ARM64 is just a wrapper of ptep_get(),
>> which will not take into account any contig-PTEs dirty and access bits.
>> Meanwhile we will implement a new ARM64-specific huge_ptep_get()
>> interface in following patch, which will take into account any contig-PTEs
>> dirty and access bits and only be allowed to pass the head pte of
>> a contig-PTE/PMD size page.
> 
> IIUC, the huge_ptep_get() you have implemented in patch 2 could
> handle non-head pte. It'll return the original pte without potential
> AD bit. I admit it is more efficeent to use ptep_get() directly,
> but the judgement here should be updated.

Ah, right. I missed the 'ncontig' will be 0 if a non-head pte passed. 
Will update the commit message in next version. Thanks for reviewing.

> 
> With this update.
> 
> Reviewed-by: Muchun Song <songmuchun@bytedance.com>
