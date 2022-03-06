Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 893A44CEAAD
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Mar 2022 12:11:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233284AbiCFLM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 06:12:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233223AbiCFLMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 06:12:25 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4ACC606DD
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 03:11:32 -0800 (PST)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 02CC83F623
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 11:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646565091;
        bh=wIiMX0XUCkTo8b0ATD0IcXb9TBhD0CdDLNQdfZCqwBY=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=UEckeTDZN7uQSneG5kZ9iCCmRS7GSoA9CaQZXcWSJha3fyX47u+DsameWMU6LIqYj
         Xwkb4Al4oO8aUxXKgjwopAwOHA8PS0mlA6/4ONo51Qu1zqd8I8ydkzUdU0Kzb/PzYw
         o2PQVH9acsCt1oEsDFDamXaiiy62C+Oy/eONnDrwJWkOSIB1BX1WtZJJHyJcz260+v
         xJGNC0037ozcX7NHhye+NyY9Tcij08fEjd8nY0pmaXIDOZE6xDefxO28TmfiVOZAVD
         366PJvUa4vgxTHN2ecJr88Ij45666MXNgD7OYV1eyAwRINAFCXJ+n2L9eM3G2WyhFf
         ctDka/hi7BIFw==
Received: by mail-ed1-f70.google.com with SMTP id bq19-20020a056402215300b0040f276105a4so6768162edb.2
        for <linux-kernel@vger.kernel.org>; Sun, 06 Mar 2022 03:11:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wIiMX0XUCkTo8b0ATD0IcXb9TBhD0CdDLNQdfZCqwBY=;
        b=N3xXsUecUYWMyeqGL1ZR/yHkL7xlc3ZXcB2fdwO/tHIWMeEUbQgKcP2e8/LfEvsw3T
         r3eZZIDbUYrAGl1FMSttQD+ovQ+PQaU8BZdMgVS4JLNr0FdUDJzol32CY1J7EFuqqXZt
         kBWXoEUcj63MwTrcWrMxW04pbmfDZaime2N5ANaRISb3fKgsQ8tYsvROOFuM5Evp0dGw
         XJEsFBn0nogueM1atwMvn9V1i1Q5HXQmnznm7dbHZKXCsfDw8DAtEHi1+ue/x9dUxdtk
         bOqn8AYgb5jT38J0gZ7eIOtM8bUX8PK7ejJl1Z/648BoMBUBXdYV6SFvLMO3D7I/39ro
         tb/g==
X-Gm-Message-State: AOAM532sKSRISVg3onsbI3CLCIb4D2NSnh4pmFIn9SeXTFjfCtaWgsPD
        e7Fp0nDK8ClSjUDKgCJO5QKtUX7gs4HJjDPBSpvq4ZrV8v4kXrB92DWrXe89ypkYvg5gH1VYGAr
        Ic1wTeLSi3TpkGXyDn3xZZXqyUV1rQETJ1e8R/tSMsQ==
X-Received: by 2002:aa7:c80b:0:b0:416:463c:309c with SMTP id a11-20020aa7c80b000000b00416463c309cmr415347edt.413.1646565089793;
        Sun, 06 Mar 2022 03:11:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzP9L+8xDUVkpWxiFjFj1GYgye5Xlluz6YMq3chqBtolnFZUO6sIbZcQekE9OTuQDMjNAfrdQ==
X-Received: by 2002:aa7:c80b:0:b0:416:463c:309c with SMTP id a11-20020aa7c80b000000b00416463c309cmr415331edt.413.1646565089569;
        Sun, 06 Mar 2022 03:11:29 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id a9-20020a1709066d4900b006da888c3ef0sm3720444ejt.108.2022.03.06.03.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Mar 2022 03:11:28 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Wei Xu <xuwei5@hisilicon.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jan Kotas <jank@cadence.com>, Li Wei <liwei213@huawei.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-scsi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v3 00/12] dt-bindings: ufs: add common platform bindings + fixes
Date:   Sun,  6 Mar 2022 12:11:13 +0100
Message-Id: <20220306111125.116455-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Not tested on hardware, so please kindly test.
Bindings maintainers might need checking - taken from git log.

Changes since v2
================
1. Do not deprecate freq-table-hz, but instead update dtschema to accept
   uint32-matrix. See:
   https://github.com/devicetree-org/dt-schema/pull/69
