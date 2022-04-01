Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E379F4EFB95
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 22:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352520AbiDAU3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 16:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352905AbiDAU25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 16:28:57 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE2B98FE4D
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 13:27:05 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id a17so4256631edm.9
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 13:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W/JwoXAcjqpUeNN5rrXlo11fHlP+fYByEFJ34EyPDQ4=;
        b=z4d9SYyBZioII/u1DVvwwX/yVHWqJ2PqRyvTNe9OXAF2qqCQ4HNspqkY1qfLlXZkzo
         QvE3agotx83Ip2w4aR0v8q1GU42qBmma10TUNG1rW9e/0wZejTSuXuj6NeAuzD2W1VDb
         LGAeg0NguiK1kOapyXFvQNiO2xVw4so17vgrV7s9asQc/aZdZHvOsfOxvCn5dqfxBFbE
         AZfXu/oOBPXM9myX/vlMZanmY500YaU+9IMzt5E7b95g9G/wLG5E45D6/kkt14UEGRvJ
         KRI7OXcSImCnqqL++zh7JBOS09oeYcGe0NHAkv7fY5v9NJaP7M909M1MkLB6xFN02tc3
         LVPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W/JwoXAcjqpUeNN5rrXlo11fHlP+fYByEFJ34EyPDQ4=;
        b=z3UYKVCiKyySpPa8z4RuSlM13nsZNwfgh7og83PUWrtze7W3/9OaYRNHo3R/8/52Ul
         +dgqKgE9SopvEZHLA6mSSTzkkXBIKinLlFUVDbCPGeW1GM5nmZluZv54O4DAjgRVlrGU
         i3G9XzK4Y5xP1VtFKHkcQ3guKU9beIL97sVQRR3QiH6D/hcSb0MKqx6x6ENEiMkWn2MA
         2oNljTCDdfbs/C0046Lc+G4uclVLcc1xfbr+wJsG4lZP5eezwfCduoBb5g9cgQdKKdPD
         OTIcdeg/RHVlvKEScOmPGLnK158BMjvfB8R4lKK+W5rJZU5qP3m+6FIh7VRssORwk7uO
         WDsA==
X-Gm-Message-State: AOAM531nQGCrgvweLF5dVcblnYXJ2c0QrzsSZdBTEV2aiU+HE+gWpqSh
        dQWz2ioZDUMKTELE3O9lqzVCHA==
X-Google-Smtp-Source: ABdhPJx9nANjqq4+8ixZjJbQGQrULdad43yJO+knWbgLK8q95XKiW1gXmt4aZK9nCD2zWU5MqzIgQA==
X-Received: by 2002:aa7:c30f:0:b0:419:2af:4845 with SMTP id l15-20020aa7c30f000000b0041902af4845mr22948828edq.296.1648844824221;
        Fri, 01 Apr 2022 13:27:04 -0700 (PDT)
Received: from localhost.localdomain (cpc78119-cwma10-2-0-cust590.7-3.cable.virginm.net. [81.96.50.79])
        by smtp.gmail.com with ESMTPSA id k14-20020a50e18e000000b0041b6f23f7f6sm1619346edl.22.2022.04.01.13.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 13:27:03 -0700 (PDT)
From:   Caleb Connolly <caleb.connolly@linaro.org>
To:     caleb.connolly@linaro.org, Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc:     Amit Pundir <amit.pundir@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>
Subject: [PATCH 0/6] power: supply: introduce the Qualcomm smb2
Date:   Fri,  1 Apr 2022 21:26:37 +0100
Message-Id: <20220401202643.877609-1-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a driver for the Qualcomm PMI8998/SDM660 Switch-Mode Battery Charger
"2". This replaces the previous SMBB hardware found in older PMICs.

This driver provides basic support for initialising the hardware,
configuring the USB input current limit and reporting information about
the state of the charger. Features like type-c dual role support and OTG
switching will be added in future patches.

This patch series depends on my previous series adding support for
the Round Robin ADC which is used for reading the USB voltage and
current, it can be found here:
https://lore.kernel.org/linux-arm-msm/20220323162820.110806-1-caleb@connolly.tech/

---
Caleb Connolly (6):
  power: supply: add Qualcomm SMB2 driver
  arm64: dts: qcom: pmi8998: add smb2 node
  arm64: dts: sdm845-oneplus: enable smb2
  arm64: dts: qcom: sdm845-db845c: enable smb2
  arm64: dts: qcom: sdm845-xiaomi-beryllium enable smb2
  dt-bindings: power: supply: qcom,smb2: add bindings for smb2 driver

 .../bindings/power/supply/qcom,smb2.yaml      |  68 ++
 arch/arm64/boot/dts/qcom/pmi8998.dtsi         |  15 +
 arch/arm64/boot/dts/qcom/sdm845-db845c.dts    |  18 +
 .../boot/dts/qcom/sdm845-oneplus-common.dtsi  |   4 +
 .../dts/qcom/sdm845-oneplus-enchilada.dts     |   4 +
 .../boot/dts/qcom/sdm845-oneplus-fajita.dts   |   4 +
 .../boot/dts/qcom/sdm845-xiaomi-beryllium.dts |  14 +
 drivers/power/supply/Kconfig                  |   9 +
 drivers/power/supply/Makefile                 |   1 +
 drivers/power/supply/qcom_smb2.c              | 930 ++++++++++++++++++
 10 files changed, 1067 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/qcom,smb2.yaml
 create mode 100644 drivers/power/supply/qcom_smb2.c

-- 
2.35.1

