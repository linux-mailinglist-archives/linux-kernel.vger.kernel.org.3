Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E95A4FDC56
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 13:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379355AbiDLKTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 06:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357486AbiDLJ7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 05:59:17 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A90136D4D3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 02:01:54 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d15so16217548pll.10
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 02:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NJIUPTIwlW1yqo+bBjjNQ6hCNCU4mnU6YG9EAezP6EA=;
        b=gTDuuZ9+FGdPsqHBdpPR3b+DkmcyZk8Vjr9z3ud96fdzFLo4BQnD440lWFnCGd1Zg3
         cZvysxJ2g/DGs5Xc0jhErEkcpCGDEv1hMuTXr3nJRHW/IqZ5dg+lp2E0mDHQ+mA7l28r
         sogpemINd9OotgPA7TJ6dt+aJV6aKYaJpwZOACgli7we52A0S7lBYo5hSkRi3oVCwpZ7
         nRZ2Ic0QdBdshwR6uBkf/Z6I9krNxFghnIHsCnZUe6omlAGuoqpm+0bgozQk+qG4d1oi
         H/JWBqCQ7WuWU5kJZfE9s453SwHGHyLYF3FGgPphmmCYqIBCR4vUxBz/rjZ5ny2P/y0t
         SWqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NJIUPTIwlW1yqo+bBjjNQ6hCNCU4mnU6YG9EAezP6EA=;
        b=7i2Vq3zvPHV2SlEFo5V5tS8ZVXBhVJ37WHvOp6+T9KWXkk8AcQUmp8b7Z29UMDBqaX
         PVm7hJRU9q+xZfMYbXOdUtyI7CLHNni8mbVl3NA3IYnv5dyl2d98d49scF/DQTYDEauh
         kg2g9bLcdei4MbKLJuRU1Fup/mjSTCOl1GlL9wiSaJTiJeq7jHFlKHvQqfygkNsBuGbT
         zx3fyWxDzBMpy4MUPDKZYWPLR9/83Q02hWgs8q+eBPVstouoVCKnYrIv411G/eYwq/mD
         NzgYpOvoO/P2c71WAAn/D1NEbDTwI2/hl6an3JCxgDVqdQ7tMvgmGoXwCSdy4ymAdUwW
         3HDg==
X-Gm-Message-State: AOAM532heINrIYJr8mqaFwXUZ0CVg473RZw8tQsimnfmzeDF6DF0Py+5
        m/7uM0QCfOQknE0CcBvXjshk1/RepOA=
X-Google-Smtp-Source: ABdhPJyCiaAvpOVYpOy4NCFANstY3YgAIY18ez5RlUm3CicYx95FyB64nqoJrt47QujVjaFtEWPb/A==
X-Received: by 2002:a17:90a:5983:b0:1c9:ee11:76df with SMTP id l3-20020a17090a598300b001c9ee1176dfmr3824811pji.95.1649754114164;
        Tue, 12 Apr 2022 02:01:54 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id j63-20020a636e42000000b003987df110edsm2172423pgc.42.2022.04.12.02.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 02:01:53 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: lv.ruyi@zte.com.cn
To:     iwona.winiarska@intel.com, joel@jms.id.au, andrew@aj.id.au
Cc:     jae.hyun.yoo@linux.intel.com, pierre-louis.bossart@linux.intel.com,
        linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lv Ruyi <lv.ruyi@zte.com.cn>, Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] peci: fix error check return value of platform_get_irq()
Date:   Tue, 12 Apr 2022 09:01:47 +0000
Message-Id: <20220412090148.2533219-1-lv.ruyi@zte.com.cn>
X-Mailer: git-send-email 2.25.1
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

From: Lv Ruyi <lv.ruyi@zte.com.cn>

platform_get_irq() return negative value on failure, so null check of
priv->irq is incorrect. Fix it by comparing whether it is less than zero.

Fixes: a85e4c52086c ("peci: Add peci-aspeed controller driver")
Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>
---
 drivers/peci/controller/peci-aspeed.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/peci/controller/peci-aspeed.c b/drivers/peci/controller/peci-aspeed.c
index 1925ddc13f00..731c5d8f75c6 100644
--- a/drivers/peci/controller/peci-aspeed.c
+++ b/drivers/peci/controller/peci-aspeed.c
@@ -523,7 +523,7 @@ static int aspeed_peci_probe(struct platform_device *pdev)
 		return PTR_ERR(priv->base);
 
 	priv->irq = platform_get_irq(pdev, 0);
-	if (!priv->irq)
+	if (priv->irq < 0)
 		return priv->irq;
 
 	ret = devm_request_irq(&pdev->dev, priv->irq, aspeed_peci_irq_handler,
-- 
2.25.1

