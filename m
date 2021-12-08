Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8DB446D508
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 15:05:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234706AbhLHOJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 09:09:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234653AbhLHOJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 09:09:17 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D16C061746;
        Wed,  8 Dec 2021 06:05:45 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id u1so4215015wru.13;
        Wed, 08 Dec 2021 06:05:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FmTOFqjVxki8cZU+aa74RnBASpfg0MyIeQg/J9RS4VA=;
        b=Mo8uxOCQye+dU+DdDSe/z/0E9dnG2Lq8RHqJ81XtKalNKURqbSDidM4yMulADErNxA
         J1t7OYKUpv6tjN8pCY/Rxy6+gmDguyOiB0bf5pMzZJNuCWUap61QqOxFbtiM0pwVLVnQ
         kJ/78oIPsvhVdupxq7h1uuS+7Ht9yRWElUFazJSUoipkql7FknoI0GRL+K3ED/+qfR3w
         c7Xo6/kg5bXihrx6Ig9rmzTMfDtQmSb4Ad3EzsYW4r4jg3H9OyOh9IT7h4ss83/s+zKh
         atliYmbmaWnU67CuwIl5RRv/2Rlnn5F8Z4KQeGamYg5yuQ3+tOwb50SWQRQb/49DCgN9
         mLbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FmTOFqjVxki8cZU+aa74RnBASpfg0MyIeQg/J9RS4VA=;
        b=hfuk45wm+TG6HCN2jXWsNaKPkWKlPBT6oUKZYtcUfRo7NjvyHtMkVDV4haWbCnpWfv
         hP+rS17ACUy9Id4TO6UzD0H32cuKf+2QmvcO3V7x1wPY1DsZX3irz4v8Rpserg25eWT1
         V6k4g1g+jwLc+pjO4ATejhbufeJOPdh3OfWJUvHm845kMo9DRow1+tr83bsnr39J7VVl
         dTEgYuP8RZPI2WakTHrK03utARlCkqeCfWfJxAU/VZ2mE8NaPAtIDXxpOuTbg5qv91w8
         BUFqcQUUMRB8MbwUKIAjKLGNbjGLZ/H5746Zn1hRaJ0qaa1Juoj1VNPrYgBKYupq/BC5
         Jm6Q==
X-Gm-Message-State: AOAM532EhkJ04f5b+aE1BUgzkm3Wd9CNL4LJra/8OwL159Um+3XCdrx+
        8BSQP4L72WWtuEWrZkiAQWqgDCS1tJ4CfA==
X-Google-Smtp-Source: ABdhPJwm6JslislsBSA3HkfvknWC762P26cTQK0RAd3fGuv8kwgqsqVQBWS7h11Zw1VwIURSu8iUMA==
X-Received: by 2002:adf:a412:: with SMTP id d18mr59823794wra.529.1638972343630;
        Wed, 08 Dec 2021 06:05:43 -0800 (PST)
Received: from localhost ([193.209.96.43])
        by smtp.gmail.com with ESMTPSA id z5sm7434049wmp.26.2021.12.08.06.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 06:05:42 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] misc: sram: Add compatible string for Tegra234 SYSRAM
Date:   Wed,  8 Dec 2021 15:05:41 +0100
Message-Id: <20211208140541.520238-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mikko Perttunen <mperttunen@nvidia.com>

We want to use the same behavior as on Tegra186 and Tegra194, so add
this the compatible string for Tegra234 SYSRAM to the list.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/misc/sram.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/sram.c b/drivers/misc/sram.c
index 4c26b19f5154..f0e7f02605eb 100644
--- a/drivers/misc/sram.c
+++ b/drivers/misc/sram.c
@@ -371,6 +371,7 @@ static const struct of_device_id sram_dt_ids[] = {
 	{ .compatible = "atmel,sama5d2-securam", .data = &atmel_securam_config },
 	{ .compatible = "nvidia,tegra186-sysram", .data = &tegra_sysram_config },
 	{ .compatible = "nvidia,tegra194-sysram", .data = &tegra_sysram_config },
+	{ .compatible = "nvidia,tegra234-sysram", .data = &tegra_sysram_config },
 	{}
 };
 
-- 
2.34.1

