Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD995531BBC
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 22:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243036AbiEWST4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 14:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245628AbiEWSSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 14:18:20 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3F165DD36;
        Mon, 23 May 2022 10:57:02 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id h8so18112417ljb.6;
        Mon, 23 May 2022 10:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bOlYsdGBjB8la7xfDxJ83baKM4S1nbqwnMPOp413tZ8=;
        b=XulNbwRW0NjEWCEnZSzm0Gq/3TvyuwtTwqHPQBDZFKe0nwSuv4sY+Gqbrnny+R5/jx
         8jhRUwSCHPdZuGn76v3OuSYCy0sCm1fMsD4edv/qPUuxYYlRu4Lp3JkSppnV+xwktmQj
         0l0FNHs4WTUaxkdNlBxJ8QoxokkPG7ZBRgJvlbes/0k44G4eKDVe3KlXyOXGDQVjEUUK
         vwrL1COxrm62BlICzbZl7jnF550PGr2vRRAp9KuP4Ez8dZcjN1Kfn1TmXMSUCWw7b4Go
         142po8BcO0k2n6JiDvQQA2gOaHNeQSnwd0Nr5LQpKqO1SSuxfz7JuV7uqQoUXv7sxp1W
         vsdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bOlYsdGBjB8la7xfDxJ83baKM4S1nbqwnMPOp413tZ8=;
        b=7FChkw3qqNTrUDoS3wCxL0ub01IEBPaZH1BGQmuP8rs5rVZefYxveqvsNEmo1CkGyl
         pttN0oTbbNpEtCYek2u22J9NzHItqaWcvAs5DXrokYVLJ9gHKOcGOu5vu0tS9g8WLgOr
         f9cPkCrxBJNN7ebLoQXoAiyqGIWfQYpxRNwgZnu2PAPUtbksc28bpTQCESEiU6pLYjjv
         2ZfMMucLv1uIPBwa384GKRFP42V3+YRVl60Zh5O0y6Tz1xAHtNAIoog16qs9wui9FO46
         VR8pwSPBb4liXSiV6Ngp87uB+JiBHsD1PGrfKtDzEUKSvl2A7UWGN0JMR+8p6atY1Syg
         12+w==
X-Gm-Message-State: AOAM533lfl61v9SNN7F2nu8ByvjeSWAnVHO1I2663RHvJ5uJ741SAVlR
        c9NYDguFr//Ml9OzP4oBbG/zPm1Dr3bUGA==
X-Google-Smtp-Source: ABdhPJxP57/kkoig/xX65Iulf97/ByC+R673sxqZviml4DwkB2Z0HHmnwHfpK1UjyfgoMOgovfl9Wg==
X-Received: by 2002:a05:651c:10a8:b0:253:c8a7:3afd with SMTP id k8-20020a05651c10a800b00253c8a73afdmr13839377ljn.431.1653328468359;
        Mon, 23 May 2022 10:54:28 -0700 (PDT)
Received: from nergzd-desktop.localdomain ([194.39.226.133])
        by smtp.gmail.com with ESMTPSA id x9-20020a056512078900b0047255d211f9sm2087743lfr.296.2022.05.23.10.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 10:54:27 -0700 (PDT)
From:   Markuss Broks <markuss.broks@gmail.com>
To:     linux-kernel@vger.kernel.org, jic23@kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Markuss Broks <markuss.broks@gmail.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Song Qiang <songqiang1304521@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v5 0/5] Add support for ToF sensor on Yoshino platform
Date:   Mon, 23 May 2022 20:53:39 +0300
Message-Id: <20220523175344.5845-1-markuss.broks@gmail.com>
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
v4:
- reorder powering on and power off action (Jonathan)
- sort pinctrls by GPIO number (Konrad)
v5:
- "This patch adds..." -> "Add ..." (Krzysztof)

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

