Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2F5954D3AE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 23:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347860AbiFOV1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 17:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237423AbiFOV11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 17:27:27 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE575621D
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 14:27:25 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id w17so9469752wrg.7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 14:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BPF4o7sLOFsJSmN4SPO/juaDAdyVg3hHUH3VwC4Ah5A=;
        b=As3v3yyTP4c1H2WamQXtagSPpLm/T0AQiRpx/sXZPbAFz4c8+7Itm/3B5JI9Wot1Jk
         atgSKcsRE61zeiY2qhpUF7E9U68/F02Be2/SobaFyjxRdddBOS+Im3Ddofr7E+WLpB3O
         ucpqHRbcGc7QPWlQKqZzbKrxQymh4Qfq9kOPY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BPF4o7sLOFsJSmN4SPO/juaDAdyVg3hHUH3VwC4Ah5A=;
        b=YHnCdN3TkePCid6kt2xp6Qj4i9Cow4ZP78g/Mt0tjJGEGEg91oMv4qk6llcCVUbLSW
         yMq12LY4zX89E0FZzlsPd1vFP96VgBqvI/FpCpXqrXemuvATIUV6CLiWL3bStwwZxfiD
         cF5KQVJ3niniDQe/ePkJV4zlZlNu81kPe+wYnVz0Vs4xVQejVb2HP4g7cvw0Xlyncj74
         IGtG0qIEvbxxPsHVc8DYBvha4MHuj6eyblMSlhIJxfkTxEnSdkrFinUbsLvunDrBMOln
         6oPyyEB8MuM9L6IIxWxoVNAD3Acja1pTjuZH5JrkS79rc2L0Fn5KORtRNfmu5c830oPT
         3ykQ==
X-Gm-Message-State: AJIora89FWexhNU4QVhZXsADM8cKqkocXlIcAgRjC8ZtIPUV/4D/yWIN
        jPLjU7rdzg1EWLazBxx2x5PXTU4qWKClLzgyETKN/Q==
X-Google-Smtp-Source: AGRyM1v4ANlH7LhwVu51I3oLbGKooh3SiqVw+IV+zQM6Y1o8c0uh0vN8qrZnqVKOlQmoljFG+KZvCPvNV1gfuyTpoPk=
X-Received: by 2002:adf:d1c2:0:b0:218:5736:63d9 with SMTP id
 b2-20020adfd1c2000000b00218573663d9mr1544472wrd.667.1655328443819; Wed, 15
 Jun 2022 14:27:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAODwPW9E8wWwxbYKyf4_-JFb4F-JSmLR3qOF_iudjX0f9ndF0A@mail.gmail.com>
 <CAODwPW8fiFSNehZbZDdR9kjHxohLGiyE7edU=Opy0xV_P8JbEQ@mail.gmail.com> <CAD=FV=XAYUx9OKLxThQxYr02ZE+7Rjw0VnSsxg7kfPCBG38FZw@mail.gmail.com>
In-Reply-To: <CAD=FV=XAYUx9OKLxThQxYr02ZE+7Rjw0VnSsxg7kfPCBG38FZw@mail.gmail.com>
From:   Julius Werner <jwerner@chromium.org>
Date:   Wed, 15 Jun 2022 14:27:12 -0700
Message-ID: <CAODwPW_6A3kcmTLHVnH19bdYKpVBadAcDk5g-qxuju04uPRcMg@mail.gmail.com>
Subject: Re: [RFC] Correct memory layout reporting for "jedec,lpddr2" and
 related bindings
To:     Doug Anderson <dianders@chromium.org>
Cc:     Julius Werner <jwerner@chromium.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Jian-Jia Su <jjsu@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Nikola Milosavljevic <mnidza@outlook.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-10.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Two comments about the above:
>
> 1. It seems like the top-level node should have a compatible of some
> type. Without that I guess you're just relying on people to find it
> based on the name of the node?
>
> 2. Why not put the `channel-io-width` property in the channel? Then
> you don't need to repeat it for each rank that's under the channel?

Yes, we could do it that way. That seemed a bit more complicated to
me, but if there's precedent for that in other devices it's probably
the right thing.

> 1. In the above the two ranks are in series, right? ...with a chip
> select to select rank0 vs rank1? From how SPI works I'd expect that to
> be represented using "reg", AKA:

I wouldn't call it "in series" (rank is just a separate dimension of
its own, in my mental model) but yes, if you think they should also be
named with a property inside the node (and not just distinguished by
node name), we can do that. Using "reg" for this feels a bit odd to
me, but if that's common device tree practice we can do it that way.

