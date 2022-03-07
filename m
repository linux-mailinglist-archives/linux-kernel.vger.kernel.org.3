Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B85104CFF63
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 14:00:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242684AbiCGNBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 08:01:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240325AbiCGNBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 08:01:51 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A9D8A6C2
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 05:00:56 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id p9so23134041wra.12
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 05:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=pSHEpDDbP3cBBq52zYK0sNbU+pR3WMacBq6FSVuCsuM=;
        b=LCuu2kJ2WK3apjNwfJaaGKw3LfWQxq3nVjKl4XDn7Zd/ZudKYJlRYR6C0RsPt/mC4i
         Ci3QvmMl8EGMpHDTBjYa8ojuUgfUd+kyP2WqDIeIgLTDgSV6td5MCe3Z5/jsf9iruK+T
         VQ/7Cdzpn0qGtDTC8PPsCqnFoXxH/HwVguTAlkQDZZfXg4+btoyaqlDy6OCsaQG7M8/g
         SLfhrDqZfdBr73m+NnDep1iIv5uPI4mJJ9hP5SkNhb3O0SaR5wf1wsc2L8VZaoKpL35D
         nzTo5ycCw9N9Mwg3vZ3ib3MEavB5YTwHx6D+l/0IVBj9dI7ZdkeKQF2WmJmtlJtcFLNH
         ckfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=pSHEpDDbP3cBBq52zYK0sNbU+pR3WMacBq6FSVuCsuM=;
        b=V+g172jl9Q9FhfUkSo5wPyX/xGvUQEOE9PXOQAdAh8MSFy39LIohfhOpzqsYZlJbgk
         PdIOl6VkotJQmgLWyUO0qndCvcfJL4vi12vODFIyvSr5buuspfEMwtV/8lhOClX6GbMe
         KD46i4pybgJX1agTf8cMUwZ4Rk8a5zmEWMr/Ld5pVJzP9v2kxm9FvNAVBFvcn8ggN9Wt
         unA/snmTA+XR6eQtE0yb4eUY9/c0XvxzeYBIqjJsJ9GbtdiZuP/oFm8WB7L/86Mijs8S
         V4ceC6w2NDZH6gdteZw4N6CEULHQLiHuSHqYaleeTn8t3w5cqfre8gIuB+mK7Pll6i13
         reeQ==
X-Gm-Message-State: AOAM532vNSyN5uyf8b/Gu21J/0ThpfuRb2JTjTk3AN9RHi9T0pek62Ck
        AlrCy0Eo4NyNQboX9FhcrMVLxg==
X-Google-Smtp-Source: ABdhPJzQ2zK+BHalBN2ZGLsmib6HHXicnCDWmEggfQLtbjc0cgr3mMIlGK04NE7s/VBEZJTjHJu/uQ==
X-Received: by 2002:a05:6000:1ac8:b0:1f1:f808:fb5b with SMTP id i8-20020a0560001ac800b001f1f808fb5bmr3916828wry.560.1646658055340;
        Mon, 07 Mar 2022 05:00:55 -0800 (PST)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id q125-20020a1c4383000000b003899720641dsm6821115wma.30.2022.03.07.05.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 05:00:54 -0800 (PST)
Date:   Mon, 7 Mar 2022 13:00:53 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Javier Martinez Canillas <javier@dowhile0.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] regulator/mfd: dt-bindings: maxim,max77802:
 convert to dtschema
Message-ID: <YiYCBdT8bpRrW/gx@google.com>
References: <20220215075344.31421-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220215075344.31421-1-krzysztof.kozlowski@canonical.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enjoy!

