Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51E4259FA06
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 14:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237626AbiHXMar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 08:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236586AbiHXMag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 08:30:36 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E494615A1D
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 05:30:35 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id g18so16915614pju.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 05:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=FDm84dyy75ENZ0IrYEJTEobHEymiTqy3rBmHZuIhj6A=;
        b=ltGAr6JpF5rXO3b+Wn9cL3fNxmpSKzik53UOFwkssxyTQZYyZsBJsI7PSdbVf2yu6l
         y7NfphDA+xbrJMBiJcOEDF/Rr3EGkfrHHKNbezh2ByoAk+BYkz1NFTnFoLiV+JmIlasu
         kGwYx90rKcagSgnNhutP1u4fDSgFiY3TjOgHDQ2miCDEYriE7Ts8/S75u0VGUqGZO1+N
         3dKlwxiysFeJNYuBsBE+qOz3ReMsW3u1aXO9tYMCqXMohx7ogiuYaikDqGfHUVbdQQsJ
         OuZUYRM/kcK3jFcFA8ODGgcDM4VKOmY7LIspuGIytaEp7ngzywnLhdJxFJwBfDbnApN3
         YwlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=FDm84dyy75ENZ0IrYEJTEobHEymiTqy3rBmHZuIhj6A=;
        b=xyPgbAsa+ae/JYMh6p4sflNw+Qf3Z7Lkkh248jOlH9fz8tV6AoZ4hcCFA/w79fbwI1
         4eZ1KMLnAjp9lKIc6l9nnEs8VOxCk1/l60Y7tvcvEo0F92/oSeiRsYvwFVvS+dZ+Dsyk
         iLOOIHudH7Tl3RDH+D8k9sgAvYxj4zN5eIPueIyXzWvBbiYqzG90ylwfsZy2IcsxE3jR
         cqyYauTMjN96aJZeR4B1ifJPHR6Vyzy3soRVfRwf+gElK1L6ioqEtTMtD5SNKyEPOtFc
         UvP6oPZPWU4Tq8p+pvIJA/ifjMEBHFKAlbpwt9SKFSUM7VTA6GiyQ0aYVtPPzX3/XDGH
         StmQ==
X-Gm-Message-State: ACgBeo2uWAhJz654JgIDbBYxs6gtX9aS7RVQjr6Y4lFdQ4AmGD92BWhL
        WRj7pUE5mxYz1ZDwEBQQ2A5f
X-Google-Smtp-Source: AA6agR4gBzmuGb87Azs89AknZIhwzdo+ke4N5E/7y/nF0rubNHOj6n+ye8BpQGQFAcIQ+I+hV2FceQ==
X-Received: by 2002:a17:90a:8b82:b0:1fa:973c:1d34 with SMTP id z2-20020a17090a8b8200b001fa973c1d34mr8181609pjn.31.1661344235395;
        Wed, 24 Aug 2022 05:30:35 -0700 (PDT)
Received: from localhost.localdomain ([117.207.24.28])
        by smtp.gmail.com with ESMTPSA id b3-20020a1709027e0300b00173031308fdsm3539220plm.158.2022.08.24.05.30.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 05:30:35 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     kishon@ti.com, gregkh@linuxfoundation.org, lpieralisi@kernel.org
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        mie@igel.co.jp, kw@linux.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 4/5] misc: pci_endpoint_test: Remove unnecessary WARN_ON
Date:   Wed, 24 Aug 2022 18:00:09 +0530
Message-Id: <20220824123010.51763-5-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220824123010.51763-1-manivannan.sadhasivam@linaro.org>
References: <20220824123010.51763-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If unable to map test_reg_bar, then probe will fail with a dedicated
error message. So there is no real need of WARN_ON here.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/misc/pci_endpoint_test.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index a7d8ae9730f6..5e4d4691a160 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -810,10 +810,8 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
 		if (pci_resource_flags(pdev, bar) & IORESOURCE_MEM) {
 			base = pci_ioremap_bar(pdev, bar);
-			if (!base) {
+			if (!base)
 				dev_err(dev, "Failed to read BAR%d\n", bar);
-				WARN_ON(bar == test_reg_bar);
-			}
 			test->bar[bar] = base;
 		}
 	}
-- 
2.25.1

