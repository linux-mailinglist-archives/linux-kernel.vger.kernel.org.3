Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74BE7487392
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 08:31:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235437AbiAGHbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 02:31:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235400AbiAGHbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 02:31:33 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16444C061245;
        Thu,  6 Jan 2022 23:31:33 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id g2so4765016pgo.9;
        Thu, 06 Jan 2022 23:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=weIS9HwVlyNyw+T3Cb+eEG7d4JKYOeqCLfsbY8A/UBc=;
        b=gIZeAQfnlLYxCh3zDWYj0D4FwWvXGByE5lnPKqmmOVekbBIQBAZb2vd4SsE7gSp/MA
         rqC1LdHT2UejqI6YxKOCIICwdscRaRIHhMnYqBk6kM/uAQLZuZd+Voshx463MZoq8SUS
         XJuDloXJwcTewC4174L+wJ9sfcmDNw9RX/dAbNA8Q4iFPI5nuQ+9MP2Q/bCc/b0b1zos
         fAJRFHv0CTJDarqk7IeU6xUshpBX4n9CjWUuyt3dqWeaWW93saqFMeHFh4IsHF4zvT2N
         FtbEKyRS7Zs4Unshz1opUV0ISktkKrNQJcExaVf9rmd/VIe1FI+8IAS8hLqzLGAJNMth
         uWZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=weIS9HwVlyNyw+T3Cb+eEG7d4JKYOeqCLfsbY8A/UBc=;
        b=vnp+cHOW7ce2lMlpJapTsH3+KVP/DkY6Ecqm+ibCwuxONZdoaGd72fu9ppVpZAq5gN
         O7aEvfYJVnEPXsSDjMZbvhtIPVtsPSPxzhd8uOPV8T30F8FG7Tx3gaCvl/RPmHxWychD
         Y/UR9eyBhQazbl29+ZpsDuDCCO9HX6Rf/5Kwr19it03628A2zZxjHa/i7Q+qCWSVTN7/
         wOzQ30sU4pnwelKm2nokZQKsUIUwNIQZlT/pGRSqA50WlKNy0MiMszAmj6lOVnO8ytXm
         JAXHw86aj4ZZC3GUFQNkw73ZZq02O4CiYr3gtZxKtmhIzFwI+7JdJPCybbd9UCVIg8e9
         tGwg==
X-Gm-Message-State: AOAM532HuA9rhO8+YSx/OIIgqY8tvuBK/DcP3RLhCFFxddtlWsnxerG6
        TNSsWnyZf4OCeg+BEhS4pg4=
X-Google-Smtp-Source: ABdhPJwIX4Eyz5JXvr3CmVZJFI5y+fDLb5kbyADdcn71b6n5AzRh++tMHIgMLXphEuZLP+PDjRJIpg==
X-Received: by 2002:a05:6a00:24c6:b0:4bb:e02:9d4 with SMTP id d6-20020a056a0024c600b004bb0e0209d4mr63884176pfv.39.1641540692503;
        Thu, 06 Jan 2022 23:31:32 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id n10sm962360pje.0.2022.01.06.23.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 23:31:32 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
Cc:     linmq006@gmail.com, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Luca Weiss <luca@z3ntu.xyz>,
        Brian Masney <masneyb@onstation.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] soc: qcom: ocmem: Fix missing put_device() call in of_get_ocmem
Date:   Fri,  7 Jan 2022 07:31:26 +0000
Message-Id: <20220107073126.2335-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The reference taken by 'of_find_device_by_node()' must be released when
not needed anymore.
Add the corresponding 'put_device()' in the error handling path.

Fixes: 01f937ffc468 ("soc: qcom: ocmem: don't return NULL in of_get_ocmem")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/soc/qcom/ocmem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/qcom/ocmem.c b/drivers/soc/qcom/ocmem.c
index d2dacbbaafbd..97fd24c178f8 100644
--- a/drivers/soc/qcom/ocmem.c
+++ b/drivers/soc/qcom/ocmem.c
@@ -206,6 +206,7 @@ struct ocmem *of_get_ocmem(struct device *dev)
 	ocmem = platform_get_drvdata(pdev);
 	if (!ocmem) {
 		dev_err(dev, "Cannot get ocmem\n");
+		put_device(&pdev->dev);
 		return ERR_PTR(-ENODEV);
 	}
 	return ocmem;
-- 
2.17.1

