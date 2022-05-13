Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0318D5265CC
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 17:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349749AbiEMPPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 11:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381173AbiEMPPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 11:15:33 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0504654018
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 08:15:31 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id u3so11896215wrg.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 08:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4kMBq3ML8i4Cw0yoGEU+fJc6+bgjz8wLr/JmgXqi+0Y=;
        b=sSPnHzKsfAMHfdJZEceCGudvpiXtlhgaJ1KH/jFERZw+Cwc4GNQJYDOsKkIwlRr1SG
         zkWovpQQtEag6AdaxK7LyAXiyW4g8aA5dcLn+9igMe8Z3FYGQlwHPZ1wvRN/wEYYdiHu
         hMkkGjyQ+Tg2fqdGTUSLDTrNDPk2ljGdh5zd3aZlkZJpJe6aTklZSUiwHBRbGGHQYQGu
         ok9S/0Q9HjL69n9v7eso0j2N64NbQr2B6Zd/FL9ssgXm67yxf6bgcK+dfcKAnLT9EwdE
         5ObekqAsaYhfBzkthbhzG+YTC8/USyXkFJr1R21N2xOWBQa1TszxvMOXXJCCK3dpGgXF
         HzhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4kMBq3ML8i4Cw0yoGEU+fJc6+bgjz8wLr/JmgXqi+0Y=;
        b=lfs9IveaaElNYpJTwbU9Oy0R1ABy3WPmzWoXB/rkTzycG2ziMxwnYW9hBHeGB0d2q4
         Takbt6SRHsjanrlAQIuC+Zt5F5n+TymkyZQsJd6NN9poc/aT6I+X+ycZmiqvwxhoIqnU
         jUj9Bi3SWMgDzF1qNdR/KkJpKzqxj/yKGwotLxEvzIRf2u8ammQkaZF/90QmAAiPfgh1
         5I5lbdJJ0fJHJG5L0VU0dmSyoN/h9GM0Su+qqZrTZ4SpDtvhKIj+kC6o5nNB0wbQaGlC
         jMUk9bJdaUztZH6g2Q0eXcTZURwUa4r/b5w+mSErfTGhVDduXYKt+XKcNBR4DmWCsdt1
         23Ig==
X-Gm-Message-State: AOAM531k/MwSFLQyEbTo3y1891IXE4SRRXaHtooGS9BEF1ruyxhvIA9r
        q8izPx0nGVAE1b06yfhS4O3wXg==
X-Google-Smtp-Source: ABdhPJxYzFSnDNuHEGkraj3axUSnYZQ3NLj17U3JhPBsXfiJv7WzEL40kF+makqi7xt9BaGY90jGXw==
X-Received: by 2002:a05:6000:86:b0:20a:d7be:e09b with SMTP id m6-20020a056000008600b0020ad7bee09bmr4325701wrx.398.1652454929639;
        Fri, 13 May 2022 08:15:29 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id y15-20020a05600c364f00b003945237fea1sm2741440wmq.0.2022.05.13.08.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 08:15:29 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Govind Singh <govinds@codeaurora.org>,
        ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] ath10k: do not enforce interrupt trigger type
Date:   Fri, 13 May 2022 17:15:16 +0200
Message-Id: <20220513151516.357549-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Interrupt line can be configured on different hardware in different way,
even inverted.  Therefore driver should not enforce specific trigger
type - edge rising - but instead rely on Devicetree to configure it.

All Qualcomm DTSI with WCN3990 define the interrupt type as level high,
so the mismatch between DTSI and driver causes rebind issues:

  $ echo 18800000.wifi > /sys/bus/platform/drivers/ath10k_snoc/unbind
  $ echo 18800000.wifi > /sys/bus/platform/drivers/ath10k_snoc/bind
  [   44.763114] irq: type mismatch, failed to map hwirq-446 for interrupt-controller@17a00000!
  [   44.763130] ath10k_snoc 18800000.wifi: error -ENXIO: IRQ index 0 not found
  [   44.763140] ath10k_snoc 18800000.wifi: failed to initialize resource: -6

Fixes: c963a683e701 ("ath10k: add resource init and deinit for WCN3990")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Separate question is whether DTS has a proper interrupt type (level
high) configured...
---
 drivers/net/wireless/ath/ath10k/snoc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/snoc.c b/drivers/net/wireless/ath/ath10k/snoc.c
index 607e8164bf98..5576ad9fd116 100644
--- a/drivers/net/wireless/ath/ath10k/snoc.c
+++ b/drivers/net/wireless/ath/ath10k/snoc.c
@@ -1249,13 +1249,12 @@ static void ath10k_snoc_init_napi(struct ath10k *ar)
 static int ath10k_snoc_request_irq(struct ath10k *ar)
 {
 	struct ath10k_snoc *ar_snoc = ath10k_snoc_priv(ar);
-	int irqflags = IRQF_TRIGGER_RISING;
 	int ret, id;
 
 	for (id = 0; id < CE_COUNT_MAX; id++) {
 		ret = request_irq(ar_snoc->ce_irqs[id].irq_line,
-				  ath10k_snoc_per_engine_handler,
-				  irqflags, ce_name[id], ar);
+				  ath10k_snoc_per_engine_handler, 0,
+				  ce_name[id], ar);
 		if (ret) {
 			ath10k_err(ar,
 				   "failed to register IRQ handler for CE %d: %d\n",
-- 
2.32.0

