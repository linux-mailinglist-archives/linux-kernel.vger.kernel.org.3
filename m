Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 083EB5150DB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 18:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359437AbiD2Qbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 12:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379127AbiD2QbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 12:31:24 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C035D95E9
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 09:28:05 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id e24so11442756wrc.9
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 09:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HPTbnXchZEXZ0p3ds/wq+y0hbHjmZmNRQUvjNkIEyfI=;
        b=QNMHLmyEf3EoZGEPvVHVVcqTG1zIVRH7BYUJM6wS4q/sZIbOgh4syAaUrvsqKQytc9
         ycvRUX5+k4CuVSj0/EmfixdpFSGDDoWbSHCTqz1xTO+9j+ML3ytqRS0aOharBTvmYLyU
         gcdby9O6Z70Hxb1WMxfUcGzMsNjme20ZMAgji4YPGLBtL8mnyLnJ1o0apiuymVr4/bVQ
         8Z1Me6R1wNCFMPt0LkSOXUaxYF6Nnks8hJnl0WQcWFQBjl0xyAjnZ9srO4G4oiDVkHF5
         KQivMPMXnHJwVpBxO8BmLhqf7C/oZ5hUTrBkEMc5Cabccas4sQWfyxb+u0zw7lMN0g6J
         wOcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HPTbnXchZEXZ0p3ds/wq+y0hbHjmZmNRQUvjNkIEyfI=;
        b=OLN7KIzhHDpk7NV3SlFikPsyxWPAC2w9h79MV7QuOBaJ600eiXGHuA/qzwZzYUBybx
         eA2IgHQ0t0r7d5NfVaVwvAwZfDQ066mgYDTipbLoyPKptBh7lelpgyvWv55lqnlo/0rK
         KwrQTyT28WpfKKsbsJ0EW+OexwJqzvve/f9sMQuGfw8JYMFBbniNpvECHUWvj6ewqs2l
         /xctSwoneyQEgFUyHhb+lnMbsERJ5002hdtptiaQga106HbCN59xOjrMa9h7kkBJ6TNV
         jTYiTEtYsugXPWv6xhuh64jWm+3ywoWhG/XkQd0FPaPPhL56A3KtSEiDQptTtBMXG5kl
         fSzw==
X-Gm-Message-State: AOAM531VT3JlPSSGo5AN+i7mC/JIJc7H9OsTEdchdAGDjIRsqLaNrshb
        AFMHe3H4idpNJ1H35rZngYY1qg==
X-Google-Smtp-Source: ABdhPJyevM/9QI3P29ZV3lY1+n77lMxQp1ThJrFOj8KUk3bkcm4NmzDuoObKaYvWlnRoSyloKGKtdg==
X-Received: by 2002:adf:ebc7:0:b0:1ee:945a:ffb4 with SMTP id v7-20020adfebc7000000b001ee945affb4mr31403918wrn.641.1651249683858;
        Fri, 29 Apr 2022 09:28:03 -0700 (PDT)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id b5-20020adff905000000b0020a8781be70sm2781801wrr.12.2022.04.29.09.28.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 09:28:03 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 09/16] nvmem: qfprom: using pm_runtime_resume_and_get instead of pm_runtime_get_sync
Date:   Fri, 29 Apr 2022 17:26:54 +0100
Message-Id: <20220429162701.2222-10-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20220429162701.2222-1-srinivas.kandagatla@linaro.org>
References: <20220429162701.2222-1-srinivas.kandagatla@linaro.org>
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

From: Minghao Chi <chi.minghao@zte.com.cn>

Using pm_runtime_resume_and_get is more appropriate
for simplifing code

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/qfprom.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvmem/qfprom.c b/drivers/nvmem/qfprom.c
index 162132c7dab9..c1e893c8a247 100644
--- a/drivers/nvmem/qfprom.c
+++ b/drivers/nvmem/qfprom.c
@@ -217,9 +217,8 @@ static int qfprom_enable_fuse_blowing(const struct qfprom_priv *priv,
 		goto err_clk_rate_set;
 	}
 
-	ret = pm_runtime_get_sync(priv->dev);
+	ret = pm_runtime_resume_and_get(priv->dev);
 	if (ret < 0) {
-		pm_runtime_put_noidle(priv->dev);
 		dev_err(priv->dev, "Failed to enable power-domain\n");
 		goto err_reg_enable;
 	}
-- 
2.21.0

