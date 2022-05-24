Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64BF1532C51
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 16:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236158AbiEXOcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 10:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235943AbiEXOcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 10:32:39 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2134606FA
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 07:32:37 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4L6xVn01kZzDqKp;
        Tue, 24 May 2022 22:32:32 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 24 May 2022 22:32:35 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 24 May 2022 22:32:35 +0800
Message-ID: <4c848b48-6ddf-664a-6296-d85ab49a694d@huawei.com>
Date:   Tue, 24 May 2022 22:32:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v3 4/6] mm: ioremap: Add arch_ioremap/iounmap()
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        "Christoph Hellwig" <hch@infradead.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>
References: <20220519082552.117736-1-wangkefeng.wang@huawei.com>
 <20220519082552.117736-5-wangkefeng.wang@huawei.com>
 <CAK8P3a1DbNY6NzcwzjVFvd9yw6L3YBHQos_hmE=nG=6cuv1DAg@mail.gmail.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <CAK8P3a1DbNY6NzcwzjVFvd9yw6L3YBHQos_hmE=nG=6cuv1DAg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/5/24 20:37, Arnd Bergmann wrote:
> On Thu, May 19, 2022 at 10:25 AM Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>> Add special hook for architecture to verify or setup addr, size
>> or prot when ioremap() or iounmap(), which will make the generic
>> ioremap more useful.
>>
>>    arch_ioremap() return a pointer,
>>      - IS_ERR means return an error
>>      - NULL means continue to remap
>>      - a non-NULL, non-IS_ERR pointer is directly returned
>>    arch_iounmap() return a int value,
>>      - 0 means continue to vunmap
>>      - error code means skip vunmap and return directly
>>
>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> I don't really like interfaces that mix error pointers and NULL pointer
> returns.
>
> Would it be possible to have a special error code other than NULL
> for the fallback case?
I don't find a good error code, maybe  ENOTSUPP, any better suggestion?
>
>         arnd
>
> .
