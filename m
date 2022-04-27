Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21AC95112D3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 09:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359059AbiD0Hvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 03:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359039AbiD0HvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 03:51:19 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D05A11379F
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 00:48:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lyyxN8UoKxpUUKIfA/gCM2/6AaiwyIzStR2ajESh6tKeOffppvsDh/Y++fctb62HoDkIgker6+XfRvzX9+52OStrNYh/kx0mQAAsYS1/ZEaLbv6lJ2nBb0Ej2W/gDwXWN0HvMH0wLDq+ubEzpOYfzHoEjBbZdlBPgPgCLNN9/WQ2g6IlRPDzHz5Jb4pLbiCzu6ZmJEK1FB3ECFHARZ6VYP5SEoimWgFLw8OH5m+lhdnhdxpTbx75nxI2yEhllzpC6HDh0i0q8D4Fzwpn7OdBizzILFfNkNM5prx2EZnxRIUvFPmxKGe3QL8nm3evZYiEgaPMMcGXn2EfRvyM5NAK1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=geOI8YRxKJsqpY5LdH038fvqEhriYRA2X69C7YeZVmc=;
 b=RJqEjTx4FnEufes90NlK2/Pv9kf8k4zTzA62okcOfOIcIhwQDQriW9YZDa5P9SRXkm4k8ZUe+CDiybbtn429nW2pUba3ENA/pl6V4KEFpFM59L34TBuuFMh14wptwmiujJITMExSnWoKUNWd+MPVuXoWRIHXp0LTwxQmm+2e5qD54VmPLaCxWIN//LVg1QYoi1zSJNk+YdiEC/hb6IcikjrlbEX/Xvzl027zsKsepApukmCYsJHWS4+0lopR5qDtbzjTieWTmWJxu4KewzIJHHvUk+iMfISosI5m7wZheYkTJk2304lJzh6CyHepXGgr44xhMArJK5MaGUIDMf1ygA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=xilinx.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=geOI8YRxKJsqpY5LdH038fvqEhriYRA2X69C7YeZVmc=;
 b=sr81v9U60wkdEXBfGdW9Y9cepLish4DCkcRZwRIixyZLHoLiGd+Le4Gs/RA+4v5VTNyw6Ch9IbAMazc2qZFoKok+S2XEU2fBgsICnjwc/oUMh28Vw+hKqL9VeozNaPPoPF2OCeRAI4SeVKxLshpBwggdUbzp0EHOh4yXZlAGYMw=
