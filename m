Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59C4C512005
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244154AbiD0Rlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 13:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244245AbiD0Rlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 13:41:36 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 973535BD15
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 10:38:23 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id j4so4401769lfh.8
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 10:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=d4ythIy+4BMKhrFRBWTelImtvnFliKqEsbPbAXakWNA=;
        b=Rxz8TwmTciAgk1vS6UVXjQfgsSd8NJiPicC44NHYEYvHeQX7PQS/0HS2mJ+k7bNa84
         x53Unulgrzln1EX8siAcPHSTO3dO3fw/ORCo2UB0bhnxc8u4lR5UHlgeSUMqHYw90idd
         L7js8ruFeWcajOx0UHQaehE+rXPO8+cDUZWtzEy0Lr+m7YSOJw6QQEE9A19CP1f+zUUa
         WFWm5YgxUnybu3a29ZGqv0LhOKHlq+71fNx+PBKNh8W5eN6cYmQnkB9pD7hxF9G4VW0J
         IAKPDEF3vHBYHAf4mz7EsiokQlwOoV3fWtKYbJsM5Zz/rpeAMqZP+0KkHpwrztvekH6/
         ly7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=d4ythIy+4BMKhrFRBWTelImtvnFliKqEsbPbAXakWNA=;
        b=xFlwY7MqD7gGPN8g45V9S97Q44bnKxr5Z9AwNZSZ1bwoIwPm5VytF0NLJSHtYXVmxt
         /vtkODQw38bU9bGaBctoQRu5dWScOj0i7IGLyfzABdQtFru38ztwmu67Cc57qqvHzI90
         Labo02E075Ke5pVt2rgcGTg+l8i5HR4IT0Vb6RRmFIknOySbgDCczkF51uOWDQqd1fFv
         bx9p3tX5ahf3nivM3+d6oB+JPrdMI54iuXxOuFJ8+YIDwYfsa4YRCefWLr1Q1GPIOjpo
         K8098lh/5/wH6zQ+gKfXhlto2oKgpgjPKc639PNTuzhS5wNzTJmxPMsxhSTABU7U4ff0
         kTLQ==
X-Gm-Message-State: AOAM533CQEz53TXt7Z5tZB2Z/wY0YC8ql0tZZDjqpIbEPgfinm599dbS
        ExBknfsxC7MmEuSkZ0hc0VqD/sEycXttN7dB+Ga71Q==
X-Google-Smtp-Source: ABdhPJwUwyoKDXmd/Qnsb0PVaPczo3M9ZqbxWCO8Yi39M/Y51Dl62QA24fZkYYZ77+w8PmuO+NTXk881VpoPaApgnfY=
X-Received: by 2002:a05:6512:3f89:b0:44a:f5bf:ec7e with SMTP id
 x9-20020a0565123f8900b0044af5bfec7emr21200622lfa.671.1651081101604; Wed, 27
 Apr 2022 10:38:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220425094708.2769275-1-mw@semihalf.com> <20220427172514.n4musn42dhygzbu2@skbuf>
In-Reply-To: <20220427172514.n4musn42dhygzbu2@skbuf>
From:   Marcin Wojtas <mw@semihalf.com>
Date:   Wed, 27 Apr 2022 19:38:09 +0200
Message-ID: <CAPv3WKeFudAqSrPbxeFLvs=myo1UDhBo+GPOZ6dGgpwC-eq8eg@mail.gmail.com>
Subject: Re: [net: PATCH] net: dsa: add missing refcount decrementation
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        vivien.didelot@gmail.com, Florian Fainelli <f.fainelli@gmail.com>,
        upstream@semihalf.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=C5=9Br., 27 kwi 2022 o 19:25 Vladimir Oltean <olteanv@gmail.com> napisa=C5=
=82(a):
>
> On Mon, Apr 25, 2022 at 11:47:08AM +0200, Marcin Wojtas wrote:
> > After obtaining the "phy-handle" node, decrementing
> > refcount is required. Fix that.
> >
> > Fixes: a20f997010c4 ("net: dsa: Don't instantiate phylink for CPU/DSA p=
orts unless needed")
> > Signed-off-by: Marcin Wojtas <mw@semihalf.com>
> > ---
> >  net/dsa/port.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/net/dsa/port.c b/net/dsa/port.c
> > index 32d472a82241..cdc56ba11f52 100644
> > --- a/net/dsa/port.c
> > +++ b/net/dsa/port.c
> > @@ -1620,8 +1620,10 @@ int dsa_port_link_register_of(struct dsa_port *d=
p)
> >                       if (ds->ops->phylink_mac_link_down)
> >                               ds->ops->phylink_mac_link_down(ds, port,
> >                                       MLO_AN_FIXED, PHY_INTERFACE_MODE_=
NA);
> > +                     of_node_put(phy_np);
> >                       return dsa_port_phylink_register(dp);
> >               }
> > +             of_node_put(phy_np);
> >               return 0;
> >       }
> >
> > --
> > 2.29.0
> >
>
> Thanks for the patch.
>
> commit fc06b2867f4cea543505acfb194c2be4ebf0c7d3
> Author: Miaoqian Lin <linmq006@gmail.com>
> Date:   Wed Apr 20 19:04:08 2022 +0800
>
>     net: dsa: Add missing of_node_put() in dsa_port_link_register_of
>
>     The device_node pointer is returned by of_parse_phandle()  with refco=
unt
>     incremented. We should use of_node_put() on it when done.
>     of_node_put() will check for NULL value.
>
>     Fixes: a20f997010c4 ("net: dsa: Don't instantiate phylink for CPU/DSA=
 ports unless needed")
>     Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
>     Signed-off-by: David S. Miller <davem@davemloft.net>

Great, I'll rebase then and I can drop my patch.

Thanks,
Marcin
