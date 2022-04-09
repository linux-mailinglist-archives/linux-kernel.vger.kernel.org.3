Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED9704FA664
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 11:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238853AbiDIJTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 05:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbiDIJTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 05:19:52 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B139207C9E
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 02:17:45 -0700 (PDT)
Received: from kwepemi100007.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Kb8dg56shzdZXd;
        Sat,  9 Apr 2022 17:17:11 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (7.193.23.234) by
 kwepemi100007.china.huawei.com (7.221.188.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 9 Apr 2022 17:17:42 +0800
Received: from [10.174.179.234] (10.174.179.234) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Sat, 9 Apr 2022 17:17:41 +0800
Message-ID: <8ef7a71b-fd0d-f86e-98bc-0a9cffc79207@huawei.com>
Date:   Sat, 9 Apr 2022 17:17:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [RFC PATCH -next V2 5/7] arm64: add get_user to machine check
 safe
To:     Mark Rutland <mark.rutland@arm.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
References: <20220406091311.3354723-1-tongtiangen@huawei.com>
 <20220406091311.3354723-6-tongtiangen@huawei.com>
 <Yk14AwR92MX0LKqZ@FVFF77S0Q05N>
 <ac80045b-24f0-a163-ea96-be0d01c48d29@huawei.com> <YlBTLn1cf7+gJmiM@lakrids>
From:   Tong Tiangen <tongtiangen@huawei.com>
In-Reply-To: <YlBTLn1cf7+gJmiM@lakrids>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.234]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600017.china.huawei.com (7.193.23.234)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/4/8 23:22, Mark Rutland 写道:
> On Thu, Apr 07, 2022 at 10:38:04PM +0800, Tong Tiangen wrote:
>> 在 2022/4/6 19:22, Mark Rutland 写道:
>>> On Wed, Apr 06, 2022 at 09:13:09AM +0000, Tong Tiangen wrote:
>>>> Add scenarios get_user to machine check safe. The processing of
>>>> EX_TYPE_UACCESS_ERR_ZERO and EX_TYPE_UACCESS_ERR_ZERO_UCE_RECOVERY is same
>>>> and both return -EFAULT.
>>>
>>> Which uaccess cases do we expect to *not* be recoverable?
>>>
>>> Naively I would assume that if we're going to treat a memory error on a uaccess
>>> as fatal to userspace we should be able to do that for *any* uacesses.
>>>
>>> The commit message should explain why we need the distinction between a
>>> recoverable uaccess and a non-recoverable uaccess.
>>>
>>> Thanks,
>>> Mark.
>>
>> Currently, any memory error consumed in kernel mode will lead to panic
>> (do_sea()).
>>
>> My idea is that not all memory errors consumed in kernel mode are fatal,
>> such as copy_ from_ user/get_ user is a memory error consumed when
>> reading user data in the process context. In this case, we can not let the
>> kernel panic, just kill the process without affecting the operation
>> of the system.
> 
> I understood this part.
> 
>> However, not all uaccess can be recovered without affecting the normal
>> operation of the system. The key is not whether it is uaccess, but whether
>> there are key data affecting the normal operation of the system in the read
>> page.
> 
> Ok. Can you give an example of such a case where the a uaccess that hits
> a memory error must be fatal?
> 
> I think you might be trying to say that for copy_{to,from}_user() we can
> make that judgement, but those are combined user+kernel access
> primitives, and the *uaccess* part should never be reading from a page
> with "key data affecting the normal operation of the system", since
> that's userspace memory.
> 
> Is there any *userspace access* (e.g. where we use LDTR/STTR today)
> where we must treat a memory error as fatal to the system?
> 
> Thanks,
> Mark.
> .

I seem to understand what you mean.
Take copy_to_user()/put_user() as an example. If it encounters memory 
error, only related processes will be affected. According to this 
understanding, it seems that all uaccess can be recovered.

Thanks,
Tong.
