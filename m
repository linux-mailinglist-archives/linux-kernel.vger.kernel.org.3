Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E087B5070A4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 16:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353681AbiDSOc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 10:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353398AbiDSOcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 10:32:01 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EEE03969E
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 07:29:16 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id z99so21508519ede.5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 07:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=xWS9zh5KMUXIqFZALN21cYcGLfXB3BzUXuFD0a0fUOw=;
        b=aLV9hLaJJ0NaAlRkO0aHQgwZPtV2CafANhXdezXlvGXflg0FXgSZKgiFBo5azgdpoe
         iBsB2CHPZElvVUvAhCQ3YTfehyZNBGF/wZ8qHQY31N/Z50eaxl1riMkeh9PUq+zVURKW
         tXd2/Ec5cDNI8Bfqi8RcV/4NeeTvpgkhiQ77dO0LlWLWI36dyTvhAelFG86MD/MncwRX
         EN5nuCJ6EflxmGNk9yKMixNIqf4J5Ypj2faFSv2VXc6uNHhqhcNNEBiamuJTDaw1zsUx
         u8BjjM1d/7Jm9SbC9x48/U0ZqLOxSwiu+NQ6eazi7QF2U/gsIx6Iw8lOKImpLy81KsZa
         y2PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xWS9zh5KMUXIqFZALN21cYcGLfXB3BzUXuFD0a0fUOw=;
        b=lXMWXHUYopxBHSp647WfIJxczLZVMpT40DEb8pyBu8WD/96vM1307HQxPiPcuFBDYU
         CtEZRZa7IcRvjMaph3qRq0HTji2mlHOFxlO/dMc6Ix4rfPTdukzYOe4xLPuIqDeKnuFI
         VYlNXI9hY9HQjnLprHJr41rU99XzF2v2kMWJaTW14SWT/QTy+ynv29cyjLq4GAMSO95k
         MB/oZqR6O6H7I5DQNAn/DHc2FqTWBiR2BKSWa3a/CnEphx3JQzm8M3VPMMjBo+31h0wL
         8ENkGNfJ9vsKiQZIkuMGTCPHPmksseL8M4OwOLvynem7fG2DIHRKmEGp8Pnap2cTi63n
         bbRA==
X-Gm-Message-State: AOAM5334sAHyq8YcmUjgozuhmv51q+if6KCOWastbOIfzextjeEeHg9V
        QUgBGHgcb6KFBPwlbjyTmpcDlw==
X-Google-Smtp-Source: ABdhPJzkzsncCIKBUOGljWWovNy5FkPnFo0osExDv5Sz3kp3CcXwRLh62x+x0uhbvqikml8HwNYnRw==
X-Received: by 2002:a05:6402:1e8c:b0:424:1d6:1b71 with SMTP id f12-20020a0564021e8c00b0042401d61b71mr3019255edf.211.1650378554873;
        Tue, 19 Apr 2022 07:29:14 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id u10-20020a170906b10a00b006e1004406easm5761884ejy.93.2022.04.19.07.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 07:29:14 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Markus Mayer <mmayer@broadcom.com>,
        Broadcom Kernel Team <bcm-kernel-feedback-list@broadcom.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH 7/7] memory: renesas-rpc-if: simplify platform_get_resource_byname()
Date:   Tue, 19 Apr 2022 16:28:59 +0200
Message-Id: <20220419142859.380566-7-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220419142859.380566-1-krzysztof.kozlowski@linaro.org>
References: <20220419142859.380566-1-krzysztof.kozlowski@linaro.org>
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

Use devm_platform_ioremap_resource_byname() instead of
platform_get_resource_byname() and devm_ioremap_resource().

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/memory/renesas-rpc-if.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/memory/renesas-rpc-if.c b/drivers/memory/renesas-rpc-if.c
index ba9c526833c0..4316988d791a 100644
--- a/drivers/memory/renesas-rpc-if.c
+++ b/drivers/memory/renesas-rpc-if.c
@@ -259,8 +259,7 @@ int rpcif_sw_init(struct rpcif *rpc, struct device *dev)
 
 	rpc->dev = dev;
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "regs");
-	rpc->base = devm_ioremap_resource(&pdev->dev, res);
+	rpc->base = devm_platform_ioremap_resource_byname(pdev, "regs");
 	if (IS_ERR(rpc->base))
 		return PTR_ERR(rpc->base);
 
-- 
2.32.0

