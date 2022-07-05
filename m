Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F75D5678DB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 22:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbiGEU4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 16:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbiGEU4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 16:56:04 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D29C013FBB;
        Tue,  5 Jul 2022 13:56:01 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id y8so11084833eda.3;
        Tue, 05 Jul 2022 13:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LsXRox3KLxWxIanaGD+qUnujzqKGqHw2gDkP62Qede0=;
        b=cry1CMJRpd3NzNdhwKau+KGhKMcqM+4IHaXv/ucAHHgIbCVRIe2fQOfvkaYk6ksFJ9
         CQgHChzmkk6t19ebrUpIv0abR39WYI6TO9cIlLR0Aop8+j1fcNF5rYQTNoK19ceFVxsu
         kxjaT95fAy5UTWP3D4DTZ7+25OJvZKXePuCwJ6PnfPbSv0MhOOYvxyLpvt7VVLtemwgg
         I55ly82Cq2B6KFkkoYtSvrOOru//H8R95LNWOD0FnOIv9gXxaML1F8knAULj0l6SR/Cw
         BhgIq/65t1joaq6lzilIh1OB7ElaJ/2Z9vsuDoS40Il/NzErOQbYFE50qT7ULaC8n1pM
         TVIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LsXRox3KLxWxIanaGD+qUnujzqKGqHw2gDkP62Qede0=;
        b=v70GGUIg9vELE2mWnokgBX9bpbhU5Sjo6tq1Zm+6mAojuZuN7VZWEfMT0+82RYIO/L
         QI8yHx+tOUCd4sRODmkBOWpjXBLKjZxxQ/7C3PEe/kxnN9zoq7nifh46gTffRDsf/HPs
         PMk9ffajN9o8j5VdhZWknzbw2FfHtKwSxyS0VLf9HvcB7IADFnjxEokTXQsq5pSnNy7l
         EVMD1p1mHSmM1V3XdPHf9+f1ohBphcXMYy9lLPJIoXTpcgm09X5aDx8iClUzv3kCL5e4
         WPbypgbIFyMdM9ykoGNEBHkkWrQPnPIpyHe4LqGQw4PU2unm8O9YaJ8tcFOd9/jA+eZy
         9Ktg==
X-Gm-Message-State: AJIora/PS/TezSbPnL8T4ia/yfCHLh648+gBDrP/Nf/LRYIac8/91yBo
        rYofc5CiYiRqNg/6x7dIquQOf1aBwYQ=
X-Google-Smtp-Source: AGRyM1tNxsoA71taKrbmhWq2cicsD6xbEUyVUnmsiCUvKvGw0sve6B2QkKeAQWBgkZPP0dHO33m7vg==
X-Received: by 2002:a05:6402:2812:b0:437:6235:adbe with SMTP id h18-20020a056402281200b004376235adbemr48635901ede.416.1657054560214;
        Tue, 05 Jul 2022 13:56:00 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id dm3-20020a05640222c300b0043a70c51470sm3836956edb.55.2022.07.05.13.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 13:55:59 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH 0/5] clk: qcom: Drop use of pxo/cxo_board for rpm devices
Date:   Tue,  5 Jul 2022 22:28:32 +0200
Message-Id: <20220705202837.667-1-ansuelsmth@gmail.com>
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

Trying to convert every driver used by ipq806x to parent_data api, I notice
RPM was still using pxo_board clk.

pxo and pxo_board are the same clock and are defined just to handle old
clock definition. It was discovered that rpm is the last driver using
pxo_board instead of pxo.

While updating the rpm driver I notice the documentation was also wrong,
so this series also fix that.

Christian Marangi (5):
  dt-bindings: clock: fix wrong clock documentation for qcom,rpmcc
  ARM: DTS: qcom: fix dtbs_check warning with new rpmcc clocks
  clk: qcom: clk-rpm: convert to parent_data API
  ARM: dts: qcom: add pxo/cxo clock-output-names for ipq8064
  clk: qcom: gcc-ipq806x: remove cc_register_board for pxo and cxo

 .../devicetree/bindings/clock/qcom,rpmcc.yaml | 77 ++++++++++++++++++-
 arch/arm/boot/dts/qcom-apq8064.dtsi           |  2 +
 arch/arm/boot/dts/qcom-ipq8064.dtsi           |  4 +
 arch/arm/boot/dts/qcom-msm8660.dtsi           |  4 +-
 drivers/clk/qcom/clk-rpm.c                    | 24 ++++--
 drivers/clk/qcom/gcc-ipq806x.c                |  8 --
 6 files changed, 98 insertions(+), 21 deletions(-)

-- 
2.36.1

