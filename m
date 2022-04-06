Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9614E4F6C5D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 23:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234820AbiDFVQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 17:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235518AbiDFVP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 17:15:56 -0400
X-Greylist: delayed 23900 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 06 Apr 2022 13:00:15 PDT
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 633192467DF;
        Wed,  6 Apr 2022 13:00:14 -0700 (PDT)
Received: from darkstar.musicnaut.iki.fi (85-76-76-218-nat.elisa-mobile.fi [85.76.76.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: aaro.koskinen)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id C3DA61B000E0;
        Wed,  6 Apr 2022 23:00:11 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1649275212;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HF/OS3JAtoNKv3AksoUVmxtqiwmaGXqNkeVyB7AYT2k=;
        b=Nn4RAbFbzK4bwfg86ykyMmwZil9SKibzGCF6IqPtA9woskWkPm0Qpo8xHB6DmiuFZCDabl
        hKhYB7cTF1pnQmfdEueduNI+Bie9rxrrlv4+Ae9YdogxoZPaT+AnKd36njOcJfii/ZG9el
        NXeQ9cJa9eyyADZvMify5l3g3e6/9P6d54WrG6RxGfxgsqDX4gklm2g60np78Z2iAK4H5W
        MYGDa3g/ettQmzEK/GGe/dgnxSa0+JfQVzn6IDHYnDPuqAhZ29ChrVGrIXEk6e+gIQp/ZO
        YsKxpOTuJMbZKTk6UgFqwopmBrXCz1Q8WLvlxfzJ2EFoML4ykS+CJaqZAs9ITA==
Date:   Wed, 6 Apr 2022 23:00:10 +0300
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc:     Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helge Deller <deller@gmx.de>, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Felipe Balbi <balbi@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-mmc@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH v2] ARM: OMAP1: Prepare for conversion of OMAP1 clocks to
 CCF
Message-ID: <20220406200010.GE594699@darkstar.musicnaut.iki.fi>
References: <20220310233307.99220-3-jmkrzyszt@gmail.com>
 <1810824.tdWV9SEqCh@dell>
 <20220406132149.GC594699@darkstar.musicnaut.iki.fi>
 <1888452.PYKUYFuaPT@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1888452.PYKUYFuaPT@dell>
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1649275212; a=rsa-sha256;
        cv=none;
        b=Ol1GS9eE8NlyDUV0WcHY2VWATp+nj58s0051qvEeumo7NtBnjXas42R78yzG70ifyC61w1
        uNejgjj5y2u/lipXR8kWDr6uohk/Qlt2RTi7GBtSFq/B72+3ebibY0TmKGFTacwnLE/Q0Q
        tPyBaa+IGUVAVry4W3pdajUy4YfXuZPAbe7qOV2W6PWhvFy5/u1KlaqNZJsnjYrRO5D9dj
        xoCq4TSeoGt+wWudWLGQwD7h83OmvjLmmnHe1ciL+J2iNX7wi6z6XTcYeQ2dMUgmsEzE7h
        UOG82BaXJw2nJuLhTmns2woVednPtANIIzueIdMPzqje3Y1nqQ/oFewmJr60ng==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=aaro.koskinen smtp.mailfrom=aaro.koskinen@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1649275212;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HF/OS3JAtoNKv3AksoUVmxtqiwmaGXqNkeVyB7AYT2k=;
        b=amTI0JvrXmyzyX8Uf2XnSz1hRH/n+rrTw1Nz41uGo9Db4A+x3UljqHgdkWZ+xZMSMFXmqF
        NpqoT7DqPS10usMauUwiurnKUVrlRou9YOW5adeY4I5ejE8YptoMDaRUt5BlI5ya6Tsir4
        ZQ9EwOXwkara1rof7KYZYYBUaJHXP873LqWCguWgum+N5SNiM6cE8BjG6+lCLdr+Og6l7/
        02uNTNywsqyZ7r97elJ/MoCN+w2VWTRKFSv18b2pTuPihEhiQNuhWhqeAlpXg+nqf5Nq92
        42iC+aDWXKVc7nuF531otS5HSwey0rL0Z+4eYJWSaqI9TJ0RCC9yORLMK37McA==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Apr 06, 2022 at 08:48:14PM +0200, Janusz Krzysztofik wrote:
> Dnia środa, 6 kwietnia 2022 15:21:49 CEST Aaro Koskinen pisze:
> > On Sat, Mar 26, 2022 at 10:17:49PM +0100, Janusz Krzysztofik wrote:
> > > Dnia wtorek, 22 marca 2022 20:07:53 CET Aaro Koskinen pisze:
> > > > On Tue, Mar 22, 2022 at 06:36:48PM +0200, Aaro Koskinen wrote:
> > > > > Something is still broken. When doing kexec (using CCF kernel), the
> > > > > kexec'ed kernel now hangs early (on 770):
> > > > [...]
> > > > > [    0.928863] calling  omap1_init_devices+0x0/0x2c @ 1
> > > > 
> > > > It hangs in omap_sram_reprogram_clock() (<- omap1_select_table_rate()
> > > > <- omap1_clk_late_init()).
> > > 
> > > I've reviewed my changes but haven't found anything suspicious.
> > 
> > The below change is fixing the kexec boot. Based on the comment in the
> > code, it seems this clock is needed for the SRAM to work.
> > 
> > diff --git a/arch/arm/mach-omap1/clock_data.c b/arch/arm/mach-omap1/clock_data.c
> > index e33e11f826af..b8b4876ff935 100644
> > --- a/arch/arm/mach-omap1/clock_data.c
> > +++ b/arch/arm/mach-omap1/clock_data.c
> > @@ -285,7 +285,7 @@ static struct omap1_clk tc1_ck = {
> >   */
> >  
> >  static struct omap1_clk tc2_ck = {
> > -	.hw.init	= CLK_HW_INIT("tc2_ck", "tc_ck", &omap1_clk_gate_ops, 0),
> > +	.hw.init	= CLK_HW_INIT("tc2_ck", "tc_ck", &omap1_clk_gate_ops, CLK_IS_CRITICAL),
> >  	.ops		= &clkops_generic,
> >  	.enable_reg	= OMAP1_IO_ADDRESS(ARM_IDLECT3),
> >  	.enable_bit	= EN_TC2_CK,
> > 
> > A.
> > 
> 
> Thank you Aaro.  Will you submit this as a separate fix, or should I submit 
> v2 of my patch 4/4 with your fix included?

Please send a new version with the fix included.

A.
