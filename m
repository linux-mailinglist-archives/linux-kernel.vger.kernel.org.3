Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 430D650815B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 08:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354620AbiDTGrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 02:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352892AbiDTGrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 02:47:00 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A937F340DA
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 23:44:14 -0700 (PDT)
Received: from kwepemi500007.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4KjrjC5Hypz1J9qf;
        Wed, 20 Apr 2022 14:43:27 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (7.193.23.234) by
 kwepemi500007.china.huawei.com (7.221.188.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 20 Apr 2022 14:44:12 +0800
Received: from [10.174.179.234] (10.174.179.234) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 20 Apr 2022 14:44:10 +0800
Message-ID: <c376877e-53a7-d471-61bc-e7f9dd400d60@huawei.com>
Date:   Wed, 20 Apr 2022 14:44:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH -next v4 1/4] mm: page_table_check: move
 pxx_user_accessible_page into x86
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-riscv@lists.infradead.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Guohanjun <guohanjun@huawei.com>
References: <20220418034444.520928-1-tongtiangen@huawei.com>
 <20220418034444.520928-2-tongtiangen@huawei.com>
 <1671baf7-046e-7c52-183f-fd654125fd67@arm.com>
From:   Tong Tiangen <tongtiangen@huawei.com>
In-Reply-To: <1671baf7-046e-7c52-183f-fd654125fd67@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.234]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600017.china.huawei.com (7.193.23.234)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/4/19 17:29, Anshuman Khandual 写道:
> 
> 
> On 4/18/22 09:14, Tong Tiangen wrote:
>> --- a/mm/page_table_check.c
>> +++ b/mm/page_table_check.c
>> @@ -10,6 +10,14 @@
>>   #undef pr_fmt
>>   #define pr_fmt(fmt)	"page_table_check: " fmt
>>   
>> +#ifndef PMD_PAGE_SIZE
>> +#define PMD_PAGE_SIZE	PMD_SIZE
>> +#endif
>> +
>> +#ifndef PUD_PAGE_SIZE
>> +#define PUD_PAGE_SIZE	PUD_SIZE
>> +#endif
> 
> Why cannot PMD_SIZE/PUD_SIZE be used on every platform instead ? What is the
> need for using PUD_PAGE_SIZE/PMD_PAGE_SIZE ? Are they different on x86 ?
> .

Hi, Pasha：
I checked the definitions of PMD_SIZE/PUD_SIZE and 
PUD_PAGE_SIZE/PMD_PAGE_SIZE in x86 architecture and their use outside 
the architecture(eg: in mm/, all used PMD_SIZE/PUD_SIZE), Would it be 
better to use a unified PMD_SIZE/PUD_SIZE here?

Thanks,
Tong.
