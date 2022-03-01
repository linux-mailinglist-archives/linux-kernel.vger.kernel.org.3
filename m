Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 869CA4C8A7C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 12:18:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233089AbiCALTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 06:19:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbiCALTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 06:19:19 -0500
Received: from relay12.mail.gandi.net (relay12.mail.gandi.net [IPv6:2001:4b98:dc4:8::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46CDD1DA4B
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 03:18:35 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id F1F13200003;
        Tue,  1 Mar 2022 11:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1646133513;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1onpxNnFoCXsqo506jvf7SOJaOlkoC3XKwD8NMc9uTQ=;
        b=mrgSYljU26q9SyublNacGu2CJRJlEXAsqilOiDlbsTI3WISP1QS1VUesZ0AixgqWisvyoK
        aEq9vGYD0V0rkIWWOwTzg2MNvz+UHfg3XCG9oTaZMcuwXfUpY6xY0T7KXBwymDFGPAwD9S
        gGhs7Qf7QUy07EEwIgNu1ZzQkpEFpIjhSQNIIvO3mMLqFjQ18lcYmBUa6bBioQUtmu3Z7M
        U+b+NUQZ1JjgGF7ZrDwih1ojKwcV8ATShVp0xBr4/d6jCl4VPV/gNbmEHcuBEw/1Gn8Ivd
        C+5ippITlTrmBVKtF3sFQhz7mpHJv86z5L6Zv4n0kkH07IEPcUAeZqR93iEAcQ==
Date:   Tue, 1 Mar 2022 12:18:32 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     codrin.ciubotariu@microchip.com, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        nicolas.ferre@microchip.com, claudiu.beznea@microchip.com,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: atmel_ssc_dai: Handle errors for clk_enable
Message-ID: <Yh4BCPqPngcsvER1@piout.net>
References: <20220301090637.3776558-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220301090637.3776558-1-jiasheng@iscas.ac.cn>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/03/2022 17:06:37+0800, Jiasheng Jiang wrote:
> As the potential failure of the clk_enable(),
> it should be better to check it and return error if fals.
> 

As I already replied to an earlier patch, this will never, ever fail,
this patch doesn't fix anything.

> Fixes: cbaadf0f90d6 ("ASoC: atmel_ssc_dai: refactor the startup and shutdown")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
>  sound/soc/atmel/atmel_ssc_dai.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/atmel/atmel_ssc_dai.c b/sound/soc/atmel/atmel_ssc_dai.c
> index 26e2bc690d86..c1dea8d62416 100644
> --- a/sound/soc/atmel/atmel_ssc_dai.c
> +++ b/sound/soc/atmel/atmel_ssc_dai.c
> @@ -280,7 +280,10 @@ static int atmel_ssc_startup(struct snd_pcm_substream *substream,
>  
>  	/* Enable PMC peripheral clock for this SSC */
>  	pr_debug("atmel_ssc_dai: Starting clock\n");
> -	clk_enable(ssc_p->ssc->clk);
> +	ret = clk_enable(ssc_p->ssc->clk);
> +	if (ret)
> +		return ret;
> +
>  	ssc_p->mck_rate = clk_get_rate(ssc_p->ssc->clk);
>  
>  	/* Reset the SSC unless initialized to keep it in a clean state */
> -- 
> 2.25.1
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
