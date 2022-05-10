Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4D565225A2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 22:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232020AbiEJUnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 16:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiEJUn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 16:43:28 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A84128B681;
        Tue, 10 May 2022 13:43:27 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id p10so72243lfa.12;
        Tue, 10 May 2022 13:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/rWvKzwkcndU699uCK8+HpcopA807nPrEODSc7gQasM=;
        b=HTOYyyyWbn47Di2MCRUgKVqdYIejkpqttDdAdAKYwDx+UWtGg3DkxExTbc+nh6fqAt
         bXe4FID20SSEAK/vMDr1crEFzzqSWlHxokiHprsiNv2szybLpIkF6XMeznrds3giLQGK
         QZJhrb4cm0E6jJckF2c2fFx804okLr6hQLfY5aP2TF2O5p9fj/tyYhyysczekaHz4U6F
         xetKmxAKzMgSfqtHY99lnC5/oLcW5nmh/S5b7/pVu3WFkah5yB3qKMj0vlQu1B5Nb0+w
         PRnKf0YfrdhZHUGt0RVMV+pW9taAJlj9Q9ccZ5X+FYbrtE/57AHdifLdoY0YS3CC6iwR
         H58A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/rWvKzwkcndU699uCK8+HpcopA807nPrEODSc7gQasM=;
        b=j5/FF05cdUWR+QlyVDDEWENz9phadoRv+V/WvEKNg6NOJxn8w0+F4JlO10GMaVbEDq
         MKYsWCN+kqSXBpysZchyqPGl1Y8iZ6RlqdkxSoBPfY8+iGsUCxjBDyet7qeDPr7qjcxO
         +P6WylmKkPjWJzT4CLEI1h9wrnryiNq6NRDZ+e5uMatDw78uf1gpol4PIR1l/0kY5WLx
         ndeDcknRfyG3Xr7O3AF64zZXRuKerRRIInSgTZ7hHn0n47bcJcALsDzZV4s1TqnliDGz
         2oPhzTyYwXcxLb56zCLrlwRkHN0SmkFb1gVE1Z7nCRYImrIhXrpITR1ZqMSF8VTtWxF+
         z7xQ==
X-Gm-Message-State: AOAM531m+TgXq7TYOruLpyRRXYVTXy66Ng4RltbZFX4da0n20CFboRA+
        VfvjI3sy1dul6nrT8pI3y1BuVJ/KGj4=
X-Google-Smtp-Source: ABdhPJzehHyw7ekVz4xHzRVVz/r6JeoNjgpPl+q7Ij7ovB07TQOJeLztre/xvGjHXvCnbUxS4thaEg==
X-Received: by 2002:a19:7710:0:b0:472:3486:a49e with SMTP id s16-20020a197710000000b004723486a49emr17953979lfc.600.1652215405565;
        Tue, 10 May 2022 13:43:25 -0700 (PDT)
Received: from nergzd-desktop.localdomain ([194.39.226.133])
        by smtp.gmail.com with ESMTPSA id 10-20020ac25f4a000000b0047255d210f0sm12318lfz.31.2022.05.10.13.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 13:43:25 -0700 (PDT)
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
Subject: [PATCH 0/5] Add support for ToF sensor on Yoshino platform
Date:   Tue, 10 May 2022 23:42:51 +0300
Message-Id: <20220510204256.8874-1-markuss.broks@gmail.com>
X-Mailer: git-send-email 2.35.1
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

