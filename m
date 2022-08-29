Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2EF55A40A3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 03:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbiH2B0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 21:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiH2B02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 21:26:28 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E27C92A954
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 18:26:26 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MGCNm50KQz1N7Rq;
        Mon, 29 Aug 2022 09:22:48 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (7.193.23.234) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 29 Aug 2022 09:26:24 +0800
Received: from [10.174.179.234] (10.174.179.234) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 29 Aug 2022 09:26:23 +0800
Message-ID: <bc23cce2-1a13-27c5-586b-283289ac8275@huawei.com>
Date:   Mon, 29 Aug 2022 09:26:22 +0800
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
 <c0e286b4-3005-71fb-3bb2-476944099d4e@huawei.com>
 <CAK8P3a0akgBkyVQuAfi5qdi9O5DhxZJ3FknxGH-gedpJpAVw6w@mail.gmail.com>
From:   Tong Tiangen <tongtiangen@huawei.com>
In-Reply-To: <CAK8P3a0akgBkyVQuAfi5qdi9O5DhxZJ3FknxGH-gedpJpAVw6w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.234]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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



在 2022/8/27 20:49, Arnd Bergmann 写道:
> On Sat, Aug 27, 2022 at 12:43 PM Tong Tiangen <tongtiangen@huawei.com> wrote:
>> 在 2022/8/26 17:30, Arnd Bergmann 写道:
>>
>> I am very interested in the implementation of X86. I need to investigate
>> and consider a cross architecture implementation.
> 
> One more point about the cross-architecture work: it generally makes
> sense to do the most commonly used architectures first, usually
> that would be x86, arm64 and powerpc64, followed by riscv, arm,
> s390 and mips. If we can find something that the first architecture
> maintainers like, everyone else can follow and you don't have to
> rework all of them multiple times before getting to a consensus.
> 
>> However, I understand that the modification of the current patch has
>> little to do with the two points mentioned above. We can optimize the
>> code step by step.
> 
> You are correct that this has little to do with your patch, my point
> was mainly that your patch is moving the code further away from
> the other architectures, so it would make it harder to then do the
> changes we actually want.
> 
>         Arnd

I understand what you mean，it's reasonable.

Thanks,
Tong.
> 
> .
