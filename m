Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDBF650DBFF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 11:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241355AbiDYJKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 05:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242103AbiDYJJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 05:09:14 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D563F895
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 02:03:46 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id u17-20020a05600c211100b0038eaf4cdaaeso12046636wml.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 02:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=jug/8OpXFDkTxUKywL6vHGEFgX9c5JLBUJ6VTO9tAvU=;
        b=AuaNnnovMVQoPw+JEXQgdTDv0aWz3z1naSE9MADi02hw0meYMhy+V8+mHd5cGTQly/
         rAayEXMfUvwIF3wINEmqP9tGRiYcqn1/fU9J4rygwBSSiZIx64hOTgKpOSy6Vhyig9nq
         XxQ44vLxd+IIJxQm04fo15/fNII9Xt7uH2YHfiCnA2H7ekxrSSkLljW+7lrSko3Nhq1L
         efOjG4ZCF+J5wK/aCS/VYByF/BNC3QJfSrVZL8Z/EpDl5ZSSHg5Bs4Vz8eV/QAAiRxdD
         qZqEGdjn2G6hK1i374Xu8ZBI3EOjlZPa5KgQQPb1Izn9mO88BWBYPpvI8JyvUogKDQSC
         KOEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=jug/8OpXFDkTxUKywL6vHGEFgX9c5JLBUJ6VTO9tAvU=;
        b=rvClcbXbcX3TpgNO90l6PIq9l4zblQP9UMMCRQi4lJHoE84QtyAXKDoZvZM4pFYhSu
         P6agjVGPZXhJrkcp8Iin6k1jVR8ojijyoxTBmzskAqJvfiXVneSU6CPyq7BvE0dXfRE7
         eZSGTOFoNxdGE6Li6jQFlsUpIWMCXpVwgCxzBnHhompwOpFT8uc4SbecEXkGOfEq82VE
         K26veR+YgXD2hwhElFfzf4zXdz8vTg1OYy3oGj5DW2f3JV/2u84gKelJq14X47PAJ81z
         WJJRoOkexnXS3LL4IaKiSLsjxXyIgUbrhLg9+k4zudw12tSMMi9btmVD+VpAeaqkUazc
         b3cA==
X-Gm-Message-State: AOAM533wAwlSeoFwQS2wgLx2NL/1FLNhidr94qdxryhrgrWaRf8SQjkF
        wvBEhrP3xln8rn39qpxKEUHa8Q==
X-Google-Smtp-Source: ABdhPJzcnhc5LcepFB4EyQ4oJ1jx/PdiGxt7o18Br4Wx6z05JWcQAnDIdJIVic89TBi9DG3Mg7J25A==
X-Received: by 2002:a05:600c:1e89:b0:390:ba57:81c6 with SMTP id be9-20020a05600c1e8900b00390ba5781c6mr16057691wmb.29.1650877424536;
        Mon, 25 Apr 2022 02:03:44 -0700 (PDT)
Received: from localhost ([2a01:cb19:85e6:1900:b365:80a1:ee3:312f])
        by smtp.gmail.com with ESMTPSA id f66-20020a1c3845000000b00393e84ea043sm3821672wma.44.2022.04.25.02.03.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 02:03:44 -0700 (PDT)
From:   Mattijs Korpershoek <mkorpershoek@baylibre.com>
To:     Dang Huynh <danct12@riseup.net>, Dang Huynh <danct12@riseup.net>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: mediatek: pumpkin: Remove input-name property
In-Reply-To: <20220425064850.246228-1-danct12@riseup.net>
References: <20220425064850.246228-1-danct12@riseup.net>
Date:   Mon, 25 Apr 2022 11:03:43 +0200
Message-ID: <87tuah7cwg.fsf@baylibre.com>
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

On lun., avril 25, 2022 at 13:48, Dang Huynh <danct12@riseup.net> wrote:

> This property doesn't seem to exist in the documentation nor
> in source code, but for some reason it is defined in a bunch
> of device trees.
>
> Signed-off-by: Dang Huynh <danct12@riseup.net>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
> This patch is a split of this treewide patch [1] to ease the 
> maintainers. 
>
> [1]: https://patchwork.kernel.org/patch/12633497/
>
>  arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi b/arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi
> index fcddec14738d..7a717f926929 100644
> --- a/arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi
> @@ -25,7 +25,6 @@ optee: optee@4fd00000 {
>  
>  	gpio-keys {
>  		compatible = "gpio-keys";
> -		input-name = "gpio-keys";
>  		pinctrl-names = "default";
>  		pinctrl-0 = <&gpio_keys_default>;
>  
> -- 
> 2.36.0
>
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
