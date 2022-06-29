Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 172F85609FD
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 21:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbiF2TJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 15:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiF2TJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 15:09:13 -0400
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A72472C658;
        Wed, 29 Jun 2022 12:09:12 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id i15so29748614ybp.1;
        Wed, 29 Jun 2022 12:09:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WIUOcjqbDRqwHoZr9SPqc9wp23o2wvFnWFd2gZt8KDA=;
        b=LWnGs1tnDYOx83m2JuK1YE/Vgeewgfg5n3YOyLO64Oq5OZz+B5ntCWYkWamBi+li+l
         4u6EiJc/MZvYyEw75KZe5VKSfQV+DYT14xE43XmW6SqwTx5Y/XKwechMdGCBPmZWe7+P
         EeOE0kb9hu32+WYr4cksUXfQcRTL3uVHQlZbLDmpFkcRgZ4yMIlj4QasntX3e7FGx6ja
         iGx9iZwWtYdjzmRm33BWgctCqr+MHkwAkQxN+eFwPNA3EorYOqBwNq3Z6P92IwGDWP9a
         hJDpMIGuqYNO1d2Z2OcqKdGjPuirotQ3j5J1AwhP2PqCjsReMtS3S2WCKf34YgK42hGk
         E0YA==
X-Gm-Message-State: AJIora+BaCelcLv1jk9XRzmtyjWjUJjlnfNQpQgCtl8gAzahgSIl8ACp
        Jc/0j7PviijIpRV659qpW41hMZMbW4TwGIUUIGhXtwZEQNU=
X-Google-Smtp-Source: AGRyM1s4C3/6sJZHuyLqpS6iezs/ly5vUFd6ItASLD+BbmfGmMNmroBUjHtM15ShmS3+COg2i+4w3G6bUpDOabwzRHA=
X-Received: by 2002:a25:664f:0:b0:66c:d0f4:36cc with SMTP id
 z15-20020a25664f000000b0066cd0f436ccmr4909364ybm.482.1656529751871; Wed, 29
 Jun 2022 12:09:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220627165832.10246-1-mario.limonciello@amd.com>
 <CAJZ5v0g2qfA00=ukatTxSXPnoOaquwvn8tk0oNHaY-0F7ODZQw@mail.gmail.com> <MN0PR12MB6101BFCBAA33B98D438B25E8E2BB9@MN0PR12MB6101.namprd12.prod.outlook.com>
In-Reply-To: <MN0PR12MB6101BFCBAA33B98D438B25E8E2BB9@MN0PR12MB6101.namprd12.prod.outlook.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 29 Jun 2022 21:09:00 +0200
Message-ID: <CAJZ5v0g8e4pJoPSaCqPmgfvi8KYNLJyAHsXAcU_z-kU5bMJy=w@mail.gmail.com>
Subject: Re: [PATCH] ACPI: CPPC: Don't require _OSC if X86_FEATURE_CPPC is supported
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Pierre Gondois <pierre.gondois@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Yuan, Perry" <Perry.Yuan@amd.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Wed, Jun 29, 2022 at 8:49 PM Limonciello, Mario
<Mario.Limonciello@amd.com> wrote:
>
> [Public]
>
>
>
> > -----Original Message-----
> > From: Rafael J. Wysocki <rafael@kernel.org>
> > Sent: Wednesday, June 29, 2022 13:42
> > To: Limonciello, Mario <Mario.Limonciello@amd.com>
> > Cc: Rafael J. Wysocki <rafael@kernel.org>; Len Brown <lenb@kernel.org>;
> > Pierre Gondois <pierre.gondois@arm.com>; Sudeep Holla
> > <sudeep.holla@arm.com>; Yuan, Perry <Perry.Yuan@amd.com>; ACPI Devel
> > Maling List <linux-acpi@vger.kernel.org>; Linux Kernel Mailing List <linux-
> > kernel@vger.kernel.org>
> > Subject: Re: [PATCH] ACPI: CPPC: Don't require _OSC if X86_FEATURE_CPPC is
> > supported
> >
> > On Mon, Jun 27, 2022 at 6:58 PM Mario Limonciello
> > <mario.limonciello@amd.com> wrote:
> > >
> > > commit 72f2ecb7ece7 ("ACPI: bus: Set CPPC _OSC bits for all and
> > > when CPPC_LIB is supported") added support for claiming to
> > > support CPPC in _OSC on non-Intel platforms.
> > >
> > > This unfortunately caused a regression on a vartiety of AMD
> > > platforms in the field because a number of AMD platforms don't set
> > > the `_OSC` bit 5 or 6 to indicate CPPC or CPPC v2 support.
> > >
> > > As these AMD platforms already claim CPPC support via `X86_FEATURE_CPPC`,
> > > use this enable this feature rather than requiring the `_OSC`.
> > >
> > > Fixes: 72f2ecb7ece7 ("Set CPPC _OSC bits for all and when CPPC_LIB is
> > supported")
> > > Reported-by: Perry Yuan <perry.yuan@amd.com>
> > > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > > ---
> > >  drivers/acpi/cppc_acpi.c | 12 +++++++++---
> > >  1 file changed, 9 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> > > index 903528f7e187..5463e6309b9a 100644
> > > --- a/drivers/acpi/cppc_acpi.c
> > > +++ b/drivers/acpi/cppc_acpi.c
> > > @@ -629,6 +629,15 @@ static bool is_cppc_supported(int revision, int
> > num_ent)
> > >                 return false;
> > >         }
> > >
> > > +       if (osc_sb_cppc_not_supported) {
> > > +               pr_debug("Firmware missing _OSC support\n");
> > > +#ifdef CONFIG_X86
> > > +               return boot_cpu_has(X86_FEATURE_CPPC);
> > > +#else
> > > +               return false;
> > > +#endif
> >
> > What about doing
> >
> > if (osc_sb_cppc_not_supported) {
> >         pr_debug("Firmware missing _OSC support\n");
> >         return IS_ENABLED(CONFIG_X86) && boot_cpu_has(X86_FEATURE_CPPC);
> > }
> >
> > instead for the sake of reducing #ifdeffery?
>
> I don't think that would compile on non-X86.  X86_FEATURE_CPPC comes as part of
> arch/x86/include/asm/cpufeatures.h, which I wouldn't expect is included on !x86.

Good point.

Something like this would still look better though IMO:

if (!osc_sb_cppc_not_supported)
        return true;

#ifdef CONFIG_X86
        return boot_cpu_has(X86_FEATURE_CPPC);
#else
        return false;
#endif
}


>
> >
> > Also, this is somewhat risky, because even if the given processor has
> > X86_FEATURE_CPPC set, the platform may still not want to expose CPPC
> > through ACPI.  How's that going to work after this change?
> >
>
> Well actually doing that through _OSC wouldn't have worked before 72f2ecb7ece7 either.
> If desirable - a platform could avoid populating _CPC objects in ACPI tables in this case.
>
> I do know of OEM platforms that the underlying APU supports CPPC but the OEM doesn't
> populate _CPC.  Presumably for this exact reason.

That is an option, but there is no requirement that _CPC must not be
populated when CPPC is not supported.

_OSC is the proper mechanism for negotiating CPPC support.

Still, if you know for a fact that on AMD systems X86_FEATURE_CPPC
always means that CPPC is supported, I can live with an extra vendor
check in the code above.
