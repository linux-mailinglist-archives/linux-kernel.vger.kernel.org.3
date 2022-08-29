Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9C35A4649
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 11:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbiH2Jl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 05:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbiH2JlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 05:41:06 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C7E94505A
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 02:40:54 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id c7so2752855wrp.11
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 02:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=FM+u/mT19a85swWLirrWas+cuEiZlUx6xGmwi5sOw9Q=;
        b=CR/429N71yazrm5/GlvVbONcJoh6cPfXGYcwqJEQTMhYzAMFpXA+Pf13aXAA5ocPLQ
         PyO7mI3WKEZbFSHVp8DN8HtyhahXiQ1vJQZoDmPmfpfUSUFNMk7llu6DyryxCtPx51QM
         UggdjRr6OCpz2I1aB+YBSjdf7baBkWv2LNjU15dug5RLH3NaZuT1TGf4hhVoihKnyOrn
         KS0aId49TCKXRZ+8As1clAfdlLcfqjkFqBKf6TJnPItx+8Wd42Cuzq29FQqGL0n0vdPc
         MWlZHocaeL1NO/HzOZLtPJ3ZWcqMRTdFyyeXatsF/XKP99Km19neLAkjnP+4aVzKklhJ
         Cigw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=FM+u/mT19a85swWLirrWas+cuEiZlUx6xGmwi5sOw9Q=;
        b=fwoASjnrUpuO5Kiz70PmeSe/qkA1xCACzcwy+qjwPw7Onzn3QctkcGsWHNmaW4koef
         yBbcPJOr4cgof5uoSaNqApCG0qO/2gdq9ZgEAIk+SyZaTap1vYbj6KKYO5RkwqWEBaLZ
         vvXkfNUt0GZ11n7Ai7fAnvTPEzfpP3unVB+e1CmETlj+5oijzOI+nQbkfvk9POAt3jg4
         y6p2BhkKwmN8dTVDjLNKQMvptaSHWjC3dtQD1hrw/oAWDKjdl6pqCZBGCQODzUwNh/jW
         D2S7CB9JDnwwHl2QrraGyIMwa8d7hrsQ1JT35ogMmNo4Et6Y48o9ILs+9r0wdnpRRvYU
         WjTQ==
X-Gm-Message-State: ACgBeo0r+xwJcuq6lu0pGo5XaCc3aJyo67DHkxWSN9CiqzkO9TTYezsN
        sbdIiNwkDw1GrkyMQrv5i+Hq8A==
X-Google-Smtp-Source: AA6agR6yz+KetRQLU5z5+8USMBrJz6Xsi96fJACvOe/SZcUPY6d6c25Q1ykCxbsnofqIb7BISTZIQQ==
X-Received: by 2002:a05:6000:1045:b0:226:df71:fd5e with SMTP id c5-20020a056000104500b00226df71fd5emr588745wrx.427.1661766053017;
        Mon, 29 Aug 2022 02:40:53 -0700 (PDT)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id k13-20020a7bc40d000000b003a83ac538a1sm7489435wmi.29.2022.08.29.02.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 02:40:52 -0700 (PDT)
Date:   Mon, 29 Aug 2022 12:40:50 +0300
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Marcel Ziswiler <marcel@ziswiler.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Abel Vesa <abelvesa@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 4/5] clk: imx6sll: add proper spdx license identifier
Message-ID: <YwyJorBWti0FTYg/@linaro.org>
References: <20220826192252.794651-1-marcel@ziswiler.com>
 <20220826192252.794651-5-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220826192252.794651-5-marcel@ziswiler.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-08-26 21:22:51, Marcel Ziswiler wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> This fixes the following error:
> 
> include/dt-bindings/clock/imx6sll-clock.h:1: warning: Improper SPDX
>  comment style for 'include/dt-bindings/clock/imx6sll-clock.h', please
>  use '/*' instead
> include/dt-bindings/clock/imx6sll-clock.h:1: warning: Missing or
>  malformed SPDX-License-Identifier tag in line 1
> 
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Reviewed-by: Abel Vesa <abel.vesa@linaro.org>

> ---
> 
>  include/dt-bindings/clock/imx6sll-clock.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/dt-bindings/clock/imx6sll-clock.h b/include/dt-bindings/clock/imx6sll-clock.h
> index f446710fe63d..494fd0c37fb5 100644
> --- a/include/dt-bindings/clock/imx6sll-clock.h
> +++ b/include/dt-bindings/clock/imx6sll-clock.h
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0
> +/* SPDX-License-Identifier: GPL-2.0 */
>  /*
>   * Copyright (C) 2016 Freescale Semiconductor, Inc.
>   * Copyright 2017-2018 NXP.
> -- 
> 2.36.1
> 
