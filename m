Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 635FC552E47
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 11:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348656AbiFUJ2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 05:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347480AbiFUJ2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 05:28:02 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D932CBB4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 02:27:53 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id b23so6137486ljh.7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 02:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8e6CPzPX9uApajCNlf3OZqOW+gA8MhL7WPc0wiikTqU=;
        b=il/sljDYx3y2Rj9aqTxNbHbIQ6aPBlIM7Pdno2uuS3KhdGKi1EZgd2FZY9hkCiRxUf
         tXXC5pVQluIx7hzrqJkyWQa8PUsf0LJEY1Ckb5XU825NXkHH39idMeeWYYKj8nx3j9ov
         AVbtVZ20G4hmmd8vqMhW2AI7pWnxAilWfxN8qOYRJ8JpVhXsc4uZLRjZa/oRuq1Ek4Sq
         +NfhopYiugeI1pVHBPe7y9TDcyBtvwaAB6nO9UYiHGVr7CxQDXuXLfNpVecYHKp31Ryx
         lOS1h5CPu7upadyDALbWKNDakfbwsuKkASE6Xre2cbymdQ6fljJLXzGYJ8RPK+fnUTP9
         WVyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8e6CPzPX9uApajCNlf3OZqOW+gA8MhL7WPc0wiikTqU=;
        b=3ZgYTG01g1qta3uU02uhBVSnfru9GMMXJ4c5fMjcgdFFYOHKgBPux9CgrSjk9hPj6w
         2uSXOXSHq3p58AKFwQWh1vm/Uzinf4CxcpSLxYPNLAKVsiGBnyfYyBT7TWmryP1cnLRU
         zVB/0sXrnsCEPxolZFZC3GuYrcswE8EeUo280Cae9F9QM9PhVZXxU3UltBkufRgi7Jcl
         MtPZNfkCBpInDdvRLq7BB7h8Q2AeymWPJG2uqzCME0Woaaub3HRbGGO267Ca3x2UbP6F
         lfxaIoJ0DPmKzA3kAMnAauubMxeKnq6L8rCzvDpUqLo6i4f/Rph4rcWQw1GdX2Gbcd7M
         Hx5g==
X-Gm-Message-State: AJIora8TOxWwehqvgWeGMfmvukcZx8V9v72n/2OM22hSfBfA5VJA9qkR
        MXpdNJhQz7zmPUk0QBR5Cg2zJ1Xfnh8ZpehVI6WN0Q==
X-Google-Smtp-Source: AGRyM1sBSSnPQfUNpVkNAnJ/02rMsTXl7DvXUFqZ5omPctSopVyLOUzYU7be4FE/ZwsUBD8Qkkc/Jkri0LrTRGe/ZjQ=
X-Received: by 2002:a2e:a58d:0:b0:25a:6348:9595 with SMTP id
 m13-20020a2ea58d000000b0025a63489595mr7562439ljp.72.1655803672117; Tue, 21
 Jun 2022 02:27:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220620150225.1307946-1-mw@semihalf.com> <20220620150225.1307946-4-mw@semihalf.com>
 <YrCxUfTDmvm9zLXq@smile.fi.intel.com>
In-Reply-To: <YrCxUfTDmvm9zLXq@smile.fi.intel.com>
From:   Marcin Wojtas <mw@semihalf.com>
Date:   Tue, 21 Jun 2022 11:27:43 +0200
Message-ID: <CAPv3WKch9hC3ZjZE0f4JntqFDY04PUpQ1yzsgShThmhkqV01-g@mail.gmail.com>
Subject: Re: [net-next: PATCH 03/12] net: dsa: switch to device_/fwnode_ APIs
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        vivien.didelot@gmail.com, Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, pabeni@redhat.com,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Grzegorz Bernacki <gjb@semihalf.com>,
        Grzegorz Jaszczyk <jaz@semihalf.com>,
        Tomasz Nowicki <tn@semihalf.com>,
        Samer El-Haj-Mahmoud <Samer.El-Haj-Mahmoud@arm.com>,
        upstream@semihalf.com
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

pon., 20 cze 2022 o 19:41 Andy Shevchenko
<andriy.shevchenko@linux.intel.com> napisa=C5=82(a):
>
> On Mon, Jun 20, 2022 at 05:02:16PM +0200, Marcin Wojtas wrote:
> > In order to support both ACPI and DT, modify the generic
> > DSA code to use device_/fwnode_ equivalent routines.
> > No functional change is introduced by this patch.
>
> ...
>
> >       struct device_node      *dn;
>
> What prevents us from removing this?

I left it to satisfy possible issues with backward compatibility - I
migrated mv88e6xxx, other DSA drivers still rely on of_* and may use
this field.

>
> > +     struct fwnode_handle    *fwnode;
>
> ...
>
> > -             dn =3D of_get_child_by_name(ds->dev->of_node, "mdio");
> > +             fwnode =3D fwnode_get_named_child_node(ds->dev->fwnode, "=
mdio");
>
> The rule of thumb is avoid dereferencing fwnode from struct device. So
> dev_fwnode(), but here it would be achieved by device_get_named_child_nod=
e().
>

Ok, thanks - will do for all occurences.

> ...
>
> > -static int dsa_switch_parse_of(struct dsa_switch *ds, struct device_no=
de *dn)
> > +static int dsa_switch_parse_of(struct dsa_switch *ds, struct fwnode_ha=
ndle *fwnode)
>
> Shouldn't _of suffix be replaced by, let's say, _fw?
>

I thought about it and can perform such naming update in next iteration.

> ...
>
> > -     return dsa_switch_parse_ports_of(ds, dn);
> > +     return dsa_switch_parse_ports_of(ds, fwnode);
>
> Ditto.
>
> ...
>
> > +     fwnode =3D ds->dev->fwnode;
>
> dev_fwnode() or corresponding device_property_ API.
>

OK.

> ...
>
> >       slave_dev->dev.of_node =3D port->dn;
> > +     slave_dev->dev.fwnode =3D port->fwnode;
>
> device_set_node()
>

OK.

Thanks,
Marcin
