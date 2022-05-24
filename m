Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29CCD532A73
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 14:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237379AbiEXMfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 08:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232680AbiEXMfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 08:35:47 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A8313F20
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 05:35:46 -0700 (PDT)
Received: from mail-yb1-f178.google.com ([209.85.219.178]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MuluN-1ncV6p2OlH-00rn6L for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022
 14:35:44 +0200
Received: by mail-yb1-f178.google.com with SMTP id s14so3268017ybc.10
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 05:35:44 -0700 (PDT)
X-Gm-Message-State: AOAM532HVzq86NpMQWhQDw99CLVyqkFtPi7jwl+vdkVwU5cN4GTQqkZe
        xUF8OCdr4bmrcJgLKD+Z8VlBTpQiEEpXAXikNXQ=
X-Google-Smtp-Source: ABdhPJz9m9ORZ9D9BvYMed+3CBOfj9iqcDQAfnck/FOZ2NFPYY/aPURrCNWdk7JUo0ug0DMQDbzsidcl1E/w96/ZJ20=
X-Received: by 2002:a25:5e09:0:b0:64d:8543:627d with SMTP id
 s9-20020a255e09000000b0064d8543627dmr26382655ybb.394.1653395743407; Tue, 24
 May 2022 05:35:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220519082552.117736-5-wangkefeng.wang@huawei.com>
 <202205240657.BXxrhbgp-lkp@intel.com> <c4ea8f50-f445-f4ee-1d17-f21954e52a83@huawei.com>
In-Reply-To: <c4ea8f50-f445-f4ee-1d17-f21954e52a83@huawei.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 24 May 2022 14:35:27 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1qEk3hLUOijtzXRhT4-nZO8KUe1a_3mvUVSSzaGt2itg@mail.gmail.com>
Message-ID: <CAK8P3a1qEk3hLUOijtzXRhT4-nZO8KUe1a_3mvUVSSzaGt2itg@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] mm: ioremap: Add arch_ioremap/iounmap()
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     kernel test robot <lkp@intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kbuild-all@lists.01.org, Linux-MM <linux-mm@kvack.org>,
        Christoph Hellwig <hch@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:5WSYV9p9l8D8Rx2OhPaKKjoiyxoWYbDr7kObijWVWfVx0f/kEgc
 OvPAFrxJNEHQd5zD1eb24vVFP4Evb0BolBYhcRyH97ntusYgXXN0wbadQpX+v7lCKcIw7Df
 Uac1qCNaxTp8RJE307Bd78MRoL+i35QhNdHKZnG8hn1IOhac0+6k0u3bazOX6tu+8JeV9B8
 FURo0BWoTIiE6Q++avB2g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7toOWGWTT8g=:dhIHCU18s1llDyTH3YN98d
 LVaSopTcRG39ykXFM8QJMAuowcIdw7rEViID7ePG9PxncVBMaQrqD5aDxw6rXoT54sy6NzlHK
 tLbnfM0h4A90S8VZkUpVu+o3alvA4lyzF2I1u9+4mPT9J3UMg2NiqrXcgZA7H246aTPoNPhfm
 wPLSzTrLknpOOT9/FgR68L+bhcRdTuY26etUOJb1K3MjdzcsV+HNy3Xfxw0WDfnBRhq80nUzx
 8wwLdQHPUDBfjB1ovzdMGbuDpZjzk/q2b4/lZmIcg/OomeEXki4HK7ZFMm1vmDiEV8SEH6Joe
 QiflF+sB3aMhLSYJ2AmoxA6v341uHtjGIhyrzbz7QJKnZ7QBrrEbg/gzc7nTnxlTxGG+KfiM+
 b+z8IcijFLXyHLcNADiDzuiKmhK67cRJUS0O1tVDu9xJSC4wnVobXKsgAZCmOQyLsAbMqzFdf
 KsHl48O9SrCSyojVkIkKIrHNBrOGT/MBSUjMtAfxU3X+2gtz12mbVeRRoXrsKqunXyHPDtiLj
 AklTOjBn6QDh2lUBUtROoYyMyw3ebSLHS3+hs7HTQnYL5+Ymwcs5kvjVCjL+0oy4lgDs+0I2X
 3jEkgF8iFokz8xH74ZcD3d/+91UOksWc/TwCn293UWn3VnQUldX9HTRSc0xpeTvVQn2v8coQv
 bA7/4Xd7pYbCm06+HKc8V0dehjwEBqO7qKKNkxtDdq0/eCs+IvX6ASHdfDoLDNAvFKYAqvpaD
 AcZI+29EvICo8+EmvUildjmQLVWCAoY07dsDKaaRDWKQvuGlo5D3g3xmOpopIi01RUPXiuTbV
 Xg4YusigGdOtHSo2dOswIWXCAACrSAaKWRdxeREUdHD9rMSWsP2W7cgQsP+0b4ljswJuFqTlI
 fxilcmMoY7ThJXv1vr0dOTBmvTZVeOrqiNfiWbNFY=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 24, 2022 at 11:48 AM Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
> >>> mm/ioremap.c:59:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const *addr @@     got void [noderef] __iomem *vaddr @@
> >     mm/ioremap.c:59:16: sparse:     expected void const *addr
> >     mm/ioremap.c:59:16: sparse:     got void [noderef] __iomem *vaddr
> >
> > vim +59 mm/ioremap.c
> >
> >      51
> >      52       void iounmap(volatile void __iomem *addr)
> >      53       {
> >      54               void __iomem *vaddr = (void __iomem *)((unsigned long)addr & PAGE_MASK);
> >      55
> >      56               if (arch_iounmap(vaddr))
> >      57                       return;
> >      58
> >    > 59               vunmap(vaddr);
>
> 1) Will add generic "arch_ioremap/arch_iounmap define"
>
> 2) and change this to vunmap((void *)vaddr);

I think this need an extra __force to actually suppress the sparse
warning, as in

        vunmap((void __force *)vaddr);

Using __force is usually wrong, this is one of the exceptions, so
maybe add a comment
as well.

         Arnd
