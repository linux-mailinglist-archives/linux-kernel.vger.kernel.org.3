Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1EB64710D4
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 03:22:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244232AbhLKC0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 21:26:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243779AbhLKC0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 21:26:11 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30B9FC0617A2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 18:22:35 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id g14so34521594edb.8
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 18:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BN1rqnmoBfuCzzscvm3YOnK3Hq7APTJunkR2e6AyI44=;
        b=OlOB76TD4cnwKGMSNsqhD27bIGeNBDINaYaPIW606KZgbr4YcpmhVQpRZ5i7HoU25f
         /gI0gVIIVCFayaXW5CeZBZo5k+GtXYQ2D/y3h5WAD9MrExseetqHU1+3zGzcOlQoLR0P
         zanBl3z97aC2zyy9oQ3rUdTV9mxpR9uZ4NGcGgkGRM9vDAvtYb+f4gHC4adV+Bdo8ZF1
         m9LAsszA/U6mjYJH2ySLjicW6cGh+3w8wLo/IiHWpKvQL1zmu7tabwkuHSt4zKfCorhr
         Fq9JUc3griRTifpQN93SZEkgnsObl1CFUXqoeWhXQ0nB868+o4DL30s3RXlVGjVz6xKS
         vh2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BN1rqnmoBfuCzzscvm3YOnK3Hq7APTJunkR2e6AyI44=;
        b=GjiXyqmfjO2A3ix4dOOxMpaCG72wIMezDlyLwC9z/o9P3UUKqND0gc8TOQ3AoPFE6W
         OANOd14AiIpvlvHMiBK3pOuB/8AJ3/8VktLKpPsI/Is8omPaIgKiJZ+YmIgZ/7IJwlbf
         BLHLS3MDBTDh0PfgkhEgrrTNN+8vDyhRlY8UPHY6vPswftOmzAjhyRxplkvOLcGrQ/MM
         K7pySBLrr0FSlqn5mzz/i/aXbWVlopFC+p3UMzqZEl5hB1miOz3peDSm2xvtLmF6PDrM
         UH9284bfs0ixMa/L4iL+L4roIdBvsC8o8YMNPC8gew/ssNj/GOcyjgYKfCHyaKVwrHD8
         gRng==
X-Gm-Message-State: AOAM532OX2PNzqeV0xouYagPFNZb2a98j/VU35xilSqgvI+UiOcnpvMu
        GPdcVfGp27017yiaXUJWY0nHIwXTkNw4Xw==
X-Google-Smtp-Source: ABdhPJyIY1FSnIyvZJddEk0bFdLO16sKK4IFXhAd18ZGe1ELTgmf+D8v0J1Iu5Q7EEzNY4Q7QN5HPQ==
X-Received: by 2002:a17:907:2bd0:: with SMTP id gv16mr27304054ejc.121.1639189353667;
        Fri, 10 Dec 2021 18:22:33 -0800 (PST)
Received: from lion.localdomain (cpc78119-cwma10-2-0-cust590.7-3.cable.virginm.net. [81.96.50.79])
        by smtp.gmail.com with ESMTPSA id s2sm2449424ejn.96.2021.12.10.18.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 18:22:33 -0800 (PST)
From:   Caleb Connolly <caleb.connolly@linaro.org>
X-Google-Original-From: Caleb Connolly <caleb@connolly.tech>
To:     caleb.connolly@linaro.org, sumit.semwal@linaro.org,
        amit.pundir@linaro.org, john.stultz@linaro.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Caleb Connolly <caleb@connolly.tech>
Subject: [PATCH 0/7] iio: adc: introduce Qualcomm SPMI Round Robin ADC
Date:   Sat, 11 Dec 2021 02:22:17 +0000
Message-Id: <20211211022224.3488860-1-caleb@connolly.tech>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RRADC is responsible for reading data about the current and
voltage from the USB or DC in jacks, it can also read the battery
ID (resistence) and some temperatures. It is found on the PMI8998 and
PM660 Qualcomm PMICs.

The RRADC has to calibrate some ADC values based on which chip fab
the PMIC was produced in, to facilitate this the patch
("mfd: qcom-spmi-pmic: expose the PMIC revid information to clients")
exposes the PMIC revision information as a struct and registers it
as driver data in the Qualcomm SPMI PMIC driver so that it can be 
read by the RRADC.

Caleb Connolly (7):
  mfd: qcom-spmi-pmic: expose the PMIC revid information to clients
  dt-bindings: iio: adc: document qcom-spmi-rradc
  iio: adc: qcom-spmi-rradc: introduce round robin adc
  arm64: dts: qcom: pmi8998: add rradc node
  arm64: dts: qcom: sdm845-oneplus: enable rradc
  arm64: dts: qcom: sdm845-db845c: enable rradc
  arm64: dts: qcom: sdm845-xiaomi-beryllium: enable RRADC

 .../bindings/iio/adc/qcom,spmi-rradc.yaml     |   54 +
 arch/arm64/boot/dts/qcom/pmi8998.dtsi         |    8 +
 arch/arm64/boot/dts/qcom/sdm845-db845c.dts    |    4 +
 .../boot/dts/qcom/sdm845-oneplus-common.dtsi  |    4 +
 .../boot/dts/qcom/sdm845-xiaomi-beryllium.dts |    4 +
 drivers/iio/adc/Kconfig                       |   13 +
 drivers/iio/adc/Makefile                      |    1 +
 drivers/iio/adc/qcom-spmi-rradc.c             | 1020 +++++++++++++++++
 drivers/mfd/qcom-spmi-pmic.c                  |  103 +-
 include/soc/qcom/qcom-pmic.h                  |   58 +
 10 files changed, 1216 insertions(+), 53 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/qcom,spmi-rradc.yaml
 create mode 100644 drivers/iio/adc/qcom-spmi-rradc.c
 create mode 100644 include/soc/qcom/qcom-pmic.h

-- 
2.34.1

