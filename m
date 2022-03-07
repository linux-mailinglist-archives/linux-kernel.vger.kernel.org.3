Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EEBC4CF743
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 10:44:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238049AbiCGJpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 04:45:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237493AbiCGJfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 04:35:20 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47DDC5BD36
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 01:31:04 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id m42-20020a05600c3b2a00b00382ab337e14so9753434wms.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 01:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=mEobgGRGVJ5wiAE2capMOyflSnP2BH+i8WBwi8HQrCE=;
        b=NjumzJzXCW534OAtBTl5MUzvZ/jln6ubPNbWaGKP0P3vhbQk0ynhrATl5R8P8ua6PE
         jL7QXrBuehr/5qfZoRo7xAZPwv2FkvT329Qhq5iQ/bCJIeb87w2R1fsLjrWPZ0l//qCg
         tYPDMOCjCq0N6QZyloMMGqvwdRQ99LolPRzcpnEPRbmLDFSE1SmD70dsPfGsPlv5XRXT
         imSCAybERGskCUPGNBRperwkzn/+mHVGRBJVl2Qu1z1r1Lp9VZoJplbNe5LZ56FQRwP3
         H6ON3vUdPlKsWhgRGxGoM4aSSOvmt0MqIocAVAIwQfitt8ryyh9rSJIeON46u3ohAq8e
         +FuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=mEobgGRGVJ5wiAE2capMOyflSnP2BH+i8WBwi8HQrCE=;
        b=j81yph3scVihpTGOPNmbBTCNe20KK8b5cBuVNGJ5cwVW33ezRALKTCSlA9LBzBMGOp
         R1CgukRcxUFPrD9vamLlKIEB8/vhkJrfY0F5ZkQ5IV+0v+4IPV3WXirHUsYB8gnRtD1j
         Dlifh7xn0jDuBB6EJi99eXoK0l16VSS4g9abYEUS1nAIW+lwhtHkwV9hUwj8VwF/vNeX
         Z+pZvMQS9+CqVUdigIUWWmIlsauAEDzCRftTy3QQaLo9sr6bkz/IJal0cCUCt4AIJwPF
         va+xIWtK4aLziGSthDldt8T9ScspURAkMcokL7sUk2nfTY8lNUokuB0CwZzlcOz92vxX
         d1qA==
X-Gm-Message-State: AOAM533gcAfNOqo26iDNEl/B7/ST1nKhBvqIhSzJSEkyL+Te0iIUW4Tf
        YPLdm0K9ptf0iYXvFvQbp7R62A==
X-Google-Smtp-Source: ABdhPJxVFyQ+f5cy6lUcxFa91ShR5PJvJhr2UPMVkDjDE6mY7sIKkjrehIRNnwFunvP9OhEL6QgSoA==
X-Received: by 2002:a1c:f705:0:b0:37d:f2e5:d8ec with SMTP id v5-20020a1cf705000000b0037df2e5d8ecmr17701505wmh.21.1646645445640;
        Mon, 07 Mar 2022 01:30:45 -0800 (PST)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id g17-20020adff411000000b001f03426827csm10805840wro.71.2022.03.07.01.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 01:30:45 -0800 (PST)
Date:   Mon, 7 Mar 2022 09:30:43 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 2/3] regulator: dt-bindings: maxim,max14577: convert
 to dtschema
Message-ID: <YiXQw01QZ4zFeALb@google.com>
References: <20220215074759.29402-1-krzysztof.kozlowski@canonical.com>
 <20220215074759.29402-3-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220215074759.29402-3-krzysztof.kozlowski@canonical.com>
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

> Convert the regulator bindings of Maxim MAX14577/MAX77835 MUIC to DT
> schema format.  The existing bindings were defined in
> ../bindings/mfd/max14577.txt.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/regulator/maxim,max14577.yaml    | 78 +++++++++++++++++++
>  1 file changed, 78 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/maxim,max14577.yaml

Applied, thanks.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
