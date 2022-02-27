Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF174C5BA2
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 14:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231350AbiB0Nxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 08:53:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231374AbiB0Nxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 08:53:39 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A9B313EBF
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 05:52:58 -0800 (PST)
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id A06DB3FCA4
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 13:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645969976;
        bh=kn+qF0tdCo1etTHWEFOqoxtrhJ+rC4czu2ZZy5+SihI=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=g/n18JaeGinQORgtY4QcJ7kbbEjJy11fkB2WKTLa4LCYT5O9lgnD/mEK6pUfczZhX
         N3WJaQ3tCLgOMKGl+2rwA+LyWJh+3Aj4XoJ2v61bnSzhVSQQiuxmbCUGz149qH7moH
         8PbB1Cz8jXgPDKXESb2szR3pC497Ojy6zHdNgMgXii6yM/wUJTuyAjFmvaO0sOMBwg
         BWcz6pLXfg8BgZ/Dgrumz91dlekNljjeEQ1TE1RT0CSWOgNPLUs0+xMC3w2sTnlYu3
         d1mEESwt5CymrNuB2Q/knreChKGNY0B5uZmtodCVQlAVL4qcnNWwLtFxIPrbCZDrRy
         hVvZIKA88kfNA==
Received: by mail-wm1-f72.google.com with SMTP id 187-20020a1c19c4000000b0037cc0d56524so4918167wmz.2
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 05:52:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kn+qF0tdCo1etTHWEFOqoxtrhJ+rC4czu2ZZy5+SihI=;
        b=Iz3p8E4sfpKYntqF8drEZ5xkUQeDb4k6sXvygR5cndX6gbmsvCNtQuzw1raaFWylUF
         82YW+Ji0gNtDde5Qfoxi7iPGSPZNrWD/Dq16lzesPRkDvefoavsJJm7HoFiGyYm3/AYI
         UfTFE59Lx+ezOPrZdZ6ViRt/7X20RXuTrsykMYXuTNikkaGp9TBUOw1d6V2FR9aSDPfy
         sbqoB/2yBHy7PsnGcfe3FNLfwDbfSkg2HkJbjCz5QEEFUFf2mcsaJU7NKq07fejm7Y6w
         pCS4elBJLQDizmCPkkyto5lRRk2sml2fgkMKLla8GbsSmWFGsSA+aLBfa0lbY2BL6Ith
         OMvA==
X-Gm-Message-State: AOAM531DvCdHJvaz1KPaQZM0drZWOeOmM2UVtNr2Yz9Hsfr7x04sLn0J
        eGgBbKYwdofi7tUkAW1t/XBRkW59TGp4C1Ikv2Bfvn/MM++GJv/Nup2BbQpNFOVdfOeTfcmtv4X
        Da4UYjA3WUTLvjWQlb+2VKBHRlR1dd7xHBkU1RMnWDQ==
X-Received: by 2002:aa7:c4da:0:b0:410:bb1d:8232 with SMTP id p26-20020aa7c4da000000b00410bb1d8232mr15075950edr.333.1645969961202;
        Sun, 27 Feb 2022 05:52:41 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyhg/i5aHofZaz+ahzc6dFTcb8xbpOjhh0OtL6Jhkm85pFdhXbdMsjLVRzYgEWWn1QmpSdqKg==
X-Received: by 2002:aa7:c4da:0:b0:410:bb1d:8232 with SMTP id p26-20020aa7c4da000000b00410bb1d8232mr15075900edr.333.1645969960978;
        Sun, 27 Feb 2022 05:52:40 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id r22-20020a17090638d600b006d584aaa9c9sm3393333ejd.133.2022.02.27.05.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Feb 2022 05:52:40 -0800 (PST)
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
Subject: [PATCH v3 06/11] s390: cio: Use driver_set_override() instead of open-coding
Date:   Sun, 27 Feb 2022 14:52:09 +0100
Message-Id: <20220227135214.145599-7-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220227135214.145599-1-krzysztof.kozlowski@canonical.com>
References: <20220227135214.145599-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use a helper for seting driver_override to reduce amount of duplicated
code. Make the driver_override field const char, because it is not
modified by the core and it matches other subsystems.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/s390/cio/cio.h |  7 ++++++-
 drivers/s390/cio/css.c | 28 ++++------------------------
 2 files changed, 10 insertions(+), 25 deletions(-)

diff --git a/drivers/s390/cio/cio.h b/drivers/s390/cio/cio.h
index 1cb9daf9c645..e110c10613e8 100644
--- a/drivers/s390/cio/cio.h
+++ b/drivers/s390/cio/cio.h
@@ -103,7 +103,12 @@ struct subchannel {
 	struct work_struct todo_work;
 	struct schib_config config;
 	u64 dma_mask;
-	char *driver_override; /* Driver name to force a match */
+	/*
+	 * Driver name to force a match.
+	 * Do not set directly, because core frees it.
+	 * Use driver_set_override() to set or clear it.
+	 */
+	const char *driver_override;
 } __attribute__ ((aligned(8)));
 
 DECLARE_PER_CPU_ALIGNED(struct irb, cio_irb);
diff --git a/drivers/s390/cio/css.c b/drivers/s390/cio/css.c
index fa8293335077..913b6ddd040b 100644
--- a/drivers/s390/cio/css.c
+++ b/drivers/s390/cio/css.c
@@ -338,31 +338,11 @@ static ssize_t driver_override_store(struct device *dev,
 				     const char *buf, size_t count)
 {
 	struct subchannel *sch = to_subchannel(dev);
-	char *driver_override, *old, *cp;
-
-	/* We need to keep extra room for a newline */
-	if (count >= (PAGE_SIZE - 1))
-		return -EINVAL;
-
-	driver_override = kstrndup(buf, count, GFP_KERNEL);
-	if (!driver_override)
-		return -ENOMEM;
-
-	cp = strchr(driver_override, '\n');
-	if (cp)
-		*cp = '\0';
-
-	device_lock(dev);
-	old = sch->driver_override;
-	if (strlen(driver_override)) {
-		sch->driver_override = driver_override;
-	} else {
-		kfree(driver_override);
-		sch->driver_override = NULL;
-	}
-	device_unlock(dev);
+	int ret;
 
-	kfree(old);
+	ret = driver_set_override(dev, &sch->driver_override, buf, count);
+	if (ret)
+		return ret;
 
 	return count;
 }
-- 
2.32.0

