Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40CC0554135
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 06:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbiFVEKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 00:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239728AbiFVEKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 00:10:21 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5565333E19
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 21:10:20 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-1013ecaf7e0so20956675fac.13
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 21:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ERBTNZYy1BbiXil4wGReIFa0+xbTgQOOsoni8m4d7Fw=;
        b=shUkpP14ikfFApr9WxUYDRTChvkIC0FcV9ueZifLsuD0p/cRNMm/yXB0720i7HOSNM
         lwiHNuFW0lB59tNo/rMY0MHlTONkuxb9r6m01OqfUNSRkGPPQBR9ceUKnwfCy2WYNBxj
         Z+fAAusZZ1rGD3ilWs/Uq8+B5X/LArNd8Dc5MI5FYIUdvFlxI7fucPjgRHixd91IE+5l
         7oK5bSKZD7Eg7U4rsjQQKXGQR4DAdlO0jjSu3HN0XWfxnDWpwbki6JaQ2KWD9Ix/iu6P
         p6Neg8ng8f7mVVHOYyJ9TVOMj/9b3+Z+338TMav6G5J/iggwkfDFr3zFcPN21ZIeH0xS
         +W1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ERBTNZYy1BbiXil4wGReIFa0+xbTgQOOsoni8m4d7Fw=;
        b=IT086CM6WcYzgh4wxYjmyy9S/hZBlROephppGygj6imbkbotbaCuw6MsE/jYfKC908
         HboEiPVR8u9jxhaiRHlVaqMxeIOK2+237Bv1o2SIyGpyougrH02Y6bhXMwXSxJCPhlZA
         F02nwMhHTbdrv+Rp15LaS8d5L/H7qrtMLSzYjaugNl8yHibqRmOHtTHiAYOxfXDn0v/d
         A7Je0JU232keKxY9bwYisXQqA409ngGCjg962+eQut+8Fa6/xSkcMrfaQlIplTd5zULp
         VRzr8Jm1wzdJUt8R5sz/VyLFk5RKYh0nNhJ4AAmVTiZHhkU/Ern5KSd4LmQ5qdfGHUBQ
         lh4w==
X-Gm-Message-State: AJIora+YhWDzFX+tu03KlN21pLyUkKDO1Jrf5JsggnI+rpRkQQL62A2m
        q02OgFWV0NLNqJ8x/KV3f2Z+bA==
X-Google-Smtp-Source: AGRyM1tCEhiBmkSz67O/uKdSovXj0R2rIc/1Cn7fzuFBthSOF1Bi1+TeLO/cmoxiq4GbzTpA1ZSGuA==
X-Received: by 2002:a05:6870:58a6:b0:101:af0a:2858 with SMTP id be38-20020a05687058a600b00101af0a2858mr951556oab.61.1655871019058;
        Tue, 21 Jun 2022 21:10:19 -0700 (PDT)
Received: from ripper.. (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id b7-20020a056870918700b000f2455e26acsm2314718oaf.48.2022.06.21.21.10.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 21:10:18 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/6] arm64: dts: qcom: Introduce SC8280XP
Date:   Tue, 21 Jun 2022 21:12:18 -0700
Message-Id: <20220622041224.627803-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.35.1
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

This series introduces the Qualcomm 8cx Gen 3 platform, with basic support for
the CRD reference device, the Lenovo Thinkpad X13s and the SA8295P automotive
development platform.

Bjorn Andersson (5):
  dt-bindings: arm: qcom: Document additional sc8280xp devices
  dt-bindings: mailbox: qcom-ipcc: Add NSP1 client
  arm64: dts: qcom: add SC8280XP platform
  arm64: dts: qcom: sc8280xp: Add reference device
  arm64: dts: qcom: add SA8540P and ADP

Johan Hovold (1):
  arm64: dts: qcom: sc8280xp: add Lenovo Thinkpad X13s devicetree

 .../devicetree/bindings/arm/qcom.yaml         |    2 +
 arch/arm64/boot/dts/qcom/Makefile             |    3 +
 arch/arm64/boot/dts/qcom/sa8295p-adp.dts      |  427 ++++
 arch/arm64/boot/dts/qcom/sa8540p.dtsi         |  133 +
 arch/arm64/boot/dts/qcom/sc8280xp-crd.dts     |  432 ++++
 .../qcom/sc8280xp-lenovo-thinkpad-x13s.dts    |  393 +++
 arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi  |  108 +
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi        | 2145 +++++++++++++++++
 include/dt-bindings/mailbox/qcom-ipcc.h       |    1 +
 9 files changed, 3644 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sa8295p-adp.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sa8540p.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/sc8280xp.dtsi

-- 
2.35.1

