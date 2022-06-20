Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0B15524A9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 21:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244492AbiFTTl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 15:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233184AbiFTTlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 15:41:25 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 690B41401C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 12:41:24 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-31772f8495fso109503327b3.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 12:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W3cF1VcNZKMUkal3wxdtJamU5dlHgg7QxmEQyZt0dz0=;
        b=aO2AYN3zp0ClZrYRS2Q8cyVAwbUa7767aMcv8OyCU5rPa5d03QKD5NJP4c5JAuGSij
         3lnUxhivwtYF2TKpUEfHSSRwjzT74jT3s63IHP+4lGXEO3JebLxdma7I2g+t4M9pmcrP
         ZBoIfAsp16J6LeFM7E9trq+cVZZhVBVFyWgw4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W3cF1VcNZKMUkal3wxdtJamU5dlHgg7QxmEQyZt0dz0=;
        b=7YvITn48JW0+qEsqX5tT+bYyeZQxWc6FqJHyYq3G00kI69BczEl4QOhzQOa0pR0QpE
         GckQLvLtO+qYb9qrHQUHzPgO1YSavg2XZwy1YV5BnZRMTWT1p+vk/T5SIfVib0K0HzGG
         X+YEM0w0+dMrcIEKVDIyVD0jNRhKdjEilJxuLhkRFzhA5b1aFsrDCZ52Pp+g+2ZbGPoZ
         OD0/WZEO2JLaiwVRBkh+ryGJw8EyT4O6X/DPPIcVCvvck3KbjYIlqKicoIHNl2HRa3m8
         n2LAfWUpIzbVRj69ibouOQ8ZeLI7oN/pfn3PE+aO+g40m9r1cRFweiOty+oh9FmJrZ6o
         TADQ==
X-Gm-Message-State: AJIora9+Q2VM44amFecF/Cd+6E9fjYzKkbLDHxvsWh0+orbgm4WSAwwg
        U4fxz7ANNnb0KAT3GPFr80RxP8QOgz7D6nPP6DbSL9/qPw==
X-Google-Smtp-Source: AGRyM1sjc6n2Bzm9cy/SUFZ/GJLuqV4owB4rH6VbtDqmkmLyBzbuScGeatMo9HK8lbzoZ8jRgbVOd1LTgcwYS7echBU=
X-Received: by 2002:a0d:cbc8:0:b0:317:95ef:399e with SMTP id
 n191-20020a0dcbc8000000b0031795ef399emr15460241ywd.340.1655754083630; Mon, 20
 Jun 2022 12:41:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220619203212.3604485-1-heiko@sntech.de> <20220619203212.3604485-2-heiko@sntech.de>
 <CAOnJCUJC3dk21cYXXDOsamvwFDHsukoBx7HEYwqHM+MN5fLRpA@mail.gmail.com> <5907887.LM0AJKV5NW@phil>
In-Reply-To: <5907887.LM0AJKV5NW@phil>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Mon, 20 Jun 2022 12:41:12 -0700
Message-ID: <CAOnJCUKmWcMT83jkJHX3J56uNeVvFMgudGSg_DWg9G_faBjGXQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] of: also handle dma-noncoherent in of_dma_is_coherent()
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Wei Fu <wefu@redhat.com>, Guo Ren <guoren@kernel.org>,
        Christoph Muellner <cmuellner@linux.com>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        Christoph Hellwig <hch@lst.de>,
        Samuel Holland <samuel@sholland.org>,
        Anup Patel <anup@brainfault.org>,
        Nick Kossifidis <mick@ics.forth.gr>,
        Rob Herring <robh+dt@kernel.org>, krzk+dt@kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        Drew Fustini <drew@beagleboard.org>,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 20, 2022 at 11:11 AM Heiko Stuebner <heiko@sntech.de> wrote:
>
> Hi Atish,
>
> Am Montag, 20. Juni 2022, 18:33:09 CEST schrieb Atish Patra:
> > On Sun, Jun 19, 2022 at 1:32 PM Heiko Stuebner <heiko@sntech.de> wrote:
> > >
> > > of_dma_is_coherent() currently expects the architecture to be
> > > non-coherent and some devices being coherent getting marked
> > > as such with the dma-coherent devicetree property.
> > >
> > > For PowerPC CONFIG_OF_DMA_DEFAULT_COHERENT was added which currently
> > > makes of_dma_is_coherent() always return true but doesn't handle
> > > the case of the architecture being coherent but some devices not.
> > >
> > > So modify the function to also check for dma-noncoherent and
> > > set a suitable default return value. If CONFIG_OF_DMA_DEFAULT_COHERENT
> > > is set the value starts with true and finding dma-noncoherent will
> > > set it to false and without CONFIG_OF_DMA_DEFAULT_COHERENT, the
> > > behaviour is reversed.
> > >
> > > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > > ---
> > >  drivers/of/address.c | 16 +++++++++++-----
> > >  1 file changed, 11 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/drivers/of/address.c b/drivers/of/address.c
> > > index 94f017d808c4..1c362d09983d 100644
> > > --- a/drivers/of/address.c
> > > +++ b/drivers/of/address.c
> > > @@ -1045,26 +1045,32 @@ phys_addr_t __init of_dma_get_max_cpu_address(struct device_node *np)
> > >   *
> > >   * It returns true if "dma-coherent" property was found
> > >   * for this device in the DT, or if DMA is coherent by
> > > - * default for OF devices on the current platform.
> > > + * default for OF devices on the current platform and no
> > > + * "dma-noncoherent" property was found for this device.
> >
> > "dma-noncoherent" is not a standard DT property. I couldn't find any
> > references to
> > it in the kernel as well. If we are introducing a new DT property for
> > non-coherent devices,
> > it should be added in DT bindings as well ?
>
> The dma-coherent is part of the core devicetree-spec,
> so I sent a patch adding dma-noncoherent [0]
> to the devicetree-spec mailing list yesterday as well.
>

Ahh. That's great. Thanks!

> [0] https://www.spinics.net/lists/devicetree-spec/msg01053.html
>
>
> >
> > >   */
> > >  bool of_dma_is_coherent(struct device_node *np)
> > >  {
> > >         struct device_node *node;
> > > +       bool ret = false;
> > >
> > >         if (IS_ENABLED(CONFIG_OF_DMA_DEFAULT_COHERENT))
> > > -               return true;
> > > +               ret = true;
> > >
> > >         node = of_node_get(np);
> > >
> > >         while (node) {
> > >                 if (of_property_read_bool(node, "dma-coherent")) {
> > > -                       of_node_put(node);
> > > -                       return true;
> > > +                       ret = true;
> > > +                       break;
> > > +               }
> > > +               if (of_property_read_bool(node, "dma-noncoherent")) {
> > > +                       ret = false;
> > > +                       break;
> > >                 }
> > >                 node = of_get_next_dma_parent(node);
> > >         }
> > >         of_node_put(node);
> > > -       return false;
> > > +       return ret;
> > >  }
> > >  EXPORT_SYMBOL_GPL(of_dma_is_coherent);
> > >
> > > --
> > > 2.35.1
> > >
> >
> >
> >
>
>
>
>


-- 
Regards,
Atish
