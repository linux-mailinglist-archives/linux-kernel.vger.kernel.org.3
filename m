Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E449E510A0F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 22:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241221AbiDZURT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 16:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235912AbiDZURP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 16:17:15 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC7451869C8
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 13:14:03 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id r8so21962891oib.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 13:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LOF/swU7ri17HNXlnT7ndFuNSzBTT2l6UmX2G8t0fao=;
        b=EpcCQfcX8t4tCHTkCeCt7XTlaO4cJlPlfOe5Yq7QXrx+iwdOvURAOX3BenP9I9NxTg
         dxO/zHL+D8q3dmjsHi87Pdtco459mLR9p9OL/vn5z9V87y+JLthD7h+5QS7o/Ev9QVb6
         Ent0ow9LRg9IIvmt7SzKVKoGIGHxpuYarl32h1juJi82dBm9lDtLlurW2ZR6Ba6RD9Ue
         LIfoQyWAteLcdB3NIj/h/kUle8V3gcyyKJaw7xydnZ2151CuDvqL8JiNl7pYO2eFhPbk
         bchpvdCVkot+QjLIVBwUzcjYYoR9aQn16BHusvPq4TDN+eCmTdoZRFyeXXuWeCl9J6DY
         NBIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=LOF/swU7ri17HNXlnT7ndFuNSzBTT2l6UmX2G8t0fao=;
        b=v2I+LIE14u3ZzgSqD8YPO6yNgdOAbG20PfmLcprpKbrq2dG4VZw1MH/OI34LNy347B
         pf1/9PjaC2LDApwDEZH7wo/qBAWdl4XEj4PwTd5yfLZJCd3CVN7KMwvij0N0NbA8VT7C
         Kkg2IG1LTxCnyKXB8TZ2PZujir8recwh/piouX3R1tRy2bdAqGS7thhZejTmDZ0gL38W
         ae9Mtma3cD3KIZIsPaSsGNFonlqHSYhuVlvS9pRcdvXfuVkApPrYG6yBPYyGAgq+lSKk
         s0QHi7aTT9eE1fgq/9hBA7cg3vTLlMw2o/qlilcUxnRf87lwLNJWfDRATIjowXX7dzXT
         NVcA==
X-Gm-Message-State: AOAM532x7g+HDYL+keWXK+g8iN8VSKUxvi8ev0vRF6EoypkJpC2iQRxH
        KWX5IJy4ljTHWG63Cjg15NU=
X-Google-Smtp-Source: ABdhPJz7ZBRrPySGNSDh4uQ3vrQ+SI3TKBgjip8c1iucs6eTt4im6RhPCVdr+b7FmdPmTtUdABULTg==
X-Received: by 2002:a05:6808:118f:b0:2d9:a01a:48be with SMTP id j15-20020a056808118f00b002d9a01a48bemr15280519oil.265.1651004042074;
        Tue, 26 Apr 2022 13:14:02 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l96-20020a9d1b69000000b00605db61f2f4sm62293otl.49.2022.04.26.13.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 13:14:01 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 26 Apr 2022 13:13:59 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Brian Norris <briannorris@chromium.org>
Cc:     Heiko Stuebner <heiko@sntech.de>, Arnd Bergmann <arnd@arndb.de>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] soc: rockchip: Clean up Kconfig whitespace
Message-ID: <20220426201359.GH4093517@roeck-us.net>
References: <20220426014545.628100-1-briannorris@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220426014545.628100-1-briannorris@chromium.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 06:45:42PM -0700, Brian Norris wrote:
> There are spaces instead of tabs, and other inconsistent indentation.
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> 
> (no changes since v2)
> 
> Changes in v2:
>  * New patch
> 
>  drivers/soc/rockchip/Kconfig | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/soc/rockchip/Kconfig b/drivers/soc/rockchip/Kconfig
> index 156ac0e0c8fe..aff2f7e95237 100644
> --- a/drivers/soc/rockchip/Kconfig
> +++ b/drivers/soc/rockchip/Kconfig
> @@ -23,23 +23,23 @@ config ROCKCHIP_IODOMAIN
>  	  voltage supplied by the regulators.
>  
>  config ROCKCHIP_PM_DOMAINS
> -        bool "Rockchip generic power domain"
> -        depends on PM
> -        select PM_GENERIC_DOMAINS
> -        help
> -          Say y here to enable power domain support.
> -          In order to meet high performance and low power requirements, a power
> -          management unit is designed or saving power when RK3288 in low power
> -          mode. The RK3288 PMU is dedicated for managing the power of the whole chip.
> +	bool "Rockchip generic power domain"
> +	depends on PM
> +	select PM_GENERIC_DOMAINS
> +	help
> +	  Say y here to enable power domain support.
> +	  In order to meet high performance and low power requirements, a power
> +	  management unit is designed or saving power when RK3288 in low power
> +	  mode. The RK3288 PMU is dedicated for managing the power of the whole chip.
>  
> -          If unsure, say N.
> +	  If unsure, say N.
>  
>  config ROCKCHIP_DTPM
>  	tristate "Rockchip DTPM hierarchy"
>  	depends on DTPM && m
>  	help
> -	 Describe the hierarchy for the Dynamic Thermal Power
> -	 Management tree on this platform. That will create all the
> -	 power capping capable devices.
> +	  Describe the hierarchy for the Dynamic Thermal Power Management tree
> +	  on this platform. That will create all the power capping capable
> +	  devices.
>  
>  endif
> -- 
> 2.36.0.rc2.479.g8af0fa9b8e-goog
> 
