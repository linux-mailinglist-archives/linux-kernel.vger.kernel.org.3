Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74C974CF50E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 10:24:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236570AbiCGJYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 04:24:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237334AbiCGJXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 04:23:45 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C256527C7
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 01:22:50 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id k24so12673667wrd.7
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 01:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=2H3bOlfOoJGazb69yKfS/sfq+9Q8+S0RoO93d6v477E=;
        b=qitkM+VpPRyZ/7PZxnPXOdyD3DXCy+67o2nET6cp2jEHCTTb96yr41T9AXJKcRZ1hp
         WtyeZpk2YKhEzas9JXy9ICW3KI0X/3Wzyc9WDibpfnb2G0CE29bV37s7HfSgRyeLO5rA
         FuhXPOGGHm96mkDBm7ZmCjkUpIRg3diZIX12Q4cPLHN76zYpmUyPawOfOhTZ6ydVkIn1
         M94R2/vtVzuXVSv/qfYLNWiXAfxND42doEg7n4P7aZnq0s4onroDm9r77+mxTEyAYZEI
         5Gg/6aJSHVh+Ow4TQE49JKlw+ShZ7Oe+tU1tMGw8k8jBgPxnFLR0W/cmlWWDaL/tG9pN
         fTcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=2H3bOlfOoJGazb69yKfS/sfq+9Q8+S0RoO93d6v477E=;
        b=Q/NV0+vJnVBgvBM6QHixItBY1tAHa1lpkisutbiLtcZb1vRlOum2/uhhsaO2W/6Kch
         c9wxXIVX+kBZzA6+cR23Nf4lhm4NlALIpo6hykqlUOK0kGrz3L4uk7rIfvuibue76psO
         YlBYVFskzT+LYGga4KAXz//emSriYCxMMS1mAFiIHJDqmi+j9mQADaNxLAbmKsXyUqeZ
         00WVvKONmDQfq31tTKC4hqEWObWnzp5euYzoDZZyV1WiVAW+7fKqFq0M6RrbFFxiFQDC
         e8fySelc+KL3a/K0g7SFeSfNvZZ8Sb84n2LJCeRhBFkguCrSeJy6nuiSeuCEkCKoeH98
         GfyA==
X-Gm-Message-State: AOAM533xd+nK+2ruPMNQqH7MW9vfsz8yEc2ZT0g5ul+FOY/5TVCLXJwT
        zufQ8UHxShbYUm8vxtT3h/eqoA==
X-Google-Smtp-Source: ABdhPJxPhwAw8l9WqBnwJbxiH9KL3OutpuQdPLX3w899jAz9Onsp44AI9k8My/RHezDWBSOGBG/UKw==
X-Received: by 2002:a5d:5449:0:b0:1f0:1a0c:963f with SMTP id w9-20020a5d5449000000b001f01a0c963fmr7231900wrv.98.1646644968650;
        Mon, 07 Mar 2022 01:22:48 -0800 (PST)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id b1-20020a5d40c1000000b001f1dd6ea504sm5440695wrq.59.2022.03.07.01.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 01:22:48 -0800 (PST)
Date:   Mon, 7 Mar 2022 09:22:46 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        Pratyush Yadav <p.yadav@ti.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-spi@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v6 4/4] spi: s3c64xx: allow controller-data to be optional
Message-ID: <YiXO5plQdpsVfwo1@google.com>
References: <20220124082347.32747-1-krzysztof.kozlowski@canonical.com>
 <20220124082347.32747-5-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220124082347.32747-5-krzysztof.kozlowski@canonical.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jan 2022, Krzysztof Kozlowski wrote:

> The Samsung SoC SPI driver requires to provide controller-data node
> for each of SPI peripheral device nodes.  Make this controller-data node
> optional, so DTS could be simpler.
> 
> Suggested-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
> Reviewed-by: Andi Shyti <andi@etezian.org>
> ---
>  drivers/spi/spi-s3c64xx.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
