Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 933E04B2F0A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 22:05:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353673AbiBKVDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 16:03:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353650AbiBKVDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 16:03:06 -0500
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97DCE2D3;
        Fri, 11 Feb 2022 13:03:04 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 5488620007;
        Fri, 11 Feb 2022 21:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1644613382;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dBJ4jn/Othh/3mI5Ygz5jPmtny0zhFBhPSaVX6iPMeA=;
        b=Yj4OgahBfdgUT4cPNMdh3B+AjwN0nLxhAHavhTZ7s8t0zyl0cJWVSDiTPhKQFp48if4UYq
        BO28iPBqV/qSsif6nLAAafgAyjcjH8Pkh77j8Lx2Vwhi8jO3ObYynyFWcsvR3BDUw7OQyQ
        Em5e9g4WoPj21dMR6KX5E31C6qDagdstEh7v0sbNJjQC5EI0dcbQaRqY2lT00VL/FYifi4
        HiLsF0cEfPYudAvwQpcvNAYiiF9wT7mUp7eZCcsAyLKjVaxNby97N+k7XFnsjPU2jvXr+u
        ayEF4Y4bDI7CrrYa+6GjyT4eeyvLst7pO1l9rILrhX3oclGB4CAK5BzM3cXAMA==
Date:   Fri, 11 Feb 2022 22:02:58 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Hugo Villeneuve <hvilleneuve@dimonoff.com>
Cc:     "hugo@hugovil.com" <hugo@hugovil.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 10/10] dt-bindings: rtc: pcf2127: add PCF2131 INT_A and
 INT_B support
Message-ID: <YgbPAtIO5kZ/WLhM@piout.net>
References: <20220125200009.900660-1-hugo@hugovil.com>
 <20220125200009.900660-11-hugo@hugovil.com>
 <YgMy/CYL8lmf6Y+J@robh.at.kernel.org>
 <20220210171234.4e317c8a5d5f91f358382b07@hugovil.com>
 <YgWSgGTKR63g+S9e@piout.net>
 <20220210175510.c99eb77c6367d4df5d8bb9a2@hugovil.com>
 <7be3f9541eaed7e17e334267e49665f442b1b458.camel@dimonoff.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7be3f9541eaed7e17e334267e49665f442b1b458.camel@dimonoff.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/02/2022 20:16:27+0000, Hugo Villeneuve wrote:
> > > Actually, this property has to be made more generic and thought
> > > out.
> > > There are multiple RTCs that have multiple interrupt pins where one
> > > of
> > > the pin can be used for different interrupt or clock output.
> 
> Hi,
> the only example I could find of such a device is in rtc-pcf85363.c.
> This device also has two interrupt pins, INT A/B, like the PCF2131.
> However, in the pcf85363 driver, pin INT B is simply ignored, and all
> interrupts are configured to go on INT A.
> 

Yes, this was the RTC for which we had that discussion last time but
there is also pcf8523 and other non NXP RTCs.

> For the moment, I will simply modify my PCF2131 patches serie to mimic
> the same behavior in V2. This simplifies things a lot, and support for
> INT B pin could be added at a later stage (and also to pcf85363) if
> anyone needs it (I don't).
> 
> Hugo.
> 
> > > With your binding, there is no way to separate which interrupt is
> > > going
> > > to which pin and so there is no way to get the alarm and BLF or the
> > > watchdog on different pins and we certainly don't want to have a
> > > property per interrupt type.
> > 
> > Hi,
> > can you please suggest how you would prefer it to be done?
> > 
> > > Also, the documentation is missing the fact that the driver makes
> > > having
> > > one of the property mandatory.
> > 
> > I will add it.
> > 
> > Thank you, Hugo.
> > 
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
