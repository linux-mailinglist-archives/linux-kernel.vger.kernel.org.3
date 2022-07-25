Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E195457F7C6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 02:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbiGYAS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 20:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiGYAS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 20:18:56 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D8A4624A
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 17:18:55 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-10dc6e9f500so7009528fac.4
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 17:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XUFbA8ZzNjRypzHIphcDJBi2xFieRAvCdVsFOKHTtA4=;
        b=Iz9lg6T6MBldhUpTNQDKF+csaXmAD/aAy3P8U9WNQ/jz7mCg7DBKMQBtpio1HE8OAk
         7kIDZl1tXrQoZ68180drRYgJ+1NqYR7oOp8c1DIFGINMm9QBnkXQal4mczFOvTc2MUL4
         nOxCP4nWiOAjzlyhO78y+Fcu1vNfZwuPUv4Oz79N0sEbk2y3nSAkMrcNIh46lGdA4xgL
         kFS9mnn310/ZUXOVL3WWXOPuwHNiRiK5oPPT8FaunbhkDhQlt6pa7PHwIwanwK8wi/Qi
         0GclGsRa+HHODAhacl9aojZCAwSkQ7todas5Lne3/BuRkdeeosBVYJ20gzX4NnCrZcMm
         VEgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XUFbA8ZzNjRypzHIphcDJBi2xFieRAvCdVsFOKHTtA4=;
        b=dDvUUNUbhYSPNvf78y0eDTwjcKWE3wMaHR67rhzuUWTVyU92M0+t3u6xH0OKE07odD
         6rxAJ5raLI2LBJODOCSzNQkf8vuQV3vwjb8u+PsUqSO8B+L9qYRFQX8lLmkebNiBleHr
         MStShgZHSeUw8UAwvhFpMg14qba/Jd5cO8VVwfnQjuAOwNK565MkpW1jdi1+76V/Si+1
         uUng+FoKYDtQEIPEEmnGWzdtiKpbDhmf8hM/y+7S4zqWPcS9RiLnR7vs5PF99UaLGQ6W
         i8KxqmOMFLRHyxGi8pX3bbT9R1c3kzO9lr3ZMAyG4Rp59OeFs2CVODk5cV1bPGGJ8nHu
         HMKg==
X-Gm-Message-State: AJIora+cpe5waKw1xpgR/on60Kan/lQ/mt5uswtJD5Wl95zKGUfTxmya
        V1EwAIwmuN2Q7Ya1JvX9u2/99u0Vulq3qaIvRi/4UQ==
X-Google-Smtp-Source: AGRyM1tTErJi5mxhQAwOyvNwGehPBz3JImoZzTV0dzz/oO6LGH/ro7TFiVIk4OSZJCUc7unmJEQ3ayVi+6sGDaRPpwE=
X-Received: by 2002:a05:6870:a182:b0:10b:efbe:e65d with SMTP id
 a2-20020a056870a18200b0010befbee65dmr12811238oaf.5.1658708334500; Sun, 24 Jul
 2022 17:18:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220714010021.1786616-1-mw@semihalf.com> <20220724233807.bthah6ctjadl35by@skbuf>
In-Reply-To: <20220724233807.bthah6ctjadl35by@skbuf>
From:   Marcin Wojtas <mw@semihalf.com>
Date:   Mon, 25 Jul 2022 02:18:45 +0200
Message-ID: <CAPv3WKdFNOPRg45TiJuAVuxM0LjEnB0qZH70J1rMenJs7eBJzw@mail.gmail.com>
Subject: Re: [net-next: PATCH] net: dsa: mv88e6xxx: fix speed setting for
 CPU/DSA ports
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Grzegorz Jaszczyk <jaz@semihalf.com>,
        Tomasz Nowicki <tn@semihalf.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vladimir,


pon., 25 lip 2022 o 01:38 Vladimir Oltean <olteanv@gmail.com> napisa=C5=82(=
a):
>
> Hi Marcin,
>
> On Thu, Jul 14, 2022 at 03:00:21AM +0200, Marcin Wojtas wrote:
> > Commit 3c783b83bd0f ("net: dsa: mv88e6xxx: get rid of SPEED_MAX setting=
")
> > stopped relying on SPEED_MAX constant and hardcoded speed settings
> > for the switch ports and rely on phylink configuration.
> >
> > It turned out, however, that when the relevant code is called,
> > the mac_capabilites of CPU/DSA port remain unset.
> > mv88e6xxx_setup_port() is called via mv88e6xxx_setup() in
> > dsa_tree_setup_switches(), which precedes setting the caps in
> > phylink_get_caps down in the chain of dsa_tree_setup_ports().
> >
> > As a result the mac_capabilites are 0 and the default speed for CPU/DSA
> > port is 10M at the start. To fix that execute phylink_get_caps() callba=
ck
> > which fills port's mac_capabilities before they are processed.
> >
> > Fixes: 3c783b83bd0f ("net: dsa: mv88e6xxx: get rid of SPEED_MAX setting=
")
> > Signed-off-by: Marcin Wojtas <mw@semihalf.com>
> > ---
> >  drivers/net/dsa/mv88e6xxx/chip.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6x=
xx/chip.c
> > index 37b649501500..9fab76f256bb 100644
> > --- a/drivers/net/dsa/mv88e6xxx/chip.c
> > +++ b/drivers/net/dsa/mv88e6xxx/chip.c
> > @@ -3293,7 +3293,12 @@ static int mv88e6xxx_setup_port(struct mv88e6xxx=
_chip *chip, int port)
> >        * port and all DSA ports to their maximum bandwidth and full dup=
lex.
> >        */
> >       if (dsa_is_cpu_port(ds, port) || dsa_is_dsa_port(ds, port)) {
> > -             unsigned long caps =3D dp->pl_config.mac_capabilities;
> > +             unsigned long caps;
> > +
> > +             if (ds->ops->phylink_get_caps)
> > +                     ds->ops->phylink_get_caps(ds, port, &dp->pl_confi=
g);
> > +
> > +             caps =3D dp->pl_config.mac_capabilities;
>
> We'll need this bug fixed in net-next one way or another.
> If you resend this patch, please change the following:
>
> (1) it's silly to (a) check for the presence of ds->ops->phylink_get_caps=
 and
>     (b) do an indirect function call when you know that the implementatio=
n is
>     mv88e6xxx_get_caps(). So just call that.
>
> (2) please don't touch &dp->pl_config, just create an on-stack
>     struct phylink_config pl_config, and let DSA do its thing with
>     &dp->pl_config whenever the timing of dsa_port_phylink_create() is.
>

I can of course apply both suggestions, however, I am wondering if I
should resend them at all, as Russell's series is still being
discussed. IMO it may be worth waiting whether it makes it before the
merge window - if not, I can resend this patch after v5.20-rc1,
targetting the net branch. What do you think?

Thanks,
Marcin

> >
> >               if (chip->info->ops->port_max_speed_mode)
> >                       mode =3D chip->info->ops->port_max_speed_mode(por=
t);
> > --
> > 2.29.0
> >
