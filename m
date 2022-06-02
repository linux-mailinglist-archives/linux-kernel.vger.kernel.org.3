Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFF2953B20B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 05:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233412AbiFBDIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 23:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbiFBDIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 23:08:50 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA023DDE9;
        Wed,  1 Jun 2022 20:08:48 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id s14so3412521plk.8;
        Wed, 01 Jun 2022 20:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J2cdsfsG0mpf92WrWuIuHSZ0x1jXPLBhoImykLvIqzA=;
        b=pSb/+V/Y/7pccZ7WlsxWvJdyPY0ZpgBrsBVRM8K0EDEFPn8E6KDNuj/+Vj06xGNlpK
         o7Oj19uOgWXo44bNs+7TtwLhSGy756IsK1FIELD06fXsmnd0spueWX4yvLpDfUruJ8tl
         KcRsISb6SVbN3sFl6tA46xEJgT9qlKfet6AambiuXjWCjcuVMQi0KoDqzL/qntzJWAyx
         NfpW+YFAf+WFj0PtR3ZizDhWchpZZTNYQ04om0WH8eJF8ZcqL48GO878P5cYciskPhKV
         XuVA1hrq+/4G2wPiB1c2sfdF6iB9NN82bsU+DIM+j00XkopjIkDBR+pgirumFwrpfZmf
         QrKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J2cdsfsG0mpf92WrWuIuHSZ0x1jXPLBhoImykLvIqzA=;
        b=GPak3IDfaVL+GZqz+FZizYxCe+JnNl7PH5aZQnvvprc78K1wC83+iD5NasjTuwR15K
         qIenl7yeJEvJ2AsyPL5FDDtNzflPNvGSJwfasa4GXNigQcR4Sg3KJ7qkeuGb7e6NHpYJ
         FtPt9cjCMfGhCirGe2zkxdMDgb0NfydHxvxKzraLjaUfx+//1f7ZhRRsuDOSdhZZByvN
         QCYV11xUIF9LEM2DCOw24I9hFnajW8dwg8svVGpfqlXr7PyCwW+kqJTAOHaOdwJrFq3V
         wcBs8eYesRQg9Yfc1YicnAs5GMVg8iSwrUSImPHg+aNn8+4lHN6W2CUxn3NgLl75rWyM
         qGtg==
X-Gm-Message-State: AOAM530kJ+wvA6S+TIPwDz4SMJjfiBYIE0fOjYnsSYM7uVSbQd/v+X/f
        +9T+5TzhuwkzkW8QDDkPeok=
X-Google-Smtp-Source: ABdhPJwmr7yCGlGsGBxiF2TATphq27GajOli/euKSMx07hdul5BkpqZyebCmLrnNWmPNbwuD0Pzuig==
X-Received: by 2002:a17:902:ebca:b0:15f:4cc5:f40f with SMTP id p10-20020a170902ebca00b0015f4cc5f40fmr2643383plg.96.1654139327765;
        Wed, 01 Jun 2022 20:08:47 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id e22-20020a17090a4a1600b001e345c579d5sm2056326pjh.26.2022.06.01.20.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 20:08:47 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Tero Kristo <kristo@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        linux-omap@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] clk: ti: dra7-atl: Fix reference leak in of_dra7_atl_clk_probe
Date:   Thu,  2 Jun 2022 07:08:36 +0400
Message-Id: <20220602030838.52057-1-linmq006@gmail.com>
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

pm_runtime_get_sync() will increment pm usage counter.
Forgetting to putting operation will result in reference leak.
Add missing pm_runtime_put_sync in some error paths.

Fixes: 9ac33b0ce81f ("CLK: TI: Driver for DRA7 ATL (Audio Tracking Logic)")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/clk/ti/clk-dra7-atl.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/ti/clk-dra7-atl.c b/drivers/clk/ti/clk-dra7-atl.c
index aa0950c4f498..5c278d6c985e 100644
--- a/drivers/clk/ti/clk-dra7-atl.c
+++ b/drivers/clk/ti/clk-dra7-atl.c
@@ -253,14 +253,16 @@ static int of_dra7_atl_clk_probe(struct platform_device *pdev)
 		if (rc) {
 			pr_err("%s: failed to lookup atl clock %d\n", __func__,
 			       i);
-			return -EINVAL;
+			ret = -EINVAL;
+			goto pm_put;
 		}
 
 		clk = of_clk_get_from_provider(&clkspec);
 		if (IS_ERR(clk)) {
 			pr_err("%s: failed to get atl clock %d from provider\n",
 			       __func__, i);
-			return PTR_ERR(clk);
+			ret = PTR_ERR(clk);
+			goto pm_put;
 		}
 
 		cdesc = to_atl_desc(__clk_get_hw(clk));
@@ -293,8 +295,9 @@ static int of_dra7_atl_clk_probe(struct platform_device *pdev)
 		if (cdesc->enabled)
 			atl_clk_enable(__clk_get_hw(clk));
 	}
-	pm_runtime_put_sync(cinfo->dev);
 
+pm_put:
+	pm_runtime_put_sync(cinfo->dev);
 	return ret;
 }
 
-- 
2.25.1

