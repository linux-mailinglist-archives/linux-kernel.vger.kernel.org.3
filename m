Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20A764A7281
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 15:02:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344706AbiBBOBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 09:01:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344646AbiBBOBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 09:01:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F92C061714
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 06:01:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 438B1617F0
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 14:01:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A82A8C340ED
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 14:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643810510;
        bh=uSBHocmLnCmMwcSkbq1j0OtxS41oNNINKaJqar0f250=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=p92mUzIOfxLfrBqJ3GgpORGL6IGCJ6PxH6YDkaCxkoCRicCxggyGMOcEOiio85gSz
         WZBXdLzww9ZUVMZGQzug2RCKEsG3BAXdRym9EvlIu1NQdAMlKtTRsKmhDIDeLL1Tnh
         Z9oSaOUCPI6jlBv0/KL5sW/8+eTblAGy+lds4TbTlimzBkf0pGmUNyHv9ZQwRPgIj3
         p3oy1htdARnejboPJ/UwAQvv7dQnLO+MbkS1OHuJrDLhbempgnbTsu/Dt2s5N+9GMe
         xjsIlOKMpHCkS2ukrmOyw/mYVY0nDtctksc5YjiZSmebLxxYO4a12uudJcR0w2VviP
         vrOMwynfHaReQ==
Received: by mail-wr1-f50.google.com with SMTP id h7so6774137wrc.5
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 06:01:50 -0800 (PST)
X-Gm-Message-State: AOAM532e/c87udPEiHFTKozCVqoihejclbTFnIYZecDJXDi10IZ8qtfH
        Uwc3GMCD1UoneO2je6pGYeoqIkoW8+igYL70rm4=
X-Google-Smtp-Source: ABdhPJxZ24ZW0U4wDz2icx2KPfTF7ramCqisfnEX5yTPNuYH09Rte02aSzdx80Og0f5iraT23DCJcd3757Ysb6dyxWU=
X-Received: by 2002:a05:6000:1c9:: with SMTP id t9mr25966742wrx.550.1643810508877;
 Wed, 02 Feb 2022 06:01:48 -0800 (PST)
MIME-Version: 1.0
References: <YfP0osb45uJldtM9@localhost.localdomain> <YfQTZTUNaeGi+8tG@FVFF77S0Q05N>
 <YfRorCpk0seVGI+5@localhost.localdomain> <Yfk8hQB1eon7oeYU@FVFF77S0Q05N> <Yfp7wZXLKPIYBxmp@localhost.localdomain>
In-Reply-To: <Yfp7wZXLKPIYBxmp@localhost.localdomain>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 2 Feb 2022 15:01:37 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEP+0ErwmLebw5mswz+jD+Yd_U_U7jmhPR2bKgnMRTWNw@mail.gmail.com>
Message-ID: <CAMj1kXEP+0ErwmLebw5mswz+jD+Yd_U_U7jmhPR2bKgnMRTWNw@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: move efi_reboot to restart handler
To:     Krzysztof Adamski <krzysztof.adamski@nokia.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Matija Glavinic-Pecotic <matija.glavinic-pecotic.ext@nokia.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Feb 2022 at 13:41, Krzysztof Adamski
<krzysztof.adamski@nokia.com> wrote:
>
> Dnia Tue, Feb 01, 2022 at 01:58:29PM +0000, Mark Rutland napisa=C5=82(a):
> >> If we use the restart handlers only to reset the system, this is indee=
d
> >> true. But technically, restart handlers support the scenario where the
> >> handler does some action that does not do reset of the whole system an=
d
> >> passes the control further down the chain, eventually reaching a handl=
er
> >> that will reset the whole system.
> >> This can be done on non-uefi systems without problems but it doesn't
> >> work on UEFI bases arm64 systems and this is a problem for us.
> >>
> >> In other words, I would like to be able to run a restart handler on EF=
I
> >> based ARM64 systems, just like I can on other systems, just for its
> >> "side effects", not to do the actual reboot. Current code disables thi=
s
> >> possibility on an ARM64 EFI system.
> >
> >It sounds like two things are being conflated here:
> >
> >1) A *notification* that a restart will subsequently occur.
> >2) A *request* to initiate a restart.
> >
> >IIUC (1) is supposed to be handled by the existing reboot notifier mecha=
nism
> >(see the reboot_notifier_list) which *is* invoked prior to the EFI reboo=
t
> >today.
> >
> >IMO, using restart handlers as notifiers is an abuse of the interface, a=
nd
> >that's the fundamental problem.
> >
> >What am I missing?
>
> You are completly right. It is possible that I would like to be able to
> *abuse* the restart handlers as notifier. You are right that we have a
> reboot_notifier but it is not good enough for my usecase - it is only
> called, well, on reboot. It is not called in case of emergency_restart()
> so in case of a panic, this won't happen. It also is called much earlier
> than restart handlers which also makes a difference in some cases. So I
> see no other choice than to abuse the restart_handler mechanism for that.
>

Why would such a platform implement ResetSystem() in the first place
if it cannot be used?

So the right solution here is for the firmware to publish a
EFI_RT_PROPERTIES_TABLE that describes ResetSystem() as unsupported,
and Linux will happily disregard it and try something else.

Btw please cc linux-efi@vger.kernel.org and myself on future EFI
issues. I found this thread by accident.
