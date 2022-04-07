Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A47F24F7C1C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 11:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243998AbiDGJtM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 7 Apr 2022 05:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237429AbiDGJtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 05:49:09 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC59110FDDE
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 02:47:08 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1ncOix-0007d3-0T; Thu, 07 Apr 2022 11:46:43 +0200
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1ncOix-001aNC-5z; Thu, 07 Apr 2022 11:46:41 +0200
Received: from pza by lupine with local (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1ncOiv-0004Dh-5U; Thu, 07 Apr 2022 11:46:41 +0200
Message-ID: <b9cc064d124bc767c6ea3f3fa39eeb82d291ca0e.camel@pengutronix.de>
Subject: Re: [PATCH v2 07/10] power: reset: at91-reset: add
 reset_controller_dev support
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>, robh+dt@kernel.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        linux@armlinux.org.uk, sre@kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org
Date:   Thu, 07 Apr 2022 11:46:41 +0200
In-Reply-To: <20220407071708.3848812-8-claudiu.beznea@microchip.com>
References: <20220407071708.3848812-1-claudiu.beznea@microchip.com>
         <20220407071708.3848812-8-claudiu.beznea@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Do, 2022-04-07 at 10:17 +0300, Claudiu Beznea wrote:
> SAMA7G5 reset controller has 5 extra lines that goes to different devices
> (3 lines to USB PHYs, 1 line to DDR controller, 1 line to DDR PHY
> controller). These reset lines could be requested by different controller
> drivers (e.g. USB PHY driver) and these controllers' drivers could
> assert/deassert these lines when necessary. Thus add support for
> reset_controller_dev which brings this functionality.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  drivers/power/reset/at91-reset.c | 107 +++++++++++++++++++++++++++++--
>  1 file changed, 103 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/power/reset/at91-reset.c b/drivers/power/reset/at91-reset.c
> index 1b2aca3f490d..a6f65ac430cd 100644
> --- a/drivers/power/reset/at91-reset.c
> +++ b/drivers/power/reset/at91-reset.c
[...]
> +static int at91_reset_update(struct reset_controller_dev *rcdev,
> +			     unsigned long id, bool assert)
> +{
> +	struct at91_reset *reset = to_at91_reset(rcdev);
> +	u32 val;
> +
> +	spin_lock(&reset->lock);

Use spin_lock_irqsave. We don't know where we are called from and this
isn't a time critical path.

> +	val = readl_relaxed(reset->dev_base);
> +	if (assert)
> +		val |= BIT(id);
> +	else
> +		val &= ~BIT(id);
> +	writel_relaxed(val, reset->dev_base);
> +	spin_unlock(&reset->lock);
> +
> +	return 0;
> +}
> +
> +static int at91_reset_assert(struct reset_controller_dev *rcdev,
> +			     unsigned long id)
> +{
> +	return at91_reset_update(rcdev, id, true);
> +}
> +
> +static int at91_reset_deassert(struct reset_controller_dev *rcdev,
> +			       unsigned long id)
> +{
> +	return at91_reset_update(rcdev, id, false);
> +}
> +
> +static int at91_reset_dev_status(struct reset_controller_dev *rcdev,
> +				 unsigned long id)
> +{
> +	struct at91_reset *reset = to_at91_reset(rcdev);
> +	u32 val;
> +
> +	spin_lock(&reset->lock);

Locking is not necessary here. If the read is racing against an update,
it either returns the register value before or after the update, same
as without a lock.

With those changes,
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp
