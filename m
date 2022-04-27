Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 190175112D0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 09:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359073AbiD0Hve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 03:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359045AbiD0HvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 03:51:20 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 296FF113CB3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 00:48:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nqkOXEw25DuVHlsZc4texi4LIoqckg+T8W7sgl5p8eReR/W7iv2RqMVFtHxsNHvRYLtkfqHFdha8ugqAF3eXB5V1phULbhYCv3sJlo0W/H9yzmKFVkHtxapMkj8RHbfogVUCd12Fln7lNpVjNRSePP7dLqvI8poN/G8oIo8v9O6LpnrqWPbpddXnkWHNFc59jTTfBz74mBX68p9tE/GjFiIbJShS9s98HN/n8VVNmygELz2QlCn3g6sbrLLMaXRYlAsi/nS7uCBgZYKQeFasDyWn61exRPDTPd0g25T5kuRAIQVznFJDyAZ26KhB3TpeQno+XGBp5Eyk3JqWVqZlqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oqJKTFJ4bOYLDXbUVdmex7MMkbUlEIj2tIOXATlSP7c=;
 b=E0UlbFkv6zTwwgRdJq5theT5hEbzf9z1T4hKl6qvsS0cjFgRbVmf88nNB0EpRSAEPTTD5kv4bD6onX+wQf/X+qOLMk2Sbig7wvKWfpfJ59JxJgK70T4830IIXzIQ6UvXJofBFc+N2XTyvxq9zkf2fLCqK+sAxMEthCIBGbdhi2PxRfVvv572mSHTQlGX+aWADS6tHO+QKQQMgsWNHpstU6NhW333E7Kem1c/T3YpXsfXMLbQgFFi/+HnEqTlPAXoA/l7Rb6KDPbBhy3kyRYiqMNmB8lS4bCb+2TAiyzXeVZPlZoERnU6v+dvxu4uNH2t8eVcVc10rYEDqiaVG5caZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=xilinx.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oqJKTFJ4bOYLDXbUVdmex7MMkbUlEIj2tIOXATlSP7c=;
 b=Ud17jaiILDy1ivYw8aZjcDgtvO/VrFzoPgK7YvsRjED1QwQrwcq/qOY5Pdrh877pCVyBbybJf7Pf4JfLOoEzx3fZ2K/vfsgQztVcrZIGoUYWH/yAFACDm6tBcTKB46mkHZKGFIk8eDXE+C8KlmFA73hrzYypKYC9YLn2wVcgoeI=
