Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA3A542961
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 10:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbiFHIXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 04:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbiFHIV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 04:21:56 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFC6F3AD8BE
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 00:48:29 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 67-20020a1c1946000000b00397382b44f4so10664207wmz.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 00:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=lqY+yGTizo28KA0GxuLPPWRDIJPNvZCC8690vTojGfw=;
        b=rJKimGqxM9lPho0kjQMT0As4HYnbCFTaudyp28LP4beS819PzchOl4qBDzu6wfHVhD
         R/7b2ucXeGP3hrljf6RxhjU+dOHq80y2Xrs/EtV17nXhvc4FpovzQmOiD0QpDrrM02yq
         zUOTzwD4G9XGZA47M1e9Hbd75sPnAf4N7wPPYS++GeQfVxU+CtKoKijJKfKskGYmlk4w
         Iu10ozBkMGDF7dtHw0V5NsueqChUEhHQeEdvFoJ77kKZ9Vng3WEewmalzTwvhN2Iuasv
         hPRwlKg5YH3aI2k4LcgrjdAshwp8ifEcZMf3E5HJO2LFnhSlxfUbxdkpNSg4t5Y8aGSj
         UKtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=lqY+yGTizo28KA0GxuLPPWRDIJPNvZCC8690vTojGfw=;
        b=0V0rkt7iy8yt/RGElQ2mZTkSa37lO+xWmcx9jkRHtk8tZrcLFvifESiBD4vqTYEg5v
         uMdv2JsJ1d57DyX4aPHBNUBP6wZa3HVQ3uTnGHHriJyht+l1fjMWxJI/TRI6poUufNUp
         fkRtjKTkhvRl57sOI5t6BhfQKuZzvUtPzJkmQBU2Td/eVKn1XdLlJjcNB4LipumZgX9y
         CE/nL5Ba2N7Pe2KR2X+3maNI6akwMk/Ssn/B4MKGReTZgSz74urEreNNAISXO18tNLSc
         ehkpBELD9DwYPL15BtAbgalvEmvSxNDlW3z8JWxaJqeyoocHgoBl5C4dgRuqsRzNf7CO
         GC4w==
X-Gm-Message-State: AOAM531x4FkZdPgn9MISmZUoPOrhAiI9oy/3UAkAsCjP+mnvh6Q4rpcW
        3C6ETAFlirMk+pRxxi4qNYsmwQ==
X-Google-Smtp-Source: ABdhPJzX8u/vF1uMO+f6IIT0LehkLZnmEeGwTIeTTQ25oBVz6rOOKXk8eZ2rx4zRGhav0uPYaI11Ew==
X-Received: by 2002:a05:600c:3ac9:b0:397:70f8:bd65 with SMTP id d9-20020a05600c3ac900b0039770f8bd65mr62494168wms.194.1654674508274;
        Wed, 08 Jun 2022 00:48:28 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id i8-20020a05600c354800b0039c6390730bsm1060766wmq.29.2022.06.08.00.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 00:48:27 -0700 (PDT)
Date:   Wed, 8 Jun 2022 08:48:25 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Conor Dooley <mail@conchuod.ie>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Support Opensource <support.opensource@diasemi.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Steve Twiss <stwiss.opensource@diasemi.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Atul Khare <atulkhare@rivosinc.com>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 3/4] dt-bindings: mfd: convert da9063 to yaml
Message-ID: <YqBUSfyxsRpNdqob@google.com>
References: <20220606201343.514391-1-mail@conchuod.ie>
 <20220606201343.514391-4-mail@conchuod.ie>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220606201343.514391-4-mail@conchuod.ie>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 Jun 2022, Conor Dooley wrote:

> From: Conor Dooley <conor.dooley@microchip.com>
> 
> Convert the dt binding for the da9063/da9063l to yaml.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  .../devicetree/bindings/mfd/da9063.txt        | 114 ---------------
>  .../devicetree/bindings/mfd/dlg,da9063.yaml   | 132 ++++++++++++++++++
>  .../devicetree/bindings/trivial-devices.yaml  |   2 -
>  MAINTAINERS                                   |   1 +
>  4 files changed, 133 insertions(+), 116 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mfd/da9063.txt
>  create mode 100644 Documentation/devicetree/bindings/mfd/dlg,da9063.yaml

Applied, thanks.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
