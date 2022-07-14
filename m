Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A599F574B7D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 13:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238599AbiGNLGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 07:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbiGNLGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 07:06:11 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F4E300
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 04:06:08 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0VJJBXzu_1657796763;
Received: from B-LB6YLVDL-0141.local(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0VJJBXzu_1657796763)
          by smtp.aliyun-inc.com;
          Thu, 14 Jul 2022 19:06:04 +0800
Subject: Re: [PATCH V2 2/2] riscv: Add modules to virtual kernel memory layout
 dump
To:     =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <alexandre.ghiti@canonical.com>,
        Guo Ren <guoren@kernel.org>, Anup Patel <anup@brainfault.org>,
        Nick Kossifidis <mick@ics.forth.gr>,
        Mike Rapoport <rppt@kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        huanyi.xj@alibaba-inc.com
References: <20220714025901.359695-1-xianting.tian@linux.alibaba.com>
 <CAK8P3a3-jKEs+uGL=_kjmfzao6DYgmrkO+YWtNhv5O+hFw_qog@mail.gmail.com>
 <f706ddff-8444-bba1-a98a-23a1333cc70a@linux.alibaba.com>
 <3975689.5fSG56mABF@diego>
From:   Xianting Tian <xianting.tian@linux.alibaba.com>
Message-ID: <46732d07-f14b-2fd1-5606-1582f69b8d00@linux.alibaba.com>
Date:   Thu, 14 Jul 2022 19:06:03 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <3975689.5fSG56mABF@diego>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/7/14 下午5:46, Heiko Stübner 写道:
> Am Donnerstag, 14. Juli 2022, 11:17:26 CEST schrieb Xianting Tian:
>> 在 2022/7/14 下午4:24, Arnd Bergmann 写道:
>>> On Thu, Jul 14, 2022 at 4:59 AM Xianting Tian
>>> <xianting.tian@linux.alibaba.com> wrote:
>>>> As MODULES is only defined for CONFIG_64BIT, so we dump it when
>>>> CONFIG_64BIT.
>>> Doesn't this cause a compile-time error on 32-bit?
>> I tested, rv32 compile is OK.
>>>>                   (unsigned long)VMEMMAP_END);
>>>>           print_ml("vmalloc", (unsigned long)VMALLOC_START,
>>>>                   (unsigned long)VMALLOC_END);
>>>> +       if (IS_ENABLED(CONFIG_64BIT))
>>>> +               print_ml("modules", (unsigned long)MODULES_VADDR,
>>>> +                       (unsigned long)MODULES_END);
>>> The IS_ENABLED() check prevents the line from getting executed, but
>>> unlike an #ifdef it still relies on it to be parsable.
>> Thanks, I will use #ifdef instead of IS_ENABLED
> Patch1 also has that issue with the
thanks, I will modify it in V3.
>
>        if (IS_ENABLED(CONFIG_64BIT)) {
>                vmcoreinfo_append_str("NUMBER(MODULES_VADDR)=0x%lx\n", MODULES_VADDR);
>                vmcoreinfo_append_str("NUMBER(MODULES_END)=0x%lx\n", MODULES_END);
>        ....
>
>
> module_alloc falls back to a weak variant [0] which is the same as the riscv variant
> only then using VMALLOC_START - VMALLOC_END as range, as the riscv-variant
> conditional to CONFIG_64BIT.

yes, I ever checked, actually before 5.13, it doesn't define MODULES 
area but use VMALLOC for modules,

crash> mod
      MODULE       NAME           BASE           SIZE  OBJECT FILE
ffffffdf8167f280  galcore  ffffffdf81646000  3075841  (not loaded)  
[CONFIG_KALLSYMS]

[    0.000000]      vmalloc : 0xffffffd000000000 - 0xffffffdfffffffff   
(65535 MB)

>
> I'm wondering if it wouldn't be easier in the long run to just define
> MODULES_VADDR, MODULES_END for 32bit to use these values and get rid of
> the CONFIG_64BIT ifdef we already have for MODULES (and new ones we are
> introducing now).
>
>
> Heiko
>
>
> [0] https://elixir.bootlin.com/linux/latest/source/kernel/module.c#L2835
>
>
