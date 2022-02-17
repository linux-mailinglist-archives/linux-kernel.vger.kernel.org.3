Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5F0B4B9C8A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 10:55:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238893AbiBQJz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 04:55:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237274AbiBQJzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 04:55:25 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DAE0D205B
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 01:55:11 -0800 (PST)
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 3C53B40931
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 09:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645091710;
        bh=xqg/Xc9CYuc87DkKuqIherW4tETRFmrI7ZElb+EIvLo=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=GAORvpRRPrf+vkRusRc1QHGiTjSY2YIwdOg8Bx25a6357VBpJ15+MWJvxnX5f6smz
         f0i31p/nEyEfIjWxcH27J4JRq0G0VV2hPYzJKXe1Z6COWXZw2OxuX9ZD0d+VN624xH
         /03upjP8G+6lJmg7nosEzLz6V+5bpYXqh4KEujTg57bEwIvShqcikNS1Bk/xrZ42W9
         619hfaDTKYO9RoTFKUJPeC3PgEyF8AFRUiG+msaImy6JGXNRZxCU3kHNnjDtly4/Lk
         m4BGkHUPTf26rlDQuQ7TV+8w67/vT5WqtVG0/SgOF1nA0rG0hxiMSslGqviPcD5J+s
         A9A7s37j/kNsQ==
Received: by mail-ej1-f72.google.com with SMTP id k16-20020a17090632d000b006ae1cdb0f07so1256830ejk.16
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 01:55:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xqg/Xc9CYuc87DkKuqIherW4tETRFmrI7ZElb+EIvLo=;
        b=Fmp2IizWIguOSqo4B0Oy6AhvJzkmumx8525mgerQr+I7Q8jrC7bI02uwbkOvp4sSK3
         TRQezwSMnatio5cMzjGSLiSS/7C5UHMsS7qoY1sIlQe8Qy7jhBrueQhGMN0ngNnXPzvk
         OTpg7/bd1jmRZSmogwVYv+nALC9ZeGhEgKIfxlSzPSoLkONpAIusoA5KzzFGcgm2Mx5y
         0GyTa3DS6Tz9mA+v2i0HQe++4jEiRh84RQl3ZMmJfiKArulOgjXKIuOyv4LYss/lOPZU
         hUsvh4xutJiVS9iYQIb2QVOh1JANEl7S0vdf3ZCKfUNEpUu9ePFVkDpNYi3BdNlb4kJI
         cfhw==
X-Gm-Message-State: AOAM533LjRXkLe81aImjDxwrcNnZX62HUvf9L74oQKkU9+t4ALQ1lDUD
        cPaG+l2/MFtp+UB7+6ksfN2i4F/+MaODtLQs7S5TApWybGiuHB327hqO4AwA4Wb3azC00GbI+j5
        cKADlT+2IxzJUS+u/Il7oYDRhdW9DwIAdSaM+eVtIJQ==
X-Received: by 2002:a05:6402:1d51:b0:412:86c3:7580 with SMTP id dz17-20020a0564021d5100b0041286c37580mr1702414edb.353.1645091709889;
        Thu, 17 Feb 2022 01:55:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyVqiLRT5dbOU5Ly6LY4l8kChFX+8DIMSGvlA48+vjFgCFmMOBcgpltkyZQ5jhMw4Nm2YxMLw==
X-Received: by 2002:a05:6402:1d51:b0:412:86c3:7580 with SMTP id dz17-20020a0564021d5100b0041286c37580mr1702390edb.353.1645091709625;
        Thu, 17 Feb 2022 01:55:09 -0800 (PST)
Received: from [192.168.0.110] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id 1sm964379ejm.186.2022.02.17.01.55.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Feb 2022 01:55:08 -0800 (PST)
Message-ID: <535d7d37-c2c5-d0e9-85af-ae91cbccd0d2@canonical.com>
Date:   Thu, 17 Feb 2022 10:55:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3] dt-bindings: dma: Convert mtk-uart-apdma to DT schema
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, vkoul@kernel.org
Cc:     robh+dt@kernel.org, sean.wang@mediatek.com, matthias.bgg@gmail.com,
        long.cheng@mediatek.com, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20220217095242.13761-1-angelogioacchino.delregno@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220217095242.13761-1-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/02/2022 10:52, AngeloGioacchino Del Regno wrote:
> Convert the MediaTek UART APDMA Controller binding to DT schema.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
> v3: Removed anyOf condition
> v2: Fixed interrupt maxItems to 16, added interrupts/reg maxItems constraint
>     to 8 when the dma-requests property is not present
> 

Awesome, thanks!

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
