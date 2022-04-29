Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FCDE515837
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 00:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381339AbiD2WOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 18:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237982AbiD2WOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 18:14:15 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8EF310DA
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 15:10:55 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id v12so12390807wrv.10
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 15:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pikpMhYcg3LtmyyBP01zKh7b0dNBqXyk+C6F1QU+WH8=;
        b=Z1AydJsHe4/DVQY/qNijIW+DyLoOc9wSXwnlhUJtIkRiYF2G7tMNMmtEMKGVP5V4sG
         asGjR8dLd9jZ7ZAkx9mh4S1IKU2fGok8W/Ed60RlW+wpF67o6ASw+hRo/UpQFP73hkR4
         uTlSH5DBMqFq9JBQwDpZvH3ha2UnWvOtXv/rdeVZffFfgERV6Qr971+dlbe8AUQtGqxV
         PlSfKSHwdrRi9s7FCHRUNFdsBwhQhBloLr2IZOG0gEtCIJWP38lfroAlOkbetEM9yKiw
         v4P1ad4WJiGf8z7IWAYvEAFhatQ0/BQrcSvU9SE9mEVvybZDokFU1ve/EeP/6BVkXJEq
         GdlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pikpMhYcg3LtmyyBP01zKh7b0dNBqXyk+C6F1QU+WH8=;
        b=ZsTyZTEPDpy0wTl7fc1nwjj2Qr60lStCQAf4B8qn9CTOcKpyuAuuxjPhJlyznyO1M4
         6y0EZO5Cne+i9rJ+QO9Z8jjTfuCPwuw4C889NazJT27YWBIptfvwOzdL9hUoRX9qZK+4
         Hw3GVxTuoipamYuhOvIiWt16IhGh1o32Vml33N+JBI6D4e6Y6X709BpKPbrvUKH+MjkK
         ++MVSgUFqpeNW218+5X1MbVeojgWGWjDJBngy+DSIsi/wJXERu+F1MewNjYIvPD/a3WO
         VeBP7ClIxIGJcfgnDEvlcq4FUKET3/UZldjc2aC3kLrF9ZsGTTSt9xOyh1ajmLTpfH/0
         bI5g==
X-Gm-Message-State: AOAM533ss6ch59JgOOpfpFcB6Oe7E4Ew2fSJBZfROb/43AW+dbYvqYVP
        fibYYZzt0TKRR5uKsvneqSr5KCyEVwALZA==
X-Google-Smtp-Source: ABdhPJzFozM7NTvQYFAXPe4wlECGV6ipQ4UhWd+BoAdouaN1rrcL7xVxGoA9BoE/b/50TNj1WuNneQ==
X-Received: by 2002:a5d:48c7:0:b0:20a:c72d:279b with SMTP id p7-20020a5d48c7000000b0020ac72d279bmr844806wrs.379.1651270254328;
        Fri, 29 Apr 2022 15:10:54 -0700 (PDT)
Received: from localhost.localdomain (cpc78119-cwma10-2-0-cust590.7-3.cable.virginm.net. [81.96.50.79])
        by smtp.gmail.com with ESMTPSA id q7-20020a1cf307000000b003942a244ebfsm291985wmq.4.2022.04.29.15.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 15:10:53 -0700 (PDT)
From:   Caleb Connolly <caleb.connolly@linaro.org>
To:     caleb.connolly@linaro.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     Jami Kettunen <jami.kettunen@somainline.org>,
        Sumit Semwal <sumit.semwal@linaro.org>
Subject: [PATCH v14 00/10] iio: adc: introduce Qualcomm SPMI Round Robin ADC
Date:   Fri, 29 Apr 2022 23:08:55 +0100
Message-Id: <20220429220904.137297-1-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RRADC is responsible for reading data about the current and
voltage from the USB or DC in jacks, it can also read the battery
ID (resistence) and some temperatures. It is found on the PMI8998 and
PM660 Qualcomm PMICs.

The RRADC has to calibrate some ADC values based on which chip fab
the PMIC was produced in, to facilitate this the patches
("mfd: qcom-spmi-pmic: expose the PMIC revid information to clients")
and ("mfd: qcom-spmi-pmic: read fab id on supported PMICs")
expose the PMIC revision information and fab_id as a struct and register
them as driver data in the Qualcomm SPMI PMIC driver so that it can be
read by the RRADC.

The first 3 patches add support for looking up an SPMI device from a
struct device_node, as well as introducing support for looking up the
base USID of a Qcom PMIC, see patch comments for more details. These
Address Bjorns comments on v2.

