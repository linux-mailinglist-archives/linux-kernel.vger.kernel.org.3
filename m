Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A45AD4D13E7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 10:53:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345388AbiCHJyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 04:54:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232116AbiCHJyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 04:54:11 -0500
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E68EE34B93;
        Tue,  8 Mar 2022 01:53:15 -0800 (PST)
Received: by mail-qt1-f178.google.com with SMTP id a14so2726584qtx.12;
        Tue, 08 Mar 2022 01:53:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RhnnNRTUQhZ66DiV0sFKGErrjIL8uzqVLKi9U1XyIMU=;
        b=67a9/olw7Lui86qnC8r6WCSUTlNFBD0ajR0SUMXISia9ODkBCfvNeRfofNmEZKM3wU
         zDCHfZjeNcE51Y+rIfZtoeh64Ek8cs041+xk79xvFB1faSqYa2Il9hoIKBi7bMPrbSkx
         EYcCTMf4uepmb+APeBRENBhregIFFjDBelaf7AeFtVvHiEbOHRZNGE1c1uXiVEoYx3v6
         6knwe9cBfs4YulG4ccg/QPGx0S9yIZEiGiR5HDyZQnqkIyWmuMZ/LV+RKdGRCC7LG9/n
         nAhY6SP6o9Ymf+WKPP62r7A+06iWr2qyEL8Tggq4vsgOdk3NgyMxRItwCos6Fy8HLqRQ
         lF5g==
X-Gm-Message-State: AOAM530U7UFY/BnhldFP4JaDouWev2xOIXT+oFW7tIOpskuwIkysGtNl
        K5IzFEZ9ml/yrbjt7V928qLB32IOrpowMg==
X-Google-Smtp-Source: ABdhPJxAM/RrpROx9BNYQugwuKU7LEzbGQw+a4KKOhS0kVbUseOgmmL9XBqkF5xN8JzSmUEOcP/v0Q==
X-Received: by 2002:a05:622a:164b:b0:2e0:769e:fa2a with SMTP id y11-20020a05622a164b00b002e0769efa2amr404124qtj.343.1646733194799;
        Tue, 08 Mar 2022 01:53:14 -0800 (PST)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com. [209.85.128.171])
        by smtp.gmail.com with ESMTPSA id n13-20020ac85b4d000000b002de6fe91d2fsm10228796qtw.68.2022.03.08.01.53.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 01:53:14 -0800 (PST)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-2dbfe58670cso195106257b3.3;
        Tue, 08 Mar 2022 01:53:14 -0800 (PST)
X-Received: by 2002:a0d:f1c7:0:b0:2db:d2bc:be11 with SMTP id
 a190-20020a0df1c7000000b002dbd2bcbe11mr11992421ywf.62.1646733193799; Tue, 08
 Mar 2022 01:53:13 -0800 (PST)
MIME-Version: 1.0
References: <20220301190400.1644150-1-robh@kernel.org> <CAMuHMdXqsvQy_6+6w8DVCtqNiFERPV29xd3HRqtyz9RY3KXOYw@mail.gmail.com>
 <CAL_JsqKX7XrSS1OktT6OfPgyxte6_+AcGh4uV0Abdf2Wi4eCFg@mail.gmail.com>
In-Reply-To: <CAL_JsqKX7XrSS1OktT6OfPgyxte6_+AcGh4uV0Abdf2Wi4eCFg@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 8 Mar 2022 10:53:02 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXzNpjSjhT3crdN3XzcFNXd8Uojqo8gA7Y=Qtz8utH6Mw@mail.gmail.com>
Message-ID: <CAMuHMdXzNpjSjhT3crdN3XzcFNXd8Uojqo8gA7Y=Qtz8utH6Mw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: clock: renesas: Make example 'clocks' parsable
To:     Rob Herring <robh@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

Hi Rob,

On Fri, Mar 4, 2022 at 2:28 PM Rob Herring <robh@kernel.org> wrote:
> On Fri, Mar 4, 2022 at 3:09 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Tue, Mar 1, 2022 at 8:04 PM Rob Herring <robh@kernel.org> wrote:
> > > 'clocks' in the example is not parsable with the 0 phandle value
> > > because the number of #clock-cells is unknown in the previous entry.
> > > Solve this by adding the clock provider node. Only 'cpg_clocks' is
> > > needed as the examples are built with fixups which can be used to
> > > identify phandles.
> > >
> > > This is in preparation to support schema validation on .dtb files.
> > >
> > > Signed-off-by: Rob Herring <robh@kernel.org>
> >
> > Thanks for your patch!
> >
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >
> > Do you want me to queue this in renesas-clk-for-v5.19, or do you
> > want to take it yourself, together with the validation patches?
> > Please let me know.
>
> You can take it.

Thanks, queuing in renesas-clk-for-v5.19.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
