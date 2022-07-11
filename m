Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE3C5570697
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 17:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232040AbiGKPHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 11:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiGKPHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 11:07:12 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 186D059269;
        Mon, 11 Jul 2022 08:07:10 -0700 (PDT)
Received: from mail-yw1-f178.google.com ([209.85.128.178]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MkYHO-1nhrW717Ak-00m1Cw; Mon, 11 Jul 2022 17:07:09 +0200
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-31c8bb90d09so51972277b3.8;
        Mon, 11 Jul 2022 08:07:08 -0700 (PDT)
X-Gm-Message-State: AJIora9eToO4KDIPYYTbpilbP7rgm/wNbT8EvFVhUlH5oRfDAhw7LlwX
        SIZDOZblIGawLjfp8Ug9ydbF5x8y9SlheY98FP0=
X-Google-Smtp-Source: AGRyM1vaXhfOl3QItNRfQ000H5cqHKSlSfBsuKTqQoYqjnPl3VeC8AEpjwD+LvECxEubJyHF3u5xH42jRbNIDk4Ku7Y=
X-Received: by 2002:a81:f82:0:b0:31c:f1ae:1ed6 with SMTP id
 124-20020a810f82000000b0031cf1ae1ed6mr19994128ywp.249.1657552027874; Mon, 11
 Jul 2022 08:07:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220711122459.13773-1-me@linux.beauty> <20220711122459.13773-2-me@linux.beauty>
 <CAK8P3a1WbJSWHsfegTtLhzSRwAoN8WfdezTTedRk9-FCiM8+GA@mail.gmail.com> <181edbe0f3d.e1336ef3387914.4730240512950880256@linux.beauty>
In-Reply-To: <181edbe0f3d.e1336ef3387914.4730240512950880256@linux.beauty>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 11 Jul 2022 17:06:50 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0Qo=xexUDs=XA2gRe4p-FPoXUpuxWrnqWrr43FTViA3w@mail.gmail.com>
Message-ID: <CAK8P3a0Qo=xexUDs=XA2gRe4p-FPoXUpuxWrnqWrr43FTViA3w@mail.gmail.com>
Subject: Re: [PATCH 1/4] of: add struct page support to rmem
To:     Li Chen <me@linux.beauty>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Li Chen <lchen@ambarella.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:soLT3rJcjNSjCdFsvjKYBqi9Zwd2f8kyPgdtb4mJkM3zwMPQ8VG
 j3DVwbHaQn/YZwSQ0gfQimssLV94zL56FOwVOtGCtxpSem5l57Ut08XbboHXSBbySOb6rDd
 UL4Mz+kshMFzpxl/22XvZ6OypVlZ70ckXeQ8XeDRdq0bYvGfeDgT0oM/pDR52niGVFiCHkm
 U7ja9KvAs8OIiKtOUyvyw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:IKaYoq9n/Ec=:IbWAFkbCNbVkEijXVqShvj
 ffHJsxNQrvMxUCHq0n0NwAwDzqdxtHz1Qwp1jF+eUX4zqiM9gqPsekuZcqjJYxs6Ch/iBm43t
 M8MOyFCHBWAnYWhulo+cvhIfZlpfC4Nhu607TUDRPt2Gzed5lkJmFMQzXW3aZe7UbImKRGd+Q
 oBL+hR8czYyDlPddcfvNs8/4NlB0TIXGkvLhw+VrK+vigbd06ssuMrFrlA28u0kra5ZyjJHO0
 cyDs2Z0srGNS4EfSwTQojGqj9fBXpWzf81pJwKfwOp5jAT2mrEX7JvaHws0LnGPTMcgUIjvN0
 OCZZPRDjLMh0ewRz4Z2GrmvZSdX30n2sQJt5jzfEiaWifmJzvmx1J6BwNgSwZmd02mdDYWOZE
 TiBDFjJfXqVZFAyV65PhJdTWtwfSUJAK/2TDKe8bw2ilpqQdauxI+VFzl5Ccopu3CNnkLX+ty
 POzWtP50M364CQBj+adwup8kKPkcOAp2WlpPsEtT81jWPA3Xh201mWqQsXpYHVfskmmlj6U9c
 1p3KDTSbM27LMIQWeMrJHApcQMzFlB58gh3jp10eTsnLzhCFCukqPTLFCWUd9hE5PZD7TKsCN
 85ZiNqubavwbKrHIKqGb1DmIqdUdBZlLeMQ297mwriHCiyjYak6l1ARq8QCoUGxDzXazU+AZG
 Yb4yFk/0UXYKpWdRv44Rnw1qW7Zy80xT83iixFBF4eXo4Y5GEfqzWSP+qHUJW+ldVLKWkHowM
 XfWqjNbg38QKCsvvOCnlrXiCiJGgGjVPEBxnxjv9WM5VaYzLkScC/R14Y8GsrZHOFufoghNL7
 uN9BEefdcIxF5oPAdCsOLVC1ZjgIvvCAYGml2bwhJyO/BBntLLXNhKKz0CPcTBCd6QemmSqS1
 7SWE1rsdagnQpMIsEk7Y2nuCZo4o1zIrMplFMWd40=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 11, 2022 at 4:51 PM Li Chen <me@linux.beauty> wrote:
>  ---- On Mon, 11 Jul 2022 21:36:12 +0800  Arnd Bergmann <arnd@arndb.de> wrote ---
>  > On Mon, Jul 11, 2022 at 2:24 PM Li Chen <me@linux.beauty> wrote:
>  >
>  > > +config OF_RESERVED_MEM_DIO_SUPPORT
>  > > +       bool "add Direct I/O support to reserved_mem"
>  > > +       depends on ZONE_DEVICE && ARCH_KEEP_MEMBLOCK
>  > > +       help
>  > > +          By default, reserved memory don't get struct page support, which
>  > > +                means you cannot do Direct I/O from this region. This config takes
>  > > +                uses of ZONE_DEVICE and treats rmem as hotplug mem to get struct
>  > > +                page and DIO support.
>  >
>  > This probably does not need to be user visible, it's enough to select it from
>  > the drivers that need it.
>
> When you say "user visible", do you mean the config can be dropped or something else like Kconfig type other than bool?

I mean this can be a hidden option, which you can do by leaving out the
one-line description after the 'bool' keyword. The option will still
be selectable
in Kconfig files from other options, but not shown in 'make menuconfig'.

        Arnd
