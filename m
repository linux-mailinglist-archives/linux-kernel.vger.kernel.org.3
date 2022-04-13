Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 714E94FEC07
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 03:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbiDMBGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 21:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiDMBGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 21:06:50 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ADAB2558D
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 18:04:31 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id k14so335725pga.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 18:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nY/di/ysNrXys5hLZLAzfqtetv16NHy5HD+OIKSD450=;
        b=pfAmzAgd+3XvYXMaijTNmoTdKLKheabhIAus+/1HOCL9K/aGGRWf0wIqFioAi75BsT
         03EegT91x09xqKjy+NphmLlDhLtcT9fqKPcmucw3I4hUbrCKwckux01A/LIntSY4do7R
         hVp/6fdoa3DfedqIR5+4FtFVZuAeJcs/xSBDQgT5Gm0fav19AHvD4/LSX5tkdVl0L07t
         QDK+gddHbdRjcclAJb5QzvveGx9bwYh4h1QS2NtaENHYmsR/IBqhpnD7MMmgrKfw1cr7
         /IgFOIB6QsNwWXRBbbatKWXAbVdhihw9PvV+8NpYcmWTFP5dnHaCKS1IWKAoxTKBodYM
         SBnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nY/di/ysNrXys5hLZLAzfqtetv16NHy5HD+OIKSD450=;
        b=mxCHsiE+t3E3m9BsHtojh5c01DFhcs1LMLHoeFsGDXjhPbHWVhVARv1oG3owj6Vsd0
         LJNupk/dueR8mbvOBVqtLZHaQvfEIdXCDNMo6crNo3bOCe6M7yK/QJ1z0r8WOV0s5X30
         09zsPymRs36dDeznYwCiqiWz1jLH56eiPzROzaHrvzf3rUksE2eYbCUgl/X07fy4bkCo
         L+yhtAfbJlRiP5pw3ZoBU1m04cGlTyTxXUSGpjJ4V79YLzYvkFEyrGvq2Un8cxxsWOgZ
         qmIQyDrQeuoJu9y7upsQoQDqhi4UvaKeNcgQ0CEPQlOmUXXpeP3eYPnOsNdWmqU7r/Se
         gIRQ==
X-Gm-Message-State: AOAM531nWtHHccvJn4NjOyFhIF6F+gXYHoyRmk5FtebDWJ5JZXSHxSDr
        Se6vikN61c8DzohrP/g+W1o=
X-Google-Smtp-Source: ABdhPJzO2HhOlpHu6E6g/YKT6WPznRIK8MTuigx0kAa2cPRadPTgCsRINF7fdUU8ekY6oAQzyooYSg==
X-Received: by 2002:a63:5219:0:b0:39d:7212:4b3f with SMTP id g25-20020a635219000000b0039d72124b3fmr7907489pgb.255.1649811870927;
        Tue, 12 Apr 2022 18:04:30 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id i15-20020a17090a058f00b001cd50a6ec5csm251107pji.16.2022.04.12.18.04.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 18:04:30 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: lv.ruyi@zte.com.cn
To:     iwona.winiarska@intel.com
Cc:     andrew@aj.id.au, cgel.zte@gmail.com, jae.hyun.yoo@linux.intel.com,
        joel@jms.id.au, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        lv.ruyi@zte.com.cn, openbmc@lists.ozlabs.org,
        pierre-louis.bossart@linux.intel.com,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH v2] peci: aspeed: fix error check return value of platform_get_irq()
Date:   Wed, 13 Apr 2022 01:04:25 +0000
Message-Id: <20220413010425.2534887-1-lv.ruyi@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <d09484f7cda13de3f156bd1bcba8c2671495dcd1.camel@intel.com>
References: <d09484f7cda13de3f156bd1bcba8c2671495dcd1.camel@intel.com>
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
v2: prefix the subject with "peci: aspeed:"
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

