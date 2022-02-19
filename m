Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5974BC952
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 17:39:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242607AbiBSQkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 11:40:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiBSQkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 11:40:01 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60CF31BAC4C
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 08:39:40 -0800 (PST)
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id EA0763F1DD
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 16:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645288778;
        bh=fv6Vlts8WZIOYFM6nhe/RZHWwtYVs4haR4eZslzQ91M=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=Gw+t81ySigxZI9PojtI690BRL/zTq0Z5pzqtZtzuD7XZn+3s3Ji4CyRqMlR4no2wy
         PD8PCTE8KQWsHZlrtecwo45ase9w0yk9OLqWvpRISJnreDnkrnnEpm+GRnKMB1uLNf
         baAMLa8LbcwTL8LvvepGNBVe2kovHW/aL87jL18zGK3HpwGB0C4qLokpzdRTqFPVUI
         OWuunoPsoOgowSNGhZf3HO/oYBt9aGLESuPJaGfYFTbG+3X0XoSb72zZqxcOoC6QLX
         brOVKeQg1zUOL4r3vxU55APcr7wp8MLyP7WDF8n04gbrZSXFtXYpzvKU3n2rcu3TMA
         y36CFD+ZkvC+Q==
Received: by mail-wr1-f72.google.com with SMTP id k20-20020adfc714000000b001e305cd1597so4831468wrg.19
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 08:39:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fv6Vlts8WZIOYFM6nhe/RZHWwtYVs4haR4eZslzQ91M=;
        b=d8ApnVk8NORa66mgGa0Je3NUsdGew7J5iTw6d97B9G39SNTvUu9wNudPcl+yln6V6s
         NNyyKUD4jwNcJfhPf23MAcD2qzIv8eWZCmrTN78SV4SfhQnTi/Y9a9pDdbqBjtIi2Bl1
         GWdBBSZI/qofxoqyGI3dK/N46MGL7UGy/7/11R/gZXmyyj6+xipi795hD4KpDEq7/AoW
         ZeLNT6wXuri3HZEmGYZ1HztMarBsSsKIh/RKhmBKLLT8wDcCFppkQ0zOjv0xpWDrdZAS
         YQF62HfcP6hyBLNb2Fd0rvZEbcSPo9b0rEZQdxxYVGkj0rpgJWOrWHUiAtItt+dt4jXT
         OJ5g==
X-Gm-Message-State: AOAM530sTicQjbBxSDON7dbM3sC3rWDzh9wWyyfEKNVfBxMg0+aoXmOL
        yorZbO36YHQZIl+6p/4JrtkCZkD9ZiXoR3s5JokWZFrHzOdm9ZFTC1qfCuiWujZ/UuOzY8w8zJZ
        aaOcvCzUjLHZJZNpTJwkOY02M9qCz7GLH7eTIMWPySg==
X-Received: by 2002:a7b:c938:0:b0:37b:fdaa:2749 with SMTP id h24-20020a7bc938000000b0037bfdaa2749mr15160138wml.88.1645288778247;
        Sat, 19 Feb 2022 08:39:38 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwTjIE8tRPmBD+PlkUTZBca9lbgzOitR83nDpYhWogpejZ8yTpnvZi5vWazVdvUaNy10Rl8sw==
X-Received: by 2002:a7b:c938:0:b0:37b:fdaa:2749 with SMTP id h24-20020a7bc938000000b0037bfdaa2749mr15160128wml.88.1645288778087;
        Sat, 19 Feb 2022 08:39:38 -0800 (PST)
Received: from [192.168.0.116] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id p7sm20505311wrr.95.2022.02.19.08.39.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Feb 2022 08:39:37 -0800 (PST)
Message-ID: <6188a47f-ed12-7d0a-bc28-5efa4092b59f@canonical.com>
Date:   Sat, 19 Feb 2022 17:39:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v5 1/2] dt-bindings: iio: frequency: Add ADMV4420 doc
Content-Language: en-US
To:     Cristian Pop <cristian.pop@analog.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     jic23@kernel.org, devicetree@vger.kernel.org, robh+dt@kernel.org
References: <20220218150738.94735-1-cristian.pop@analog.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220218150738.94735-1-cristian.pop@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/02/2022 16:07, Cristian Pop wrote:
> Add device tree bindings for the ADMV4420 K band downconverter.
> 
> Signed-off-by: Cristian Pop <cristian.pop@analog.com>
> ---
> changes in v5:
>  - Add spaces and fix prefix in commit subject
>  - Rename node name: admv4420 -> mixer
>  .../bindings/iio/frequency/adi,admv4420.yaml  | 55 +++++++++++++++++++
>  1 file changed, 55 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/frequency/adi,admv4420.yaml
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
