Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5360C57EFDE
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 16:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236938AbiGWO4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 10:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiGWO4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 10:56:04 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8118CC29;
        Sat, 23 Jul 2022 07:56:03 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id g1so8874283edb.12;
        Sat, 23 Jul 2022 07:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JSxzmKxjlNqM9TSDpV5dH/r3annlSczSnTdVT/KLPhw=;
        b=Ci/8784Th6shNIq9MybffNf+/ze500Ci6XwQIr/9wvzIYV5DMQTHa7Gx8cOETmA0X+
         Vh3ynnxhg5VWGXUMzrJm+dfHH0ZCJcPDt0CalKGqwxr1LCrXDE4j/1CkCeWtMkbXpbrX
         sijdgkJvhZtulYKyrsVb5QSMcuxuuql23EhOTLNdJg07uANubwIyvE1MtcMJXhXFG6v4
         NYYkd6/Gl9LYF0sjphn7IyCZD/bYU/aCKgHCsqZU4/TtbeZYcaJ8Ycp57HEyb6Ro7jQO
         fHn/5m6EoBi5aX+yToRNEqK36gbQXLtgYeadxNyBWFSP9Y91sxIRK19A/DEBCeqGHDqf
         LLEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JSxzmKxjlNqM9TSDpV5dH/r3annlSczSnTdVT/KLPhw=;
        b=fcOBgQoQhCSTrantY0Fep8R5Hkhma+rWBzLau/htRyG5PIC+l32nyL18tC0PY93URi
         GtNYyIGMWC3xYs27ZAvpjTDyRLd57RNj/dvSMIj598n5Y72QaBI9kqDiT8843dNhwtgV
         rEfuX7B4iwMPzbGQMeKQyyOsSOK+f4Bw2pzXNksS4nBC8rLbMETwuX1S18hafmAhcmCc
         wBnWKetxdnGVu1VM/iUmCE3TeaupWS0GpflKEzYkUoSQL2W9b80kiJY49mrsPQOAyAgP
         2BN8X37mAkEYLFxtyx+jL0kIluKowL90vKEGggjqgJX9ebKr4pwfv8dmXWzihICOZW8v
         bHHw==
X-Gm-Message-State: AJIora+RN30vjJ1Rn7J88wKWBwBfjrDJ+1jxmFI1FWrHmGutrmc91gOm
        nNK9EnGOYCdABLD4rri/SEw=
X-Google-Smtp-Source: AGRyM1svGBQm8o/vHZh+k4JHCekqFN+vfcSGobyHkEzWj6qxW4FvY4cABfx0prHfMW79df6QR3Q+fg==
X-Received: by 2002:a05:6402:5513:b0:43a:b866:b9ab with SMTP id fi19-20020a056402551300b0043ab866b9abmr4860586edb.290.1658588161719;
        Sat, 23 Jul 2022 07:56:01 -0700 (PDT)
Received: from localhost.localdomain (host-87-7-207-127.retail.telecomitalia.it. [87.7.207.127])
        by smtp.googlemail.com with ESMTPSA id cy24-20020a0564021c9800b0043ba1ecb0dfsm4143781edb.75.2022.07.23.07.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jul 2022 07:56:01 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v6 1/4] dt-bindings: clock: add pcm reset for ipq806x lcc
Date:   Sat, 23 Jul 2022 16:55:55 +0200
Message-Id: <20220723145558.25210-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pcm reset define for ipq806x lcc.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>
---
v3:
 - Added review tag
 - Added ack tag
v2:
 - Fix Sob tag

 include/dt-bindings/clock/qcom,lcc-ipq806x.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/dt-bindings/clock/qcom,lcc-ipq806x.h b/include/dt-bindings/clock/qcom,lcc-ipq806x.h
index 25b92bbf0ab4..e0fb4acf4ba8 100644
--- a/include/dt-bindings/clock/qcom,lcc-ipq806x.h
+++ b/include/dt-bindings/clock/qcom,lcc-ipq806x.h
@@ -19,4 +19,6 @@
 #define SPDIF_CLK			10
 #define AHBIX_CLK			11
 
+#define LCC_PCM_RESET			0
+
 #endif
-- 
2.36.1

