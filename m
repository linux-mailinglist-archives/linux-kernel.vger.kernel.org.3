Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1B151F5B1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 09:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236771AbiEIHx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 03:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233897AbiEIHud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 03:50:33 -0400
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A2617CC87;
        Mon,  9 May 2022 00:46:38 -0700 (PDT)
Received: by mail-qt1-f174.google.com with SMTP id hf18so10439352qtb.0;
        Mon, 09 May 2022 00:46:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3XPGjru+uW0hOeRykS42TNYyIx8ZkoC8DFG5cF+O4o4=;
        b=41F9GyWZlsfocB5MenQJl7d0bF5bQN5+OHhw7IwhQxihHqhhYlAwOGtex2kpjR0nap
         3KGJyib2NQ5zz1sidV1zAHrPdoPy3m2SNZKaCBT9W38BBGzrA1tciu2RylX2SteqAllA
         LLehhLi/JSu34sDMJ/AaPp6Zkhr7pYzq2WN3PaMe65tShsZni2Fw1RR3wKMxtmo1fY6h
         ge6NTGekiWrRiRN4KMseD4yqI/ErHE5DvVy7b66yV8g6bEv6Od4TFvfCvislmTHz4quo
         Dqx11FZoM1WEuPg1p1+f8qanvEPJtnJnb074yBcVtZMAhtiewu5SdbV/t/N7rLKEVQFU
         9SpA==
X-Gm-Message-State: AOAM531ngeJfEyi/zsqFB7W0egtP9qBf3rw2rEG70Zf6DPfEbA0a5+81
        JCeZiiUYHQrqBCmtE5GLjyaaJDlcoISUqQ==
X-Google-Smtp-Source: ABdhPJy4TyR1k/BcB6Il7OOSsz4Ai0gOSQz4I1J9xfUsRwEOEjElDVeCSVQEoRs/W1+8J27CkS5Y7Q==
X-Received: by 2002:a05:622a:13d2:b0:2f3:d2aa:7c5a with SMTP id p18-20020a05622a13d200b002f3d2aa7c5amr7638987qtk.155.1652082397698;
        Mon, 09 May 2022 00:46:37 -0700 (PDT)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com. [209.85.128.176])
        by smtp.gmail.com with ESMTPSA id o12-20020ac8554c000000b002f39b99f6a8sm6913691qtr.66.2022.05.09.00.46.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 May 2022 00:46:37 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-2f83983782fso134895587b3.6;
        Mon, 09 May 2022 00:46:37 -0700 (PDT)
X-Received: by 2002:a81:9b0c:0:b0:2f4:c522:7d3c with SMTP id
 s12-20020a819b0c000000b002f4c5227d3cmr12831128ywg.316.1652082396821; Mon, 09
 May 2022 00:46:36 -0700 (PDT)
MIME-Version: 1.0
References: <YjeEbHL8ITkW692W@rowland.harvard.edu> <YmKt3kH+85kjzdbL@kroah.com>
 <YmSc29YZvxgT5fEJ@rowland.harvard.edu> <YmSo6fU1FlNq8cOZ@rowland.harvard.edu>
 <YmSpKpnWR8WWEk/p@rowland.harvard.edu> <YmSpdxaDNeC2BBOf@rowland.harvard.edu>
 <alpine.DEB.2.22.394.2205031209030.681336@ramsan.of.borg> <YnFCEn45XwDWM/9Y@rowland.harvard.edu>
 <CAMuHMdVDK0W0T3=+2c1E6wtwy5JTUemTGYyj3PFuVUhK++AzrA@mail.gmail.com>
 <YnFO0Qr8RY7peFCg@rowland.harvard.edu> <YnaR8LaaPTdLTiok@rowland.harvard.edu>
In-Reply-To: <YnaR8LaaPTdLTiok@rowland.harvard.edu>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 9 May 2022 09:46:25 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUpOiHHMktPk_-NauDW2ufvGThnkFU7Pok376pM6OEyYw@mail.gmail.com>
Message-ID: <CAMuHMdUpOiHHMktPk_-NauDW2ufvGThnkFU7Pok376pM6OEyYw@mail.gmail.com>
Subject: Re: [PATCH 4/4] USB: gadget: Add a new bus for gadgets
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        USB mailing list <linux-usb@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

On Sat, May 7, 2022 at 5:36 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> On Tue, May 03, 2022 at 11:48:33AM -0400, Alan Stern wrote:
> > On Tue, May 03, 2022 at 05:27:08PM +0200, Geert Uytterhoeven wrote:
> > > On Tue, May 3, 2022 at 5:14 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> > > > On Tue, May 03, 2022 at 12:14:30PM +0200, Geert Uytterhoeven wrote:
> > > > > On Sat, 23 Apr 2022, Alan Stern wrote:
> > > > > > This patch adds a "gadget" bus and uses it for registering gadgets and
> > > > > > their drivers.  From now on, bindings will be managed by the driver
> > > > > > core rather than through ad-hoc manipulations in the UDC core.
> > > > > >
> > > > > > As part of this change, the driver_pending_list is removed.  The UDC
> > > > > > core won't need to keep track of unbound drivers for later binding,
> > > > > > because the driver core handles all of that for us.
> > > > > >
> > > > > > However, we do need one new feature: a way to prevent gadget drivers
> > > > > > from being bound to more than one gadget at a time.  The existing code
> > > > > > does this automatically, but the driver core doesn't -- it's perfectly
> > > > > > happy to bind a single driver to all the matching devices on the bus.
> > > > > > The patch adds a new bitflag to the usb_gadget_driver structure for
> > > > > > this purpose.
> > > > > >
> > > > > > A nice side effect of this change is a reduction in the total lines of
> > > > > > code, since now the driver core will do part of the work that the UDC
> > > > > > used to do.
> > > > > >
> > > > > > A possible future patch could add udc devices to the gadget bus, say
> > > > > > as a separate device type.
> > > > > >
> > > > > > Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> > > > >
> > > > > Thanks for your patch, which is now commit fc274c1e997314bf ("USB:
> > > > > gadget: Add a new bus for gadgets") in usb-next.
> > > > >
> > > > > This patch cause a regression on the Renesas Salvator-XS development
> > > > > board, as R-Car H3 has multiple USB gadget devices:
> > > >
> > > > Then these gadgets ought to have distinct names in order to avoid the
> > > > conflict below:
>
> Geert:
>
> Can you test the patch below?  It ought to fix the problem (although it

Thanks!

root@h3-salvator-xs:~# ls -l /sys/bus/gadget/devices/
total 0
lrwxrwxrwx 1 root root 0 Feb 14  2019 gadget.0 ->
../../../devices/platform/soc/e659c000.usb/gadget.0
lrwxrwxrwx 1 root root 0 Feb 14  2019 gadget.1 ->
../../../devices/platform/soc/ee020000.usb/gadget.1
lrwxrwxrwx 1 root root 0 Feb 14  2019 gadget.2 ->
../../../devices/platform/soc/e6590000.usb/gadget.2

Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

LGTM, so
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> might end up causing other problems down the line...)

Can you please elaborate? I'm not too familiar with UBS gadgets.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
