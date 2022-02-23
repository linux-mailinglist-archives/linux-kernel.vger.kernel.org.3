Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67DA54C1BF0
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 20:16:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244300AbiBWTQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 14:16:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244305AbiBWTQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 14:16:18 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21E0F40E6A
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 11:15:50 -0800 (PST)
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id AFF223F1D0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 19:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645643739;
        bh=7IYTHmQXzsIW766tCpVJPfNTfO+AmvxjDRcTslL8YGA=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=J8x2EjljgeeQCSRe+JhdeC2s8js7YbAQAnJjBQ4rm3jfFhkRX0jyCgfXYG9cawMZo
         10CcRPVMClFkwDorda1J3Ni4vObX4YNelb+NysVadbD/cVJ573veLbzT6iIJdyWwbl
         u7oWSggEFrtIRKovYG8ywiWw8IFBnfrWZ+uiaIfsEHGiRjmr9AtOy3QIf2/FgBWdHl
         FgI5Llo4hetfyxRD/VL+9vrVlCgdYJJ+OYArvp1g9i8AfMqXgNVJE6LW6EAXf7vgjv
         T3zC4N6dv32Xacu58JdUJUxQegkbmD2m+R0cS62IZgOSibz7sqKU1fDZNmKrprYkzl
         p/Apto6MMepqg==
Received: by mail-ed1-f72.google.com with SMTP id r11-20020a508d8b000000b00410a4fa4768so13937431edh.9
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 11:15:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7IYTHmQXzsIW766tCpVJPfNTfO+AmvxjDRcTslL8YGA=;
        b=AxT3Kbb/JPERByzBekToKg+ac8AOPIe5jrv062XHOgIc5tEbZ00WdvQjbbpvQcCF4D
         WZGJ5xwfLZHtHRw3dBGJ1Bz26O1H/BO8ybsfBie6/LvCD6VyNbhg6oFV8IIAyn1GN25X
         pTa991Cjzx+Wf5NSlkLuoQ7Vzr/tyrF+GBff++yK1WAkjfR2CaGp9qoPiFJPhMqMIFKx
         +WJNAhGfD8ljMRzR039fyX7KCSwjoSpg69ZJEUnicqosNf7gGYLy09O5RrmV20kz+zzV
         xviVZK9BKgct/6XIIbp7669H9vb6bmT55qYnaxwRbv7wIm5dZLbDpA4v3sZEMWUN1kw5
         Tu1w==
X-Gm-Message-State: AOAM532C2hurOtzG+H/Jx07BM59M6ZYELUAINlUqUftu2/mVWtUn/fB/
        9km8fOOKqq0V8g6OD2xkb00QqifZWC+ApVqyhxp0cwc4Gb2kIoLeVXsqb+XL0qpy2rPGjUf2Ovo
        9ZWcVrR1luZtrJqCEFT0dCE/NQ7+MAs1HVIHVA8e5Vg==
X-Received: by 2002:a17:906:b57:b0:6ce:e31a:524 with SMTP id v23-20020a1709060b5700b006cee31a0524mr898065ejg.290.1645643723446;
        Wed, 23 Feb 2022 11:15:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwXaymv6Y03sx5emAtiihVKDslUlZDj5+bUOqZTX2T0tvcmba61MgF/pNNazmHUobDDFmGa2g==
X-Received: by 2002:a17:906:b57:b0:6ce:e31a:524 with SMTP id v23-20020a1709060b5700b006cee31a0524mr898038ejg.290.1645643723190;
        Wed, 23 Feb 2022 11:15:23 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id b3sm208368ejl.67.2022.02.23.11.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 11:15:22 -0800 (PST)
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
Subject: [PATCH v2 07/11] spi: use helper for safer setting of driver_override
Date:   Wed, 23 Feb 2022 20:14:37 +0100
Message-Id: <20220223191441.348109-1-krzysztof.kozlowski@canonical.com>
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

Remove also "const" from the definition of spi_device.driver_override,
because it is not correct.  The SPI driver already treats it as
dynamic, not const, memory.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/spi/spi.c       | 20 ++++----------------
 include/linux/spi/spi.h |  2 +-
 2 files changed, 5 insertions(+), 17 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 4599b121d744..0c7e2c34f4a3 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -74,27 +74,15 @@ static ssize_t driver_override_store(struct device *dev,
 	struct spi_device *spi = to_spi_device(dev);
 	const char *end = memchr(buf, '\n', count);
 	const size_t len = end ? end - buf : count;
-	const char *driver_override, *old;
+	int ret;
 
 	/* We need to keep extra room for a newline when displaying value */
 	if (len >= (PAGE_SIZE - 1))
 		return -EINVAL;
 
-	driver_override = kstrndup(buf, len, GFP_KERNEL);
-	if (!driver_override)
-		return -ENOMEM;
-
-	device_lock(dev);
-	old = spi->driver_override;
-	if (len) {
-		spi->driver_override = driver_override;
-	} else {
-		/* Empty string, disable driver override */
-		spi->driver_override = NULL;
-		kfree(driver_override);
-	}
-	device_unlock(dev);
-	kfree(old);
+	ret = driver_set_override(dev, &spi->driver_override, buf);
+	if (ret)
+		return ret;
 
 	return count;
 }
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 7ab3fed7b804..01224d07aaff 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -184,7 +184,7 @@ struct spi_device {
 	void			*controller_state;
 	void			*controller_data;
 	char			modalias[SPI_NAME_SIZE];
-	const char		*driver_override;
+	char			*driver_override;
 	int			cs_gpio;	/* LEGACY: chip select gpio */
 	struct gpio_desc	*cs_gpiod;	/* chip select gpio desc */
 	struct spi_delay	word_delay; /* inter-word delay */
-- 
2.32.0

