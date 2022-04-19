Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A933506815
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 11:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350440AbiDSJzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 05:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350431AbiDSJzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 05:55:15 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8876C20BFC;
        Tue, 19 Apr 2022 02:52:33 -0700 (PDT)
Received: from mail-wr1-f50.google.com ([209.85.221.50]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MG90u-1nhuC32jIy-00GcBq; Tue, 19 Apr 2022 11:52:31 +0200
Received: by mail-wr1-f50.google.com with SMTP id t1so21684582wra.4;
        Tue, 19 Apr 2022 02:52:31 -0700 (PDT)
X-Gm-Message-State: AOAM532JHFHrFKxAxcbMMCGIHGqaZiIfNYD84DnPtjvVv3f90mdSz7ks
        lTv3KHO3+fVZZiN45Ydt22aiWdYrdcEDZA/YaqM=
X-Google-Smtp-Source: ABdhPJzCXBI+RcttLx9ypMCYJp26DkP98+kkPTFl+n5n/hcn08b2tUYxS4vgAQ33NEwseKjHf7Qbovh8TXElWM6kX8E=
X-Received: by 2002:a5d:6983:0:b0:207:a226:df4b with SMTP id
 g3-20020a5d6983000000b00207a226df4bmr11097055wru.192.1650361951213; Tue, 19
 Apr 2022 02:52:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220415142055.30873-1-sven@svenpeter.dev> <20220415142055.30873-7-sven@svenpeter.dev>
 <20220419053157.GA31530@lst.de> <866f79b1-6c02-4248-ac98-594829fed204@www.fastmail.com>
In-Reply-To: <866f79b1-6c02-4248-ac98-594829fed204@www.fastmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 19 Apr 2022 11:52:15 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2CWZb3vdHQvseJZQwPbUFDRo5Z9aGb7iVgodT1YeB5Yw@mail.gmail.com>
Message-ID: <CAK8P3a2CWZb3vdHQvseJZQwPbUFDRo5Z9aGb7iVgodT1YeB5Yw@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] nvme-apple: Add initial Apple SoC NVMe driver
To:     Sven Peter <sven@svenpeter.dev>
Cc:     "hch@lst.de" <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        Hector Martin <marcan@marcan.st>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <maz@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvme@lists.infradead.org, linux-spdx@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:XMo+Fxs8ep4V8fBgB6R2KXUs6/FrFBHsYrJiuM+O+N73W005nxm
 ZidcQpb9RWcLf+btE5VXWD67zeP58eHKK/fufL2CoQlw5KAD+rKPSJyKrpMgSnMnsdOYjMb
 0Ep31UvS9QRBeRRh62v1LxRypbUoRYVTQGkpeQ237KxH6k7BEgSBRy969Nla2JUn0ika/gy
 /wmtMpCUWYYdF7bXwUmqw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WRARO1r46tU=:u1RlMeIaeFSmOBlNuwDqPT
 D9N7/nRjz57oeMY7TMX55x7aoMOQ3j1OA+/+WcNlpLdqJxYMoPWk+VNwHgAYbayKdBdjXo61w
 310E3DzxUcZh6H/cbXWMzjNbbVbUzwqcn+zoBJTMFN78pRB/FncRo2heV75fWhMBOgCxUtmDB
 KyOKFxWF0l68nfRk/0f68L6OtfGQibaaMc3ah64qnBs3kVSQZmelAkVrtEtQ2lVWsId0ZrbE0
 bXUiwdn2izEsxN3QIRLyZSGsD5tprP3lk8zm+zCBSGim31lIN770kyrWSN5hNS4hbkMKKYVkY
 RfHQMu5bVt+qTKp+4TJBvovDsuJI8DRYd3ocoK8u2qa5flwcOIWuyGywBKC/s1TBO5L0Ts8OX
 GeuMDxVdsSMwJbzMB/xlXgZnp0k1o1qEvW6jGEqTLYs5EcGNN/1z+JQXvi/bgBFRZHggSxOhs
 aOfftIxwHiHFeqsGUWH/JkGHxC82pOAtfSmBbYOcCu2YuPbQbpne6Ew14IK6UA6HVaXkpe6Hi
 7cP4DBlTtkIFk0OdJ834ee2btH+W5lXmHGecdRRHO5Ce9cnQ3wC8NW15th68kQTrCcDTjwXaB
 zpx1xBBLNvZ9HsZv4e3ajHJwfhK9F19mF+57wiZ5S4H1RAl005BImtYDLoBxl8hA3I6txeG2J
 UYR9/wgHBeMMYVYiowRkDe+NhtFsm+Hh9CUxA4o2AiJEeOyI16a2TBmInZvazFeIoCYG9kdiz
 VqTJOWicssnsUwj0DjSISUoflnKel2Rv+cSdlwlnsspvCy4EtGS0/TzP0XBfSg6iplECjRB6u
 cc5a+tLB8fu05Kndsz5mG/3Rfu5T0zblisotT6SkHVEpoQ2mrk=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2022 at 11:47 AM Sven Peter <sven@svenpeter.dev> wrote:
> On Tue, Apr 19, 2022, at 07:31, Christoph Hellwig wrote:
> > On Fri, Apr 15, 2022 at 04:20:55PM +0200, Sven Peter wrote:
> >> +++ b/drivers/nvme/host/apple.c
> >> @@ -0,0 +1,1597 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +/*
> >> + * Apple ANS NVM Express device driver
> >> + * Copyright The Asahi Linux Contributors
> >
> > Is that actually a valid legal entity?
> >
> >> +#include <linux/io-64-nonatomic-lo-hi.h>
> >
> > Does this controller still not support 64-bit MMIO accesses like
> > the old Apple PCIe controllers or is this just a leftover?
>
> I just checked again and 64-bit accesses seem to work fine.
> I'll remove the lo_hi_* calls and this include.

If you remove the #include, it is no longer possible to compile-test
this on all 32-bit architectures, though that is probably fine as long
as the Kconfig file has the right dependencies, like

      depends on ARCH_APPLE || (COMPILE_TEST && 64BIT)

I'd prefer to keep the #include here, but I don't mind the dependency
if Christoph prefers it that way.

       Arnd
