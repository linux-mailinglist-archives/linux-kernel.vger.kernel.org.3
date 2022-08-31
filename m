Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84C625A82E3
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 18:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231878AbiHaQRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 12:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232135AbiHaQRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 12:17:48 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04ACED5711
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 09:17:42 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id bx38so15132750ljb.10
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 09:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=cKBGsEaj4oQkEiZ75eQ0nd+cq+8A2N09JqV8gHiJ4+Q=;
        b=tMgFRqslaUaliYOxYH0dYUK2/uIP7BKLWbF+I6IKNsjCJinHeYlZHRVMu1TRfw18Wp
         bUUkrsR36U9exIiOTQm6OmML0i/o8y2PcqqRp5BB8Nr2aaU0hNDmnhYE+52sHOujL6Vt
         1edd5Gm891k0Nu5Fsw1IyJvFBxknVve9eMr9QIBaqtPqLZjmLfNcGdJqcnrwyXclrZrA
         K9X6jK+IPOdS3ljtzFzBXEnpyCtnp6lopK0QmsQNQFcBrE2nqL3pllJCwOEwf0SimD2e
         LzLBsew2A2CtBjjxVQ9pqWnVFcUCtYQn0uJKMIvISBauaVlJIsJxLbwth/pDtYdLqjiJ
         h8ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=cKBGsEaj4oQkEiZ75eQ0nd+cq+8A2N09JqV8gHiJ4+Q=;
        b=jeyuLM4sRNPq6wJJTdzVLBEypqAIEu58mZZ9JtTa+uR4nj5F4xkYbjO2jBsuWXTk2Y
         1qZ0mbT4qwO0Oyn2V0Row1sADxTb+2T1xdGiHxW7DuN+mvgWNSz6HyK4OkEhYfNRw2Zb
         x0HbUy+yCkx+ithHtUk4aloXhhdrppXPiZibMzWETEzIceauSdYdLI7lEhh2uXG+izRi
         Sdrwgc9rpW2zExKsHjY1d2bnqbfymGnhhQwPW8KH06u78HWc5f/Ex4g1q9Q7pMqcxoPM
         P7lMQ48kC2bWBc9NWYG57u568o5g5c7Edr2l16ojcuAkYXN5CgJc5OMiPPPsGVUfdaiI
         MUng==
X-Gm-Message-State: ACgBeo3SB76v1wGSPJhoiAjjFf+Y397NdZouz7yhKGtUq/isCi0muptR
        KYOs4+VnGmufg8joLBE/en4MXQ==
X-Google-Smtp-Source: AA6agR4XliYALSJxmaQxjIWvOpSmc8kb/s83quW2sIBceAg8gUtAGNVFHuJ2Z38TzPn8KPwBT6uGuA==
X-Received: by 2002:a05:651c:905:b0:261:d00c:e71 with SMTP id e5-20020a05651c090500b00261d00c0e71mr8699218ljq.407.1661962661016;
        Wed, 31 Aug 2022 09:17:41 -0700 (PDT)
Received: from krzk-bin.. (balticom-73-99-134.balticom.lv. [109.73.99.134])
        by smtp.gmail.com with ESMTPSA id s2-20020a056512214200b004917a30c82bsm306338lfr.153.2022.08.31.09.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 09:17:40 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] remoteproc: report firmware name on load failures
Date:   Wed, 31 Aug 2022 19:17:36 +0300
Message-Id: <20220831161736.749932-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

remoteproc error messages like:
  remoteproc remoteproc0: request_firmware failed: -2
  remoteproc remoteproc1: request_firmware failed: -2
are difficult to debug as one actually have no clue which device
reported it and which firmware is missing.  Be verbose and print the
name of the failed firmware.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/remoteproc/remoteproc_core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index e5279ed9a8d7..71cd7ed7a970 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -1923,7 +1923,8 @@ int rproc_trigger_recovery(struct rproc *rproc)
 	/* load firmware */
 	ret = request_firmware(&firmware_p, rproc->firmware, dev);
 	if (ret < 0) {
-		dev_err(dev, "request_firmware failed: %d\n", ret);
+		dev_err(dev, "request_firmware %s failed: %d\n",
+			rproc->firmware, ret);
 		goto unlock_mutex;
 	}
 
@@ -2023,7 +2024,8 @@ int rproc_boot(struct rproc *rproc)
 		/* load firmware */
 		ret = request_firmware(&firmware_p, rproc->firmware, dev);
 		if (ret < 0) {
-			dev_err(dev, "request_firmware failed: %d\n", ret);
+			dev_err(dev, "request_firmware %s failed: %d\n",
+				rproc->firmware, ret);
 			goto downref_rproc;
 		}
 
-- 
2.34.1

