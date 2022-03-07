Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA7004CF541
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 10:26:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236832AbiCGJ0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 04:26:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237250AbiCGJXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 04:23:36 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38EC666AEA
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 01:22:12 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id r10so22149962wrp.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 01:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=TzLMm8d5/5RhTE3DYDsmUp6D8X8Ydwg5/r6Fi48udB8=;
        b=QgeD1W69kNSsFj6i3XGdU7D+hth1glWGCqT4P7Vm0wMB4RPSONn5E/Iwpqq7CO0qbt
         BHq4ZYSB3XEASxpnrq2urNEdVYZt7F0JaYDdV+dZ5n11Ab055gxPWK2WTZgWKWadI4YJ
         XsB3konkMeFniH33UHxIECdGh6R0l89qgA2pERzu8DTW+y5VOXwOqJayevO9VLfYrxWZ
         utuhocvMHNQ17tIUFL/30DyxhZcJ/2tddzKOb5pvY9frgDRNZY8Bd2j3lncNsL94VvQv
         Bt6ewUUVH/jDC1hx/Pl7O9mOimjwGYnLRnJQeB+VQZstjvfC7VnFr+42bsyu+I4vd0rp
         QiPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=TzLMm8d5/5RhTE3DYDsmUp6D8X8Ydwg5/r6Fi48udB8=;
        b=VBk+p7J3PHAyZpZ0osRniKUNsd5/uTdRW54SY2luBBrr6S/fgWdhxkDFGrrRxAi2Hu
         lFWc62HFXFDtEUx7Y8i1FmMvJCxUW4/YGdt7REwrpTpkanv3P4sd2MDUJz71dWk7kWzs
         5WpWLbDf5rqGhXNLpEhG/woJRTtBf8wuQUzl/pKtK2x+C/WZpNCN75uJwqtb+KIRBnCN
         oMBf3HS1V8jsX8DWw7vWyhrDrfqOd6EhTqxKoblaWZ4QmXgQUI5oWBafQT97qYuFeMoG
         VmGFeZcoce9umOg3HyjAFxZHbd7P2572kPH0gUYsJUE6HFjdf6F71M5YACacAIAib1bO
         VOBw==
X-Gm-Message-State: AOAM530b3vUu9Jt7wTayiARXzkMGT5KPZsZoDi6rQAPgXRbN+Oxnusky
        IABqmje6P1ctuaYudNIcxYUf6g==
X-Google-Smtp-Source: ABdhPJz4EFu0SE80BY7+ikiCREJ1pMzmlDCfMLmycAfsArDTW2sXSNoBB0FYUyjw+lidQB23WvmTpg==
X-Received: by 2002:adf:f150:0:b0:1f0:6925:722 with SMTP id y16-20020adff150000000b001f069250722mr7237824wro.465.1646644930760;
        Mon, 07 Mar 2022 01:22:10 -0800 (PST)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id u18-20020adfdd52000000b001f04e9f215fsm10449523wrm.53.2022.03.07.01.22.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 01:22:10 -0800 (PST)
Date:   Mon, 7 Mar 2022 09:22:08 +0000
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
        linux-samsung-soc@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH v6 3/4] mfd: dt-bindings: google,cros-ec: fix indentation
 in example
Message-ID: <YiXOwFvDIvrB0t2E@google.com>
References: <20220124082347.32747-1-krzysztof.kozlowski@canonical.com>
 <20220124082347.32747-4-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220124082347.32747-4-krzysztof.kozlowski@canonical.com>
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

> Correct level of indentation in the example.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  Documentation/devicetree/bindings/mfd/google,cros-ec.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
