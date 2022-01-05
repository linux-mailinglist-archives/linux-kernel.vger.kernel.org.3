Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA554859B8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 21:01:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243794AbiAEUBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 15:01:18 -0500
Received: from relay11.mail.gandi.net ([217.70.178.231]:60761 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243779AbiAEUBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 15:01:14 -0500
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 5811D100004;
        Wed,  5 Jan 2022 20:01:11 +0000 (UTC)
Date:   Wed, 5 Jan 2022 21:01:10 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: isl1208: avoid unnecessary rc variable tests
Message-ID: <YdX5BocOfHE/0twa@piout.net>
References: <20220105193440.151359-1-hugo@hugovil.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220105193440.151359-1-hugo@hugovil.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/01/2022 14:34:39-0500, Hugo Villeneuve wrote:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> The rc variable doesn't need to be tested a second time when the <if> block
> evaluates to false.
> 

rc is not tested a second time, here is the relevant listing:

-	if (client->irq > 0)
+	if (client->irq > 0) {
 ffffffff81aef647:	41 8b b5 bc 01 00 00 	mov    0x1bc(%r13),%esi
 ffffffff81aef64e:	85 f6                	test   %esi,%esi
 ffffffff81aef650:	0f 8f 35 01 00 00    	jg     ffffffff81aef78b <isl1208_probe+0x314>
 		rc = isl1208_setup_irq(client, client->irq);
 	if (rc)
 		return rc;
+	}
 
-	if (evdet_irq > 0 && evdet_irq != client->irq)
+	if (evdet_irq > 0 && evdet_irq != client->irq) {
 ffffffff81aef656:	85 db                	test   %ebx,%ebx
 ffffffff81aef658:	7e 0d                	jle    ffffffff81aef667 <isl1208_probe+0x1f0>
 ffffffff81aef65a:	41 39 9d bc 01 00 00 	cmp    %ebx,0x1bc(%r13)
@@ -1663,6 +1664,7 @@ ffffffff81aef661:	0f 85 0a 01 00 00
 		rc = isl1208_setup_irq(client, evdet_irq);
 	if (rc)
 		return rc;
+	}

As you can see, no change in assembly but it is worse to read. gcc on
arm behaves the same way.

> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> ---
>  drivers/rtc/rtc-isl1208.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-isl1208.c b/drivers/rtc/rtc-isl1208.c
> index 182dfa605515..c7f04df5a0b6 100644
> --- a/drivers/rtc/rtc-isl1208.c
> +++ b/drivers/rtc/rtc-isl1208.c
> @@ -880,15 +880,17 @@ isl1208_probe(struct i2c_client *client, const struct i2c_device_id *id)
>  	if (rc)
>  		return rc;
>  
> -	if (client->irq > 0)
> +	if (client->irq > 0) {
>  		rc = isl1208_setup_irq(client, client->irq);
> -	if (rc)
> -		return rc;
> +		if (rc)
> +			return rc;
> +	}
>  
> -	if (evdet_irq > 0 && evdet_irq != client->irq)
> +	if (evdet_irq > 0 && evdet_irq != client->irq) {
>  		rc = isl1208_setup_irq(client, evdet_irq);
> -	if (rc)
> -		return rc;
> +		if (rc)
> +			return rc;
> +	}
>  
>  	rc = devm_rtc_nvmem_register(isl1208->rtc, &isl1208->nvmem_config);
>  	if (rc)
> -- 
> 2.30.2
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
