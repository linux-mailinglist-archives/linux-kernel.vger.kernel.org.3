Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0705155433F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 09:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351579AbiFVGu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 02:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351561AbiFVGuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 02:50:51 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D855035DD9
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 23:50:43 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id g25so32059227ejh.9
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 23:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=hDecnGG4JqyqaEmTekjzP5TBFNFZlOAgs9hf2jW2DzU=;
        b=ZTCaVUax35P/NMEV0BrfMR1PGal2Fyisxi/nTx1vzSLlDQjPRULxmzs1bl8qWG3i45
         BhZOIHDp7X4mvWkIzdavkKVhF44fcyFw4j5iaBnZd9rJ0JRQ6O796iPmeCvxXcoOWPKN
         XUqrn4QMsixzrfKAJxuU+mWbDW2x0vwMIji3h66T9WTMwBtyEZ16lPk+hr2i6tj5UZTq
         pgWCZ/U9rHJuVjdlZ86wneJE4e/098gBAw/opNv1/AGxFnY9jMtXwn33whvZeDBvmQXT
         wwnVx2rcT/gwfzeK0w71Rl+sg1mxc5pyvy7ZD7g3GCmZi0+gVzXYjIS/JuOssukUr9bW
         QWBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=hDecnGG4JqyqaEmTekjzP5TBFNFZlOAgs9hf2jW2DzU=;
        b=g9QC/cdST71pSbqfs5se54FsQejIM/B1Acnfu48LbSEMqLUERbrzzwCPtWFLGaLydL
         OA8TyR5hjFlFwWsUKJxmCkFoNQPFOWFoPyaZvXDNrP0wWXS7l18oHy/EOB2j1YCLF6vA
         XcmrClKM40RRSKjShugcKE58KXaMX+CivZ+oiwO2QMfQX+Qo+HeP9IaVKWUS7V0KRuDs
         Dox/9f4qanG093xqXcswoJBc8x04w8LxMbBFOfD6RMFk1aJTm16a/n9ryU6Z1eY41DoP
         Vn6Mwdv+uNKb/p1lQDc/twK/ZFfgaUCtLxcatj6jw6N5KFNzofW6eNvgdDVfqEJddbiI
         qMkA==
X-Gm-Message-State: AJIora87D4Hegv31BcimQ0pEcmG/XtitKKBuV07ADE+li+vgsTY79QiG
        3j86cBlvNiCqSobIv5xtXzgPPw==
X-Google-Smtp-Source: AGRyM1v6P9lcbhtpyb9iwwfskLAwO6UuTNjyafIdu9H1nHALG62CuEf9jvAvCWxhr00K6eTtKh+79w==
X-Received: by 2002:a17:906:530b:b0:722:e9ad:e90 with SMTP id h11-20020a170906530b00b00722e9ad0e90mr1749111ejo.676.1655880642434;
        Tue, 21 Jun 2022 23:50:42 -0700 (PDT)
Received: from [192.168.0.223] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id 7-20020a170906308700b00722e7e26d22sm1556075ejv.58.2022.06.21.23.50.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jun 2022 23:50:42 -0700 (PDT)
Message-ID: <bdfc94d0-c634-c391-d74b-2104cbf82b22@linaro.org>
Date:   Wed, 22 Jun 2022 08:50:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] memory/tegra: Add missing of_node_get() in
 tegra_emc_find_node_by_ram_code
Content-Language: en-US
To:     Liang He <windhl@126.com>, thierry.reding@gmail.com,
        jonathanh@nvidia.com
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20220622042824.4094625-1-windhl@126.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220622042824.4094625-1-windhl@126.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/06/2022 06:28, Liang He wrote:
> of_find_node_by_name() will decrease the refcount of its first arg and
> we need to add a of_node_put() to keep refcount balance.

We do NOT need to add an of_node_put?

Anyway why do you add of_node_get which is not explained here?

> 
> Besides, during the 'for' loop execution, the refcount of 'np' will be
> automatically increased and decreased. There is no need to call
> of_node_put() again.
> 
> Signed-off-by: Liang He <windhl@126.com>
> ---
>  drivers/memory/tegra/tegra20-emc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/memory/tegra/tegra20-emc.c b/drivers/memory/tegra/tegra20-emc.c
> index 25ba3c5e4ad6..e43a5f8e188e 100644
> --- a/drivers/memory/tegra/tegra20-emc.c
> +++ b/drivers/memory/tegra/tegra20-emc.c
> @@ -477,6 +477,7 @@ tegra_emc_find_node_by_ram_code(struct tegra_emc *emc)
>  
>  	ram_code = tegra_read_ram_code();
>  
> +	of_get_node(dev->of_node);
>  	for (np = of_find_node_by_name(dev->of_node, "emc-tables"); np;
>  	     np = of_find_node_by_name(np, "emc-tables")) {
>  		err = of_property_read_u32(np, "nvidia,ram-code", &value);
> @@ -484,6 +485,7 @@ tegra_emc_find_node_by_ram_code(struct tegra_emc *emc)
>  			struct device_node *lpddr2_np;
>  			bool cfg_mismatches = false;
>  
> +			of_node_get(np);
>  			lpddr2_np = of_find_node_by_name(np, "lpddr2");
>  			if (lpddr2_np) {
>  				const struct lpddr2_info *info;
> @@ -521,7 +523,6 @@ tegra_emc_find_node_by_ram_code(struct tegra_emc *emc)
>  			}
>  
>  			if (cfg_mismatches) {
> -				of_node_put(np);
>  				continue;
>  			}
>  		}


Best regards,
Krzysztof
