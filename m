Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93C6B512B7D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 08:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243917AbiD1G3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 02:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244133AbiD1G3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 02:29:03 -0400
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B3AA972B5;
        Wed, 27 Apr 2022 23:25:45 -0700 (PDT)
Received: by mail-qt1-f179.google.com with SMTP id t16so2768793qtr.9;
        Wed, 27 Apr 2022 23:25:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XfKmtzg0D+/23Jg+mxJhp4CSenJ+1YBHova8u1JkXUQ=;
        b=ZnMLO/Lv6AqimFNQXTbBlSmQzAYfbc9QIGeK56A8vnXl+3h5bSmMkLqrZmBl2lvJ4r
         YvR6ys4yhRsZBH8HI+GWMfRuwbO7mYTTU4EICyZk9eKIwLdY0KAxBuaWnE6nSkcXlzu2
         9yLkuN6DQjI3qgguMYfWwGuvxQzY0VM4V0F9h1PNozkLMwjUYoyHmuQvZG/Eg5opw2x4
         zFlWroAVjxHtZkGSIYh3OKjBDvJiTXdtl6t786KJlDc/dlnldvy7HdHg7MZcR+PGBhOl
         cY58R3lVyZJxHSbmqwM0mprTUkELDEXpa/aipET38mGuVW0CcasVTe4wCEus+MX4qq7L
         IabA==
X-Gm-Message-State: AOAM533bm5vdnI5ww5YMrF+Fr4up06DaRzPgKWa9RD/4sOGt0O6ladDw
        /i6ZNbay//BgEju11K2jGC7JviINdHYgtg==
X-Google-Smtp-Source: ABdhPJzUkEFign92kH4Yv1si1oS0yjzkNBzRfm5+D5PBEvnhvmoMIrHJ17MfSAxsVeKG/4fgB7UwYw==
X-Received: by 2002:a05:622a:13ca:b0:2f3:8070:ec79 with SMTP id p10-20020a05622a13ca00b002f38070ec79mr7355320qtk.199.1651127144247;
        Wed, 27 Apr 2022 23:25:44 -0700 (PDT)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com. [209.85.128.169])
        by smtp.gmail.com with ESMTPSA id q27-20020a05620a039b00b0069c8307d9c4sm9023360qkm.18.2022.04.27.23.25.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Apr 2022 23:25:43 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-2f863469afbso18014217b3.0;
        Wed, 27 Apr 2022 23:25:43 -0700 (PDT)
X-Received: by 2002:a81:8489:0:b0:2f7:edff:239f with SMTP id
 u131-20020a818489000000b002f7edff239fmr18913227ywf.256.1651127143411; Wed, 27
 Apr 2022 23:25:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210324223713.1334666-1-frowand.list@gmail.com>
 <20210327174035.GA291160@robh.at.kernel.org> <3e6710e7-08ac-7d1b-aa69-bcd36f0d932a@gmail.com>
 <CAMuHMdXpGKMi-xv6hZQmmEw0JO=Q0WuvUzwJ2v0O28Tx5uW+sg@mail.gmail.com>
 <d1aefaae-7b12-b5fb-4b97-7230bd52c1be@gmail.com> <20210526061144.yvoaurpz75a3bsjr@vireshk-i7>
 <f651e95b-feef-5c86-edba-d6008bc80b34@gmail.com> <YK70Xsl1oXeEQpWZ@yekko>
 <CAMuHMdWdb2s08a=axC+m88gARSA3enOBnczsN59XL2F9yHXXYA@mail.gmail.com>
 <YLBnX4PeK51YwUJB@yekko> <CAMuHMdXPn9FHr41xmihuuzNNNKvY-50yAwY4HyuyVo6qBn=Z1w@mail.gmail.com>
 <CAMuHMdWeL3DOXY3xcPOBW2WDDGW3PxgSM8didt7J1KxSm1ivJg@mail.gmail.com>
 <CAMuHMdWXXoS9mmX9VWRQyXfmsy8YROgpLZ-xB7zthEdPdM2u4A@mail.gmail.com>
 <CAMuHMdVWkSnki8VQDaYRzJ8yu8xtEKpXyfQppTtw3wXDQPmYzw@mail.gmail.com>
 <d4b7ce06-23e7-1c60-cc0c-b6aea07e0a1a@gmail.com> <CAL_JsqKTckMABk6cM8d=boZcHyLdcqYmbzfKDjAHdCXoCPSDtg@mail.gmail.com>
 <CAMuHMdU4oUKaGxmaPiC=cX0XpHG3KXhr+4MywEfeQ8sq-EG18A@mail.gmail.com>
 <CAL_JsqL3fHXNdGS=ap6+5Y25T2zmnDYRkt5dNV9mW7hyanVvuw@mail.gmail.com> <CAL_JsqJn459-8wnwT0N0CKumnvh_gDkVdgVebvMVa13oTxfQ=g@mail.gmail.com>
