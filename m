Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 862934C7D32
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 23:17:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbiB1WSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 17:18:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbiB1WSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 17:18:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7BD314CCB1;
        Mon, 28 Feb 2022 14:17:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 75098612B9;
        Mon, 28 Feb 2022 22:17:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDDFBC340EE;
        Mon, 28 Feb 2022 22:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646086655;
        bh=+5Ebaf1JgAKThev9+rJsx/+iCNaZXo9JRDOsYWl+xZo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XbML9xM8oQ6cCAwFZGfBFfnDyUl1U9fU3NazvmKVk6SjN1YCs5UBDQx6g7n7a5ckP
         dL+lkTGu6d8If5vQcwUQDTtewaE52rHjhDkXIP/z/dmk7jBr+m+UkRTquCYGagkPvb
         +yZnQ87m5hUKx+84J6hKHuK9fagTfsXRIjlmO0uzsGIRKrKi7mLtqfI4K/EkQH/v5A
         xSJepxznPLhk9n4e8BtU5FxcXV7JOJcdanzAcXHRjU97nRpZ85UsSgDmL2kKWE9fvq
         6Vt6rjAtIYysSPr7Svl8TntSwGmraV1PZ1ej0b6sAmx1aY/AKv+DhLOd/KR7mTyZLx
         r6hSr30mJMxPw==
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-2d07ae0b1bfso124991567b3.6;
        Mon, 28 Feb 2022 14:17:35 -0800 (PST)
X-Gm-Message-State: AOAM532MhSEttMjkUG6qBwGBHvvg84SG0vPlxh76gAGpJwx6J0Bflq3Z
        INXXerXNkp+0ccQOla2cQGI68oh3LseHOOF+dRs=
X-Google-Smtp-Source: ABdhPJzH0G05phRTtNIqLFFIX6jMLkHugtQfeZmwrLVH4ng2M6z7TPcqsieJ40ykSjjDx2Oap4kMpwv3iDxrtUZDOO0=
X-Received: by 2002:a81:1413:0:b0:2d9:d452:9c6a with SMTP id
 19-20020a811413000000b002d9d4529c6amr16304344ywu.231.1646086654884; Mon, 28
 Feb 2022 14:17:34 -0800 (PST)
MIME-Version: 1.0
References: <CAHmME9qHnvwrxEue4Pdm_E1qZQGXFuR9orJSKCWj8fH5TSh6fA@mail.gmail.com>
 <20220228183355.9090-1-Jason@zx2c4.com> <CAHp75VcjrD3kwN1BfWpjKXaVpG7MHfftMUscSGhcJfStm4b-Xg@mail.gmail.com>
 <CAMj1kXFmEAKJRHCiuXyGECCmOs0+xX9AVeBDxfuD0XuX2TQ2Uw@mail.gmail.com>
 <Yh0+LA8B1jw8tnl9@smile.fi.intel.com> <db551fce-632e-c84f-3a3e-2733af9dcd46@amazon.com>
In-Reply-To: <db551fce-632e-c84f-3a3e-2733af9dcd46@amazon.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 28 Feb 2022 23:17:23 +0100
X-Gmail-Original-Message-ID: <CAMj1kXF4rm9SfhzKyUkWhkK9n4vVTaUKaE3mcYxj_nQRL-=sZQ@mail.gmail.com>
Message-ID: <CAMj1kXF4rm9SfhzKyUkWhkK9n4vVTaUKaE3mcYxj_nQRL-=sZQ@mail.gmail.com>
Subject: Re: Re: [PATCH 2/3 v6] ACPI: allow longer device IDs
To:     Alexander Graf <graf@amazon.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-crypto <linux-crypto@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Feb 2022 at 23:01, Alexander Graf <graf@amazon.com> wrote:
>
> Hi Andy,
>
> On 28.02.22 22:27, Andy Shevchenko wrote:
> > On Mon, Feb 28, 2022 at 10:02:43PM +0100, Ard Biesheuvel wrote:
> >> On Mon, 28 Feb 2022 at 21:47, Andy Shevchenko <andy.shevchenko@gmail.c=
om> wrote:
> >>> On Mon, Feb 28, 2022 at 9:28 PM Jason A. Donenfeld <Jason@zx2c4.com> =
wrote:
> >>>> From: Alexander Graf <graf@amazon.com>
> >>>>
> >>>> We create a list of ACPI "PNP" IDs which contains _HID, _CID, and CL=
S
> >>>> entries of the respective devices. However, when making structs for
> >>>> matching, we squeeze those IDs into acpi_device_id, which only has 9
> >>>> bytes space to store the identifier. The subsystem actually captures=
 the
