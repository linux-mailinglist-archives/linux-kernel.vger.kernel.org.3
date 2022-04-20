Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 942275084AD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 11:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377113AbiDTJSm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 05:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232939AbiDTJSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 05:18:41 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AF623BFA3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 02:15:55 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1nh6RF-00051t-Nb; Wed, 20 Apr 2022 11:15:53 +0200
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1nh6RF-0006Q5-0o; Wed, 20 Apr 2022 11:15:53 +0200
Date:   Wed, 20 Apr 2022 11:15:52 +0200
To:     Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        lars@metafoo.de, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, robh+dt@kernel.org, nicolas.ferre@microchip.com
Subject: Re: [PATCH v3 1/6] ASoC: dmaengine: do not use a NULL
 prepare_slave_config() callback
Message-ID: <20220420091552.GD2387@pengutronix.de>
References: <20220307122202.2251639-1-codrin.ciubotariu@microchip.com>
 <20220307122202.2251639-2-codrin.ciubotariu@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220307122202.2251639-2-codrin.ciubotariu@microchip.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 11:00:02 up 20 days, 21:29, 67 users,  load average: 0.11, 0.08,
 0.08
User-Agent: Mutt/1.10.1 (2018-07-13)
From:   Sascha Hauer <sha@pengutronix.de>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Mar 07, 2022 at 02:21:57PM +0200, Codrin Ciubotariu wrote:
> Even if struct snd_dmaengine_pcm_config is used, prepare_slave_config()
> callback might not be set. Check if this callback is set before using it.
> 
> Fixes: fa654e085300 ("ASoC: dmaengine-pcm: Provide default config")
> Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
> ---
> 
> Changes in v2,v3:
>  - none
> 
>  sound/soc/soc-generic-dmaengine-pcm.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/soc/soc-generic-dmaengine-pcm.c b/sound/soc/soc-generic-dmaengine-pcm.c
> index 285441d6aeed..2ab2ddc1294d 100644
> --- a/sound/soc/soc-generic-dmaengine-pcm.c
> +++ b/sound/soc/soc-generic-dmaengine-pcm.c
> @@ -86,10 +86,10 @@ static int dmaengine_pcm_hw_params(struct snd_soc_component *component,
>  
>  	memset(&slave_config, 0, sizeof(slave_config));
>  
> -	if (!pcm->config)
> -		prepare_slave_config = snd_dmaengine_pcm_prepare_slave_config;
> -	else
> +	if (pcm->config && pcm->config->prepare_slave_config)
>  		prepare_slave_config = pcm->config->prepare_slave_config;
> +	else
> +		prepare_slave_config = snd_dmaengine_pcm_prepare_slave_config;
>  
>  	if (prepare_slave_config) {
>  		int ret = prepare_slave_config(substream, params, &slave_config);

I wonder if this patch is correct. There are drivers like
sound/soc/mxs/mxs-pcm.c which call snd_dmaengine_pcm_register() with a
config which has the prepare_slave_config callback unset. For these
drivers dmaengine_pcm_hw_params() previously was a no-op. Now with this
patch snd_dmaengine_pcm_prepare_slave_config() and
dmaengine_slave_config() are called. At least for the mxs-pcm driver
calling dmaengine_slave_config() will return -ENOSYS.

At least the "Check if this callback is set before using it" part is
wrong, the callback is checked before using it with

	if (prepare_slave_config) {
		...
	}

I don't have any mxs hardware at hand to test this. I just stumbled upon
the change of behaviour when rebasing
https://patchwork.kernel.org/project/alsa-devel/patch/20220301122111.1073174-1-s.hauer@pengutronix.de/
on current master.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
