Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F36C4FAF65
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 19:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243759AbiDJRxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 13:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiDJRxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 13:53:14 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EDC74B418;
        Sun, 10 Apr 2022 10:51:01 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id h15-20020a17090a054f00b001cb7cd2b11dso2184794pjf.5;
        Sun, 10 Apr 2022 10:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Id/DirePZJY/Ai1GEf6Xyjg7zUYiVdrMqThuQAYxghE=;
        b=PuRceRuA04I2fUI+H534OZaQG3ZJn4zMgmj/TNQkY8mW/DtKsLtmyl/q4OWqWhDGeZ
         ejwTzY79s7YrWQ0J6rTl8d8THVqV+1wG44tyWsXq4m/MiHWiP+7uafcv1OSe94zIYMF3
         9QTFPgb5dzmVp/dstNt+8Cki/fvfjjfg/zjwc8HRtKw4LgugxAVk78PpdELq1CnzhoOE
         Ufct+alK4wSPEbvrZQiD1K0UTIiD679UzYyI5qiJgRZZrZN2jC6XylAYj0e3O+F3BywA
         jUTUrpq/JNRzZx9fvh5Dtf/BHZmB50u9/KZQNnkmStrhM+2l8/8/ZYITfuWHGCYxkgha
         d/Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Id/DirePZJY/Ai1GEf6Xyjg7zUYiVdrMqThuQAYxghE=;
        b=WO39sJq5QwUIB+Ielfd2pG10hkJn6TZEmsBH+Jnmn3TtkimXHkpJgkltqH0CaVg2gI
         8qrE7u+Gf7ipK/ECii6kp8TTDFj8bLJ+bZ/8rhiPtPoA7UPnWkl2ec+5yQTgtJXm900H
         xfUyC+qbBGXkoiZHwLjLj9i97rA9TDm2BNZgRdq+dRSqaXztixISGJzXC8HhHzMOJarW
         v+ehhDLLo69X9+g3QHPvJ00ZfsXxG5PeOo6a230SoUzTFLwlAn/3/BHLw18dK7yJ0Uxe
         +ahkStbpkxN3yS5uCCSWRF0qTcoPnxi1DxP2e3Au+MIBcJWlfM+TSS3NvJYZxC1HBH4W
         yigw==
X-Gm-Message-State: AOAM533U8LmJSEwAp1HZ1M0frBmBeKfB056fNet8OWKSxTOI4shGn9kZ
        ej069SW7oTG7yoR74IK3brE=
X-Google-Smtp-Source: ABdhPJyQy4c89b59i1wMQNAYbXRWxvfN1RFTS3Q/G1sNt2+3pACXaxa384nayARAetxtkwonjpr0EA==
X-Received: by 2002:a17:902:8490:b0:156:9846:240 with SMTP id c16-20020a170902849000b0015698460240mr28464361plo.141.1649613060769;
        Sun, 10 Apr 2022 10:51:00 -0700 (PDT)
Received: from localhost.localdomain ([122.161.51.18])
        by smtp.gmail.com with ESMTPSA id l4-20020a056a0016c400b004f79504ef9csm32283286pfc.3.2022.04.10.10.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Apr 2022 10:51:00 -0700 (PDT)
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v2 0/6] Convert Qcom BAM dma binding to json format
Date:   Sun, 10 Apr 2022 23:20:50 +0530
Message-Id: <20220410175056.79330-1-singh.kuldeep87k@gmail.com>
X-Mailer: git-send-email 2.25.1
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

v2:
- Add more variants of ip4019-ap/dk-{01/04/07} for dma node rename
- Add #dma-cells in binding file
- use additionalproperties as false
---

Patch 1,2,3,4,5 require generic node name for dma and 6/6 is actual
conversion change.

Looking forward towards review comments. Thanks!

Kuldeep Singh (6):
  ARM: dts: qcom: apq8064: User generic node name for DMA
  ARM: dts: qcom: mdm9615: User generic node name for DMA
  arm64: dts: qcom: msm8996: User generic node name for DMA
  ARM: dts: qcom: ipq4019: User generic node name for DMA
  ARM: dts: qcom: ipq8064: User generic node name for DMA
  dt-bindings: dma: Convert Qualcomm BAM DMA binding to json format

 .../devicetree/bindings/dma/qcom,bam-dma.yaml | 94 +++++++++++++++++++
 .../devicetree/bindings/dma/qcom_bam_dma.txt  | 52 ----------
 arch/arm/boot/dts/qcom-apq8064.dtsi           |  6 +-
 arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1.dtsi |  4 +-
 .../boot/dts/qcom-ipq4019-ap.dk04.1-c1.dts    |  2 +-
 arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1.dtsi |  2 +-
 arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1.dtsi |  4 +-
 arch/arm/boot/dts/qcom-ipq4019.dtsi           |  6 +-
 arch/arm/boot/dts/qcom-ipq8064.dtsi           |  4 +-
 arch/arm/boot/dts/qcom-mdm9615.dtsi           |  4 +-
 arch/arm64/boot/dts/qcom/msm8996.dtsi         |  2 +-
 11 files changed, 111 insertions(+), 69 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
 delete mode 100644 Documentation/devicetree/bindings/dma/qcom_bam_dma.txt

-- 
2.25.1

