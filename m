Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA2B509A62
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 10:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386489AbiDUINf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 04:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386526AbiDUIM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 04:12:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 955FC6398;
        Thu, 21 Apr 2022 01:10:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4E69EB8233C;
        Thu, 21 Apr 2022 08:10:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EA53C385B7;
        Thu, 21 Apr 2022 08:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650528605;
        bh=/W8IliiCajYPso0oJDKeh6+LCmFpM9Iq4B+vqL+KHZ4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UtxzIvoNdabVELeWIz3V4TclK6xXmq9BMhzfujlm+gFWBoT8rY4aF9GfRX2ccT1vn
         wDcqT+y+x552llxpM0QL7xb0FLdoLZIo54LK520enQwUc0BbOcQrzNYQiwfY0jTUpi
         4qNX03YnasClaEAYsxgd8xc9OOZJfmG9mYcvjA+pDQdP70iw48miJ+2lz2WSgyuBbq
         tmIpimyZgrqkiOqSIOS0XySlX/JLBOUliDNfhAYHogz26OJgf2EClSsKjy3h8/tJZB
         X4KNgNCuxEid0pr34FAxb4UcPVrvYQRtv4HO3faFNFitLqqrQosV4+qH8YLlMGH9LJ
         cYb7+DzLwXx7g==
Received: by mail-wr1-f41.google.com with SMTP id x18so5538452wrc.0;
        Thu, 21 Apr 2022 01:10:04 -0700 (PDT)
X-Gm-Message-State: AOAM532gQMIQslZvDRR/JDrpCg7+UnB5TuMBR/wPI+cl36iApq4b3aAc
        1BMSjNNEWyVyaARlUmKsGksttyissLHt1+hFBjU=
X-Google-Smtp-Source: ABdhPJw9RSqdGWpafgMW97qQu7yaTHgV5jKD56P0eBxUAQhkvQ6X95c920XjmeJj56kP8+QCXLYB93ISvku4scoF6r4=
X-Received: by 2002:a5d:6389:0:b0:207:a7d8:2b64 with SMTP id
 p9-20020a5d6389000000b00207a7d82b64mr18151004wru.12.1650528603264; Thu, 21
 Apr 2022 01:10:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220421074204.1284072-1-hch@lst.de> <20220421074204.1284072-8-hch@lst.de>
In-Reply-To: <20220421074204.1284072-8-hch@lst.de>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Thu, 21 Apr 2022 10:09:47 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3Y9F8Xb-uON8b+X5bUW9BeWkb6dBuXvdkhL4g15+7_uQ@mail.gmail.com>
Message-ID: <CAK8P3a3Y9F8Xb-uON8b+X5bUW9BeWkb6dBuXvdkhL4g15+7_uQ@mail.gmail.com>
Subject: Re: [PATCH 7/7] ARM: use dma-direct unconditionally
To:     Christoph Hellwig <hch@lst.de>
Cc:     Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 9:42 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Use dma-direct unconditionally on arm.  It has already been used for
> some time for LPAE and nommu configurations.
>
> This mostly changes the streaming mapping implementation and the (simple)
> coherent allocator for device that are DMA coherent.  The existing
> complex allocator for uncached mappings for non-coherent devices is still
> used as is using the arch_dma_alloc/arch_dma_free hooks.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/arm/Kconfig                   |   4 +-
>  arch/arm/include/asm/dma-mapping.h |  24 --
>  arch/arm/mach-highbank/highbank.c  |   2 +-
>  arch/arm/mach-mvebu/coherency.c    |   2 +-
>  arch/arm/mm/dma-mapping.c          | 365 ++---------------------------
>  5 files changed, 19 insertions(+), 378 deletions(-)
>  delete mode 100644 arch/arm/include/asm/dma-mapping.h

The diffstat looks really nice!

I can't really tell from looking at the code if this is an equivalent
conversion,
so I have to trust you on that. I did make sure this passes the basic tests
on kernelci.org, which tests a large number of machines, which is a good
sign.

Tested-by: Arnd Bergmann <arnd@arndb.de>
