Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE47511F26
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243065AbiD0QVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 12:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242813AbiD0QSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 12:18:34 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B98B8F187
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 09:14:38 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id p18so2521356edr.7
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 09:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iFtQQxlzreRUl8NYVzyEv+oobXt03dUXlkwOfmHujiQ=;
        b=zFx6dgEJwUJ09auBqAc9Lu1g3Aeq6JvXDOqtYxmZsE6v3AYgQR2nNJNDpG5pRMMWo/
         nKI8pRznYLgHoirfU0wE8mMRr21vyjMaixW8O6sJO9kH9H35F2WS0TQFeduP1MZaGwRf
         hOBGngSyvJCyOGs7h8wDHIpgyadTqEN66dqCnhuGGs2w0aeAlqMcJxGz3QNg2a+Lw3Fh
         fYAzSVzQH3ueo7HGm5qtczjqcexzT2Ua7pvdCYu45CFGUhHQLsh08WL64sYJpWW+EJpt
         Xv0Kp5a15P0VFs9LsE+kQfR3eedCfYQYvZs4ieiiw2FNeIy7m0QCetIGWuQDkNLpEttr
         /zMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iFtQQxlzreRUl8NYVzyEv+oobXt03dUXlkwOfmHujiQ=;
        b=ZzCC6Jgy/81KJND1N49yAVB0NBGq3I0vYPWlaAq21ZAoO5o8LMLiSCNgKCgnpMr7jB
         ZeFBNTt+1eqlizDPaxHEA9+fkAaHDnsr9wQ6Sul9b7hKbrb5924rEvfeIdPvqzURlVPY
         Nu3JwnJ07QdeBPjz5w9SdxowwycEgjvSqhlCeN7xop2367o/3sHVXLlzsgQ1ylZNEtsf
         VcCcAWeU/Z5NFcD/nniLs+YwpeKzQiQG//lTYN73OrTY6F8GGFchnEgvx4gOsAlb81Ui
         gZZEpdXA7mbLsIC1HR0Ou4/DTaVqU+W4J8V88DLzMKAmXfbrJlejBMIJMhHR89yeXSdk
         XyjQ==
X-Gm-Message-State: AOAM533fel2PlB1kBjS3Ued/WsHMV+zOLjwamkOVSGLb6aE04pjipk1D
        9XMGsreT3Bp5J+ZnoEDUQaKPwg==
X-Google-Smtp-Source: ABdhPJxFd9VEGHMo4tPif+bW/nQIupvHnKCCUsLpD5OoAgT4+qXxFMlzJxh9DvTdhH2ifhDxn3Q1Ww==
X-Received: by 2002:a05:6402:2214:b0:425:d6ed:de5d with SMTP id cq20-20020a056402221400b00425d6edde5dmr22029579edb.383.1651076069273;
        Wed, 27 Apr 2022 09:14:29 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id b17-20020aa7dc11000000b00412ae7fda95sm8583383edu.44.2022.04.27.09.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 09:14:28 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/3] dmaengine: sprd: deprecate '#dma-channels'
Date:   Wed, 27 Apr 2022 18:14:22 +0200
Message-Id: <20220427161423.647534-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220427161423.647534-1-krzysztof.kozlowski@linaro.org>
References: <20220427161423.647534-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The generic property, used in most of the drivers and defined in generic
dma-common DT bindings, is 'dma-channels'.  Switch to new property while
keeping backward compatibility.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/dma/sprd-dma.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/sprd-dma.c b/drivers/dma/sprd-dma.c
index 7f158ef5672d..2138b80435ab 100644
--- a/drivers/dma/sprd-dma.c
+++ b/drivers/dma/sprd-dma.c
@@ -1117,7 +1117,11 @@ static int sprd_dma_probe(struct platform_device *pdev)
 	u32 chn_count;
 	int ret, i;
 
-	ret = device_property_read_u32(&pdev->dev, "#dma-channels", &chn_count);
+	/* Parse new and deprecated dma-channels properties */
+	ret = device_property_read_u32(&pdev->dev, "dma-channels", &chn_count);
+	if (ret)
+		ret = device_property_read_u32(&pdev->dev, "#dma-channels",
+					       &chn_count);
 	if (ret) {
 		dev_err(&pdev->dev, "get dma channels count failed\n");
 		return ret;
-- 
2.32.0

