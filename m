Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D84DA55F5D5
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 07:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbiF2Fvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 01:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiF2Fvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 01:51:46 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A911658C
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 22:51:45 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LXrBZ1KwczhYrL;
        Wed, 29 Jun 2022 13:49:26 +0800 (CST)
Received: from dggpemm500016.china.huawei.com (7.185.36.25) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 29 Jun 2022 13:51:42 +0800
Received: from [10.67.108.157] (10.67.108.157) by
 dggpemm500016.china.huawei.com (7.185.36.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 29 Jun 2022 13:51:42 +0800
Message-ID: <6c274345-3370-16c8-f5f1-68521de0f51a@huawei.com>
Date:   Wed, 29 Jun 2022 13:51:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] stack: Declare {randomize_,}kstack_offset to fix Sparse
 warnings
Content-Language: en-US
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>
CC:     Xiu Jianfeng <xiujianfeng@huawei.com>,
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220629032939.2506773-1-gongruiqi1@huawei.com>
 <ca0fa9d2-64dd-0e77-71b6-3673e353c316@csgroup.eu>
From:   Gong Ruiqi <gongruiqi1@huawei.com>
In-Reply-To: <ca0fa9d2-64dd-0e77-71b6-3673e353c316@csgroup.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.108.157]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500016.china.huawei.com (7.185.36.25)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/06/29 13:10, Christophe Leroy wrote:
> 
> 
> Le 29/06/2022 à 05:29, GONG, Ruiqi a écrit :
>> Fix the following Sparse warnings that got noticed when the PPC-dev
>> patchwork was checking another patch (see the link below):
>>
>> init/main.c:862:1: warning: symbol 'randomize_kstack_offset' was not declared. Should it be static?
>> init/main.c:864:1: warning: symbol 'kstack_offset' was not declared. Should it be static?
>>
>> Which in fact are triggered on all architectures that have
>> HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET support (for instances x86, arm64
>> etc).
>>
>> Link: https://lore.kernel.org/lkml/e7b0d68b-914d-7283-827c-101988923929@huawei.com/T/#m49b2d4490121445ce4bf7653500aba59eefcb67f
>> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
>> Cc: Xiu Jianfeng <xiujianfeng@huawei.com>
>> Signed-off-by: GONG, Ruiqi <gongruiqi1@huawei.com>
>> ---
>>   init/main.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/init/main.c b/init/main.c
>> index e2490387db2b..6aa0fb2340cc 100644
>> --- a/init/main.c
>> +++ b/init/main.c
>> @@ -101,6 +101,10 @@
>>   #include <linux/stackdepot.h>
>>   #include <net/net_namespace.h>
>>
>> +#ifdef CONFIG_RANDOMIZE_KSTACK_OFFSET
> 
> You don't need this #ifdef, there is already one inside 
> linux/randomize_kstack.h
> 

Ah yes, I didn't notice the config was there already. I will send a new
version. Thanks for your reminder!

>> +#include <linux/randomize_kstack.h>
>> +#endif
>> +
>>   #include <asm/io.h>
>>   #include <asm/bugs.h>
>>   #include <asm/setup.h>
>> --
>> 2.25.1
