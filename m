Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85ED14B8D57
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 17:09:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236010AbiBPQJx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 16 Feb 2022 11:09:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235210AbiBPQJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 11:09:52 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09429BBE03
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 08:09:38 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1nKMs3-0007Kl-OM; Wed, 16 Feb 2022 17:09:35 +0100
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1nKMs2-00GzCC-S5; Wed, 16 Feb 2022 17:09:34 +0100
Received: from pza by lupine with local (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1nKMs0-001lH9-A3; Wed, 16 Feb 2022 17:09:32 +0100
Message-ID: <89a08ce1cdb1cf0b4d46b916e7107eca0796ca9d.camel@pengutronix.de>
Subject: Re: [PATCH] gpu: ipu-v3: Fix dev_dbg frequency output
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Mark Jonas <mark.jonas@de.bosch.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        tingquan.ruan@cn.bosch.com
Date:   Wed, 16 Feb 2022 17:09:32 +0100
In-Reply-To: <20220207151411.5009-1-mark.jonas@de.bosch.com>
References: <20220207151411.5009-1-mark.jonas@de.bosch.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Mon, 2022-02-07 at 16:14 +0100, Mark Jonas wrote:
> From: Leo Ruan <tingquan.ruan@cn.bosch.com>
> 
> This commit corrects the printing of the IPU clock error percentage if
> it is between -0.1% to -0.9%. For example, if the pixel clock requested
> is 27.2 MHz but only 27.0 MHz can be achieved the deviation is -0.8%.
> But the fixed point math had a flaw and calculated error of 0.2%.
> 
> Before:
>   Clocks: IPU 270000000Hz DI 24716667Hz Needed 27200000Hz
>   IPU clock can give 27000000 with divider 10, error 0.2%
>   Want 27200000Hz IPU 270000000Hz DI 24716667Hz using IPU, 27000000Hz
> 
> After:
>   Clocks: IPU 270000000Hz DI 24716667Hz Needed 27200000Hz
>   IPU clock can give 27000000 with divider 10, error -0.8%
>   Want 27200000Hz IPU 270000000Hz DI 24716667Hz using IPU, 27000000Hz
> 
> Signed-off-by: Leo Ruan <tingquan.ruan@cn.bosch.com>
> Signed-off-by: Mark Jonas <mark.jonas@de.bosch.com>
> ---
>  drivers/gpu/ipu-v3/ipu-di.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/ipu-v3/ipu-di.c b/drivers/gpu/ipu-v3/ipu-di.c
> index b4a31d506fcc..74eca68891ad 100644
> --- a/drivers/gpu/ipu-v3/ipu-di.c
> +++ b/drivers/gpu/ipu-v3/ipu-di.c
> @@ -451,8 +451,9 @@ static void ipu_di_config_clock(struct ipu_di *di,
>  
>                 error = rate / (sig->mode.pixelclock / 1000);
>  
> -               dev_dbg(di->ipu->dev, "  IPU clock can give %lu with divider %u, error %d.%u%%\n",
> -                       rate, div, (signed)(error - 1000) / 10, error % 10);
> +               dev_dbg(di->ipu->dev, "  IPU clock can give %lu with divider %u, error %c%d.%d%%\n",
> +                       rate, div, error < 1000 ? '-' : '+',
> +                       abs(error - 1000) / 10, abs(error - 1000) % 10);
>  
>                 /* Allow a 1% error */
>                 if (error < 1010 && error >= 990) {

Rounding (always down) is still a bit unintuitive, but this certainly
improves things.

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp
