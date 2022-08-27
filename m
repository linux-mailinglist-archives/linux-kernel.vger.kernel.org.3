Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD38E5A3715
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 12:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233786AbiH0KnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 06:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbiH0KnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 06:43:11 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0087572EE0
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 03:43:09 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MFCrP2pptzlVhw;
        Sat, 27 Aug 2022 18:39:49 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (7.193.23.234) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 27 Aug 2022 18:43:08 +0800
Received: from [10.174.179.234] (10.174.179.234) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 27 Aug 2022 18:43:06 +0800
Message-ID: <c0e286b4-3005-71fb-3bb2-476944099d4e@huawei.com>
Date:   Sat, 27 Aug 2022 18:43:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH -next v2 1/2] riscv: uaccess: rename
 __get/put_user_nocheck to __get/put_mem_nocheck
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        <Conor.Dooley@microchip.com>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <wangkefeng.wang@huawei.com>,
        Guohanjun <guohanjun@huawei.com>
References: <20220815032025.2685516-1-tongtiangen@huawei.com>
 <20220815032025.2685516-2-tongtiangen@huawei.com>
 <CAK8P3a0ixaYimjCh77QBJpbHbVsw+9C7RiW2LEnwQ8HnwG_jHg@mail.gmail.com>
From:   Tong Tiangen <tongtiangen@huawei.com>
In-Reply-To: <CAK8P3a0ixaYimjCh77QBJpbHbVsw+9C7RiW2LEnwQ8HnwG_jHg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.234]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600017.china.huawei.com (7.193.23.234)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/8/26 17:30, Arnd Bergmann 写道:
> On Mon, Aug 15, 2022 at 5:20 AM Tong Tiangen <tongtiangen@huawei.com> wrote:
>>
>> Current, The helpers __get/put_user_nocheck() is used by get/put_user() and
>> __get/put_kernel_nofault(), which is not always uaccess, so the name with
>> *user* is not appropriate.
>>
>> Also rename xxx_user_xxx to xxx_mem_xx  on the call path of
>> __get/put_user_nocheck()
>>
>> Only refactor code without any functional changes.
>>
>> Signed-off-by: Tong Tiangen <tongtiangen@huawei.com>
> 
> I would prefer this not being done, it just makes riscv diverge from the
> code on other architectures. While the new name does make more sense,
> it ends up making it harder to refactor this across architectures in the end.
> 
> There are two important cleanups that I would like to see done in
> asm/uaccess.h across architectures:
> 
>   - generalize the __get_user()/__put_user()/__get_kernel_nofault()/
>    __put_kernel_nofault() wrappers to the point that architectures do not
>    need to worry about the variable type stuff but instead just provide
>    trivial fixed-length helpers of some sort
> 
> - change the calling conventions in a way that allows the use of the
>    asm-goto-with-output method for better object code on modern
>    compilers.
> 
> The x86 version already has most of this, with their
> __get_user_size() macro supporting both the asm-goto label
> and the error code assignment, so the generalized code should
> probably be based on that approach.

I am very interested in the implementation of X86. I need to investigate 
and consider a cross architecture implementation.
However, I understand that the modification of the current patch has 
little to do with the two points mentioned above. We can optimize the 
code step by step.

Thanks,
Tong.

> 
>         Arnd
> 
> .
