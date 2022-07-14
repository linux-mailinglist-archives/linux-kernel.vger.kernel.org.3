Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31A6E5753DA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 19:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239229AbiGNRTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 13:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235636AbiGNRTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 13:19:11 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38D614E84B
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 10:19:09 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id o7so3884039lfq.9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 10:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/iRwB4SIZGcrcHdLv8kR4Wq5A27ltiLacaWAkXsJp44=;
        b=EuBVP/4AG3rWcpGAfyEti98dnWn9EPkkJmI7Ln4EdEVHcAWSVlqLsuGQh+m5Epjobn
         gPXkz+akTG/aDD0Ex8wHQ9YIvefZgI8VJbusQRIzHwfl5yXT34TbCS1FkNWoJONMiGY5
         erEJnfeAzr+FxOOu+S5NjUyrY0QUd9ajVAjuuhcdugNd93G+e41oAPMZPBP+aYBVUORS
         chC3sdeUYIguAUzpxdRoruPfkrCcA319TWstsmWzL+QvS2Qfvo+E4L7kiF2lDp4V4g6l
         Scb6GVpJgXnQsXQnTuO5MSUuDMkMe8FJKYaVpdwrF7jdYFde5bhs6A2kH/JNEPq4Oypq
         8bsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/iRwB4SIZGcrcHdLv8kR4Wq5A27ltiLacaWAkXsJp44=;
        b=1RT9zF7PeMuz1jhhsCCnXyVz5tKz1+TFLz2z4l4LH9BOwVMd8X81W+Zwo7Aer0q9Oq
         oijnJR0vPCaGlBRQ4seDrW6DdwpNXUg0e0Ctw0uWwZwqmkeAC+6f2zqpMTgDefXNfgkR
         jPB9dKkKcLI0S2RVsiufvv8vZxTg2UFV1Jj68k6mLk8ybnJDUUN+BeFkxSPJrmnWpUWW
         PRNh9mvUufvw5fhgQuhgU8rIB0L+s974m42X4dzFEyrLk6AEPcDnOZeX77wrLXB08Bo1
         8D2qIO3oRK6PvPUctFFpAbomd386t0OBVAw7tRZMEYihoN1+F7qhv+wkMkBsj9ntFde8
         +slw==
X-Gm-Message-State: AJIora+jqUlcFMWm4c1N0Jfm5OxgSr35K4rM6TkMU7RqYVsZaKyqCdaV
        2+D5mmuupneC6SXMzHyNqlXzqvsG4UiymeMuV//fhw==
X-Google-Smtp-Source: AGRyM1ubgP89EswVsEcdm6/fKB3caUtCNtO+q94GutFgojH1MjQ6CTV9ueuUxg6pvRrIoSzPgUV8ePXyHezOTGBkz1o=
X-Received: by 2002:a05:6512:1685:b0:47f:aab4:dcd0 with SMTP id
 bu5-20020a056512168500b0047faab4dcd0mr5736808lfb.481.1657819147425; Thu, 14
 Jul 2022 10:19:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220714010021.1786616-1-mw@semihalf.com> <YtAMw7Sp06Kiv9PK@shell.armlinux.org.uk>
In-Reply-To: <YtAMw7Sp06Kiv9PK@shell.armlinux.org.uk>
From:   Marcin Wojtas <mw@semihalf.com>
Date:   Thu, 14 Jul 2022 19:18:57 +0200
Message-ID: <CAPv3WKcxH=b01ikuUESczWeX8SJjc2fg3GjSCp7Q8p72uSt_og@mail.gmail.com>
Subject: Re: [net-next: PATCH] net: dsa: mv88e6xxx: fix speed setting for
 CPU/DSA ports
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Grzegorz Jaszczyk <jaz@semihalf.com>,
        Tomasz Nowicki <tn@semihalf.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell,

czw., 14 lip 2022 o 14:32 Russell King (Oracle)
<linux@armlinux.org.uk> napisa=C5=82(a):
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
>
> Please don't merge this - the plan is to submit the RFC series I sent on
> Wednesday which deletes this code, and I'd rather not re-spin the series
> and go through the testing again because someone else changed the code.

Thank for the heads-up. Are you planning to resend the series or
willing to get it merged as-is? I have perhaps one comment, but I can
apply it later as a part of fwnode_/device_ migration.

>
> Marcin - please can you test with my RFC series, which can be found at:
>
> https://lore.kernel.org/all/Ys7RdzGgHbYiPyB1@shell.armlinux.org.uk/
>

The thing is my v2 of DSA fwnode_/device_ migration is tested and
ready to send. There will be conflicts (rather easy) with your
patchset - I volunteer to resolve it this way or another, depending on
what lands first. I have 2 platforms to test it with + also ACPI case
locally.

I'd like to make things as smooth as possible and make it before the
upcoming merge window - please share your thoughts on this.

Best regards,
Marcin
