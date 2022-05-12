Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4921524AFA
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 13:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352963AbiELLIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 07:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240084AbiELLIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 07:08:13 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91BF3580CB;
        Thu, 12 May 2022 04:08:10 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id t25so6030560ljd.6;
        Thu, 12 May 2022 04:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dBBHl0CC2zkFhkTGpkjRFnXUjhNmvvs7bjai/yQgBzI=;
        b=YFbbrvWobPli7+ZpBvGVl4ObJiJOD73o01734aD9JYzT0Pvm4RiULDDuD3uMASjewG
         cSaMk8i8WGQYkZB4SMHoOajCR7rJsaThoHtyu+RPp4EVGv/8/Hdp7Mg13EG2blUPH6c/
         ohc2v2q4EWOvANPY1lRf4o9E16LIZuHgG+9XC2labNqX+iZU9UbGlHlyI00PeetmjU78
         Mb0Cud+we7CiQLD/IPy7I4UyJl+zt+iElyUrmsJcvsFYX0rXQ01ZB7nwzSF4NbIRcaW7
         7gSNtva5lX5SOV9Nd32mQz7QAml71gQtOCJv7rQvi5ag9MVjz8i+BKRCKxiKvKhlS0BR
         TrDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dBBHl0CC2zkFhkTGpkjRFnXUjhNmvvs7bjai/yQgBzI=;
        b=a5k8Q5+lKTf2F5z+six26pFkJF63+2ryHuL5lxLhU8X/56ZiLmUrPC/qqKAmFG5Qyt
         GVYwwKUnjOBigUDEizBBZbYG/cyDXNv/91BxEs8VNwGEqS+lTMqQHlM/yMIW2UYxB5R5
         3F/rgnD47efHIY7G1VjSFISMipjYvcv1HmFLlilHLjVPhWax9Z/+ZJAyThoveatDg9TK
         wc3IAppf/4gh6CAghDfww52L0Meb7dbIRgyhD0FBhXdeGHT1mmGnOP2BSIbFvrxevpmb
         M3QrqBQpV4l3b9n2KRAbme+HmXCxNq8GQsS6QB195UN9yk9RuqogEvp1TP1AF+r7rJnR
         YoMQ==
X-Gm-Message-State: AOAM532lvS7IWL7+vzQATzGAD8vW7m+43NghW+wtz3KSFIMyq0rn0XhP
        8CwJ2xNqiA4wx3VSM6CkKTnqAMr81wKqVA==
X-Google-Smtp-Source: ABdhPJwlYkC1xm2URAbVR3Mh4H7Sa69hMp6XIWvNUDRFcpN2z4ld6Iq203X7uw25R+808nPph3qxFg==
X-Received: by 2002:a2e:9645:0:b0:24f:2e6f:f931 with SMTP id z5-20020a2e9645000000b0024f2e6ff931mr20360672ljh.466.1652353687988;
        Thu, 12 May 2022 04:08:07 -0700 (PDT)
Received: from nergzd-desktop.localdomain ([194.39.226.133])
        by smtp.gmail.com with ESMTPSA id i25-20020a056512007900b004725b99d2fdsm734883lfo.164.2022.05.12.04.08.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 04:08:07 -0700 (PDT)
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
Subject: [PATCH v3 0/5] Add support for ToF sensor on Yoshino platform
Date:   Thu, 12 May 2022 14:07:52 +0300
Message-Id: <20220512110757.5297-1-markuss.broks@gmail.com>
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
v3:
- add irq.h header (forgot to commit)
- reword commit message (already initialized -> pre-initialized)

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