Received: from SA9P221CA0004.NAMP221.PROD.OUTLOOK.COM (2603:10b6:806:25::9) by
 BL3PR02MB8236.namprd02.prod.outlook.com (2603:10b6:208:343::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.14; Wed, 27 Apr 2022 07:48:05 +0000
Received: from SN1NAM02FT0024.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:25:cafe::29) by SA9P221CA0004.outlook.office365.com
 (2603:10b6:806:25::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14 via Frontend
 Transport; Wed, 27 Apr 2022 07:48:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0024.mail.protection.outlook.com (10.97.5.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Wed, 27 Apr 2022 07:48:05 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 27 Apr 2022 00:48:04 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Wed, 27 Apr 2022 00:48:04 -0700
Envelope-to: gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Received: from [172.19.2.91] (port=54884 helo=xsjpmteam52.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <abhyuday.godhasara@xilinx.com>)
        id 1njcP6-0002bP-OG; Wed, 27 Apr 2022 00:48:04 -0700
From:   Abhyuday Godhasara <abhyuday.godhasara@xilinx.com>
To:     <gregkh@linuxfoundation.org>
CC:     <michal.simek@xilinx.com>, <abhyuday.godhasara@xilinx.com>,
        <manish.narani@xilinx.com>,
        <lakshmi.sai.krishna.potthuri@xilinx.com>, <jliang@xilinx.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 2/2] driver: soc: xilinx: Update function prototype for xlnx_unregister_event
Date:   Wed, 27 Apr 2022 00:48:03 -0700
Message-ID: <20220427074803.19009-3-abhyuday.godhasara@xilinx.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a
In-Reply-To: <20220427074803.19009-1-abhyuday.godhasara@xilinx.com>
References: <20220427074803.19009-1-abhyuday.godhasara@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: de752158-56ea-4946-f371-08da28224392
X-MS-TrafficTypeDiagnostic: BL3PR02MB8236:EE_
X-Microsoft-Antispam-PRVS: <BL3PR02MB8236C490AD3E1654099A9534A1FA9@BL3PR02MB8236.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tlhBD3k1lOp7FhaNd54Cxp4WKCNZielR9vc2kKpLvuPyGVR97tt4oZgFjwk4Xs5IYWaMDZQK6MKGLLDyT+0cAz9ax9WPXhm568bX5e562BUFXlQEFQTbZgeWYB64PjM36XuR9mIzl1DS09K0n9xSL5j54SI3Jbmyb/BFHbo+twB9qjSUGdMCMXDGP7GXJG4iYT1f9KmFwr29hAnXzeqS1lw0kk1gDpklGnK472iltsSgE4wLAjRMByqH5eaRIg0leFbua5kR373v6irxW9uBk5QWNtEyIebo5a44ehnSs/pyXJDkzxiKxsQLTDjN8L6FJ02PW3hEs2qJKInG43q6jA3Fo1FwuC0hmvEs3FO8KCk+EyyZph87n0uaqr/6XYnlzzJMXypYwwo/ODZfZsSgmn0XUXBHJe9RyMh64K1dQn1N4l7IMKTxbEaQcOZg2q6ELoQt1shDXFM9ksAMwdyaD8zVy/COmZKBat4WBD3GKNgiAotlqcmgI0WOVG9Uj+/2VzW7Zdme7cz4EugrdibOjppK8kUgkinJLI4UPWKeAG/Sf/3OVXhEEl93MTH8lprR4jopd9PNNYf+e3zEUXjoeqqgQlNLY+qhg6oV/4UxTHf4BC6EmgIq1IRy4zyagCdXx88lAEkZifcNanJxq1Jorm6TqP0uVDwiB9BRVyKZeKIRllr2YHrGnIGF+8zSeOExjAzcmX3ZXTLJhY17s6Se1g==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(6916009)(70586007)(70206006)(8676002)(54906003)(356005)(4326008)(2616005)(7636003)(316002)(82310400005)(7696005)(26005)(40460700003)(36860700001)(426003)(1076003)(508600001)(186003)(47076005)(336012)(83380400001)(2906002)(15650500001)(44832011)(9786002)(5660300002)(8936002)(36756003)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2022 07:48:05.3268
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de752158-56ea-4946-f371-08da28224392
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0024.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR02MB8236
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per the current implementation only single callback data gets saved per
event, driver is throwing an error if try to register multiple callback for
same event. So at time of unregistration of any event required things are
event details and callback handler as parameter of xlnx_unregister_event().

As part of adding support of multiple callbacks for same event also require
change in prototype of xlnx_unregister_event().
During unregistration of any events, now required things are event details,
callback handler and agent's private data as parameter of
xlnx_unregister_event().

Also modify the usage of xlnx_unregister_event() in xilinx/zynqmp_power.c
driver as per new implementation.

Signed-off-by: Abhyuday Godhasara <abhyuday.godhasara@xilinx.com>
---
 drivers/soc/xilinx/xlnx_event_manager.c     | 58 ++++++++++++++-------
 drivers/soc/xilinx/zynqmp_power.c           |  7 +--
 include/linux/firmware/xlnx-event-manager.h |  4 +-
 3 files changed, 45 insertions(+), 24 deletions(-)

diff --git a/drivers/soc/xilinx/xlnx_event_manager.c b/drivers/soc/xilinx/xlnx_event_manager.c
index f89000dc33a3..5dcb7665fe22 100644
--- a/drivers/soc/xilinx/xlnx_event_manager.c
+++ b/drivers/soc/xilinx/xlnx_event_manager.c
@@ -41,6 +41,8 @@ static int event_manager_availability = -EACCES;
 static DEFINE_HASHTABLE(reg_driver_map, REGISTERED_DRIVER_MAX_ORDER);
 static int sgi_num = XLNX_EVENT_SGI_NUM;
 
+static bool is_need_to_unregister;
+
 /**
  * struct agent_cb - Registered callback function and private data.
  * @agent_data:		Data passed back to handler function.
@@ -189,6 +191,8 @@ static int xlnx_remove_cb_for_suspend(event_cb_func_t cb_fun)
 	struct agent_cb *cb_pos;
 	struct agent_cb *cb_next;
 
+	is_need_to_unregister = false;
+
 	/* Check for existing entry in hash table for given cb_type */
 	hash_for_each_possible(reg_driver_map, eve_data, hentry, PM_INIT_SUSPEND_CB) {
 		if (eve_data->cb_type == PM_INIT_SUSPEND_CB) {
@@ -203,6 +207,7 @@ static int xlnx_remove_cb_for_suspend(event_cb_func_t cb_fun)
 			/* remove an object from a hashtable */
 			hash_del(&eve_data->hentry);
 			kfree(eve_data);
+			is_need_to_unregister = true;
 		}
 	}
 	if (!is_callback_found) {
@@ -214,7 +219,7 @@ static int xlnx_remove_cb_for_suspend(event_cb_func_t cb_fun)
 }
 
 static int xlnx_remove_cb_for_notify_event(const u32 node_id, const u32 event,
-					   event_cb_func_t cb_fun)
+					   event_cb_func_t cb_fun, void *data)
 {
 	bool is_callback_found = false;
 	struct registered_event_data *eve_data;
@@ -222,20 +227,28 @@ static int xlnx_remove_cb_for_notify_event(const u32 node_id, const u32 event,
 	struct agent_cb *cb_pos;
 	struct agent_cb *cb_next;
 
+	is_need_to_unregister = false;
+
 	/* Check for existing entry in hash table for given key id */
 	hash_for_each_possible(reg_driver_map, eve_data, hentry, key) {
 		if (eve_data->key == key) {
 			/* Delete the list of callback */
 			list_for_each_entry_safe(cb_pos, cb_next, &eve_data->cb_list_head, list) {
-				if (cb_pos->eve_cb == cb_fun) {
+				if (cb_pos->eve_cb == cb_fun &&
+				    cb_pos->agent_data == data) {
 					is_callback_found = true;
 					list_del_init(&cb_pos->list);
 					kfree(cb_pos);
 				}
 			}
-			/* remove an object from a HASH table */
-			hash_del(&eve_data->hentry);
-			kfree(eve_data);
+
+			/* Remove HASH table if callback list is empty */
+			if (list_empty(&eve_data->cb_list_head)) {
+				/* remove an object from a HASH table */
+				hash_del(&eve_data->hentry);
+				kfree(eve_data);
+				is_need_to_unregister = true;
+			}
 		}
 	}
 	if (!is_callback_found) {
@@ -307,7 +320,7 @@ int xlnx_register_event(const enum pm_api_cb_id cb_type, const u32 node_id, cons
 					eve = event & (1 << pos);
 					if (!eve)
 						continue;
-					xlnx_remove_cb_for_notify_event(node_id, eve, cb_fun);
+					xlnx_remove_cb_for_notify_event(node_id, eve, cb_fun, data);
 				}
 			}
 		}
@@ -329,10 +342,10 @@ int xlnx_register_event(const enum pm_api_cb_id cb_type, const u32 node_id, cons
 					eve = event & (1 << pos);
 					if (!eve)
 						continue;
-					xlnx_remove_cb_for_notify_event(node_id, eve, cb_fun);
+					xlnx_remove_cb_for_notify_event(node_id, eve, cb_fun, data);
 				}
 			} else {
-				xlnx_remove_cb_for_notify_event(node_id, event, cb_fun);
+				xlnx_remove_cb_for_notify_event(node_id, event, cb_fun, data);
 			}
 			return ret;
 		}
