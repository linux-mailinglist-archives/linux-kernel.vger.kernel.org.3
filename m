Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA87560AB1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 21:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbiF2Txh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 15:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbiF2Txf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 15:53:35 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD3FD20BC9
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 12:53:31 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id sb34so34627300ejc.11
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 12:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dqavdjkcT0va56FD3EAwacRKjzmrc+kAsjMewxtGQNk=;
        b=LLdoGzkK2JjpkHb6PtvuoF5XA5STkn9qwLNSbrOkqQW+nRhUheph7vagv8spFW3HZf
         buAQemnlMu1kjxtGb8qcAtkwI8HwbLVjVbnofOvcA3WtPHj57EGKakcqWT0GtIDzhi21
         IKmFp1mRlPFVFq2TfkGq+F0BbdiutoJjgjK94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dqavdjkcT0va56FD3EAwacRKjzmrc+kAsjMewxtGQNk=;
        b=A2WY1vXsBJrBzoxilwAMAO/YSQWlwnB4TvjJ35p2UXnAxIzzXAKWkg63cxHgwc4Owy
         2tPFvOeKPLplktmH1//mDGyYaNT2mcbhnXIFzP+0HiQC9mj3iUMTl4d6RNY9jOLOlrDv
         DJtu/LhS271tRyyDZoOQrCcgKbyQD+A7IoX7K4Q0JIO5atA0vpSSscZiyzKcrYuUxz6A
         LOrpxSjnZoSxW4YKEL6SoqnZJEykosazgB5su2A49L1v408tmST0uhklvJHTSd48QGdr
         P3vdP8KdiMBwT5Bjt6xl0K046QRVflZMmchlayrO/BT/jlfugZcGbeJ7QA3OUgMmMDw+
         qW7w==
X-Gm-Message-State: AJIora/9bNl2lHCfh5JpYIig2W3xECv9/D6hhKr199nJkQ6sSOZK4d31
        GCuPsDSbzwPmtK6GL1f5HP0BaG1O+XIv7Nip
X-Google-Smtp-Source: AGRyM1twtwwwHQJl9DWF0Wd6ZQd/+OpJKUw2sL1d8Dps0BJ44fKJmzOk2EmC3KTMOab/AXd8G+RfrA==
X-Received: by 2002:a17:907:1b1e:b0:6d7:31b0:e821 with SMTP id mp30-20020a1709071b1e00b006d731b0e821mr4807561ejc.334.1656532409280;
        Wed, 29 Jun 2022 12:53:29 -0700 (PDT)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com. [209.85.221.41])
        by smtp.gmail.com with ESMTPSA id f15-20020a1709062c4f00b007081282cbd8sm8153827ejh.76.2022.06.29.12.53.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jun 2022 12:53:28 -0700 (PDT)
Received: by mail-wr1-f41.google.com with SMTP id i1so19533015wrb.11
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 12:53:27 -0700 (PDT)
X-Received: by 2002:adf:d1e9:0:b0:21b:c8f8:3c16 with SMTP id
 g9-20020adfd1e9000000b0021bc8f83c16mr4660391wrd.659.1656532407325; Wed, 29
 Jun 2022 12:53:27 -0700 (PDT)
MIME-Version: 1.0
References: <YqpprpUHmlD62YzI@google.com> <CAD=FV=VNDamV4+j07TrnX3cUs2-D5ySbeQ-zfU=Eef8+WagGig@mail.gmail.com>
 <Yqub17iT4O7aqFMi@google.com> <CAD=FV=VEztPLhsrJecZUdyHCW7ZfFTVvxyqY5CqRVv2mWyrLog@mail.gmail.com>
 <YquoSMiQS+RG8rOM@google.com> <CAD=FV=W81pSEUbzw2ZQgs_TJ9MLnHQHiDopZXZ6bHdS7QMzAyA@mail.gmail.com>
 <YqvMffveCPiKQEUk@google.com> <CAD=FV=UJOStPfRR3Hq2DmRBSH-HCtZ16hAU9eVH5w6Hm=WSJRQ@mail.gmail.com>
 <YqytDNB2y4+qT8GD@google.com> <CAD=FV=UT0XtMjZ9syQPGXeTEaUrwGTb_LgDow+cofgmx4D30VA@mail.gmail.com>
 <Yrnzl8k81f9JTMIQ@google.com>
In-Reply-To: <Yrnzl8k81f9JTMIQ@google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 29 Jun 2022 12:53:13 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Xphn68xA01xCZzX1d4YRRtkm+5G=SEUOywUCD8LKP=gw@mail.gmail.com>
Message-ID: <CAD=FV=Xphn68xA01xCZzX1d4YRRtkm+5G=SEUOywUCD8LKP=gw@mail.gmail.com>
Subject: Re: [PATCH v22 2/3] usb: misc: Add onboard_usb_hub driver
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Felipe Balbi <balbi@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Bastien Nocera <hadess@hadess.net>,
        Peter Chen <peter.chen@kernel.org>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Roger Quadros <rogerq@kernel.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Souradeep Chowdhury <quic_schowdhu@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jun 27, 2022 at 11:14 AM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> On Fri, Jun 24, 2022 at 01:33:19PM -0700, Doug Anderson wrote:
> > Hi,
> >
> > On Fri, Jun 17, 2022 at 9:34 AM Matthias Kaehlcke <mka@chromium.org> wrote:
> > >
> > > > Looking at the "companion-hub" case with fresh eyes, too, I wonder if
> > > > that can be simpler. If we find a companion hub, do we need both the
> > > > check for usb_hcd_is_primary_hcd() and the check to see whether the
> > > > pdev was already created?
> > >
> > > I was also doubting about this and concluded that it is still needed.
> > >
> > > Let's use once more the trogdor config as example, which has one physical
> > > onboard hub chip with a USB 3.1 hub and a USB 2.1 companion hub, connected
> > > to the dwc3 controller:
> > >
> > > &usb_1_dwc3 {
> > >         dr_mode = "host";
> > >         #address-cells = <1>;
> > >         #size-cells = <0>;
> > >
> > >         /* 2.x hub on port 1 */
> > >         usb_hub_2_x: hub@1 {
> > >                 compatible = "usbbda,5411";
> > >                 reg = <1>;
> > >                 vdd-supply = <&pp3300_hub>;
> > >                 companion-hub = <&usb_hub_3_x>;
> > >         };
> > >
> > >         /* 3.x hub on port 2 */
> > >         usb_hub_3_x: hub@2 {
> > >                 compatible = "usbbda,411";
> > >                 reg = <2>;
> > >                 vdd-supply = <&pp3300_hub>;
> > >                 companion-hub = <&usb_hub_2_x>;
> > >         };
> > > };
> > >
> > > Let's assume we don't check for the pdev. With our change above for root hubs
> > > the loop is now only executed for the primary HCD. In the first iteration
> > > we encounter the 2.x hub, it has a companion hub, but that alone doesn't
> > > tell us much, so we create a pdev. In the next iteration we encouter the
> > > 3.x hub, it also has a companion hub, but we don't know/check that the
> > > companion already has a pdev, so we create another one for the same
> > > physical hub.
> >
> > Ah, you are correct. You only run into that case for the root hub,
> > correct? For everything else it's impossible?
> >
> > ...and I guess things would be different if inside the loop you
> > actually set "hcd" to point to the "hcd" of the child device. I guess
> > that's where my confusion keeps stemming from. "hcd" is the parent's
> > host controller which is not always the same as the child's host
> > controller.
>
> I'd phrase it differently: for root hubs the 'parent_hub' isn't necessarily
> the parent of each 'child' node.
>
> > It would have been keen if we could somehow know the child's host
> > controller and get a pointer to that, but we can't because the child
> > device hasn't been enumerated yet.
> >
> > OK, I'm convinced. I'll mention it in your v23 but maybe I'll have a
> > slightly better chance of figuring this out if/when I look at this
> > again if we rename "hcd" to "parent_hcd".
>
> I'm not convinced that this would generally help to reduce the confusion.
> To me 'parent_hcd' sounds as if there was a tree of HCDs, which isn't
> the case. Also one could still read 'parent_hcd' as the HCD of all
> 'child' nodes.
>
> Maybe a bit more verbose documentation like this could help:
>
>   Some background about the logic in this function, which can be a bit hard
>   to follow:
>
>   Root hubs don't have dedicated device tree nodes, but use the node of their
>   HCD. The primary and secondary HCD are usually represented by a single DT
>   node. That means the root hubs of the primary and secondary HCD share the
>   same device tree node (the HCD node). As a result this function can be
>   called twice with the same DT node for root hubs. We only want to create a
>   single platform device for each physical onboard hub, hence for root hubs
>   the loop is only executed for the primary hub. Since the function scans
>   through all child nodes it still creates pdevs for onboard hubs connected
>   to the secondary hub if needed.
>
>   Further there must be only one platform device for onboard hubs with a
>   companion hub (the hub is a single physical device). To achieve this two
>   measures are taken: pdevs for onboard hubs with a companion are only
>   created when the function is called on behalf of the parent hub that is
>   connected to the primary HCD (directly or through other hubs). For onboard
>   hubs connected to root hubs the function processes the nodes of both
>   companions. A platform device is only created if the companion hub doesn't
>   have one already.

Sounds good. Extra docs explaining this are always good and I'm fine
with more docs and leaving it called "hcd" instead of "parent_hcd"


> When writing this I realized that the check for an existing platform device
> for companions could be put inside an 'if (!parent_hub->parent)' block. It
> isn't necessary for hubs deeper down in the chain, since their pdev will only
> be created for the hub (indirectly) connected to the primary HCD.

Yup. I'm not 100% sure if it's worth adding the extra "if" test or
not. Could make the argument either way.

-Doug
