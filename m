Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C724755008D
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 01:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382099AbiFQXSx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 19:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358481AbiFQXSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 19:18:51 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 290CA64BCE
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 16:18:48 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id h34-20020a17090a29a500b001eb01527d9eso4508075pjd.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 16:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L5VJMQFQuBE4SqSUMrFo93pnwhbO/r/KnkFGijwP654=;
        b=D9q5XhwKGuBXqDdFf4ZKxhqj4jBTqavmRDHyVTtRdFWOhsLsspGOmpTOlKlqOzDs6D
         IQOQ1RLxN8PQOhd4BlDfXvdzqEJUuYesp7Edis7uc/i8I7CYL9Yg9e/xFz57lmGgHl2V
         Z2yxAlWYAey7MW2Hy3EnIjBHPQhrMUjJkAf2A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L5VJMQFQuBE4SqSUMrFo93pnwhbO/r/KnkFGijwP654=;
        b=aSHyXMAGT0POhE5Xd61e3YRHLOqzvPLKBsOQWgYlsvmTbRKacCZiCOR0rzJmcfbfAc
         ZqZ3nC+/TKDYMAq5HX87EiB6FaYkqIL4HS4qz7ew9ycmFyEk5fSIDZT1AbM387MeLH57
         /vucveb0BYoNRiIj/LQAdo9X+Gy2N/KNyjuqjIXtb7D2S3eN2U6hzZZ+p4VOktaNsF2t
         yqBJqmneaMWkPKoLfU1jVMEIac7uG3RhzJUsYyCpWTKCP+h2FDZ47B0tdJa5q09zJqu9
         pOmcnqokDoTgbijmzgsNVIAW+IrdR5xVMNob8Yx3eb/C0TlJKdgS8SnULsDCH7D/1brJ
         gvSA==
X-Gm-Message-State: AJIora+hb+vu4rudNvBRhIstPG/2FA3SlF+MBqP9G/prgHHdfuUNLYKI
        n/5BRBZKney4kCYfWPsdFJffP09fUOMh/A==
X-Google-Smtp-Source: AGRyM1tstSkK9CnQf36BBjmq5jsms4lDlAdI0SFFDUaoecgEE/QEyvASJqJ6KqLiZQESKnT20Zz5zw==
X-Received: by 2002:a17:902:d2c9:b0:163:bdee:b2df with SMTP id n9-20020a170902d2c900b00163bdeeb2dfmr12210994plc.98.1655507927420;
        Fri, 17 Jun 2022 16:18:47 -0700 (PDT)
Received: from joebar-glaptop.roam.corp.google.com (c-71-202-34-56.hsd1.ca.comcast.net. [71.202.34.56])
        by smtp.gmail.com with ESMTPSA id l8-20020a170903244800b001689e31ff9dsm2276749pls.9.2022.06.17.16.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 16:18:46 -0700 (PDT)
From:   "Joseph S. Barrera III" <joebar@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Alexandru M Stan <amstan@chromium.org>,
        "Joseph S. Barrera III" <joebar@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v6 1/6] Simple version of Stephen's patch.
Date:   Fri, 17 Jun 2022 16:16:40 -0700
Message-Id: <20220617161622.v6.1.I4deaec603e855815b517a68f8dbc77b150886c42@changeid>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Joseph S. Barrera III <joebar@chromium.org>
---

(no changes since v1)

 arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi | 2 +-
 arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi
index 9b3e3d13c165..d1e2df5164ea 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi
@@ -5,7 +5,7 @@
  * Copyright 2021 Google LLC.
  */
 
-#include "sc7180-trogdor.dtsi"
+/* This file must be included after sc7180-trogdor.dtsi */
 
 / {
 	/* BOARD-SPECIFIC TOP LEVEL NODES */
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi
index fe2369c29aad..88f6a7d4d020 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi
@@ -5,7 +5,7 @@
  * Copyright 2020 Google LLC.
  */
 
-#include "sc7180-trogdor.dtsi"
+/* This file must be included after sc7180-trogdor.dtsi */
 
 &ap_sar_sensor {
 	semtech,cs0-ground;
-- 
2.31.0