@@ -350,15 +363,18 @@ EXPORT_SYMBOL_GPL(xlnx_register_event);
  * @node_id:	Node-Id related to event.
  * @event:	Event Mask for the Error Event.
  * @cb_fun:	Function pointer of callback function.
+ * @data:	Pointer of agent's private data.
  *
  * Return:	Returns 0 on successful unregistration else error code.
  */
 int xlnx_unregister_event(const enum pm_api_cb_id cb_type, const u32 node_id, const u32 event,
-			  event_cb_func_t cb_fun)
+			  event_cb_func_t cb_fun, void *data)
 {
-	int ret;
+	int ret = 0;
 	u32 eve, pos;
 
+	is_need_to_unregister = false;
+
 	if (event_manager_availability)
 		return event_manager_availability;
 
@@ -375,23 +391,26 @@ int xlnx_unregister_event(const enum pm_api_cb_id cb_type, const u32 node_id, co
 	} else {
 		/* Remove Node-Id/Event from hash table */
 		if (!xlnx_is_error_event(node_id)) {
-			xlnx_remove_cb_for_notify_event(node_id, event, cb_fun);
+			xlnx_remove_cb_for_notify_event(node_id, event, cb_fun, data);
 		} else {
 			for (pos = 0; pos < MAX_BITS; pos++) {
 				eve = event & (1 << pos);
 				if (!eve)
 					continue;
 
-				xlnx_remove_cb_for_notify_event(node_id, eve, cb_fun);
+				xlnx_remove_cb_for_notify_event(node_id, eve, cb_fun, data);
 			}
 		}
 
-		/* Un-register for Node-Id/Event combination */
-		ret = zynqmp_pm_register_notifier(node_id, event, false, false);
-		if (ret) {
-			pr_err("%s() failed for 0x%x and 0x%x: %d\n",
-			       __func__, node_id, event, ret);
-			return ret;
+		/* Un-register if list is empty */
+		if (is_need_to_unregister) {
+			/* Un-register for Node-Id/Event combination */
+			ret = zynqmp_pm_register_notifier(node_id, event, false, false);
+			if (ret) {
+				pr_err("%s() failed for 0x%x and 0x%x: %d\n",
+				       __func__, node_id, event, ret);
+				return ret;
+			}
 		}
 	}
 
@@ -447,7 +466,8 @@ static void xlnx_call_notify_cb_handler(const u32 *payload)
 							 list) {
 					/* Remove already registered event from hash table */
 					xlnx_remove_cb_for_notify_event(payload[1], payload[2],
-									cb_pos->eve_cb);
+									cb_pos->eve_cb,
+									cb_pos->agent_data);
 				}
 			}
 		}
