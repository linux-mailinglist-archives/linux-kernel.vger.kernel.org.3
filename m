Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9BB4B1834
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 23:33:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344987AbiBJWch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 17:32:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344965AbiBJWcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 17:32:36 -0500
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81B36267F;
        Thu, 10 Feb 2022 14:32:36 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 75E0F240003;
        Thu, 10 Feb 2022 22:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1644532354;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+QgVffAGvdGWhHLFKs1yKdpUZfk0sx8ZccSaPdB92Lc=;
        b=lAQGGi+iO2hQ8Jo77cYHXAKC9fn+Dtj73HjHETDcS6HzIAeGvxrIUqUd2p3khMDYu59OyQ
        d9Wm+X31vHFHH9humJRy1hjWfxtz/H6kXk285aSJ/p1fIVcjmtz3S7uLf2y/5HJiwhor0i
        DRn+HxJNSn3bc7bhcAHlJsRPTil3HN8+B6G1b6EqyZZsdXrr5i3EmcI4Etj2AjEffrUg96
        V15H9Li6j9h1AmY5UgQAqAn9h8u0C9G2vbO1c+4ZvfqA0ngcTdT8CWoH/OxOCSq8K9dShP
        j9PNV6UDcJ1h6C/zXPXsyClS634lZLYkI5pSXEYeTz737HEZfHqvuaqVqz3Nvw==
Date:   Thu, 10 Feb 2022 23:32:32 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     Rob Herring <robh@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/10] dt-bindings: rtc: pcf2127: add PCF2131 INT_A and
 INT_B support
Message-ID: <YgWSgGTKR63g+S9e@piout.net>
References: <20220125200009.900660-1-hugo@hugovil.com>
 <20220125200009.900660-11-hugo@hugovil.com>
 <YgMy/CYL8lmf6Y+J@robh.at.kernel.org>
 <20220210171234.4e317c8a5d5f91f358382b07@hugovil.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220210171234.4e317c8a5d5f91f358382b07@hugovil.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/02/2022 17:12:34-0500, Hugo Villeneuve wrote:
> On Tue, 8 Feb 2022 21:20:28 -0600
> Rob Herring <robh@kernel.org> wrote:
> 
> > On Tue, Jan 25, 2022 at 03:00:09PM -0500, Hugo Villeneuve wrote:
> > > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > > 
> > > The PCF2131 has two output interrupt pins, named INT_A and INT_B.
> > > 
> > > Add properties to identify onto which pin we want the alarm interrupt
> > > to be routed. It can be either one, or both.
> > > 
> > > These properties are automatically set to false for variants other
> > > than PCF2131 (ex: PCF2127).
> > > 
> > > Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > > ---
> > >  .../devicetree/bindings/rtc/nxp,pcf2127.yaml  | 23 +++++++++++++++++++
> > >  1 file changed, 23 insertions(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/rtc/nxp,pcf2127.yaml b/Documentation/devicetree/bindings/rtc/nxp,pcf2127.yaml
> > > index 57eb0a58afa3..83656dd2f97f 100644
> > > --- a/Documentation/devicetree/bindings/rtc/nxp,pcf2127.yaml
> > > +++ b/Documentation/devicetree/bindings/rtc/nxp,pcf2127.yaml
> > > @@ -24,6 +24,16 @@ properties:
> > >    interrupts:
> > >      maxItems: 1
> > >  
> > > +  alarm-output-a:
> > 
> > nxp,alarm-output-a
> 
> Ok, this will be fixed for V2.
> 

Actually, this property has to be made more generic and thought out.
There are multiple RTCs that have multiple interrupt pins where one of
the pin can be used for different interrupt or clock output.

With your binding, there is no way to separate which interrupt is going
to which pin and so there is no way to get the alarm and BLF or the
watchdog on different pins and we certainly don't want to have a
property per interrupt type.

Also, the documentation is missing the fact that the driver makes having
one of the property mandatory.


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
