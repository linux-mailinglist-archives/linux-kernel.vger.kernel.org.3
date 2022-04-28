Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C10DF5130AC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 12:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233194AbiD1KG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 06:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbiD1KGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 06:06:20 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA4003DA5B
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 02:53:26 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id x18so6051699wrc.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 02:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Xqi3tQeoc1NHno9yKWMqbw4r5YQdgiKDuSb9oAeYHa8=;
        b=yr78g+MaZhUlHS2UcXn1OUn3doItrjOKC8k1mxoul2Im7B+S6CbbzGMO5FxmG7VARk
         B7pvcw5TzrbXRgxGIldFIdVA3DM15i8d7f48li84BuKwof+K4h8jJJXwABUBE8A7xGtb
         PHzESRMgKjoDZjv0vMD1jD3NzpGFDK8sWlO8gM3Zl61C++rp56wfXLpnL7R26QTzraP+
         xDY4MZ+BEVBP+FqFoFt9LOkDZZ/wHZbau4yo+bq7fAq3+a2j4vhSIRNUvoAY1FLovv+2
         qrF0EIdo+7RzxS07iAAzFNw7fAD1AUoPYFNEmSDJfhq6UUKpFGVWzCbVEOzo0F9yGCUI
         p/fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Xqi3tQeoc1NHno9yKWMqbw4r5YQdgiKDuSb9oAeYHa8=;
        b=ew7QudvdtZ08qS6YHL5wjlok6676NM9kw+HQQpIo9elPITHzzaaO74OUo8NzmQBaXz
         d6raMcLY+0xw41GlTBDeQ6U9OlMihXkL8kXg0lF7prRYItsaTP3Mw9eJ/krOrxENlnWL
         DXpavS7XTPBs4QBnhIgAqSmdWa2V24Qezn3Z9mbNw9wCBVfIGBrhe8KtyRqmHG8Dj9D7
         PddkwqfQBZMDAQz5jTlqItMCzpESc0ljdb35Ht+1kLkK8Y+Z9ExdBu/batdbwDUrVxHm
         xXfwbdcL5w4CYVhibwzW4zm/B133vwKb+J0lrn3WRsEdGIbJofB0vq9hAFamPq+tk/ZE
         TurA==
X-Gm-Message-State: AOAM531mXZVrujZcfimywYX/2vZmQw5rzUQpyewOej5Jjo8q2jK46s/d
        olQcTzekFznCBxtX7SrX4/2ByQ==
X-Google-Smtp-Source: ABdhPJww1dXap9RkiBq4VNLp6PdlAcDue9crNwyW2b35J8EzRhEJPe7hKCSwo+1hkrq+KUvXKsMcZg==
X-Received: by 2002:adf:f30a:0:b0:20a:e193:6836 with SMTP id i10-20020adff30a000000b0020ae1936836mr12101094wro.654.1651139605530;
        Thu, 28 Apr 2022 02:53:25 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id i15-20020adfaacf000000b0020aee621955sm3721870wrc.34.2022.04.28.02.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 02:53:25 -0700 (PDT)
Date:   Thu, 28 Apr 2022 10:53:23 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom Kernel Team <bcm-kernel-feedback-list@broadcom.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 06/10] dt-bindings: mfd: samsung,exynos5433-lpass: fix
 'dma-channels/requests' properties
Message-ID: <YmpkE0FgEhPNneg+@google.com>
References: <20220427155840.596535-1-krzysztof.kozlowski@linaro.org>
 <20220427155840.596535-7-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220427155840.596535-7-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Apr 2022, Krzysztof Kozlowski wrote:

> pl330 DMA controller bindings documented 'dma-channels' and
> 'dma-requests' properties (without leading hash sign), so fix the DTS to
> match the bindings.
> 
> Reported-by: Rob Herring <robh@kernel.org>
> Fixes: e18183cefc8b ("mfd: Add DT bindings documentation for Samsung Exynos LPASS")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/mfd/samsung,exynos5433-lpass.yaml     | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
