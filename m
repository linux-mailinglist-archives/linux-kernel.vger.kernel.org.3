Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD134A6100
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 17:08:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240850AbiBAQIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 11:08:36 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:41878 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234704AbiBAQId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 11:08:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 789726150D;
        Tue,  1 Feb 2022 16:08:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCCFFC340EB;
        Tue,  1 Feb 2022 16:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643731712;
        bh=LYkQIZRdd7F2uIoAPFnJqBxGFTDPHifWmC0kphwydIk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Mc44WwDdggfnOKb2YcVDXJjFUYp3qUUF3GymEtcwPk4DR2XktERGmIh5XV2Xu4ARi
         /oPUn4Ebfzwl7/V2qnocj8ywsSpMjEWqG/C2uo5xtquj8kHp098+iujuFTNGcDZKUD
         DxWzGpc8dCRdm2Rn89oo3vViy1DN5vNw8eyZTrQT2ssMCeEmFKbjew1We8Ny16jEvf
         ryfA4LLaXxS2PYwmF9wc32w2fkJ9+Fsc1c5ab/N7V15l5Waz/WEd0qw0NfzZlRJroN
         yMRsCoeduUd5AQ+wl0Lqg4YDReQdyNgUYuQ47mSc25XeQphfxQkD8AtP4Q6aofi/KA
         eCuh+9rDUiC/A==
Received: by mail-oi1-f182.google.com with SMTP id e81so34198418oia.6;
        Tue, 01 Feb 2022 08:08:32 -0800 (PST)
X-Gm-Message-State: AOAM533Y+GKlaqLRrxpgLTsPuEUJe8Lur0/Tbw8CP8zxug4Db56lIk3X
        SstTk4tprjUvgQ0taLZN2d/YoKsji+Uet48JtCU=
X-Google-Smtp-Source: ABdhPJwGwRRmdd4QCEB6IP8oQPo2IqFKHmeSL4cqMhkamDEclF2NS8VqdEVXFb+FteZjR4DIcDqjJbmNSCUC3lMBNLk=
X-Received: by 2002:a05:6808:1a26:: with SMTP id bk38mr1636034oib.291.1643731712169;
 Tue, 01 Feb 2022 08:08:32 -0800 (PST)
MIME-Version: 1.0
References: <20220201150339.1028032-1-arnd@kernel.org> <YflSNQQvignxL4PA@rowland.harvard.edu>
In-Reply-To: <YflSNQQvignxL4PA@rowland.harvard.edu>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 1 Feb 2022 17:08:15 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1DghU4fm_6OA8=_SG_ODYsnrw0J_Z-kmC9ay1hH=Gqwg@mail.gmail.com>
Message-ID: <CAK8P3a1DghU4fm_6OA8=_SG_ODYsnrw0J_Z-kmC9ay1hH=Gqwg@mail.gmail.com>
Subject: Re: [RFC] ARM: sa1100/assabet: move dmabounce hack to ohci driver
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Russell King <linux@armlinux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Christoph Hellwig <hch@infradead.org>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        USB list <linux-usb@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 1, 2022 at 4:31 PM Alan Stern <stern@rowland.harvard.edu> wrote:

> > diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
> > index 3c7c64ff3c0a..5f2fa46c7958 100644
> > --- a/drivers/usb/core/hcd.c
> > +++ b/drivers/usb/core/hcd.c
> > @@ -1260,7 +1260,8 @@ void usb_hcd_unlink_urb_from_ep(struct usb_hcd *hcd, struct urb *urb)
> >  EXPORT_SYMBOL_GPL(usb_hcd_unlink_urb_from_ep);
> >
> >  /*
> > - * Some usb host controllers can only perform dma using a small SRAM area.
> > + * Some usb host controllers can only perform dma using a small SRAM area,
> > + * or that have restrictions in addressable DRAM.
>
> s/that //
> s/in/on/

Fixed now.

> Otherwise the USB parts of this look okay to me.  I don't have suitable
> hardware to test either.  (I wonder if anyone is still using this
> platform...)

I assumed Russell was still using the Assabet, but his last upstream
commits for sa1100 are from 2016 (merged in 2019), so that may have
changed in the meantime.

> Acked-by: Alan Stern <stern@rowland.harvard.edu>

Thanks!

       Arnd