> 2. I guess if you had two things in parallel you'd want to know how?
> Maybe if you had 4 8-bit chips connected to a 32-bit channel maybe
> it'd look like this: [...]

I think the channel-io-width mechanism is sufficient to distinguish
this (by dividing by io-width), so I don't think there's anything to
gain from listing each of these parallel chips separately. This also
more closely reflects the way the memory training firmware that's
writing these entries actually sees the system. The way I understand
it, from the memory controller's perspective there's actually no
difference between talking to a single 32-bit chip or two 16-bit chips
in parallel -- there's no difference in register settings or anything,
both software and hardware are totally unaware of this. This is all
just implemented by wiring the respective components together
correctly in the board layout (split the DQ pins between the two
chips, and short all the other pins like clock and chip select
together). When reading the mode register value, the controller only
reads the first chip's register (which is connected to DQ[0:7]). When
writing a mode register, the one Write Mode Register cycle will write
all chips at once (because the written value is transferred through
the column address pins which are shorted together between all chips).
So if we were to pretend in the FDT that we had separate density and
io-width values for each chip, that's kinda disingenuous, because the
firmware can only read one of them and just assumes that it applies to
all chips in parallel on that channel. The only way the firmware could
know how many chips there are in parallel would also be by dividing
the width of its channel by the io-width reported by the chip -- so I
think it would be more honest there to just report those two "original
source" values to the kernel / userspace and let them make that
deduction themselves if they care to.

> ...and I guess you could have things that include serial and parallel hookups...

Sorry, just to avoid having more confusion here: there is no "serial"
dimension to this as far as I'm aware (in my original email I called
the "several chips per channel" thing "in series", but you are right
that it would really be more accurate to call it "in parallel").
There's only three dimensions: a) multiple channels (totally separate
sets of pins coming out of the controller), b) multiple chips per
channel (splitting e.g. 32 pins from the controller onto two 16-pin
parts), and c) multiple ranks within each chip (which chip select pin
is asserted in each access cycle).

> > > This would be describing a dual-channel, dual-rank layout where each
> > > 32-bit channel is connected to two 16-bit LPDDR chips in series. The
> > > total capacity would be (2048 Mbits * (32/16) chips + 1024 Mbits *
> > > (32/16) chips) * 2 channels = 12Gbits.
>
> Just to make sure I'm understanding things: in your hypothetical
> example we're effectively wasting half of the SDRAM bandwidth of the
> controller, right? So while what you describe is legal you'd get a
> much more performant system by hooking the two big chips in parallel
> on one channel and the two small chips in parallel on the other
> channel. That would effectively give you a 64-bit wide bus as opposed
> to the 32-bit wide bus that you describe.

No, I don't think you're wasting bandwidth. In my example the
controller has two 32-bit channels, so it always uses 64 bits of
bandwidth in total. There's no asymmetry in the "chips per channel"
dimension in my example (maybe that was a misunderstanding due to our
different use of "in series" vs "in parallel") -- in fact, there can
never be asymmetry in that dimension, when you split a channel onto
more than one chip then those chips always must be exactly equal in
geometry and timings (because, as mentioned above, they all get
initialized the same way with parallel Write Mode Register commands).
Asymmetry can only come in at the rank or channel dimension.
(Asymmetry there may have a minor performance penalty since you'd be
limiting the amount of rank or channel interleaving the controller can
do, but it would be an indirect penalty that depends on the access
pattern and not be anywhere near as bad as "half the bandwidth".)

Anyway, whether it's a good idea or not, these parts definitely do
exist and get sold that way. I can't find an example with a public
datasheet right now, but e.g. the MT53E1536M32DDNQ-046 WT:A part
offers two 16-bit channels that have two ranks each, where rank 0 is 8
Gbits and rank 1 is 16 Gbits for each channel (6 GB part in total).

> I'm happy to let others chime in, but one way to do this would be to
> put the super common properties (density, width, etc) in a common file
> and have it "included" by everyone else. See
> `bindings/spi/spi-controller.yaml` and then see how all the SPI
> controllers "reference" that.

Okay, that should work. I don't think there would be any differences
other than the compatible strings right now (and maybe which values
are valid for each property... not sure if that can be distinguished
while still including shared definitions?), but I can write them as
three dummy binding files that contain nothing but a compatible string
and an include.
