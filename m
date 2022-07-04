Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B62C55650D6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 11:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233804AbiGDJcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 05:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233883AbiGDJb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 05:31:28 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB90EDF61
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 02:30:39 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id z14so8487022pgh.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 02:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=580FSsVvcoP64wHucJMgx5sENeOjcD4XN2V8bHgQbsM=;
        b=KgsOmtPKN9WUoaAxvl1AF1Uv0/Xf8QcVkzGiVgcar2oqWRMsN08v9SObEK036O5nuN
         2HGFgdTMl84wa9DkNVzw4WmYdWr6apxvcaR+mVMgTubkerT77/lz97YCFmy44JDW9/yA
         oV42d2jAY6aWlfXHOrYZCxzd0hWbAcozrNalCd7SEKsrcjD52oiJvzaPiBHS0CMvA9co
         RlQk4JypG20W34dh+Rsy7g3byzQn1CwXt7G5bu/3H6jKyeOSCpXVuzOyYymC3MQIqzqt
         h9YQeusmkoYT8tlxWKEZ2oeXVhzEA4bpcND1tg+1kGX8XOoe0l+J/ocEs80x1wk7B2yh
         FEZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=580FSsVvcoP64wHucJMgx5sENeOjcD4XN2V8bHgQbsM=;
        b=oWHJzZ2TZ/N00GJvkO612ZA7KEjR2m1+J5u2vwqg7rHdReXqDhZKdTMcJzq6fI7qY4
         8GZ6xt2StE9WZvdCAY+AEwzAkFDQQlqlbSqaW+ihkTMvbHyfKhNG7MZmRtWtm4koMdsH
         ynVQ3zCFae3SLHvhRhdN7ECiDA8zz2Je2f2LUxTMmFZ1J+SsMa9AxHpo2foG5OaddEDs
         lkWpZI+/LriVS9Qy9XeSt6PamWRdufO7MJYLRPSQ8OPpNxMwFFhaVRp53BmpVOCjAcCL
         DIQmTgLg8FMQNo0mDAgpv1uplPcSJxDfjBTGOsIJ91Hjg1EZ5sLvbMEbMMeYLT2ski1C
         +nAA==
X-Gm-Message-State: AJIora+RykvLVNkxS9CBiQvcr6hwOPQAJ4cJnh4v6rkt0a5E0Dv6v5x/
        jYBLAIm8YIOjuKt3UxqKOBOawQ==
X-Google-Smtp-Source: AGRyM1tH3vwhajvPBg4leivOY9YJmC7TRn/tOB8Y7q/YI5W9oe+S899mpngi15lAG4QTUjfwcb+nbQ==
X-Received: by 2002:a63:6c4:0:b0:40d:d290:4a84 with SMTP id 187-20020a6306c4000000b0040dd2904a84mr23799959pgg.426.1656927038929;
        Mon, 04 Jul 2022 02:30:38 -0700 (PDT)
Received: from leo-build-box.lan ([154.3.32.171])
        by smtp.gmail.com with ESMTPSA id ms16-20020a17090b235000b001ef81bac701sm2926177pjb.42.2022.07.04.02.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 02:30:38 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v3 0/5] interconnect: qcom: icc-rpm: Support bucket
Date:   Mon,  4 Jul 2022 17:30:24 +0800
Message-Id: <20220704093029.1126609-1-leo.yan@linaro.org>
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

 .../bindings/interconnect/qcom,rpm.yaml       |   7 +-
 drivers/interconnect/qcom/Makefile            |   3 +
 drivers/interconnect/qcom/icc-common.c        |  34 +++++
 drivers/interconnect/qcom/icc-common.h        |  13 ++
 drivers/interconnect/qcom/icc-rpm.c           | 134 ++++++++++++++++--
 drivers/interconnect/qcom/icc-rpm.h           |   6 +
 drivers/interconnect/qcom/icc-rpmh.c          |  26 +---
 drivers/interconnect/qcom/icc-rpmh.h          |   1 -
 drivers/interconnect/qcom/sm8450.c            |   1 +
 9 files changed, 183 insertions(+), 42 deletions(-)
 create mode 100644 drivers/interconnect/qcom/icc-common.c
 create mode 100644 drivers/interconnect/qcom/icc-common.h

-- 
2.25.1

