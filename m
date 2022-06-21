Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FFB15537DE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 18:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352926AbiFUQdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 12:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350998AbiFUQds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 12:33:48 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 073C9140A1;
        Tue, 21 Jun 2022 09:33:48 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id v1so28608230ejg.13;
        Tue, 21 Jun 2022 09:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=15+HpU1LWB4LAxkhCvwaxGq511OUYw5iXFZyQQCZrLo=;
        b=BJAfwfXXspb75BwMg2QxmS5n7niNvezSsSqBCKW3I8ZCwPSM9OyvwwSFX9jD2vNkXZ
         cFHY2lKdLK5kC2/LsWLwDFUm4JswWIcvzVOkifFW9NtFZyrMUaoBpIWkOE6srRiBLJe/
         9kc5ksfBTy7+8BXgES44LJb7oYk/pdWfMjxKcT3zZmjeraCLkfG9X8V55665S7U3LSiH
         2CrLrjDKA3gF6ifIkUzpiix/jvvKwr5tO0rBtOJwPaFtyXiJXtiJZg9bUYAOpBIkWOyt
         FpxDf/U821rQJE57MApy3Psb+tU2j8vtqEY93K6mn7UjvUblkndFJq8pRwGv8R0U9f8C
         d5lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=15+HpU1LWB4LAxkhCvwaxGq511OUYw5iXFZyQQCZrLo=;
        b=CgU8lEeH8H5ygJkgc2lDYUYJmUhXFBHpFey/BNcbTQkqN4xmKURJQVRcmE4GD1y7Nr
         l8sh/UEzjII8vej4AzkDWvwuUpHHBg4az8k2g73MqivvZiiyNtt0cjpnDLopj0LkvnpY
         pN2l6SJPx3mrC2pSKv6olmhNKoA3OIvdLjwj0+XgW4JCmze6Xfv+ZLjAkM3grGHQgCO2
         AdFj020BAty/3JZKct/Y08aeRfEx/cqFlkC6s2XfSglrv7ZUKAM+fqgyCVcpNhZPbqbb
         hkyiKg6eWKh8jEgHfpTCo/EtZMUDJAFijo5vjmDFHYBTw0Br3o5OLomxCYTqYOV3h21d
         +LbQ==
X-Gm-Message-State: AJIora9xoGnlkn+aLXibHC4mYuy0P0mhTHdM1gRGH40UflvaZzLFZL2Y
        VmSaHkaszLiX2LIZhtCN9e4=
X-Google-Smtp-Source: AGRyM1v5QMgQTDCniTHaBREuzbUpJe/GwTAtweqPyHDGkHtmFVtH1vCYMJdfCrhcTbOs28ZLswTsTA==
X-Received: by 2002:a17:906:73d7:b0:722:e88b:1b31 with SMTP id n23-20020a17090673d700b00722e88b1b31mr1523243ejl.350.1655829226298;
        Tue, 21 Jun 2022 09:33:46 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id g5-20020a50d5c5000000b004356c0d7436sm9557663edj.42.2022.06.21.09.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 09:33:44 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH v2 1/3] dt-bindings: clock: add pcm reset for ipq806x lcc
Date:   Tue, 21 Jun 2022 18:33:24 +0200
Message-Id: <20220621163326.16858-1-ansuelsmth@gmail.com>
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
---
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

