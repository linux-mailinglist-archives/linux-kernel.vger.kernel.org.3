Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 839B5569C96
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 10:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235162AbiGGIGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 04:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235149AbiGGIGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 04:06:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E21425C5;
        Thu,  7 Jul 2022 01:06:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2D58F61F9D;
        Thu,  7 Jul 2022 08:06:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E9C4C341CA;
        Thu,  7 Jul 2022 08:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657181161;
        bh=sfmXV4tMP+5FC7d+XgMFdRmfqhgCRC6kI6KR1vW5czg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GAgMo0gS3gmNmDLrfo5hXZRhjDRnB0z6u0nQIlAHcNkUohsekUOT0arnNzkJk0PeJ
         kiqvBbCCzpBZL91oWmRGYLhpwDY11jb6Z0rq5NZLwG8Hxv5Kwiw15K/zqV4hWGP/Ta
         zxi3FIh5nbchm9t1YsRRUpPMK76SGBxSxqqqPZUGzp6nBJk9OwL5Y8aXFWn8NohlQb
         X4Ih/hMPHwvhp6nrcI8M1tIMm3zt2XpD/4IXyn7659xU16Fb6aIhppwPfVhWqnlFIK
         di8tTm83tOh09lNCQWY33uWGXxYdoYSNS/knPLKbFV5MUb1ypI/CG6QUgImE7U+hWb
         mgNcvFDiEyjNA==
Received: by mail-yb1-f169.google.com with SMTP id 76so15612381ybd.0;
        Thu, 07 Jul 2022 01:06:01 -0700 (PDT)
X-Gm-Message-State: AJIora9VSQIqnrJe48vZNHeihtCRv1YXzXLElTn1KlYTFsnQBpsGLgGL
        1nttSYtnpPDb4IswdFdN8szFaeOY8gSKsWYvhXE=
X-Google-Smtp-Source: AGRyM1vWsB1m06E0i839p0o7wq8aG5nv0UEyiO+bhht+9D2f833cmH7AafXMl6w9gYbck24GPqPDrwirxb/5d2EjiFU=
X-Received: by 2002:a25:9f87:0:b0:669:4345:a8c0 with SMTP id
 u7-20020a259f87000000b006694345a8c0mr48554733ybq.472.1657181160664; Thu, 07
 Jul 2022 01:06:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220614092047.572235-1-hch@lst.de> <20220629062837.GA17140@lst.de>
 <Yrv0HLSj3xAHa+av@kroah.com> <20220707045840.GA12672@lst.de>
In-Reply-To: <20220707045840.GA12672@lst.de>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Thu, 7 Jul 2022 10:05:43 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1VFhruH=DVLtL7u5JhH9ayCxrKyNb23qsAR4JBLvrD4Q@mail.gmail.com>
Message-ID: <CAK8P3a1VFhruH=DVLtL7u5JhH9ayCxrKyNb23qsAR4JBLvrD4Q@mail.gmail.com>
Subject: Re: fully convert arm to use dma-direct v3
To:     Christoph Hellwig <hch@lst.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 7, 2022 at 6:58 AM Christoph Hellwig <hch@lst.de> wrote:
> On Wed, Jun 29, 2022 at 08:41:32AM +0200, Greg Kroah-Hartman wrote:
> > On Wed, Jun 29, 2022 at 08:28:37AM +0200, Christoph Hellwig wrote:
> > > Any comments or additional testing?  It would be really great to get
> > > this off the table.
> >
> > For the USB bits:
> >
> > Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>
> So given that we're not making any progress on getting anyone interested
> on the series, I'm tempted to just pull it into the dma-mapping tree
> this weekend so that we'll finally have all architectures using the
> common code.

Yes, please do!

Getting it into linux-next now should give plenty of time to test it
with the automated kernelci and lkft systems, as well as Russell's
Assabet. I'm sure we can fix up any regressions before this actually
hits the 5.20 release.

         Arnd
