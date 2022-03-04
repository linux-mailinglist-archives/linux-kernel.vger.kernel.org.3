Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC2684CCEE4
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 08:11:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238831AbiCDHMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 02:12:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238876AbiCDHK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 02:10:26 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7F091965E3
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 23:08:01 -0800 (PST)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 1D9AA3F1AF
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 07:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646377680;
        bh=N/1/s+Ed03pMGV4VO6sMw3Ii5bh7oLhfTOUQvpVABiY=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=opvlomMk7f7GQi9XeWxL3xOd46NV7CEIAZF2KctzJMtQZRwF4kECYnANx+BCoXG+r
         CuRDWp1bsVMcld7IA3tlT9dsSKM5rAeAV6aspqdcqjSy1blA198lzpDPnXSOXfh4nn
         mudtrHItRzIDTY/mjA1C23f+eGn+FeKiLkg3ixoN323U3ya+HjLDhcXsEa5y1WdBRB
         UMcg6vYWxFBYbt56QY6QU33Z/mpK/t6+5mvER4Wo21n63nf6l8oPgafAJ3iFEv8wrw
         DI/FraIQ3dTihqOIjYeWNzNJc3y55ZETrc8+z6+1K3KkSH6T/uG//nroHSTCjlQdin
         ie36fjS+O/okQ==
Received: by mail-ed1-f70.google.com with SMTP id y26-20020a50ce1a000000b00415e9b35c81so1900740edi.9
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 23:08:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=N/1/s+Ed03pMGV4VO6sMw3Ii5bh7oLhfTOUQvpVABiY=;
        b=jkfd/MFr1Ve0QwUHFvztttf7D8Gug5ex2GIBvJiObOC2G21jXtX7rKMmCMDXpN6RFc
         cIyXCmDZc+feUwbWubv+rAQjdAuD9v6P0D9gbcWAXujBkGlBcZ/uicjuQYYXvQhQhvnS
         diS0Atr4WbsKd5GCHjTAdMN7s4OUj2pd+D62Lq3mEIHi2lZUegYqj9zHeJP74YddFPmp
         J54MhX/d6hMFcpKHIEkpqTB0S5PiZVgCI4JZvwCD9zKD0FL22dXk1cdmLFEYuiwDUc6v
         cbaqb8Ea8gcRFKKrGErGTPNnUGJNEQWB9+8EvEJkm0QLZx/L0XIeR2mHKctY/tOHZD8x
         vAig==
X-Gm-Message-State: AOAM531KGmZJYxOlVnBZq61VDcBIySK9dLypVQBy9Q3ts68bItNppcMx
        UF5bxIavEo8p5pPnbVPmG/qXTP/O2lT+hv63fJXU9YptEsPkSgooqa3nudEoWuRWCo7C5sRpdwv
        gZTDXWfyRG3xbkgs+hkt2lbBdxRXeXQ9AUE64ax0Ddw==
X-Received: by 2002:a17:906:e08c:b0:6bb:6f89:7d59 with SMTP id gh12-20020a170906e08c00b006bb6f897d59mr29274084ejb.85.1646377679793;
        Thu, 03 Mar 2022 23:07:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyy8e4pIZMZnPd5rczSQZGV6twzM+/yp98TImvs5xVvRwjTi5ipd7MooK4COLXs3PKn+olIPg==
X-Received: by 2002:a17:906:e08c:b0:6bb:6f89:7d59 with SMTP id gh12-20020a170906e08c00b006bb6f897d59mr29274073ejb.85.1646377679604;
        Thu, 03 Mar 2022 23:07:59 -0800 (PST)
Received: from [192.168.0.138] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id kq26-20020a170906abda00b006da87077172sm1469596ejb.29.2022.03.03.23.07.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Mar 2022 23:07:58 -0800 (PST)
Message-ID: <887c5cf8-8dda-3311-0aa7-27fbceb6a6f9@canonical.com>
Date:   Fri, 4 Mar 2022 08:07:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] clk/samsung: Use of_device_get_match_data()
Content-Language: en-US
To:     cgel.zte@gmail.com
Cc:     alim.akhtar@samsung.com, chi.minghao@zte.com.cn,
        cw00.choi@samsung.com, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, mturquette@baylibre.com,
        s.nawrocki@samsung.com, sboyd@kernel.org, tomasz.figa@gmail.com,
        zealci@zte.com.cn
References: <77a147f9-794c-83ca-070b-fb17d665ed8f@canonical.com>
 <20220304011155.2061393-1-chi.minghao@zte.com.cn>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220304011155.2061393-1-chi.minghao@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/03/2022 02:11, cgel.zte@gmail.com wrote:
> From: Minghao Chi (CGEL ZTE) <chi.minghao@zte.com.cn>
> 
> Use of_device_get_match_data() to simplify the code.
> 
> Signed-off-by: Minghao Chi (CGEL ZTE) <chi.minghao@zte.com.cn>
> ---
>  drivers/clk/samsung/clk-exynos-clkout.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/drivers/clk/samsung/clk-exynos-clkout.c b/drivers/clk/samsung/clk-exynos-clkout.c
> index e6d6cbf8c4e6..feed1a347c09 100644
> --- a/drivers/clk/samsung/clk-exynos-clkout.c
> +++ b/drivers/clk/samsung/clk-exynos-clkout.c
> @@ -81,19 +81,13 @@ MODULE_DEVICE_TABLE(of, exynos_clkout_ids);
>  static int exynos_clkout_match_parent_dev(struct device *dev, u32 *mux_mask)
>  {
>  	const struct exynos_clkout_variant *variant;
> -	const struct of_device_id *match;
>  
>  	if (!dev->parent) {
>  		dev_err(dev, "not instantiated from MFD\n");
>  		return -EINVAL;
>  	}
>  
> -	match = of_match_device(exynos_clkout_ids, dev->parent);
> -	if (!match) {
> -		dev_err(dev, "cannot match parent device\n");
> -		return -EINVAL;
> -	}
> -	variant = match->data;
> +	variant = of_device_get_match_data(dev->parent);
>  

What about possible NULL pointer exception? Device is being instantiated
by MFD, so the match here could be false if MFD driver is updated but
this one here not. With your change returned NULL will be dereferenced
line below.

>  	*mux_mask = variant->mux_mask;
>  


Best regards,
Krzysztof
