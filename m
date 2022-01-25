Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94A7F49B24E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 11:54:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353549AbiAYKtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 05:49:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355294AbiAYKou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 05:44:50 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9AC1C061756
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 02:44:42 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id r2-20020a1c2b02000000b0034f7b261169so1477241wmr.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 02:44:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Gue0fJwwcgJTZVNdeX+6H9YxIr2uToB8WYyhrif8Zgg=;
        b=sfzTb+mBqz0CAb/NiDVYEy4M/U6s+cmQivYUZ8T8HCXtmf47TqVlQa1MVrKhdPAMHN
         +6sUu1m8cJkI2leNd7KOBhsW/75lhMRZXi2RgH1od2b4BisBeAPZq26RZk0ojhIeqAvU
         E7sfVfSgMK3D0+Ao8mZk7tESb0rO1VWhWnEa0+IehTUyxqK6eNAffYdfKIAYHypoFwiD
         pGadS7fcpBpZh2iYufU8CZlSmVr6I+ufZREvlxdmNgy/3VdzFUfs4xUN6DJI2EOWZVZx
         sR3jFsHtIpGYVQ+FGBhHrmI6E2cPmgy9vVR/gtFq5LoHmrCwZU65QghzCIWNfZ1cV36o
         INDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Gue0fJwwcgJTZVNdeX+6H9YxIr2uToB8WYyhrif8Zgg=;
        b=UzoHiaCwSoFevhULovW0lcNkKE1rN30ZHnY7bIEstb/giOFO6M/wHW45qn6zWG8/Nb
         Hum+ui8FglwXnVcGML+O5G8R3N7mpuZHSQRFdN/c3Cf+BOdLudf+Kz4nuiOXukJBjzQK
         FbG9I/RnWQmMdrnjeylJb4ERxR1wy/Vp2+gkzZgQwe9h09nNhNOzefkop7Oy6S1+3vEf
         HHS7EuiKvXH+thui9jXgDwZvYOS1MpQ/tw9vffWWIvCjACnroNyBbnWWA/VTsInhp91K
         BDubvl9n6FAeZl9BP5+Q/4sAqctfHmu+AC0r/QuLz7zR7UIweMzcakQV923IswtRh0Vd
         E1Gg==
X-Gm-Message-State: AOAM532D7gGYD6TE++7VxouOVz4zAlwP49Z+uOqdTrN4EjhYm4Dw6blS
        pEi7SkcIIuS0ZbDJ/LwP08jeww==
X-Google-Smtp-Source: ABdhPJwyyIe2jBpAoerujDirbO4rY9Xe5Cophwwo1PvJt0DtwWdDxkzOGYMcccAJJqr8guZLIXQUMQ==
X-Received: by 2002:a7b:c944:: with SMTP id i4mr2337930wml.174.1643107481389;
        Tue, 25 Jan 2022 02:44:41 -0800 (PST)
Received: from [192.168.86.34] (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.googlemail.com with ESMTPSA id o14sm5657228wry.104.2022.01.25.02.44.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jan 2022 02:44:40 -0800 (PST)
Message-ID: <3f9a9731-c096-bc9b-63df-bd1dff032737@linaro.org>
Date:   Tue, 25 Jan 2022 10:44:39 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 3/3] nvmem: core: Fix a conflict between MTD and NVMEM on
 wp-gpios property
Content-Language: en-US
To:     Christophe Kerello <christophe.kerello@foss.st.com>,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        robh+dt@kernel.org
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        devicetree@vger.kernel.org, chenshumin86@sina.com
References: <20220105135734.271313-1-christophe.kerello@foss.st.com>
 <20220105135734.271313-4-christophe.kerello@foss.st.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20220105135734.271313-4-christophe.kerello@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/01/2022 13:57, Christophe Kerello wrote:
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index e765d3d0542e..e11c74db64f9 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -769,7 +769,7 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
>   
>   	if (config->wp_gpio)
>   		nvmem->wp_gpio = config->wp_gpio;
> -	else
> +	else if (config->reg_write)
This is clearly not going to work for everyone.

A flag in nvmem_config to indicate that wp gpio is managed by provider 
driver would be the right thing to do here.
>   		nvmem->wp_gpio = gpiod_get_optional(config->dev, "wp",
>   						    GPIOD_OUT_HIGH);

--srini

