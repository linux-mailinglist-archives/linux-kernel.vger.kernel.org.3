Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23C22512027
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244781AbiD0SYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 14:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244782AbiD0SYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 14:24:05 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A7C5AA4E
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 11:20:49 -0700 (PDT)
Received: from mail-yw1-f174.google.com ([209.85.128.174]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1Mspy4-1nz6Ep3T1k-00t8Zv for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022
 20:20:48 +0200
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-2ef5380669cso28336387b3.9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 11:20:47 -0700 (PDT)
X-Gm-Message-State: AOAM533JQw/gKkymZv4K96LKPX/UFEo5u67tJ++oO0BvKJgPGA94M1oc
        jpNu8wHFzHPHXHWtQ830FuaDI6i4QWdK2ZXqT8Y=
X-Google-Smtp-Source: ABdhPJwvEoSUguhdRwTP+lohWXQtYJ9DDg1Zn7qIjSsaEiGfg1kkd2iKF2q7oFkNsz/JpP2X/5Hv5gVbR3gnWZxOUM4=
X-Received: by 2002:a81:2305:0:b0:2f7:dadb:2162 with SMTP id
 j5-20020a812305000000b002f7dadb2162mr17396473ywj.42.1651083646618; Wed, 27
 Apr 2022 11:20:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220427121413.168468-1-wangkefeng.wang@huawei.com> <20220427121413.168468-3-wangkefeng.wang@huawei.com>
In-Reply-To: <20220427121413.168468-3-wangkefeng.wang@huawei.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 27 Apr 2022 20:20:30 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1E1vP-vS=-aH-XP=5taSTy8EUTfNSpQk9x47WLRMCOzQ@mail.gmail.com>
Message-ID: <CAK8P3a1E1vP-vS=-aH-XP=5taSTy8EUTfNSpQk9x47WLRMCOzQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] mm: ioremap: Add arch_ioremap/iounmap_check()
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:Py9c6L8yk4Q+u/Ah/U4yqNG58vF9Vui/iwrdfbE1xO+IcAxVelg
 WfkrrCffOdx2DTbqy59soc4/tCN3xmG1SPp5ACwCCx4ppq+CoTLMvNlkY+MHXm0pH1JFtJ4
 4K2hMrERDwyBThIlOMPSonMr47Kq+C037LICDMMcGVmdKS28BXKkgFtwVN5gChkhN6rnw02
 ncDaL0Pq8ZZvkCQOHusNw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:X4H1rwttH/k=:Gi7FBhMS0HESqzXcIydzOy
 OSg3pSWdg97bTqWTKHP9Biuzf+6xNpzVH7CLVNmwzmFH97QEi/qpvdSdKTuoWDHD15EZ4rjCw
 igScqUIdXj2oC6uavt1GTL+VqShDV9lEfrMTetXkRnhJBA6u2pbs78HRfN1CH6ME6nDuR/0Lq
 HRxmXDFR64kHpzyCyOZA0sZUEFeEtL6WFdjHINrk6EHwC1lIRmI/bSf1ZOE3C9eoEz9AA3K1n
 oe21c9TFyxK9puxDBaMxwbNXgiqS5cROyYDFm6wc0lVs2sc+4RUh3GrJP2g7x0GJoZ+Ydns8Y
 Y3uKoeL1Z/+jJ9vhH4QoB7lpiH7sZuACns63jkGCGBKYcJCPnKsJLAuz5/SRGRzQf/Zk8hao/
 sMv7I3IDdCk/jrFk69fRnOQS8OHRcGc5X4OOASkhCMd5kJwwQ3y1wkAKOjFoTLpIrc1T8zlC4
 CXXnYmNgitlT+H8alsr9FHmDjWRLq1gGpLPd6wlRzWNtjK1NFH5uBTtYW9jNq+B1pNlBwLjUU
 VUxrDQNdIzJM6i8WjfgLR+wc3ks5LHIUyQRB4/l+L+0Ak6Gdi8zcojGrnZ1nDb2V+G2uT/pFm
 B8aM5nfopwCK4jtk/3BsYA0P/jCXpbZXsp2hWzBNd5jHmjz1Y88JrOx+lxWm83CginrmdDr/9
 I51mPe42LT7k0JqVFM4oXRxIo8fz1cU7DyB4CGl20ABJ9btUlnhuo+crbWiqSjVhVMN/YIzUk
 HYdLayU4k9ftezAdSJJfqx8jiN9FpLWWxazLcVV7F6whbWrgTa6hvloEE0RG8ChMDyU7NOUED
 dzkGpo9td+UxqlXDoF/NmSknvJoGkcJ8r+79Ok9Otb1OfwoGKs=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 2:14 PM Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
> @@ -964,6 +964,9 @@ static inline void iounmap(volatile void __iomem *addr)
>  #elif defined(CONFIG_GENERIC_IOREMAP)
>  #include <linux/pgtable.h>
>
> +bool arch_ioremap_check(phys_addr_t addr, size_t size, unsigned long prot);
> +bool arch_iounmap_check(void __iomem *addr);
> +
>  void __iomem *ioremap_prot(phys_addr_t addr, size_t size, unsigned long prot);
>  void iounmap(volatile void __iomem *addr);
>
> diff --git a/mm/ioremap.c b/mm/ioremap.c
> index 522ef899c35f..d1117005dcc7 100644
> --- a/mm/ioremap.c
> +++ b/mm/ioremap.c
> @@ -11,6 +11,16 @@
>  #include <linux/io.h>
>  #include <linux/export.h>
>
> +bool __weak arch_ioremap_check(phys_addr_t addr, size_t size, unsigned long prot)
> +{
> +       return true;
> +}
> +
> +bool __weak arch_iounmap_check(void __iomem *addr)
> +{
> +       return true;
> +}
> +

I don't really like the weak functions. The normal way to do this in
asm-generic headers
is to have something like

#ifndef arch_ioremap_check
static inline bool arch_ioremap_check(phys_addr_t addr, size_t size,
unsigned long prot)
{
       return true;
}
#endif

and then in architectures that actually do some checking, have these
bits in asm/io.h

bool arch_ioremap_check(phys_addr_t addr, size_t size, unsigned long prot);
#define arch_ioremap_check arch_ioremap_check

(or alternatively an extern declaration, if the implementation is nontrivial)

It may be worth pointing out that either way requires including
asm-generic/io.h,
which most architectures don't. This is probably fine, as only csky, riscv and
now arm64 use CONFIG_GENERIC_IOREMAP, and we can probably require
that any further architectures using this symbol also have to use
asm-generic/io.h.

      Arnd