2. Drop patches and changes related to freq-table-hz -> freq-table conversion.
3. Add tags.
4. Change maintainer of qcom,ufs.

Changes since v1
================
1. Make freq-table as matrix of tuples (Nishanth).
2. New patches: convert all bindings and fix up DTS files.
3. Several minor fixes in UFS bindings.

Dependencies
============
None dependencies. The DTS patches can go independently via respective
maintainers. The dt-bindings patches could go via UFS tree.

Best regards,
Krzysztof

Krzysztof Kozlowski (12):
  dt-bindings: ufs: add common platform bindings
  dt-bindings: ufs: samsung,exynos-ufs: use common bindings
  dt-bindings: ufs: cdns,ufshc: convert to dtschema
  dt-bindings: ufs: drop unused/old ufs-qcom PHY bindings
  dt-bindings: ufs: qcom,ufs: convert to dtschema
  dt-bindings: ufs: hisilicon,ufs: convert to dtschema
  dt-bindings: ufs: mediatek,ufs: convert to dtschema
  dt-bindings: ufs: snps,tc-dwc-g210: convert to dtschema
  arm64: dts: hisilicon: align 'freq-table-hz' with dtschema in UFS
  arm64: dts: qcom: msm8996: drop unsupported UFS
    vddp-ref-clk-max-microamp
  arm64: dts: qcom: msm8996: correct UFS compatible
  arm64: dts: qcom: sm8350: drop duplicated ref_clk in UFS

 .../devicetree/bindings/ufs/cdns,ufshc.txt    |  32 ---
 .../devicetree/bindings/ufs/cdns,ufshc.yaml   |  68 +++++
 .../bindings/ufs/hisilicon,ufs.yaml           |  90 +++++++
 .../devicetree/bindings/ufs/mediatek,ufs.yaml |  67 +++++
 .../devicetree/bindings/ufs/qcom,ufs.yaml     | 242 ++++++++++++++++++
 .../bindings/ufs/samsung,exynos-ufs.yaml      |  13 +-
 .../bindings/ufs/snps,tc-dwc-g210.yaml        |  51 ++++
 .../bindings/ufs/tc-dwc-g210-pltfrm.txt       |  26 --
 .../devicetree/bindings/ufs/ti,j721e-ufs.yaml |   7 +-
 .../devicetree/bindings/ufs/ufs-common.yaml   |  82 ++++++
 .../devicetree/bindings/ufs/ufs-hisi.txt      |  42 ---
 .../devicetree/bindings/ufs/ufs-mediatek.txt  |  45 ----
 .../devicetree/bindings/ufs/ufs-qcom.txt      |  63 -----
 .../devicetree/bindings/ufs/ufshcd-pltfrm.txt |  90 -------
 MAINTAINERS                                   |   1 +
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi     |   4 +-
 arch/arm64/boot/dts/hisilicon/hi3670.dtsi     |   4 +-
 .../boot/dts/qcom/msm8996-xiaomi-common.dtsi  |   1 -
 arch/arm64/boot/dts/qcom/msm8996.dtsi         |   3 +-
 arch/arm64/boot/dts/qcom/sm8350.dtsi          |   3 -
 20 files changed, 614 insertions(+), 320 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/ufs/cdns,ufshc.txt
 create mode 100644 Documentation/devicetree/bindings/ufs/cdns,ufshc.yaml
 create mode 100644 Documentation/devicetree/bindings/ufs/hisilicon,ufs.yaml
 create mode 100644 Documentation/devicetree/bindings/ufs/mediatek,ufs.yaml
 create mode 100644 Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
 create mode 100644 Documentation/devicetree/bindings/ufs/snps,tc-dwc-g210.yaml
 delete mode 100644 Documentation/devicetree/bindings/ufs/tc-dwc-g210-pltfrm.txt
 create mode 100644 Documentation/devicetree/bindings/ufs/ufs-common.yaml
 delete mode 100644 Documentation/devicetree/bindings/ufs/ufs-hisi.txt
 delete mode 100644 Documentation/devicetree/bindings/ufs/ufs-mediatek.txt
 delete mode 100644 Documentation/devicetree/bindings/ufs/ufs-qcom.txt
 delete mode 100644 Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt

-- 
2.32.0

