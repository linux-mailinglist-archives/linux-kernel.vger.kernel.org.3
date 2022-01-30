Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 861604A3681
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 14:39:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354892AbiA3Njh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 08:39:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354875AbiA3Nje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 08:39:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B08FC061714;
        Sun, 30 Jan 2022 05:39:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 34204611A0;
        Sun, 30 Jan 2022 13:39:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BD33C340E4;
        Sun, 30 Jan 2022 13:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643549973;
        bh=KkkR+/istY01b0m72vBgPpw/mmxq0HitAfAwOrw14G0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=k/pOwp1CYSXv/b6RrMbpU+oC42qDUIC30ikzyLZH1KrDpHgZwkvkWt+bfMkf75X8Q
         qjy4EPx/gZxOjwebzxNaUhwnXoPYanVGl+acHZjBhgNLoLq8pzS+ik/FAw0ZIVLDRO
         mzFnsTJCaGjI00NziFej6N7/6r90CgFh7sXm8aC5eLCXj7DsGNJSTAYb42sRKFzXRo
         a7RD9csYOpnz8/JuXJ0aHXFhkG3u3gPe3WzYnpv7Kx5rSuWiSoZYFphaOrw3GEo7yN
         7UnzeMQbPwJbfnqJD0PXOYmzMpmuCsn94lJVAheU9b0LDa6NtOEByeVKZhuJt2RERN
         0hVySdvX/j7UQ==
Date:   Sun, 30 Jan 2022 13:45:57 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Your Name <you@example.com>,
        Chris Lesiak <chris.lesiak@licor.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] iio: humidity: hdc100x: Add ACPI HID table
Message-ID: <20220130134557.5e211d45@jic23-huawei>
In-Reply-To: <CAHp75VfC873djcc4Z2+HhzR8z3Uaute3g0Fgr1dvOs_v=gD3Lw@mail.gmail.com>
References: <20220128042054.2062060-1-kai.heng.feng@canonical.com>
        <CAHp75VfC873djcc4Z2+HhzR8z3Uaute3g0Fgr1dvOs_v=gD3Lw@mail.gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jan 2022 15:53:11 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Fri, Jan 28, 2022 at 6:21 AM Kai-Heng Feng
> <kai.heng.feng@canonical.com> wrote:
> >
> > x86 boards may use ACPI HID "TXNW1010" for the hdc100x device.
> >
> > TI told us "The ACPI ID for TI is: https://uefi.org/node/1028 (TXNW),
> > therefore it would most likely be appropriate to use TXNW1010."  
> 
> So, they basically agree on using it, did I get it right?
> 
> > So add an ACPI match table for that accordingly.  
> 
> Assuming TI is aware of the ID,
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
With that assumption I'm applying this to the togreg branch of iio.git which
will be pushed out as testing for 0-day to take a look at.

Still time to pull it out before I push this out as non rebasing if
we have misunderstood the above.

Thanks,

Jonathan

> 
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > ---
> > v3:
> >  - Add info from vendor
> >  - Drop redundant line and comma.
> >  - Wording change.
> >
> > v2:
> >  - Change the ID to follow ACPI Spec
> >  - Add __maybe_unused to avoid compiler warning
> >
> >  drivers/iio/humidity/hdc100x.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/drivers/iio/humidity/hdc100x.c b/drivers/iio/humidity/hdc100x.c
> > index 9e0fce917ce4c..47f8e8ef56d68 100644
> > --- a/drivers/iio/humidity/hdc100x.c
> > +++ b/drivers/iio/humidity/hdc100x.c
> > @@ -417,10 +417,17 @@ static const struct of_device_id hdc100x_dt_ids[] = {
> >  };
> >  MODULE_DEVICE_TABLE(of, hdc100x_dt_ids);
> >
> > +static const struct acpi_device_id hdc100x_acpi_match[] = {
> > +       { "TXNW1010" },
> > +       { }
> > +};
> > +MODULE_DEVICE_TABLE(acpi, hdc100x_acpi_match);
> > +
> >  static struct i2c_driver hdc100x_driver = {
> >         .driver = {
> >                 .name   = "hdc100x",
> >                 .of_match_table = hdc100x_dt_ids,
> > +               .acpi_match_table = hdc100x_acpi_match,
> >         },
> >         .probe = hdc100x_probe,
> >         .id_table = hdc100x_id,
> > --
> > 2.33.1
> >  
> 
> 

