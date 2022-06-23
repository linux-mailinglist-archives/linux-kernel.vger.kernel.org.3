Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53F1F5577D0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 12:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbiFWKYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 06:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbiFWKYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 06:24:43 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5CD149CB9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 03:24:41 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id u12so40036280eja.8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 03:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OcOxzRrmout0J6KGnfy+0CFuX6gez+EVlPisuTa/Efo=;
        b=XXHC1h9NIZtSXCdxkZC4+2oX9kyJq0XfXoQRxh/3fYGxrkAM7yJJkZXGwKFVEPXVKM
         qeeqdGJuhE41gxChF0BRzJmR8ELmhG+QgmesJX9uThU4trQu4aMoVbP6dVx4ya6H6xhO
         75wgzV14RihAQZgf20b/xXmyzAnreJYWHz7zCzTIz7mjRYM8tWwo/JSCveoP8Lnl4+w+
         6jOAC3CgH2u+K0d4wTYUhMqqKyHDWIsO10yNJPuqTwtMUqMEj/7yOrVi91SEbqTTJEUQ
         zieybDJZ1vziRz5yMLWK2Kx+EdEhJJ8H0x3uj4PWHhzYWz5F50IFmxoonty0WBgNHBew
         fRDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OcOxzRrmout0J6KGnfy+0CFuX6gez+EVlPisuTa/Efo=;
        b=Zps6f7vdxxBfF6rnWR/viOS4W8aCoHDCJyoIPza++D26XdWUlMDVzuD7s+a5fCqnDX
         4V9HCCiKOHa6w+pTSHgCx1xLVbdg3XYmHaE5SOwOQgtifEk92FCEZEf1RHjakBTLa3vg
         au0y6JINXyaXUG6cEH8voRemj81D1UsjVHhecPv4Bx8gQ/eD2lG8WxsdABSEuUilnTLW
         ti93Gs02963IRB4L4WLZ/eskaxdPB8ge9T+s7/DHPlolqgGhjGkODW+E81PrBhTvuzaY
         oIl99EMQARerZ0aKqLNJNSS+dKeKwY2Df940o+Dq8tgzCScoUpf7ny9EmwSsw91Az2uG
         sJXA==
X-Gm-Message-State: AJIora/UwUjZI7gEdSwcuzR+xTi79bQwArhZnY8qYZg40ItZxl5vE6FP
        jNeDnd/ZqgRefA/QvGnI1BWyrQ==
X-Google-Smtp-Source: AGRyM1v+zfjYyrIJHG7DNkBmGM+zEYv9Y2gwhU7r8LrRr5hAnM0h81pD2+LM9BZAFfGUuis78PUwdA==
X-Received: by 2002:a17:906:1c9:b0:712:1115:42a5 with SMTP id 9-20020a17090601c900b00712111542a5mr7234837ejj.662.1655979880272;
        Thu, 23 Jun 2022 03:24:40 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id 15-20020a170906300f00b006f3ef214dd9sm10692128ejz.63.2022.06.23.03.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 03:24:39 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Doug Gilbert <dgilbert@interlog.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v4 2/3] scsi: ufs: ufshcd-pltfrm: constify pointed data
Date:   Thu, 23 Jun 2022 12:24:31 +0200
Message-Id: <20220623102432.108059-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220623102432.108059-1-krzysztof.kozlowski@linaro.org>
References: <20220623102432.108059-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Constify pointers to data which is not modified for code safety.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/ufs/host/ufshcd-pltfrm.c | 10 +++++-----
 drivers/ufs/host/ufshcd-pltfrm.h |  4 ++--
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/ufs/host/ufshcd-pltfrm.c b/drivers/ufs/host/ufshcd-pltfrm.c
index e7332cc65b1f..e0b7c02092cc 100644
--- a/drivers/ufs/host/ufshcd-pltfrm.c
+++ b/drivers/ufs/host/ufshcd-pltfrm.c
@@ -26,7 +26,7 @@ static int ufshcd_parse_clock_info(struct ufs_hba *hba)
 	int i;
 	struct device *dev = hba->dev;
 	struct device_node *np = dev->of_node;
-	char *name;
+	const char *name;
 	u32 *clkfreq = NULL;
 	struct ufs_clk_info *clki;
 	int len = 0;
@@ -79,8 +79,8 @@ static int ufshcd_parse_clock_info(struct ufs_hba *hba)
 	}
 
 	for (i = 0; i < sz; i += 2) {
-		ret = of_property_read_string_index(np,
-				"clock-names", i/2, (const char **)&name);
+		ret = of_property_read_string_index(np,	"clock-names", i/2,
+						    &name);
 		if (ret)
 			goto out;
 
@@ -208,8 +208,8 @@ static void ufshcd_init_lanes_per_dir(struct ufs_hba *hba)
  *
  * Returns 0 on success, non-zero value on failure
  */
-int ufshcd_get_pwr_dev_param(struct ufs_dev_params *pltfrm_param,
-			     struct ufs_pa_layer_attr *dev_max,
+int ufshcd_get_pwr_dev_param(const struct ufs_dev_params *pltfrm_param,
+			     const struct ufs_pa_layer_attr *dev_max,
 			     struct ufs_pa_layer_attr *agreed_pwr)
 {
 	int min_pltfrm_gear;
diff --git a/drivers/ufs/host/ufshcd-pltfrm.h b/drivers/ufs/host/ufshcd-pltfrm.h
index 43c2e412bd99..fead72998dca 100644
--- a/drivers/ufs/host/ufshcd-pltfrm.h
+++ b/drivers/ufs/host/ufshcd-pltfrm.h
@@ -25,8 +25,8 @@ struct ufs_dev_params {
 	u32 desired_working_mode;
 };
 
-int ufshcd_get_pwr_dev_param(struct ufs_dev_params *dev_param,
-			     struct ufs_pa_layer_attr *dev_max,
+int ufshcd_get_pwr_dev_param(const struct ufs_dev_params *dev_param,
+			     const struct ufs_pa_layer_attr *dev_max,
 			     struct ufs_pa_layer_attr *agreed_pwr);
 void ufshcd_init_pwr_dev_param(struct ufs_dev_params *dev_param);
 int ufshcd_pltfrm_init(struct platform_device *pdev,
-- 
2.34.1

