Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 397D4527196
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 16:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232918AbiENOKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 10:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbiENOK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 10:10:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0DB412AAB;
        Sat, 14 May 2022 07:10:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B87660EDA;
        Sat, 14 May 2022 14:10:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92CA2C340EE;
        Sat, 14 May 2022 14:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652537424;
        bh=b4Yqu2wA3dN7+oULR9UAd9cblXScNS6iqAVMaDg7EZE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LLwLyTCUREjf9+Z+WNGHiSAxcNJocRVUeO5DWnio4BFZPQrrEJ6MOIEfcMI7OKIh+
         XYntVv8ore/SgqMGkY9jFvD3lWDhLjjOf8XOlfGSiohPUocmHu5L5rr102cwaJwJvS
         mHKXAs4pFU3/vuO0AxHrb15rGc0zSHwG2bYYd2PvVe+iA3B94WPO1rhFya0yPY7Oak
         9MmfivXBU79Np45ScUmdDwtWXtQM+3LgLMpofJHAyU7MhK1h9NqHx1Doyjik84eNj0
         ovChgZ3nN3Goior9c69A90zSerh/BxXuGPOIepf882iro2kQGAzuph5L9y0bVJXi0U
         yq3G+OLeMILwg==
Date:   Sat, 14 May 2022 15:18:59 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     William Breathitt Gray <william.gray@linaro.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        schnelle@linux.ibm.com, David Laight <David.Laight@aculab.com>,
        macro@orcam.me.uk, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 0/8] Utilize iomap interface for PC104 and friends
Message-ID: <20220514151859.692928dc@jic23-huawei>
In-Reply-To: <CAMRc=McAe28ZwcGknzrju-PQTEZ7x2XAfoRyfLFMWpgGB8DVLw@mail.gmail.com>
References: <cover.1652201921.git.william.gray@linaro.org>
        <CAMRc=McAe28ZwcGknzrju-PQTEZ7x2XAfoRyfLFMWpgGB8DVLw@mail.gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 May 2022 14:57:49 +0200
Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> On Tue, May 10, 2022 at 7:31 PM William Breathitt Gray
> <william.gray@linaro.org> wrote:
> >
> > PC104 cards and similar devices do not need to access I/O ports directly
> > via inb()/outb() and can instead use the more typical I/O memory
> > ioread8()/iowrite8() accessor calls by first calling ioport_map(). This
> > patchset converts the relevant PC104/ISA card drivers to do such. With
> > these drivers now utilizing I/O memory accessor calls, work can be done
> > to consolidate some similar devices (e.g. 104-idio-16, pci-idio-16,
> > etc.) into a unified driver in a future patchset.
> >
> > This patchset spawned from a suggestion made in another thread titled
> > "gpio: add HAS_IOPORT dependencies":
> > https://lore.kernel.org/all/c3a3cdd99d4645e2bbbe082808cbb2a5@AcuMS.aculab.com/
> >
> > William Breathitt Gray (8):
> >   counter: 104-quad-8: Utilize iomap interface
> >   gpio: 104-dio-48e: Utilize iomap interface
> >   gpio: 104-idi-48: Utilize iomap interface
> >   gpio: 104-idio-16: Utilize iomap interface
> >   gpio: gpio-mm: Utilize iomap interface
> >   gpio: ws16c48: Utilize iomap interface
> >   iio: adc: stx104: Utilize iomap interface
> >   iio: dac: cio-dac: Utilize iomap interface
> >
> >  drivers/counter/104-quad-8.c    | 169 +++++++++++++++++---------------
> >  drivers/gpio/gpio-104-dio-48e.c |  63 ++++++------
> >  drivers/gpio/gpio-104-idi-48.c  |  27 ++---
> >  drivers/gpio/gpio-104-idio-16.c |  33 ++++---
> >  drivers/gpio/gpio-gpio-mm.c     |  43 ++++----
> >  drivers/gpio/gpio-ws16c48.c     |  65 ++++++------
> >  drivers/iio/adc/stx104.c        |  56 ++++++-----
> >  drivers/iio/dac/cio-dac.c       |  14 +--
> >  8 files changed, 248 insertions(+), 222 deletions(-)
> >
> >
> > base-commit: ce522ba9ef7e2d9fb22a39eb3371c0c64e2a433e
> > --
> > 2.35.3
> >  
> 
> I don't see any dependencies so applied the GPIO part.
Likewise, I've applied the IIO ones. Initially pushed out as testing
to see if 0-day finds any issues. Given timing, we may well be looking
at next merge window now though.

Thanks,

Jonathan

> 
> Bart

