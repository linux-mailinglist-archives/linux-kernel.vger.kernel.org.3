Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC8C14CFF6D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 14:02:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235999AbiCGNDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 08:03:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240089AbiCGND3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 08:03:29 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47DF2237D7
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 05:02:35 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id u1so23126942wrg.11
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 05:02:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=pSHEpDDbP3cBBq52zYK0sNbU+pR3WMacBq6FSVuCsuM=;
        b=xaD0uy3OaS2SthEhwpI13bvsD4t81TogWIb7k5vqCrTOSEylRf4LTLpNYM10hqcfIy
         amhMsB6nmZLjTLtmCRB0du+N12lEviwtRcdS5ul+qPWrVrAPJAV3M4IqsVHt4WbYHjVd
         OO95ewCkhISPExCZd6cmzRDZqY2y3hM6fp/E1zK4P/Q+6roTZa7WcTTqUpLKZ0cgmesS
         hQMOvs/QuU+XA3LvDYMr/ZByyzyCR5dN4HcN7MZ/LRQKn6Fxh0vG7ualFmIPX22wyLTR
         kp+HDgghHM6Db0X76t2sHGLQ7S7CCMHk5cetlJgAtGy65brquPO1TpC9yB+1GoIQLTuW
         8xLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=pSHEpDDbP3cBBq52zYK0sNbU+pR3WMacBq6FSVuCsuM=;
        b=K1Pl4Hi+k6lqx9xDTdneSCp7ucqDbwe2cml9PLfogqAFlZVc638FYNwLW64R4Nzj9g
         Ve46KBzQ7KjY2PjD2qhVfbYdTKRpUuZkL/Q8M2qzKmv1Q6K1xCkBcJa1/Tn135EBJS04
         MPtu8X1MdLmOuFK8f7W/EU9hCKEfy9q5dyEqWr+NLQLJ3NuMzf2CFnllkfFK0DIMf67+
         sgvMXe4OQ3hsC/BJ3oiq3LT3/JLKkMl9CXb2hZXT1cnyUy+Jg2NSY4jKEZisDEBuKoDF
         ezRdnZKsOCvuf/wuyGHZRMvjFI4qeGbAyKOoBbBW9eAZE4qYP2LE+I46PdAtzWQorjeo
         vnlg==
X-Gm-Message-State: AOAM531WKqctsjNlmrddbfzAedYKQmWcrTcEXTR/2JPw73VhM5gQAivA
        9aztUoTOTg8+cNaAR1co3Z0vrKcHUgQ+mQ==
X-Google-Smtp-Source: ABdhPJwFm2cCjjXxy2SN2JW1Q88+o10LH4UWSkDfPpFyumvyJ9d+kwhochV9n4mGtrAnH7VGmZxiwA==
X-Received: by 2002:adf:e44b:0:b0:1f0:250a:d3ef with SMTP id t11-20020adfe44b000000b001f0250ad3efmr8153721wrm.402.1646658153858;
        Mon, 07 Mar 2022 05:02:33 -0800 (PST)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id p18-20020adfba92000000b001e4ae791663sm11883954wrg.62.2022.03.07.05.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 05:02:33 -0800 (PST)
Date:   Mon, 7 Mar 2022 13:02:31 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [GIT PULL] Immutable branch between MFD, SPI and DT  due for the
 v5.18 merge window
Message-ID: <YiYCZ31RPv77D2Nr@google.com>
References: <20220215074759.29402-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220215074759.29402-1-krzysztof.kozlowski@canonical.com>
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