diff --git a/drivers/soc/xilinx/zynqmp_power.c b/drivers/soc/xilinx/zynqmp_power.c
index 859dd31b6eff..78a8a7545d1e 100644
--- a/drivers/soc/xilinx/zynqmp_power.c
+++ b/drivers/soc/xilinx/zynqmp_power.c
@@ -208,7 +208,7 @@ static int zynqmp_pm_probe(struct platform_device *pdev)
 							   GFP_KERNEL);
 		if (!zynqmp_pm_init_suspend_work) {
 			xlnx_unregister_event(PM_INIT_SUSPEND_CB, 0, 0,
-					      suspend_event_callback);
+					      suspend_event_callback, NULL);
 			return -ENOMEM;
 		}
 		event_registered = true;
@@ -263,7 +263,8 @@ static int zynqmp_pm_probe(struct platform_device *pdev)
 	ret = sysfs_create_file(&pdev->dev.kobj, &dev_attr_suspend_mode.attr);
 	if (ret) {
 		if (event_registered) {
-			xlnx_unregister_event(PM_INIT_SUSPEND_CB, 0, 0, suspend_event_callback);
+			xlnx_unregister_event(PM_INIT_SUSPEND_CB, 0, 0, suspend_event_callback,
+					      NULL);
 			event_registered = false;
 		}
 		dev_err(&pdev->dev, "unable to create sysfs interface\n");
@@ -277,7 +278,7 @@ static int zynqmp_pm_remove(struct platform_device *pdev)
 {
 	sysfs_remove_file(&pdev->dev.kobj, &dev_attr_suspend_mode.attr);
 	if (event_registered)
-		xlnx_unregister_event(PM_INIT_SUSPEND_CB, 0, 0, suspend_event_callback);
+		xlnx_unregister_event(PM_INIT_SUSPEND_CB, 0, 0, suspend_event_callback, NULL);
 
 	if (!rx_chan)
 		mbox_free_channel(rx_chan);
diff --git a/include/linux/firmware/xlnx-event-manager.h b/include/linux/firmware/xlnx-event-manager.h
index 3f87c4929d21..82e8254b0f80 100644
--- a/include/linux/firmware/xlnx-event-manager.h
+++ b/include/linux/firmware/xlnx-event-manager.h
@@ -17,7 +17,7 @@ int xlnx_register_event(const enum pm_api_cb_id cb_type, const u32 node_id,
 			event_cb_func_t cb_fun, void *data);
 
 int xlnx_unregister_event(const enum pm_api_cb_id cb_type, const u32 node_id,
-			  const u32 event, event_cb_func_t cb_fun);
+			  const u32 event, event_cb_func_t cb_fun, void *data);
 #else
 static inline int xlnx_register_event(const enum pm_api_cb_id cb_type, const u32 node_id,
 				      const u32 event, const bool wake,
@@ -27,7 +27,7 @@ static inline int xlnx_register_event(const enum pm_api_cb_id cb_type, const u32
 }
 
 static inline int xlnx_unregister_event(const enum pm_api_cb_id cb_type, const u32 node_id,
-					 const u32 event, event_cb_func_t cb_fun)
+					const u32 event, event_cb_func_t cb_fun, void *data)
 {
 	return -ENODEV;
 }
-- 
2.32.0.93.g670b81a

