Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB91B4B2B15
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 17:57:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235148AbiBKQ45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 11:56:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351825AbiBKQ44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 11:56:56 -0500
Received: from relay12.mail.gandi.net (relay12.mail.gandi.net [IPv6:2001:4b98:dc4:8::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7A0C21F;
        Fri, 11 Feb 2022 08:56:53 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 0E2CE200006;
        Fri, 11 Feb 2022 16:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1644598612;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=epuYM84Tn+ODiTT+lvHjBYbEpXJYG3364MQ9ICEJw14=;
        b=kAVVi8qHnL9TXVtPiwDgqVd9Bdg4bUdroldXpfatPcoIyMHhgo1On7YrFPcbAy6lr4Tx+W
        9wec8MRKGeXvViSgojfyIyEc2sz3TXgWQgzwr3b7qVa6T5ebRi+T4AGfINpEvotjRDe7W1
        sQd8oDgoT+H1DeLLfHFxcIXU6jj0u3xdbnDbAMcNSd3kxAyc5oX+9TPb1ivcngmEsijyAX
        nJCnAR2Ohq46/uyyZW6gzdFKd6lOKqi+BgPs6tzWVDroXGK9F3Ss5EvNw8TEeaG9ZdRJSr
        6Hc30sjna8OwzoutHHQ2ONJm1aJc8i7iXLUgisM8Vr6m+GE9idz6nWRKSCLN4Q==
Date:   Fri, 11 Feb 2022 17:56:50 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Laurent Vivier <laurent@vivier.eu>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-rtc@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Stephen Boyd <sboyd@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v14 3/5] rtc: goldfish: use gf_ioread32()/gf_iowrite32()
Message-ID: <YgaVUtn6PpXYAewP@piout.net>
References: <20220130143333.552646-1-laurent@vivier.eu>
 <20220130143333.552646-4-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220130143333.552646-4-laurent@vivier.eu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/01/2022 15:33:31+0100, Laurent Vivier wrote:
> replace readl()/writel() by gf_ioread32()/gf_iowrite32()
> as done for goldfish-tty.
> 
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

> ---
>  drivers/rtc/rtc-goldfish.c | 31 ++++++++++++++++---------------
>  1 file changed, 16 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-goldfish.c b/drivers/rtc/rtc-goldfish.c
> index 7ab95d052644..eb1929b0cbb6 100644
> --- a/drivers/rtc/rtc-goldfish.c
> +++ b/drivers/rtc/rtc-goldfish.c
> @@ -10,6 +10,7 @@
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/rtc.h>
> +#include <linux/goldfish.h>
>  
>  #define TIMER_TIME_LOW		0x00	/* get low bits of current time  */
>  					/*   and update TIMER_TIME_HIGH  */
> @@ -41,8 +42,8 @@ static int goldfish_rtc_read_alarm(struct device *dev,
>  	rtcdrv = dev_get_drvdata(dev);
>  	base = rtcdrv->base;
>  
> -	rtc_alarm_low = readl(base + TIMER_ALARM_LOW);
> -	rtc_alarm_high = readl(base + TIMER_ALARM_HIGH);
> +	rtc_alarm_low = gf_ioread32(base + TIMER_ALARM_LOW);
> +	rtc_alarm_high = gf_ioread32(base + TIMER_ALARM_HIGH);
>  	rtc_alarm = (rtc_alarm_high << 32) | rtc_alarm_low;
>  
>  	do_div(rtc_alarm, NSEC_PER_SEC);
> @@ -50,7 +51,7 @@ static int goldfish_rtc_read_alarm(struct device *dev,
>  
>  	rtc_time64_to_tm(rtc_alarm, &alrm->time);
>  
> -	if (readl(base + TIMER_ALARM_STATUS))
> +	if (gf_ioread32(base + TIMER_ALARM_STATUS))
>  		alrm->enabled = 1;
>  	else
>  		alrm->enabled = 0;
> @@ -71,18 +72,18 @@ static int goldfish_rtc_set_alarm(struct device *dev,
>  
>  	if (alrm->enabled) {
>  		rtc_alarm64 = rtc_tm_to_time64(&alrm->time) * NSEC_PER_SEC;
> -		writel((rtc_alarm64 >> 32), base + TIMER_ALARM_HIGH);
> -		writel(rtc_alarm64, base + TIMER_ALARM_LOW);
> -		writel(1, base + TIMER_IRQ_ENABLED);
> +		gf_iowrite32((rtc_alarm64 >> 32), base + TIMER_ALARM_HIGH);
> +		gf_iowrite32(rtc_alarm64, base + TIMER_ALARM_LOW);
> +		gf_iowrite32(1, base + TIMER_IRQ_ENABLED);
>  	} else {
>  		/*
>  		 * if this function was called with enabled=0
>  		 * then it could mean that the application is
>  		 * trying to cancel an ongoing alarm
>  		 */
> -		rtc_status_reg = readl(base + TIMER_ALARM_STATUS);
> +		rtc_status_reg = gf_ioread32(base + TIMER_ALARM_STATUS);
>  		if (rtc_status_reg)
> -			writel(1, base + TIMER_CLEAR_ALARM);
> +			gf_iowrite32(1, base + TIMER_CLEAR_ALARM);
>  	}
>  
>  	return 0;
> @@ -98,9 +99,9 @@ static int goldfish_rtc_alarm_irq_enable(struct device *dev,
>  	base = rtcdrv->base;
>  
>  	if (enabled)
> -		writel(1, base + TIMER_IRQ_ENABLED);
> +		gf_iowrite32(1, base + TIMER_IRQ_ENABLED);
>  	else
> -		writel(0, base + TIMER_IRQ_ENABLED);
> +		gf_iowrite32(0, base + TIMER_IRQ_ENABLED);
>  
>  	return 0;
>  }
> @@ -110,7 +111,7 @@ static irqreturn_t goldfish_rtc_interrupt(int irq, void *dev_id)
>  	struct goldfish_rtc *rtcdrv = dev_id;
>  	void __iomem *base = rtcdrv->base;
>  
> -	writel(1, base + TIMER_CLEAR_INTERRUPT);
> +	gf_iowrite32(1, base + TIMER_CLEAR_INTERRUPT);
>  
>  	rtc_update_irq(rtcdrv->rtc, 1, RTC_IRQF | RTC_AF);
>  
> @@ -128,8 +129,8 @@ static int goldfish_rtc_read_time(struct device *dev, struct rtc_time *tm)
>  	rtcdrv = dev_get_drvdata(dev);
>  	base = rtcdrv->base;
>  
> -	time_low = readl(base + TIMER_TIME_LOW);
> -	time_high = readl(base + TIMER_TIME_HIGH);
> +	time_low = gf_ioread32(base + TIMER_TIME_LOW);
> +	time_high = gf_ioread32(base + TIMER_TIME_HIGH);
>  	time = (time_high << 32) | time_low;
>  
>  	do_div(time, NSEC_PER_SEC);
> @@ -149,8 +150,8 @@ static int goldfish_rtc_set_time(struct device *dev, struct rtc_time *tm)
>  	base = rtcdrv->base;
>  
>  	now64 = rtc_tm_to_time64(tm) * NSEC_PER_SEC;
> -	writel((now64 >> 32), base + TIMER_TIME_HIGH);
> -	writel(now64, base + TIMER_TIME_LOW);
> +	gf_iowrite32((now64 >> 32), base + TIMER_TIME_HIGH);
> +	gf_iowrite32(now64, base + TIMER_TIME_LOW);
>  
>  	return 0;
>  }
> -- 
> 2.34.1
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
