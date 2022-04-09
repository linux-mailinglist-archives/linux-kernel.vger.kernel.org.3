Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 395F94FAA3E
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 20:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243069AbiDISnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 14:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243061AbiDISnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 14:43:33 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52D8AFC131;
        Sat,  9 Apr 2022 11:41:26 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id r66so10638560pgr.3;
        Sat, 09 Apr 2022 11:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WN+cZ+EH/2jdMXxpTEKPOeickiZoQW84lQN8HFTlfGk=;
        b=GVr+YmrpKw9iWExzzn0YYiFAVz0khz0N4A6GJYFa4ApK4WwiSNadltPKsdak1Fl0+W
         /U+ll7cTgWilgsrcytPMn+E2rN0DlTXPYZvfGfwMSPGq+4DVxwlYgVyvR7YqY4ZqTET5
         EAYjUBcW3lQruMSMxg5EfSsXY6LgR13c1o24In5YsqNgTh+zAOtUnhzYbebTAkK7SIVN
         h39n/5AzlXuBN4r0Jmx2+gEOXcrgcatdBXnReqEFHp8sUBx5hGBElnq2XblXrY4GITvc
         +46IudDIR+lvNPAfyNbMey5XXNEqqLsWmCrQFkrHp+8vDCZD7yc6DNMa/3BSK+sGsu13
         gKNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WN+cZ+EH/2jdMXxpTEKPOeickiZoQW84lQN8HFTlfGk=;
        b=U3zHtnG6W9JgB0S5lSR6lYUNzXf2HtkOksGQenjHQW71fVQQkH03KihYEMmgJygoTt
         QyId4LCDa8M0EKXPbgakVHvZ6LkXGX/vv8d7RB0Y5/VyRPXQYvXHiMgmX5NrNsGUrYaP
         dkIPqdg4jK6a8FcxIzH6Jt+h5cKop0yCn8CIlN3tw3dg2AFOT0peiJntR55G+gCA+XPD
         +O5wWE55ZWE9lZ6uSOwXUxbesNsZwpO9n6ItixK1lPi90pDRqU5cIMCY0n0hqlsH9m/e
         7T/SpOjO7Snldj+Qyc2FJomzQGF5rHdaoLX/RvklivbNITl8PyimbnTaVwfacScie3+c
         5Tpg==
X-Gm-Message-State: AOAM532ugHDqK/Y4yKSbaOIYBy115pTQJYigYsRfYUkGyibczqyr8LKi
        YELSlly39KK5ZucdDkF+wU7BJY7IuEQ=
X-Google-Smtp-Source: ABdhPJw9Tw2GpTtcmFXjMJJp93pcZOSpYFzo9oV6lAt8ttC99gcYK3AqXAp91Odw8nptfOEQQHiuJw==
X-Received: by 2002:a05:6a00:2124:b0:4fa:739f:2386 with SMTP id n4-20020a056a00212400b004fa739f2386mr25196272pfj.68.1649529685701;
        Sat, 09 Apr 2022 11:41:25 -0700 (PDT)
Received: from localhost.localdomain ([122.161.51.18])
        by smtp.gmail.com with ESMTPSA id g3-20020a63ad03000000b003821d0f0ef4sm25813933pgf.71.2022.04.09.11.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Apr 2022 11:41:25 -0700 (PDT)
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Kuldeep Singh <singh.kuldeep87k@gmail.com>
Subject: [PATCH 0/6] Covert Qcom BAM dma binding to json format
Date:   Sun, 10 Apr 2022 00:11:09 +0530
Message-Id: <20220409184115.15612-1-singh.kuldeep87k@gmail.com>
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

 .../devicetree/bindings/dma/qcom,bam-dma.yaml | 90 +++++++++++++++++++
 .../devicetree/bindings/dma/qcom_bam_dma.txt  | 52 -----------
 arch/arm/boot/dts/qcom-apq8064.dtsi           |  6 +-
 arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1.dtsi |  4 +-
 arch/arm/boot/dts/qcom-ipq4019.dtsi           |  6 +-
 arch/arm/boot/dts/qcom-ipq8064.dtsi           |  4 +-
 arch/arm/boot/dts/qcom-mdm9615.dtsi           |  4 +-
 arch/arm64/boot/dts/qcom/msm8996.dtsi         |  2 +-
 8 files changed, 103 insertions(+), 65 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
 delete mode 100644 Documentation/devicetree/bindings/dma/qcom_bam_dma.txt

-- 
2.25.1