Received: from SA9P221CA0001.NAMP221.PROD.OUTLOOK.COM (2603:10b6:806:25::6) by
 BN7PR02MB4065.namprd02.prod.outlook.com (2603:10b6:406:fe::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.15; Wed, 27 Apr 2022 07:48:06 +0000
Received: from SN1NAM02FT0024.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:25:cafe::67) by SA9P221CA0001.outlook.office365.com
 (2603:10b6:806:25::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13 via Frontend
 Transport; Wed, 27 Apr 2022 07:48:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0024.mail.protection.outlook.com (10.97.5.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Wed, 27 Apr 2022 07:48:06 +0000
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
        id 1njcP6-0002bP-N0; Wed, 27 Apr 2022 00:48:04 -0700
From:   Abhyuday Godhasara <abhyuday.godhasara@xilinx.com>
To:     <gregkh@linuxfoundation.org>
CC:     <michal.simek@xilinx.com>, <abhyuday.godhasara@xilinx.com>,
        <manish.narani@xilinx.com>,
        <lakshmi.sai.krishna.potthuri@xilinx.com>, <jliang@xilinx.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 1/2] driver: soc: xilinx: Add support of multiple callbacks for same event in event management driver
Date:   Wed, 27 Apr 2022 00:48:02 -0700
Message-ID: <20220427074803.19009-2-abhyuday.godhasara@xilinx.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a
In-Reply-To: <20220427074803.19009-1-abhyuday.godhasara@xilinx.com>
References: <20220427074803.19009-1-abhyuday.godhasara@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bac0b324-430c-4169-c494-08da28224407
X-MS-TrafficTypeDiagnostic: BN7PR02MB4065:EE_
X-Microsoft-Antispam-PRVS: <BN7PR02MB4065ADB4444B3D954EB194BCA1FA9@BN7PR02MB4065.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wFHeObXBP9dunHQ+lRCo2E7QydQSAgsMjCoPouGPEuLMkPxIsFgzCor3IUUGHMxMXljDXrPTJHS54/rwS9bwP/HmeQWmfulwEQJa6i/Zu28yhZxeM69KVszpiD2qAIeyEOmTPTvY5rOp07zHwKpubIuLAj+suA9hnS/onSPjWi2oo3WSVm4oiF4Y6uVlAJlmPbiIbnoxblHaPojF0ZsdS0EldybO0KWv/WGPdUYAudSbajevyqPMeJiuIFJUtVzpxm+sJig7wb3pfQRCQI8IckxX8vwpDrN30wuf8m5GN+26zLNM3H8S+k/dqWFOAtn2/Beg0cAwPjuYcHEx36vEpajGRXuJi6Wk4f0OVBkJILFI+Y9T8zw6hFPrAa6Ju+JRE0k35RhbXxt7OXquEF1fxImkNB1FwxxAyhcYYw275u/3sXm/uWAkwzZwhiWr0xUimc9Ecso9j4HEmm8EE3A7k0ME3TbmOpFW7ZdMs7sgIDYBwDXwhqlbYVyC0lpJ5Rt5BDpKq2chMjcQImD6DioXprW6cXv4eShiCTxdJ2AZzUDuxrVLq80SLclxeYeTni9hcQY1ow6mFlXcf/StvHBjkMqhLKDQGgOx6UbiJ6drFj6icft/3u8cCDTTzOlTFuio4dtrk55wB+aq++W3XP5z5Cylb/idgZYz70p4qUwvPCCCHYvwqRck/1jxCoXHryGJwstioqWOYic3mMvnBQ3EBA==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(426003)(186003)(356005)(47076005)(7636003)(7696005)(1076003)(2616005)(508600001)(336012)(6916009)(44832011)(8936002)(9786002)(4326008)(8676002)(82310400005)(36756003)(2906002)(5660300002)(316002)(70586007)(26005)(70206006)(36860700001)(54906003)(40460700003)(83380400001)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2022 07:48:06.0924
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bac0b324-430c-4169-c494-08da28224407
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0024.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR02MB4065
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per the current implementation of only single callback data gets
saved per event, driver is throwing an error if try to register multiple
callback for same event.

Add support of multiple callbacks data for same event. So agent can
register for same event with multiple callbacks. Here event management
driver will store the callbacks as list in Hash table entry for that event.

Here each callback data contain 2 element as callback handler and private
data of agent driver.

Signed-off-by: Abhyuday Godhasara <abhyuday.godhasara@xilinx.com>
---
 drivers/soc/xilinx/xlnx_event_manager.c | 151 ++++++++++++++++++------
 1 file changed, 117 insertions(+), 34 deletions(-)

diff --git a/drivers/soc/xilinx/xlnx_event_manager.c b/drivers/soc/xilinx/xlnx_event_manager.c
index b27f8853508e..f89000dc33a3 100644
--- a/drivers/soc/xilinx/xlnx_event_manager.c
+++ b/drivers/soc/xilinx/xlnx_event_manager.c
@@ -41,25 +41,35 @@ static int event_manager_availability = -EACCES;
 static DEFINE_HASHTABLE(reg_driver_map, REGISTERED_DRIVER_MAX_ORDER);
 static int sgi_num = XLNX_EVENT_SGI_NUM;
 
+/**
+ * struct agent_cb - Registered callback function and private data.
+ * @agent_data:		Data passed back to handler function.
+ * @eve_cb:		Function pointer to store the callback function.
+ * @list:		member to create list.
+ */
+struct agent_cb {
+	void *agent_data;
+	event_cb_func_t eve_cb;
+	struct list_head list;
+};
+
 /**
  * struct registered_event_data - Registered Event Data.
  * @key:		key is the combine id(Node-Id | Event-Id) of type u64
  *			where upper u32 for Node-Id and lower u32 for Event-Id,
  *			And this used as key to index into hashmap.
- * @agent_data:		Data passed back to handler function.
  * @cb_type:		Type of Api callback, like PM_NOTIFY_CB, etc.
- * @eve_cb:		Function pointer to store the callback function.
- * @wake:		If this flag set, firmware will wakeup processor if is
+ * @wake:		If this flag set, firmware will wake up processor if is
  *			in sleep or power down state.
+ * @cb_list_head:	Head of call back data list which contain the information
+ *			about registered handler and private data.
  * @hentry:		hlist_node that hooks this entry into hashtable.
  */
 struct registered_event_data {
 	u64 key;
 	enum pm_api_cb_id cb_type;
-	void *agent_data;
-
-	event_cb_func_t eve_cb;
 	bool wake;
+	struct list_head cb_list_head;
 	struct hlist_node hentry;
 };
 
@@ -78,29 +88,60 @@ static int xlnx_add_cb_for_notify_event(const u32 node_id, const u32 event, cons
 					event_cb_func_t cb_fun,	void *data)
 {
 	u64 key = 0;
+	bool present_in_hash = false;
 	struct registered_event_data *eve_data;
+	struct agent_cb *cb_data;
+	struct agent_cb *cb_pos;
+	struct agent_cb *cb_next;
 
 	key = ((u64)node_id << 32U) | (u64)event;
 	/* Check for existing entry in hash table for given key id */
 	hash_for_each_possible(reg_driver_map, eve_data, hentry, key) {
 		if (eve_data->key == key) {
-			pr_err("Found as already registered\n");
-			return -EINVAL;
+			present_in_hash = true;
+			break;
 		}
 	}
 
-	/* Add new entry if not present */
-	eve_data = kmalloc(sizeof(*eve_data), GFP_KERNEL);
-	if (!eve_data)
-		return -ENOMEM;
+	if (!present_in_hash) {
+		/* Add new entry if not present in HASH table */
+		eve_data = kmalloc(sizeof(*eve_data), GFP_KERNEL);
+		if (!eve_data)
+			return -ENOMEM;
+		eve_data->key = key;
+		eve_data->cb_type = PM_NOTIFY_CB;
+		eve_data->wake = wake;
+		INIT_LIST_HEAD(&eve_data->cb_list_head);
+
+		cb_data = kmalloc(sizeof(*cb_data), GFP_KERNEL);
+		if (!cb_data)
+			return -ENOMEM;
+		cb_data->eve_cb = cb_fun;
+		cb_data->agent_data = data;
+
+		/* Add into callback list */
+		list_add(&cb_data->list, &eve_data->cb_list_head);
+
+		/* Add into HASH table */
+		hash_add(reg_driver_map, &eve_data->hentry, key);
+	} else {
+		/* Search for callback function and private data in list */
+		list_for_each_entry_safe(cb_pos, cb_next, &eve_data->cb_list_head, list) {
+			if (cb_pos->eve_cb == cb_fun &&
+			    cb_pos->agent_data == data) {
+				return 0;
+			}
+		}
 
-	eve_data->key = key;
-	eve_data->cb_type = PM_NOTIFY_CB;
-	eve_data->eve_cb = cb_fun;
-	eve_data->wake = wake;
-	eve_data->agent_data = data;
+		/* Add multiple handler and private data in list */
+		cb_data = kmalloc(sizeof(*cb_data), GFP_KERNEL);
+		if (!cb_data)
+			return -ENOMEM;
+		cb_data->eve_cb = cb_fun;
+		cb_data->agent_data = data;
 
-	hash_add(reg_driver_map, &eve_data->hentry, key);
+		list_add(&cb_data->list, &eve_data->cb_list_head);
+	}
 
 	return 0;
 }
@@ -108,6 +149,7 @@ static int xlnx_add_cb_for_notify_event(const u32 node_id, const u32 event, cons
 static int xlnx_add_cb_for_suspend(event_cb_func_t cb_fun, void *data)
 {
 	struct registered_event_data *eve_data;
+	struct agent_cb *cb_data;
 
 	/* Check for existing entry in hash table for given cb_type */
 	hash_for_each_possible(reg_driver_map, eve_data, hentry, PM_INIT_SUSPEND_CB) {
@@ -124,8 +166,16 @@ static int xlnx_add_cb_for_suspend(event_cb_func_t cb_fun, void *data)
 
 	eve_data->key = 0;
 	eve_data->cb_type = PM_INIT_SUSPEND_CB;
-	eve_data->eve_cb = cb_fun;
-	eve_data->agent_data = data;
+	INIT_LIST_HEAD(&eve_data->cb_list_head);
+
+	cb_data = kmalloc(sizeof(*cb_data), GFP_KERNEL);
+	if (!cb_data)
+		return -ENOMEM;
+	cb_data->eve_cb = cb_fun;
+	cb_data->agent_data = data;
+
+	/* Add into callback list */
+	list_add(&cb_data->list, &eve_data->cb_list_head);
 
 	hash_add(reg_driver_map, &eve_data->hentry, PM_INIT_SUSPEND_CB);
 
@@ -136,12 +186,20 @@ static int xlnx_remove_cb_for_suspend(event_cb_func_t cb_fun)
 {
 	bool is_callback_found = false;
 	struct registered_event_data *eve_data;
+	struct agent_cb *cb_pos;
+	struct agent_cb *cb_next;
 
 	/* Check for existing entry in hash table for given cb_type */
 	hash_for_each_possible(reg_driver_map, eve_data, hentry, PM_INIT_SUSPEND_CB) {
-		if (eve_data->cb_type == PM_INIT_SUSPEND_CB &&
-		    eve_data->eve_cb == cb_fun) {
-			is_callback_found = true;
+		if (eve_data->cb_type == PM_INIT_SUSPEND_CB) {
+			/* Delete the list of callback */
+			list_for_each_entry_safe(cb_pos, cb_next, &eve_data->cb_list_head, list) {
+				if (cb_pos->eve_cb == cb_fun) {
+					is_callback_found = true;
+					list_del_init(&cb_pos->list);
+					kfree(cb_pos);
+				}
+			}
 			/* remove an object from a hashtable */
 			hash_del(&eve_data->hentry);
 			kfree(eve_data);
@@ -161,13 +219,21 @@ static int xlnx_remove_cb_for_notify_event(const u32 node_id, const u32 event,
 	bool is_callback_found = false;
 	struct registered_event_data *eve_data;
 	u64 key = ((u64)node_id << 32U) | (u64)event;
+	struct agent_cb *cb_pos;
+	struct agent_cb *cb_next;
 
 	/* Check for existing entry in hash table for given key id */
 	hash_for_each_possible(reg_driver_map, eve_data, hentry, key) {
-		if (eve_data->key == key &&
-		    eve_data->eve_cb == cb_fun) {
-			is_callback_found = true;
-			/* remove an object from a hashtable */
+		if (eve_data->key == key) {
+			/* Delete the list of callback */
+			list_for_each_entry_safe(cb_pos, cb_next, &eve_data->cb_list_head, list) {
+				if (cb_pos->eve_cb == cb_fun) {
+					is_callback_found = true;
+					list_del_init(&cb_pos->list);
+					kfree(cb_pos);
+				}
+			}
+			/* remove an object from a HASH table */
 			hash_del(&eve_data->hentry);
 			kfree(eve_data);
 		}
@@ -338,12 +404,16 @@ static void xlnx_call_suspend_cb_handler(const u32 *payload)
 	bool is_callback_found = false;
 	struct registered_event_data *eve_data;
 	u32 cb_type = payload[0];
+	struct agent_cb *cb_pos;
+	struct agent_cb *cb_next;
 
 	/* Check for existing entry in hash table for given cb_type */
 	hash_for_each_possible(reg_driver_map, eve_data, hentry, cb_type) {
 		if (eve_data->cb_type == cb_type) {
-			eve_data->eve_cb(&payload[0], eve_data->agent_data);
-			is_callback_found = true;
+			list_for_each_entry_safe(cb_pos, cb_next, &eve_data->cb_list_head, list) {
+				cb_pos->eve_cb(&payload[0], cb_pos->agent_data);
+				is_callback_found = true;
+			}
 		}
 	}
 	if (!is_callback_found)
@@ -356,12 +426,16 @@ static void xlnx_call_notify_cb_handler(const u32 *payload)
 	struct registered_event_data *eve_data;
 	u64 key = ((u64)payload[1] << 32U) | (u64)payload[2];
 	int ret;
+	struct agent_cb *cb_pos;
+	struct agent_cb *cb_next;
 
 	/* Check for existing entry in hash table for given key id */
 	hash_for_each_possible(reg_driver_map, eve_data, hentry, key) {
 		if (eve_data->key == key) {
-			eve_data->eve_cb(&payload[0], eve_data->agent_data);
-			is_callback_found = true;
+			list_for_each_entry_safe(cb_pos, cb_next, &eve_data->cb_list_head, list) {
+				cb_pos->eve_cb(&payload[0], cb_pos->agent_data);
+				is_callback_found = true;
+			}
 
 			/* re register with firmware to get future events */
 			ret = zynqmp_pm_register_notifier(payload[1], payload[2],
@@ -369,9 +443,12 @@ static void xlnx_call_notify_cb_handler(const u32 *payload)
 			if (ret) {
 				pr_err("%s() failed for 0x%x and 0x%x: %d\r\n", __func__,
 				       payload[1], payload[2], ret);
-				/* Remove already registered event from hash table */
-				xlnx_remove_cb_for_notify_event(payload[1], payload[2],
-								eve_data->eve_cb);
+				list_for_each_entry_safe(cb_pos, cb_next, &eve_data->cb_list_head,
+							 list) {
+					/* Remove already registered event from hash table */
+					xlnx_remove_cb_for_notify_event(payload[1], payload[2],
+									cb_pos->eve_cb);
+				}
 			}
 		}
 	}
@@ -572,8 +649,14 @@ static int xlnx_event_manager_remove(struct platform_device *pdev)
 	struct registered_event_data *eve_data;
 	struct hlist_node *tmp;
 	int ret;
+	struct agent_cb *cb_pos;
+	struct agent_cb *cb_next;
 
 	hash_for_each_safe(reg_driver_map, i, tmp, eve_data, hentry) {
+		list_for_each_entry_safe(cb_pos, cb_next, &eve_data->cb_list_head, list) {
+			list_del_init(&cb_pos->list);
+			kfree(cb_pos);
+		}
 		hash_del(&eve_data->hentry);
 		kfree(eve_data);
 	}
-- 
2.32.0.93.g670b81a

