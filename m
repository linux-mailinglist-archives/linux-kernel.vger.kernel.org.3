Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1A04CFF7F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 14:04:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242708AbiCGNE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 08:04:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242292AbiCGNE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 08:04:56 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0C748AE4E
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 05:04:01 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id p184-20020a1c29c1000000b0037f76d8b484so9248283wmp.5
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 05:04:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=pSHEpDDbP3cBBq52zYK0sNbU+pR3WMacBq6FSVuCsuM=;
        b=lEyjhp0FKvJ9cyn+Cm7Hv5psgSCRwSDD5d+n6tgI9FYAv/WsSTdc3xwTHRUAcxqtMG
         zkInt4KD4lSlbfM75JZTqp5GalPnY6ZYw0JgOFUXP0WeuklE3uYh+NMYpAvxE7CK8mql
         mHk7mTU0WQzoBV1eIMANMCjafPQ4uarYNyqf+IrCCNRX9p7SQdYZfFrC8D/a4E6pdz63
         DfNmqoUauu71RdSxPSVL/7hsGlubdCXj0326JPu4XthjhZ9p3rf3QIZgJGEiyyd4wt+0
         D3pe7c6I2li66/nlL97rigXO70zNrjhqLCQt4hGFXbd7uTxQoz6Zanwa2UeYTYxf4Ojr
         eKHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=pSHEpDDbP3cBBq52zYK0sNbU+pR3WMacBq6FSVuCsuM=;
        b=UBi7uKMyDFBsHkBJRZuZScr4xVaAEsVWAGk8rih5g64wPKGxbi5MTsK0xL1uX/2qe4
         JdIqrAA/OMR3b/tO/ZrFklZN1BvZXewHtFpT4rTMcCB9/uTGgTQpc0VerU8O6MjwBFGj
         2wei/BZgb9x3XzdGMlMkmikx5bcfuK6l3AD/hgBgk0St/r1t1PFC8kJCvwoCJC5C2NX8
         LGZCNWQnZrHBEHgGuee7ccl0sVHODWKP9jFR+O9Mu+4EHbzDzFausUpjX028hgAIazLu
         b7unIyomvfXii+E4UfR81VnSrcp3T02Tz+XAcp2E5OHiHlhGyHc2360d4yiHEkgiBFjg
         muPA==
X-Gm-Message-State: AOAM532RX1rVRDix9EVajqEMx8d12lrtbCPHbnyggRuWBafHCXkQPyME
        AeYyLnoXEeAcPMVSSkwVoiqSTQ==
X-Google-Smtp-Source: ABdhPJzLVcA7qBP2Lke70Pkrbh5ieyS9z/kxVkQ/DbMFElu7PyUeAvGDLw6bvia/bpEjh5zPHNxrBw==
X-Received: by 2002:a7b:c2aa:0:b0:389:891f:1fd1 with SMTP id c10-20020a7bc2aa000000b00389891f1fd1mr11411322wmk.138.1646658240568;
        Mon, 07 Mar 2022 05:04:00 -0800 (PST)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id f7-20020a5d4dc7000000b001f1d99e9441sm6699454wru.106.2022.03.07.05.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 05:04:00 -0800 (PST)
Date:   Mon, 7 Mar 2022 13:03:58 +0000
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
Subject: [GIT PULL] Immutable branch between MFD, SPI and DT  due for the
 v5.18 merge window
Message-ID: <YiYCvsdgG5o2DpuN@google.com>
References: <20220124082347.32747-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220124082347.32747-1-krzysztof.kozlowski@canonical.com>
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
