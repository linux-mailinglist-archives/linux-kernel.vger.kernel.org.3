Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6510C52FF60
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 22:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343968AbiEUUa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 16:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233059AbiEUUaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 16:30:22 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D005A2C4
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 13:30:21 -0700 (PDT)
Received: from mail-yw1-f175.google.com ([209.85.128.175]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MuDTn-1nZbF8223R-00ud5b for <linux-kernel@vger.kernel.org>; Sat, 21 May
 2022 22:30:19 +0200
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-2ff39b44b06so115437057b3.13
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 13:30:19 -0700 (PDT)
X-Gm-Message-State: AOAM531apC9iUp6ehTXbLxO0zX4vum9NEiWALnO3qI5cnPPpuKeymKxJ
        HiMinqAeZAxD0F37HOJdkHRtp1iOJ7OISMuz+qM=
X-Google-Smtp-Source: ABdhPJxdzeQ8ppWmG4FaNugj1IVJL8hVon5ICr2txVNKnWSwzCAfUIa/u3XB2kovYWtRi5zFhQ8P1BD7cK9iFDjy8rQ=
X-Received: by 2002:a81:950:0:b0:2fe:d88e:5529 with SMTP id
 77-20020a810950000000b002fed88e5529mr16185220ywj.320.1653165018339; Sat, 21
 May 2022 13:30:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220519082552.117736-1-wangkefeng.wang@huawei.com> <20220519082552.117736-2-wangkefeng.wang@huawei.com>
In-Reply-To: <20220519082552.117736-2-wangkefeng.wang@huawei.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 21 May 2022 22:30:01 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3AaYovsu+aOmi62y-2i+0tmHHqpGN_PdToGt_UnGw=Ag@mail.gmail.com>
Message-ID: <CAK8P3a3AaYovsu+aOmi62y-2i+0tmHHqpGN_PdToGt_UnGw=Ag@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] ARM: mm: kill unused runtime hook arch_iounmap()
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Christoph Hellwig <hch@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Russell King <linux@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:EyHYTdRf6fVBn4QH+OGG17POm2ylUgIsX3SJ886CzOZYeKjc15D
 krzAaAWjsrKunYBRBFP9SttUpBW3GZAqV94vn7Qb0BLs/3rlIxb8T6V43Ckb512GXpbENmj
 S/oqUcX0bkPLforyIAUCK3i9GrLb1+QGvC8sGVKMGTaDiYDYr/OTvTmUWgM7ilTSwfw6m9z
 Hoj4/b1qCZvlQmBZBlyrA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Vo1Z3ZuSZUo=:vrhxz5YVbXAXV6/4I56+O3
 ws0Ba4m0X5sSPrOoejBrejsaav/QcwkSFTvwb0i6d8Q27eF3ir4i7Cbk9vFRZ3FxI7XkR6OnZ
 nugI8p3Xa1VTrDPqLqNQedtty+LckNnnYGacfqbdNeXpRysIH+HcmvJgxnD8tLrXv/o1tXCpB
 +AnrmrCEwLLNnGpDX4l5SJ/nKlPqWBgyBV+58ZNKilxkoddSUFIxChvLHr2TqxqIfQIUCS8Ts
 ikMi2sDE6q2qOmNGOt/aKPhJDNNA0IdwFeK/3fT6eorIk1Gl86/lcH0k63SuvxI6QdQg+YZrX
 JySl5j5Ou0SN9hwE7+I7bBSsrHay6G6wpRhYrEYmZqORimqIAhVLFkmvcebta6XF1u+LZQIhR
 375RfEwloLoXdf+DaZ8SY7lqCIKrkEl/BRNBP6Hd99ypRJ5r4ILys8zWgtuYzd9L1tAJeY9H/
 TSvqx/+kvBNX6vE//qtO95+DZL0+C7p8imNPCAp1/DqHuJSK3gzNW/LE0jGNCkrelUfTpjlmC
 zXn6awZA0zo0kgaWPOy9VC81lNEv085/wLLJobVsdEsO5o1NHERuop2h3TFBcPF7ro2Uspv+W
 ccNePwTPWHtkz1wa0zbglXSVDBuu8Yiwr9wCyXCvyiez8FPD6HxPte73pYm/Vk30/OTx6hXrB
 VKq/z2+FY1Rpo4K3TEhttBwEDuvqNEYQx6ar24hvjbKfZ9h+X1pjG2HkCLxSt+S+Kd80AbnzV
 RHqVVGJ8PZT/A7PHLLUWuZ/wgReacPOkPZdhbkPbPjP2VNm+P0cAIy0js+n+6dhryL17WG0Zl
 vIdOLfDntmzg7/srIxKdVLOFYQ8OOAdPM5AT++gdl5zZTSrM3kaC1gwLNH/Q3tlKnl8wlBi4r
 +MF7qRPncSkG/d5F0Orw==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2022 at 10:25 AM Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>
> Since the following commits,
>
> v5.4
>   commit 59d3ae9a5bf6 ("ARM: remove Intel iop33x and iop13xx support")
> v5.11
>   commit 3e3f354bc383 ("ARM: remove ebsa110 platform")
>
> The runtime hook arch_iounmap() on ARM is useless, kill arch_iounmap()
> and __iounmap(), and the naming of arch_iounmap will be used in
> GENERIC_IOREMAP with the later patch.
>
> Cc: Russell King <linux@armlinux.org.uk>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

I had a very similar patch prototyped recently,

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

It would be nice to do the same for arch_ioremap_caller(), which now
has two implementations left for mvebu and imx3, previously we had
more for iop13xx, ebsa110, ixp4xx and msm.

For both armada37x/380 and imx3, the only purpose is to override
the mtype argument, and it feels like there should be a better way
to do this, though I'm not sure what that is. Having an overridable
mtype value per 256MB section of physical address space would
be sufficient for both, but I don't know if that's any better than what
we have.

        Arnd
