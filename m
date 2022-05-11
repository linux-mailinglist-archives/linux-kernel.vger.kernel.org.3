Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE6C522A10
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 04:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236358AbiEKCst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 22:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243183AbiEKCjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 22:39:55 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8282920F4C4
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 19:39:54 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id k2so1003380wrd.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 19:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KimymyJktXOor657BlbrRRjA7HWKVOcx61gbNhrB/7o=;
        b=ZTskdwHe7UUDxCjjzUIP50Srj0RKN2OBSf66044H+HXptMv9A605OSh25vJ7YOdG+P
         8CWFNQSjC2CX4AMryGeDeVV/PLLXxV1NLtCivoeweCvK1w2iEyV8sdWQ666XzLfFtrY+
         67SgDnkPzBDpl5rbl639zMJ/yn2uOnWvm9s5Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KimymyJktXOor657BlbrRRjA7HWKVOcx61gbNhrB/7o=;
        b=ht+DzSMSAcecn+tpIF/Evj0/UrsKKP+ck7dOqOEmCuDmge/a9CGIHs7zKqZaU56YCM
         GZwmoyT5zx0JunvykfjE3hAcwB7lmmoHj8XdhUfKWeJOM4W/JFpqySoKzMWQuVDTcsJT
         OPwgtPUFQiZo7eNY2IWek4hAp3Qw4aJkptO4yqh8udiKgoFs5x4lr42oci1eO76IUHqG
         1ZYISxWtT6iKNsk3fEkBgM3rCqTumWc6H9135w1TL3NcvoBA1KHh7j/w7Be9iQTiIsBH
         VsyZ9GatAwWiU69kRcSAcATGH4pDihw00+5f7TGM2TUnKd9sKylj0h7tr1LGf7Btqqv2
         Rgtw==
X-Gm-Message-State: AOAM530+EcNZw+E4mkCD1J17Rmm5NO5Sf4IdFhfYM1BZWZRca5srrDpM
        QgCvd0yIM2sKm5WZFxArXPsBq8fvrcUmTLN4at6u6g==
X-Google-Smtp-Source: ABdhPJyE21AqoP29m/WgP+FLL3uuTZ5ahlHZq51uPrAhbthHgig5xYN633m5PWpnaxVRM9I3YPxOQ1caQeVnDqhrN+Y=
X-Received: by 2002:adf:fb03:0:b0:20a:e253:b8c7 with SMTP id
 c3-20020adffb03000000b0020ae253b8c7mr20282047wrr.119.1652236792930; Tue, 10
 May 2022 19:39:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220330090947.9100-1-chenxiangrui@huaqin.corp-partner.google.com>
 <a0eb6bf9-256a-29b1-2211-496df710f531@linaro.org> <CAD=FV=UjyLofXZqnj=bL89fza5JS6O5Np9W-A4V4WK+na0hdrw@mail.gmail.com>
 <b7ff08b8-60fb-7629-9399-3d5cca46ab9e@linaro.org> <CAD=FV=Vx5g_xTRZGc9wW=ZLnfsOcubTYFcnYQRC5jLm+n3en0w@mail.gmail.com>
 <606cc762-a0c2-49a4-3e5d-d2dbd4595bc7@linaro.org> <CAD=FV=W_SA-3PfDFi-Gkjk9pew5bchFNjQhXX8MkZyuy5UohEQ@mail.gmail.com>
 <CAJKOXPdt5WTg4VU-TEW3dmPHR76dKg63XVxRQfa7ZSKc_jz6Ag@mail.gmail.com>
 <CAD=FV=XQqQSQDNh-zXqEQkwsrax5Qb3OtfKZoQLkncJj_4mcQw@mail.gmail.com>
 <daf66d41-42ac-50dc-3f8d-c261da8e452d@linaro.org> <CAD=FV=WhA=n_=Ys6NfedPtNPddL81HnG6Qws_R+vq9w8Nrsn5A@mail.gmail.com>
 <ce2ea308-b63d-ad27-4cea-7353268f8ebb@linaro.org>
