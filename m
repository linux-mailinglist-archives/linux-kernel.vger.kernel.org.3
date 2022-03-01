Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B0854C815B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 03:59:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231932AbiCAC7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 21:59:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbiCAC7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 21:59:38 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB792AE18
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 18:58:58 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id g7-20020a17090a708700b001bb78857ccdso914829pjk.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 18:58:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=FecKxYpeO4n33xmiWqk9SqIey10zNBseQvud/vQ/vV4=;
        b=lfKVovcp+PqFLpajm0E9k0CmuzDdMIetRtBohZJaE4llFH787CTue4wRl+PhuM8way
         hd23HpY/jOTSqeTjrRNAYV4A3pIlvcKBQzACDs/9yp9LvvVy782g7aOGUOw5bvog73vF
         2BM7zjSQ4KzwiKW0vMvHx9cwkGxzlWfqql03Zk6YTl/4SInbuXhCOLL9UgGYGCsJygu3
         lp0ttaKCjFQW2Hql3VZSpTKvdXQAj5I8ZLrH4mvK4JDscoRGCHXe8UxY4OlpBDFrWSHx
         XFin5JcUn/1kiOViJ04N3yiqc+beW5oNasMZqKuTmXXyyeRW50zO4sm8gvALyFNdgnXo
         bEYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=FecKxYpeO4n33xmiWqk9SqIey10zNBseQvud/vQ/vV4=;
        b=Zog85nVWlhjNOKe5Ols0HUw38la2725aoCzYtDVjtOMDRV9QC9x+TJ+U4iptqIb5nJ
         BTkzjxxLjsE0AMyUypOInpOMX0ak3tNdzgPWD4WxMFq30KlNJWBLiwthgPauuiMMAWvD
         jP8fhsvsrBN79Ef3hbH/IGCyNF7p31JRWZLEBI7naZgW9hHLRp/RKXFw7dwBAnRs4paT
         mdwH8mzZu0izp/U3wrDNkXAo/m+ke27sOpcUo60da+KfMjKR3kp6Wr+PMBlMaYa+Ypqi
         u7zEEGbeyBYL9DzE/7pypEiKVkG7b1iPmh2NIh5dJSk8TbC8QZpP0AOVrYGnyWyHk3ip
         6F1A==
X-Gm-Message-State: AOAM5325lw//5hSVtq6CAisecJ+r8iClTB7b7TkjpnCfWodmA1pxqwRA
        fhQLAQ2YrzIaWr+t3gsExOE=
X-Google-Smtp-Source: ABdhPJziG+6HlY/JbmxxcP3vpoRkHmZT5wZLHw8bsPXRk3/LgxhY/IAfiUAngyYQ7mgDz6jOJnGwnw==
X-Received: by 2002:a17:902:8d84:b0:14f:83f2:8c0d with SMTP id v4-20020a1709028d8400b0014f83f28c0dmr23529356plo.110.1646103538517;
        Mon, 28 Feb 2022 18:58:58 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id k130-20020a633d88000000b00378c359ea29sm2490541pga.12.2022.02.28.18.58.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 18:58:58 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Miaoqian Lin <linmq006@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Roger Quadros <rogerq@ti.com>, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] phy: ti: Add missing pm_runtime_disable() in serdes_am654_probe
Date:   Tue,  1 Mar 2022 02:58:49 +0000
Message-Id: <20220301025853.1911-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220105090225.20507-1-linmq006@gmail.com>
References: <20220105090225.20507-1-linmq006@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pm_runtime_enable() will increase power disable depth.
If the probe fails, we should use pm_runtime_disable() to balance
pm_runtime_enable().
Add missing pm_runtime_disable() for serdes_am654_probe().

Fixes: 71e2f5c ("phy: ti: Add a new SERDES driver for TI's AM654x SoC")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
changes in v2:
- remove unused label
---
 drivers/phy/ti/phy-am654-serdes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/ti/phy-am654-serdes.c b/drivers/phy/ti/phy-am654-serdes.c
index c1211c4f863c..0be727bb9f79 100644
--- a/drivers/phy/ti/phy-am654-serdes.c
+++ b/drivers/phy/ti/phy-am654-serdes.c
@@ -838,7 +838,7 @@ static int serdes_am654_probe(struct platform_device *pdev)
 
 clk_err:
 	of_clk_del_provider(node);
-
+	pm_runtime_disable(dev);
 	return ret;
 }
 
-- 
2.17.1

