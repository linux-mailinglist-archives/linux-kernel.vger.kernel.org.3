Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B7AA552E2A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 11:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347954AbiFUJWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 05:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347951AbiFUJWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 05:22:36 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 455DB1FA4C
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 02:22:34 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id j22so8077921ljg.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 02:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YQJ0P5pmj7pWHKO2M8CX9J9qrG0ooOx/mkHybDQ4GBg=;
        b=aMxG6S8DAeIn+DjepGp31VtLdFcuEUyiZ9F9DfVF60ir3YzF6gtG7xVME6GsL7DU6y
         25Mxbp/KyhTvl2n5DzwI60KipI1j9jA7Hy1qQly0uQFnFl+jm18RLliZW+2uQdIPTkGn
         hEBHkPys8aojNmjXMPwz2LlCkpCRc+3COR44NMol6MMuhQywPr4ryDLVS6IkRkw3wOR9
         fMYXQtVWmR2Wp+VHDUold0P11mMo46vFOeIEPyVdKqnMZUTjYiq3CcOrQlQGqOFSQSkK
         3uFmGEoF7lZpUNGRhU47heDrTdht3rOwbNuEQezoPRO4yavQowjzxPHFxDJ4+5+d9+Mt
         W++w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YQJ0P5pmj7pWHKO2M8CX9J9qrG0ooOx/mkHybDQ4GBg=;
        b=Jrf5nnMXBcak7atrcyYSSqxcZ8Cp8jIgMKLcsTl7s7YAiGVN1Qr9CIkF7sdU7B/IFP
         HSDHBwmL4j7f9j6C0CM6qkeipj2k3xfHxoqyKmjFZA6HOM12tQlLF1oMT6R/toarQQpd
         jCS6uccDVY4K6hOUHgIik8zBc6XhkZwWU1piYzsbRjKgcOEQ183LwgvflvcS6EcHlXFA
         D/usHNmDqHnZgcvJrhQxxmzcC4/drqkap04mNVViEU4AIuZlk/gOV1kRkT9AZtmuyL5R
         P+gkRQT/H3h5lf3vCovfBEKmw9k6wV44M1QrLHEdQ1OGUXT8bbX8jKtlymwbJl2CIkUa
         T4sQ==
X-Gm-Message-State: AJIora8nFp4gWw0GgMuAjL4+G+K/ACesIFZmeAEmeyldfHR+scbBT6eH
        25G6XQeVyPWH+MIW8WTMT0VgTpDn/LMW4oErwmbLDQ==
X-Google-Smtp-Source: AGRyM1vfNop/ptWwAu46TOF54jRmU3XA7qR7mmDPRHfJviUn1W6HrxgfWJ2GoePQ4fSO345+zf+ZykLhIk+ddb12lsk=
X-Received: by 2002:a2e:bf1c:0:b0:259:f33:a4db with SMTP id
 c28-20020a2ebf1c000000b002590f33a4dbmr13322684ljr.454.1655803352545; Tue, 21
 Jun 2022 02:22:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220620150225.1307946-1-mw@semihalf.com> <20220620150225.1307946-3-mw@semihalf.com>
 <YrCvFYaBuICKIQM/@smile.fi.intel.com>
In-Reply-To: <YrCvFYaBuICKIQM/@smile.fi.intel.com>
From:   Marcin Wojtas <mw@semihalf.com>
Date:   Tue, 21 Jun 2022 11:22:23 +0200
Message-ID: <CAPv3WKeX4=-vHE+292WpavDYwZJDiRcXosPT1uDUFSyV0tSYfQ@mail.gmail.com>
Subject: Re: [net-next: PATCH 02/12] net: mdio: switch fixed-link PHYs API to fwnode_
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

pon., 20 cze 2022 o 19:32 Andy Shevchenko
<andriy.shevchenko@linux.intel.com> napisa=C5=82(a):
>
> On Mon, Jun 20, 2022 at 05:02:15PM +0200, Marcin Wojtas wrote:
> > fixed-link PHYs API is used by DSA and a number of drivers
> > and was depending on of_. Switch to fwnode_ so to make it
> > hardware description agnostic and allow to be used in ACPI
> > world as well.
>
> ...
>
> > +bool fwnode_phy_is_fixed_link(struct fwnode_handle *fwnode)
> > +{
> > +     struct fwnode_handle *fixed_link_node;
> > +     const char *managed;
> > +     int len;
> > +
> > +     /* New binding */
> > +     fixed_link_node =3D fwnode_get_named_child_node(fwnode, "fixed-li=
nk");
> > +     if (fixed_link_node) {
> > +             fwnode_handle_put(fixed_link_node);
> > +             return true;
> > +     }
> > +
> > +     if (fwnode_property_read_string(fwnode, "managed", &managed) =3D=
=3D 0 &&
> > +         strcmp(managed, "auto") !=3D 0)
> > +             return true;
> > +
> > +     /* Old binding */
> > +     len =3D fwnode_property_read_u32_array(fwnode, "fixed-link", NULL=
, 0);
>
>
> fwnode_property_count_u32()
>
> > +     if (len =3D=3D (5 * sizeof(u32)))
>
> I'm not sure how to interpret this. len will return a count of u32 elemen=
ts.
> What does the sizeof(u32) mean here?
>

You are right, thanks for spotting. The total byte count remained
after migrating from of_get_property ->
fwnode_property_read_u32_array.

Best regards,
Marcin
