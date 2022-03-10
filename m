Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 188984D52E6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 21:10:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244559AbiCJULK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 15:11:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240295AbiCJULH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 15:11:07 -0500
Received: from metanate.com (unknown [IPv6:2001:8b0:1628:5005::111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D912B9BBAA
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 12:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=metanate.com; s=stronger; h=In-Reply-To:Content-Type:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description; bh=EudowKxfuxNie/ZjDfg6vUBWXj6aFVtwbByn8cDt7u0=; b=KLfK5
        LOPvlCEY+dbh4fbpastBX+zfJn5iFUDHcdp+MUaGJd5qE9DZWpDNYguBfD7VQtiWoXPch/2af1BPo
        9N/bXphDDYVXm7QWcFOWTlx/wAohslHDHNewkmh+dq/7vIUGvISsGltk3Bi8/k7z8Saf+n51heS+k
        +QImFLyPlJ3vlXVX2wlVKWauAClsOHiGF1hRHuxuwaN5BvgKiPrh1yyKLVUD+uHMMt83ZCO80Pa6T
        yQt9ZYB056GPJz7MgCafSaTxvWm0Fu4n3WlaZXFnKYmsm+ShpX1KrOeStWLL9HTWvRSFOKztcaHPr
        jHrlLpTaAwL5rAEaRIML00ecOT8JQ==;
Received: from [81.174.171.191] (helo=donbot)
        by email.metanate.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <john@metanate.com>)
        id 1nSP6Z-0001lX-L2; Thu, 10 Mar 2022 20:09:47 +0000
Date:   Thu, 10 Mar 2022 20:09:42 +0000
From:   John Keeping <john@metanate.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Daniel Beer <daniel.beer@igorinstitute.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ASoC: tas5805m: fix pdn polarity
Message-ID: <YipbBti4yeq2HzCe@donbot>
References: <20220309135649.195277-1-john@metanate.com>
 <YijOHNT0eqDyoviP@sirena.org.uk>
 <YijTk0/UTXpjFiRq@donbot>
 <YijVrgZ+Ysv9J/8E@sirena.org.uk>
 <YikLB4+xHVxjFTSL@donbot>
 <YikiXAseSiODXfrD@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YikiXAseSiODXfrD@sirena.org.uk>
X-Authenticated: YES
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2022 at 09:55:40PM +0000, Mark Brown wrote:
> On Wed, Mar 09, 2022 at 08:16:07PM +0000, John Keeping wrote:
> > On Wed, Mar 09, 2022 at 04:28:30PM +0000, Mark Brown wrote:
> 
> > > I think the device tree binding needs to be clarified here to be
> > > explicit about this since there's obviously some room for user confusion
> > > here.  We can probably get away with a change at this point since it's
> > > not hit a release but we do need to try to avoid the situation where any
> > > other implementations use active high polarity for the bindings.
> 
> > Taking a quick survey of the other devices that have a pdn-gpios
> > property:
> 
> > - tvp5150 is correct with the driver setting 0 to make the device active
> 
> > - tas571x also sets 0 to make the device active
> 
> > - ak4375 uses the opposite sense setting PDN = 1 to make the device
> >   active; this has no in-tree users and was merged as part of v5.17-rc1
> >   so it's not in a released kernel yet
> 
> Sure, I still think it would be good to update the binding document to
> clarify things as part of your patch - the binding currently just has it
> as the "pdn" pin not the /pdn pin or anything.

I've been thinking about this but I can't really think what to say.
tas571x's binding says:

	GPIO specifier for the TAS571x's active low powerdown line

Is that the sort of wording you have in mind?

To me it seems like a general principle that the GPIO_ACTIVE_{HIGH,LOW}
flags should be used to indicate how the pin works so that the driver
consistently uses logical levels regardless of how the hardware is
wired.

From the driver point of view pdn-gpios is effectively reset-gpios by
another name and it's pretty consistent that setting a reset GPIO to 1
means the device is inaccessible.

Maybe this just means I'm approaching this "down" from the software
abstraction more than "up" from the hardware.
