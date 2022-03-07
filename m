Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1B844CFF8A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 14:05:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242751AbiCGNFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 08:05:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242746AbiCGNFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 08:05:44 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2E858B6E0
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 05:04:49 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id l1-20020a05600c4f0100b00389645443d2so6397145wmq.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 05:04:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=pSHEpDDbP3cBBq52zYK0sNbU+pR3WMacBq6FSVuCsuM=;
        b=XLyeiwVhjuSvm1H+7sPNOkIjnPIAoE356QmfluREdPanjLa9kWBaBs2JYW7nOTq1Vh
         iSJtkImjNyl39RpfBnBzbW0rwZoy6dSsNoN7O2f8MBzcNfPylMRGd9oF5InNQ6abEpxm
         aAykJ5f1VkvH/FzSfL0CFfEVInTEGsJjS2KFVSAgvkHGWE7RFkFEIK20e5yM3HwCwCHx
         IBv783hbYl7adH824wYQFuDsFiDUKSRQUGD4/jXaxxQXKNBVHpy+ifUETAd2zTN0X4sY
         vgiN6+NeTNAiC4XQizrU8ixcbl0gwBlUyK/12MQXoLMEXJdsqtYCiqbxnaCqV6c0m3Fl
         11gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=pSHEpDDbP3cBBq52zYK0sNbU+pR3WMacBq6FSVuCsuM=;
        b=ixEjOcNMP6U2hlOJI5xFUf+Qc2L7ZkxRLNmXdrRRkaHQuT+JUT1o+LOsGoxLGS9zpZ
         SPA2nUpkFe66eam+RE8/Ojg6tW28n//O7A7HQZ2Y13QG9v2jUOfmlodb27UPqa36I01R
         JCREbE5q6A06g2LzlRYkoteYVtj5Pf4tVCFpjyMIXzh0JO89q4G3tv1AfzQKmTDZW+b1
         VQbl7mShcsdMcSBf6Gws83LJCgyVZyXUGwPnpcrSgQlzXziw49X4bivlthGEwI0EbZAl
         YYXKH23zvQWzd6UIMmSyUUOozhyCLdaBv2FlKXO5pYMMjTOmPuTuAlHNg58PGy657cu8
         A13Q==
X-Gm-Message-State: AOAM533+Owe8caZhS6u7fu7dVv7Uk12I6NgwEbejh1BrLxkF9Sc7eSNP
        RNhdrHrt6yNUVY5FJN5DUcGdFX3AHN1iIg==
X-Google-Smtp-Source: ABdhPJznWFey3I79lvfFbj3YIKguTh07jov3yA4uNxLJ2MAttWncbN2J1Y5NWXWQkl4klHMXxvXevw==
X-Received: by 2002:a05:600c:4307:b0:389:4f8f:f189 with SMTP id p7-20020a05600c430700b003894f8ff189mr9115530wme.29.1646658287807;
        Mon, 07 Mar 2022 05:04:47 -0800 (PST)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id n15-20020a05600c4f8f00b003842f011bc5sm16608794wmq.2.2022.03.07.05.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 05:04:47 -0800 (PST)
Date:   Mon, 7 Mar 2022 13:04:45 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [GIT PULL] Immutable branch between MFD, SPI and DT  due for the
 v5.18 merge window
Message-ID: <YiYC7eYx2SpPILyl@google.com>
References: <20220111174805.223732-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220111174805.223732-1-krzysztof.kozlowski@canonical.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
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
