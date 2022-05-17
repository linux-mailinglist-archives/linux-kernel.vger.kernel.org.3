Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56ED452A06F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 13:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345217AbiEQLb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 07:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233488AbiEQLb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 07:31:57 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD47027175
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 04:31:56 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4L2Yjx0jCkzCskY;
        Tue, 17 May 2022 19:27:01 +0800 (CST)
Received: from [10.174.179.215] (10.174.179.215) by
 canpemm500007.china.huawei.com (7.192.104.62) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 17 May 2022 19:31:54 +0800
Subject: Re: [PATCH -next] powerpc/book3e: Fix build error
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "paulus@samba.org" <paulus@samba.org>
CC:     "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220517094830.27560-1-yuehaibing@huawei.com>
 <0e8b7931-9bfb-1948-c141-c4e612ba0fe6@csgroup.eu>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <8b169642-5d32-4135-93a7-4969515d1ab0@huawei.com>
Date:   Tue, 17 May 2022 19:31:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <0e8b7931-9bfb-1948-c141-c4e612ba0fe6@csgroup.eu>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/5/17 18:45, Christophe Leroy wrote:
> 
> 
> Le 17/05/2022 à 11:48, YueHaibing a écrit :
>> arch/powerpc/mm/nohash/fsl_book3e.c: In function ‘relocate_init’:
>> arch/powerpc/mm/nohash/fsl_book3e.c:348:2: error: implicit declaration of function ‘early_get_first_memblock_info’ [-Werror=implicit-function-declaration]
>>    early_get_first_memblock_info(__va(dt_ptr), &size);
>>    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>
>> Add missing include file linux/of_fdt.h to fix this.
>>
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> 
> Thats for fixing that.
> 
> Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> 
> It means we don't have any defconfig for 32 bits booke with 
> CONFIG_RELOCATABLE ?

Indeed, there is no defconfig with CONFIG_RELOCATABLE under arch/powerpc/configs
> 
>> ---
>>   arch/powerpc/mm/nohash/fsl_book3e.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/powerpc/mm/nohash/fsl_book3e.c b/arch/powerpc/mm/nohash/fsl_book3e.c
>> index 08a984e29433..093da4dbdee1 100644
>> --- a/arch/powerpc/mm/nohash/fsl_book3e.c
>> +++ b/arch/powerpc/mm/nohash/fsl_book3e.c
>> @@ -36,6 +36,7 @@
>>   #include <linux/delay.h>
>>   #include <linux/highmem.h>
>>   #include <linux/memblock.h>
>> +#include <linux/of_fdt.h>
>>   
>>   #include <asm/io.h>
>>   #include <asm/mmu_context.h>
