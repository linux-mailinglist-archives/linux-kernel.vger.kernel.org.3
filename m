Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B708E59CC5E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 01:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238727AbiHVXoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 19:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235448AbiHVXoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 19:44:03 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95249E012;
        Mon, 22 Aug 2022 16:44:00 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1oQH5A-00013b-GV; Tue, 23 Aug 2022 01:43:48 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Quentin Schulz <foss+kernel@0leil.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Quentin Schulz <quentin.schulz@theobroma-systems.com>
Subject: Re: [RFC PATCH 0/1] Making Rockchip IO domains dependency from other devices explicit
Date:   Tue, 23 Aug 2022 01:43:46 +0200
Message-ID: <2696616.PYKUYFuaPT@diego>
In-Reply-To: <CACRpkdZXTtar73-HP8_wcAsCYw7JOgPwkXZt-_3s0GdoggBABw@mail.gmail.com>
References: <20220802095252.2486591-1-foss+kernel@0leil.net> <CACRpkdZXTtar73-HP8_wcAsCYw7JOgPwkXZt-_3s0GdoggBABw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Am Montag, 22. August 2022, 10:38:11 CEST schrieb Linus Walleij:
> On Tue, Aug 2, 2022 at 11:53 AM Quentin Schulz <foss+kernel@0leil.net> wrote:
> 
> > Some background on IO domains on Rockchip:
> >
> > On some Rockchip SoCs, some SoC pins are split in what are called IO
> > domains.
> >
> > An IO domain is supplied power externally, by regulators from a PMIC for
> > example. This external power supply is then used by the IO domain as
> > "supply" for the IO pins if they are outputs.
> >
> > Each IO domain can configure which voltage the IO pins will be operating
> > on (1.8V or 3.3V).
> >
> > There already exists an IO domain driver for Rockchip SoCs[1]. This
> > driver allows to explicit the relationship between the external power
> > supplies and IO domains[2]. This makes sure the regulators are enabled
> > by the Linux kernel so the IO domains are supplied with power and
> > correctly configured as per the supplied voltage.
> > This driver is a regulator consumer and does not offer any other
> > interface for device dependency.
> 
> What makes me confused about the patch is the relationship, if any,
> between this "IO domain" and generic power domains (genpd) that has
> been worked on for ~10 years.
> 
> I am worried that we are reinventing the world.

In a nutshell, the Rockchip io-domains handle the voltages of specific
pin-groups. I.e. mostly it is just switching between 1.8V and 3.3V .

The voltage itself is always set in a (i2c-)regulator but there is a
separate step necessary to tell the soc this information.

3.3 -> 1.8: set regulator to 1.8, tell io-domain "we're at 1.8 now"
1.8 -> 3.3: tell io-domain "3.3", set regulator to 3.3.

There is supposedly a soc-health-issue if you set the regulator to 3.3
while the io-domain thinks it's at 1.8 .


So the io-domain driver right now, just attaches to the regulator, catches
the voltage-change events and sets the io-domain setting accordingly.


What Quentin is trying to solve is a probe-dependency issue that can
happen when stuff is built into the kernel, the regulator has probed
the regulator using driver has probed, but the io.domain driver hasn't,
as that also only attached to the regulator as described above.

Heiko


> While my intuitive feeling is that genpd power domains are only on-chip
> and not considering off-chip pins, I am not so sure that it warrants
> its own abstraction and want to know whether this can be retrofit into
> genpd rather than inventing this?
> 
> Documentation/devicetree/bindings/power/power-domain.yaml
> include/linux/pm_domain.h
> 
> Yours,
> Linus Walleij
> 