Changes since v13:
 * Address Lee Jones' feedback on the SPMI patches.
 * Pick up Jami's patch to enable the RRADC on the OnePlus 5

Changes since v12:
 * Apply Krzysztof's suggestions to rradc DT binding docs.

Changes since v11:
 * Remove debug logging which was left in ("mfd: qcom-spmi-pmic: expose the PMIC revid information to clients")
 * Picked up Dmitry's Tested-by and Reviewed-by tags.

Changes since v10:
 * Don't inline spmi_device_from_of()

Changes since v9:
 * Add back missing copyright, this driver is originally derived from
   downstream (Thanks Manivannan).

Changes since v8:
 * Drop Reported-by for the bugfix on previous revision reported by LKP
 * Apply Jonathans suggestions
 * Rework patch 2 ("expose the PMIC revid information to clients") to
   handle PMICs with a single USID (thanks Dmitry)

Changes since v7:
 * Addressed Jonathans comments
 * Fixed bug reported by LKP

Changes since v6:
 * Fix printf format warning in rradc

Changes since v5:
 * Add missing EXPORT_SYMBOL_GPL() to
   ("spmi: add a helper to look up an SPMI device from a device node")

Changes since v4:
 * Addressed Jonathan's comments on v4
 * Reworked the qcom-spmi-pmic patches to properly walk the devicetree
   to find the base USID. I've tested this on SDM845 which has two PMICs
   (pm8998 and pmi8998) and I'm able to look up the PMIC revid from all
   4 USIDs.

Changes since v3:
 * Split PMIC patch in two, rework to support function drivers on a
   sibling USID
 * Completely rework RRADC driver to make use of the modern IIO
   framework. This required re-arranging a lot of the equations and
   results in some lost precision, where relevant I've left comments to
   explain this. I don't think any of it is significant enough to
   justify doing post-processing in driver.
   Thanks a lot Jonathan and John Stultz for helping me out with
   this

Changes since v2:
 * Add missing include (thanks kernel test robot :D)
 * Rework some confusing function return values, specifically
   rradc_read_status_in_cont_mode and rradc_prepare_batt_id_conversion
   both of which didn't correctly handle "ret". This also bought up an
   issue as the previous implementation didn't actually wait for the
   channel to be ready. It doesn't seem like that's strictly necessary
   (same data is reported if I wait for the status to be good or not)
   but I've included it anyway for good measure.

Changes since v1:
 * Rework the RRADC driver based on Jonathan's feedback
 * Pick up Rob's reviewed by for the dt-binding patch.
 ---
Caleb Connolly (9):
  spmi: add a helper to look up an SPMI device from a device node
  mfd: qcom-spmi-pmic: expose the PMIC revid information to clients
  mfd: qcom-spmi-pmic: read fab id on supported PMICs
  dt-bindings: iio: adc: document qcom-spmi-rradc
  iio: adc: qcom-spmi-rradc: introduce round robin adc
  arm64: dts: qcom: pmi8998: add rradc node
  arm64: dts: qcom: sdm845-oneplus: enable rradc
  arm64: dts: qcom: sdm845-db845c: enable rradc
  arm64: dts: qcom: sdm845-xiaomi-beryllium: enable rradc

Jami Kettunen (1):
  arm64: dts: qcom: msm8998-oneplus-common: enable RRADC

 .../bindings/iio/adc/qcom,spmi-rradc.yaml     |   51 +
 .../boot/dts/qcom/msm8998-oneplus-common.dtsi |    4 +
 arch/arm64/boot/dts/qcom/pmi8998.dtsi         |    8 +
 arch/arm64/boot/dts/qcom/sdm845-db845c.dts    |    4 +
 .../boot/dts/qcom/sdm845-oneplus-common.dtsi  |    4 +
 .../boot/dts/qcom/sdm845-xiaomi-beryllium.dts |    4 +
 drivers/iio/adc/Kconfig                       |   12 +
 drivers/iio/adc/Makefile                      |    1 +
 drivers/iio/adc/qcom-spmi-rradc.c             | 1021 +++++++++++++++++
 drivers/mfd/qcom-spmi-pmic.c                  |  272 +++--
 drivers/spmi/spmi.c                           |   17 +
 include/linux/spmi.h                          |    3 +
 include/soc/qcom/qcom-spmi-pmic.h             |   61 +
 13 files changed, 1372 insertions(+), 90 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/qcom,spmi-rradc.yaml
 create mode 100644 drivers/iio/adc/qcom-spmi-rradc.c
 create mode 100644 include/soc/qcom/qcom-spmi-pmic.h

-- 
2.36.0

