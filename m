Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD9E247BCA9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 10:16:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236219AbhLUJQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 04:16:19 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:37335 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236205AbhLUJQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 04:16:18 -0500
Received: from mail-wr1-f49.google.com ([209.85.221.49]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MAORn-1nAteV1M3X-00Bppp; Tue, 21 Dec 2021 10:16:16 +0100
Received: by mail-wr1-f49.google.com with SMTP id v7so18213114wrv.12;
        Tue, 21 Dec 2021 01:16:16 -0800 (PST)
X-Gm-Message-State: AOAM530fbHOl5il2ljn1FhA4COoKsuLIJDsLKyFwRHVX4esi6IpdtuIz
        pxZ7S+m2H5CqNNYWEmdKbfxR/VyX/78c7+jDQlA=
X-Google-Smtp-Source: ABdhPJx9Io4wbdq+1IzDizMc/1NQgxlt0NBkcspgb9PgBIVFPO0KlDZf3O7JLbMTa4+qFamZN9MU3ZDjBxCGAtpSd58=
X-Received: by 2002:a5d:6989:: with SMTP id g9mr1797985wru.12.1640078175904;
 Tue, 21 Dec 2021 01:16:15 -0800 (PST)
MIME-Version: 1.0
References: <20211218085843.212497-1-cuigaosheng1@huawei.com>
 <CAK8P3a1-0u4VCCfgc7tjmnANM0yr7oUrQX2y-ZSVvZHDN191BQ@mail.gmail.com> <dfc25b22-2f66-4404-66c4-44c9c8c3bab4@huawei.com>
In-Reply-To: <dfc25b22-2f66-4404-66c4-44c9c8c3bab4@huawei.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 21 Dec 2021 10:15:59 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0aNoU693ft3pHCPJOcGubZ1dMFyOmWozO0N_8-F_JkLQ@mail.gmail.com>
Message-ID: <CAK8P3a0aNoU693ft3pHCPJOcGubZ1dMFyOmWozO0N_8-F_JkLQ@mail.gmail.com>
Subject: Re: [PATCH -next 0/3] replace open coded VA->PA calculation
To:     cuigaosheng <cuigaosheng1@huawei.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>,
        SoC Team <soc@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/SAMSUNG EXYNOS ARM ARCHITECTURES" 
        <linux-samsung-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        gongruiqi1@huawei.com, wangweiyang2@huawei.com
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:RXEaeH3nBegkLgZfgx9t7rLv38M8HHElpuZdzHblYHKxPP9a4OX
 BBP1OSZ6a7tf3Iyc1vticcuiLajy/qzjxS0mtvJW6/rSxYdG7267ONfLaePEPi/NKPkjkVL
 KxBqFev5ALDQ0QPgdTkmApRbaRTG2A5QGVUGtERp3AEnunyUpeH9z3z+1rOkaBHGwir4Sq4
 HDIF/rXTSWb48a0CHD1vA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:BqzGCKWClw4=:wNKDXLu15+S1DvrVALIeKB
 KrNXXUahM8FWa4FlF2xZNmU4BJEA0nZMEkCoYN5Y2tGMutQNTDBqee+kni0eLLkh9KmRSKrg3
 9BpHjOrq+kxEnX+GjkNV3hK7IJJsHkJAD1gJbIvUe8ge2bTAsxNyRUh6Ec0Q1aoXYjrUeQUaD
 7BZP7SujEP++has03OTePNDikM2WX/s+6pYzna6sjWjbcVArX/fGfYk/lNAuo3iIWxosUTCaP
 vttrT8Krc1S/M5aLNXlyfcGgHfVARtt69n2HQGx1VWLZl1hmjEC3lnzKCHECPsd+EkzXQlYCn
 +PDbY74CqUmfp/QLG8slqqinz0gu5tfaIgwBarrQsAmPPnUMZ3E8O54KGfondtV78tt8l/ivk
 tUnc08WsGTlCq6cPNjOQgoWevlTBybMj0wUzoIV9BRvmM0FKI8uIO41v80BPPfppY6ngI0ZOp
 lERRJ8/Lluvb5QAdZvvzeP28UctvlneskNkoCml40kGzTdAd+/ULauIP0NyvYLVP0O+KM3Fzq
 Cu3jVOm9BJoketLZR2DxRaEatABqq2hdg9fpEJmhZgX42EToBe1SC1jg5NV7HqA5zvmGdBaUX
 UDa1eB2WVNAV+qGaCvLqAh9xRfupcyrUj6rNTlUjnjFbQMuD9Y9d45XHAlEOIvPBdLHLBfYox
 tLE6E03u48xAGZsu78SWBtcbx1dHnm/vFabISe5P+HfRNriyEvgIGFlrHi+xGMjubNnjCXGrr
 CUHWqQYE7mTt7pIsNReK+FRqVvL/nHMKS8b0KFOh/RQhfTmebeUVS2dzduHlRBXXzAAVhp1PZ
 9NBquEv0WrWkLlZTZ+V6dUtcqO1pymf5EsqDpN8wGW12LVQM+8=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2021 at 2:41 AM cuigaosheng <cuigaosheng1@huawei.com> wrote:
>
> > I could apply them directly with the maintainer Acks, but I don't understand
> > the significance of you sending them now. Is something broken without the
> > three patches? Are these the only ones missing from Ard's original series,
> > or is this preparation? Would you expect the patches to get backported to
> > stable kernels?
>
> Thanks for your reply.
>
> This is preparation work for arm32 kaslr,and I want to continue to improve
> the solution based on the work of Ard. These patches are relatively
> independent, so I submit these patches first.

The approach of merging support incrementally is good in principle, but in this
case I think we first need to agree on the overall direction first.
How far have you
come rebasing Ard's patches, do you have KASLR working yet? This is information
that should go into the [PATCH 0/3] cover letter.

Do you have a particular target platform in mind?

I think for CPUs that can use LPAE, we want to eventually move to the 4G:4G
memory model, which in turn depends on having the kernel in vmalloc space, as
implemented by Linus Walleij in
https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git/log/?h=kernel-in-vmalloc-v5.14-rc1

With this work, the randomization will look quite different, on the one hand it
leaves less room for relocating the kernel within the smaller 256MB vmalloc
space, while on the other hand it does open the possibility of complete
randomization by scrambling the virt-to-phys mapping in vmalloc space,
using linear virtual addresses to refer to a randomized set of
physical addresses.
(this is just a wild idea that one could implement, nobody has actual plans for
it at the moment, and it comes with additional runtime overhead).

        Arnd
