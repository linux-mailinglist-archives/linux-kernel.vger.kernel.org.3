Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35B50497D06
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 11:26:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237041AbiAXK0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 05:26:04 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:53476 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232375AbiAXK0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 05:26:03 -0500
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20O6jNgC004848;
        Mon, 24 Jan 2022 11:25:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=m2pE2NjuAQdxDmxVVEBqH4NGL47GpfjItWxKc/nx7t0=;
 b=I6Wbu1Wx4+NzOH+pvadjWCyDXtmarUBUHopawoDE7Xz1nDODXWb72VWSgZnH4mkGWZs7
 Ad9Q+8zCku2NDRAnTFmLSo38Bs7+E7SsdXasPTP7j9bB7/ombPyC8X07U4zDkADbPUNB
 eGLkSV7ATQ4KQsuKYECYGxz31GXe2eMEIAdzq0/l1DLoXwcCWGHIkamJd55cYYgy/WLl
 PAxDkwk1N8OE4elNbFyecbWcvmicRzbpQmwF2leS05XUtO/D/KpCw7iVlSHHv557/d/r
 1CpkO7uyVd3ymhmU+FJA9lIQSVqK+ozy/28KrAKcWZD4GsCd5bd5v6OKlhhnuSfUobhe Gg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ds9v1kcjc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Jan 2022 11:25:53 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 33FF9100038;
        Mon, 24 Jan 2022 11:25:53 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2DFF82128B5;
        Mon, 24 Jan 2022 11:25:53 +0100 (CET)
Received: from localhost (10.75.127.44) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Mon, 24 Jan 2022 11:25:52
 +0100
From:   Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <julien.massot@iot.bzh>, <arnaud.pouliquen@foss.st.com>
Subject: [PATCH v9 02/11] rpmsg: Create the rpmsg class in core instead of in rpmsg char
Date:   Mon, 24 Jan 2022 11:25:15 +0100
Message-ID: <20220124102524.295783-3-arnaud.pouliquen@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220124102524.295783-1-arnaud.pouliquen@foss.st.com>
References: <20220124102524.295783-1-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-24_06,2022-01-24_01,2021-12-02_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Migrate the creation of the rpmsg class from the rpmsg_char
to the core that the class is usable by the rpmsg_char and
the future rpmsg_ctrl module.

Suggested-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/rpmsg/rpmsg_char.c     | 11 +----------
 drivers/rpmsg/rpmsg_core.c     | 15 +++++++++++++--
 drivers/rpmsg/rpmsg_internal.h |  2 ++
 3 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/rpmsg/rpmsg_char.c b/drivers/rpmsg/rpmsg_char.c
index 3708233cf736..fd56e7967ee3 100644
--- a/drivers/rpmsg/rpmsg_char.c
+++ b/drivers/rpmsg/rpmsg_char.c
@@ -27,11 +27,11 @@
 #include <uapi/linux/rpmsg.h>
 
 #include "rpmsg_char.h"
+#include "rpmsg_internal.h"
 
 #define RPMSG_DEV_MAX	(MINORMASK + 1)
 
 static dev_t rpmsg_major;
-static struct class *rpmsg_class;
 
 static DEFINE_IDA(rpmsg_ctrl_ida);
 static DEFINE_IDA(rpmsg_ept_ida);
@@ -547,17 +547,9 @@ static int rpmsg_chrdev_init(void)
 		return ret;
 	}
 
-	rpmsg_class = class_create(THIS_MODULE, "rpmsg");
-	if (IS_ERR(rpmsg_class)) {
-		pr_err("failed to create rpmsg class\n");
-		unregister_chrdev_region(rpmsg_major, RPMSG_DEV_MAX);
-		return PTR_ERR(rpmsg_class);
-	}
-
 	ret = register_rpmsg_driver(&rpmsg_chrdev_driver);
 	if (ret < 0) {
 		pr_err("failed to register rpmsg driver\n");
-		class_destroy(rpmsg_class);
 		unregister_chrdev_region(rpmsg_major, RPMSG_DEV_MAX);
 	}
 
@@ -568,7 +560,6 @@ postcore_initcall(rpmsg_chrdev_init);
 static void rpmsg_chrdev_exit(void)
 {
 	unregister_rpmsg_driver(&rpmsg_chrdev_driver);
-	class_destroy(rpmsg_class);
 	unregister_chrdev_region(rpmsg_major, RPMSG_DEV_MAX);
 }
 module_exit(rpmsg_chrdev_exit);
diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
index d9e612f4f0f2..79368a957d89 100644
--- a/drivers/rpmsg/rpmsg_core.c
+++ b/drivers/rpmsg/rpmsg_core.c
@@ -20,6 +20,9 @@
 
 #include "rpmsg_internal.h"
 
+struct class *rpmsg_class;
+EXPORT_SYMBOL(rpmsg_class);
+
 /**
  * rpmsg_create_channel() - create a new rpmsg channel
  * using its name and address info.
@@ -662,10 +665,17 @@ static int __init rpmsg_init(void)
 {
 	int ret;
 
+	rpmsg_class = class_create(THIS_MODULE, "rpmsg");
+	if (IS_ERR(rpmsg_class)) {
+		pr_err("failed to create rpmsg class\n");
+		return PTR_ERR(rpmsg_class);
+	}
+
 	ret = bus_register(&rpmsg_bus);
-	if (ret)
+	if (ret) {
 		pr_err("failed to register rpmsg bus: %d\n", ret);
-
+		class_destroy(rpmsg_class);
+	}
 	return ret;
 }
 postcore_initcall(rpmsg_init);
@@ -673,6 +683,7 @@ postcore_initcall(rpmsg_init);
 static void __exit rpmsg_fini(void)
 {
 	bus_unregister(&rpmsg_bus);
+	class_destroy(rpmsg_class);
 }
 module_exit(rpmsg_fini);
 
diff --git a/drivers/rpmsg/rpmsg_internal.h b/drivers/rpmsg/rpmsg_internal.h
index b1245d3ed7c6..416316200bde 100644
--- a/drivers/rpmsg/rpmsg_internal.h
+++ b/drivers/rpmsg/rpmsg_internal.h
@@ -18,6 +18,8 @@
 #define to_rpmsg_device(d) container_of(d, struct rpmsg_device, dev)
 #define to_rpmsg_driver(d) container_of(d, struct rpmsg_driver, drv)
 
+extern struct class *rpmsg_class;
+
 /**
  * struct rpmsg_device_ops - indirection table for the rpmsg_device operations
  * @create_channel:	create backend-specific channel, optional
-- 
2.25.1

