Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86B5C4BADE8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 01:05:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbiBQX7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 18:59:41 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:38630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbiBQX7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 18:59:38 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3111622BD7;
        Thu, 17 Feb 2022 15:59:13 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id f3so11510261wrh.7;
        Thu, 17 Feb 2022 15:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=vT22BNhvWNrWcIFz/SRqR6yLshzUpgXQgOLovMBptOU=;
        b=bM8B6vC/eHIfkdXvjvjzL0Io3HKiXs0BA7aifVkhBrtTk4ngyHOIZvcyuEmvV5LwQm
         WdSUq34wTE1tqEtkkTraje0lPl/0xUcdLe/MPHjIFT3TOh0mh6qpGRBvKxg3sfSiafcF
         sS9XjOeXcMgD/UlM3mXU69hTehlbVxtFN2KholoVF331OQ8Kvp4O5RrpQ363kuNOHu6e
         qiTZD6vXY8pW9GadBxHwCgNNH5/1qO2a+d2jJmJgPg6U1G91vdLgRqGwwpNUjYx1CTWZ
         WE3xy81vHrKJg3Yq+lH+7f90WCoIQp/WT97uRz2+JhM3fMr9xhtPmYd3T078Mk76szBc
         +cwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vT22BNhvWNrWcIFz/SRqR6yLshzUpgXQgOLovMBptOU=;
        b=q/SXee97kJPaH8qqGAwWhbB0Hzw9tnqmpB7Kx+SUP5+r+Zf5h64DS1E8YFgjhgnppC
         Ztrl0/+gkX4fXoOcFFdBc6wUlplU40M26iPsInfyEXYGUDVQZAKLMveEuAKuV9NXBddP
         2m5mlpX/1JTZnKq50DQtAzZcKFO6Ah689x40+ssRZbr0thZkuKWGqRA2lL21bx4/Aw1F
         kHMucbG6m249LPZbPq3YuJBeHudbDhPtCNccruQAQMs2CQ3nG3I99T15GM5cFXYdcG47
         vo6lqLHUrijeUMZN48zXUpjxVpX9VbWfNPfbZNtbX+z+knA6j2Kd6YdnDdvJqDPkUTN3
         YHfw==
X-Gm-Message-State: AOAM530IkaYPXL7quSIKUam8hAYZqGPRPWBPvAjYFbIvIE/XoaWo7Aro
        PexeJ6lau7H7FROpy/n49vI=
X-Google-Smtp-Source: ABdhPJx0o0QEWI6rJv/9wEUhc/aYF1XXdO7EAOnqwF9+/FebyqXIwWI2GYV49YBmfR5KWqyhwgGkqQ==
X-Received: by 2002:a5d:6292:0:b0:1e7:8afb:73ea with SMTP id k18-20020a5d6292000000b001e78afb73eamr3944853wru.149.1645142238476;
        Thu, 17 Feb 2022 15:57:18 -0800 (PST)
Received: from Ansuel-xps.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.googlemail.com with ESMTPSA id r2sm3691694wmq.24.2022.02.17.15.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 15:57:18 -0800 (PST)
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
Subject: [PATCH v4 14/16] dt-bindings: reset: add ipq8064 ce5 resets
Date:   Fri, 18 Feb 2022 00:57:01 +0100
Message-Id: <20220217235703.26641-15-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220217235703.26641-1-ansuelsmth@gmail.com>
References: <20220217235703.26641-1-ansuelsmth@gmail.com>
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

