Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82D4551506F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 18:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238152AbiD2QNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 12:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378470AbiD2QND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 12:13:03 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69942D76DE
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 09:09:44 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id u3so11408436wrg.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 09:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JWMAn/Bn8ohxKs6BvOjyYpQ71mruJeatGTg+RHO7TDU=;
        b=hqE8BOyx/OO+QvPg/NFycXPm1WifkvLBScYG4S0tODof3BwXf9egD1HH+z/2HRa88h
         Wl7/0Mu5TyFJxNZvCEJOUAWZbSqhagKV5cXC1EPTltZOm4HOQfkYRJFYm+NO0elI/Kf6
         oRRHthAd3vSAuzSLhR2udVVEaxcYJsuu039DoQrrV9fVH8i+353v34sqg/cpDy+pHydX
         St2j+JlRt5iJfrZkM+stvUmzv5ZqTFhipJgLkOli6YzuyxEbZXQ+esnxPXD3n/jPxNmF
         C/pbaVSfPlAjSN6oCRYpyTD569PX15RVUkHolHBFAJbegJQC9NB6kcsLRyG+uWkFk+Ix
         JKEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JWMAn/Bn8ohxKs6BvOjyYpQ71mruJeatGTg+RHO7TDU=;
        b=2C1Lwjt5hhpdEZAaw6TaPvwzkYT762IMaUDwuKrbNqWfd355m5DgXNDpWW5Ftzjgdi
         Um8sZWk0hRkiME72/4kTx30Bytn2tazEujt7+XjKROI3R+G7nAAvrZPvf8ePW57Z1ZJk
         H/LJyetyVGQxLhe7dXn2eIy14dxJn3E9QVMErsbXT1qy+t4HzAwys3c3kTmLGWgimsFG
         WBMqWiEwhuTCgqqHPfhWnKYpqBlhUJbfD6ubuQNyNwbvyahJeHy0w4augqpYbdTroL6G
         3w81Teh514aLpawoQsLqdYV6D/gEBVpUOtMyC9GfIUiX5QRLprDPoS2fwR4vQp87ByQq
         Vx/w==
X-Gm-Message-State: AOAM531+u7IG/fQseeX+YMZfUUoD9ZPD3KXVlr+qCpTHL0Sg960uR5ZG
        +gYDq3MbWBIFEDV3VhkhWDTqamlXHgeehA==
X-Google-Smtp-Source: ABdhPJzZ/2OiJVcoHnRZLspX+t/FHdW4FlaxULi9G0U+ixxQ6FdHjGbd2IzZrLvCjcTb7ZyapRlOgg==
X-Received: by 2002:a05:6000:1844:b0:20a:f429:f80c with SMTP id c4-20020a056000184400b0020af429f80cmr8474722wri.643.1651248582988;
        Fri, 29 Apr 2022 09:09:42 -0700 (PDT)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id z11-20020a05600c220b00b00393ffde5f5fsm7827863wml.36.2022.04.29.09.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 09:09:42 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     vkoul@kernel.org
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Subject: [PATCH] soundwire: qcom: adjust autoenumeration timeout
Date:   Fri, 29 Apr 2022 17:09:28 +0100
Message-Id: <20220429160928.24614-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently timeout for autoenumeration during probe and bus reset is set to
2 secs which is really a big value. This can have an adverse effect on
boot time if the slave device is not ready/reset.
This was the case with wcd938x which was not reset yet but we spent 2
secs waiting in the soundwire controller probe. Reduce this time to
1/10 of Hz which should be good enough time to finish autoenumeration
if any slaves are available on the bus.

Reported-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/soundwire/qcom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index da1ad7ebb1aa..432e5cb9a4d2 100644
--- a/drivers/soundwire/qcom.c
+++ b/drivers/soundwire/qcom.c
@@ -105,7 +105,7 @@
 
 #define SWRM_SPECIAL_CMD_ID	0xF
 #define MAX_FREQ_NUM		1
-#define TIMEOUT_MS		(2 * HZ)
+#define TIMEOUT_MS		(HZ/10)
 #define QCOM_SWRM_MAX_RD_LEN	0x1
 #define QCOM_SDW_MAX_PORTS	14
 #define DEFAULT_CLK_FREQ	9600000
-- 
2.21.0

