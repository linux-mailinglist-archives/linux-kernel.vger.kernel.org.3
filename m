Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 633E0509A31
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 10:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386453AbiDUIIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 04:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355609AbiDUIIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 04:08:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35E3C1401F;
        Thu, 21 Apr 2022 01:05:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BDA1AB82325;
        Thu, 21 Apr 2022 08:05:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FA6DC385AF;
        Thu, 21 Apr 2022 08:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650528329;
        bh=pEk2DBnIt9rk2wabkGdOd9ccO0Sp1aN2SsNNj0MBRog=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qWPM0VbCaFTCX7EfkRcA/rtW+syvpvauja9jw25voq6ipQfgeRSOI8QUgToJUNmSz
         OKn+BpJ7yAh+6LD2DtMs+LSIbUdCRp6H6euZbGvUFYkZwrKj22SIgqER2cZs6XltKG
         uftD/9TJgk67j0lF3y11+P7IMrq1mDd8xrKUB6u/Y9WwEa3rdBNgqUdZzQma0dy0CI
         790z77c82J7gC3xpwqTV0fFgHJcAa9+osqbFiqkFNA6wIBW3hjuispqAohUPdowc1D
         F0hBhNuydvq2NiVaV67w1yhkK86x6ydkV9tieQgzUuz+QBueVLbjesjV06o9inYPpk
         zk1SrHXiJ36Lg==
Received: by mail-wr1-f53.google.com with SMTP id i20so5462547wrb.13;
        Thu, 21 Apr 2022 01:05:29 -0700 (PDT)
X-Gm-Message-State: AOAM533q5Qc79/Cz4WoXgzPtxaOQAVT1PqJZE6eGvRn5ic+e4K6Dsvl3
        PnJfunVG594h5V6UllLmTKbVRvKFAfm/3/yF0jI=
X-Google-Smtp-Source: ABdhPJywpA6fOGw9KAZbIcns13/kEE7+YRmRr2P9g6saD61ZSVU9a6gQSpL63u+tG5iSukB8FNVqJ9kAQ9Wk1V6Tp0I=
X-Received: by 2002:adf:e106:0:b0:20a:b31b:213d with SMTP id
 t6-20020adfe106000000b0020ab31b213dmr3969063wrz.219.1650528327698; Thu, 21
 Apr 2022 01:05:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220421074204.1284072-1-hch@lst.de> <20220421074204.1284072-7-hch@lst.de>
In-Reply-To: <20220421074204.1284072-7-hch@lst.de>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Thu, 21 Apr 2022 10:05:11 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3BD5zLiXf=Wr0kcJp-k3+vmhBkEP5DNRw_-H=OX9CoGA@mail.gmail.com>
Message-ID: <CAK8P3a3BD5zLiXf=Wr0kcJp-k3+vmhBkEP5DNRw_-H=OX9CoGA@mail.gmail.com>
Subject: Re: [PATCH 6/7] ARM: use the common dma_to_phys/phys_to_dma
 implementation where possible
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
> Only the footbridge platforms provide their own DMA address translation
> helpers, so switch to the generic version for all other platforms, and
> consolidate the footbridge implementation to remove two levels of
> indirection.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

> ---
> @@ -335,17 +336,19 @@ unsigned long __bus_to_virt(unsigned long res)
>         return res;
>  }
>  EXPORT_SYMBOL(__bus_to_virt);
> -
> -unsigned long __pfn_to_bus(unsigned long pfn)
> +#else
> +static inline unsigned long fb_bus_sdram_offset(void)
>  {
> -       return __pfn_to_phys(pfn) + (fb_bus_sdram_offset() - PHYS_OFFSET);
> +       return BUS_OFFSET;
>  }
> -EXPORT_SYMBOL(__pfn_to_bus);
> +#endif /* CONFIG_FOOTBRIDGE_ADDIN */

I have an older patch to remove CONFIG_FOOTBRIDGE_ADDIN
completely, as it does a couple of other nasty things and there are
apparently no users. Would that help here?

       Arnd
