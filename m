Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06EA15032D9
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 07:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbiDPDBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 23:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbiDPDBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 23:01:18 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC215B3C6;
        Fri, 15 Apr 2022 19:58:47 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id s18so18255400ejr.0;
        Fri, 15 Apr 2022 19:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cKj4GsjkvCLxphsJLv+6Hci1YlI8gLSSD4ZLBL6UMd0=;
        b=SVa9E9Xy76r8k25gbN8Q/LINPOLriAA1UsCaTPjz7ZbH3Jatqtea/kE9HQ8OPEwTc+
         nDxGkPKJkxRAqjDbn0rIFAfT4/ZmPoOdfqms+o7MG7ywExI6TBF/Fm4NW8U9mNRL1wfe
         NQAoScYa4dXp1KzbTY7RQNAxAakOdB67YWS+u4W8d1AjJPbjiydZl/LnQT4s0aNR9jSt
         wGB9cJihRCZOFi/TJT1oH1EmBEvwsuClaWNHaLoRwJ5z1xZtJXDE81zUUyIhdZ2fCsBv
         9+fYMLXotuTtdVZuDA99UgpdYLok4JY435S6JO2hMMOOFmWqslGTN8GA6lSquCh9oR5q
         tfGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cKj4GsjkvCLxphsJLv+6Hci1YlI8gLSSD4ZLBL6UMd0=;
        b=LKYRqyC+tWpYWqFELKfHBumtAbOg3L7HmKHOUU0u4S+EpoMG+GGNq1bVFga0++m+lY
         OlY/GJBG/f/OwDEPEUzIdbhoaNrQL31JKNI8IcsFXWrvMQ6CEqF1Tc1jVSzW/vyvHntT
         th5KmCk4y4KrpWib5v/5L5Lu1TNsit6MIP6D8e6syMdzTFA9JmZ1oTAo6Wenjxu6WXvW
         pPohSLyBK5W2SDx34uXupSMpDG0FlJZZ2igumHy9+S+f41HgNJfOJ6umJlnnQLlTm0ld
         cZxPF6+TadY7PA0zaXI3iS049hu0suP4axdvy0l/UFiJGSteLyQ41NX/MsBG5pI3VQRt
         KCdg==
X-Gm-Message-State: AOAM531PkyDhA2BXhI5y9MtgUDJCQu8f73KWkcrmR6HlyxpyrtUOeNNZ
        ZhTMcQyCx/v02awa2b+SjGw=
X-Google-Smtp-Source: ABdhPJwzNioJqGCDFqkl0SU3Yb9EiGQefjo9Uq/jObUZx9M+SnNfIcEm2CeIHmhMTjw7D6wfwllhKQ==
X-Received: by 2002:a17:907:3f10:b0:6da:818d:4525 with SMTP id hq16-20020a1709073f1000b006da818d4525mr1307011ejc.47.1650077925985;
        Fri, 15 Apr 2022 19:58:45 -0700 (PDT)
Received: from localhost.localdomain ([138.199.7.159])
        by smtp.gmail.com with ESMTPSA id oz20-20020a170906cd1400b006e872188edbsm2200915ejb.104.2022.04.15.19.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 19:58:45 -0700 (PDT)
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH RESEND v2 2/9] dt-bindings: clk: qcom: msm8996-apcc: Add MSM8996 Pro compatible
Date:   Sat, 16 Apr 2022 06:56:30 +0400
Message-Id: <20220416025637.83484-3-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220416025637.83484-1-y.oudjana@protonmail.com>
References: <20220416025637.83484-1-y.oudjana@protonmail.com>
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

Add a compatible string for msm8996pro-apcc.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/clock/qcom,msm8996-apcc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/clock/qcom,msm8996-apcc.yaml b/Documentation/devicetree/bindings/clock/qcom,msm8996-apcc.yaml
index 325f8aef53b2..ad77175dda45 100644
--- a/Documentation/devicetree/bindings/clock/qcom,msm8996-apcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,msm8996-apcc.yaml
@@ -17,6 +17,7 @@ properties:
   compatible:
     enum:
       - qcom,msm8996-apcc
+      - qcom,msm8996pro-apcc
 
   reg:
     items:
-- 
2.35.1

