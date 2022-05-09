Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 775BC52001A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 16:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237713AbiEIOq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 10:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237586AbiEIOqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 10:46:10 -0400
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E090D16549E;
        Mon,  9 May 2022 07:42:15 -0700 (PDT)
Received: by mail-qv1-f42.google.com with SMTP id p3so9066600qvi.7;
        Mon, 09 May 2022 07:42:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5+vqGfHPelFk9/33nSW7ABuV7vg2is0Y9SwNAQ6T9v4=;
        b=DGT+neaCKSscwji9RnnyGFEHn7J2QQUOuNq6XDeNgrNygGU0iXUjOdfj+nLKuuhI3L
         oL6KQwVILpQYNKOfG2VuJcVRaIc1ayqiXIuFHHQJu2Mh+dc4on4D7lgxc7PTAxaA7TM9
         +4yaSLcDU9QLAgJgzcdOKNda/XnyDJ/pDcAb8eSLf3PDvZcBmWfAx/cmtXimLarnEsjz
         nSUHsSGqvC3PUISqoqP2OCxdsaXdmH+rDK5fVDtXtpcW+pjSl9pSEdnw33nt/z8i3/RJ
         yI5wteJbSptHoWfiPIP9e/a+j16d3PZjgcENCXMAqqYDdCYHwZUlL13gYEQhViJuU7WC
         fTyQ==
X-Gm-Message-State: AOAM533jzNOHWi3g4UXU5rQkQzAYXmg3fRjWpdJhHnjg/xCo2A5ArcqE
        fs65a1DFIwDEIzkS/clv2Ivy89rEp5l2Wg==
X-Google-Smtp-Source: ABdhPJwTUAyBBcVDLljE8qHNTc1pWx9OGwM5BYrXk3pdZITLhywp1dWPKPsocm3VqzQxHInqnLCHvQ==
X-Received: by 2002:a05:6214:411d:b0:45a:8012:d45c with SMTP id kc29-20020a056214411d00b0045a8012d45cmr13722396qvb.38.1652107334683;
        Mon, 09 May 2022 07:42:14 -0700 (PDT)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id n78-20020a372751000000b0069fc13ce228sm7059971qkn.89.2022.05.09.07.42.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 May 2022 07:42:14 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-2f7d7e3b5bfso146902677b3.5;
        Mon, 09 May 2022 07:42:14 -0700 (PDT)
X-Received: by 2002:a0d:d953:0:b0:2f7:d5ce:f204 with SMTP id
 b80-20020a0dd953000000b002f7d5cef204mr14325486ywe.502.1652107333940; Mon, 09
 May 2022 07:42:13 -0700 (PDT)
MIME-Version: 1.0
References: <YmSc29YZvxgT5fEJ@rowland.harvard.edu> <YmSo6fU1FlNq8cOZ@rowland.harvard.edu>
 <YmSpKpnWR8WWEk/p@rowland.harvard.edu> <YmSpdxaDNeC2BBOf@rowland.harvard.edu>
 <alpine.DEB.2.22.394.2205031209030.681336@ramsan.of.borg> <YnFCEn45XwDWM/9Y@rowland.harvard.edu>
 <CAMuHMdVDK0W0T3=+2c1E6wtwy5JTUemTGYyj3PFuVUhK++AzrA@mail.gmail.com>
 <YnFO0Qr8RY7peFCg@rowland.harvard.edu> <YnaR8LaaPTdLTiok@rowland.harvard.edu>
 <CAMuHMdUpOiHHMktPk_-NauDW2ufvGThnkFU7Pok376pM6OEyYw@mail.gmail.com> <Ynkh5eKtfxU+AyZX@rowland.harvard.edu>
In-Reply-To: <Ynkh5eKtfxU+AyZX@rowland.harvard.edu>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 9 May 2022 16:42:01 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVi6jCi=tRBNjBodVcA48ygiqPACQcmHx+1HRYnArJ9tQ@mail.gmail.com>
Message-ID: <CAMuHMdVi6jCi=tRBNjBodVcA48ygiqPACQcmHx+1HRYnArJ9tQ@mail.gmail.com>
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

On Mon, May 9, 2022 at 4:15 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> On Mon, May 09, 2022 at 09:46:25AM +0200, Geert Uytterhoeven wrote:
> > > Geert:
> > >
> > > Can you test the patch below?  It ought to fix the problem (although it
> >
> > Thanks!
> >
> > root@h3-salvator-xs:~# ls -l /sys/bus/gadget/devices/
> > total 0
> > lrwxrwxrwx 1 root root 0 Feb 14  2019 gadget.0 ->
> > ../../../devices/platform/soc/e659c000.usb/gadget.0
> > lrwxrwxrwx 1 root root 0 Feb 14  2019 gadget.1 ->
> > ../../../devices/platform/soc/ee020000.usb/gadget.1
> > lrwxrwxrwx 1 root root 0 Feb 14  2019 gadget.2 ->
> > ../../../devices/platform/soc/e6590000.usb/gadget.2
> >
> > Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >
> > LGTM, so
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> Thanks!
>
> > > might end up causing other problems down the line...)
> >
> > Can you please elaborate? I'm not too familiar with UBS gadgets.
>
> I was concerned about the fact that changing the name of a file,
> directory, or symbolic link in sysfs means changing a user API, and so
> it might cause some existing programs to fail.  That would be a
> regression.
>
> Perhaps the best way to work around the problem is to leave the name set
> to "gadget" if the ID number is 0, while adding the ID number on to the
> name if the value is > 0.  What do you think?

Oh, you mean the "gadget.N" subdirs, which are the targets of the
symlinks above? These were indeed named "gadget" before.

Would it be possible to append the ".N" suffixes only to the actual
symlinks, while keeping the target directory names unchanged?
E.g. /sys/bus/gadget/devices/gadget.0 ->
../../../devices/platform/soc/e659c000.usb/gadget

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
