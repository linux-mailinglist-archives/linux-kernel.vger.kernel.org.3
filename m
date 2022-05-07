Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF4C51E334
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 03:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445256AbiEGBrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 21:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389810AbiEGBrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 21:47:01 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7841059306;
        Fri,  6 May 2022 18:43:16 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Kw99m3bnczGpT7;
        Sat,  7 May 2022 09:40:28 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 7 May 2022 09:42:45 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 7 May 2022 09:42:44 +0800
Subject: Re: [PATCH v24 5/6] of: Support more than one crash kernel regions
 for kexec -s
To:     Baoquan He <bhe@redhat.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
        <linux-kernel@vger.kernel.org>, Dave Young <dyoung@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        <kexec@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        <devicetree@vger.kernel.org>, "Jonathan Corbet" <corbet@lwn.net>,
        <linux-doc@vger.kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
        Feng Zhou <zhoufeng.zf@bytedance.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Chen Zhou <dingguo.cz@antgroup.com>,
        "John Donnelly" <John.p.donnelly@oracle.com>,
        Dave Kleikamp <dave.kleikamp@oracle.com>
References: <20220506114402.365-1-thunder.leizhen@huawei.com>
 <20220506114402.365-6-thunder.leizhen@huawei.com>
 <20220506231737.GD122876@MiWiFi-R3L-srv>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <55e201f1-f136-607c-78f8-eb4ec481909e@huawei.com>
Date:   Sat, 7 May 2022 09:42:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20220506231737.GD122876@MiWiFi-R3L-srv>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/5/7 7:17, Baoquan He wrote:
> On 05/06/22 at 07:44pm, Zhen Lei wrote:
>> When "crashkernel=X,high" is used, there may be two crash regions:
>> high=crashk_res and low=crashk_low_res. But now the syscall
>> kexec_file_load() only add crashk_res into "linux,usable-memory-range",
>> this may cause the second kernel to have no available dma memory.
>>
>> Fix it like kexec tool do for option -c, add both 'high' and 'low' regions
>               ~~~~~~~~~~~~ 
>               kexec-tools does

OK, I will update it. Thanks.

> 
> Other than this, LGTM,
> 
> Acked-by: Baoquan He <bhe@redhat.com>
> 
>> into the dtb.
>>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> Acked-by: Rob Herring <robh@kernel.org>
>> ---
>>  drivers/of/kexec.c | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>>
>> diff --git a/drivers/of/kexec.c b/drivers/of/kexec.c
>> index b9bd1cff179388c..8d374cc552be5f2 100644
>> --- a/drivers/of/kexec.c
>> +++ b/drivers/of/kexec.c
>> @@ -386,6 +386,15 @@ void *of_kexec_alloc_and_setup_fdt(const struct kimage *image,
>>  				crashk_res.end - crashk_res.start + 1);
>>  		if (ret)
>>  			goto out;
>> +
>> +		if (crashk_low_res.end) {
>> +			ret = fdt_appendprop_addrrange(fdt, 0, chosen_node,
>> +					"linux,usable-memory-range",
>> +					crashk_low_res.start,
>> +					crashk_low_res.end - crashk_low_res.start + 1);
>> +			if (ret)
>> +				goto out;
>> +		}
>>  	}
>>  
>>  	/* add bootargs */
>> -- 
>> 2.25.1
>>
> 
> .
> 

-- 
Regards,
  Zhen Lei
