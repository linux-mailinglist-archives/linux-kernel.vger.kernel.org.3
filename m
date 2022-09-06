Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 010525AF1E7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 19:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239117AbiIFRHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 13:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232342AbiIFRHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 13:07:16 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 303CF72FDF
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 09:55:16 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id e13so16401317wrm.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 09:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=p6vQI2CwgE+q6ddXbTpyyYqLEbh2B3crUHEbmjFAgzQ=;
        b=yG4ac7NdpzOkvdjn0uedl98YkeL+kblRoBov5U2pz9lKAau5dkhf76ou+R23zJMsW8
         UsQA31U0Wm+cgwAASCEdxKxiKBh3CwxlUFMeioUUIrW/yuL1IniHDy8lnVEw2Q5uB4Au
         Yah2UFo4zT+7qOYmqWrV3wlcLHNNiuxxaIiWStu1zjIF64lcr8eCY9Mlrm77no/u2act
         GNeGiRPet7hR7egf/7IvAnYzjlzMXZEXV7rO4cb/D924vO4/Zqj7v77XvDP+83kVF+mI
         mgXWDQ9JYm3UJxW4LfDCgOj/WeK+kqiGEqKcwEl+HlfZFcq/O6kNI3qInnTlPHNf6TC5
         Jt+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=p6vQI2CwgE+q6ddXbTpyyYqLEbh2B3crUHEbmjFAgzQ=;
        b=2WqpoKGl2apTGL1olIwZy6oFbaDwrHJ4O2FV+TN8VSCnitvLlwxbvm3c7hp2A4ge2V
         G+K1JsaKgpvgnEGikE1WXORAZSs+1CUsGRhh/Ve3wSuc7l5EDvaNwVe/AWLLq3EP3p/9
         7FZrQ44ZAQ1Q4SL+2t2WtPPH/y07OfDtp69RNc/gNOFD9Zmi2yWkYVS+lFJEmw1sC5+p
         RRTW2hNd62qPxhKIq4Ob5O0/Ue2c9XO4uPgRvTev72jjguvCCvs2bjrLcJBN5ZhMRTzX
         cFW5jgcA995LNDztclXYp4qEUTisyFH4vaRdNT+bUvpna/FgfJP7aqJheWOilRDxxW5Q
         rh5g==
X-Gm-Message-State: ACgBeo2tMaj0ee0WQS42XZC8OubwtuxJtRyoPJsS0kVGL5+5HfyYayDB
        1oWJv5keyH4KVWijOYIYZfRk0w==
X-Google-Smtp-Source: AA6agR7SSqNb1Einsp+U+Aa89KAMr9g5aD0bxAbu3IfTxJLaIRqidiBl5f7PYr1G726iQGq6SEmb7A==
X-Received: by 2002:a05:6000:18ad:b0:226:f3b4:74f2 with SMTP id b13-20020a05600018ad00b00226f3b474f2mr16033776wri.537.1662483314772;
        Tue, 06 Sep 2022 09:55:14 -0700 (PDT)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id co4-20020a0560000a0400b0021eed2414c9sm13775906wrb.40.2022.09.06.09.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 09:55:14 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, bgoswami@quicinc.com,
        perex@perex.cz, tiwai@suse.com, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 0/4] ASoC: qcom: add support for sc8280xp machine
Date:   Tue,  6 Sep 2022 17:55:04 +0100
Message-Id: <20220906165508.30801-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds support for SC8280XP SoC machine driver.

First patch moves some of the commonly used code to common from sm8250 machine driver
and the follow on code adds minimal support for sc8280xp.

Currently this driver is only tested with SmartSpeakers and Headset
on Lenovo Thinkpad X13s.

Support for sm8450 is tested and I will post the patches soon.

Thanks,
Srini

Changes since v1:
- make all the exported symbol as EXPORT_SYMBOL_GPL


Srinivas Kandagatla (4):
  ASoC: qcom: common: use EXPORT_SYMBOL_GPL instead of EXPORT_SYMBOL
  ASoC: dt-bindings: qcom,sm8250: add compatibles for sm8450 and sm8250
  ASoC: qcom: sm8250: move some code to common
  ASoC: qcom: add machine driver for sc8280xp

 .../bindings/sound/qcom,sm8250.yaml           |   2 +
 sound/soc/qcom/Kconfig                        |  11 ++
 sound/soc/qcom/Makefile                       |   2 +
 sound/soc/qcom/common.c                       | 171 +++++++++++++++++-
 sound/soc/qcom/common.h                       |  12 ++
 sound/soc/qcom/sc8280xp.c                     | 157 ++++++++++++++++
 sound/soc/qcom/sm8250.c                       | 152 +---------------
 7 files changed, 361 insertions(+), 146 deletions(-)
 create mode 100644 sound/soc/qcom/sc8280xp.c

-- 
2.21.0

