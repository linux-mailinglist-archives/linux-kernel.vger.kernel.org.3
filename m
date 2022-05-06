Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0BD51D3A6
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 10:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390273AbiEFIvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 04:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390267AbiEFIvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 04:51:01 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAE9957127
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 01:47:14 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id x18so9122911wrc.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 01:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7LQd7iQdqQi625fScqqUgHbyBnZ+6vFhX41p9tiKGP0=;
        b=IMscpR8PfJpHILzYcvylriVA5ovdlSmxZrGEyN8QyRyGkOIt2J2TgzSLvmKypmI5NW
         ro/p3Mou7emqGjRj/MS2mserpj9t5GFyhxt3wz6C0usU9tF9ynFSS5gcILBENYBIG4V3
         pjukkVG2qOCKx7MLAtwcgew8GJF+xHexsU2B9QRja11CqGmRCiUF+DmN7jljGh0uimSF
         pDBctRlBEpWvlKE6JDMsbNO+MsSCimMP3nsQVWIe7JzmUHgCgQRf2HA1igkX1zKOprQt
         j+adMdy+mNLIPOijwOxn6jIgfBDKWIamR7pPW+8iq0vQyh2HQXo959bVD9QDWDMVSSMx
         i9Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7LQd7iQdqQi625fScqqUgHbyBnZ+6vFhX41p9tiKGP0=;
        b=E2SWAJgvi3vEmWaCsAcY7t7/BX4fdRPVa4i3uHLDzn8MgWP/4Re0JhAPASvUFgiHGs
         psxfu21KpZC9UDejQrXF733Ja0gf/QctrT9UJ2A91bolo8UOMQyz7KEv5wQnPn3pkggw
         v27oYCIGWl01/uWrSYRNPLMcLao6dWANoOiYfCyjNnZrGeHs7NEhbJ6fxciCxNYH42Id
         YW0cN90sZlz+2eQ0I7Utowbb90sZkqo0ml1HzfWMA1h5TzLoqRWkhV6xDp8e0idl06b/
         LqNNmEZUm+D9DUSdjzbHqiTDAJm3Mbs/9B/L8G+Jj1g2YqkjAKeKCh2G/eZkLbZllkZB
         vI4A==
X-Gm-Message-State: AOAM533ndzcRssBGkGVmng6Lr9sW4oRKinaSSH4udHUi6S3/kasETX/c
        Vvkut6TPPjnX5k5prHivhr1wsw==
X-Google-Smtp-Source: ABdhPJx4WNtOGpGgOD2ShjcgQm2jF+xPxTjiXdlFjdV8rdMqU7AYWO6RI//SkfzYV9xgRDf/GROpyQ==
X-Received: by 2002:a5d:6345:0:b0:20a:d69f:8126 with SMTP id b5-20020a5d6345000000b0020ad69f8126mr1775273wrw.276.1651826833431;
        Fri, 06 May 2022 01:47:13 -0700 (PDT)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id o9-20020a5d62c9000000b0020c5253d903sm3071349wrv.79.2022.05.06.01.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 May 2022 01:47:12 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     vkoul@kernel.org
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Subject: [PATCH v2] soundwire: qcom: adjust autoenumeration timeout
Date:   Fri,  6 May 2022 09:47:05 +0100
Message-Id: <20220506084705.18525-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
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

Changes since v1:
	replaced HZ/10 with 100 as suggested by Pierre

 drivers/soundwire/qcom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index 7367aa88b8ac..d6111f69d320 100644
--- a/drivers/soundwire/qcom.c
+++ b/drivers/soundwire/qcom.c
@@ -105,7 +105,7 @@
 
 #define SWRM_SPECIAL_CMD_ID	0xF
 #define MAX_FREQ_NUM		1
-#define TIMEOUT_MS		(2 * HZ)
+#define TIMEOUT_MS		100
 #define QCOM_SWRM_MAX_RD_LEN	0x1
 #define QCOM_SDW_MAX_PORTS	14
 #define DEFAULT_CLK_FREQ	9600000
-- 
2.21.0

