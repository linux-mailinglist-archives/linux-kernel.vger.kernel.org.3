Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9953D4A8344
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 12:40:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350205AbiBCLjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 06:39:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234997AbiBCLju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 06:39:50 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C64BDC061714
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 03:39:50 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id k25so1902619qtp.4
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 03:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t/FmJ+H6iPvmZzSgzAi6Vzfm5Bl75LQIahcxCaEsuyE=;
        b=P94tOZ+K0B+HU5I2I9P6ymAbTI2GNSrt0XldvVwf0lmQabuky1T+i+dbQqs2NmUdbU
         k8pvA1od8fOQ43PMUWKGFelgDliKuS/NSX3z3JqeVHs/f9Dw3dyS/hEydKaHkJlL1p7o
         kY9d2lpNwPl9sAjNtLZNQnt6oyKrd3UlZ+aos=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t/FmJ+H6iPvmZzSgzAi6Vzfm5Bl75LQIahcxCaEsuyE=;
        b=Bi8Rk6Rg7LL1NyXrwF+8q3G8ernJ705njz5JnYNS9lj64YPIpNH+BvkHp8dnuqwsYq
         wmSeYpZrCL0ozBQpj0CiMQEySH/jh17QwgcKbwyL2OS+P57VE5UjZEQsqEgtp5qxVEtm
         w704QiWCvl5NML2Dh+yA6ytqUQOoGjTx4de3GSUGAc9ukgHKViaYK/UiUVwgOEJ6lIRh
         abUdJa0lQK3QTt1bN3aJRFnt8BYM4TUTlRbX590YQRmgWC4N5AlVY4SbwwKqBeEuKto1
         SobJzGuKezfFwQbQwqfclNQeMII9aZ2HPq4gvXZ1QibneHO+OL5qgpt94q4vyn8zrWiv
         CYVw==
X-Gm-Message-State: AOAM531AMcNiNmSpTnwalNVvQbbOjiJXjQqOlTTzv+GksN6h1XspOYFD
        ioHlfJtJVX/W+zmJsEh905y0D18vjDwsPBr0wr7jIbwi
X-Google-Smtp-Source: ABdhPJxRb/JyUozYSYKLFLDaIbQz9iHfeo6RHF4VQC9PTd8qJYKFSk2SQWVOIjoFfpGT/Rr3BktnRlrOxYI4t86ps7w=
X-Received: by 2002:ac8:5a93:: with SMTP id c19mr26756233qtc.58.1643888389787;
 Thu, 03 Feb 2022 03:39:49 -0800 (PST)
MIME-Version: 1.0
References: <20220201050501.182961-1-joel@jms.id.au> <20220201050501.182961-3-joel@jms.id.au>
 <YfjyNo5wBPs16vkz@kroah.com>
In-Reply-To: <YfjyNo5wBPs16vkz@kroah.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Thu, 3 Feb 2022 11:39:38 +0000
Message-ID: <CACPK8XcYFZUtw_-8A5hzT0dYqtnifuFOf7qoER0YVsbCsReH8A@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: aspeed: Add secure boot controller support
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Andrew Jeffery <andrew@aj.id.au>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Ryan Chen <ryan_chen@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Feb 2022 at 08:41, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Feb 01, 2022 at 03:35:01PM +1030, Joel Stanley wrote:

> > --- a/drivers/soc/aspeed/aspeed-socinfo.c
> > +++ b/drivers/soc/aspeed/aspeed-socinfo.c
> > @@ -8,6 +8,9 @@
> >  #include <linux/platform_device.h>
> >  #include <linux/slab.h>
> >  #include <linux/sys_soc.h>
> > +#include <linux/firmware_bootinfo.h>
> > +
> > +static u32 security_status;
> >
> >  static struct {
> >       const char *name;
> > @@ -74,6 +77,83 @@ static const char *siliconid_to_rev(u32 siliconid)
> >       return "??";
> >  }
> >
> > +#define SEC_STATUS           0x14
> > +#define ABR_IMAGE_SOURCE     BIT(13)
> > +#define OTP_PROTECTED                BIT(8)
> > +#define LOW_SEC_KEY          BIT(7)
> > +#define SECURE_BOOT          BIT(6)
> > +#define UART_BOOT            BIT(5)
>
> Where do these bits come from?

They are taken from the datasheet.

> > +     pr_info("AST2600 secure boot %s\n",
> > +             (security_status & SECURE_BOOT) ? "enabled" : "disabled");
>
> When all is good, no need to print anything out.

We had some back and forth on this in an earlier iteration of this change:

 https://lore.kernel.org/all/57584776-06e7-0faf-aeb2-eab0c7c5ae1f@molgen.mpg.de/

It boils down to what is "good"? The system is fine if it is not
provisioned with secure boot keys, if that's the intent of the system
builder.

A similar thing is done for efi secure boot, where it prints out
whether it's enabled, disabled or unable to determine.

I'll send out a v2 that takes on the suggestions you made in the cover letter.

Cheers,

Joel