The following changes since commit e783362eb54cd99b2cac8b3a9aeac942e6f6ac07:

  Linux 5.17-rc1 (2022-01-23 10:12:53 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-spi-dt-v5.18

for you to fetch changes up to 172e611b54e813c49a35b6b74bccaa99f27bf566:

  dt-bindings: mfd: maxim,max77802: Convert to dtschema (2022-03-07 12:55:59 +0000)

----------------------------------------------------------------
Immutable branch between MFD, SPI and DT  due for the v5.18 merge window

----------------------------------------------------------------
Krzysztof Kozlowski (13):
      dt-bindings: extcon: maxim,max77843: Add MAX77843 bindings
      regulator: dt-bindings: maxim,max77843: Add MAX77843 bindings
      dt-bindings: mfd: maxim,max77843: Add MAX77843 bindings
      MAINTAINERS: mfd: Cover MAX77843 by Maxim PMIC/MUIC for Exynos boards entry
      spi: dt-bindings: samsung: Convert to dtschema
      mfd: dt-bindings: google,cros-ec: Reference Samsung SPI bindings
      mfd: dt-bindings: google,cros-ec: Fix indentation in example
      spi: s3c64xx: Allow controller-data to be optional
      dt-bindings: power: supply: maxim,max14577: Convert to dtschema
      regulator: dt-bindings: maxim,max14577: Convert to dtschema
      dt-bindings: mfd: maxim,max14577: Convert to dtschema
      regulator: dt-bindings: maxim,max77802: Convert to dtschema
      dt-bindings: mfd: maxim,max77802: Convert to dtschema

 .../devicetree/bindings/extcon/maxim,max77843.yaml |  40 +++++
 .../devicetree/bindings/mfd/google,cros-ec.yaml    |  31 ++--
 Documentation/devicetree/bindings/mfd/max14577.txt | 147 ----------------
 Documentation/devicetree/bindings/mfd/max77802.txt |  25 ---
 .../devicetree/bindings/mfd/maxim,max14577.yaml    | 195 +++++++++++++++++++++
 .../devicetree/bindings/mfd/maxim,max77802.yaml    | 194 ++++++++++++++++++++
 .../devicetree/bindings/mfd/maxim,max77843.yaml    | 144 +++++++++++++++
 .../bindings/power/supply/maxim,max14577.yaml      |  84 +++++++++
 .../devicetree/bindings/regulator/max77802.txt     | 111 ------------
 .../bindings/regulator/maxim,max14577.yaml         |  78 +++++++++
 .../bindings/regulator/maxim,max77802.yaml         |  85 +++++++++
 .../bindings/regulator/maxim,max77843.yaml         |  65 +++++++
 .../bindings/soc/samsung/exynos-usi.yaml           |   2 +-
 .../bindings/spi/samsung,spi-peripheral-props.yaml |  33 ++++
 .../devicetree/bindings/spi/samsung,spi.yaml       | 187 ++++++++++++++++++++
 .../bindings/spi/spi-peripheral-props.yaml         |   1 +
 .../devicetree/bindings/spi/spi-samsung.txt        | 122 -------------
 MAINTAINERS                                        |   9 +-
 drivers/spi/spi-s3c64xx.c                          |  14 +-
 19 files changed, 1136 insertions(+), 431 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/extcon/maxim,max77843.yaml
 delete mode 100644 Documentation/devicetree/bindings/mfd/max14577.txt
 delete mode 100644 Documentation/devicetree/bindings/mfd/max77802.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/maxim,max14577.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/maxim,max77802.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/maxim,max77843.yaml
 create mode 100644 Documentation/devicetree/bindings/power/supply/maxim,max14577.yaml
 delete mode 100644 Documentation/devicetree/bindings/regulator/max77802.txt
 create mode 100644 Documentation/devicetree/bindings/regulator/maxim,max14577.yaml
 create mode 100644 Documentation/devicetree/bindings/regulator/maxim,max77802.yaml
 create mode 100644 Documentation/devicetree/bindings/regulator/maxim,max77843.yaml
 create mode 100644 Documentation/devicetree/bindings/spi/samsung,spi-peripheral-props.yaml
 create mode 100644 Documentation/devicetree/bindings/spi/samsung,spi.yaml
 delete mode 100644 Documentation/devicetree/bindings/spi/spi-samsung.txt

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