In-Reply-To: <CAL_JsqJn459-8wnwT0N0CKumnvh_gDkVdgVebvMVa13oTxfQ=g@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 28 Apr 2022 08:25:31 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUyuJbyHthc4ATuRXY=zM_Vbc7DmsZvWgX_u8w3FfhzDg@mail.gmail.com>
Message-ID: <CAMuHMdUyuJbyHthc4ATuRXY=zM_Vbc7DmsZvWgX_u8w3FfhzDg@mail.gmail.com>
Subject: Re: [PATCH 1/1] of: unittest: rename overlay source files from .dts
 to .dtso
To:     Rob Herring <robh@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Anmar Oueja <anmar.oueja@linaro.org>,
        Bill Mills <bill.mills@linaro.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Wed, Apr 27, 2022 at 11:14 PM Rob Herring <robh@kernel.org> wrote:
> On Wed, Jan 26, 2022 at 1:31 PM Rob Herring <robh@kernel.org> wrote:
> > On Fri, Jan 14, 2022 at 3:25 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > On Fri, Jan 14, 2022 at 3:10 AM Rob Herring <robh@kernel.org> wrote:
> > > > On Thu, Jan 6, 2022 at 11:23 AM Frank Rowand <frowand.list@gmail.com> wrote:
> > > > > Patient Geert has pinged again.
> > > >
> > > > If it's not a patch to be reviewed, then I'm not going to see it most
> > > > likely. I don't read the DT list regularly...
> > >
> > > Fair enough...
> > >
> > > > > If I remember correctly you guys were not thrilled with this idea, but
> > > > > also did not seem strongly against it.  Are you willing to go along
> > > > > with .dtso for overlay source files?  If so, I will revive this patch
> > > > > series.
> > > > >
> > > > > David, if you are against supporting .dtso in the dtc compiler then
> > > > > the kernel can still support it through make rules.
> > > >
> > > > I'm not really interested in diverging from dtc. I'd suggest moving
> > > > the discussion to dtc list and/or devicetree-spec if you want to get
> > > > more attention on this.
> > >
> > > What needs to be supported in the dtc compiler?
> > > The fallback passed to guess_input_format() is "dts".
> > > So this has been working out-of-the-box since forever?
> >
> > Ah, okay.
> >
> > > > Also, keep in mind that extensions also affect MIME types which
> > > > someone was also asking about recently.
> > >
> > > You mean "MIME type of Devicetree Blobs and Sources"[1]?
> > > According to [2](2022-01-13), none of that has happened.
> >
> > This is what I was thinking of:
> >
> > https://github.com/devicetree-org/devicetree-specification/issues/46
> >
> > In any case, given everyone is ambivalent, send me an updated patch
> > and I'll apply it.
>
> Ping! Anyone still want this?
>
> What I don't want to see is a mixture of .dts and .dtso. And now I'm
> reviewing RPi overlay patches[1] with .dts.

I still prefer .dtso over .dts, as it allows tools to detect the file
type without having to read the file's contents.
Without this, e.g. make needs to have all overlays listed explicitly
in a Makefile.

We do have .c, .h, .s (even .S), .dtsi. So why not .dtso?

> [1] https://lore.kernel.org/r/20220427185243.173594-3-detlev.casanova@collabora.com

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
