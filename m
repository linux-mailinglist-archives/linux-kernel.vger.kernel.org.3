Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28B9B59F834
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 12:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236383AbiHXKxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 06:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234115AbiHXKx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 06:53:29 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD2123C8E1;
        Wed, 24 Aug 2022 03:53:27 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id EF58A60008;
        Wed, 24 Aug 2022 10:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1661338404;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wWhY07SBJoBBrYsQWckDh4HVuRXZ5NEqxZCLw/HYK4o=;
        b=XC5u1hqmTD48Pjx9ydsP4Lkm6A6OUg420rdBtQOCgaujq4WUkcoADDxGgyOas2RM+pfva6
        OAIn5ogyolHiDbTykHOAlnZYAochDBuolz4zh3uA928SVz1MxxpskZCYd2rjOv9TEQpGAd
        lLv9pU2yRmc3I9+Yshytw+fw+VhMmPbK+Qf8Zwt+eiOCboDLg+PQ2pDz1fet61OdKduPt1
        gXk8j7gp+AAbrov2ww/qWoksgiuS5me0Lb9WWv4XHiizy+Nss1FavcWH9mTp9LWGk1XZ/q
        KIoPSSfXmc7S5nhVeTUw+rROISaJeHWeCXsvjuWLHbWoLLb5ZIeLaNmBCdlBwQ==
Date:   Wed, 24 Aug 2022 12:53:23 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Conor.Dooley@microchip.com
Cc:     christophe.jaillet@wanadoo.fr, Daire.McNamara@microchip.com,
        a.zummo@towertech.it, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-rtc@vger.kernel.org
Subject: Re: [PATCH] rtc: mpfs: Use devm_clk_get_enabled() helper
Message-ID: <YwYDI04TDD0RWn2B@mail.local>
References: <e55c959f2821a2c367a4c5de529a638b1cc6b8cd.1661329086.git.christophe.jaillet@wanadoo.fr>
 <f76fb247-5160-61ed-a0a3-037d2f40d2f9@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f76fb247-5160-61ed-a0a3-037d2f40d2f9@microchip.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/08/2022 09:58:35+0000, Conor.Dooley@microchip.com wrote:
> Hey Christope,
> Thanks for your patch.
> 
> On 24/08/2022 09:18, Christophe JAILLET wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > The devm_clk_get_enabled() helper:
> >     - calls devm_clk_get()
> >     - calls clk_prepare_enable() and registers what is needed in order to
> >       call clk_disable_unprepare() when needed, as a managed resource.
> > 
> > This simplifies the code, the error handling paths and avoid the need of
> > a dedicated function used with devm_add_action_or_reset().
> > 
> > That said, mpfs_rtc_init_clk() is the same as devm_clk_get_enabled(), so
> > use this function directly instead.
> 
> Firstly, I think something is missing from the commit description here.
> devm_clk_get_enabled() is not just a blanket "use this instead of get(),
> prepare_enable()" & is only intended for cases where the clock would
> be kept prepared or enabled for the whole lifetime of the driver. I think
> it is worth pointing that out to help people who do not keep up with
> every helper that is added.
> 
> I had a bit of a look through the documentation to see if the block would
> keep track of time without the AHB clock enabled, but it does not seem to.
> There is no reason to turn off the clock here (in fact it would seem
> counter productive to disable it..) so it looks like the shoe fits in that
> regard.

This would be very surprising that it doesn't keep the time with the AHB
clock disabled, this would mean the RTC loses the time when the SoC is
not powered. or is the AHB clock also in the always-on domain?

> 
> However...
> 
> > 
> > This also fixes an (unlikely) unchecked devm_add_action_or_reset() error.
> > 
> > Based on my test with allyesconfig, this reduces the .o size from:
> >     text    data     bss     dec     hex filename
> >     5330    2208       0    7538    1d72 drivers/rtc/rtc-mpfs.o
> > down to:
> >     5074    2208       0    7282    1c72 drivers/rtc/rtc-mpfs.o
> > 
> > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > ---
> > devm_clk_get_enabled() is new and is part of 6.0-rc1
> > ---
> >   drivers/rtc/rtc-mpfs.c | 19 +------------------
> >   1 file changed, 1 insertion(+), 18 deletions(-)
> > 
> > diff --git a/drivers/rtc/rtc-mpfs.c b/drivers/rtc/rtc-mpfs.c
> > index 944ad1036516..2a479d44f198 100644
> > --- a/drivers/rtc/rtc-mpfs.c
> > +++ b/drivers/rtc/rtc-mpfs.c
> > @@ -193,23 +193,6 @@ static int mpfs_rtc_alarm_irq_enable(struct device *dev, unsigned int enabled)
> >          return 0;
> >   }
> > 
> > -static inline struct clk *mpfs_rtc_init_clk(struct device *dev)
> > -{
> > -       struct clk *clk;
> > -       int ret;
> > -
> > -       clk = devm_clk_get(dev, "rtc");
> > -       if (IS_ERR(clk))
> > -               return clk;
> > -
> > -       ret = clk_prepare_enable(clk);
> > -       if (ret)
> > -               return ERR_PTR(ret);
> > -
> > -       devm_add_action_or_reset(dev, (void (*) (void *))clk_disable_unprepare, clk);
> 
> ... this bit here concerns me a little. I don't think we should be
> registering a callback here at all - if we power down Linux this is
> going to end up stopping the RTC isn't it?
> 
> I think this is left over from the v1 driver submission that reset
> the block during probe & should be removed.
> 
> Thanks,
> Conor.
> 
> > -       return clk;
> > -}
> > -
> >   static irqreturn_t mpfs_rtc_wakeup_irq_handler(int irq, void *dev)
> >   {
> >          struct mpfs_rtc_dev *rtcdev = dev;
> > @@ -251,7 +234,7 @@ static int mpfs_rtc_probe(struct platform_device *pdev)
> >          /* range is capped by alarm max, lower reg is 31:0 & upper is 10:0 */
> >          rtcdev->rtc->range_max = GENMASK_ULL(42, 0);
> > 
> > -       clk = mpfs_rtc_init_clk(&pdev->dev);
> > +       clk = devm_clk_get_enabled(&pdev->dev, "rtc");
> >          if (IS_ERR(clk))
> >                  return PTR_ERR(clk);
> > 
> > --
> > 2.34.1
> > 
> > 
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
