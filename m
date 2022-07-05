Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71DC1566674
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 11:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbiGEJoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 05:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbiGEJoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 05:44:07 -0400
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F8FA25EA;
        Tue,  5 Jul 2022 02:44:06 -0700 (PDT)
Received: by mail-qk1-f169.google.com with SMTP id p11so8250886qkg.12;
        Tue, 05 Jul 2022 02:44:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kIx91exCzZ5dHESFRAFLa43/wrVeA8Y2G2chqGSTvNs=;
        b=EpZ2Ex/ib2/Vbrv07gZ/CbHahTz66tzX9dF3tAhTbRcYAPUpdmcJIK6dIVCfcvmhbR
         oHDSn/FYdeB1oSry0lEI/OsUcCjFifGfKQL/0Al98ZWzKWF4K/KgxV1qkoaACErVXIed
         uDuG1hM9mDhPjzqRg8Z6K3j1XGSHeQkKUMiUy87/5hJ+JCPw0foD/ReAOK1HdUNU2wAX
         id7WTrN/vjNeYAig+aOk+gb5stjpjh29VP7LMAtjq3QXt9MlR+V4a5uCsk9o+M4VLKGX
         4R3j8C2CZVzVR9VbpnxUoAfnDnRNnJIgWIBM+uRBFYPxmzOmwYLGHUOt/kFXI1z9Y4tG
         LOJQ==
X-Gm-Message-State: AJIora+3fAugXz1js8JGgKROdOagnJEq1hs+wcPQvvExREejXy84d94e
        uN59YEVA3boXyf+HKlQ4fylpJNOQFAWWGA==
X-Google-Smtp-Source: AGRyM1u3FwBTKHdTEDRXIccxmWyh3H1KPbcF1VZmA8m2QFBxtT9sCNkP4we9shJ97IcuLXoHs3dJlg==
X-Received: by 2002:a05:620a:4045:b0:6b1:86a9:c78c with SMTP id i5-20020a05620a404500b006b186a9c78cmr21341141qko.580.1657014245205;
        Tue, 05 Jul 2022 02:44:05 -0700 (PDT)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com. [209.85.128.177])
        by smtp.gmail.com with ESMTPSA id m14-20020a05620a290e00b006b46ad28ba7sm3889045qkp.84.2022.07.05.02.44.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jul 2022 02:44:04 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-31caffa4a45so31457157b3.3;
        Tue, 05 Jul 2022 02:44:04 -0700 (PDT)
X-Received: by 2002:a81:5404:0:b0:31c:c24d:94b0 with SMTP id
 i4-20020a815404000000b0031cc24d94b0mr3713401ywb.502.1657014244204; Tue, 05
 Jul 2022 02:44:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220618195031.10975-1-max@enpas.org> <20220627150557.qluqtejrddj5nfif@pengutronix.de>
 <20220627190126.4eb57a2b.max@enpas.org>
In-Reply-To: <20220627190126.4eb57a2b.max@enpas.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 5 Jul 2022 11:43:52 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUYCiRC+9UnQB6-2XGp+wOjYq1U_J3bDQT+WNm==mS4qg@mail.gmail.com>
Message-ID: <CAMuHMdUYCiRC+9UnQB6-2XGp+wOjYq1U_J3bDQT+WNm==mS4qg@mail.gmail.com>
Subject: Re: [PATCH v9] can, tty: can327 CAN/ldisc driver for ELM327 based
 OBD-II adapters
To:     Max Staudt <max@enpas.org>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Wolfgang Grandegger <wg@grandegger.com>,
        linux-can@vger.kernel.org,
        Vincent Mailhol <vincent.mailhol@gmail.com>,
        Oliver Neukum <oneukum@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oliver Hartkopp <socketcan@hartkopp.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Max,

On Mon, Jun 27, 2022 at 7:10 PM Max Staudt <max@enpas.org> wrote:
> On Mon, 27 Jun 2022 17:05:57 +0200
> Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> > On 18.06.2022 21:50:31, Max Staudt wrote:
> > > This is the can327 driver. It does a surprisingly good job at
> > > turning ELM327 based OBD-II interfaces into cheap CAN interfaces
> > > for simple homebrew projects.
> > >
> > > Please see the included documentation for details and limitations:
> > > Documentation/networking/device_drivers/can/can327.rst
> > >
> > > Cc: linux-can <linux-can@vger.kernel.org>
> > > Signed-off-by: Max Staudt <max@enpas.org>
> > > Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> >
> > Added with some minor coding style improvements (line breaks and
> > whitespace changes) to make checkpatch and clang-format happier to
> > can-next/master!
>
> Wonderful, thank you!

Thanks for your patch, which is now commit 43da2f07622f4137 ("can:
can327: CAN/ldisc driver for ELM327 based OBD-II adapters") in
linux-can-next/master

> (+CC: Greg, Oliver Hartkopp)
>
> This quite fittingly marks the end of an era for me, so I would like to
> thank everyone involved, more or less in order of appearance:
>
> Oliver Hartkopp    for slcan (the inspiration) and related feedback.
> Oliver Neukum      for the first reviews, before this went public.
> Marc Kleine-Budde  for upstream guidance.
> Greg Kroah-Hartman for TTY and style support.
> Vincent Mailhol    for intensive reviews up until the end.
>
> ...and of course thanks to the numerous people I've been in touch with
> via GitHub and otherwise. Bug reports, testing, or simply thanks and
> encouragement - they have all helped.
>
> Some stats for those interested: It has been a solid 8 years since the
> idea for this driver was born in 2014, with occasional on and off work
> on it since. The oldest code is from 2015, running in userspace and
> injecting packets via vcan. It became a kernel module in 2016, with
> link settings via "ip link". The first public version was released in
> 2018. It then gained in popularity, making upstreaming... inevitable ;)

So development started before commit cd6484e1830be260 ("serdev:
Introduce new bus for serial attached devices").  I guess that is the
reason why this driver uses a line discipline, instead of the serial
bus?

I had a quick glance through the various revisions posted, and it
doesn't seem like anyone mentioned the serial bus.  Would there be
any advantage in migrating to the serial bus?

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
