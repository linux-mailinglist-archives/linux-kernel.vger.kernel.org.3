Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D04BA53DADE
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 10:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350834AbiFEIkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 04:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236304AbiFEIks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 04:40:48 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C5682FE7D
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 01:40:47 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id b135so10440919pfb.12
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jun 2022 01:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aQpfNS+r3gvm5vQLoUP5fF1DHiiFVqBEBMp9DZpwHMg=;
        b=ByZRoM3j4iaoXqTKvHAn7fzsSjnQ8NhbYHK516s5FZMfOfWFv/TV0PfKtxGmIonTwB
         lTW2yqOaYYmzt0mgGeOiFrCczqJ7lPYyM4mQGCdE6r7bT0GjYrJiVDbOt4USH51kSu3Q
         shiGoqzAZ2wUOxdOSDY37JVQNRfrAkEQ0pkZO30C+4V9Kt4h4bJPDBAnvGXeCTTGeRYo
         q2qO5Ru+m4jav/aDxTUxiOXQg9eRGVcRuOw32UHyCOiKI/6eJQ0KkZJQlNmoxT6cQ92J
         390OTsj2DFvHPznpgkBQk6b9FHUuCBr57ihuSojNrEXmFJGBJ+emd4eLLrfiQ/TFr62v
         z2Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aQpfNS+r3gvm5vQLoUP5fF1DHiiFVqBEBMp9DZpwHMg=;
        b=ownqso0msvfjh6nL7NaiSP58apDzFq5hAYdhY4DsA/vNN8/7dAByEI3L1hGbqsLii6
         EsVpiXAvDlt9jdJi0iOyrR2N7DJZB80gUAWd3DhuyRxvm8274/3nIKnLSuNnwaQQKNbI
         YtqphKyU9omyGIvyeYanOffqXzmDGWbcipFDs3TBB8qfHoLgmHf/aOObqPKNo84HOOyd
         tar9KEyQmfnLWDAEAtzI2usJfFbb3LbVLy2RW5yFnaUGxGtE5sA7YDz6fnqhBtcBP3Eh
         9ZJvZ8teD9XTw9zlX4EZkjhv1w0wWRVL2S47GLmdMfFKM22kPEAxCPGJeuYksdPEwo37
         eZ2Q==
X-Gm-Message-State: AOAM531uWA6dP5XCKYkkQcS4+PkcrZfFe+Vz2hSd+VkQYhkVFuymm3KA
        Cve2TA5yl7tuz9Px71lOkbc=
X-Google-Smtp-Source: ABdhPJyblrAIpv56unO0ayEauib56A4SYuOB+hS7iEOJLLwveL/Fh3rQs1ouywo/o0gJirukRa6p+A==
X-Received: by 2002:a62:de84:0:b0:51b:e34b:ed2e with SMTP id h126-20020a62de84000000b0051be34bed2emr10837648pfg.86.1654418446975;
        Sun, 05 Jun 2022 01:40:46 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id d15-20020aa797af000000b0051bbc198f3fsm7756810pfq.13.2022.06.05.01.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jun 2022 01:40:46 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Mihai Sain <mihai.sain@microchip.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drivers: soc: atmel: Fix refcount leak in atmel_soc_device_init
Date:   Sun,  5 Jun 2022 12:40:32 +0400
Message-Id: <20220605084035.27127-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_find_node_by_path() returns a node pointer with refcount incremented,
we should use of_node_put() on it when not need anymore.
Add missing of_node_put() to avoid refcount leak.

Fixes: 960ddf70cc11 ("drivers: soc: atmel: Avoid calling at91_soc_init on non AT91 SoCs")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/soc/atmel/soc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/atmel/soc.c b/drivers/soc/atmel/soc.c
index b2d365ae0282..46dfa24c52fb 100644
--- a/drivers/soc/atmel/soc.c
+++ b/drivers/soc/atmel/soc.c
@@ -369,10 +369,13 @@ static int __init atmel_soc_device_init(void)
 {
 	struct device_node *np = of_find_node_by_path("/");
 
-	if (!of_match_node(at91_soc_allowed_list, np))
+	if (!of_match_node(at91_soc_allowed_list, np)) {
+		of_node_put(np);
 		return 0;
+	}
 
 	at91_soc_init(socs);
+	of_node_put(np);
 
 	return 0;
 }
-- 
2.25.1

