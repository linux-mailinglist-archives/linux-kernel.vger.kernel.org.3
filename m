Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98AB34C1BBD
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 20:14:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244263AbiBWTPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 14:15:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244236AbiBWTOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 14:14:49 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A861342A3E
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 11:14:18 -0800 (PST)
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 1D28C402D7
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 19:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645643645;
        bh=rf7a9EFQwPOyocENu81tYUT+5dnJvDmCZPPvLR/17AA=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=Oz0rbn++Yhu99bUy836NEBzxwNjVnxyG572juhk2JjpKyWkJ3eDsAXMC5zaisJcPH
         y8TFwv9t4fQPJkpdhqREBBtv+ooELcqEmZRHSigGkxzA0pg9wk2Uv5REE1nXZKjK7q
         ETdL217wqpDM6QAlMDOyP7E19xIKROi4APX9yo6RWo7QlUpZrz/YRTPZvLsLqCnnjF
         +YhkYTH0LwHjXrh0ZhKgRfD1oVHVpLgpXAaljXkalpaaLGeDXXBK9YL117n7v2xdVg
         icRm+ZWLqdb9iFZOjc/K9bYJUkDnqPzfTLCcowkqjPxsdCYlLg8vDKree9z3lITa2B
         xVXSY5EChEfrg==
Received: by mail-ej1-f69.google.com with SMTP id ga31-20020a1709070c1f00b006cec400422fso7471766ejc.22
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 11:14:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rf7a9EFQwPOyocENu81tYUT+5dnJvDmCZPPvLR/17AA=;
        b=E5jLT4P1a/RnAaPTEQGrlHCCbDY46qa5OFGKfd1JN8HjTZ2v1x9NcvwHKjOMHdZcwb
         IN2tfrlPxc98UJQsutAuQoYO+LGDb2XStFsESHu6cAgvu2GEcQ9rZv5lyie0FqOAsdRt
         I83+H0iMZwB6lTobGplHBc0E8K7rD+5DIbOfxBpkXAz0K9hXVqpWzDoaQ0BdQU/BJMEs
         27ZTkVHrXd+o0JpDIH6/hwgAmJj4IFEgJn4gsHvO+t21ba6EegdfD0+8FpkzNGMamK29
         y940VVtcikODDUeyZXC4PM1mM9rjLK9sauYroqXG4PxzYZQJhiknVh/vILmb1LX+rSWs
         7DCw==
X-Gm-Message-State: AOAM533AyFsRpNk8nMnD+GqZWRLMrLk1WyG3Wi+hhy7xDBk+M1DcIH7L
        1HkhQz/oM0SPoxiGXuC+LXEIIpJqNzaoiKU1if4UO2Ikglsj3uAHAU5hUP/4SQMSMV2tGyZjehg
        glaAjLWCuR+95OVWdQpTsx/xh4kWmo0tNB3bo2Rnv4Q==
X-Received: by 2002:a17:906:e244:b0:6cd:24e3:ab8b with SMTP id gq4-20020a170906e24400b006cd24e3ab8bmr856430ejb.633.1645643640107;
        Wed, 23 Feb 2022 11:14:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyXgfLS9GHyX1kCvT/o1Mu24QLFIsYnwLPgsBOYcxKH/GiFu7jQtQB6sjAsK4TU39w3xnST4g==
X-Received: by 2002:a17:906:e244:b0:6cd:24e3:ab8b with SMTP id gq4-20020a170906e24400b006cd24e3ab8bmr856416ejb.633.1645643639914;
        Wed, 23 Feb 2022 11:13:59 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id q5sm212611ejc.115.2022.02.23.11.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 11:13:58 -0800 (PST)
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
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH v2 05/11] pci: use helper for safer setting of driver_override
Date:   Wed, 23 Feb 2022 20:13:04 +0100
Message-Id: <20220223191310.347669-6-krzysztof.kozlowski@canonical.com>
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

Use a helper for seting driver_override to reduce amount of duplicated
code.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/pci/pci-sysfs.c | 24 ++++--------------------
 1 file changed, 4 insertions(+), 20 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 602f0fb0b007..16a163d4623e 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -567,31 +567,15 @@ static ssize_t driver_override_store(struct device *dev,
 				     const char *buf, size_t count)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
-	char *driver_override, *old, *cp;
+	int ret;
 
 	/* We need to keep extra room for a newline */
 	if (count >= (PAGE_SIZE - 1))
 		return -EINVAL;
 
-	driver_override = kstrndup(buf, count, GFP_KERNEL);
-	if (!driver_override)
-		return -ENOMEM;
-
-	cp = strchr(driver_override, '\n');
-	if (cp)
-		*cp = '\0';
-
-	device_lock(dev);
-	old = pdev->driver_override;
-	if (strlen(driver_override)) {
-		pdev->driver_override = driver_override;
-	} else {
-		kfree(driver_override);
-		pdev->driver_override = NULL;
-	}
-	device_unlock(dev);
-
-	kfree(old);
+	ret = driver_set_override(dev, &pdev->driver_override, buf);
+	if (ret)
+		return ret;
 
 	return count;
 }
-- 
2.32.0

