Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE55354D49C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 00:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348112AbiFOWeE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 18:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245457AbiFOWeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 18:34:00 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1716A54FBF
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 15:33:59 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id u12so25898408eja.8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 15:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jBRgA7mh0vSrO2Go9U8aP6vyu4ifC2xD2pQy0EesF+o=;
        b=cglBvxOlfV3v1KIVmIU9z8AoYu7+sFR5skD2h9EQX0wN+SpZp4MCG7Up301QYRGkcI
         9VrL7Nz8q2h6PIkrOjM+coLyHJ8TmA/NDkfreo5RS5cGN8iwsjpiygHvUc9Tc8qUURaS
         WDu3vzTIRJcIcuARkhQeken5kL0fzEiWQ4Ks4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jBRgA7mh0vSrO2Go9U8aP6vyu4ifC2xD2pQy0EesF+o=;
        b=aJt7j4vwidFdR2ymqb4960NjJ9q4yWPaWK6SJXPz8dEhxxh6v+p36VfFbQPKPIME+J
         G6XAVlq6L45uAnqke3Rw9s+NbJEgl/vruaVBeJo2TdSGK2Gw5frQJUQ0J5uFtaDYfrUv
         VnRDfhS+AaomvMD3ZfpRIueWlYUyrhpi6EPkgg46M+K4LUwUVD24o+Fq/5aSMxSRzl+9
         fnzb5GgsANlOKxrQPENuOZdqBIR55fxzBklzPBjueXrdeO0hoX4xmkWXUWCPbiGanPAS
         7wgIu5eDBUqDj5whqepl7AQhvuFN2mo8lYgyNmfYxsdobvhAnyQ7dpLdV7VGEYSDl08H
         Y66g==
X-Gm-Message-State: AJIora9B1E5wHasjZaNGzIzwuVTKKU3D6GIMiqgr3nArrQCJw1mV0PdY
        LANcQNRbYPAjXK+u1Ad1Y26TEQ65uwK7PnHAi4E=
X-Google-Smtp-Source: AGRyM1tMwnQ/KWD6ZUYv3sWkIJ3HGs5Hif/gzsgfO3+MEOw8OYOFzgAZLPb5EmgX5PFOw4G49iTXTw==
X-Received: by 2002:a17:906:1018:b0:718:dd3f:f28c with SMTP id 24-20020a170906101800b00718dd3ff28cmr1896294ejm.55.1655332438273;
        Wed, 15 Jun 2022 15:33:58 -0700 (PDT)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com. [209.85.128.46])
        by smtp.gmail.com with ESMTPSA id g8-20020a056402090800b0042dd022787esm374682edz.6.2022.06.15.15.33.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jun 2022 15:33:57 -0700 (PDT)
Received: by mail-wm1-f46.google.com with SMTP id n185so7017871wmn.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 15:33:57 -0700 (PDT)
X-Received: by 2002:a05:600c:591:b0:39c:4544:b814 with SMTP id
 o17-20020a05600c059100b0039c4544b814mr12279690wmd.118.1655332436642; Wed, 15
 Jun 2022 15:33:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAODwPW9E8wWwxbYKyf4_-JFb4F-JSmLR3qOF_iudjX0f9ndF0A@mail.gmail.com>
 <CAODwPW8fiFSNehZbZDdR9kjHxohLGiyE7edU=Opy0xV_P8JbEQ@mail.gmail.com>
 <CAD=FV=XAYUx9OKLxThQxYr02ZE+7Rjw0VnSsxg7kfPCBG38FZw@mail.gmail.com> <CAODwPW_6A3kcmTLHVnH19bdYKpVBadAcDk5g-qxuju04uPRcMg@mail.gmail.com>
In-Reply-To: <CAODwPW_6A3kcmTLHVnH19bdYKpVBadAcDk5g-qxuju04uPRcMg@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 15 Jun 2022 15:33:43 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UzsbwSbTc7LtsTj=wxj8A1MqmkVFt0XBrTdQ8pEhde=A@mail.gmail.com>
Message-ID: <CAD=FV=UzsbwSbTc7LtsTj=wxj8A1MqmkVFt0XBrTdQ8pEhde=A@mail.gmail.com>
Subject: Re: [RFC] Correct memory layout reporting for "jedec,lpddr2" and
 related bindings
To:     Julius Werner <jwerner@chromium.org>
Cc:     Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Jian-Jia Su <jjsu@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Nikola Milosavljevic <mnidza@outlook.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jun 15, 2022 at 2:27 PM Julius Werner <jwerner@chromium.org> wrote:
>
> > Two comments about the above:
> >
> > 1. It seems like the top-level node should have a compatible of some
> > type. Without that I guess you're just relying on people to find it
> > based on the name of the node?
> >
> > 2. Why not put the `channel-io-width` property in the channel? Then
> > you don't need to repeat it for each rank that's under the channel?
>
> Yes, we could do it that way. That seemed a bit more complicated to
> me, but if there's precedent for that in other devices it's probably
> the right thing.
>
> > 1. In the above the two ranks are in series, right? ...with a chip
> > select to select rank0 vs rank1? From how SPI works I'd expect that to
> > be represented using "reg", AKA:
>
> I wouldn't call it "in series" (rank is just a separate dimension of
> its own, in my mental model) but yes, if you think they should also be
> named with a property inside the node (and not just distinguished by
> node name), we can do that. Using "reg" for this feels a bit odd to
> me, but if that's common device tree practice we can do it that way.

Definitely should listen to real DT maintainers and not just me--it
just sounded like it matched how SPI did things where the chip select
was the "reg".


