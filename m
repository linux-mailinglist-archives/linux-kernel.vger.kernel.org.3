Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEF2852762A
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 08:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235883AbiEOGmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 02:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235879AbiEOGmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 02:42:31 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A27A222B2;
        Sat, 14 May 2022 23:42:29 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id bo5so11311944pfb.4;
        Sat, 14 May 2022 23:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R70u7aKcalBy/OfNQ27Efmy9t/Kzj8CNy0QFYWzkyIg=;
        b=PaEiC5KNfp1oJ/1byQ6sKlb0XBZfuoy6H+ca9hxE+ZFIADImwXIyvZxMv1kib9xMx0
         KTqjrr7jmOjS9m39Cd1LLBR2qBa4esr4sSl3jOkjCEGWxe1/zsfsJPsNwKzejKr/fRue
         +dKW+uzQoiD47Leg5jEwcVSqDZQbWUzqnG5QQVmHUJk4vtTyid2Bz5pJV2dD9vpSpMyT
         Bl38jdSs/16kPbWX2g/9C4G8tbyaHx8ZgmztmyadkG50zTUQztkaSHK9DHjsE1h7G8Ua
         D4Ztmk3bZj2MuU9koAvETVgAdEu7ynJjF1VCMfHr75L2G3maOutPGjHsDdmjaCqB3Ha0
         DWow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R70u7aKcalBy/OfNQ27Efmy9t/Kzj8CNy0QFYWzkyIg=;
        b=xP9lRzHSAdvvIGH5+86duQzSgpDasZ/HpvmH1TuuUkzIqhmEziJGmC09vCAQs/XJfK
         INAwwqV8Lde3ex3Ld+iqRuVI234G6zzs9fxBuKg2pA3eFduTELSi0DuQd9QJWK7lkZLi
         +oOWDC9P6sy/eaPIoHD4rmd+JkdldXNUc4q8rF0vENuVdhXpHplJGoXwMXKEuvWUuCvh
         0FzVAwdxQMBmcq456bRoB8UimGulAEbqgBDW+kPlD1uWVarHMWi4kMSLeloy2bIZuNx2
         20DVpRA58Qpqy7LXFD0HsF7bJLLxkT8tpMBoAaDMI4jbf4FJjLsE6Jou8kI1TbRxSPUg
         FJDQ==
X-Gm-Message-State: AOAM5333ob2O6kLI0iLcmJ3lVkl8X3MltLG6uh0sfSMnWleW2uPDmPlX
        T/V1ao+peSQmZQVEr3q9xDQ=
X-Google-Smtp-Source: ABdhPJw1IgUFDGp0uoKhqpfGvW0FjfkaLTJupB0PEcRiLm+MbVXGkcGdILpLntVDoY7cYo5x/NFAZg==
X-Received: by 2002:a63:5f07:0:b0:3db:8691:f66e with SMTP id t7-20020a635f07000000b003db8691f66emr10455711pgb.567.1652596948704;
        Sat, 14 May 2022 23:42:28 -0700 (PDT)
Received: from alarm.. ([103.51.72.28])
        by smtp.gmail.com with ESMTPSA id g24-20020a170902d5d800b0015e8d4eb2e3sm4568687plh.301.2022.05.14.23.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 May 2022 23:42:28 -0700 (PDT)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Anand Moon <linux.amoon@gmail.com>
Subject: [PATCHv2 4/6] thermal: exynos: fixed the efuse min/max value for exynos5422
Date:   Sun, 15 May 2022 06:41:21 +0000
Message-Id: <20220515064126.1424-5-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220515064126.1424-1-linux.amoon@gmail.com>
References: <20220515064126.1424-1-linux.amoon@gmail.com>
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

As per Exynos5422 user manaul e-Fuse range min~max range is 16~76.
if e-Fuse value is out of this range, then thermal sensor may not
sense thermal data properly.

Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
v1: Fix the commit message
---
 drivers/thermal/samsung/exynos_tmu.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 58ff1b577c47..0faec0f16db6 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -926,12 +926,14 @@ static int exynos_map_dt_data(struct platform_device *pdev)
 		data->gain = 8;
 		data->reference_voltage = 16;
 		data->efuse_value = 55;
-		if (data->soc != SOC_ARCH_EXYNOS5420 &&
-		    data->soc != SOC_ARCH_EXYNOS5420_TRIMINFO)
+		if (data->soc == SOC_ARCH_EXYNOS5420 &&
+		    data->soc == SOC_ARCH_EXYNOS5420_TRIMINFO) {
+			data->min_efuse_value = 16;
+			data->max_efuse_value = 76;
+		} else {
 			data->min_efuse_value = 40;
-		else
-			data->min_efuse_value = 0;
-		data->max_efuse_value = 100;
+			data->max_efuse_value = 100;
+		}
 		break;
 	case SOC_ARCH_EXYNOS5433:
 		data->tmu_set_trip_temp = exynos5433_tmu_set_trip_temp;
-- 
2.36.1

