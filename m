Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7222751D5C8
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 12:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391022AbiEFKfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 06:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390993AbiEFKfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 06:35:07 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D32760D9F
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 03:31:24 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id bv19so13630600ejb.6
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 03:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G7AKvMZPXvXSnfImyNv30/Tu154Oa9ejf/GkvDjzFBY=;
        b=Z8cFLDFsO5ZuGKiEQJA03dJNctu2elENQQ0uxCdgWJmVkg61HPj3j9GZ87Kz0PJTVp
         HhFbD+MXuribyNGlSjqe4zeE0Ty9YxwOyMP2VeQuNR/TWNeVogE1eD2qK8NTkrJuSB+S
         GQfnac9V/6qH12wFzEKptjotXX+cbzvmhc1hut6c/rihIRA0nV0yaXdj08N2fhqdkwF/
         uCpgQkipkN6khlNu7K35YUhmeqVUH/58DsCmlGH3meVthU3rxOhbPVD7i4zaSMdLLhtB
         a2osizx9oSJNsSftMpB6t3vLMGYmNZw/nCvC2Y0VXnf6fwToppdP9L/CrFbwJihkIi9r
         Qcuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G7AKvMZPXvXSnfImyNv30/Tu154Oa9ejf/GkvDjzFBY=;
        b=lJvp+zcMVSgAQ1pGOgYGsDfn0AGXcYifljjYwXIrOMY8Xf4kthgrRqs5YduvRw9/PK
         EBe/xuuyHwNLpsFKXjcms+UOEe1sro/eHmLUEPCDGindA88l/PO82r+pWkY/SOsD9OCU
         /qN42dDjSxY+ltyYEcJtx9xW25fHXSK2jowBYceb2MBfWgQvZes+TG6wd8BJHM8Wmx0W
         4IcAUbRqLeYC7S9r6ruKbXHqLoruEwObeBbMThkkvYofp/Ero/dkWncz/6aQZpQOgUWk
         GRuIqgJ9FfXqFxaxAR1uxhX6tSBMp/iZ4Tkpcm8q1oD/vNeL8ko1TYFOHvvmXrQUChZP
         xTVQ==
X-Gm-Message-State: AOAM5323PINd1DQw/61dounSd1eJL40sn33ltRdlTmDiYBs5R83Rif+L
        gJcfa76YP8XQLChSznkB2Nut0veXBfgNC6gb
X-Google-Smtp-Source: ABdhPJy+dR+cjNHSaFFy83lVt8fb779H9yBeKHxCkXUgxaa8JTcod6EQOvNGYenOtbBL5+BSuTUxbw==
X-Received: by 2002:a17:906:9c83:b0:6df:839a:a6d0 with SMTP id fj3-20020a1709069c8300b006df839aa6d0mr2296006ejc.419.1651833082631;
        Fri, 06 May 2022 03:31:22 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id em10-20020a170907288a00b006f3ef214e6dsm1726957ejc.211.2022.05.06.03.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 May 2022 03:31:22 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Doug Gilbert <dgilbert@interlog.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 2/3] scsi: ufs: ufshcd-pltfrm: constify pointed data
Date:   Fri,  6 May 2022 12:31:14 +0200
Message-Id: <20220506103115.307410-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220506103115.307410-1-krzysztof.kozlowski@linaro.org>
References: <20220506103115.307410-1-krzysztof.kozlowski@linaro.org>
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

Constify pointers to data which is not modified for code safety.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/scsi/ufs/ufshcd-pltfrm.c | 10 +++++-----
 drivers/scsi/ufs/ufshcd-pltfrm.h |  4 ++--
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/scsi/ufs/ufshcd-pltfrm.c b/drivers/scsi/ufs/ufshcd-pltfrm.c
index f5313f407617..3ab555f6e66e 100644
--- a/drivers/scsi/ufs/ufshcd-pltfrm.c
+++ b/drivers/scsi/ufs/ufshcd-pltfrm.c
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
diff --git a/drivers/scsi/ufs/ufshcd-pltfrm.h b/drivers/scsi/ufs/ufshcd-pltfrm.h
index c33e28ac6ef6..0f0c2942a5be 100644
--- a/drivers/scsi/ufs/ufshcd-pltfrm.h
+++ b/drivers/scsi/ufs/ufshcd-pltfrm.h
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
2.32.0

