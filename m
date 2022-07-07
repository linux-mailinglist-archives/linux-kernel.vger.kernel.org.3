Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D03E569F37
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 12:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234818AbiGGKNj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 06:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234494AbiGGKNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 06:13:37 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4523963AD;
        Thu,  7 Jul 2022 03:13:33 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id r21so2767075eju.0;
        Thu, 07 Jul 2022 03:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JSxzmKxjlNqM9TSDpV5dH/r3annlSczSnTdVT/KLPhw=;
        b=LMD2tcEGHar5a4MhmPO61wUfbZswPmFpFYxW9zo9fiIWy3jOX7ASwleROrm1damjrW
         hcT5QxAE7fF+kQnaL80zIAuidgovPDlNM2PLL7/6+gKA3K2Coo3ZoPYrBxDiAzXrjq1i
         HTiVPpLYZZzVtIDMYayYJWi/EBEDWa+cElXELL/SkaMo1AEJp24yPhivXmNZah1wvTn+
         K5ACLYU2cTkPXtwTB5kLyTAwF6RueKzXYCzIPDDlO42mOY4LPenedkgrd/ZnU86h2+GS
         NNm7yGb08ERdd5/Rfq4qRZgehNmUBq4t6LxTN5qR9theNK0oNTC5OfWBOoVwDOlryG6L
         c0yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JSxzmKxjlNqM9TSDpV5dH/r3annlSczSnTdVT/KLPhw=;
        b=P+tuW9XbM/9jNoXBgLFm2QJ9FKTdNBXlRHd23dWP1hLhT5QCEcHCObh+UHxk7ujbyA
         NH+BjsIWK3fu0iiyOqpPhQ/E6uFJ3hnwWhnFC2PcQ6J2OxIn8SmDwKxZrqgLeNXjK7u2
         pmtTLh4noBbtIPiYHnJ98O1FU8WlchAdy2xb2th7lUy3gfkfh/tlWa6+4rZ4KnHqm5E+
         u4cM0gMdfTrrLw/varegkxEsyTCI35uRzJM0oIKpcWsmG+5sXvkFOMVnh8QWESxCSFha
         wFcAm77x8iUpcbNzxP+XQybehyBChvs0+96HYUlqhKLF/Im1Id4IGMOipBjFDPZotdyS
         GN9A==
X-Gm-Message-State: AJIora9e9V7KFXUnJbWFd9gH6/VpeDEBQfeKK5dLWdr6SIR63nX8TM4q
        zB+w4ijkR89nTJb2n3ZtdQ60mZVJm3I=
X-Google-Smtp-Source: AGRyM1tp3F0M/dSUE7qDpjMoMY9zJyAP8CT7r6UXzPz39biEttTPUe/kix98/U5Doa1K4fOrDQOfAA==
X-Received: by 2002:a17:907:1629:b0:72a:d6b6:8c96 with SMTP id hb41-20020a170907162900b0072ad6b68c96mr16516134ejc.423.1657188811564;
        Thu, 07 Jul 2022 03:13:31 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id kv12-20020a17090778cc00b0072ac3f06615sm6235747ejc.133.2022.07.07.03.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 03:13:30 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 1/3] dt-bindings: clock: add pcm reset for ipq806x lcc
Date:   Thu,  7 Jul 2022 12:13:24 +0200
Message-Id: <20220707101326.30880-1-ansuelsmth@gmail.com>
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

