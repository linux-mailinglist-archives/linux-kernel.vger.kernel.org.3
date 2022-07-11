Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2A9A57012E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 13:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbiGKLvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 07:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbiGKLvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 07:51:06 -0400
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6107F11827;
        Mon, 11 Jul 2022 04:51:01 -0700 (PDT)
Received: by mail-qk1-f178.google.com with SMTP id g1so3576210qkl.9;
        Mon, 11 Jul 2022 04:51:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xTIxfzVYvQSQBWGEAyJsa64Sv2ORsLUEzdvEludKZ5E=;
        b=cprsFO6vDQfY52CiDfK/TqMzlVFGbLMjQHi7YjqlLph3PoWIMHzI2PXHsKs/Wpxtn/
         FXqjuG3M495bKLxYvfrqlI4suzaftrNZl4q2i8jNOw/JFE2PV2UMG/rvZ/y/zRUlN/Rw
         Qmg2gnrctVdWAOSHh4G6rb6MS9+2qcSLOvnAF87vKMkR7iO9w/Jd9kUPRxg4c40jeVUg
         jr66/ErdjVytiwJ6UzBPLHP4ebHksZJXMZS/ltfGF2Pz/ld1Og9nkdpdYY3vuOiy1uMH
         s2PKlH05Odw1SlSDwkvvshFfod6VY46WcRCzbF5TVBME66PeLM1jj7qvkewmUl0ia0Ei
         ps+w==
X-Gm-Message-State: AJIora/9k7g1B4vUKuIWvG1z/s2EiuIKsHyT78iKu2egAWso29na05+j
        KmI1eU4bUsklDoPjBQ9fCfGk/vaQM4G40w==
X-Google-Smtp-Source: AGRyM1taGynhTBsH6+IpPqZOvYlFS2TuYzQRerkpADhMuw+62U55RHy4NnSYgafo5eiCtVoUumCl1w==
X-Received: by 2002:ae9:e402:0:b0:6a7:86a3:752e with SMTP id q2-20020ae9e402000000b006a786a3752emr10940210qkc.300.1657540260104;
        Mon, 11 Jul 2022 04:51:00 -0700 (PDT)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id k18-20020a05620a415200b006b58fce19dasm1363678qko.20.2022.07.11.04.50.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jul 2022 04:50:59 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id l11so8237896ybu.13;
        Mon, 11 Jul 2022 04:50:59 -0700 (PDT)
X-Received: by 2002:a25:2b48:0:b0:668:3b7d:326c with SMTP id
 r69-20020a252b48000000b006683b7d326cmr16333764ybr.380.1657540258983; Mon, 11
 Jul 2022 04:50:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220707182314.66610-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220707182314.66610-6-prabhakar.mahadev-lad.rj@bp.renesas.com> <CACRpkdbhDJq9bJKHM=1pq5+HrVasrT_WuqtAxGWFfnAXMWSr8g@mail.gmail.com>
In-Reply-To: <CACRpkdbhDJq9bJKHM=1pq5+HrVasrT_WuqtAxGWFfnAXMWSr8g@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 11 Jul 2022 13:50:47 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXqK7Snk6=+VNhq59SLgv-zRCgwrkABMtC5JOpX02fuVg@mail.gmail.com>
Message-ID: <CAMuHMdXqK7Snk6=+VNhq59SLgv-zRCgwrkABMtC5JOpX02fuVg@mail.gmail.com>
Subject: Re: [PATCH v8 5/6] dt-bindings: pinctrl: renesas,rzg2l-pinctrl:
 Document the properties to handle GPIO IRQ
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Prabhakar Lad <prabhakar.csengg@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Rob Herring <robh@kernel.org>
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

Hi Linus,

On Mon, Jul 11, 2022 at 1:36 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> On Thu, Jul 7, 2022 at 8:25 PM <prabhakar.csengg@gmail.com> wrote:
>
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Document the required properties to handle GPIO IRQ.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Reviewed-by: Rob Herring <robh@kernel.org>
>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>
> Is this already queued in Marc's branch targeted for next
> so I don't need to do anything with the pinctrl patches?

I don't know; I was wondering the same thing ;-)

The gitweb link in the bot email does not work:

    Commit-ID:     35c37efd12733d8ddbdc11ab9c8dbcee472a487f
    Gitweb:
https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/35c37efd12733d8ddbdc11ab9c8dbcee472a487f

The actual commit seems to exist in that repo, but using the web
interface, it is difficult to find out to which branch it belongs.

It is also not part of next-20220711.

Anyway, it's too late for me to take the pinctrl parts for v5.20 (saw
no ack from Marc before the bot emails), so if it finds a different
path upstream, I'm happy ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
