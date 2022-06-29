Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6B1055F4E3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 06:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbiF2EL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 00:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbiF2ELz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 00:11:55 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3272D35AAE
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 21:11:54 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id h65so19990411oia.11
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 21:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MdFPqd732DS30jFNC43fudujZD0ohWzK0v59dUm/e+g=;
        b=uT8x4i4bwxUgQuVFU7XLfQLJyui3EMpoCgaPELdMwaGhPYQge7itji9XlRIS67E+/+
         633Wxci6LnX9u4naBYcNVP04lZZio2krFvkpzFrkiyyTX3sz36vUvGhM9xhFRyhQCUXy
         sRiaeN+ucbZBk5QFpkOrvwnG/exUlb7yDuQpdRDVnQxH9mqQF0J2WJ06ntca2G0CTkkA
         my/XM4HBYrNaO77i0IEuuF81WYYFCD2Zl9HdHCTRPx9I+33t/nmNxIyO5YRF6H0hWnYG
         k0oM30JywHcpX5m8pQzKEFA3HVZZyDZDYhzSnJuo54XhYi08CGCPSd+SoBKZVLXtDNc+
         z2qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MdFPqd732DS30jFNC43fudujZD0ohWzK0v59dUm/e+g=;
        b=vLLzoToHIswzYvY+XxZ4i4vzOI3Pj1eGi3E0aVm3UoWrPtqa7TkjNr9K8oqDicoZOD
         zSY448YVHR+OOyLPZ7mdR7KutbBYyGzRFcssOUqFC0Wzzrg7Xh3wHzXuPVO3zNl7uQqW
         FprS+JJQ4DzovMQ5vklMXZ2PYW8QIniCihn3BOHkcx3mgqw3Jb8N36K15KDFvFyc+6br
         wi0Oohs0fhGozz6hYhMwGMOgTcrxp/LqCx4QdpAeugYt0JXKEcAXO5Ldd3us+wADE/2b
         2ZkhoulnlSqiOkg02Qi/H4Pf7JpwUfP+2jVUdkIDGNCNoYXN5L5ldQ8WnZDBEDuUNfkY
         pQ4A==
X-Gm-Message-State: AJIora9XnrMHj0V/NiEZpnupkwlOSyjoe/WyBW1OaU9cr/wEHNXqvobQ
        bzROvPjsncsU42VKx7dZcBnlyg==
X-Google-Smtp-Source: AGRyM1uVZfbtak6txUqQT6+yqXmqHE+bs9G3w8uy1R0KuBW7xTMCozDJGoHJI/sKL0l90zqysGDDRA==
X-Received: by 2002:a05:6808:171c:b0:334:9342:63ef with SMTP id bc28-20020a056808171c00b00334934263efmr886955oib.63.1656475913546;
        Tue, 28 Jun 2022 21:11:53 -0700 (PDT)
Received: from ripper.. (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id p12-20020a9d4e0c000000b00616ec82b29bsm1578692otf.35.2022.06.28.21.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 21:11:52 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Johan Hovold <johan@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/5] arm64: dts: qcom: Introduce SC8280XP
Date:   Tue, 28 Jun 2022 21:14:33 -0700
Message-Id: <20220629041438.1352536-1-bjorn.andersson@linaro.org>
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
the CRD reference device and the SA8295P automotive development platform.

The Lenovo Thinkpad X13s dts was part of this series, but Johan reposed a
polished version at [1], which I intend to merge on top of this series.

[1] https://lore.kernel.org/all/20220622132617.24604-1-johan+linaro@kernel.org/

Bjorn Andersson (5):
  dt-bindings: arm: qcom: Document additional sc8280xp devices
  dt-bindings: mailbox: qcom-ipcc: Add NSP1 client
  arm64: dts: qcom: add SC8280XP platform
  arm64: dts: qcom: sc8280xp: Add reference device
  arm64: dts: qcom: add SA8540P and ADP

 .../devicetree/bindings/arm/qcom.yaml         |    2 +
 arch/arm64/boot/dts/qcom/Makefile             |    2 +
 arch/arm64/boot/dts/qcom/sa8295p-adp.dts      |  406 ++++
 arch/arm64/boot/dts/qcom/sa8540p.dtsi         |  133 +
 arch/arm64/boot/dts/qcom/sc8280xp-crd.dts     |  427 ++++
 arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi  |  109 +
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi        | 2142 +++++++++++++++++
 include/dt-bindings/mailbox/qcom-ipcc.h       |    1 +
 8 files changed, 3222 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sa8295p-adp.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sa8540p.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/sc8280xp.dtsi

-- 
2.35.1

