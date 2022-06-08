Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7222542C07
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 11:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235270AbiFHJyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 05:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235831AbiFHJxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 05:53:39 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 000A04253F9
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 02:23:38 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id i17-20020a7bc951000000b0039c4760ec3fso4140852wml.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 02:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8eV6nIYV8SU6cGKfjJH6IuBQJkesB4s+GfYeW1ujbBY=;
        b=yfPJviBzBPAoWfqiRyBev2YmtSekag/ce5R4TXWS48H1P/Evi7E5TB4vT3PR3E8aj3
         W7V+yIRePpReAEdegxUDxKd1K5j3YcZ/X9I2dg95aREfa2ooixPGrI4JNbofdS5Sq1cJ
         W42F5YcmUZk2zJk+QQk0+MVdp0O0W1Pk01mKCNppDXZyCUkjqBW10RbxyMuj7ydHz4dZ
         PfnejUW3iyyNEIkJcCSwpK+9Ki08hmTYbDfedqOsRj+WbfyXvmi6OR4qm+K/cObXS/t9
         HYm9o8wLPshlOpW4G0YGfzNBC2K2TstMcRLWAUaLgN+v2Db+PnvZLxiNHb1dAZfixesi
         jIXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8eV6nIYV8SU6cGKfjJH6IuBQJkesB4s+GfYeW1ujbBY=;
        b=TW7uAdZA6Y0u/R6ppRbZxxGG7kS3lwF1GudEO/VFx6KlMTTCldLSvSkC1sPseRUDQW
         DwpWKULUzHB0R8lbsLg0S7d3UU8DwzGfMkcNbkLTyATBFFe55Nk4a2SQMn/kDdjGiUJo
         FsTLPvCX+ahA1VgPmvTAy/EDjDTniwSyc+Ttcv8+fZTM1N3XdXaxid9l7ZjlwmLASLWQ
         6awG2HiXkrZjZfzgtVb83CO3WnOEQM/BnXaVa3lYWeCcX5EOG4kf/iRKdoyLd8wvx+hD
         C83rfxVNO1FJX6WNUFcsfwka0gTJLFzp8uL0ZuF2cQntDaQuZ5WHRwzAgx0MltK+26TT
         ppoA==
X-Gm-Message-State: AOAM530Xn9iuhEb+QmQ25wnW5p6tLA3g49jS4YH3EGw5xObA26/Hmi22
        DpuTYTBhVNoiev1EDe9YwpEhUQ==
X-Google-Smtp-Source: ABdhPJyM+IflvMN2gKuuxgwYkvwPOCyEfY1Cnbc1MlR6mjMqp5ng/HykRi2LIV6jvv1XqHQatPbucg==
X-Received: by 2002:a7b:c5da:0:b0:39c:542a:a07b with SMTP id n26-20020a7bc5da000000b0039c542aa07bmr13928306wmk.83.1654680217388;
        Wed, 08 Jun 2022 02:23:37 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id o18-20020a05600c4fd200b0039744bd664esm27578721wmq.13.2022.06.08.02.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 02:23:36 -0700 (PDT)
Date:   Wed, 8 Jun 2022 10:23:34 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     cy_huang <u0084500@gmail.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee.jones@linaro.org, jingoohan1@gmail.com, pavel@ucw.cz,
        deller@gmx.de, cy_huang@richtek.com, lucas_tsai@richtek.com,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] backlight: rt4831: Apply ocp level from devicetree
Message-ID: <20220608092334.23srjgxsjmj7mwer@maple.lan>
References: <1654677674-15417-1-git-send-email-u0084500@gmail.com>
 <1654677674-15417-3-git-send-email-u0084500@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1654677674-15417-3-git-send-email-u0084500@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 08, 2022 at 04:41:14PM +0800, cy_huang wrote:
> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> Add 'richtek,bled-ocp-microamp' property parsing in
> device_property_init function.
> 
> This value may configure prior to the kernel driver. If it's not specified in
> devicetree, keep the original setting. Else, use clamp to align the
> value in min/max range and also roundup to choose the best selector.
> 
> Reported-by: Lucas Tsai <lucas_tsai@richtek.com>
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
