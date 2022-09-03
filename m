Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BFCD5ABF7A
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 17:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbiICPNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 11:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiICPNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 11:13:14 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [185.16.172.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 247DC41D34;
        Sat,  3 Sep 2022 08:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=BiitqeKalMPshyno6OYFxIT0YzySsq7ePYD/GgFK/wU=; b=TkoZpy3K7Y7WD4HUl5W90O86ph
        lcawWuy6T88t1KjgVa6YCokVy7lQzN2zZnVan2F77Y8svLmvFwqClP5s3Huq2HVfZFaujLAPjqvXL
        m9LNA2yCPu6n2r4vrIjW3PUa8GvjdzhAYIlWUkhsAs094KEuFeBihH6cxR7JAx/df/Dg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1oUUpK-00FVsj-G9; Sat, 03 Sep 2022 17:12:54 +0200
Date:   Sat, 3 Sep 2022 17:12:54 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: turris-omnia: Add mcu node
Message-ID: <YxNu9sXY5UhVCZ+w@lunn.ch>
References: <20220819131152.6513-1-pali@kernel.org>
 <20220831142809.lcmnv3l4rnulo522@pali>
 <YxE2JqJutZ0ilghH@lunn.ch>
 <20220903043828.6afd3ab4@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220903043828.6afd3ab4@thinkpad>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > diff --git a/arch/arm/boot/dts/armada-385-turris-omnia.dts b/arch/arm/boot/dts/armada-385-turris-omnia.dts
> > > > index f4878df39753..f655e9229d68 100644
> > > > --- a/arch/arm/boot/dts/armada-385-turris-omnia.dts
> > > > +++ b/arch/arm/boot/dts/armada-385-turris-omnia.dts
> > > > @@ -184,7 +184,13 @@
> > > >  			#size-cells = <0>;
> > > >  			reg = <0>;
> > > >  
> > > > -			/* STM32F0 command interface at address 0x2a */
> > > > +			/* MCU command i2c API */
> > > > +			mcu: mcu@2a {
> > > > +				compatible = "cznic,turris-omnia-mcu";
> > > > +				reg = <0x2a>;
> > > > +				gpio-controller;
> > > > +				#gpio-cells = <3>;
> > > > +			};  
> > 
> > Please document the binding, preferably in yaml.
> > 
> > I'm also not sure what the DT people will say about the node name mcu.
> > I don't see any examples of that in the binding documentation. They
> > might request you rename it to gpio-controller, unless it does more
> > than GPIO? And if it does do more than GPIO we are then into mfd
> > territory, and the binding then becomes much more interesting. Then we
> > start the questions, are you defining a ABI now, before there is even
> > a driver for it?
> 
> Most probably mfd territory. It is at least a gpio-controller,
> reset-controller and watchdog.

O.K.

Then i suggest we wait for the actual drivers before committing any
DT. The binding will need revier, and could change.

    Andrew
