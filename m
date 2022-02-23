Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C83744C1BD1
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 20:16:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244275AbiBWTQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 14:16:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244233AbiBWTQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 14:16:01 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0139A3FBC4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 11:15:33 -0800 (PST)
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 81400407D0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 19:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645643731;
        bh=7X8ZF+SfQI2ha/R62opt5Mpi3EJQ2IXnqtdf8o/szaw=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=p+mECjX6IJJhO4alngh2NKhaovPH5X4W3OO38kUkNxUT2vWTDpVENCjXuzvqScJpu
         yLQHVcD6sjcPv3KqrunR4kxgWZ3Ve7dGEP5gVkxjxPaPH6Tro6nn8KD5v2ARIQcvTY
         Cu7oVtd6c/KiWei+foQc8SkOXaRoeVvck9cNtORash0Cko4TS8potkk6VoPJeNO8Si
         R9TkWLWWM9ahvSw5JEHlOMnh3VfkE6R8M5CgGL+ioX7avSaHN1Jy6NVQHj/dgf078H
         ugxMsQOKMNID7n2qE4oODRPkDbd8JRsmyvxX+prGGx8hZwR3aRRkhI6JUJmxBrOqem
         anzZeFOh2w6HQ==
Received: by mail-ed1-f71.google.com with SMTP id h17-20020a05640250d100b004133863d836so1372676edb.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 11:15:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7X8ZF+SfQI2ha/R62opt5Mpi3EJQ2IXnqtdf8o/szaw=;
        b=23hr1rW8aWAcEr5WgFU23M/tpSLVp3Esm1hR5HzeW0JPL3ZyWSdpDevI6Yz8WRpC/o
         jo0IYbmxEw7g/tui6RgilbTXSeh4ZKtCZY7VeMOPukukhrBCTRwzpCP8DU2Q9rffGZO3
         SPaWS9D0drRRHe+xkCdwIBRKHgKNs9qHCfPxO7Yb9S5qLmJZ/LB5nDYg+NeiTCh09IwH
         MB+MfNcejAYsOJJLYc3yqhdgtrdi6cdb4NpZHOpjubn8u2IKeqzfPnD41JX1gHH+4hbJ
         4kMHnqLnWZk+hDmgd4RVpH4ldBN7mXBQozsT7E+US+yv/3RVNdddREkxXyvK7o+cuPiF
         o8WQ==
X-Gm-Message-State: AOAM533f/ZcIB+vobTagIOMAbUx4XzKIFI5Pj5f6loYoeNismQlKcCEn
        MVKkdnhvCnAWc5tuIrKNSkKyq6FuYkWnOE2VZYAajlfeC8Jh08BXB+MtHsMyQvGvmYh023dsFt3
        4wzOaFByDZYzPOcyHbU96zGzsCJliatLeadA9lXUiWA==
X-Received: by 2002:a17:906:130a:b0:6b7:5e48:350a with SMTP id w10-20020a170906130a00b006b75e48350amr887355ejb.184.1645643731006;
        Wed, 23 Feb 2022 11:15:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwzAUHN+IckyCUDaf6b+egXxiKcwH4G6el1z4Ve3vQHF0MnEv7U39pYdE62mAB1vpTAj/GhtQ==
X-Received: by 2002:a17:906:130a:b0:6b7:5e48:350a with SMTP id w10-20020a170906130a00b006b75e48350amr887325ejb.184.1645643730755;
        Wed, 23 Feb 2022 11:15:30 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id b3sm208368ejl.67.2022.02.23.11.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 11:15:30 -0800 (PST)
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
Subject: [PATCH v2 11/11] rpmsg: fix kfree() of static memory on setting driver_override
Date:   Wed, 23 Feb 2022 20:14:41 +0100
Message-Id: <20220223191441.348109-5-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220223191310.347669-1-krzysztof.kozlowski@canonical.com>
References: <20220223191310.347669-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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

Fixes: 950a7388f02b ("rpmsg: Turn name service into a stand alone driver")
Fixes: c0cdc19f84a4 ("rpmsg: Driver for user space endpoint interface")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/rpmsg/rpmsg_internal.h | 13 +++++++++++--
 drivers/rpmsg/rpmsg_ns.c       | 14 ++++++++++++--
 2 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/rpmsg/rpmsg_internal.h b/drivers/rpmsg/rpmsg_internal.h
index b1245d3ed7c6..c7bd0a3c802d 100644
--- a/drivers/rpmsg/rpmsg_internal.h
+++ b/drivers/rpmsg/rpmsg_internal.h
@@ -92,10 +92,19 @@ int rpmsg_release_channel(struct rpmsg_device *rpdev,
  */
 static inline int rpmsg_chrdev_register_device(struct rpmsg_device *rpdev)
 {
+	int ret;
+
 	strcpy(rpdev->id.name, "rpmsg_chrdev");
-	rpdev->driver_override = "rpmsg_chrdev";
+	ret = driver_set_override(&rpdev->dev, &rpdev->driver_override,
+				  "rpmsg_chrdev");
+	if (ret)
+		return ret;
+
+	ret = rpmsg_register_device(rpdev);
+	if (ret)
+		kfree(rpdev->driver_override);
 
-	return rpmsg_register_device(rpdev);
+	return ret;
 }
 
 #endif
diff --git a/drivers/rpmsg/rpmsg_ns.c b/drivers/rpmsg/rpmsg_ns.c
index 762ff1ae279f..1c9f9cf065b0 100644
--- a/drivers/rpmsg/rpmsg_ns.c
+++ b/drivers/rpmsg/rpmsg_ns.c
@@ -20,12 +20,22 @@
  */
 int rpmsg_ns_register_device(struct rpmsg_device *rpdev)
 {
+	int ret;
+
 	strcpy(rpdev->id.name, "rpmsg_ns");
-	rpdev->driver_override = "rpmsg_ns";
+	ret = driver_set_override(&rpdev->dev, &rpdev->driver_override,
+				  "rpmsg_ns");
+	if (ret)
+		return ret;
+
 	rpdev->src = RPMSG_NS_ADDR;
 	rpdev->dst = RPMSG_NS_ADDR;
 
-	return rpmsg_register_device(rpdev);
+	ret = rpmsg_register_device(rpdev);
+	if (ret)
+		kfree(rpdev->driver_override);
+
+	return ret;
 }
 EXPORT_SYMBOL(rpmsg_ns_register_device);
 
-- 
2.32.0

