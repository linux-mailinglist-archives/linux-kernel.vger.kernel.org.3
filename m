Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6784AD663
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 12:25:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358173AbiBHLZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 06:25:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356063AbiBHKHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 05:07:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FC26C03FEC0;
        Tue,  8 Feb 2022 02:07:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 51E25B81802;
        Tue,  8 Feb 2022 10:07:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55214C340EF;
        Tue,  8 Feb 2022 10:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1644314827;
        bh=OikrdX8FMNiMLuMVEJTQbFg4yac0GkRiulyJsMntNGY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jiP1EPaq3l/aJLJwYUcK5NMYqW2KzAtVaLuE9HOb9vDiTt92PUE12lcvGYU6E6zqt
         XcPHv5v36KfoKOmKMk4R3I/1iVdMxdBG53W5NftkumO7AlhhmCtBDucZk4S+gPHloK
         ss7Xe7jZpLAI2h8sTcfxDRByeIUNzXrPHSohN2ps=
Date:   Tue, 8 Feb 2022 11:07:04 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Erwan LE RAY <erwan.leray@foss.st.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Gerald Baeza <gerald.baeza@st.com>,
        Valentin Caron <valentin.caron@foss.st.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] serial: mctrl_gpio: add a new API to enable /
 disable wake_irq
Message-ID: <YgJAyAZFJBFXQGvf@kroah.com>
References: <20220203171644.12231-1-erwan.leray@foss.st.com>
 <20220203171644.12231-2-erwan.leray@foss.st.com>
 <CAHp75VfxGj=3mKvjcRpQjyXBCM0szsidHVuJGdAL8yP5SmdBzw@mail.gmail.com>
 <cb09a49a-37f8-9e3f-168c-4c5dd62e2c07@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cb09a49a-37f8-9e3f-168c-4c5dd62e2c07@foss.st.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 04, 2022 at 04:41:58PM +0100, Erwan LE RAY wrote:
> Hi Andy,
> 
> On 2/4/22 10:07 AM, Andy Shevchenko wrote:
> > 
> > 
> > On Thursday, February 3, 2022, Erwan Le Ray <erwan.leray@foss.st.com
> > <mailto:erwan.leray@foss.st.com>> wrote:
> > 
> >     Add a new API to enable / disable wake_irq in order to enable gpio
> >     irqs as
> >     wakeup irqs for the uart port.
> > 
> >     Signed-off-by: Erwan Le Ray <erwan.leray@foss.st.com
> >     <mailto:erwan.leray@foss.st.com>>
> > 
> >     diff --git a/drivers/tty/serial/serial_mctrl_gpio.c
> >     b/drivers/tty/serial/serial_mctrl_gpio.c
> >     index c41d8911ce95..1663b3afc3a0 100644
> >     --- a/drivers/tty/serial/serial_mctrl_gpio.c
> >     +++ b/drivers/tty/serial/serial_mctrl_gpio.c
> >     @@ -299,4 +299,42 @@ void mctrl_gpio_disable_ms(struct mctrl_gpios
> >     *gpios)
> >       }
> >       EXPORT_SYMBOL_GPL(mctrl_gpio_disable_ms);
> > 
> >     +void mctrl_gpio_enable_irq_wake(struct mctrl_gpios *gpios)
> >     +{
> >     +       enum mctrl_gpio_idx i;
> >     +
> >     +       if (!gpios)
> >     +               return;
> >     +
> >     +       if (!gpios->mctrl_on)
> >     +               return;
> >     +
> >     +       for (i = 0; i < UART_GPIO_MAX; ++i) {
> >     +               if (!gpios->irq[i])
> >     +                       continue;
> > 
> > 
> > 
> > Why not simply
> > 
> >    if (gpios[])
> >      enable_irq_...
> > 
> > ?
> > 
> > And same for disabling.
> > 
> >     +
> >     +               enable_irq_wake(gpios->irq[i]);
> >     +       }
> >     +}
> >     +EXPORT_SYMBOL_GPL(mctrl_gpio_enable_irq_wake);
> >     +
> >     +void mctrl_gpio_disable_irq_wake(struct mctrl_gpios *gpios)
> >     +{
> >     +       enum mctrl_gpio_idx i;
> >     +
> >     +       if (!gpios)
> >     +               return;
> >     +
> >     +       if (!gpios->mctrl_on)
> >     +               return;
> >     +
> >     +       for (i = 0; i < UART_GPIO_MAX; ++i) {
> >     +               if (!gpios->irq[i])
> >     +                       continue;
> >     +
> >     +               disable_irq_wake(gpios->irq[i]);
> >     +       }
> >     +}
> >     +EXPORT_SYMBOL_GPL(mctrl_gpio_disable_irq_wake);
> >     +
> >       MODULE_LICENSE("GPL");
> >     diff --git a/drivers/tty/serial/serial_mctrl_gpio.h
> >     b/drivers/tty/serial/serial_mctrl_gpio.h
> >     index b134a0ffc894..fc76910fb105 100644
> >     --- a/drivers/tty/serial/serial_mctrl_gpio.h
> >     +++ b/drivers/tty/serial/serial_mctrl_gpio.h
> >     @@ -91,6 +91,16 @@ void mctrl_gpio_enable_ms(struct mctrl_gpios *gpios);
> >        */
> >       void mctrl_gpio_disable_ms(struct mctrl_gpios *gpios);
> > 
> >     +/*
> >     + * Enable gpio wakeup interrupts to enable wake up source.
> >     + */
> >     +void mctrl_gpio_enable_irq_wake(struct mctrl_gpios *gpios);
> >     +
> >     +/*
> >     + * Disable gpio wakeup interrupts to enable wake up source.
> >     + */
> >     +void mctrl_gpio_disable_irq_wake(struct mctrl_gpios *gpios);
> >     +
> >       #else /* GPIOLIB */
> > 
> >       static inline
> >     @@ -142,6 +152,14 @@ static inline void mctrl_gpio_disable_ms(struct
> >     mctrl_gpios *gpios)
> >       {
> >       }
> > 
> >     +static inline void mctrl_gpio_enable_irq_wake(struct mctrl_gpios
> >     *gpios)
> >     +{
> >     +}
> >     +
> >     +static inline void mctrl_gpio_disable_irq_wake(struct mctrl_gpios
> >     *gpios)
> >     +{
> >     +}
> >     +
> >       #endif /* GPIOLIB */
> > 
> >       #endif
> >     --     2.17.1
> > 
> > 
> > 
> > -- 
> > With Best Regards,
> > Andy Shevchenko
> > 
> > 
> 
> Thanks for your review.
> I fully agree with your comment, but I wrote this code like it is to keep
> the same structure than all the other ops of serial_mcrtrl_gpio driver. I
> preferred keeping an homogeneous code in the driver rather than breaking the
> driver homogeneity with the addition of an optimized code.
> 
> Greg, can you please indicate which solution you recommend ?

Sadly, this is the format in this file, so I'll take this as-is.

thanks,

greg k-h
