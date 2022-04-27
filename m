Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0CC751137C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 10:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359403AbiD0IdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 04:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbiD0IdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 04:33:17 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A771CFE6
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 01:30:06 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id s21so1401792wrb.8
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 01:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=uuaqiUZLOsChqlXyKbpm6wvW7kQefLGVgCUO7BzQrzA=;
        b=e5BYU67ug0RadbCRKN+ByG3Mx0c2NoLtQ27jnqQ3gxBbZh913frGGgHnKGk7v5oH6K
         pGkmO+e9+W7xi6wl4R+z2t8uKEHXLkD+dNj9d7NmPdYbb/tFCPN6fbpMnqEtyQ3He1Sy
         2gLFvQgpW+Em0GIytTYd8cEfDYpX/3YClCO4XJW1AE4xatip0UMmrxYSYhxrWEP+nxe4
         YeUGf5dKDMN+FONVR0dWDI5xkfUPSjwgkvZiAxl3JSeuJ4/WGA4Vtzr6G4ahFWEZt+JG
         jShnercZP0dGNOSe1sZw+EPlKbLB8a1wfbRSWNquhhO4fe6i1wv0NEV8Fsg8U8V9TYGR
         i/fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=uuaqiUZLOsChqlXyKbpm6wvW7kQefLGVgCUO7BzQrzA=;
        b=1DD7D0uwXYXyvURLbr05oRIht2yGRFtTeY22kTfW8Y2LHEDts+2gcIY5cHlbE6uxvb
         Vkob6oJPnuDgDQDGBNPC+yiFbGIWsug5UhTqqzjtEiriTa2MtHnUQVh0Txa5aU/hmgmi
         WgP4ozpXoJHkA0tyc4W5mywU2E1ucWcH2EPPZi5VpF9kzfozQkpWSAC+s4rvXFJyj9YE
         +VWAKOstpClw3PJhkQmSSaNJGeedjiW4QYlXk6EHvXSJbDnFpPqISm/+cN4UwF64GYX9
         k9rjRrnmv5XhmZsZJ8PuE+58n7kjR0H+xZPQ22z35/Uj+sWr1zwkDTz0BMUoNcNBQJnE
         fx8g==
X-Gm-Message-State: AOAM5316aBUHPYYm2gnHBZnlQuf6Xb14t1XQStTx2fx8L29/k2oPxjZ3
        SHoHEy1/XFgXWp96gubsgR6kqw==
X-Google-Smtp-Source: ABdhPJwAOFzgKXb5o0/gt/GLKEE9cIElWAjB3owyDIaR+6bxgF6h8F0cDofxMRbqsSW6prkSSXgJww==
X-Received: by 2002:a5d:48d0:0:b0:207:a861:dcc9 with SMTP id p16-20020a5d48d0000000b00207a861dcc9mr21855607wrs.490.1651048205092;
        Wed, 27 Apr 2022 01:30:05 -0700 (PDT)
Received: from localhost (laubervilliers-656-1-151-143.w92-154.abo.wanadoo.fr. [92.154.18.143])
        by smtp.gmail.com with ESMTPSA id m6-20020a1c2606000000b00393fbf75a56sm1044666wmm.29.2022.04.27.01.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 01:30:04 -0700 (PDT)
From:   Mattijs Korpershoek <mkorpershoek@baylibre.com>
To:     Fabien Parent <fparent@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Fabien Parent <fparent@baylibre.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: mediatek: mt8183-pumpkin: fix bad
 thermistor node name
In-Reply-To: <20220426164755.435372-1-fparent@baylibre.com>
References: <20220426164755.435372-1-fparent@baylibre.com>
Date:   Wed, 27 Apr 2022 10:30:02 +0200
Message-ID: <87a6c753p1.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 18:47, Fabien Parent <fparent@baylibre.com> wrote:

> Fix the following dtbs_check error by using the correct node name:
> /home/fabo/build/linux/mt8183-pumpkin/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dtb: ntc: $nodename:0: 'ntc' does not match '^thermistor(.*)?$'
> 	From schema: /home/fabo/devel/baylibre/linux-mainline/Documentation/devicetree/bindings/hwmon/ntc-thermistor.yaml
>
> Signed-off-by: Fabien Parent <fparent@baylibre.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>  arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts b/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts
> index 10b2c0500219..3d6da7efe31b 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts
> @@ -55,7 +55,7 @@ led-green {
>  		};
>  	};
>  
> -	ntc {
> +	thermistor {
>  		compatible = "murata,ncp03wf104";
>  		pullup-uv = <1800000>;
>  		pullup-ohm = <390000>;
> -- 
> 2.36.0
>
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
