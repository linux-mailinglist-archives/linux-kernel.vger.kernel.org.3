Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 649E7513176
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 12:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244401AbiD1KqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 06:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbiD1KqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 06:46:00 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 533E08567E
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 03:42:46 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id r13so8716362ejd.5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 03:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kwjgvioiZr4f3+nty2OH/Bz3f+qCMBZPd8nkPdtCCJQ=;
        b=W3R6oBOTLjccgM5ecO5iHcRS8E1sV4vZyaLkM4jZh39SH1IbAkb+mmjtXoglfyaoxz
         q8PEpngIMc0rmE2FMscZ8ayFtLG2NBg8WUrvJk8dKeJ5b14QrHiSdggQaeDJ/cs48B3o
         X662ojI+GR14RSRPiaoyzlPf+fWkbSMH14PXxikOzbCD9w2v3rpibIWYzjN36M4/4KlG
         q3VuYwf4f9kxkoc6J9Cmk0izgrmhiUjVVK7N7ubQB3DbAUEGpkfOUWXc0l07JSt8ntLh
         xb/+H3QBwAjotSoFhPqIoK/1Co8GLX9ed7KG2dzp6qdMR8GRbDARGj+6vGzJloiFPaOv
         m6WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kwjgvioiZr4f3+nty2OH/Bz3f+qCMBZPd8nkPdtCCJQ=;
        b=QLYadcrYuz4gUDvm2uCbBlo10bs4zSZoNXpNg9rXeRIPVJThHkZAP+pNKaqqi9eac2
         o3BzDrMT1nyrzMDiLNCUrLHnB2ybZF4K9nDLCDt88BGDeYEhDZvOa4ezPsjPI7sY86oW
         t3dDaaZKH8Qm010oPTM9P+V7MtXi3RPU/stfbd5gyXkJoRpNYCC1pz5S3v7RhD2DRkam
         nOF4QXY8vKWKZ95zEiCopNu2JFo1d5WqSBeTFHh9aOzUrQjq8W9OVGWC/iETa9xkK2qO
         ciEvfezTGqC3IatTMjr0Vd7pP8pHy0SQxNSZXEt7cFG3kNUudX/stSDQYn2VU75pt1dE
         tJAg==
X-Gm-Message-State: AOAM531g7k7+XdmIJbwnGgX9V5hrJTgISJ7y6PtBQtJEFP+SCckgJ82C
        Ex8F87NNLd0GMiSiuH2ZAfv/gA==
X-Google-Smtp-Source: ABdhPJxlGW8RGZ6ChzgQM3jgh04UyFVQQHlpvCXeOlkc/P1f82WR4lQix0wW1VfXQcWdrgCaFQRBmw==
X-Received: by 2002:a17:907:1623:b0:6e8:8678:640d with SMTP id hb35-20020a170907162300b006e88678640dmr31126310ejc.189.1651142564876;
        Thu, 28 Apr 2022 03:42:44 -0700 (PDT)
Received: from localhost.localdomain (cpc78119-cwma10-2-0-cust590.7-3.cable.virginm.net. [81.96.50.79])
        by smtp.gmail.com with ESMTPSA id mf1-20020a1709071a4100b006f39f556011sm4982583ejc.125.2022.04.28.03.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 03:42:44 -0700 (PDT)
From:   Caleb Connolly <caleb.connolly@linaro.org>
To:     caleb.connolly@linaro.org, Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc:     Amit Pundir <amit.pundir@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>
Subject: [PATCH v2 0/6] power: supply: introduce support for the Qualcomm smb2 charger
Date:   Thu, 28 Apr 2022 11:42:27 +0100
Message-Id: <20220428104233.2980806-1-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a driver for the Qualcomm PMI8998/PM660 Switch-Mode Battery Charger.
This is the second generation SMB charger, and replaces the previous
SMBB hardware found in older PMICs.

This driver provides basic support for initialising the hardware,
configuring the USB input current limit and reporting information about
the state of the charger. Features like type-c dual role support and OTG
switching will be added in future patches.

This patch series depends on my previous series adding support for
the Round Robin ADC which is used for reading the USB voltage and
current, it can be found here:
https://lore.kernel.org/linux-arm-msm/20220323162820.110806-1-caleb@connolly.tech/

Changes since v1:
 * Rename the driver to pmi8998_charger
 * Drop unnecessary (and very broken) mutex
 * Rework the driver based on feedback to v1
 * Fix some minor bugs and improve Automatic Input Current Limit support

---
Caleb Connolly (6):
  power: supply: add Qualcomm PMI8998 SMB2 Charger driver
  arm64: dts: qcom: pmi8998: add charger node
  arm64: dts: sdm845-oneplus: enable pmi8998 charger
  arm64: dts: qcom: sdm845-db845c: enable pmi8998 charger
  arm64: dts: qcom: sdm845-xiaomi-beryllium enable pmi8998 charger
  dt-bindings: power: supply: qcom,pmi8998-charger: add bindings for
    smb2 driver

 .../power/supply/qcom,pmi8998-charger.yaml    |   82 ++
 arch/arm64/boot/dts/qcom/pmi8998.dtsi         |   17 +
 arch/arm64/boot/dts/qcom/sdm845-db845c.dts    |   18 +
 .../boot/dts/qcom/sdm845-oneplus-common.dtsi  |    4 +
 .../dts/qcom/sdm845-oneplus-enchilada.dts     |    4 +
 .../boot/dts/qcom/sdm845-oneplus-fajita.dts   |    4 +
 .../boot/dts/qcom/sdm845-xiaomi-beryllium.dts |   13 +
 drivers/power/supply/Kconfig                  |    9 +
 drivers/power/supply/Makefile                 |    1 +
 drivers/power/supply/qcom_pmi8998_charger.c   | 1070 +++++++++++++++++
 10 files changed, 1222 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/qcom,pmi8998-charger.yaml
 create mode 100644 drivers/power/supply/qcom_pmi8998_charger.c

-- 
2.36.0

