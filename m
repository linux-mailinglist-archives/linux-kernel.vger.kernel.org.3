Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5BEF509F8F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 14:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384007AbiDUM1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 08:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243488AbiDUM1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 08:27:05 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AAD22F017
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 05:24:16 -0700 (PDT)
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 5DEE43F164
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 12:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1650543854;
        bh=EunKIzEYYpqXkUA9FJTIxMLvA71NXv+oX7Al+STtVJU=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=hMNu8OnlA88hGK844OCqU/ytAsGcflRDV7o6XAGAgE2NO/dFspQ8nxL2YY6k1alyt
         /d19N8gf916n1eCsiNbxL2MJOmByj0xx152V6S2X6SceTOwa2LrJ+KjtMpx1OvWRn5
         iHCsft//gxCfhs2Dq8lL/er0OfjLDvHbFDhRDfn7Bqhy/Gab8nHEwPhvvHlH5mr7Q8
         qpxtS1DAd1KZabj2nyENw+npBbwKrcLO5YIqoLJKbHYywhu/VKqQtUgWd+pMf/jyrd
         SX71Jw4OTX7ES23e24uhQxvq6/B4S8m7qyBiaSUQu1sdX/krjezUaGt0MvZPnlmlul
         mhdGrqJsAqHfw==
Received: by mail-oi1-f198.google.com with SMTP id y132-20020aca4b8a000000b00322352ae925so2163425oia.15
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 05:24:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EunKIzEYYpqXkUA9FJTIxMLvA71NXv+oX7Al+STtVJU=;
        b=Z8ss8N4NknoYziIhnPKMr6DztpxZHJ3+b7fwYhzyZIIpOPDbUfWagqdbTR2yOzqqYp
         hFg6Lp00UaKCX267VM9xz7KSeIX60sRYVXeBf4jVCAd2mcdcG768/fqbcu5XKC8FoA7q
         xOj+4er5nyTk3UVccCM2YssTMVZEVAQbPXUPpmoJKTxU+DQc1s0EopD3g5JEI3PZVUQC
         eX4karVJNHr6OWN9KuckFoXck6hFPzKesmsTiSGNKudpdCQzwPQVqa4acQ2EU3SwvZ0u
         pFrX7IIvDt+RzCrtFE8DvPRBpvKxRpwnyJFOiTyg0WCByQ4KjxO7JfJZpcsuOm7AsaUW
         2iaQ==
X-Gm-Message-State: AOAM533dZKqX6FKP9Uk7KnhXNkE365yefs7ibzKWMqdamNf2TSHSFY0X
        Ghk51jE7Wf9wtHOMgjJZTbXr7boS4k5kgzPyRFsCscR2vKmxAQtLmZ2JWvo7MMsWkNf/OGBzEZM
        rBIXom6m+z+ctprBe+7nLg6mZqyOw9BK5oyaDu67gwmcIdfTh6d2h0WGIuA==
X-Received: by 2002:a05:6870:4391:b0:e6:3f99:49cb with SMTP id r17-20020a056870439100b000e63f9949cbmr3630342oah.54.1650543853209;
        Thu, 21 Apr 2022 05:24:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzde8lFZi4Umhw6joFgjNOjXz6/6JJ5z2YelZ8a0YKxazzdAVCl3IMXqXX+aq9eC4Gda3I7i9fG0j/IigsLEGU=
X-Received: by 2002:a05:6870:4391:b0:e6:3f99:49cb with SMTP id
 r17-20020a056870439100b000e63f9949cbmr3630336oah.54.1650543853001; Thu, 21
 Apr 2022 05:24:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220420124053.853891-1-kai.heng.feng@canonical.com>
 <20220420124053.853891-5-kai.heng.feng@canonical.com> <YmAgq1pm37Glw2v+@lunn.ch>
 <CAAd53p6UAhDC2mGkz3_HgVs7kFgCwjfu2R+9FfROhToH2R6CjA@mail.gmail.com> <YmFFWd42Nol7Lrlm@lunn.ch>
In-Reply-To: <YmFFWd42Nol7Lrlm@lunn.ch>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Thu, 21 Apr 2022 20:24:00 +0800
Message-ID: <CAAd53p6vUcUu=H=cDMh07zcUUDM8WTp+F_L+jiJSWKqd37+MDg@mail.gmail.com>
Subject: Re: [PATCH 4/5] net: phy: marvell: Add LED accessors for Marvell 88E1510
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     hkallweit1@gmail.com, linux@armlinux.org.uk,
        peppe.cavallaro@st.com, alexandre.torgue@foss.st.com,
        joabreu@synopsys.com, davem@davemloft.net, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 7:51 PM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > This is not feasible.
> > If BIOS can define a method and restore the LED by itself, it can put
> > the method inside its S3 method and I don't have to work on this at
> > the first place.
>
> So maybe just declare the BIOS as FUBAR and move on to the next issue
> assigned to you.
>
> Do we really want the maintenance burden of this code for one machines
> BIOS?

Wasn't this the "set precedence" we discussed earlier for? Someone has
to be the first, and more users will leverage the new property we
added.

> Maybe the better solution is to push back on the vendor and its
> BIOS, tell them how they should of done this, if the BIOS wants to be
> in control of the LEDs it needs to offer the methods to control the
> LEDs. And then hopefully the next machine the vendor produces will
> have working BIOS.

The BIOS doesn't want to control the LED. It just provides a default
LED setting suitable for this platform, so the driver can use this
value over the hardcoded one in marvell phy driver.
So this really has nothing to do with with any ACPI method.
I believe the new property can be useful for DT world too.

>
> Your other option is to take part in the effort to add control of the
> LEDs via the standard Linux LED subsystem. The Marvel PHY driver is
> likely to be one of the first to gain support this for. So you can
> then totally take control of the LED from the BIOS and put it in the
> users hands. And such a solution will be applicable to many machines,
> not just one.

This series just wants to use the default value platform firmware provides.
Create a sysfs to let user meddle with LED value doesn't really help
the case here.

Kai-Heng

>
>        Andrew
