Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C30C052C9CD
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 04:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232888AbiESCbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 22:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiESCbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 22:31:19 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F1C62A3B;
        Wed, 18 May 2022 19:31:17 -0700 (PDT)
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4L3YjF4335z1JCFc;
        Thu, 19 May 2022 10:29:53 +0800 (CST)
Received: from dggpeml500010.china.huawei.com (7.185.36.155) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 19 May 2022 10:30:47 +0800
Received: from [10.67.111.232] (10.67.111.232) by
 dggpeml500010.china.huawei.com (7.185.36.155) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 19 May 2022 10:30:46 +0800
Message-ID: <6eb03912-4292-8a5f-2103-eea401eccf08@huawei.com>
Date:   Thu, 19 May 2022 10:30:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH -next] x86/events:Use struct_size() helper in kzalloc()
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
CC:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>, <tglx@linutronix.de>,
        <bp@alien8.de>, <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        <hpa@zytor.com>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <johnny.chenyi@huawei.com>,
        <chenjiahao16@huawei.com>, <chenlifu@huawei.com>,
        <lizhengyu3@huawei.com>, <liaochang1@huawei.com>,
        <wangzhu9@huawei.com>, <xuyihang@huawei.com>,
        <chris.zjh@huawei.com>, <zouyipeng@huawei.com>
References: <20220518131626.109123-1-linyujun809@huawei.com>
 <20220518134920.GA8361@embeddedor>
From:   "linyujun (C)" <linyujun809@huawei.com>
In-Reply-To: <20220518134920.GA8361@embeddedor>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.232]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500010.china.huawei.com (7.185.36.155)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for your suggestion. I will modify the patch according
to your suggestion and make the v2 version.

Thanks
--
LinYujun

在 2022/5/18 21:49, Gustavo A. R. Silva 写道:
> On Wed, May 18, 2022 at 09:16:26PM +0800, Lin Yujun wrote:
>> Replace sizeof() with struct_size() to avoid potential integer
>> or heap overflow.
> This is not exactly what the patch does.
>
> Your patch is replacing the open-coded calculation of the total amount
> of memory to be allocated for rapl_pmus with struct_size().
>
>> Also, address the following sparse warnings:
>> arch/x86/events/rapl.c:685:16: warning: using sizeof on a
>> flexible structure
> This does not address this warning because struct_size()
> still make use of sizeof on the struct-with-flex-array,
> internally.
>
> So, the mention to the sparse warning should be removed from
> this changelog text.
>
>> Signed-off-by: Lin Yujun <linyujun809@huawei.com>
>> ---
>>   arch/x86/events/rapl.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
>> index 77e3a47af5ad..c7e79f0ac04f 100644
>> --- a/arch/x86/events/rapl.c
>> +++ b/arch/x86/events/rapl.c
>> @@ -685,7 +685,7 @@ static int __init init_rapl_pmus(void)
>>   	int maxdie = topology_max_packages() * topology_max_die_per_package();
>>   	size_t size;
>>   
>> -	size = sizeof(*rapl_pmus) + maxdie * sizeof(struct rapl_pmu *);
>> +	size = struct_size(rapl_pmus, pmus, maxdie);
>>   	rapl_pmus = kzalloc(size, GFP_KERNEL);
> It seems that in this case, size could be entirely replaced by
> struct_size().
>
> Thanks
> --
> Gustavo
> .
