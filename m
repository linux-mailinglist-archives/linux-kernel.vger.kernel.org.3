Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D238557B213
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 09:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbiGTHst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 03:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240228AbiGTHso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 03:48:44 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A04AB691C0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 00:48:41 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id h8so2187282wrw.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 00:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=9ElSeSk614sHvQ21Olszx7/fOD72S3pdEjMKoWVvV70=;
        b=vhSEKJmVmMARaRWH0xaA2l+kCtoc5Zx/reprZlY45YpxW3DQg9C4qONfodIx8+o4FZ
         158sB+03Rej/8Yf3e7gYSweZ3QyCmBdBh0VytqYAKE+oZyQSUaBygJar2jiBAzoEkfDm
         Xy7z/6IV1uZa5/UMmF0q2rzbG46hJGLHu0glLNe/8bl6J3YbSzA9dXRv9XD4fKfjMchv
         ndvMvmrncYAgprfLQrycI45wKDPfJwlwoaICFQ+hwF1gknT6bSptzTNKEdB+SKsj12Tg
         LRCrO1tXEf1JQAWFoFemlZHgH/7yuZxocrMVCc5L3QF30Q1OI+1IHZ05vmaUDeusjeDV
         n+1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=9ElSeSk614sHvQ21Olszx7/fOD72S3pdEjMKoWVvV70=;
        b=lLmFkSMqGAEov8XKYxyTinZiE+H4GLoP2EfZF0U6hhgcVsB6cqiOVIK2e9p/y8oelN
         j0mL6mTXd5RP0lAq4RXdkqEvjiBogTg6yoqolSmfPaqCbbq+IA0/Zy7w5iUIlS9Gi/2/
         6re9sGuACHvLT0yP/IJq+pNCip6bX4rkVY+KdYjeq54DEYxeLXmIgsyHYUWsNEkWKvQe
         KN58mhuwVXSMtR3TcDGm/v4gJon3QD8d53a5Z289KxKcZ9F3minSOd9GFx37QbIBLHZf
         8lKHTHqo8JEeNQtqLNU2cvt4WNzAH/N3tO3B/7ebq0aavra5hqEcBM+wJAU3hRHcV/8t
         7KpA==
X-Gm-Message-State: AJIora/8G0a+NomdajESoDaF9b/ePYo/M2aL/hnAY3o5dHDh4IEzPFZW
        hF4iwJjWNf7w+RwMJ7uq1ihn3+WSb5XKuQ==
X-Google-Smtp-Source: AGRyM1vuPStHxI48eylnYSZO/6tJTXBaSbjnGnKmJlNTa/CBji3je23kXPmhNPY4cFUIPz3Fu06IOQ==
X-Received: by 2002:a5d:4e49:0:b0:21d:6e8a:fa3 with SMTP id r9-20020a5d4e49000000b0021d6e8a0fa3mr28469922wrt.528.1658303320157;
        Wed, 20 Jul 2022 00:48:40 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id a20-20020a05600c225400b003a32167b8d4sm1444891wmm.13.2022.07.20.00.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 00:48:39 -0700 (PDT)
Date:   Wed, 20 Jul 2022 08:48:37 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mfd: st,stm32-timers: Correct 'resets'
 property name
Message-ID: <YtezVaZGhEZ1ZEKL@google.com>
References: <20220719215125.1877138-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220719215125.1877138-1-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Jul 2022, Rob Herring wrote:

> The correct property name for the reset binding is 'resets', not 'reset'.
> Fix the name.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/mfd/st,stm32-timers.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
