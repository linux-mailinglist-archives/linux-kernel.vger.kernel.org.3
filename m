Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35E734D7DD9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 09:52:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235357AbiCNIxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 04:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236959AbiCNIxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 04:53:50 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F881DA68
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 01:52:40 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id p9so22633264wra.12
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 01:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Ule/aqdhSJr0hH+xLp5cZT0xnq/aSwegNWuPzYz92L4=;
        b=T7BBQRH0m7boDN0DcNVFe4NFmoUR+7eCxafGF0LGeLpmdNfsI/ql87JmwVUTu4kB0Q
         /zZtiFX+Qba4BIcY4KZZkMD5HpH0bUY7JMc3A1iLCkvCaaIm6L7bdRs0BUgPU7ZDK3vZ
         tp2/evm2hU122b7aAmZbTpi8Nd+9B+iKFaiPCHpi1iHBQrG3VmOfJ2HpCicAQcI+KO3M
         cJzYaBVuQa9/ykGpT/tFDUw9FQJUSkOrvEih+wNhp5vWDjwpQE6gJjkGITKsKrNNCuB4
         FDXWWeQBihknWvpfxl1fRPiiVN+vhub7i2FSuWNUdspI9xVpRe5gwcx1YPBVYl0y4VV4
         PV+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Ule/aqdhSJr0hH+xLp5cZT0xnq/aSwegNWuPzYz92L4=;
        b=Bd1KZEJ/vBAHpd1ci0UGEPIJYlcSYHmQ1O2YlgT3oIoavT6axY+NCmKwEjwulzLaZW
         WJxdI7a4L3NkNW4SWz+BhoIW3S9aE/zf0pI6CC+8pwNm9mjho+dG5vJUVMxBAiOhMtdx
         g6MNNCpIo4l1HXR1iPUglR3Za+czyW2rDfidO+nNXZiziLfwwUeimTTG6A8HdxVKDSTA
         DX6oy9ZvJpOyOGFE9+SogbTKFLUH6zuRwuA0Rp5Q5EqYPCAV2Y4DU5CzOsqND+fuf9w3
         BBQLh4e3MDUdyWnCNtTX/3zLQFJkxcCw5exWxJzvfnWPqntAsp/APKEJClCLw+2s5kQ2
         omiw==
X-Gm-Message-State: AOAM531Rb7icgWta6JhYxQHHzXFlltDT3abo+yIfgtrSV5eB8+4gn4rj
        dWVxM6R5iNeqsifjTMWzGlfPog==
X-Google-Smtp-Source: ABdhPJxgRM/53Q0EcYcptUpuK3pXraRfhD+RcQW2uJnjJj8TGW6xRMq1bWHZkr8id8c/2Xey2vL5Gw==
X-Received: by 2002:adf:f70f:0:b0:1f1:dfb1:ab68 with SMTP id r15-20020adff70f000000b001f1dfb1ab68mr15709197wrp.439.1647247959170;
        Mon, 14 Mar 2022 01:52:39 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id m34-20020a05600c3b2200b00380e3225af9sm14723947wms.0.2022.03.14.01.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 01:52:38 -0700 (PDT)
Date:   Mon, 14 Mar 2022 08:52:36 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: extcon: maxim,max77843: fix ports type
Message-ID: <Yi8CVJTRGy6v1CWr@google.com>
References: <20220310073258.24060-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220310073258.24060-1-krzysztof.kozlowski@canonical.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Mar 2022, Krzysztof Kozlowski wrote:

> The "ports" property can contain multiple ports as name suggests, so it
> should be using "ports" type from device graphs.
> 
> Reported-by: Rob Herring <robh@kernel.org>
> Fixes: 9729cad0278b ("dt-bindings: extcon: maxim,max77843: Add MAX77843 bindings")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> 
> ---
> 
> Hi Lee,
> 
> This is a fix for a commit in your next branch.

Yes and no.

I sent out a pull-request so that follow-up fixes can go in via their
respective trees.

> ---
>  Documentation/devicetree/bindings/extcon/maxim,max77843.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/extcon/maxim,max77843.yaml b/Documentation/devicetree/bindings/extcon/maxim,max77843.yaml
> index f9ffe3d6f957..0216ec868c3e 100644
> --- a/Documentation/devicetree/bindings/extcon/maxim,max77843.yaml
> +++ b/Documentation/devicetree/bindings/extcon/maxim,max77843.yaml
> @@ -25,7 +25,7 @@ properties:
>      $ref: /schemas/connector/usb-connector.yaml#
>  
>    ports:
> -    $ref: /schemas/graph.yaml#/properties/port
> +    $ref: /schemas/graph.yaml#/properties/ports
>      description:
>        Any connector to the data bus of this controller should be modelled using
>        the OF graph bindings specified

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
