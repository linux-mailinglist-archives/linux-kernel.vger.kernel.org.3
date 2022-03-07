Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 072B54CF516
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 10:24:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236766AbiCGJYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 04:24:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236844AbiCGJXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 04:23:01 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF4B65433
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 01:21:15 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id p9so22117328wra.12
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 01:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Z++oIgLafXSWYzcuMvzuaJFII2S7/dNacUD+5s9e3lE=;
        b=hzpRNCmwIRvl2PnTInjpN07IaDzfCRSiYLTekTpM7viCd/oAtBLz8ouI1E1FZY6mzi
         mQbVv6MwjNZ2DULoEZPEljY3khTdAthfULL+9jzQbOHhw+yDesW2p6yB+bvAiTDM2d42
         JTdP5Q6cP/6Y9a3kqnFMW2oyknnYJpPZLyLKhUfMBuSKqOOaX9jggDsSIU1XJnQ8WwUo
         RSyjyStPWatCsod3QHifMR8cGWDmDI5Vhl2Ml3mKxwhW9Zy/fXFe5XEk3tfrOP4ychRY
         HwORcN7Y2BdKO6bnGag7+ya29Y6SaXwPhVXGslEigp++QFj7ivTAS63NQQVVG+1rDBW5
         rEdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Z++oIgLafXSWYzcuMvzuaJFII2S7/dNacUD+5s9e3lE=;
        b=dj0ki+FuBOi35XxgnOkzTnXd6qBiYPwf+jd8fGJwrcPjrXBJOKlnjnMSE0QSUy6rWs
         AAF8qlyoenY6O0+3LHzPmO0O2RKzqg2SaJ9Tpt5JYmMFfwe3QpOoMoKTrb3aGJvdP8p5
         CtS6ic267/l6PKK79kiyAgbQgiK+P/njhCrXv0TDQWWlBPrkqGpvOa7a5vyxf9pZoq0d
         jLDofKk74LwwyNfuCY2HrMhafY0hkS0iFl99/LPVgSmFPDnG/Q50u3nwrMHLt/TvGfYc
         w4TJU0eKwTCGHnOtEVRaa9fm0UYALiHXbb9/7j9rZd2vgqxLa/igyNWFopqX5JyBWUmG
         THhw==
X-Gm-Message-State: AOAM531peq+4fDuUQpYyWi6Azq/j36nHO5zXDw5cQUbgpxQH0tYPKjvG
        CalkPlSk5iu4at56P2XnfA4yCg==
X-Google-Smtp-Source: ABdhPJx3m1IKG9MxT8EF/vts7cSLbTdPwiNTjrx0c6TS4KkTZxh1HAKynTCLgkerHctOra4RsLvroA==
X-Received: by 2002:a5d:59ab:0:b0:1e3:2576:215 with SMTP id p11-20020a5d59ab000000b001e325760215mr7758961wrr.496.1646644874308;
        Mon, 07 Mar 2022 01:21:14 -0800 (PST)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id o7-20020a5d6707000000b001f067c7b47fsm15297609wru.27.2022.03.07.01.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 01:21:13 -0800 (PST)
Date:   Mon, 7 Mar 2022 09:21:11 +0000
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
Subject: Re: [PATCH v6 1/4] spi: dt-bindings: samsung: convert to dtschema
Message-ID: <YiXOhx+VGyn/koTC@google.com>
References: <20220124082347.32747-1-krzysztof.kozlowski@canonical.com>
 <20220124082347.32747-2-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220124082347.32747-2-krzysztof.kozlowski@canonical.com>
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

> Convert the Samsung SoC (S3C24xx, S3C64xx, S5Pv210, Exynos) SPI
> controller bindings to DT schema format.
> 
> The conversion also drops requirement from providing controller-data and
> its data for each of SPI peripheral device nodes.  The dtschema cannot
> express this and the requirement is being relaxed in the driver now.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
> Acked-by: Pratyush Yadav <p.yadav@ti.com>
> ---
>  .../bindings/soc/samsung/exynos-usi.yaml      |   2 +-
>  .../spi/samsung,spi-peripheral-props.yaml     |  33 ++++
>  .../devicetree/bindings/spi/samsung,spi.yaml  | 187 ++++++++++++++++++
>  .../bindings/spi/spi-peripheral-props.yaml    |   1 +
>  .../devicetree/bindings/spi/spi-samsung.txt   | 122 ------------
>  MAINTAINERS                                   |   2 +-
>  6 files changed, 223 insertions(+), 124 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/spi/samsung,spi-peripheral-props.yaml
>  create mode 100644 Documentation/devicetree/bindings/spi/samsung,spi.yaml
>  delete mode 100644 Documentation/devicetree/bindings/spi/spi-samsung.txt

Applied, thanks.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