In-Reply-To: <ce2ea308-b63d-ad27-4cea-7353268f8ebb@linaro.org>
From:   Julius Werner <jwerner@chromium.org>
Date:   Tue, 10 May 2022 19:39:41 -0700
Message-ID: <CAODwPW857CkH0+ZnBaUeowW4te-hSy6nrdeeX6-OLPOs5TptsQ@mail.gmail.com>
Subject: Re: [PATCH] CHROMIUM: arm64: dts: qcom: Add sc7180-gelarshie
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Doug Anderson <dianders@chromium.org>,
        =?UTF-8?Q?Krzysztof_Koz=C5=82owski?= <k.kozlowski.k@gmail.com>,
        Mars Chen <chenxiangrui@huaqin.corp-partner.google.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Julius Werner <jwerner@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Wait, we agreed that you don't consider them identical, didn't we? If
> they are identical, you do not need rev4 at all. So they are not
> identical...

Well, they are identical until they're not. We intend them to be
identical. But for practical purposes it does sometimes happen that
two board revisions which were meant to be indistinguishable by
software end up needing to be distinguished at a later point, when
both the hardware and firmware can no longer be changed. We need to
allow an escape hatch for that case. It does not happen often, so just
treating them all as separate boards from the start is not a scalable
solution. DTBs are not free when they all need to be packaged in the
same kernel image.

> Right now it's not possible to validate QCOM DTSes against DT bindings
> because they throw big fat warnings about undocumented top compatibles.
> This is a downside for us.

But that's a solvable problem, right? As I understand, what Doug was
initially just asking was whether it made _sense_ to document all of
these... not that we couldn't do it. Then this whole thread went down
a rabbit hole of whether our compatible assignments are allowed in the
first place. If we can compromise on this discussion by just doing
whatever needs to be done to make the tool happy, I think(?) we can
provide that.

> Remember, you do not have to use Devicetree or Linux at all if it causes
> you some downsides... No one is forced. :) If you choose to use it,
> sorry, it comes with some requirements like being following Devicetree
> specification or the binding guidelines.

Woah... that is maybe a bit extreme, don't you think? My understanding
was that Linux tries to support a wide variety of platforms and
devices and can make the necessary compromises where needed to stay
practical. I'm sure you are aware of the numerous hacks, workarounds
and special cases throughout the kernel that enthusiasts put in there
to get their favorite platform working, even if the original
manufacturer never bothered to test with anything but Windows and
blatantly violates common standards. Or how the USB stack has a file
listing custom quirks for hundreds of individual device IDs just to
make hardware work that didn't put any effort into following the spec.

We're not even asking for any of that -- we're here, engaging with you
and trying to find the best way for our platforms to fit cleanly into
your model. All we're asking is to please offer some way that makes
accommodations for the necessary practical concerns that come up when
building devices at our scale. We're open for new suggestions, but
they need to stay within the realm of what we can practically do (e.g.
not ship a wholly separate DTB for each board revision, because that
would grow the kernel image beyond what can fit in the kernel
partitions on our platforms, and would create a notable extra cost in
boot time for our users).

Besides, I don't actually see how this violates the Device Tree
specification? All I see it say about the toplevel compatible property
is that it

> Specifies a list of platform architectures with which this platform is co=
mpatible. This property can be used by operating systems in selecting platf=
orm specific code.

It doesn't say anything about having to uniquely identify the platform
architecture even if a more generic identifier is good enough to make
all necessary platform-specific code choices for the operating system.
In fact, about compatible properties in general the specification says

> The property value consists of a concatenated list of null terminated str=
ings, from most specific to most general. They allow a device to express it=
s compatibility with a family of similar devices, potentially allowing a si=
ngle device driver to match against several devices.

Which implies that using a more generic string to cover multiple cases
at once is an intentionally allowed use case.
