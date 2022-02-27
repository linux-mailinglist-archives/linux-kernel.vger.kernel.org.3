Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBCB14C5BCB
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 14:54:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbiB0Nya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 08:54:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231328AbiB0NyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 08:54:25 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE98C13EB7
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 05:53:48 -0800 (PST)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 7A66540017
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 13:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645970026;
        bh=qpFiz05rVbRuRAHN9hg8SmLpkD4Xh7SLbxYijfSgBwA=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=gb15HBHgoa4/ayNDCdpdmkOHg8MUudIN5aCRt8kMUNQuhCGe0tXAgYg2BZ4Wgdm4M
         qBUCRTaxMvAfdfPwR6t21rNP810akTda5OJl3rrG66W94L60NkwzgdrO6LGHixEoC0
         mtL8XKljlgqmn9PDfs1pNLGg+G/hU/hx7RIGz76qfGuSLMDgc+Fiuq2YGOWcsz2Dtw
         ya2MFy+fIGgozBO4Q0HH8HHasTR4LIhfR22633fEJ9H+OXUrdtw93RQUvyRwzNHkJa
         i643G2PdQvtrnsoKvkikJGsKnEQEJEQhO49xmg958/SU430tuDIDLcYxFaV/y7CnAl
         LVOJyjKpyymvA==
Received: by mail-ed1-f69.google.com with SMTP id l3-20020a50cbc3000000b0041083c11173so4254569edi.4
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 05:53:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qpFiz05rVbRuRAHN9hg8SmLpkD4Xh7SLbxYijfSgBwA=;
        b=DwMEhW9rtKYIelCXMZHlJXq7kwiUHWUk1lwS1D7CQZvIzQRqlldlM7YcEcgx7oss4X
         nm59FjWMm6inO0q6RsNWNuaz4jKEAV8UPMPxBErn4KDDEry7drJD4iJ1rZEvDn2tlgaA
         O393lgfCPw8S3Vm+0vTVRzhIJrpb1qDWTppFfXdqNSHWAlpy1NCAzAjTJzH6Ap1TXFCL
         JLCT+8pEBsqkVNUTiWC3Y+Y464ftvteTrTjWX/f8HBbH8M9l8Nf183q170Tmq59xsiFt
         eFQC3AV03M/AwW6hj8Pl7KHLJ0JcOVhPEMAtoXb6BVYsogOCTt6AJAs0zYTO/chW9bzN
         Bjiw==
X-Gm-Message-State: AOAM530A8r7rfT7hHJ982R0ZdfqVQeaSRvugoSjiLcXBd9kGtCHYpRVT
        M4VpMBfAKo2DMCJKOKuVB4V7XQQN+Ul3kRxFwVLFAGnx7quuUvuJYr1n1VsHSaAjj0aTuVF68L/
        VMgspcEsumLKsRwWVarDJg5w2O5iHicg3mRhlZjzusA==
X-Received: by 2002:aa7:d98a:0:b0:410:b844:7889 with SMTP id u10-20020aa7d98a000000b00410b8447889mr15100900eds.109.1645970015740;
        Sun, 27 Feb 2022 05:53:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyhO9Sv0dF420J0f9IZ/pCEaONwOixtXPt4DqHWIJWIfdwGeQCrhRg50N3SHeq1oP4tMC2tSg==
X-Received: by 2002:aa7:d98a:0:b0:410:b844:7889 with SMTP id u10-20020aa7d98a000000b00410b8447889mr15100871eds.109.1645970015533;
        Sun, 27 Feb 2022 05:53:35 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id w11-20020a056402128b00b00412ec3f5f74sm4600760edv.62.2022.02.27.05.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Feb 2022 05:53:34 -0800 (PST)
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
Subject: [PATCH v3 07/11] spi: Use helper for safer setting of driver_override
Date:   Sun, 27 Feb 2022 14:53:25 +0100
Message-Id: <20220227135329.145862-1-krzysztof.kozlowski@canonical.com>
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
code.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/spi/spi.c       | 26 ++++----------------------
 include/linux/spi/spi.h |  2 ++
 2 files changed, 6 insertions(+), 22 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 4599b121d744..9d0b11017741 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -72,29 +72,11 @@ static ssize_t driver_override_store(struct device *dev,
 				     const char *buf, size_t count)
 {
 	struct spi_device *spi = to_spi_device(dev);
-	const char *end = memchr(buf, '\n', count);
-	const size_t len = end ? end - buf : count;
-	const char *driver_override, *old;
-
-	/* We need to keep extra room for a newline when displaying value */
-	if (len >= (PAGE_SIZE - 1))
-		return -EINVAL;
-
-	driver_override = kstrndup(buf, len, GFP_KERNEL);
-	if (!driver_override)
-		return -ENOMEM;
+	int ret;
 
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
+	ret = driver_set_override(dev, &spi->driver_override, buf, count);
+	if (ret)
+		return ret;
 
 	return count;
 }
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 7ab3fed7b804..f99bbb20dd4b 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -136,6 +136,8 @@ extern int spi_delay_exec(struct spi_delay *_delay, struct spi_transfer *xfer);
  *	for driver coldplugging, and in uevents used for hotplugging
  * @driver_override: If the name of a driver is written to this attribute, then
  *	the device will bind to the named driver and only the named driver.
+ *	Do not set directly, because core frees it; use driver_set_override() to
+ *	set or clear it.
  * @cs_gpio: LEGACY: gpio number of the chipselect line (optional, -ENOENT when
  *	not using a GPIO line) use cs_gpiod in new drivers by opting in on
  *	the spi_master.
-- 
2.32.0

