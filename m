Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6555098FE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 09:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385695AbiDUHYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 03:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbiDUHYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 03:24:20 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B4CA17079
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 00:21:30 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KkTVR2F88zhXZq;
        Thu, 21 Apr 2022 15:21:19 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 21 Apr 2022 15:21:28 +0800
Received: from [127.0.0.1] (10.67.108.67) by dggpemm500013.china.huawei.com
 (7.185.36.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 21 Apr
 2022 15:21:28 +0800
Message-ID: <9f4a058d-1f6d-69ab-3c31-5817db7d1f90@huawei.com>
Date:   Thu, 21 Apr 2022 15:21:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 5.10] fix csdlock_debug cause arm64 boot panic
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <peterz@infradead.org>, <gor@linux.ibm.com>, <tglx@linutronix.de>,
        <axboe@kernel.dk>, <arnd@arndb.de>
References: <20220421033914.217622-1-chenzhongjin@huawei.com>
 <461fa8ba-82c1-73b0-b900-7fa1ffb774f9@infradead.org>
From:   Chen Zhongjin <chenzhongjin@huawei.com>
In-Reply-To: <461fa8ba-82c1-73b0-b900-7fa1ffb774f9@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.108.67]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500013.china.huawei.com (7.185.36.172)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2022/4/21 12:08, Randy Dunlap wrote:
> Hi--
> 
> On 4/20/22 20:39, Chen Zhongjin wrote:
>> ---
>>  kernel/smp.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/smp.c b/kernel/smp.c
>> index 65a630f62363..1ce64de460d0 100644
>> --- a/kernel/smp.c
>> +++ b/kernel/smp.c
>> @@ -176,7 +176,7 @@ static int __init csdlock_debug(char *str)
>>  
>>  	return 0;
> 
> ^^^ This should be
> 	return 1;
> 
> since __setup() functions return 1 on success -- opposite of
> early_param() return values.
> 

Fixed in v2.

By the way, below patch forced to open CONFIG_SPARSEMEM_VMEMMAP on arm64
from 5.12-rc3. By this __page_to_pfn won't call __nr_to_section and
causes this bug.

https://lore.kernel.org/all/20210420093559.23168-1-catalin.marinas@arm.com/

So this patch is only applied to 5.10-LTS.

>>  }
>> -early_param("csdlock_debug", csdlock_debug);
>> +__setup("csdlock_debug=", csdlock_debug);
>>  
>>  static DEFINE_PER_CPU(call_single_data_t *, cur_csd);
>>  static DEFINE_PER_CPU(smp_call_func_t, cur_csd_func);
> 
> Thanks.
> 

Thanks!

