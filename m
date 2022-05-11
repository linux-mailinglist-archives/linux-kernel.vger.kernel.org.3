Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC8A6523FA4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 23:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241211AbiEKVsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 17:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348310AbiEKVr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 17:47:58 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A0C236177;
        Wed, 11 May 2022 14:47:57 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id v4so4231139ljd.10;
        Wed, 11 May 2022 14:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tpq78z7nWFe4ZKKiz6GWvzQIHX8Dovi2d5uetwTdDd8=;
        b=f4aZIptAOWOHb9DzCRaYkVOSBAUbJaHFT6MFy51oTsjLlCJV+nNyAMtospGOl5QbGw
         JxAa4s+u0vFOm6oOpAT3irNylPPiO8NXbZU80zsfYB1BKdVyklJ69oma2ejcBWwGITyU
         P4MW3rLpMB9+kJ3EzL4aPM5SP+7iDYuz65rkmu0Gwg0+n87ytgy8YIeeQFwV18bKIoPn
         NjIe/Pjre1Va/AtQoTgF7pHb36eh8+JTFmBydb9YxDvB6OAFRPQUOq7Lub2ZjBswhgvd
         6vPalC/q1fHKgwfTnbqdhCvzCZkFmLGOdZAlAREo64jg4i21yKZoUrBRsXqHc8mmukl2
         ExPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tpq78z7nWFe4ZKKiz6GWvzQIHX8Dovi2d5uetwTdDd8=;
        b=jnz8yW+nL5KwKlHQKKTt7EhkdZQi9SQ8OHkcUyAmPk74TocSGpsLn0omVov8u0Fk0i
         iRuXa3fsTwtOLk0c4dqgc51bltuGIhBr0crvSq1+vkfIfkXbJ9tA/YwS4/EEzAZihaWH
         WG7LCTXxF18wMw4gHMqdMOxwyBMaz1TAndJVrXWOoUkNTM/lNxgeNNQmdlR5sDbBMyul
         NOiS59OYswka2I6CCmsm6KCQ8hkfcLUH0wGVzNSYk0BgUwFFitZOth3lRXuhWLNQoyUJ
         nia2cktCy+4ONBHlaxLxpYxHjLPibF4u8QhgabaFAkWNQ0poqE4qmYyG4QIfsBCdlTPn
         2eFQ==
X-Gm-Message-State: AOAM531ABvtiSwlRiLVdeVcRmjJhRQSvCek3EXzYv+qfbJw/qiSNxRPP
        ILkFNLlQjfxziqQ/rcS2b/ontKb1AGMCnA==
X-Google-Smtp-Source: ABdhPJy5ZPgQwzrJxP0PWwe991tP4tHIUXqxAbTeNbAFBQIsoie+C0H8iA/hed25VOKpfZWjXgP1HA==
X-Received: by 2002:a05:651c:1a14:b0:250:626a:95ad with SMTP id by20-20020a05651c1a1400b00250626a95admr18370424ljb.285.1652305675299;
        Wed, 11 May 2022 14:47:55 -0700 (PDT)
Received: from nergzd-desktop.localdomain ([194.39.226.133])
        by smtp.gmail.com with ESMTPSA id 7-20020ac25687000000b0047255d211afsm458891lfr.222.2022.05.11.14.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 14:47:54 -0700 (PDT)
From:   Markuss Broks <markuss.broks@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Markuss Broks <markuss.broks@gmail.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Song Qiang <songqiang1304521@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v2 0/5] Add support for ToF sensor on Yoshino platform
Date:   Thu, 12 May 2022 00:47:12 +0300
Message-Id: <20220511214718.50879-1-markuss.broks@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for the ToF proximity sensor installed on
Yoshino devices. As part of this series, support handling the reset
GPIO and VDD supply by the VL53L0X driver. Also stop hardcoding the
interrupt type, since on Yoshino devices it seems that edge triggering
doesn't work properly.

Tested on Sony Xperia XZ1 (poplar).

Cc: Konrad Dybcio <konrad.dybcio@somainline.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>

v2:
- Fix a nasty issue: turns out grouping the pinctrl makes it not apply,
which was the main cause of edge interrupts not working correctly and
having to use level interrupts, which caused a large amount of false
detections.
- handle the irq type more gracefully: if it's not provided, default
to falling edge, but if it's provided, then use the provided one.

Markuss Broks (5):
  dt-bindings: proximity: vl53l0x: Document optional supply and GPIO
    properties
  proximity: vl53l0x: Get interrupt type from DT
  proximity: vl53l0x: Handle the VDD regulator
  proximity: vl53l0x: Handle the reset GPIO
  arm64: dts: qcom: msm8998-xperia: Introduce ToF sensor support

 .../bindings/iio/proximity/st,vl53l0x.yaml    |  5 ++
 .../dts/qcom/msm8998-sony-xperia-yoshino.dtsi | 34 +++++++++++++
 drivers/iio/proximity/vl53l0x-i2c.c           | 50 ++++++++++++++++++-
 3 files changed, 88 insertions(+), 1 deletion(-)

-- 
2.35.1

