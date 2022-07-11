Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB8CF57013C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 13:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbiGKLxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 07:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231225AbiGKLwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 07:52:54 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B45526ACA
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 04:52:52 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id g4so4556853pgc.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 04:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IT6bnfMyBorw+49wZozfoU6MUehJRZf9hememagooxg=;
        b=m9fKb8SOEPmRpvJUEaFB8Bp6mooUCxzh1kDecueyx/hGEXEMe4FQgGHJ/av4sCGRWk
         hVGwapeMF3Ayxf1liMcuSiOOSf7VrCAnisII7KXiRdgOLbMW5KfWR6+uGqa7PqY0NLbt
         PE3Obqve1rOR5CxZaQpaWYqZlaUK9FNO7D6+RCEIEEovHlKga84TgEF/4fE3/IYLYwwo
         TK6Lngw/ujtxVxdALIwTWbCSbgRC5O7L1LzK/MQa9a0l+M0gO+RaD6MT7ji0axnNSoqY
         tD5CZcHifnRbsKtWl/J2HVsVt85JTgQDtwXswXcVUYq6KfoB0ykdnCvJ0LykDmO4it7f
         NH0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IT6bnfMyBorw+49wZozfoU6MUehJRZf9hememagooxg=;
        b=mBf7o8rHxtyLhfHdZmLe9x2JrDkh/cROCnA74wHtQ9vZZQ+85+q3A0RwzRg5QCZBwI
         k8gV7uD3neWviGONf1IQW8TucHtmB0AcCVRTe+g2a7+nEwBT2tdsWoULRo5AgijhnW5o
         lKhjlxM2zFgdSm/JLUUF2WMPZzQN6oyOhMGAuoVC08bBR8BNJpII1liGgBwYCjl36lh4
         J6pqhpkkYHcRGhjeAUUeGJTeOp1toVXQ1NoNCky9JZGwrqwBMHkkZ0uZdrMkW3hcaQGf
         4PyP8oK2bEjfK6/XbRcTMaUFnLj2Dzwz8kmS3V2SnjpbMmFohumO+oZ0PEx4ayEb9vlh
         C9jg==
X-Gm-Message-State: AJIora9jRzlwTGhX94GPAMPOyO4PLMBl+VYHQQ0OiO7KIFVTEdak2iIr
        09TsnJ+BCw3bVLYTl/VyDuaGVA==
X-Google-Smtp-Source: AGRyM1v1eihj78aPHcT9tIZ0bs0xq5JvJcgQfTJHIDOgqGyxrt23hFKUSIltMelH/gN9b7lieOudTQ==
X-Received: by 2002:aa7:954a:0:b0:52a:bd44:d15a with SMTP id w10-20020aa7954a000000b0052abd44d15amr10936464pfq.35.1657540372026;
        Mon, 11 Jul 2022 04:52:52 -0700 (PDT)
Received: from leo-build-box.lan (n058152077182.netvigator.com. [58.152.77.182])
        by smtp.gmail.com with ESMTPSA id h14-20020a17090a648e00b001eaec8cea55sm4586502pjj.57.2022.07.11.04.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 04:52:51 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Georgi Djakov <djakov@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v5 0/5] interconnect: qcom: icc-rpm: Support bucket
Date:   Mon, 11 Jul 2022 19:52:35 +0800
Message-Id: <20220711115240.806236-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set is to support bucket in icc-rpm driver, so it implements
the similar mechanism in the icc-rpmh driver.

We can use interconnect path tag to indicate the bandwidth voting is for
which buckets, and there have three kinds of buckets: AWC, WAKE and
SLEEP, finally the wake and sleep bucket values are used to set the
corresponding clock (active and sleep clocks).  So far, we keep the AWC
bucket but doesn't really use it.

Patches 01, 02, 03 enable interconnect path tag and update the DT
binding document; patches 04 and 05 support bucket and use bucket values
to set the bandwidth and clock rates.

Note, this patch set is dependent on an out of tree patch "interconnect:
icc-rpm: Set destination bandwidth as well as source bandwidth" [1].
With the dependent patch, this patch set can be cleanly applied on the
Linux kernel master branch with the latest commit 32346491ddf2
("Linux 5.19-rc6").

[1] https://lore.kernel.org/linux-pm/20220707093823.1691870-1-bryan.odonoghue@linaro.org/T/#r304f7b103c806e1570d555a0f5aaf83ae3990ac0


Changes from v4:
- Added Krzysztof's Acked tag for DT binding document patch;
- Fixed the unalignment between function qcom_icc_pre_bw_aggregate() and
  its comment (Georgi);
- Simplified qcom_icc_bus_aggregate() with removing unused parameter
  'max_agg_peak';
- Removed unsed local variable 'max_peak_bw' in qcom_icc_set() (Georgi).

Changes from v3:
- Removed $ref and redundant sentence in DT binding document for
  '#interconnect-cells' (Krzysztof Kozlowski).

Changes from v2:
- Fixed for DT checker error for command ''make DT_CHECKER_FLAGS=-m
  dt_binding_check' (Rob Herring).

Changes from v1:
- Added description for property "#interconnect-cells" (Rob Herring);
- Added Dimtry's reviewed tags for patches 02 and 03 (Dmitry Baryshkov);
- Rebased on the latest mainline kernel and resolved conflict.


Leo Yan (5):
  dt-bindings: interconnect: Update property for icc-rpm path tag
  interconnect: qcom: Move qcom_icc_xlate_extended() to a common file
  interconnect: qcom: icc-rpm: Change to use qcom_icc_xlate_extended()
  interconnect: qcom: icc-rpm: Support multiple buckets
  interconnect: qcom: icc-rpm: Set bandwidth and clock for bucket values

 .../bindings/interconnect/qcom,rpm.yaml       |   6 +-
 drivers/interconnect/qcom/Makefile            |   3 +
 drivers/interconnect/qcom/icc-common.c        |  34 +++++
 drivers/interconnect/qcom/icc-common.h        |  13 ++
 drivers/interconnect/qcom/icc-rpm.c           | 129 +++++++++++++++---
 drivers/interconnect/qcom/icc-rpm.h           |   6 +
 drivers/interconnect/qcom/icc-rpmh.c          |  26 +---
 drivers/interconnect/qcom/icc-rpmh.h          |   1 -
 drivers/interconnect/qcom/sm8450.c            |   1 +
 9 files changed, 176 insertions(+), 43 deletions(-)
 create mode 100644 drivers/interconnect/qcom/icc-common.c
 create mode 100644 drivers/interconnect/qcom/icc-common.h

-- 
2.25.1

