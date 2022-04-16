Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6596350342B
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 07:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiDPCHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 22:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiDPCGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 22:06:04 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 270C0F1E94
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 18:55:32 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id r8so9764766oib.5
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 18:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uqKd1Orxl/LGzBg+7rmnNDHUMWN7s9B1LCDOy65IlQA=;
        b=N364O5BnRkqe8gLCY6+6Riw2dvoQSe+pV8jWLMWkyKwDJRiXRodeWCF6dOX1MO0Y4x
         l5vzEFdxw764IXFw5pt2I5BaJ+tiXzVWOV0DHxMes3hgEwxVqH25T3a+HXfXVKNmujhX
         hMQBDzRqJbeKLwx5z5Dohu9PQwC4xp2QffevxBiof/Ljud8I/BkLx1YhGNh15rnHV943
         d3fweG1MjzrT+eHTNW/Vt4UAwMp0KpdTnPm+n/SjiieMqWl+NZC15j/By41/vK3ysxGi
         Fmv3PXICjX+HefHAu07XpbCXz3A+PWe8enneamXLGhzN05xmtj+7sxMQyENtpcQY3+mV
         3ZaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uqKd1Orxl/LGzBg+7rmnNDHUMWN7s9B1LCDOy65IlQA=;
        b=pBl1Shv4Os86/3/nNEPdG7jo1l0dFDCBorSSBrqYxPRWPQWqFmCeXWSrVQDrsCEOWK
         HtBY7KihBcEP2LfFhgy8bR3MCNwF/kW+UsFxETTitwLNn1CbEy5kPh9Pb7o/mY1RuvpE
         MimY2Fewzj2ftP7fKuZdyxNTDtynge41PQi/BZejOCuMGApxL3TnrzW5x6r6lDMgt2hl
         9rKGSpr2Ky0sVjt7WnmfkGCvjgdzxTf0V6/kKelzB8YjjG/CyqrQ/Jf7rur8M5GNaQg7
         bw+LUzZY49Giv/KfEB2OOLsLf+B+rQRfkRMd0xwNIxzDqhl8M5W7fxQD6YWJg/sX1Nug
         HP6Q==
X-Gm-Message-State: AOAM533PX+wAiVJcdNQIOB5gJX6EzzvbSxOeQV2X0+1W94fsGfGFYV1k
        WAz+sWf3GKnUGRh7yIBxHkL8Va2ahqOj9ILbRJnGPA==
X-Google-Smtp-Source: ABdhPJzO4dFfJiTJAfRiEarg+WpfXqOs2uIeFBF1W0TiWPqIMzBObZpTJ1JBTD1oZF/evYqedyW8yQ==
X-Received: by 2002:a17:90b:4d01:b0:1d0:f39f:6073 with SMTP id mw1-20020a17090b4d0100b001d0f39f6073mr1618465pjb.175.1650072405373;
        Fri, 15 Apr 2022 18:26:45 -0700 (PDT)
Received: from localhost.localdomain ([134.195.101.46])
        by smtp.gmail.com with ESMTPSA id n184-20020a6227c1000000b0050a3bbd36d6sm3313260pfn.204.2022.04.15.18.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 18:26:44 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH] interconnect: qcom: msm8939: Use icc_sync_state
Date:   Sat, 16 Apr 2022 09:26:34 +0800
Message-Id: <20220416012634.479617-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's fashion to use the icc_sync_state callback to notify the framework
when all consumers are probed, so that the bandwidth request doesn't
need to stay on maximum value.

Do the same thing for msm8939 driver.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 drivers/interconnect/qcom/msm8939.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/interconnect/qcom/msm8939.c b/drivers/interconnect/qcom/msm8939.c
index f9c2d7d3100d..ca5f611d33b0 100644
--- a/drivers/interconnect/qcom/msm8939.c
+++ b/drivers/interconnect/qcom/msm8939.c
@@ -1423,6 +1423,7 @@ static struct platform_driver msm8939_noc_driver = {
 	.driver = {
 		.name = "qnoc-msm8939",
 		.of_match_table = msm8939_noc_of_match,
+		.sync_state = icc_sync_state,
 	},
 };
 module_platform_driver(msm8939_noc_driver);
-- 
2.25.1