> >>>> full length of the IDs, and the modalias has the full length, but th=
is
> >>>> struct we use for matching is limited. It originally had 16 bytes, b=
ut
> >>>> was changed to only have 9 in 6543becf26ff ("mod/file2alias: make
> >>>> modalias generation safe for cross compiling"), presumably on the th=
eory
> >>>> that it would match the ACPI spec so it didn't matter.
> >>>> Unfortunately, while most people adhere to the ACPI specs, Microsoft
> >>>> decided that its VM Generation Counter device [1] should only be
> >>>> identifiable by _CID with a value of "VM_Gen_Counter", which is long=
er
> >>>> than 9 characters.
> >>> Then why do we not see the ECR from somebody to update the spec or to
> >>> fix MS' abuse of it?
> >>> I believe _this_ should be the prerequisite to the proposed change.
> >> What exactly are you suggesting here? That the contributor of this
> >> patch joins the UEFI forum as an individual adopter in order to get
> >> the ACPI spec updated before we can advance with this patch? Or that
> >> he works with Microsoft to get them to refrain from violating it?
> >>
> >> I don't think that is reasonable or realistic. The kernel is already
> >> riddled with UEFI and ACPI quirks that are only there because some
> >> teams at MS don't take the ACPI spec too literally (which is why they
> >> have their own AML compiler, for one), and PC vendors only care about
> >> the Windows sticker, so they don't care about the ACPI spec either.
> >>
> >> So I don't think this is the right time to get pedantic about this.
> >> Our ACPI subsystem already deals with CIDs that are longer than 8
> >> characters (which are btw permitted by the ACPI spec for bus topology
> >> related metadata), the only thing being changed here is the ability to
> >> actually match against such identifiers.
> > My point is that this is clear abuse of the spec and:
> > 1) we have to enable the broken, because it is already in the wild with
> >     the comment that this is an issue
> >
> > AND
> >
> > 2) issue an ECR / work with MS to make sure they understand the problem=
.
> >
> > This can be done in parallel. What I meant as a prerequisite is to star=
t doing
> > 2) while we have 1) on table.
>
>
> While trying to revalidate whether this really is breaking the spec,
> I've tried to reread the respective section in it and I'm afraid that it
> may be valid use of the _CID identifier:
>
>
> """
>
> 6.1.2 _CID (Compatible ID)
>
> This optional object is used to supply OSPM with a device=E2=80=99s Plug =
and
> Play-Compatible Device ID. Use _CID objects when a device has no other
> defined hardware standard method to report its compatible IDs. The _CID
> object is valid only within a Full Device Descriptor. An _HID object
> must also be present.
>
> Arguments:
>
> None
>
> Return Value:
> An Integer or String containing a single CID or a Package containing a
> list of CIDs A _CID object evaluates to either:
>
>   *
>
>     A single Compatible Device ID
>
>   *
>
>     A package of Compatible Device IDs for the device =E2=80=93 in the or=
der of
>     preference, highest preference first.
>
> Each Compatible Device ID must be either:
>
>   *
>
>     A valid HID value (a 32-bit compressed EISA type ID or a string such
>     as =E2=80=9CACPI0004=E2=80=9D).
>
>   *
>
>     A string that uses a bus-specific nomenclature. For example, _CID
>     can be used to specify the PCI ID. The format of a PCI ID string is
>     one of the following:
>
> "PCI\CC_ccss" "PCI\CC_ccsspp"
> "PCI\VEN_vvvv&DEV_dddd&SUBSYS_ssssssss&REV_rr"
> "PCI\VEN_vvvv&DEV_dddd&SUBSYS_ssssssss" "PCI\VEN_vvvv&DEV_dddd&REV_rr"
> "PCI\VEN_vvvv&DEV_dddd"
>
> """
>
> In this case, you could interpret things as looking at "bus-specific
> nomenclature" case which even in the examples mentioned in the spec
> exceeds the 8 character limit we impose on the matching logic today.
>

This is what I was referring to when I mentioned bus topology related metad=
ata.

This is why those uses of ACPI_ID_LEN outside of struct acpi_device_id
may potentially be dangerous, given that _CIDs are apparently
effectively unbounded in size. But relying on this to justify the
"VM_GEN_COUNTER" CID is a bit of a stretch, IMO.

> There still is spec violation in Hyper-V's VMGenID device's _HID value
> which doesn't follow the PNP format, but that's not relevant here. _CID
> doesn't seem to have the same restrictions?
>
