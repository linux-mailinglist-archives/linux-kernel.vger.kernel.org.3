Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE394B6333
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 06:56:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233814AbiBOF4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 00:56:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbiBOF4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 00:56:39 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D2064132C;
        Mon, 14 Feb 2022 21:56:30 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id l14so17611692qtp.7;
        Mon, 14 Feb 2022 21:56:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uPUj/2D0fnRRHEGsxfFw4uPYjIMmB8m7B7g+xVLuCTs=;
        b=e7EkjOF9JnmPm2zvwdTKMlYivOB6v4VFpWSOnTeskfEh9TmfPrj9ow39Zv8UTTKTDD
         GCALVJO2THsTZ9IRY73lRRhUJettrYNXO6G+v6eI7xNrz6nwh2hfeArS1DWLdU54W3r1
         XqSl0wO9nM2J38wWwIORRLsAWma/NjrwNvmXU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uPUj/2D0fnRRHEGsxfFw4uPYjIMmB8m7B7g+xVLuCTs=;
        b=HcjgLb8AY/Ac1hwF5vbb+bjj0+y03s3EcStNpkJLJUwaoEEAyR29JhNv110l5/5KWe
         7iZ7sqhoNAl4DyBuyLh3ekaEpTmh8ZUN9AmaJfsJxcgiMm74iwjN/LF63c/ciWC1kOEq
         wbIGe9Z9GKImqGO9rMsUKBVfAhMD0oluYahZzoN4AF6pLW7gP7ikqD1UH684BfkLNB6n
         GwkDam8jbXW07w9dhB/r+iQlDLKJmYRfcv7zCUHQZN+LOxJP/tx5Z17w7dPz2Fk8Vfcr
         KlUmPZdgBoG7CjUWf2RmomnsfrLHKJGKpPILynY08JjZmgZYc20QfykPsmDcaymyuV4w
         Tq0g==
X-Gm-Message-State: AOAM5318075vXVHvyjESPXrxDpu+jZSxKD17z/JErlATvuC3epeeDUQ/
        xzixCsMkIj75YfYebtduXoBXQHRBYR6GzJcTmfw=
X-Google-Smtp-Source: ABdhPJxDiNItJktz4LNO+XrPyLIgW4R0iAfyKu+KkaTWOe+XGOJYyD101ljPiR6VxTVgla4El5GLg42q9jEpkrRZCeQ=
X-Received: by 2002:ac8:7e91:: with SMTP id w17mr1635736qtj.678.1644904589150;
 Mon, 14 Feb 2022 21:56:29 -0800 (PST)
MIME-Version: 1.0
References: <20220129115228.2257310-1-j.neuschaefer@gmx.net>
 <CACRpkdYEigGHkoGfBg15tFXadgpXUAjDOnw7ePXhmvHJqPEJXw@mail.gmail.com>
 <YfZkis8M81Ejpagq@latitude> <CACPK8XdFXRQf3MpPh3z=EMAKtnQSHL+iwwMCVYc5dP9DfQEN+Q@mail.gmail.com>
 <YfpyjDBH83FE7r4o@latitude> <CAHp75Vdg8zFSHaTP_8jQua5QfRYbvZ4_rLdCtt3ks8YEibseTg@mail.gmail.com>
 <YgdyjUbb4lnrVHmJ@latitude>
In-Reply-To: <YgdyjUbb4lnrVHmJ@latitude>
From:   Joel Stanley <joel@jms.id.au>
Date:   Tue, 15 Feb 2022 05:56:17 +0000
Message-ID: <CACPK8Xe-t8Qso_AX+q08OxrgmUPbEayhnHXH5xiLr7M6rDxjuw@mail.gmail.com>
Subject: Re: [PATCH v5 0/9] Nuvoton WPCM450 pinctrl and GPIO driver
To:     =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Avi Fishman <avifishman70@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Feb 2022 at 12:05, Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.n=
et> wrote:
>
> On Wed, Feb 02, 2022 at 02:10:44PM +0200, Andy Shevchenko wrote:
> > On Wed, Feb 2, 2022 at 2:01 PM Jonathan Neusch=C3=A4fer
> > <j.neuschaefer@gmx.net> wrote:
> > > On Tue, Feb 01, 2022 at 11:42:11PM +0000, Joel Stanley wrote:
> > > > On Tue, 1 Feb 2022 at 13:05, Jonathan Neusch=C3=A4fer <j.neuschaefe=
r@gmx.net> wrote:
> >
> > ...
> >
> > > > I assume you're sending a v6 to fix some of the warnings?
> > >
> > > No, the warnings are fairly independent of this patchset, it's just t=
hat
> > > the adjacent pinctrl-npcm7xx driver started to be built by the bot, d=
ue
> > > to my Kconfig change. I'll fix them in a separate patchset.
> >
> > I guess you need to fix that first.
> >
> > Because now and then all CIs will complain to your patch and confuse pe=
ople.
>
> FWIW, Linus has applied the npcm7xx fixes to for-next in the pinctrl tree=
,
> which means that they are not blocking this patchset anymore, AFAICS.

I've applied the device tree changes, and I will send a pull request
for v5.18 with those.

I assume you want Linus to merge the pinctrl bindings and driver
through his tree.

Cheers,

Joel
