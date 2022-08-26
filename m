Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EEF45A2BE9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 18:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241961AbiHZQEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 12:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233247AbiHZQE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 12:04:27 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C74D4779;
        Fri, 26 Aug 2022 09:04:27 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id j1so1384742qvv.8;
        Fri, 26 Aug 2022 09:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=FeNwIbGSnin/6lpCxdAU71xVZ3XiHSxLN5ZJ0/sc5G0=;
        b=buuUZ0d/2nkVQRZuHDDqYtaT7TzNu324SLpv4R10HSLnwhDQ96WJVTnKtR7zum0t1r
         hqj2e0FMaD6GbufjOJ4k9zx3ZUqUNUUZyPkO0lahpnsaJBBptUclrfCtMuU9efsK6FXO
         2UEynvZ5f62lHMWe/gcTdeOgbu5jBoMFgqkhiTV6KhEUNElx0rs4cVYkE86I1Q4HFjSY
         2R9r/IJTqVgCguPDvErK+IEOMNmyzUp9lN4EC/OHyRu0rlB4wUvg4WTyTGdIRpTn1DGV
         59ibKqH5KGO5FyeGk1djPNZVC5NZe+orkbYsqEKimpJUj6+jVJwK5STuzPRpCpqylF5/
         oWZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=FeNwIbGSnin/6lpCxdAU71xVZ3XiHSxLN5ZJ0/sc5G0=;
        b=y1n6GlnSlLPsYFN2gvFfYfNkD27jqsU8Pb0/u8qdzrksvoGDy3YJDetatJynGl/ZXn
         xLcbmAYvhQhskA/06+33W26/s3n6Zoubkg31U78Gv4sKBxUUQ6Tvo2qlGZK+jvzfRCsv
         CyQfmPuoyFUdN80G5mVD7W+k+AMXbdYtkr5pJ+CK81a7fzXbyKMmEyi655Ygv/vSQ1Wm
         YSTfPQQGhPUF6bFMLxWqEkfQnF8YK0iyYPZniVxGZb+quh+qPy23u9xj/ubjVzgI2H/I
         LbHm30kiNwhH27YI61K9LbKUvOJHERpfZmNH1oHFA3uaH9/uioCq5E0bZEDKFPDsiBDI
         BIyA==
X-Gm-Message-State: ACgBeo0Abu4CPeTfHevSWCJk+Sa4Z4zf7pbnhAviCbcHQ1loYdJkKJ8X
        YzhAByu52P8YIIa/5aBwUogRTeaD0uYdYfjvKjw=
X-Google-Smtp-Source: AA6agR7GxQegK7svGSDjOShs7ExKxeZkw77WPZE227Ogs36elAiNCLBVrcaeegmHRf0Y5x7Clj39vvbXehqfnaKq9E0=
X-Received: by 2002:ad4:5baf:0:b0:476:6a9e:b5e1 with SMTP id
 15-20020ad45baf000000b004766a9eb5e1mr300030qvq.64.1661529866149; Fri, 26 Aug
 2022 09:04:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220825091707.8112-1-ilpo.jarvinen@linux.intel.com>
In-Reply-To: <20220825091707.8112-1-ilpo.jarvinen@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 26 Aug 2022 19:03:50 +0300
Message-ID: <CAHp75VeJ2KR_-JUfW_3LEgB1ezQQzJ_2jLbH8vcWOtTSDAhKdQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] serial: Add uart_xmit_advance() + fixes part (of a
 larger patch series)
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2022 at 12:19 PM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> Add uart_xmit_advance() helper to handle circular xmit buffer
> advancement + accounting of Tx'ed bytes. Use it to fix a few drivers
> that previously lacked to accounting for DMA Tx.

For the whole series
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Thanks for fixing this issue.

> Greg,
> I've a another series on top this which is tty-next material making the
> rest of the drivers to use uart_xmit_advance(). That series obviously
> depends on the patch 1/3 of this series so if you end up putting these
> 3 patches into tty-linus, I'll need it to be merged into tty-next at
> some point (I'm not in a big hurry with this so if you choose to delay
> the merge, it's not a big deal).
>
> Ilpo J=C3=A4rvinen (3):
>   serial: Create uart_xmit_advance()
>   serial: tegra: Use uart_xmit_advance(), fixes icount.tx accounting
>   serial: tegra-tcu: Use uart_xmit_advance(), fixes icount.tx accounting
>
>  drivers/tty/serial/serial-tegra.c |  5 ++---
>  drivers/tty/serial/tegra-tcu.c    |  2 +-
>  include/linux/serial_core.h       | 17 +++++++++++++++++
>  3 files changed, 20 insertions(+), 4 deletions(-)
>
> --
> 2.30.2
>


--=20
With Best Regards,
Andy Shevchenko
