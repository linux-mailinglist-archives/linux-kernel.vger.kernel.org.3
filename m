Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC80535BD7
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 10:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349926AbiE0Iqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 04:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349898AbiE0Iqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 04:46:36 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D09E12ACB;
        Fri, 27 May 2022 01:46:33 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4L8dfL4dGyz1JC7l;
        Fri, 27 May 2022 16:44:58 +0800 (CST)
Received: from dggpemm500018.china.huawei.com (7.185.36.111) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 27 May 2022 16:46:31 +0800
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm500018.china.huawei.com (7.185.36.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 27 May 2022 16:46:30 +0800
From:   keliu <liuke94@huawei.com>
To:     <peter.chen@kernel.org>, <gregkh@linuxfoundation.org>,
        <balbi@kernel.org>, <heikki.krogerus@linux.intel.com>,
        <mdevaev@gmail.com>, <maze@google.com>, <ruslan.bilovol@gmail.com>,
        <phil@raspberrypi.com>, <libaokun1@huawei.com>,
        <dan.carpenter@oracle.com>, <akpm@linux-foundation.org>,
        <brauner@kernel.org>, <songmuchun@bytedance.com>,
        <dh10.jung@samsung.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     keliu <liuke94@huawei.com>
Subject: [PATCH] drivers: usb: Directly use ida_alloc()/free()
Date:   Fri, 27 May 2022 09:08:00 +0000
Message-ID: <20220527090800.2881397-1-liuke94@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500018.china.huawei.com (7.185.36.111)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use ida_alloc()/ida_free() instead of deprecated
ida_simple_get()/ida_simple_remove() .

Signed-off-by: keliu <liuke94@huawei.com>
---
 drivers/usb/chipidea/core.c             | 6 +++---
 drivers/usb/gadget/function/f_hid.c     | 6 +++---
 drivers/usb/gadget/function/f_printer.c | 6 +++---
 drivers/usb/gadget/function/rndis.c     | 4 ++--
 drivers/usb/typec/class.c               | 8 ++++----
 5 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
index 5359b2a2e4d2..ab8fd4d96836 100644
--- a/drivers/usb/chipidea/core.c
+++ b/drivers/usb/chipidea/core.c
@@ -853,7 +853,7 @@ struct platform_device *ci_hdrc_add_device(struct device *dev,
 	if (ret)
 		return ERR_PTR(ret);
 
-	id = ida_simple_get(&ci_ida, 0, 0, GFP_KERNEL);
+	id = ida_alloc(&ci_ida, GFP_KERNEL);
 	if (id < 0)
 		return ERR_PTR(id);
 
@@ -883,7 +883,7 @@ struct platform_device *ci_hdrc_add_device(struct device *dev,
 err:
 	platform_device_put(pdev);
 put_id:
-	ida_simple_remove(&ci_ida, id);
+	ida_free(&ci_ida, id);
 	return ERR_PTR(ret);
 }
 EXPORT_SYMBOL_GPL(ci_hdrc_add_device);
@@ -892,7 +892,7 @@ void ci_hdrc_remove_device(struct platform_device *pdev)
 {
 	int id = pdev->id;
 	platform_device_unregister(pdev);
-	ida_simple_remove(&ci_ida, id);
+	ida_free(&ci_ida, id);
 }
 EXPORT_SYMBOL_GPL(ci_hdrc_remove_device);
 
diff --git a/drivers/usb/gadget/function/f_hid.c b/drivers/usb/gadget/function/f_hid.c
index ca0a7d9eaa34..84e834e512dc 100644
--- a/drivers/usb/gadget/function/f_hid.c
+++ b/drivers/usb/gadget/function/f_hid.c
@@ -1028,9 +1028,9 @@ static inline int hidg_get_minor(void)
 {
 	int ret;
 
-	ret = ida_simple_get(&hidg_ida, 0, 0, GFP_KERNEL);
+	ret = ida_alloc(&hidg_ida, GFP_KERNEL);
 	if (ret >= HIDG_MINORS) {
-		ida_simple_remove(&hidg_ida, ret);
+		ida_free(&hidg_ida, ret);
 		ret = -ENODEV;
 	}
 
@@ -1175,7 +1175,7 @@ static const struct config_item_type hid_func_type = {
 
 static inline void hidg_put_minor(int minor)
 {
-	ida_simple_remove(&hidg_ida, minor);
+	ida_free(&hidg_ida, minor);
 }
 
 static void hidg_free_inst(struct usb_function_instance *f)
diff --git a/drivers/usb/gadget/function/f_printer.c b/drivers/usb/gadget/function/f_printer.c
index abec5c58f525..eb325940566c 100644
--- a/drivers/usb/gadget/function/f_printer.c
+++ b/drivers/usb/gadget/function/f_printer.c
@@ -1316,9 +1316,9 @@ static inline int gprinter_get_minor(void)
 {
 	int ret;
 
-	ret = ida_simple_get(&printer_ida, 0, 0, GFP_KERNEL);
+	ret = ida_alloc(&printer_ida, GFP_KERNEL);
 	if (ret >= PRINTER_MINORS) {
-		ida_simple_remove(&printer_ida, ret);
+		ida_free(&printer_ida, ret);
 		ret = -ENODEV;
 	}
 
@@ -1327,7 +1327,7 @@ static inline int gprinter_get_minor(void)
 
 static inline void gprinter_put_minor(int minor)
 {
-	ida_simple_remove(&printer_ida, minor);
+	ida_free(&printer_ida, minor);
 }
 
 static int gprinter_setup(int);
diff --git a/drivers/usb/gadget/function/rndis.c b/drivers/usb/gadget/function/rndis.c
index 713efd9aefde..14e803862940 100644
--- a/drivers/usb/gadget/function/rndis.c
+++ b/drivers/usb/gadget/function/rndis.c
@@ -869,12 +869,12 @@ EXPORT_SYMBOL_GPL(rndis_msg_parser);
 
 static inline int rndis_get_nr(void)
 {
-	return ida_simple_get(&rndis_ida, 0, 0, GFP_KERNEL);
+	return ida_alloc(&rndis_ida, GFP_KERNEL);
 }
 
 static inline void rndis_put_nr(int nr)
 {
-	ida_simple_remove(&rndis_ida, nr);
+	ida_free(&rndis_ida, nr);
 }
 
 struct rndis_params *rndis_register(void (*resp_avail)(void *v), void *v)
diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index ee0e520707dd..6d7d69d09ed4 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -474,7 +474,7 @@ static int altmode_id_get(struct device *dev)
 	else
 		ids = &to_typec_port(dev)->mode_ids;
 
-	return ida_simple_get(ids, 0, 0, GFP_KERNEL);
+	return ida_alloc(ids, GFP_KERNEL);
 }
 
 static void altmode_id_remove(struct device *dev, int id)
@@ -488,7 +488,7 @@ static void altmode_id_remove(struct device *dev, int id)
 	else
 		ids = &to_typec_port(dev)->mode_ids;
 
-	ida_simple_remove(ids, id);
+	ida_free(ids, id);
 }
 
 static void typec_altmode_release(struct device *dev)
@@ -1599,7 +1599,7 @@ static void typec_release(struct device *dev)
 {
 	struct typec_port *port = to_typec_port(dev);
 
-	ida_simple_remove(&typec_index_ida, port->id);
+	ida_free(&typec_index_ida, port->id);
 	ida_destroy(&port->mode_ids);
 	typec_switch_put(port->sw);
 	typec_mux_put(port->mux);
@@ -2042,7 +2042,7 @@ struct typec_port *typec_register_port(struct device *parent,
 	if (!port)
 		return ERR_PTR(-ENOMEM);
 
-	id = ida_simple_get(&typec_index_ida, 0, 0, GFP_KERNEL);
+	id = ida_alloc(&typec_index_ida, GFP_KERNEL);
 	if (id < 0) {
 		kfree(port);
 		return ERR_PTR(id);
-- 
2.25.1

