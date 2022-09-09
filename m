Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B82755B2BCF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 03:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbiIIBqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 21:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbiIIBql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 21:46:41 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E837E3D68
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 18:46:32 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MNzJs0bNPzmVJm;
        Fri,  9 Sep 2022 09:42:53 +0800 (CST)
Received: from dggpemm100009.china.huawei.com (7.185.36.113) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 9 Sep 2022 09:46:30 +0800
Received: from [10.174.179.24] (10.174.179.24) by
 dggpemm100009.china.huawei.com (7.185.36.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 9 Sep 2022 09:46:29 +0800
Subject: Re: [PATCH v2] mm/huge_memory: prevent THP_ZERO_PAGE_ALLOC increased
 twice
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
References: <20220908035533.2186159-1-liushixin2@huawei.com>
 <20220908123102.rpihrmisv55j3b2o@box.shutemov.name>
 <84a82033-ceb5-d8a2-3bae-a31574a5ff28@huawei.com>
 <20220908132538.kjqas6q2i24mrsug@box.shutemov.name>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
From:   Liu Shixin <liushixin2@huawei.com>
Message-ID: <f03f70f7-142d-6b54-15ea-a6c5535e215d@huawei.com>
Date:   Fri, 9 Sep 2022 09:46:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20220908132538.kjqas6q2i24mrsug@box.shutemov.name>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.24]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm100009.china.huawei.com (7.185.36.113)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SCC_BODY_URI_ONLY,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/9/8 21:25, Kirill A. Shutemov wrote:
> On Thu, Sep 08, 2022 at 09:07:04PM +0800, Liu Shixin wrote:
>>
>> On 2022/9/8 20:31, Kirill A. Shutemov wrote:
>>> On Thu, Sep 08, 2022 at 11:55:33AM +0800, Liu Shixin wrote:
>>>> If two or more threads call get_huge_zero_page concurrently,
>>>> THP_ZERO_PAGE_ALLOC may increased two or more times. But actually,
>>>> this should only count as once since the extra zero pages has been
>>>> freed. Redefine its meaning to indicate the times a huge zero page
>>>> used for thp is successfully allocated.
>>> I don't particularly care, but it is not obvoius why the new behaviour is
>>> better.
>> The user who read the value may be more concerned about the huge zero
>> pages that are really allocated using for thp and can indicated the
>> times of calling huge_zero_page_shrinker.
>> I misunderstood when I first saw it.
> Please, explain the motivation in the commit message.
Thanks, I add the motivation.
https://lore.kernel.org/all/20220909021653.3371879-1-liushixin2@huawei.com/

