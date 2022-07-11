Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54B3B57044C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 15:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbiGKN2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 09:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbiGKN2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 09:28:33 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1EB62A1;
        Mon, 11 Jul 2022 06:28:30 -0700 (PDT)
Received: from mail-yb1-f179.google.com ([209.85.219.179]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MYvTs-1o6XqW30Ea-00UrBn; Mon, 11 Jul 2022 15:28:28 +0200
Received: by mail-yb1-f179.google.com with SMTP id 136so8702910ybl.5;
        Mon, 11 Jul 2022 06:28:28 -0700 (PDT)
X-Gm-Message-State: AJIora8/07Fi0AK3My1PcDQ+TuBbfoqJk6TSbNswul3PjAZ2+mc4wjqW
        nXXpMixeBeSiSzMNEu00oTlB7sy6vht+6kfKdUA=
X-Google-Smtp-Source: AGRyM1tsgjPLvmdsKdhCjHhwVT/DGz5LvpuJARa/rcGFyR6GoB47NyvjUek7fj/VgODmbrjEk5fFlBVA4dyEtxUAY30=
X-Received: by 2002:a5b:b47:0:b0:66e:3617:d262 with SMTP id
 b7-20020a5b0b47000000b0066e3617d262mr16426044ybr.106.1657546107384; Mon, 11
 Jul 2022 06:28:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220711122459.13773-1-me@linux.beauty> <20220711122459.13773-5-me@linux.beauty>
In-Reply-To: <20220711122459.13773-5-me@linux.beauty>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 11 Jul 2022 15:28:10 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2Mr0ZMXGDx6htYEbBBtm4mubk-meSASJjPRK1j1O-hEA@mail.gmail.com>
Message-ID: <CAK8P3a2Mr0ZMXGDx6htYEbBBtm4mubk-meSASJjPRK1j1O-hEA@mail.gmail.com>
Subject: Re: [PATCH 4/4] sample/reserved_mem: Introduce a sample of struct
 page and dio support to no-map rmem
To:     Li Chen <me@linux.beauty>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Li Chen <lchen@ambarella.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:v2NDaS4hdT01Tjkly3eBikHu19HKS9zqN4ejyDTrA05Z0rRxNN4
 iYopIHbVnVMvevWFz3J2WZhu1OoAs2JFS/1evp6XJg6P5jPZtWAorMglwwctaIzG8RbWqEP
 DnLsPWUizUZdkZXojz9P3e8fHNZ2T8EfR8s3GRcrvAckCyhzibAh9dlJ7f5oNWkxV/H1INv
 2ZXwYPfJ6ssgsAEs9iL0w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:iDmhkX6mdWU=:Fej3xj/jk+VLvNp/A9rg++
 yJ+MK5GGih77Q8agP+IBSuvWykCgsg6JAQwM2WiQHzBh2PI48U/oZBBbP9+V5mDMDvtDMpcIj
 B3lWb1uKHiRi/snfa+ToE5Ej0t922r6JzkJrPrEYkDQh8zVA2eh1rceX9UAVWV36XbZKo2f3n
 6WTVRDexHoOLxqw5/Z73l4UnDn/KvPp/NpuUHwA9TWCUMUNCxxNJYVqYSV/+KOEDvFnnO80U7
 4GN1Gg0NfzOvIxE6dIJo8xugfA8j6DYqysjFdaIeXNvDJkpWrweVmdhldH+P4lT6M/3wpXVCW
 lrFF/cmRzTnSIZOY7Ulu/dQlO0MRWQZzG4XwIMYqN+bVF8/cmkudSxBSSykhSY/EKqYkHpZ/n
 SzIidj9L8yU9BbaX2NonwLFRer/MUrgdkRPLmQ9+8ITrsgltEKwD0FM2WP2wvRdsIhRPvAPzb
 tQfBm0gUL0pbFywU7CoXJ866m1GGCnU/pLa4mVOBkmnGueQ56n8bFmD0O4Z6/lBOwzXSNnkue
 wGW7bx/q9mUXzFJnbFf73ugFF0PrbMQv/ZNtR9oMT7ybwowmDX19s6ITFFoulxta3/QdcRxbG
 bEt9lb57eQ1jASVhZjAMcXrL1IczTQv9iwIy2e/JJPl0hviu1nEo7mQFmN47MHQDzOn6lnODi
 ck/aXxJ6GsYgUPm30g5uSYBL/C1/2tMlTYhai+Yz/lZiiURNv2oxNBzpfWTz0ath/0BZ9GXC6
 K5cov5ee+sfeGJLe/zptOEPX7tFbX/xGxX1iZQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 11, 2022 at 2:24 PM Li Chen <me@linux.beauty> wrote:
>
> From: Li Chen <lchen@ambarella.com>
>
> This sample driver shows how to build struct pages support to no-map rmem.
>
> Signed-off-by: Li Chen <lchen@ambarella.com>

Not sure what a sample driver helps here if there are no actual users in-tree.

It would make more sense to merge the driver that wants to actually use this
first, and then add the additional feature.

> Change-Id: Ie78494fa86fda40ceb73eab3b8ba505d0ad851a1

Please drop these lines, the Change-Id fields are useless in a public
repository.

> +/*
> + * dts example
> + * rmem: rmem@1 {
> + *                     compatible = "shared-dma-pool";
> + *                     no-map;
> + *                     size = <0x0 0x20000000>;
> + *             };
> + * perf {
> + *             compatible = "example,rmem";
> + *             memory-region = <&rmem>;
> + *     };

The problem here is that the DT is meant to describe the platform in an OS
independent way, so having a binding that just corresponds to a user space
interface is not a good abstraction.

> +       vaddr = reserved_mem_memremap_pages(dev, rmem);
> +       if (IS_ERR_OR_NULL(vaddr))
> +               return PTR_ERR(vaddr);

 Using IS_ERR_OR_NULL() is usually an indication of a bad interface.

For the reserved_mem_memremap_pages(), you should decide whether to return
NULL on error or an error pointer, but not both.

       Arnd
