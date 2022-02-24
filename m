Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8C6B4C31DE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 17:51:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbiBXQt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 11:49:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230411AbiBXQtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 11:49:36 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 794661C7E8A;
        Thu, 24 Feb 2022 08:48:57 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id s1so558233wrg.10;
        Thu, 24 Feb 2022 08:48:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=RF2SupLnblRY3PGRxJOT5rLVt7yv2WyDPqmkS+jmfa4=;
        b=E4uZ0OPo0zvhVVJZ7wrHA1tPVgffTuvISwzw5kpxnNH/CdbMi5z0wyHtiW+E5EYSeN
         S1/yw4BR+Tue+16Np5zVUxWk0VBZYmOPqmg71TG28b6N3LFj8RVZfiiZW+X8hk6AstmO
         i6JfwZejNVyg9kni8iF827MH9jba2WeBK5KGkgC3loYK+FW0TTfrsgZmMln0B1QKzdpa
         lKVl71TZZHvZGwC7qAi2Wwp9np3FsXK8vzl0dOUjB4oAfG6iwvFpROWTbXlG2XSVvPHj
         RWAWRDGWhpLnQW2bGmUYyemdhbBMzzfWzmXs2rU1EsK9GEmx0y+MZdNng52spwpY3T3/
         QpYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RF2SupLnblRY3PGRxJOT5rLVt7yv2WyDPqmkS+jmfa4=;
        b=5M0Fj4p8ttt8WXrmBaQJ+z28flbdiZxIkJRYd1Ep9noiYhD4xkoXolFjCkrkxXAHeI
         Nql32LC6bjGBE9sl48XzeBDdKQ/Gbevcr5WPdGtctxOzpkLjHa8oUV3UaFQpTr+jBk5m
         mOtiMovbCwCG7IIl2ZMXbptRWlKYQ1PZHS1jMbFJc0cV+gVro5auZ+PQILhSjWH4iYxG
         uI1KUus7S6nYPJZWYxmA1Y+P0gfUHQR34ES+x3uFbQHm69FZag80nAhNGG8Uqm8nSQeL
         UnIa8qUcDR31w9NDwPl1TkcrdStNEnVDVe0153rw8u0hbUVvQ3u2j+aK8ELG/4yLblm2
         Y/9g==
X-Gm-Message-State: AOAM531RYdL2dHNKx6qt0dPC+pxOb74HT+/k8+qBXcpMddW7uJjIbcUj
        GUvx7/7me9bNv3llpZKefgs=
X-Google-Smtp-Source: ABdhPJyGAAVDPE53JabrDMREdhj+F1ROs2FzjB4+Dx21EWvAVRCm3MGVQ6JxmK/+0r1cjatd24YY9Q==
X-Received: by 2002:a5d:6f0b:0:b0:1ed:aac8:2853 with SMTP id ay11-20020a5d6f0b000000b001edaac82853mr2954054wrb.260.1645721335952;
        Thu, 24 Feb 2022 08:48:55 -0800 (PST)
Received: from Ansuel-xps.localdomain ([5.170.140.187])
        by smtp.googlemail.com with ESMTPSA id k18sm2694095wrp.104.2022.02.24.08.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 08:48:55 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Taniya Das <tdas@codeaurora.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 11/15] dt-bindings: clock: add ipq8064 ce5 clk define
Date:   Thu, 24 Feb 2022 17:48:27 +0100
Message-Id: <20220224164831.21475-12-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220224164831.21475-1-ansuelsmth@gmail.com>
References: <20220224164831.21475-1-ansuelsmth@gmail.com>
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

Add ipq8064 ce5 clk define needed for CryptoEngine in gcc driver.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 include/dt-bindings/clock/qcom,gcc-ipq806x.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/dt-bindings/clock/qcom,gcc-ipq806x.h b/include/dt-bindings/clock/qcom,gcc-ipq806x.h
index 7deec14a6dee..02262d2ac899 100644
--- a/include/dt-bindings/clock/qcom,gcc-ipq806x.h
+++ b/include/dt-bindings/clock/qcom,gcc-ipq806x.h
@@ -240,7 +240,7 @@
 #define PLL14					232
 #define PLL14_VOTE				233
 #define PLL18					234
-#define CE5_SRC					235
+#define CE5_A_CLK				235
 #define CE5_H_CLK				236
 #define CE5_CORE_CLK				237
 #define CE3_SLEEP_CLK				238
@@ -283,5 +283,8 @@
 #define EBI2_AON_CLK				281
 #define NSSTCM_CLK_SRC				282
 #define NSSTCM_CLK				283
+#define CE5_A_CLK_SRC				285
+#define CE5_H_CLK_SRC				286
+#define CE5_CORE_CLK_SRC			287
 
 #endif
-- 
2.34.1

