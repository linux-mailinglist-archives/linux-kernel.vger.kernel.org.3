Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 059624C1BDF
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 20:16:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235268AbiBWTQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 14:16:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235568AbiBWTP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 14:15:59 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC4C53FBCD
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 11:15:31 -0800 (PST)
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id BF60440931
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 19:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645643729;
        bh=WWBR/3RyyId0ctzqGYcSjorUZAyYEVp2bjQXWveQ/28=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=G3aWHWf5OfhGUIVQqjn8G+xNBfCnBKB07GueZlhBJ1IvCUB3eD++APC6ZXGyFhOWG
         5xMPqJdAfdoOPf4y0wDChBifJfbj3uanvWgHNcYvc1sRXuyxpBbXSiMZro/via8j7T
         oqKGzZI+QsuI0iBYnSBFbn4j4iJ8JPxT94nQi2otrf9LZqQFgsSHG26pOAyZB/ig7B
         wmk+LdIFUCqpVVVQcAU33lYBf4jIT7UFsQDYAPMu4xdAH/4498n4Z00wXox5w3kpa+
         ESCN3zsJBJwnMrN+4tISySBeio/kXl1TbncRwcbDun+CnV9bYO/OM+tZjem+Wv6Ppp
         D+fnNGYb8+lzQ==
Received: by mail-ej1-f70.google.com with SMTP id kw5-20020a170907770500b006ba314a753eso7464031ejc.21
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 11:15:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WWBR/3RyyId0ctzqGYcSjorUZAyYEVp2bjQXWveQ/28=;
        b=IRq7IwOVjYis65ymTDS2fSCDlP+mFWUv05YMH/3ChV7Bv9Vb15wLzl6XMntmIaH8M5
         42P2pQTeMrVfgKDYt9A/uV5jbiaFrUEFRX+xEnD8iv2kGtop5TNiCO4LnlrvUmPrMd+a
         hHaJXwdIHL72yddpWKxJqzR/vGre0asCzJIbeJxfh/AMuhUFDP33A1lmYd/bTYmOyhfD
         LxM12O8SXSv4B64F7NYE24IDJqPUXJUpmYZsoEKTG+I1Qnt9TZialeeN/0WL6mCkEpXb
         uOOvAEAI2tJvE9U21oYmrF0xrVVtN7AMCxC3o9QY83ahB4IqizDnm4J0p1NfVYKbQ244
         LZBw==
X-Gm-Message-State: AOAM530jMFLgMWVqhQzzmuzTRpElmDAvC/+NMq6+YfdTfKuCfjVZszOI
        Jh3i08znPzwG6BzV8ciQQKcz1CUA0mCy4qxhVfQXKoahoeOrH3r2g5ACrjrnCh+v07t0SEvnHez
        x7RSIyOCl+nXhoZloR+2UqCocTQBcBdsGBQFh6IVCzg==
X-Received: by 2002:a05:6402:70d:b0:410:ba4d:736f with SMTP id w13-20020a056402070d00b00410ba4d736fmr891831edx.0.1645643727230;
        Wed, 23 Feb 2022 11:15:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw8vcySNYfbv43Pk2WXynTAOxXboVgUUSRQKZSxFWxW+kHULs5hedJTU2eFScz4UFZao2eyYQ==
X-Received: by 2002:a05:6402:70d:b0:410:ba4d:736f with SMTP id w13-20020a056402070d00b00410ba4d736fmr891811edx.0.1645643727044;
        Wed, 23 Feb 2022 11:15:27 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id b3sm208368ejl.67.2022.02.23.11.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 11:15:26 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Andy Gross <agross@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-spi@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        stable@vger.kernel.org
Subject: [PATCH v2 09/11] clk: imx: scu: fix kfree() of static memory on setting driver_override
Date:   Wed, 23 Feb 2022 20:14:39 +0100
Message-Id: <20220223191441.348109-3-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220223191310.347669-1-krzysztof.kozlowski@canonical.com>
References: <20220223191310.347669-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver_override field from platform driver should not be initialized
from static memory (string literal) because the core later kfree() it,
for example when driver_override is set via sysfs.

Use dedicated helper to set driver_override properly.

Fixes: 77d8f3068c63 ("clk: imx: scu: add two cells binding support")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/clk/imx/clk-scu.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-scu.c b/drivers/clk/imx/clk-scu.c
index 083da31dc3ea..15e1d670e51f 100644
--- a/drivers/clk/imx/clk-scu.c
+++ b/drivers/clk/imx/clk-scu.c
@@ -683,7 +683,12 @@ struct clk_hw *imx_clk_scu_alloc_dev(const char *name,
 		return ERR_PTR(ret);
 	}
 
-	pdev->driver_override = "imx-scu-clk";
+	ret = driver_set_override(&pdev->dev, &pdev->driver_override,
+				  "imx-scu-clk");
+	if (ret) {
+		platform_device_put(pdev);
+		return ret;
+	}
 
 	ret = imx_clk_scu_attach_pd(&pdev->dev, rsrc_id);
 	if (ret)
-- 
2.32.0

