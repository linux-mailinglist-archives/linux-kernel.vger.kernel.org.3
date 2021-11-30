Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7640346422C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 00:19:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238388AbhK3XWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 18:22:49 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:34987 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231514AbhK3XWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 18:22:34 -0500
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id EE0B2200002;
        Tue, 30 Nov 2021 23:19:12 +0000 (UTC)
Date:   Wed, 1 Dec 2021 00:19:12 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>, kernel@axis.com,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: pcf8523: fix alarm interrupt disabling
Message-ID: <YaaxcFn/di3wCnO1@piout.net>
References: <20211103152253.22844-1-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211103152253.22844-1-vincent.whitchurch@axis.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 03/11/2021 16:22:52+0100, Vincent Whitchurch wrote:
> Fix the driver to actually disable the IRQ and not overwrite other bits
> in the CONTROL_1 register when it is asked to disable the alarm
> interrupt.
> 
> Compile-tested only.
> 
> Fixes: 13e37b7fb75dfaeb4 ("rtc: pcf8523: add alarm support")
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> ---
>  drivers/rtc/rtc-pcf8523.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/rtc/rtc-pcf8523.c b/drivers/rtc/rtc-pcf8523.c
> index 8b6fb20774bf..e26477267451 100644
> --- a/drivers/rtc/rtc-pcf8523.c
> +++ b/drivers/rtc/rtc-pcf8523.c
> @@ -347,7 +347,7 @@ static int pcf8523_irq_enable(struct device *dev, unsigned int enabled)
>  	if (err < 0)
>  		return err;
>  
> -	value &= PCF8523_CONTROL1_AIE;
> +	value &= ~PCF8523_CONTROL1_AIE;
>  

I was going to apply that but it seems this was fixed by:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?id=91f3849d956d58073ef55e01f2e8871dc30847a5

>  	if (enabled)
>  		value |= PCF8523_CONTROL1_AIE;
> -- 
> 2.28.0
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
