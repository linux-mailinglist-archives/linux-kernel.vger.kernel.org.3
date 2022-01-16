Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F046148FF84
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 23:46:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236378AbiAPWqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 17:46:54 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:33659 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbiAPWqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 17:46:54 -0500
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 9DA02240002;
        Sun, 16 Jan 2022 22:46:52 +0000 (UTC)
Date:   Sun, 16 Jan 2022 23:46:52 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Mateusz =?utf-8?Q?Jo=C5=84czyk?= <mat.jonczyk@o2.pl>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alessandro Zummo <a.zummo@towertech.it>
Subject: Re: [PATCH] rtc-cmos: replace obsolete comments
Message-ID: <YeSgXJlPf9ZGhCtQ@piout.net>
References: <20220107183029.486207-1-mat.jonczyk@o2.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220107183029.486207-1-mat.jonczyk@o2.pl>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/01/2022 19:30:29+0100, Mateusz Jończyk wrote:
> The comments in cmos_read_alarm() and cmos_set_alarm() do not apply to
> current code, replace them.
> 
> These comments were added in
> commit fbb974ba693b ("rtc: cmos: Do not export alarm rtc_ops when we do not support alarms")
> which introduced a separate struct rtc_class_ops, which was used when
> the device did not support RTC alarms. The functions cmos_read_alarm()
> and cmos_set_alarm() were called not only from the rtc_op struct, but
> also explicitly, so they had to independently check for RTC alarm
> support.

Isn't cmos_read_alarm still called directly from cmos_check_wkalrm and
cmos_suspend ?

> 
> The separate rtc_class_ops structure was later removed in
>         commit 30f5bd537fdb ("rtc: cmos: remove cmos_rtc_ops_no_alarm")
> but the comments remained and now are obsolete.
> 
> Signed-off-by: Mateusz Jończyk <mat.jonczyk@o2.pl>
> Cc: Alessandro Zummo <a.zummo@towertech.it>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
> 
> This patch applies cleanly on rtc-next.
> 
>  drivers/rtc/rtc-cmos.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
> index 7c006c2b125f..cd82eff2630a 100644
> --- a/drivers/rtc/rtc-cmos.c
> +++ b/drivers/rtc/rtc-cmos.c
> @@ -290,7 +290,7 @@ static int cmos_read_alarm(struct device *dev, struct rtc_wkalrm *t)
>  		.time = &t->time,
>  	};
>  
> -	/* This not only a rtc_op, but also called directly */
> +	/* Fail if the RTC alarm is not supported */
>  	if (!is_valid_irq(cmos->irq))
>  		return -EIO;
>  
> @@ -523,7 +523,7 @@ static int cmos_set_alarm(struct device *dev, struct rtc_wkalrm *t)
>  	unsigned char rtc_control;
>  	int ret;
>  
> -	/* This not only a rtc_op, but also called directly */
> +	/* Fail if the RTC alarm is not supported */
>  	if (!is_valid_irq(cmos->irq))
>  		return -EIO;
>  
> -- 
> 2.25.1
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
