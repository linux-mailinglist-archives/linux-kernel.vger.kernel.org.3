Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6586F4C5649
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 14:55:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231983AbiBZNyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 08:54:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232098AbiBZNxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 08:53:43 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C4CE128DFD;
        Sat, 26 Feb 2022 05:52:56 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id a23so16118743eju.3;
        Sat, 26 Feb 2022 05:52:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xUinUfzWAn8Shwd3VIGBacyRnb4H1vz5iJqyyM2Q3P4=;
        b=p8RTQeNZz1hfw1KjP5ls0ncg4N57Ftc+oj1NFm71i/qPklPnEbWCWzgqcL/Qp0kD3G
         8mFqXiF3Bo41G3bFP5wwVdDEy7c6p78kQeSRHxeYj29miIKRvLuy24cjBHLOW6fdjuh4
         9YFONQajWL69JrKzBZBhApjbpaPZAZzE+oGDsA6AWLiUatCbgpoLozsaiQn9y47q9sNI
         iKYVAwtRlIjrEsRfOGnsA9+dSPuPKKLx030s6XwUvHwwKhUXnHby7/xRIJaX6Ex6VWkN
         +ZyaWqH6469J5Z+sT9NhZNxOE24WOmhQv6uHRPugdvgipnrj/GTVs7AYPHybzRmKRkET
         mfbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xUinUfzWAn8Shwd3VIGBacyRnb4H1vz5iJqyyM2Q3P4=;
        b=xK6JiHfwyHMqsaBRc7yLdElROMqYgrzsZzAwiKDrqKrooLnFx3jSZoQcPqFsm+pE7L
         SJZWPxSa6n35/NlgbekfC5BQc/pF0Gy7yPsqS4uB3Aox4VBhyys/UnsdJTj5TiI5GZXF
         HJ1WtVxD/mtX/Z/tfxz+6HY/9MRFuk6b1KtRCaRiUpumJgbcOMxihENDQjhPSQ/l25Xx
         Cg6DNSoeMjr1Db1r1flwWESfE5MG61fYxvYqrsv5UfqSwSo3GCVAV2hYKPhQc92DP7s+
         l8w+8gz5W/qlFKMlQhAWEVrLsOOjt9s3VL4QrGn1OmUGmpAzeaMt6a14yOif2Td7FUJE
         i66g==
X-Gm-Message-State: AOAM5329PnQhEvS1k4udLIJWyQdwHzz8kEm15b8CBWp/PLxYFRASykR8
        Vy4KQh5Z5NMyAvzi0R08DoI=
X-Google-Smtp-Source: ABdhPJwnv39lt7d2a0hLTVpubhDaMNeW4yi2QpgcBEi7n/izQNoo9iQj4+TZEnI40olp1dx8693yVQ==
X-Received: by 2002:a17:907:b590:b0:6cf:48a4:9a4c with SMTP id qx16-20020a170907b59000b006cf48a49a4cmr9424990ejc.6.1645883574494;
        Sat, 26 Feb 2022 05:52:54 -0800 (PST)
Received: from Ansuel-xps.localdomain (host-95-251-226-220.retail.telecomitalia.it. [95.251.226.220])
        by smtp.googlemail.com with ESMTPSA id j21-20020aa7c415000000b004127ac9ddc3sm2836369edq.50.2022.02.26.05.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Feb 2022 05:52:54 -0800 (PST)
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
Cc:     Rob Herring <robh@kernel.org>
Subject: [PATCH v6 13/15] dt-bindings: reset: add ipq8064 ce5 resets
Date:   Sat, 26 Feb 2022 14:52:33 +0100
Message-Id: <20220226135235.10051-14-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220226135235.10051-1-ansuelsmth@gmail.com>
References: <20220226135235.10051-1-ansuelsmth@gmail.com>
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

Add ipq8064 ce5 resets needed for CryptoEngine gcc driver.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Acked-by: Philipp Zabel <p.zabel@pengutronix.de>
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
---
 include/dt-bindings/reset/qcom,gcc-ipq806x.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/dt-bindings/reset/qcom,gcc-ipq806x.h b/include/dt-bindings/reset/qcom,gcc-ipq806x.h
index 26b6f9200620..020c9cf18751 100644
--- a/include/dt-bindings/reset/qcom,gcc-ipq806x.h
+++ b/include/dt-bindings/reset/qcom,gcc-ipq806x.h
@@ -163,5 +163,10 @@
 #define NSS_CAL_PRBS_RST_N_RESET			154
 #define NSS_LCKDT_RST_N_RESET				155
 #define NSS_SRDS_N_RESET				156
+#define CRYPTO_ENG1_RESET				157
+#define CRYPTO_ENG2_RESET				158
+#define CRYPTO_ENG3_RESET				159
+#define CRYPTO_ENG4_RESET				160
+#define CRYPTO_AHB_RESET				161
 
 #endif
-- 
2.34.1

