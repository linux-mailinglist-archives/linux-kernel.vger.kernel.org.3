Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD9D95A4320
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 08:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbiH2GW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 02:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiH2GWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 02:22:21 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F13F049B61
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 23:22:18 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id x1-20020a17090ab00100b001fda21bbc90so3214767pjq.3
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 23:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc;
        bh=HegVDwbwdx7NAusLYsMykpD/qEuT4JpSnYO/rlTbGxI=;
        b=WjyPukPophUzCtR+SzOAoslZ/bYXM6E+9r5fsGXNAZHioj/vJQ9OynZCp1T79h5aEe
         4dS68FflIgIfuhCXszrCNKz5Qx6TGm5HmOFZTvG8QlsqvENHhr+MKvSoatxrwaJwOlj8
         8JV3z02QJU9hTnao0w2xaFHV0BKP9Zn57aKiic+o1GvNLunKZPp2MkF96H1UpsEMjz+Q
         LMUPUBEfivz663FKZp/b/T79qWS5xL5D6KkIA2aHZQTn3+qPC2wc6PbPNJryhVkVDfmY
         ohMLcL40mm5LX0X8rKdyWjtNtnRVE3tKHDge4bfB4VuY2MNXfS2h2RVUa43KuMZAR+BM
         KTOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=HegVDwbwdx7NAusLYsMykpD/qEuT4JpSnYO/rlTbGxI=;
        b=7LcCLZiZWKDC1tJinflURzRYt9DqraPUbMfvRwQ1wE04CXbEIwf1bFzO//UX59U5YK
         yhmWBMTIhYxUAs0tNC+PxpHFj2MYPTqW2frJOggHfJFCxmB8EDqhMuqEt/Oo2/g6kDLh
         0nP6owk4LNHI4aiXcrukitC8H/aIn/rIasNC21mhfg3U+HY9CpZZ4irB3Ng+sUQxG7Az
         OyYvAIRtCBQTT6xJ8hQy4f+KBoohZ5BN8qrcB8dksAvzpjh0Z6wph1A8u0IsOzLh5WSf
         gdkjoFTNStcik0v0YwTAcFJ3R8t/UClj9BRcNjTGjGSIOxbsL5qgOx2y1z8r5EA51nBI
         kYSA==
X-Gm-Message-State: ACgBeo2c4ZW0BJh9ErhCtReTsY2TR9LxcSGh3WDfK6KQwFjatC44eJm2
        S1w3QaSfCYat6Rz8xMMPeKHtIuDZkCOKqg==
X-Google-Smtp-Source: AA6agR7wY1vr9yMYNUbGEtbcomDYN4hZ6PtMf2FzEeCnczYV47TR3pGVn3Dt37Bs5BFweNFt8JSxaw==
X-Received: by 2002:a17:902:d4c8:b0:174:a871:152d with SMTP id o8-20020a170902d4c800b00174a871152dmr5233087plg.4.1661754137988;
        Sun, 28 Aug 2022 23:22:17 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id mp10-20020a17090b190a00b001f333fab3d6sm5817972pjb.18.2022.08.28.23.22.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Aug 2022 23:22:17 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, greentime.hu@sifive.com,
        conor.dooley@microchip.com, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH 3/3] EDAC/sifive: use sifive_ccache instead of sifive_l2
Date:   Mon, 29 Aug 2022 06:22:02 +0000
Message-Id: <20220829062202.3287-4-zong.li@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220829062202.3287-1-zong.li@sifive.com>
References: <20220829062202.3287-1-zong.li@sifive.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sifive L2 has been renamed to sifive CCACHE, EDAC driver needs to
apply the change as well

Signed-off-by: Zong Li <zong.li@sifive.com>
---
 drivers/edac/Kconfig       |  2 +-
 drivers/edac/sifive_edac.c | 12 ++++++------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index 17562cf1fe97..456602d373b7 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -473,7 +473,7 @@ config EDAC_ALTERA_SDMMC
 
 config EDAC_SIFIVE
 	bool "Sifive platform EDAC driver"
-	depends on EDAC=y && SIFIVE_L2
+	depends on EDAC=y && SIFIVE_CCACHE
 	help
 	  Support for error detection and correction on the SiFive SoCs.
 
diff --git a/drivers/edac/sifive_edac.c b/drivers/edac/sifive_edac.c
index ee800aec7d47..b844e2626fd5 100644
--- a/drivers/edac/sifive_edac.c
+++ b/drivers/edac/sifive_edac.c
@@ -2,7 +2,7 @@
 /*
  * SiFive Platform EDAC Driver
  *
- * Copyright (C) 2018-2019 SiFive, Inc.
+ * Copyright (C) 2018-2022 SiFive, Inc.
  *
  * This driver is partially based on octeon_edac-pc.c
  *
@@ -10,7 +10,7 @@
 #include <linux/edac.h>
 #include <linux/platform_device.h>
 #include "edac_module.h"
-#include <soc/sifive/sifive_l2_cache.h>
+#include <soc/sifive/sifive_ccache.h>
 
 #define DRVNAME "sifive_edac"
 
@@ -32,9 +32,9 @@ int ecc_err_event(struct notifier_block *this, unsigned long event, void *ptr)
 
 	p = container_of(this, struct sifive_edac_priv, notifier);
 
-	if (event == SIFIVE_L2_ERR_TYPE_UE)
+	if (event == SIFIVE_CCACHE_ERR_TYPE_UE)
 		edac_device_handle_ue(p->dci, 0, 0, msg);
-	else if (event == SIFIVE_L2_ERR_TYPE_CE)
+	else if (event == SIFIVE_CCACHE_ERR_TYPE_CE)
 		edac_device_handle_ce(p->dci, 0, 0, msg);
 
 	return NOTIFY_OK;
@@ -67,7 +67,7 @@ static int ecc_register(struct platform_device *pdev)
 		goto err;
 	}
 
-	register_sifive_l2_error_notifier(&p->notifier);
+	register_sifive_ccache_error_notifier(&p->notifier);
 
 	return 0;
 
@@ -81,7 +81,7 @@ static int ecc_unregister(struct platform_device *pdev)
 {
 	struct sifive_edac_priv *p = platform_get_drvdata(pdev);
 
-	unregister_sifive_l2_error_notifier(&p->notifier);
+	unregister_sifive_ccache_error_notifier(&p->notifier);
 	edac_device_del_device(&pdev->dev);
 	edac_device_free_ctl_info(p->dci);
 
-- 
2.17.1

