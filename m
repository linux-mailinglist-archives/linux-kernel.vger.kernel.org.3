Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A01BA506B07
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 13:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351460AbiDSLii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 07:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351406AbiDSLhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 07:37:38 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80E29B7F9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 04:34:55 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id lc2so32211669ejb.12
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 04:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Keg7xeXtq8amo+bPOPiY0urtb62UU+nYY2PydP0Pktc=;
        b=DTuv34MQ33JHfqETATQCEFdNozHmI35rAUQVc6olY52FJAiDXlsoudP958Slrb5wG1
         DSPsGtDvlTAOkorBlo5mTDEsuc4ydyQ5Yf8AxUenxXPtL5w79pnDU8388VAXjO9mEVD+
         vEeppQOWxBuT/F1c/tirPFrwshVkv0IzHeXlVS3TRoe5HUqVwgpCDZbGYEjlScL0+6Vr
         hyS9XdBBr+bjvGu2LzcODR5O9YGPdmzXSE/BE4YQKhkbj4iyXXTmW7nwSDUIvjxekh2b
         pFhW9CQNJbOpAdevGaap0fwJd6ED38/k91U2fka9puKnEErIFBBucAn4aACWqEK20wY+
         fNow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Keg7xeXtq8amo+bPOPiY0urtb62UU+nYY2PydP0Pktc=;
        b=FimCwi9d1vMnk0jFLAhGxh5ceal+2pyTVTQUF1unSFSjdoY9NuWGHruDhppD46WJJ6
         i0wXd0qfQzvkTgzJEjrZSYDaHDv1TQWsPrZlEkXKw0PEjzdvGIYMyv8ZLBsyY4kW66ou
         /UQKC8/Vu5KOpQpdRIhO2jUFcaHFO+i+/1n7hqh4iI+59yPRE/co48WR+u5uHpWVFEwV
         x9/dQgeV6/R1CoHIe4Rb8Djc9lgfojiDRF/ThOaOfWKtSh6X1aT2/o3lHGAJdHHq3wZ0
         o6m6T9/l3AQ4bqtwd4TVRCoEsT0oTR39se0/031TX+3EF83Xqn/iQ9V2WcTGDF3GzaWV
         Syxg==
X-Gm-Message-State: AOAM533DeaHC4wk8wy5+WQpHwdF6WyHhYL75FZj4S16hg4WbS7ZCzcs0
        ljiONEJdS8cKNKilKjMwgg+TfA==
X-Google-Smtp-Source: ABdhPJyVt0cgXUYUeGSEzHKPEQtYs3Qh+dbqLbNajfqREgpBOjCU9zh7evNxJ42COX+bjxL2ovpv7Q==
X-Received: by 2002:a17:906:d552:b0:6ef:c5a2:7e01 with SMTP id cr18-20020a170906d55200b006efc5a27e01mr5528474ejc.568.1650368093944;
        Tue, 19 Apr 2022 04:34:53 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id ce21-20020a170906b25500b006e89869cbf9sm5608802ejb.105.2022.04.19.04.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 04:34:53 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Stuart Yoder <stuyoder@gmail.com>,
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
        Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-spi@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Michael Kelley <mikelley@microsoft.com>
Subject: [PATCH v7 04/12] hv: Use driver_set_override() instead of open-coding
Date:   Tue, 19 Apr 2022 13:34:27 +0200
Message-Id: <20220419113435.246203-5-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220419113435.246203-1-krzysztof.kozlowski@linaro.org>
References: <20220419113435.246203-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use a helper to set driver_override to the reduce amount of duplicated
code.  Make the driver_override field const char, because it is not
modified by the core and it matches other subsystems.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
---
 drivers/hv/vmbus_drv.c | 28 ++++------------------------
 include/linux/hyperv.h |  6 +++++-
 2 files changed, 9 insertions(+), 25 deletions(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 14de17087864..607e40aba18e 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -575,31 +575,11 @@ static ssize_t driver_override_store(struct device *dev,
 				     const char *buf, size_t count)
 {
 	struct hv_device *hv_dev = device_to_hv_device(dev);
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
-	old = hv_dev->driver_override;
-	if (strlen(driver_override)) {
-		hv_dev->driver_override = driver_override;
-	} else {
-		kfree(driver_override);
-		hv_dev->driver_override = NULL;
-	}
-	device_unlock(dev);
+	int ret;
 
-	kfree(old);
+	ret = driver_set_override(dev, &hv_dev->driver_override, buf, count);
+	if (ret)
+		return ret;
 
 	return count;
 }
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index fe2e0179ed51..12e2336b23b7 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -1257,7 +1257,11 @@ struct hv_device {
 	u16 device_id;
 
 	struct device device;
-	char *driver_override; /* Driver name to force a match */
+	/*
+	 * Driver name to force a match.  Do not set directly, because core
+	 * frees it.  Use driver_set_override() to set or clear it.
+	 */
+	const char *driver_override;
 
 	struct vmbus_channel *channel;
 	struct kset	     *channels_kset;
-- 
2.32.0

