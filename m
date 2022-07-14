Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CADE2574988
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 11:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237531AbiGNJsh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 14 Jul 2022 05:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233750AbiGNJsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 05:48:07 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF19713CDE
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 02:46:35 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1oBvQL-0002sU-8M; Thu, 14 Jul 2022 11:46:21 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Arnd Bergmann <arnd@arndb.de>,
        Xianting Tian <xianting.tian@linux.alibaba.com>
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
Subject: Re: [PATCH V2 2/2] riscv: Add modules to virtual kernel memory layout dump
Date:   Thu, 14 Jul 2022 11:46:20 +0200
Message-ID: <3975689.5fSG56mABF@diego>
In-Reply-To: <f706ddff-8444-bba1-a98a-23a1333cc70a@linux.alibaba.com>
References: <20220714025901.359695-1-xianting.tian@linux.alibaba.com> <CAK8P3a3-jKEs+uGL=_kjmfzao6DYgmrkO+YWtNhv5O+hFw_qog@mail.gmail.com> <f706ddff-8444-bba1-a98a-23a1333cc70a@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 14. Juli 2022, 11:17:26 CEST schrieb Xianting Tian:
> 
> 在 2022/7/14 下午4:24, Arnd Bergmann 写道:
> > On Thu, Jul 14, 2022 at 4:59 AM Xianting Tian
> > <xianting.tian@linux.alibaba.com> wrote:
> >> As MODULES is only defined for CONFIG_64BIT, so we dump it when
> >> CONFIG_64BIT.
> > Doesn't this cause a compile-time error on 32-bit?
> I tested, rv32 compile is OK.

> >>                  (unsigned long)VMEMMAP_END);
> >>          print_ml("vmalloc", (unsigned long)VMALLOC_START,
> >>                  (unsigned long)VMALLOC_END);
> >> +       if (IS_ENABLED(CONFIG_64BIT))
> >> +               print_ml("modules", (unsigned long)MODULES_VADDR,
> >> +                       (unsigned long)MODULES_END);
> > The IS_ENABLED() check prevents the line from getting executed, but
> > unlike an #ifdef it still relies on it to be parsable.
> Thanks, I will use #ifdef instead of IS_ENABLED

Patch1 also has that issue with the

      if (IS_ENABLED(CONFIG_64BIT)) {
              vmcoreinfo_append_str("NUMBER(MODULES_VADDR)=0x%lx\n", MODULES_VADDR);
              vmcoreinfo_append_str("NUMBER(MODULES_END)=0x%lx\n", MODULES_END);
      ....


module_alloc falls back to a weak variant [0] which is the same as the riscv variant
only then using VMALLOC_START - VMALLOC_END as range, as the riscv-variant
conditional to CONFIG_64BIT.

I'm wondering if it wouldn't be easier in the long run to just define
MODULES_VADDR, MODULES_END for 32bit to use these values and get rid of
the CONFIG_64BIT ifdef we already have for MODULES (and new ones we are
introducing now).


Heiko


[0] https://elixir.bootlin.com/linux/latest/source/kernel/module.c#L2835



