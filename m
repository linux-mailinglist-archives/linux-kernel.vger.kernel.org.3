Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED4905648EA
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 20:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232388AbiGCSPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 14:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232059AbiGCSPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 14:15:17 -0400
Received: from polaris.svanheule.net (polaris.svanheule.net [84.16.241.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 027E26273
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 11:15:15 -0700 (PDT)
Received: from [IPv6:2a02:a03f:eaf9:8401:aa9f:5d01:1b2a:e3cd] (unknown [IPv6:2a02:a03f:eaf9:8401:aa9f:5d01:1b2a:e3cd])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id 4805C2F32A3;
        Sun,  3 Jul 2022 20:15:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1656872113;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gk79OAFFVmN2f29WHrBi7N3syL3PzehyawGjDyoyBbk=;
        b=W5L6aVKf16xAJRaRYBcNVxWVDklFYwFfdxcqq3XHlahQC2PhdfsAYKCBJUF4vYTpShKU5y
        65Ci5Cvgt87bZEVXpm+OOWZsCf2DmCH7+9jliPfyJ2j1pTWPz1+J/a6cb1wO7Etq1wyQUI
        amENVtWjKn97w4+5YgYoOuyTIa6B90Bv9vG8VLZ9gTJsh1JL6TQJAD/ifLAssczFzqajN5
        12gkeEEv0FYVK2grIt293ywDvb+kNeEwKJR5UlAICFuo+CWCeIqCpLC3Y9roMWChtQLqp3
        KWQPekcDIsca9EmGcFcvSwYwiDc73lnTBbzyP9H0s+B+AfnyesX3UObENZ49xg==
Message-ID: <3c9a032edd0fb9b9608ad3ca08d6e3cc38f21464.camel@svanheule.net>
Subject: Re: [PATCH] MIPS: smp-mt: enable all hardware interrupts on second
 VPE
From:   Sander Vanheule <sander@svanheule.net>
To:     Aleksander Jan Bajkowski <olek2@wp.pl>
Cc:     Marc Zyngier <maz@kernel.org>, tsbogend@alpha.franken.de,
        martin.blumenstingl@googlemail.com, hauke@hauke-m.de,
        git@birger-koblitz.de, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Sun, 03 Jul 2022 20:15:11 +0200
In-Reply-To: <20220702190705.5319-1-olek2@wp.pl>
References: <20220702190705.5319-1-olek2@wp.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.2 (3.44.2-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aleksander,

Since this is IRQ related: +CC Marc Zyngier

On Sat, 2022-07-02 at 21:07 +0200, Aleksander Jan Bajkowski wrote:
> This patch is needed to handle interrupts by the second VPE on
> the Lantiq xRX200, xRX300 and xRX330 SoCs. In these chips, 32 ICU
> interrupts are connected to each hardware line. The SoC supports
> a total of 160 interrupts. Currently changing smp_affinity to the
> second VPE hangs interrupts.
>=20
> This problem affects multithreaded SoCs with a custom interrupt
> controller. Chips with 1004Kc core and newer use the MIPS GIC.
>=20
> Also CC'ed Birger Koblitz and Sander Vanheule. Both are working
> on support for Realtek RTL930x chips with 34Kc core and Birger
> has added a patch in OpenWRT that also enables all interrupt
> lines. So it looks like this patch is useful for more SoCs.
>=20
> Tested on lantiq xRX200 and xRX330.
>=20
> Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>

Thanks for bringing up this issue. Like you say OpenWrt carries a similar p=
atch, and I also carry a
patch on my tree to enable all CPU IRQ lines.

Indiscriminately enabling all IRQ lines doesn't sit quite right with me tho=
ugh, since I would expect
these to be enabled on-demand. I.e. when a peripheral requests an IRQ, or w=
hen an IRQ controller is
cascaded into one of the CPU's interrupt lines. If I understand correctly, =
the IRQ mask/unmask
functions in drivers/irqchip/irq-mips-cpu.c should do this.

I haven't been able to achieve this (automatic) behaviour until now, so I t=
hink I must be doing
something wrong when trying to cascade the SoC IRQ driver for the RTL839x/R=
TL930x chips into both
VPEs. It is currently not clear to me how this should be made functional wi=
thout a patch like this
one, so I hope we'll be able to clear that up now.

Best,
Sander

> ---
> =C2=A0arch/mips/kernel/smp-mt.c | 3 +--
> =C2=A01 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/arch/mips/kernel/smp-mt.c b/arch/mips/kernel/smp-mt.c
> index 5f04a0141068..f21cd0eb1fa7 100644
> --- a/arch/mips/kernel/smp-mt.c
> +++ b/arch/mips/kernel/smp-mt.c
> @@ -113,8 +113,7 @@ static void vsmp_init_secondary(void)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 STATUSF_IP4 | STATUSF_IP5 |
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 STATUSF_IP6 | STATUSF_IP7);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0else
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0change_c0_status(ST0_IM, STATUSF_IP0 | STATUSF_IP1 |
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 STATUSF_IP6 | STATUSF_IP7);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0set_c0_status(ST0_IM);
> =C2=A0}
> =C2=A0
> =C2=A0static void vsmp_smp_finish(void)

