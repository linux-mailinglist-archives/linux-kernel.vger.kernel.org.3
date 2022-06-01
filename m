Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7CC539AF7
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 03:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349040AbiFAByh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 21:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231363AbiFAByd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 21:54:33 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 274528DDD5
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 18:54:32 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LCXH45GjnzjXDX;
        Wed,  1 Jun 2022 09:53:20 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 1 Jun 2022 09:54:29 +0800
Subject: Re: [PATCH] mm/migrate: skip unsupported ZONE_DEVICE page in
 migrate_vma_collect_pmd()
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Alex Sierra <alex.sierra@amd.com>,
        Christoph Hellwig <hch@lst.de>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Alistair Poppple <apopple@nvidia.com>
References: <20220531122530.17996-1-linmiaohe@huawei.com>
 <20220531110517.51b839799201e9e75684375a@linux-foundation.org>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <2fa970ac-78c5-93a1-9de9-4a450d727918@huawei.com>
Date:   Wed, 1 Jun 2022 09:54:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220531110517.51b839799201e9e75684375a@linux-foundation.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/6/1 2:05, Andrew Morton wrote:
> On Tue, 31 May 2022 20:25:30 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:
> 
>> For now we only support migrating to un-addressable device memory. Other
>> types of ZONE_DEVICE pages are not supported yet. So skip those pages in
>> MIGRATE_VMA_SELECT_SYSTEM case to save useless effort.
>>
> 
> https://lkml.kernel.org/r/20220531155629.20057-4-alex.sierra@amd.com
> just made similar-but-different changes here.  Please review those.
> 
> Normally I'm merge your fixlet ahead of the larger changes and redo
> Alex's patchset.  Because Alex's larger patchset might never get
> mainlined, so your fixlet would then get lost.
> 
> But in this case, your fixlet doesn't seem important enough to be
> churning things around in that way?

Yes. Above similar-but-different changes look good to me. I'm fine to drop
this patch.

Thanks!

> 
>> --- a/mm/migrate_device.c
>> +++ b/mm/migrate_device.c
>> @@ -157,6 +157,11 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
>>  				goto next;
>>  			}
>>  			page = vm_normal_page(migrate->vma, addr, pte);
>> +			/*
>> +			 * Other types of ZONE_DEVICE page are not supported.
>> +			 */
>> +			if (page && is_zone_device_page(page))
>> +				goto next;
>>  			mpfn = migrate_pfn(pfn) | MIGRATE_PFN_MIGRATE;
>>  			mpfn |= pte_write(pte) ? MIGRATE_PFN_WRITE : 0;
>>  		}
> 
> .
> 

