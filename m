Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD6AE4CF9E6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 11:14:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240436AbiCGKIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 05:08:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239386AbiCGJtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 04:49:39 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D6B06E568
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 01:43:12 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id v2-20020a7bcb42000000b0037b9d960079so10978669wmj.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 01:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=jUnpa9JbqR6HAnUfa1Lcq9v1yG1shY5AgIzMl2mBcFE=;
        b=t9Wtlo+r0Pn5tPQdeD022pbjZvaPxMQo0hdjv8++mgad+O2gXdBf/i85tX9TWq3kTG
         RtfnUhGKxlTTSWAXEI2eZb23JU29B9mIjEXGCdLBWM496P11Rr9XYDAG9roenwZghBRq
         FsHWGBojuuXWSgs2/WNgQZeaZahkUJNI2eoLatAsGNS/9BbooHQvHhsV0GLnBmpmU9bq
         HrizOTTs5T7N1kefnHSmfz9iW75HjNkOUujNqb9U1TwwL+l1qbiOgSg8OiGHTG2EM1zL
         PlR75pXbszJIkTCeDAHgBpZHliJQgSiPNTXmvh48AGbOfSug17BixFbXF9RI8TNMM9be
         WEyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=jUnpa9JbqR6HAnUfa1Lcq9v1yG1shY5AgIzMl2mBcFE=;
        b=wiFZ2ij5Tm6yLvObMrWmpDwRqB05s5CE15HeNMyDRtGd8d5z9TFEvSOC6LxCSlqqIX
         yElM7JurKHZOd1pt501pDvfKw5zjpSMZ9jC73Jfj1My/8UUVpSQSaHLr+4+KIFRr3jft
         3iDSkJSEsMPOBzfI5tSdqPbG1llsS+6DGvd3T1XA3hmbsO4m2Bdg+OrIDsdUqTn7DEDj
         hyN+OjuXelxxxdg9+Ei7kGnrvz/lSXhrv//li59nAfJYCl3+Chyz3ZrdnspB5JSNACgf
         Bc5MUj8BbPWjbzlMwniv5Fzi5TxbfKG5xBOi86i/pM+k1wkPgJTcCwdHO1VYtOdLIdUM
         C4Qw==
X-Gm-Message-State: AOAM531xougrY2qPWoseq2sowodQt2QFR0Q8quo7TtkfhVXGddSaoLuD
        YDiVefnsdnj47LInQxbkhE3mHA==
X-Google-Smtp-Source: ABdhPJxMwUg9F7Yyw/Mvr1bBZ99wmak82idN666DkfF2sR4hkKMm/3BdId5wfHRxVmDD6jFd6t/xxQ==
X-Received: by 2002:a05:600c:4f55:b0:381:7386:ed68 with SMTP id m21-20020a05600c4f5500b003817386ed68mr17571401wmq.36.1646646189308;
        Mon, 07 Mar 2022 01:43:09 -0800 (PST)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id a10-20020a7bc1ca000000b00389bc87db45sm576607wmj.7.2022.03.07.01.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 01:43:08 -0800 (PST)
Date:   Mon, 7 Mar 2022 09:43:07 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Javier Martinez Canillas <javier@dowhile0.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Javier Martinez Canillas <javierm@redhat.com>
Subject: Re: [PATCH v3 1/2] regulator: dt-bindings: maxim,max77802: convert
 to dtschema
Message-ID: <YiXTq6QojkzqvgHB@google.com>
References: <20220215075344.31421-1-krzysztof.kozlowski@canonical.com>
 <20220215075344.31421-2-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220215075344.31421-2-krzysztof.kozlowski@canonical.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Feb 2022, Krzysztof Kozlowski wrote:

> Convert the regulators of Maxim MAX77802 PMIC to DT schema format.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
> Acked-by: Mark Brown <broonie@kernel.org>
> ---
>  .../bindings/regulator/max77802.txt           | 111 ------------------
>  .../bindings/regulator/maxim,max77802.yaml    |  85 ++++++++++++++
>  2 files changed, 85 insertions(+), 111 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/regulator/max77802.txt
>  create mode 100644 Documentation/devicetree/bindings/regulator/maxim,max77802.yaml

Applied, thanks.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
