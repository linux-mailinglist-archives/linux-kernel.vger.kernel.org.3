Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5462C509A24
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 10:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386338AbiDUIEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 04:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344890AbiDUIEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 04:04:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D06C11A811;
        Thu, 21 Apr 2022 01:01:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8130CB822BC;
        Thu, 21 Apr 2022 08:01:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EA28C385AA;
        Thu, 21 Apr 2022 08:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650528073;
        bh=ifEFSZv1UM5fIRCyiaGc43+OrGh0I0CVrDw1Pe824tk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Jxw9n3090AL4dD2aIROf5ZASfrb4qGnMntHn9OV0MR3E9rF8iS1w32M8y0P+QTcQB
         f8BJooistAMxQF1cKz6Xn8LnCNe5de8pFPCR2vro3T9tVXXcTHTSuO+o6QvnooXcCy
         e07OjhCpum5gCdaLxthe0DzzgxJlv3WJHKinRs5rQTvVXPndDQiS2Q7r5qlxrMnSZk
         7mVLL6AT8WNyDR10Aj9stFSpOIP1GHwnoTZS+ZJK2cPkljol0G9qi9JKM1ufXjjXPp
         gilVv7PAj5XWmpwXB8kTWVl9OZyxhM8EbxZ27wzwbyb4wKnqArq5ti9OGnuiWd9fTY
         EJpYiYBngAQfA==
Received: by mail-wm1-f50.google.com with SMTP id u17-20020a05600c211100b0038eaf4cdaaeso5306699wml.1;
        Thu, 21 Apr 2022 01:01:12 -0700 (PDT)
X-Gm-Message-State: AOAM530WW0qI86a6L0HLOK/KkpZ6YM2gmfnmP7to8TBgP5eOkjJcAIiE
        c287eNqISruoq32nWnFU7jb5cjqE6GjclfO4qD8=
X-Google-Smtp-Source: ABdhPJzqgi7L5ALaCLdUcSpoT2Nq18aUkuxmUof0UjJFR0/s3eAKaJPqD7JeGsY3967XuokcLCyC0mVbOg8OIiR57g4=
X-Received: by 2002:a1c:f219:0:b0:38c:782c:3bb with SMTP id
 s25-20020a1cf219000000b0038c782c03bbmr7185525wmc.94.1650528071363; Thu, 21
 Apr 2022 01:01:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220421074204.1284072-1-hch@lst.de> <20220421074204.1284072-5-hch@lst.de>
In-Reply-To: <20220421074204.1284072-5-hch@lst.de>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Thu, 21 Apr 2022 10:00:55 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2zSZsiq_FFHJMHex6uLc_7sUfvns8W8-mE52yzxOqhKw@mail.gmail.com>
Message-ID: <CAK8P3a2zSZsiq_FFHJMHex6uLc_7sUfvns8W8-mE52yzxOqhKw@mail.gmail.com>
Subject: Re: [PATCH 4/7] ARM: remove the unused virt_to_dma helper
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
> Signed-off-by: Christoph Hellwig <hch@lst.de>

I generally prefer to have at least something useful in the description, e.g.
why it's now unused and what it was used for before.

> -static inline dma_addr_t virt_to_dma(struct device *dev, void *addr)
> -{
> -       if (dev)
> -               return pfn_to_dma(dev, virt_to_pfn(addr));
> -
> -       return (dma_addr_t)__virt_to_bus((unsigned long)(addr));
> -}

I think __virt_to_bus() is now unused as well and could be removed
in the same step.

It looks like __bus_to_virt() is still used in the ISA DMA API, but
as that is only used on footbridge and rpc, the generic version of
that could be moved into rpc (footbridge already has a custom
version).

    Arnd
