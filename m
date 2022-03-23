Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 537EB4E5C3A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 01:12:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346751AbiCXAON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 20:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiCXAOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 20:14:08 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F10AFE73;
        Wed, 23 Mar 2022 17:12:37 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id a1so4367068wrh.10;
        Wed, 23 Mar 2022 17:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/J+7k67HIa20DrfFo2NZzVdI2EGmtq275w1giXcVqMg=;
        b=aX7p1KgXTAPQI9KVgmJz86DFHJvwHj/22QzWJxFYKV+H5EEDKfPyv9MsDGu9ulX0Al
         khcAN99RaFvggO1wOv/K/I27zC1DPjZXxkSrMmIIPzPyCfsG+F76aPa+Pp5fBFBYobUt
         mu0bcqmW9kE55KNDY+lWK5X9UEWxkrG6Ijb6t1D0feSrFYlCj683uyYARj7lsQWS0BC0
         f4Z/AhoO5mRAZFLEwK1KDVb5bfACaEV/AyUALHU0WSmpPvzZhNc5Qi3DCY8+byocF8dz
         YKQkkUTvJXV1+mEFY0CafLsRRkCi6Qi0j+nwUgAQb/vSuWw5DohLenFZhXFG25yU1thI
         MYQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/J+7k67HIa20DrfFo2NZzVdI2EGmtq275w1giXcVqMg=;
        b=gMoeDjwbp0nZTl7U/fpugZALrJrsFTQWDnGw0av51chZ0NYxt0xME/ZKaeTOPpv/At
         gvoKFTxKeS6PHVvZyRHwmp1HmkbTlFFKcXmJqN3q5i1ZWy+YKUSJmNLM7FsMomqpWup6
         XgdGx519kiFmpAVjFMsungKHhuax6BbGqPTP0Bp8dxuePVJ1SSl4ia3359EbDAl5uBoL
         lfdu94AUuBfFDa1FRzUjKGZV10q3Li+k5jD86LA8+3EFb9OEGhZEcBUzToV7K09HzJZs
         4CesZmgqQT0iBFY+glG+VC3KN3Qd1EZI77Fvmwe8Xlr9OhMcE1TQzM+X5Gm7tyL/ubW3
         0Wow==
X-Gm-Message-State: AOAM532OHqaamg859hfA1/A/RmqIHdQJe31y/NfiormjebvC//aYjhO1
        d4FzyZu4lr3ISTYbEv/UigNQSPCYGvc=
X-Google-Smtp-Source: ABdhPJxSxAzqMRccmd40N0pwlBUxRZGY1074kjwxy9DJTuBtXtj9TRvIROv1gUaKQI7JxeQrcDP8Vw==
X-Received: by 2002:adf:f28d:0:b0:203:f161:55ac with SMTP id k13-20020adff28d000000b00203f16155acmr2252918wro.209.1648080756298;
        Wed, 23 Mar 2022 17:12:36 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-42-69-170.ip85.fastwebnet.it. [93.42.69.170])
        by smtp.googlemail.com with ESMTPSA id bg18-20020a05600c3c9200b0037c2ef07493sm1058665wmb.3.2022.03.23.17.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 17:12:35 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Taniya Das <tdas@codeaurora.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: clock: fix dt_binding_check error for qcom,gcc-other.yaml
Date:   Wed, 23 Mar 2022 20:42:48 +0100
Message-Id: <20220323194248.26970-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

qcom,gcc-other Documentation lacks a '|' for the description. This cause
dt_binding_check to incorrectly parse "See also:" as a new value.
Add the missing '|' to correctly parse the description.

Fixes: a03965ed1310 ("dt-bindings: clock: split qcom,gcc.yaml to common and specific schema")
Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 Documentation/devicetree/bindings/clock/qcom,gcc-other.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-other.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-other.yaml
index 4dc0274dbd6b..6c45e0f85494 100644
--- a/Documentation/devicetree/bindings/clock/qcom,gcc-other.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,gcc-other.yaml
@@ -10,7 +10,7 @@ maintainers:
   - Stephen Boyd <sboyd@kernel.org>
   - Taniya Das <tdas@codeaurora.org>
 
-description:
+description: |
   Qualcomm global clock control module which supports the clocks, resets and
   power domains.
 
-- 
2.34.1

