Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA594C1BBC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 20:14:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244301AbiBWTPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 14:15:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244227AbiBWTO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 14:14:57 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CADD403C2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 11:14:29 -0800 (PST)
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 5ACE240312
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 19:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645643665;
        bh=6kmYalWKPfFv5VRw+oGSxmK6RPimpkHdVtl6uKB49Rw=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=lypfQ5EHzpPmMptBnb1UN2iDFehpADD2VaDxcZwFK3pUxK58kF5AOQV48s64IfLTr
         Vqhh3CRJ+x2XxCGdvUTryHx68LR1CYFIl7nFH7uLw4C5/JplFp6fPsVYqSOZy9yk1I
         WEDg5qj5nxzd/uUGk0dXdLCbFc8azwjZc6ZtJKqAg9h8sKbIekQyfcRMElOwwp5X78
         96Bf7WiFsP0OHi+sWOgnbgqljfBGuUt3Y5ZDjOjpnis9IgvSt0Igr6Ni2Z+HksoQQ4
         f+PVM6Dn2KeDR2gp8YLzRhS/gGzj9bgI3cJr0VUtTt7XSytE/5aQwDRvw6tNjFRmL8
         +G1t7eZX4F5KQ==
Received: by mail-wr1-f72.google.com with SMTP id p9-20020adf9589000000b001e333885ac1so10604299wrp.10
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 11:14:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6kmYalWKPfFv5VRw+oGSxmK6RPimpkHdVtl6uKB49Rw=;
        b=Z1zoE3NITSVWyJU58wB9ACxgvIetq1vTaOg95ZiKnpkVRtTERQt0dwb4ZyZULXQ5JY
         kAmeYR0iqOX4cj1tB0O857VkkzvuRGsRjvDBbnpjufIVNec2ezJx0sV/vy+VKQJlA9Op
         8Ssx27gUCGkFnbvAPWE3WvI5vdl7jA7kWM0ulilUwOW/NqSGWX/m0pmr4Hnbl9phJMIe
         0GbbxXJBwk/G0x8pyM9dVQHnsFwAmUwN1CGgRBZS1GT9IXvOjNh29Na1qi4j0fB79M7t
         RIxcDBOwak/v8NRmavAHTCSGu4jB7z/OA4mZxmISbN05VQXoz20jHWwrhcxOcoU/0c7p
         fk3Q==
X-Gm-Message-State: AOAM5327UG5HjFFg7V8put9W7NqkwBzueUjSPxvIid4XQK7OhAnqiVXm
        8qHRevwX/2ijEXAQf0JzBRsy3Z4Wykzh8DJP2YS2+wTx9hdaVicbYSxb1CIFxZyfQm/znNq9VlN
        6fB1oO40JSOnCbX6sba08lIIz2MXcYPHUAxIkpUQnHA==
X-Received: by 2002:a17:906:8517:b0:6d0:1de8:cb6e with SMTP id i23-20020a170906851700b006d01de8cb6emr879393ejx.686.1645643637572;
        Wed, 23 Feb 2022 11:13:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxB+J8rGAXqipxoP9wQ6myB7nB+zWmd6qpvw2I7Sb7Voa93sYSAIKWPaoRnjyaDxxppMxF7NQ==
X-Received: by 2002:a17:906:8517:b0:6d0:1de8:cb6e with SMTP id i23-20020a170906851700b006d01de8cb6emr879348ejx.686.1645643637394;
        Wed, 23 Feb 2022 11:13:57 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id q5sm212611ejc.115.2022.02.23.11.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 11:13:56 -0800 (PST)
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
Subject: [PATCH v2 04/11] hv: vmbus: use helper for safer setting of driver_override
Date:   Wed, 23 Feb 2022 20:13:03 +0100
Message-Id: <20220223191310.347669-5-krzysztof.kozlowski@canonical.com>
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
 drivers/hv/vmbus_drv.c | 24 ++++--------------------
 1 file changed, 4 insertions(+), 20 deletions(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 12a2b37e87f3..f2435cc8b680 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -575,31 +575,15 @@ static ssize_t driver_override_store(struct device *dev,
 				     const char *buf, size_t count)
 {
 	struct hv_device *hv_dev = device_to_hv_device(dev);
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
-	old = hv_dev->driver_override;
-	if (strlen(driver_override)) {
-		hv_dev->driver_override = driver_override;
-	} else {
-		kfree(driver_override);
-		hv_dev->driver_override = NULL;
-	}
-	device_unlock(dev);
-
-	kfree(old);
+	ret = driver_set_override(dev, &hv_dev->driver_override, buf);
+	if (ret)
+		return ret;
 
 	return count;
 }
-- 
2.32.0

