Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64D1E4FF3AE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 11:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234340AbiDMJkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 05:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232868AbiDMJj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 05:39:56 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D383853E0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 02:37:35 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id bx5so1420668pjb.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 02:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+A5GVMcDGs/YmPVYcCBNQNZhaB0wrRWQ2z4fJdwmcdY=;
        b=jgh+bv3SOSc/tjzMNsXiwiYM+gfdwL5raMVyitWjPhH/R8gBrFvkUZrGY5b0LDl3ry
         f+G7OuHGZGdZCrYDPjZvlPfzB8NL/pJQGfnKrRXYHGzZu5UP6aEwTRA/VxpsMAaLkyoB
         QLn0HNAUNjbUFV0+nYM/+voPduv4K7GtE1ZH4Ln8ecyqjaryWIKADGPhhcYW7GFNyE/j
         F4pdta8zpeXZ3O74O4zxPBUNGuKIGkriBBOLMbQaZNbqj1eBnzo8f09dgppoKKSE3uPQ
         lVacDStXWLfjfegjV7fEqXAlBXhE9sScM0/Iz/N+hD9hA5wX7Is8WXvxWxAc4dnbfigN
         1yxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+A5GVMcDGs/YmPVYcCBNQNZhaB0wrRWQ2z4fJdwmcdY=;
        b=NiUUKUdG/NtqnI3HmnhesW/wMzRrvp5JUJzoapHtdaG/7GGnCfNLhUkCNmKGy/P497
         XvpJSnsHYeo0a/DRSpjP4A/ljNLkPrGM71MQt9hBuEj9GS9iWET7PFqdMRWHyJo4qDZ8
         bUME4GfdAwRHDLTXIeXdINEdpxCM+0fT1S3nMmqL8ZE7jfzjptMBdmxt9U45jcoHaJMQ
         WMuX2AxHSk8mDupk7ndbqVP3py/H5BiSlAbTAvmyfhfz/0vFoN1L6M/FvFbEep65qwd/
         1U9cA7Ufd6vF05SeoycBnuRGO6KOwy0wDnf+uS2D3VNdMSTxCOerlDUb1CcKYOdV2T9r
         IVPw==
X-Gm-Message-State: AOAM530YybmnGYGuwMrXjkjTAUxpI8q6Whj7tpRFp8YgwfNAEQvnNCsy
        b0Y6rh6CHZ/22x+b/5n9Poc=
X-Google-Smtp-Source: ABdhPJxT6kdacq6sagnqkQ+1zInpVIOkCQ7hD7tZFQFCbrx+Iy3F3TlFWePcVpcacDAbaU5n+1NagA==
X-Received: by 2002:a17:902:b710:b0:156:47a6:c575 with SMTP id d16-20020a170902b71000b0015647a6c575mr7305869pls.37.1649842655423;
        Wed, 13 Apr 2022 02:37:35 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id m1-20020a17090ade0100b001cb3feaddfcsm3415685pjv.2.2022.04.13.02.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 02:37:35 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     shawnguo@kernel.org
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, l.stach@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] soc: img: using pm_runtime_resume_and_get instead of pm_runtime_get_sync
Date:   Wed, 13 Apr 2022 09:37:30 +0000
Message-Id: <20220413093730.2538566-1-chi.minghao@zte.com.cn>
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

From: Minghao Chi <chi.minghao@zte.com.cn>

Using pm_runtime_resume_and_get is more appropriate
for simplifing code

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 drivers/soc/imx/imx8m-blk-ctrl.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/soc/imx/imx8m-blk-ctrl.c b/drivers/soc/imx/imx8m-blk-ctrl.c
index 122f9c884b38..f85517767829 100644
--- a/drivers/soc/imx/imx8m-blk-ctrl.c
+++ b/drivers/soc/imx/imx8m-blk-ctrl.c
@@ -81,9 +81,8 @@ static int imx8m_blk_ctrl_power_on(struct generic_pm_domain *genpd)
 	int ret;
 
 	/* make sure bus domain is awake */
-	ret = pm_runtime_get_sync(bc->bus_power_dev);
+	ret = pm_runtime_resume_and_get(bc->bus_power_dev);
 	if (ret < 0) {
-		pm_runtime_put_noidle(bc->bus_power_dev);
 		dev_err(bc->dev, "failed to power up bus domain\n");
 		return ret;
 	}
@@ -335,20 +334,16 @@ static int imx8m_blk_ctrl_suspend(struct device *dev)
 	 * in the system suspend/resume paths due to the device parent/child
 	 * hierarchy.
 	 */
-	ret = pm_runtime_get_sync(bc->bus_power_dev);
-	if (ret < 0) {
-		pm_runtime_put_noidle(bc->bus_power_dev);
+	ret = pm_runtime_resume_and_get(bc->bus_power_dev);
+	if (ret < 0)
 		return ret;
-	}
 
 	for (i = 0; i < bc->onecell_data.num_domains; i++) {
 		struct imx8m_blk_ctrl_domain *domain = &bc->domains[i];
 
-		ret = pm_runtime_get_sync(domain->power_dev);
-		if (ret < 0) {
-			pm_runtime_put_noidle(domain->power_dev);
+		ret = pm_runtime_resume_and_get(domain->power_dev);
+		if (ret < 0)
 			goto out_fail;
-		}
 	}
 
 	return 0;
-- 
2.25.1


