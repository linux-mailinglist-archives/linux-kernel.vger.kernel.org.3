Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B14C4DD8AA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 12:01:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbiCRLCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 07:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235617AbiCRLCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 07:02:34 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77F522D7ABC;
        Fri, 18 Mar 2022 04:01:08 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id p5so3013363pfo.5;
        Fri, 18 Mar 2022 04:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+DfTezyTZEEgXa3A9GdADPNqeC5t3FMBzFeEqDv248I=;
        b=flDJYeJw11Atosup9EVcV2btSWN1r1qbFUvRc2kOuCoL0/LO4gaVVakhSgRWpoD//U
         +3BPSN29KgOWAa/CGHb3OmDPZPEMcHy5AQ+Ltv6X/d3VLimhfkhjdxJDGDHDz1/UCxr3
         pUv6sRK2PMX9KUUWMUWoT0zMAoXiacU0Q9jHxPZ9QTtsyyCpEhoiqzucQEa7XnknVVwk
         qxqwvCszpYntEcIlRrTN9sFzrs8pefU0DzYyESEvm6XflD0hJXDiLTveuCaIHOG9x5AA
         zj7Gd+/sZA2bZZBIANqHSmq5m6ou7ktXnOhxGvNwEClXJ3cLFoWjmaSE4gfMPsUxB9Hp
         rXbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+DfTezyTZEEgXa3A9GdADPNqeC5t3FMBzFeEqDv248I=;
        b=JtESDvzsO3zU8JwuOAnexfLKpFcPZujY/osiuemtYHkXu/ZDg3UqCdyZaAO2Ftbjw3
         99o6rp1J4dbMJltIPeAEG1CD0zXUPMclQRRdH3EjDgCoPtdVetiapG+zsO/PCD4A1gYV
         EeZ9TaOa5abjAySqVzJYWnEixF5+cFhVJEPxrSXmdqJf3CBKX2LSjUPjpCVWXaFXEE7S
         PCiMdfXIZZvyxY9ZsX0DdBuokbuHIZs+HVuZtqY53KTBJHTlKphbYxg+tGdgh/qtOHY4
         IArJEzOf0RSrO2zlhvAdRennYyGoPbNFM8Qaea0WNNF9cX6+4RwNUPQH4ddfrGsYJP6b
         brZQ==
X-Gm-Message-State: AOAM533bDu5wf582PIrJ24mSFeutCE5Bnuy+Qy1VQWaJW7lSnMaWFDW5
        YM8D5Xtxf/kq7rvIbEmpMDY=
X-Google-Smtp-Source: ABdhPJwdkiq3tFwjozVCjtQH0QfyWdY4uO8RrtKPh0PJaTcZeItVID4T4ekwLFEDdgtI6CNR277/2g==
X-Received: by 2002:a05:6a00:198c:b0:4f7:7e0f:bfc2 with SMTP id d12-20020a056a00198c00b004f77e0fbfc2mr9225986pfl.44.1647601267807;
        Fri, 18 Mar 2022 04:01:07 -0700 (PDT)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id y3-20020a056a00190300b004fa2411bb92sm9276071pfi.93.2022.03.18.04.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 04:01:07 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Kyunmin Park <kyungmin.park@samsung.com>,
        linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH v2] media: exynos4-is: Change clk_disable to clk_disable_unprepare
Date:   Fri, 18 Mar 2022 11:01:01 +0000
Message-Id: <20220318110102.29506-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220316015344.5120-1-linmq006@gmail.com>
References: <20220316015344.5120-1-linmq006@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The corresponding API for clk_prepare_enable is clk_disable_unprepare,
other than clk_disable.

Fix this by changing clk_disable to clk_disable_unprepare.

Fixes: b4155d7d5b2c ("[media] exynos4-is: Ensure fimc-is clocks are not enabled until properly configured")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
changes in v2:
- fix typo in commit message.
---
 drivers/media/platform/exynos4-is/fimc-is.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/exynos4-is/fimc-is.c b/drivers/media/platform/exynos4-is/fimc-is.c
index e55e411038f4..8e88b0f6662d 100644
--- a/drivers/media/platform/exynos4-is/fimc-is.c
+++ b/drivers/media/platform/exynos4-is/fimc-is.c
@@ -140,7 +140,7 @@ static int fimc_is_enable_clocks(struct fimc_is *is)
 			dev_err(&is->pdev->dev, "clock %s enable failed\n",
 				fimc_is_clocks[i]);
 			for (--i; i >= 0; i--)
-				clk_disable(is->clocks[i]);
+				clk_disable_unprepare(is->clocks[i]);
 			return ret;
 		}
 		pr_debug("enabled clock: %s\n", fimc_is_clocks[i]);
-- 
2.17.1

