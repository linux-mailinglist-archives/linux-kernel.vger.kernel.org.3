Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C44250D4EE
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 21:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239490AbiDXT62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 15:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239396AbiDXT6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 15:58:21 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04B8F83B1C;
        Sun, 24 Apr 2022 12:55:20 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id g6so3098604ejw.1;
        Sun, 24 Apr 2022 12:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jnZc7DP16ZcOaHpZ/GNMFf37KvUcvRnbmi+EyiBH2ZE=;
        b=AcnpSf+5qxUgF0srl66FGmfTo7OdTmIAm/XziK6pVlV5y+Ze8LSEtuXW01aQzj32eD
         UhvkN+CUxB0D3gTzfZU5NC0QWTw1BPK7YYpaU6MzOU/HsH+8Q08WP7KHA5mIa7oZBEwE
         wAXKdW9/pDIDzu/uB8msTCKmtU8eteJ1GqlEBa1lSC1CYvQgFj3AiA+B5ttspv5NeG5+
         aIbecn5OirPqnhzLhgyFahyxe4soSmeTe+KIlqfaE0aAlRk9Mm9V3Ay9AtE5BhubNBLb
         +zPQgLpKF2iXZPpAq80rAdwJyn5049gSdgXFXx41HPG3B+FeEvCHhfCuQfP9Mtfj1qZF
         HJqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jnZc7DP16ZcOaHpZ/GNMFf37KvUcvRnbmi+EyiBH2ZE=;
        b=y3RCXVhxzPO4CKTkaPewi7158XoGDSZxF1yEVYonF6wmtkozHt6hEj4yUgxOui7YQx
         qxAOdybxy5+AsHqSK00s+g5BkHynx3fGBF1SjOJ4nddGqk3EYlAHJyD4GudbrAfFO2EX
         mfFyepIUFqe3ZkGFxNFAmkfJXBqrA3oCnDer21avg3EtyEdsc3rsYll3tr31+S27u+YT
         0W+Rr9jIWM91WBoJVtHo9fAj4gy1cahRJz1SaSLIECj1f0MzyGA2qIH8rioUC7Eg76ge
         UQPAL3IUBTxqLsqZtb/boLJeN16c4yhNAcABFAl9+hGC+skJT9zGM9Z59MoRtANcG92k
         aVdQ==
X-Gm-Message-State: AOAM532LermcVVqMWz7O+h+snpoi4fnxVkZ6oBh5ur0JFiS/2iHUsjQR
        /aX0UgtK3pX6DPZQlyN84Zc=
X-Google-Smtp-Source: ABdhPJzN3eVFBus3yS50upLR1PqeRSF6bppisLjUxreAllvxq33VJBsVI+bSpN1WSBIgUo8tDD0BvQ==
X-Received: by 2002:a17:906:5006:b0:6ce:3762:c72e with SMTP id s6-20020a170906500600b006ce3762c72emr13049979ejj.30.1650830118484;
        Sun, 24 Apr 2022 12:55:18 -0700 (PDT)
Received: from kista.localnet (cpe-86-58-32-107.static.triera.net. [86.58.32.107])
        by smtp.gmail.com with ESMTPSA id ak18-20020a170906889200b006f39a445b93sm148849ejc.141.2022.04.24.12.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 12:55:18 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>,
        Icenowy Zheng <uwu@icenowy.me>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Icenowy Zheng <uwu@icenowy.me>
Subject: Re: [PATCH] clk: sunxi-ng: ccu-sun6i-rtc: set rtc-32k to critical
Date:   Sun, 24 Apr 2022 21:55:17 +0200
Message-ID: <5560593.DvuYhMxLoT@kista>
In-Reply-To: <20220424055959.109286-1-uwu@icenowy.me>
References: <20220424055959.109286-1-uwu@icenowy.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne nedelja, 24. april 2022 ob 07:59:59 CEST je Icenowy Zheng napisal(a):
> RTC itself is the one and only consumer of rtc-32k clock. As the rtc
> should be always running, set rtc-32k clock to critical, to prevent it
> from being gated by the kernel.
> 
> Fixes: d91612d7f01a ("clk: sunxi-ng: Add support for the sun6i RTC clocks")
> Signed-off-by: Icenowy Zheng <uwu@icenowy.me>

This one was already submitted here:
https://lore.kernel.org/linux-sunxi/20220411050100.40964-1-samuel@sholland.org/

Best regards,
Jernej

> ---
>  drivers/clk/sunxi-ng/ccu-sun6i-rtc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/clk/sunxi-ng/ccu-sun6i-rtc.c b/drivers/clk/sunxi-ng/ccu-
sun6i-rtc.c
> index 8a10bade7e0d..3d9c9ce5a3db 100644
> --- a/drivers/clk/sunxi-ng/ccu-sun6i-rtc.c
> +++ b/drivers/clk/sunxi-ng/ccu-sun6i-rtc.c
> @@ -241,6 +241,7 @@ static struct clk_init_data rtc_32k_init_data = {
>  	.ops		= &ccu_mux_ops,
>  	.parent_hws	= rtc_32k_parents,
>  	.num_parents	= ARRAY_SIZE(rtc_32k_parents), /* updated 
during probe */
> +	.flags		= CLK_IS_CRITICAL,
>  };
>  
>  static struct ccu_mux rtc_32k_clk = {
> -- 
> 2.35.1
> 
> 
> 