> > 2. I guess if you had two things in parallel you'd want to know how?
> > Maybe if you had 4 8-bit chips connected to a 32-bit channel maybe
> > it'd look like this: [...]
>
> I think the channel-io-width mechanism is sufficient to distinguish
> this (by dividing by io-width), so I don't think there's anything to
> gain from listing each of these parallel chips separately. This also
> more closely reflects the way the memory training firmware that's
> writing these entries actually sees the system. The way I understand
> it, from the memory controller's perspective there's actually no
> difference between talking to a single 32-bit chip or two 16-bit chips
> in parallel -- there's no difference in register settings or anything,
> both software and hardware are totally unaware of this. This is all
> just implemented by wiring the respective components together
> correctly in the board layout (split the DQ pins between the two
> chips, and short all the other pins like clock and chip select
> together). When reading the mode register value, the controller only
> reads the first chip's register (which is connected to DQ[0:7]). When
> writing a mode register, the one Write Mode Register cycle will write
> all chips at once (because the written value is transferred through
> the column address pins which are shorted together between all chips).
> So if we were to pretend in the FDT that we had separate density and
> io-width values for each chip, that's kinda disingenuous, because the
> firmware can only read one of them and just assumes that it applies to
> all chips in parallel on that channel. The only way the firmware could
> know how many chips there are in parallel would also be by dividing
> the width of its channel by the io-width reported by the chip -- so I
> think it would be more honest there to just report those two "original
> source" values to the kernel / userspace and let them make that
> deduction themselves if they care to.
>
> > ...and I guess you could have things that include serial and parallel hookups...
>
> Sorry, just to avoid having more confusion here: there is no "serial"
> dimension to this as far as I'm aware (in my original email I called
> the "several chips per channel" thing "in series", but you are right
> that it would really be more accurate to call it "in parallel").
> There's only three dimensions: a) multiple channels (totally separate
> sets of pins coming out of the controller), b) multiple chips per
> channel (splitting e.g. 32 pins from the controller onto two 16-pin
> parts), and c) multiple ranks within each chip (which chip select pin
> is asserted in each access cycle).
>
> > > > This would be describing a dual-channel, dual-rank layout where each
> > > > 32-bit channel is connected to two 16-bit LPDDR chips in series. The
> > > > total capacity would be (2048 Mbits * (32/16) chips + 1024 Mbits *
> > > > (32/16) chips) * 2 channels = 12Gbits.
> >
> > Just to make sure I'm understanding things: in your hypothetical
> > example we're effectively wasting half of the SDRAM bandwidth of the
> > controller, right? So while what you describe is legal you'd get a
> > much more performant system by hooking the two big chips in parallel
> > on one channel and the two small chips in parallel on the other
> > channel. That would effectively give you a 64-bit wide bus as opposed
> > to the 32-bit wide bus that you describe.
>
> No, I don't think you're wasting bandwidth. In my example the
> controller has two 32-bit channels, so it always uses 64 bits of
> bandwidth in total. There's no asymmetry in the "chips per channel"
> dimension in my example (maybe that was a misunderstanding due to our
> different use of "in series" vs "in parallel") -- in fact, there can
> never be asymmetry in that dimension, when you split a channel onto
> more than one chip then those chips always must be exactly equal in
> geometry and timings (because, as mentioned above, they all get
> initialized the same way with parallel Write Mode Register commands).
> Asymmetry can only come in at the rank or channel dimension.
> (Asymmetry there may have a minor performance penalty since you'd be
> limiting the amount of rank or channel interleaving the controller can
> do, but it would be an indirect penalty that depends on the access
> pattern and not be anywhere near as bad as "half the bandwidth".)
>
> Anyway, whether it's a good idea or not, these parts definitely do
> exist and get sold that way. I can't find an example with a public
> datasheet right now, but e.g. the MT53E1536M32DDNQ-046 WT:A part
> offers two 16-bit channels that have two ranks each, where rank 0 is 8
> Gbits and rank 1 is 16 Gbits for each channel (6 GB part in total).

Ah, got it. I re-read your email and I see my confusion. I thought in
your example there were a total of 4 chips in the system, but there
were actually 8 chips. You were definitely explicit about it but I
still got confused. :( I was somehow assuming that you were saying
that each channel was 32-bits wide but that we were only connecting
16-bits of it.

OK, then what you have seems OK. Personally I guess I'd find it a
little less confusing if we described it as "num-chips" or something
like that. I guess that would make me feel like the io-width could
stay where it is and describe the full width, like maybe for your
original example:

lpddr2-channel0 {
    compatible = "jdec,lpddr2-channel";
    #address-cells = <1>;
    #size-cells = <0>;

    rank@0 {
        reg = <0>;
        compatible = "jedec,lpddr2";
        density = <2048>;
        io-width = <32>;
        num-chips = <2>;
    };
    rank@1 {
        reg = <1>;
        compatible = "jedec,lpddr2";
        density = <1024>;
        io-width = <32>;
        num-chips = <2>;
    };
};


> > I'm happy to let others chime in, but one way to do this would be to
> > put the super common properties (density, width, etc) in a common file
> > and have it "included" by everyone else. See
> > `bindings/spi/spi-controller.yaml` and then see how all the SPI
> > controllers "reference" that.
>
> Okay, that should work. I don't think there would be any differences
> other than the compatible strings right now (and maybe which values
> are valid for each property... not sure if that can be distinguished
> while still including shared definitions?), but I can write them as
> three dummy binding files that contain nothing but a compatible string
> and an include.

They do have different sets of values valid for each property. The
properties are annoyingly not sorted consistently with each other, but
I think there are also different sets of properties aren't there? Like
I only see tRASmin-min-tck in the LPDDR2 one and not LPDDR3.

I was suggesting keeping most of the current stuff separate between
DDR2 / DDR3 / DDR4 and only putting the bare minimum "this is clearly
something you'd describe for any memory chip" in a common place...

-Doug
