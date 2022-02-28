Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2FBF4C7B44
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 22:03:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbiB1VDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 16:03:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbiB1VDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 16:03:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF062B240;
        Mon, 28 Feb 2022 13:02:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2483A60FB8;
        Mon, 28 Feb 2022 21:02:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EF2FC340F4;
        Mon, 28 Feb 2022 21:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646082175;
        bh=VZBP/n5mMCzFS82LeGWNgCwBAvcayN+a60oyEM3zI10=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZScFoXS0ZyN/43hbUGvbiPcAUOzmZi17c9MzKnstPv2k/5GjsIHX81yt+BHSK80kM
         0JA1hog7ZgzwN78vY0+opHr9tplO8MdbIHddXTwg8r3oq9rrC5Gqd1duEefR1L2N52
         nqc9zz8HUkP+8Id/LVYArq6uf6X0eB2pwUjH0NHBmF0ovunS4yeo/15IfmWkqhJHsZ
         1XBMBx/1tVHBjIecW//SL/vgZJEy1alnHfPHZkQsr+aaUOgIknivBYKesIY9aqg2oP
         Y5toxly29HkwNkVkjoF3AKoatR5ns2tG1BmAqJlwmYTwjYogBFS6J02A23hsLtgiiH
         GJTtG/cEeLl/Q==
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-2dbd97f9bfcso5236557b3.9;
        Mon, 28 Feb 2022 13:02:55 -0800 (PST)
X-Gm-Message-State: AOAM5311jtiVwFC/SG+P4K0O8avlNKBUGkVs56Z+dZYWvZLEZ8yKVA6Z
        aO5JPbOtDh8syW7XpTWSyXCBFFQSjpnC4MfL66Q=
X-Google-Smtp-Source: ABdhPJz7wyf8c9zkEn3wAh3JUOqNxojQRB0GSNbuSANIiNR9gRel4B4G58jsBjOLyh+1wcqefAkOWU/x48bTM8mBMHw=
X-Received: by 2002:a81:84d5:0:b0:2d1:e85:bf04 with SMTP id
 u204-20020a8184d5000000b002d10e85bf04mr22378323ywf.465.1646082174505; Mon, 28
 Feb 2022 13:02:54 -0800 (PST)
MIME-Version: 1.0
References: <CAHmME9qHnvwrxEue4Pdm_E1qZQGXFuR9orJSKCWj8fH5TSh6fA@mail.gmail.com>
 <20220228183355.9090-1-Jason@zx2c4.com> <CAHp75VcjrD3kwN1BfWpjKXaVpG7MHfftMUscSGhcJfStm4b-Xg@mail.gmail.com>
In-Reply-To: <CAHp75VcjrD3kwN1BfWpjKXaVpG7MHfftMUscSGhcJfStm4b-Xg@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 28 Feb 2022 22:02:43 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFmEAKJRHCiuXyGECCmOs0+xX9AVeBDxfuD0XuX2TQ2Uw@mail.gmail.com>
Message-ID: <CAMj1kXFmEAKJRHCiuXyGECCmOs0+xX9AVeBDxfuD0XuX2TQ2Uw@mail.gmail.com>
Subject: Re: [PATCH 2/3 v6] ACPI: allow longer device IDs
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-crypto <linux-crypto@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Alexander Graf <graf@amazon.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Feb 2022 at 21:47, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>
> On Mon, Feb 28, 2022 at 9:28 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> >
> > From: Alexander Graf <graf@amazon.com>
> >
> > We create a list of ACPI "PNP" IDs which contains _HID, _CID, and CLS
> > entries of the respective devices. However, when making structs for
> > matching, we squeeze those IDs into acpi_device_id, which only has 9
> > bytes space to store the identifier. The subsystem actually captures the
> > full length of the IDs, and the modalias has the full length, but this
> > struct we use for matching is limited. It originally had 16 bytes, but
> > was changed to only have 9 in 6543becf26ff ("mod/file2alias: make
> > modalias generation safe for cross compiling"), presumably on the theory
> > that it would match the ACPI spec so it didn't matter.
>
> > Unfortunately, while most people adhere to the ACPI specs, Microsoft
> > decided that its VM Generation Counter device [1] should only be
> > identifiable by _CID with a value of "VM_Gen_Counter", which is longer
> > than 9 characters.
>
> Then why do we not see the ECR from somebody to update the spec or to
> fix MS' abuse of it?
> I believe _this_ should be the prerequisite to the proposed change.
>

What exactly are you suggesting here? That the contributor of this
patch joins the UEFI forum as an individual adopter in order to get
the ACPI spec updated before we can advance with this patch? Or that
he works with Microsoft to get them to refrain from violating it?

I don't think that is reasonable or realistic. The kernel is already
riddled with UEFI and ACPI quirks that are only there because some
teams at MS don't take the ACPI spec too literally (which is why they
have their own AML compiler, for one), and PC vendors only care about
the Windows sticker, so they don't care about the ACPI spec either.

So I don't think this is the right time to get pedantic about this.
Our ACPI subsystem already deals with CIDs that are longer than 8
characters (which are btw permitted by the ACPI spec for bus topology
related metadata), the only thing being changed here is the ability to
actually match against such identifiers.
