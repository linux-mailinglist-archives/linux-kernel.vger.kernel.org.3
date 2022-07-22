Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 549D857E406
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 18:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233890AbiGVQC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 12:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbiGVQC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 12:02:57 -0400
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE48A17E3C;
        Fri, 22 Jul 2022 09:02:54 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 5460224000C;
        Fri, 22 Jul 2022 16:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1658505773;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cKG0lEYF348X//U1pESwwqdpnRBOQ0QEs5ZB22edgwM=;
        b=RgNRybfSVRwwGQB9674BRQtSIt3YcXmaOZRK1Gr2bUKatx6KUeQS6Vx1xDwfB2Uj9FWprO
        U/3BrpXAvYY/RPMUw77VaJ7BeSnLP28jkRVMKBEvurpdUB6+WnXX56jfKZrbgiGE2zDdGh
        Mlbwg01OocQkm7gnVWzH1ZxSHgSv0H45XFFKWPSTIPQNQQeIlC8nq25DcTjK914mQe3xwU
        2e8vHjUZ0UGlCdlgm4s6Vyz/AsDAOWKfAjflTltyrFoWonxDhh34YJB5sF70bqUkNIwbqZ
        96WSB6JESv+mFOiv5c86KL7gAlztgTywpR//qQU3AoFYdBKoQfgiOF0HQiakfA==
Date:   Fri, 22 Jul 2022 18:02:51 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Valentin CARON <valentin.caron@foss.st.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>,
        linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] dt-bindings: rtc: stm32: add alarm A out property to
 select output
Message-ID: <YtrKK1+Bp60MSHhp@mail.local>
References: <20220504130233.330983-1-valentin.caron@foss.st.com>
 <20220504130617.331290-1-valentin.caron@foss.st.com>
 <YnLhw+Y7m8G2xJpK@mail.local>
 <ceb2d1a3-dccd-865e-ed74-54444e49f349@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ceb2d1a3-dccd-865e-ed74-54444e49f349@foss.st.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/05/2022 14:34:22+0200, Valentin CARON wrote:
> Hi Alexandre,
> 
> On 5/4/22 22:27, Alexandre Belloni wrote:
> > Hello,
> > 
> > On 04/05/2022 15:06:13+0200, Valentin Caron wrote:
> > > STM32 RTC can pulse some SOC pins when an alarm of RTC expires.
> > > 
> > > This patch adds property to activate alarm A output. The pulse can
> > > output on three pins RTC_OUT1, RTC_OUT2, RTC_OUT2_RMP
> > > (PC13, PB2, PI8 on stm32mp15) (PC13, PB2, PI1 on stm32mp13).
> > > 
> > > Signed-off-by: Valentin Caron <valentin.caron@foss.st.com>
> > > ---
> > >   .../devicetree/bindings/rtc/st,stm32-rtc.yaml | 19 ++++++++++++++++++-
> > >   1 file changed, 18 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/rtc/st,stm32-rtc.yaml b/Documentation/devicetree/bindings/rtc/st,stm32-rtc.yaml
> > > index 56d46ea35c5d..71e02604e8de 100644
> > > --- a/Documentation/devicetree/bindings/rtc/st,stm32-rtc.yaml
> > > +++ b/Documentation/devicetree/bindings/rtc/st,stm32-rtc.yaml
> > > @@ -59,6 +59,13 @@ properties:
> > >         Refer to <include/dt-bindings/rtc/rtc-stm32.h> for the supported values.
> > >         Pinctrl state named "default" may be defined to reserve pin for RTC output.
> > > +  st,alarm:
> > > +    $ref: "/schemas/types.yaml#/definitions/uint32"
> > > +    description: |
> > > +      To select and enable RTC Alarm A output.
> > > +      Refer to <include/dt-bindings/rtc/rtc-stm32.h> for the supported values.
> > > +      Pinctrl state named "default" may be defined to reserve pin for RTC output.
> > > +
> > >   allOf:
> > >     - if:
> > >         properties:
> > > @@ -75,6 +82,9 @@ allOf:
> > >           st,lsco:
> > >             maxItems: 0
> > > +        st,alarm:
> > > +          maxItems: 0
> > > +
> > >           clock-names: false
> > >         required:
> > > @@ -95,6 +105,9 @@ allOf:
> > >           st,lsco:
> > >             maxItems: 0
> > > +        st,alarm:
> > > +          maxItems: 0
> > > +
> > >         required:
> > >           - clock-names
> > >           - st,syscfg
> > > @@ -117,6 +130,9 @@ allOf:
> > >           st,lsco:
> > >             maxItems: 1
> > > +        st,alarm:
> > > +          maxItems: 1
> > > +
> > >         required:
> > >           - clock-names
> > > @@ -153,8 +169,9 @@ examples:
> > >         clocks = <&rcc RTCAPB>, <&rcc RTC>;
> > >         clock-names = "pclk", "rtc_ck";
> > >         interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
> > > +      st,alarm = <RTC_OUT1>;
> > >         st,lsco = <RTC_OUT2_RMP>;
> > Shouldn't that be exactly the opposite? You have two pins that can
> > output different functions. The property should be the pin and the value
> > the function. I'd go even further and I would say this is actually
> > pinmuxing.
> > 
> You're right, if the property is the pin and the value the function, this
> looks like a pinctrl node.
> We choose to develop theses functionalities in the reverse order, to avoid
> the complexity of adding
> the pinctrl framework to our driver. Moreover, LSCO and AlarmA may haven't a
> peripheral client and
> this would probably require to also implement pinctrl hogging.
> 
> Is the implementation that we have proposed is acceptable regarding theses
> elements ?
> 


I still think that the pin has to be the property and the function the value.

Or we could find a generic name and provide an array of pin, function
pair

Or, go for pinmuxing

My point here is that this is a common feature an RTCs and I don't want
every vendor to come up with their own properties.

Regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
