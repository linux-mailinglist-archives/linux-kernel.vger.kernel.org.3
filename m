Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2958A574882
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 11:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235164AbiGNJVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 05:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237621AbiGNJVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 05:21:16 -0400
Received: from out199-2.us.a.mail.aliyun.com (out199-2.us.a.mail.aliyun.com [47.90.199.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E09243328
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 02:18:06 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R561e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0VJIm16b_1657790247;
Received: from B-LB6YLVDL-0141.local(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0VJIm16b_1657790247)
          by smtp.aliyun-inc.com;
          Thu, 14 Jul 2022 17:17:29 +0800
Subject: Re: [PATCH V2 2/2] riscv: Add modules to virtual kernel memory layout
 dump
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <alexandre.ghiti@canonical.com>,
        Guo Ren <guoren@kernel.org>, Anup Patel <anup@brainfault.org>,
        Nick Kossifidis <mick@ics.forth.gr>,
        Mike Rapoport <rppt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        huanyi.xj@alibaba-inc.com
References: <20220714025901.359695-1-xianting.tian@linux.alibaba.com>
 <20220714025901.359695-3-xianting.tian@linux.alibaba.com>
 <CAK8P3a3-jKEs+uGL=_kjmfzao6DYgmrkO+YWtNhv5O+hFw_qog@mail.gmail.com>
From:   Xianting Tian <xianting.tian@linux.alibaba.com>
Message-ID: <f706ddff-8444-bba1-a98a-23a1333cc70a@linux.alibaba.com>
Date:   Thu, 14 Jul 2022 17:17:26 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a3-jKEs+uGL=_kjmfzao6DYgmrkO+YWtNhv5O+hFw_qog@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/7/14 下午4:24, Arnd Bergmann 写道:
> On Thu, Jul 14, 2022 at 4:59 AM Xianting Tian
> <xianting.tian@linux.alibaba.com> wrote:
>> As MODULES is only defined for CONFIG_64BIT, so we dump it when
>> CONFIG_64BIT.
> Doesn't this cause a compile-time error on 32-bit?
I tested, rv32 compile is OK.
>
>>                  (unsigned long)VMEMMAP_END);
>>          print_ml("vmalloc", (unsigned long)VMALLOC_START,
>>                  (unsigned long)VMALLOC_END);
>> +       if (IS_ENABLED(CONFIG_64BIT))
>> +               print_ml("modules", (unsigned long)MODULES_VADDR,
>> +                       (unsigned long)MODULES_END);
> The IS_ENABLED() check prevents the line from getting executed, but
> unlike an #ifdef it still relies on it to be parsable.
Thanks, I will use #ifdef instead of IS_ENABLED
>
>           Arnd
