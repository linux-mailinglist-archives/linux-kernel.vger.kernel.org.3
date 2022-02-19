Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 999214BCA07
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 19:42:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242866AbiBSSnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 13:43:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242799AbiBSSm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 13:42:57 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D022716B
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 10:42:36 -0800 (PST)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id E6E9B402FD
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 18:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645296148;
        bh=MgKjv9z7uNr3RRUsHMHa/DUOLnVSfcojasTHu53YzZ0=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=doL82KuKwHUFeGeapEXNusQjxhxuNC+tpGVORDoS4ovg9n3WAoHN1vlbIAOM6uKTl
         lA/AKHGsILWWgON913YU5CYLJnGXZPEEVASmiSzgMwuqShoxoBMUUvBsQvDP1k+WXz
         BGchNnBlVAoUDQnCAKjTIxZ0xcQE6d2QSe7X6Jp9hnGRnvr+c1aCKGNULgARhqpoNw
         BkZ4Yurn9l279Tgp5Gr9Py9EezX4gGqeCKKF9nEqV6R5iH7QDLLoyTo9Plpr9Lb7tP
         2jo9dQu6AEicEo6TUtEYQQrqd4+tNb2FxG3naLj2aFqZB7du6HcidaFlMKdpdM5dHB
         sEndUQab4aUJA==
Received: by mail-ed1-f69.google.com with SMTP id b26-20020a056402139a00b004094fddbbdfso7598805edv.12
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 10:42:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MgKjv9z7uNr3RRUsHMHa/DUOLnVSfcojasTHu53YzZ0=;
        b=ePdR+/UklA/L7J957rjj30dlxtrr7XZuRsfETxUxsT5xy831yrAFA73lVV1vIRusIN
         6aVOTbwiDIt9g9MmApNhrOLfm4/zpdFSU0/1EnWS3FQOBN8RCkxxBZJvig0gwxP2MC5o
         W5cI4xQe2o7y/u0keU5NdCf4f+BVVPdA4hAv3U5E7M2XPVqRV85Njkv/bA81NnkrdAcY
         21D9LRqwpCAFJJ23CzK+Yx1M3dOJXoTpJufBEyBP7uml+x6S6/mQX1PpTLtb/mQABLwS
         wrpn9ZsMj0SWxNzrYYobl93mGHGzlWJ9QCCT7nJLuQmg91xMp1DtRH/LpPNI9tj2LqPu
         KQiQ==
X-Gm-Message-State: AOAM532oLDKvRzICXC0QaY6bqPseSOvKu67MjitqOja3S3gQh/JYLbRS
        BrBHWadyKr3ZrM7mhw/jGarizZj51l8H9vMcMtKKHQK/MJvt5D+a/NZ9RCorndJIad12DrWq/iU
        QvFbiOHL6Bp3BjTzCpTl398XWRIELbowprieVNn4q1A==
X-Received: by 2002:a05:6402:90b:b0:412:a7cc:f5f9 with SMTP id g11-20020a056402090b00b00412a7ccf5f9mr12839301edz.136.1645296148105;
        Sat, 19 Feb 2022 10:42:28 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz9AksoCFm+UDOtkXMW7lwQ/A6+F6VdlAYu3MK0g2Dmm81uCBlm5twd4SJuMN4mjgnv445xsg==
X-Received: by 2002:a05:6402:90b:b0:412:a7cc:f5f9 with SMTP id g11-20020a056402090b00b00412a7ccf5f9mr12839290edz.136.1645296147918;
        Sat, 19 Feb 2022 10:42:27 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id j8sm6680745edw.40.2022.02.19.10.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Feb 2022 10:42:27 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Wei Xu <xuwei5@hisilicon.com>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Chanho Park <chanho61.park@samsung.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Jan Kotas <jank@cadence.com>, linux-scsi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [RFC PATCH 0/8] dt-bindings: ufs: add common platform bindings + fixes
Date:   Sat, 19 Feb 2022 19:42:16 +0100
Message-Id: <20220219184224.44339-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Not tested, so please kindly test.

I am sending as RFC to gather some comments.  If it looks good, I will
convert other TXT bindings to DT schema format.

Dependencies
============
1. The DTS patches (5-8) depend on scsi/ufs driver change (patch 4), so
   they should go in a following release, after merging driver.

   This is also might affect out-of-tree users of these DTSes (other
   projects, e.g. U-boot).

Best regards,
Krzysztof

Krzysztof Kozlowski (8):
  dt-bindings: ufs: add common platform bindings
  dt-bindings: ufs: samsung,exynos-ufs: use common bindings
  dt-bindings: ufs: cdns,ufshc: convert to dtschema
  scsi: ufs: deprecate 'freq-table-hz' property
  arm64: dts: hi3670: use 'freq-table' in UFS node
  arm64: dts: exynos: use 'freq-table' in UFS node
  arm64: dts: qcom: use 'freq-table' in UFS node
  arm64: dts: ti: use 'freq-table' in UFS node

 .../devicetree/bindings/ufs/cdns,ufshc.txt    | 32 -------
 .../devicetree/bindings/ufs/cdns,ufshc.yaml   | 56 ++++++++++++
 .../bindings/ufs/samsung,exynos-ufs.yaml      | 10 +--
 .../devicetree/bindings/ufs/ti,j721e-ufs.yaml |  2 +-
 .../devicetree/bindings/ufs/ufs-common.yaml   | 86 +++++++++++++++++++
 .../devicetree/bindings/ufs/ufs-hisi.txt      |  4 +-
 MAINTAINERS                                   |  1 +
 arch/arm64/boot/dts/exynos/exynos7.dtsi       |  3 +-
 arch/arm64/boot/dts/exynos/exynosautov9.dtsi  |  3 +-
 arch/arm64/boot/dts/hisilicon/hi3670.dtsi     |  4 +-
 arch/arm64/boot/dts/qcom/msm8996.dtsi         | 23 +++--
 arch/arm64/boot/dts/qcom/msm8998.dtsi         | 17 ++--
 arch/arm64/boot/dts/qcom/sdm845.dtsi          | 19 ++--
 arch/arm64/boot/dts/qcom/sm8150.dtsi          | 19 ++--
 arch/arm64/boot/dts/qcom/sm8250.dtsi          | 17 ++--
 arch/arm64/boot/dts/qcom/sm8350.dtsi          | 19 ++--
 arch/arm64/boot/dts/qcom/sm8450.dtsi          | 17 ++--
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi     |  4 +-
 drivers/scsi/ufs/ufshcd-pltfrm.c              | 21 +++--
 19 files changed, 234 insertions(+), 123 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/ufs/cdns,ufshc.txt
 create mode 100644 Documentation/devicetree/bindings/ufs/cdns,ufshc.yaml
 create mode 100644 Documentation/devicetree/bindings/ufs/ufs-common.yaml

-- 
2.32.0

