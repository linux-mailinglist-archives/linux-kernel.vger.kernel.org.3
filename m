Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3814BF952
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 14:29:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232489AbiBVN3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 08:29:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232446AbiBVN3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 08:29:12 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6852498596
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 05:28:46 -0800 (PST)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 44AFE3FCAF
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 13:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645536525;
        bh=4gAKTfhEbiOa5VKlvnZrWEbzuOeUPflEFSiM68fpB+I=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=dkYI8QB+a7ihANAbPp67FEFYSsTNU7f+rC+C/bV0S9rQ4WP5qUoFjkZa4gza16jvU
         cP0TSqxFDRjILd5ggExIYtRMR3Ql0+8HEwbIZ1ywFXs60RFnOJS02ZM4sR0QIKFWCs
         eaxREbZn9gis9Y/dy/BS2YQm1WOfa1Rvt0mtlUp2xc9gumju1UCnYQjVEXdLhaUrps
         d8RljRvvp068RxFSPE9gnoRvc00sjabOYqf+qhRBnYi2XoXnArV/RptJSxvv5UwyUF
         98BKEIIjI7tXBjKm1z25FqwmTkXCkWP+v7YQUB1TAS+4ikgvkrc3se3clYy4iPeTbU
         3RscVdDMUeM2g==
Received: by mail-ed1-f70.google.com with SMTP id dy17-20020a05640231f100b00412897682b4so10184204edb.18
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 05:28:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4gAKTfhEbiOa5VKlvnZrWEbzuOeUPflEFSiM68fpB+I=;
        b=Cf36abxf5bEDzwlqmmICNe3Qc8w2SrQG55VKhqPcXZmPVueWsvtfzgJVEg1e4OFxEA
         deK6Z/X/mILkaN85QFxYRh7wTUBPBkTO/jUoLLV6tA8V6dYphFl8+I8tydKOuVMbChA4
         jpKzeDhzU/WiP7yBiu5B5TmI62mnLc7AL+iAaYaETyxnCblMeh6P9FKFRh9S8Scm92OT
         TxfUoWh/0vejTBiD8C6lT5p6f0sv482vAgT/x7uvIhIU7RH/KmK2uMQ/OgTdlHZnkgFO
         X2mG6kzBlHdm6hTMG9dIZIZ10Fk41fYW95bn1UsO42DmfhPQhQPY3hUN1+TDIdGiNRd9
         DtOA==
X-Gm-Message-State: AOAM533BU73zt05Nkk/BMV3eBS6tmKKflkrfnweLlNLfdIEP8UbbI9N+
        3HnICP9CQ/lTz0Yh86qQ6XLWsOQsqAmiKA436OuZNm8vGhuvNqv0M2pYRDSr9bYIHlvosx7XXtb
        6YvoInSVXk6wFKLU8IBF9xl0HMQlPmYomHiO83W3vEQ==
X-Received: by 2002:a05:6402:50d2:b0:413:1cd8:e08e with SMTP id h18-20020a05640250d200b004131cd8e08emr4730737edb.276.1645536524858;
        Tue, 22 Feb 2022 05:28:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyk7fFQMdh++yZYYeqYdt0QvvL2iwrOb2soDeyOFOcCMFVM9JS2wL10Ee7DBznFmZmRSj/ibA==
X-Received: by 2002:a05:6402:50d2:b0:413:1cd8:e08e with SMTP id h18-20020a05640250d200b004131cd8e08emr4730720edb.276.1645536524647;
        Tue, 22 Feb 2022 05:28:44 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id c5sm10029875edk.43.2022.02.22.05.28.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 05:28:44 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Abel Vesa <abel.vesa@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        stable@vger.kernel.org
Subject: [RFT PATCH 3/3] rpmsg: fix kfree() of const memory on setting driver_override
Date:   Tue, 22 Feb 2022 14:27:07 +0100
Message-Id: <20220222132707.266883-4-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220222132707.266883-1-krzysztof.kozlowski@canonical.com>
References: <20220222132707.266883-1-krzysztof.kozlowski@canonical.com>
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

The driver_override field from rpmsg_device should not be initialized
from const memory because the core later kfree() it, for example when
driver_override is set via sysfs.

Fixes: 950a7388f02b ("rpmsg: Turn name service into a stand alone driver")
Fixes: c0cdc19f84a4 ("rpmsg: Driver for user space endpoint interface")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/rpmsg/rpmsg_internal.h | 12 ++++++++++--
 drivers/rpmsg/rpmsg_ns.c       | 13 +++++++++++--
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/rpmsg/rpmsg_internal.h b/drivers/rpmsg/rpmsg_internal.h
index b1245d3ed7c6..c21e73ffbf05 100644
--- a/drivers/rpmsg/rpmsg_internal.h
+++ b/drivers/rpmsg/rpmsg_internal.h
@@ -92,10 +92,18 @@ int rpmsg_release_channel(struct rpmsg_device *rpdev,
  */
 static inline int rpmsg_chrdev_register_device(struct rpmsg_device *rpdev)
 {
+	int ret;
+
 	strcpy(rpdev->id.name, "rpmsg_chrdev");
-	rpdev->driver_override = "rpmsg_chrdev";
+	rpdev->driver_override = kstrdup("rpmsg_chrdev", GFP_KERNEL);
+	if (!rpdev->driver_override)
+		return -ENOMEM;
+
+	ret = rpmsg_register_device(rpdev);
+	if (ret)
+		kfree(rpdev->driver_override);
 
-	return rpmsg_register_device(rpdev);
+	return ret;
 }
 
 #endif
diff --git a/drivers/rpmsg/rpmsg_ns.c b/drivers/rpmsg/rpmsg_ns.c
index 762ff1ae279f..7d0605307d23 100644
--- a/drivers/rpmsg/rpmsg_ns.c
+++ b/drivers/rpmsg/rpmsg_ns.c
@@ -20,12 +20,21 @@
  */
 int rpmsg_ns_register_device(struct rpmsg_device *rpdev)
 {
+	int ret;
+
 	strcpy(rpdev->id.name, "rpmsg_ns");
-	rpdev->driver_override = "rpmsg_ns";
+	rpdev->driver_override = kstrdup("rpmsg_ns", GFP_KERNEL);
+	if (!rpdev->driver_override)
+		return -ENOMEM;
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

