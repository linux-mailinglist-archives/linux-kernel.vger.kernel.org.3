Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E91C756951B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 00:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233372AbiGFWOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 18:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbiGFWOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 18:14:32 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B1D12AC61;
        Wed,  6 Jul 2022 15:14:31 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id v12so8326786edc.10;
        Wed, 06 Jul 2022 15:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JSxzmKxjlNqM9TSDpV5dH/r3annlSczSnTdVT/KLPhw=;
        b=bWUMnq4tpjt1TRHLVqok/mjo9jrbkzKfxraZRxWS9emH9/66Hfk5TZINBc4Ds5ou7J
         XvsYCfkf3Y7csLtj2rRdTkr+VLnbdJIgw/NUO2BNm0CUiBNPcIMdkFhLWQ63w+n2ZwlN
         oEjuMs52x2IYdwHioO4iRzDuoWsmkaia7U6SW2sHAkLYXv1EGQpOhKbUBISDJ7u62BVS
         57sKF46q1caHsGUsqFoRzvp0/InzfIzcEp1ZuYrJrcdcO63l1V27d3wtC7f2KbqeW5uE
         b2tzksTVly8OrtC/BkAbjOzJzpnNKlk1M7FmXLEXoK30TBQliXQ6TtZHgV4UF8pTHgWh
         m4fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JSxzmKxjlNqM9TSDpV5dH/r3annlSczSnTdVT/KLPhw=;
        b=L276BO4QgXFhwWU9+LC3Yp/ApH882C2DOPUFO79b4IELJ2t/OmeSUsBd4JnCM8iafs
         QSsGDoZ+i99400e8tj81lMIO+tutyvBPjpztn06DwkH+eaI7+lJs0Csy94BfR6LKNz+I
         LU+P6VQEvmttVm9g/h3OYM6gxMIqz4rddzJg+2IgLDICEo96iZcZ72F0iJuRDJJbHwNx
         gxaAutD7UZMsCpx4wRuLAikJKqb9DT60cESyellxH0RUUPhJlk1A+sn9wS5erlZ7FL0n
         Bfk5DiAXFd65xQ3U7eBjjWPxp+zvAsdZZEW8ODLUXLdWS6QBgCS86TV6EAl7Ms01rwpw
         t/Hw==
X-Gm-Message-State: AJIora/thA/lZUFfTYDCgGKyqEWw2U13rtTFE2ZR2fVdLUUjLC3zxbWf
        pCshncYhAmwTrBnWElbqZ9xDzpQmlZ4=
X-Google-Smtp-Source: AGRyM1sIHMQf4YpUUtNHuu7zGZhMY5ZNbvBnFdKhyN+fUTMN9K/LJWrfSdpo8Oh8gJYIK7xMi4NafA==
X-Received: by 2002:a05:6402:795:b0:43a:6cc5:8886 with SMTP id d21-20020a056402079500b0043a6cc58886mr22184646edy.174.1657145669408;
        Wed, 06 Jul 2022 15:14:29 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id h18-20020aa7c952000000b0043a6fde6e7bsm6509469edt.19.2022.07.06.15.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 15:14:28 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 1/3] dt-bindings: clock: add pcm reset for ipq806x lcc
Date:   Thu,  7 Jul 2022 00:13:25 +0200
Message-Id: <20220706221327.14169-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.36.1
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

