Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3E0C51EEF8
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 18:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236810AbiEHQjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 12:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236510AbiEHQj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 12:39:26 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A41D65F8C
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 09:35:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l3m4TQh2eCI64Nk525rKpDYXBEuBbaxIHOqy/Ibrs1clgMyil1BemeSXLpLX31zSMdiz91cBsj9YGLKIC1zwZF9rF640gUD5v88CVlcVMkmlqW/NXyfRags0u03+CEVA0VpdVGqbLGcI/5CtaGyGFRy/j99Ipq5Rlzw8ysxC1vVKZonmZ4XAqieAV+k9TAWyOi6foyRhALLUUa0ZmXu8uoVjtvfUUf8Zo9/ZHUTPAIqWBlYKUD/g//tUSQURuZ2YWPPoV0oQ+3zDHHnM3KsORnBUIIWL0T6eEsbi7kmBgU+lZsLB2nl24AIkcPSOaF5gXKguKQimCdxSJjqqdDgU7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4WWcLWZXx98Wsv3R4mFwu/Ru1A3ufMak+xjs8CKwzKw=;
 b=j5qSQnLejgdS3ABJFLW88cwZXa5ZL+mLrGXhzm93Zpq/HzZEmoOyTk7RQ+VZ1SmKBy8lq/GJPDsUI5BkQvgpKI7yjRZr3c1mBiPemv/t0ct0OJ5UwOrl7a18SCkkiUqGCusFHMH7G62iLntQmFxK2JZ1t0PaOkA0KvzQUAQZw8hx15HJOQBK8b0164n+cf2rTmt33M627Nnq3M3ggmPUne/b8Jqi7Va1jF+tuA7adB/7Y7KrL71uFI5AHX9cVv6Fk7mfBBGlA/WRRBcJu38TkZ5zS4ExciwBI1rsNIaLYaP70RLE5R44vAdXeGjLg9BNknDbwa/s9q8dkMs4lJfACw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4WWcLWZXx98Wsv3R4mFwu/Ru1A3ufMak+xjs8CKwzKw=;
 b=nYCRl9WSnHbT4+qM0bdXWKKBGl9T2eteS/iQKHOFjhyG6R4Gqg28aMY10NL1yKqEKc/4vyrCUv+Q5u5k1kLse8W/B/ldFhdM774Pa1lQGgqGEC+lhFmNh4gOIS0yois5TP5/a9ofnoTK4ucXLo75P1uMFccYSvCB1Xd45aMtgEy95Ce+ZV5Cljycb2AcQuaUYuOrKSxWhreGK+a45aB/dkEXdMHdbG8T/ciJeeMjjM5fLR5TIFyN+VFgCNAT5f8nZ2PsQLhUddCVA/lBB3PHrAvlLM65BqNqfiXudEaSI5e9ucivNfT+4vhEU4CRpHF4YuXbEo0atcHKOFr3e6cTpw==
Received: from BN9PR03CA0770.namprd03.prod.outlook.com (2603:10b6:408:13a::25)
 by DM6PR12MB4283.namprd12.prod.outlook.com (2603:10b6:5:211::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20; Sun, 8 May
 2022 16:35:32 +0000
Received: from BN8NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13a:cafe::2d) by BN9PR03CA0770.outlook.office365.com
 (2603:10b6:408:13a::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22 via Frontend
 Transport; Sun, 8 May 2022 16:35:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 BN8NAM11FT057.mail.protection.outlook.com (10.13.177.49) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5227.15 via Frontend Transport; Sun, 8 May 2022 16:35:32 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Sun, 8 May
 2022 16:35:31 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Sun, 8 May 2022
 09:35:30 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.986.22 via Frontend Transport; Sun, 8 May
 2022 09:35:28 -0700
From:   Eli Cohen <elic@nvidia.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>
CC:     <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <si-wei.liu@oracle.com>,
        Eli Cohen <elic@nvidia.com>
Subject: [PATCH for reference] vdpa: Add supprt for reading vdpa device statistics
Date:   Sun, 8 May 2022 19:35:25 +0300
Message-ID: <20220508163525.204874-1-elic@nvidia.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cb887fbc-e136-48ee-4789-08da3110c535
X-MS-TrafficTypeDiagnostic: DM6PR12MB4283:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4283DFA5C5B475085DA3B991ABC79@DM6PR12MB4283.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VgVWmyLsMdZmW+c/DvBikdjmjO5tepePKY0m1cAoeYV+SVmWuk28YspPk/K0VGT6/TZC5go9KPWTieM9unRTxdBe65pHNg06vQlOzsh5dDxcvPbvfpV0geMINckYERRRSaIOryCttC8wRy00ndoE34ElQj4ZZipVVs60mgC2mCsaL2MCQKrZuTQ/dXbEEBq5SOZ0wtQeUkabElIxNvvALr0AkqVfnJ/1J1A0Pdw+fG8leCUnpQ4s+TZcJUg3xW1QfLOImcZU8v7FP0bHXo4ZP1U5/hW1GoTPyBb8ZkYhLfHAydt0UCfcstAYAoXs0BHyU9ZtfyoPbhbwWyLCAjO/6eIBZE3Ll4knhnbI1JiaBhkDhJBb4de8V1NXJYtM9P3M8q529dW08m+oSQgkztmmw8kF0iv5LdNdhCiNet6u6WKqWncPEWoX+RW30iSfVpuA6QZZCECss9LcAsR5HYNkKK2m1hVz1GhO/i7yh0VTQPbuNqcwCXhIH80AVDHYffgUP3u7jIDkqOxdVbiHmVah89k+rqtbHnIDdG2kIwawiA8mKqDEC8TQTWc6MYGWnGbldaSQnF9RNXDXfmzOG0/lWgPvHcBAi3qLqVFDTk6EtXo3629Xx9W0sAnFRGXD2L3yAyKHzpdIB4L4/QLbvoJBwIqOL8Ul0eaQzILIdriUbHasYjvX7FXSRxx8bdkJCsEMc8OjEWfXyJ0agcbLNuGkXQ==
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(40460700003)(86362001)(5660300002)(26005)(54906003)(186003)(2616005)(81166007)(1076003)(316002)(107886003)(7696005)(6666004)(110136005)(36756003)(426003)(2906002)(356005)(47076005)(336012)(70206006)(70586007)(8676002)(4326008)(82310400005)(83380400001)(36860700001)(8936002)(508600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2022 16:35:32.2468
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb887fbc-e136-48ee-4789-08da3110c535
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4283
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Read statistics of a vdpa device. The specific data is a recieved as a
pair of attribute name and attribute value.

Examples:
1. Read statistics for the virtqueue at index 1

$ vdpa dev vstats show vdpa-a qidx 1
vdpa-a:
qtype tx qidx 1 received_desc 4583367 completed_desc 4583367

2. Read statistics for the virtqueue at index 32
$ vdpa dev vstats show vdpa-a qidx 32
vdpa-a:
qtype cvq qidx 32 received_desc 0 completed_desc 0

3. Read statisitics for the virtqueue at index 0 with json output
$ vdpa -j dev vstats show vdpa-a qidx 0
{"vstats":{"vdpa-a":{
"qtype":"rx","qidx":0,"name":"received_desc","value":490205,"name":"completed_desc","value":489964}}}

4. Read statistics for the virtqueue at index 0 with preety json
   output
$ vdpa -jp dev vstats show vdpa-a qidx 0
{
    "vstats": {
        "vdpa-a": {

            "qtype": "rx",
            "qidx": 0,
            "name": "received_desc",
            "value": 490205,
            "name": "completed_desc",
            "value": 489964
        }
    }
}

Signed-off-by: Eli Cohen <elic@nvidia.com>
---
 vdpa/include/uapi/linux/vdpa.h |   6 ++
 vdpa/vdpa.c                    | 192 +++++++++++++++++++++++++++++++++
 2 files changed, 198 insertions(+)

diff --git a/vdpa/include/uapi/linux/vdpa.h b/vdpa/include/uapi/linux/vdpa.h
index cc575a825a7c..7f52e703f1ad 100644
--- a/vdpa/include/uapi/linux/vdpa.h
+++ b/vdpa/include/uapi/linux/vdpa.h
@@ -18,6 +18,7 @@ enum vdpa_command {
 	VDPA_CMD_DEV_DEL,
 	VDPA_CMD_DEV_GET,		/* can dump */
 	VDPA_CMD_DEV_CONFIG_GET,	/* can dump */
+	VDPA_CMD_DEV_STATS_GET,
 };
 
 enum vdpa_attr {
@@ -46,6 +47,11 @@ enum vdpa_attr {
 	VDPA_ATTR_DEV_NEGOTIATED_FEATURES,	/* u64 */
 	VDPA_ATTR_DEV_MGMTDEV_MAX_VQS,		/* u32 */
 	VDPA_ATTR_DEV_SUPPORTED_FEATURES,	/* u64 */
+
+	VDPA_ATTR_DEV_QUEUE_INDEX,		/* u32 */
+	VDPA_ATTR_DEV_VENDOR_ATTR_NAME,		/* string */
+	VDPA_ATTR_DEV_VENDOR_ATTR_VALUE,	/* u64 */
+
 	/* new attributes must be added above here */
 	VDPA_ATTR_MAX,
 };
diff --git a/vdpa/vdpa.c b/vdpa/vdpa.c
index 3ae1b78f4cac..2bceadc194e3 100644
--- a/vdpa/vdpa.c
+++ b/vdpa/vdpa.c
@@ -26,6 +26,7 @@
 #define VDPA_OPT_VDEV_MAC		BIT(4)
 #define VDPA_OPT_VDEV_MTU		BIT(5)
 #define VDPA_OPT_MAX_VQP		BIT(6)
+#define VDPA_OPT_QUEUE_INDEX		BIT(7)
 
 struct vdpa_opts {
 	uint64_t present; /* flags of present items */
@@ -36,6 +37,7 @@ struct vdpa_opts {
 	char mac[ETH_ALEN];
 	uint16_t mtu;
 	uint16_t max_vqp;
+	uint32_t queue_idx;
 };
 
 struct vdpa {
@@ -43,6 +45,7 @@ struct vdpa {
 	struct vdpa_opts opts;
 	bool json_output;
 	struct indent_mem *indent;
+	int cvq_index;
 };
 
 static void pr_out_section_start(struct vdpa *vdpa, const char *name)
@@ -174,6 +177,18 @@ static int vdpa_argv_u16(struct vdpa *vdpa, int argc, char **argv,
 	return get_u16(result, *argv, 10);
 }
 
+static int vdpa_argv_u32(struct vdpa *vdpa, int argc, char **argv,
+			 uint32_t *result)
+{
+	if (argc <= 0 || *argv == NULL) {
+		fprintf(stderr, "number expected\n");
+		return -EINVAL;
+	}
+
+	return get_u32(result, *argv, 10);
+}
+
+
 struct vdpa_args_metadata {
 	uint64_t o_flag;
 	const char *err_msg;
@@ -183,6 +198,7 @@ static const struct vdpa_args_metadata vdpa_args_required[] = {
 	{VDPA_OPT_VDEV_MGMTDEV_HANDLE, "management device handle not set."},
 	{VDPA_OPT_VDEV_NAME, "device name is not set."},
 	{VDPA_OPT_VDEV_HANDLE, "device name is not set."},
+	{VDPA_OPT_QUEUE_INDEX, "queue index is not set."},
 };
 
 static int vdpa_args_finding_required_validate(uint64_t o_required,
@@ -228,6 +244,8 @@ static void vdpa_opts_put(struct nlmsghdr *nlh, struct vdpa *vdpa)
 		mnl_attr_put_u16(nlh, VDPA_ATTR_DEV_NET_CFG_MTU, opts->mtu);
 	if (opts->present & VDPA_OPT_MAX_VQP)
 		mnl_attr_put_u16(nlh, VDPA_ATTR_DEV_NET_CFG_MAX_VQP, opts->max_vqp);
+	if (opts->present & VDPA_OPT_QUEUE_INDEX)
+		mnl_attr_put_u32(nlh, VDPA_ATTR_DEV_QUEUE_INDEX, opts->queue_idx);
 }
 
 static int vdpa_argv_parse(struct vdpa *vdpa, int argc, char **argv,
@@ -304,6 +322,14 @@ static int vdpa_argv_parse(struct vdpa *vdpa, int argc, char **argv,
 
 			NEXT_ARG_FWD();
 			o_found |= VDPA_OPT_MAX_VQP;
+		} else if ((matches(*argv, "qidx")  == 0) && (o_optional & VDPA_OPT_QUEUE_INDEX)) {
+			NEXT_ARG_FWD();
+			err = vdpa_argv_u32(vdpa, argc, argv, &opts->queue_idx);
+			if (err)
+				return err;
+
+			NEXT_ARG_FWD();
+			o_found |= VDPA_OPT_QUEUE_INDEX;
 		} else {
 			fprintf(stderr, "Unknown option \"%s\"\n", *argv);
 			return -EINVAL;
@@ -594,6 +620,7 @@ static void cmd_dev_help(void)
 	fprintf(stderr, "                                                    [ max_vqp MAX_VQ_PAIRS ]\n");
 	fprintf(stderr, "       vdpa dev del DEV\n");
 	fprintf(stderr, "Usage: vdpa dev config COMMAND [ OPTIONS ]\n");
+	fprintf(stderr, "Usage: vdpa dev vstats COMMAND\n");
 }
 
 static const char *device_type_name(uint32_t type)
@@ -819,6 +846,169 @@ static int cmd_dev_config(struct vdpa *vdpa, int argc, char **argv)
 	return -ENOENT;
 }
 
+#define MAX_KEY_LEN 200
+/* 5 bytes for format */
+#define MAX_FMT_LEN (MAX_KEY_LEN + 5 + 1)
+
+static void pr_out_dev_net_vstats(const struct nlmsghdr *nlh, int cvq_index)
+{
+	const char *name = NULL;
+	char fmt[MAX_FMT_LEN];
+	struct nlattr *attr;
+	uint16_t qidx = 0;
+	uint64_t v64;
+
+	mnl_attr_for_each(attr, nlh, sizeof(struct genlmsghdr)) {
+		switch(attr->nla_type) {
+		case VDPA_ATTR_DEV_QUEUE_INDEX:
+			qidx = mnl_attr_get_u16(attr);
+			if (qidx != cvq_index) {
+				if (qidx & 1)
+					print_string(PRINT_ANY, "queue_type", "queue_type %s ", "tx");
+				else
+					print_string(PRINT_ANY, "queue_type", "queue_type %s ", "rx");
+			} else {
+					print_string(PRINT_ANY, "queue_type", "queue_type %s ", "control_vq");
+			}
+			break;
+		case VDPA_ATTR_DEV_VENDOR_ATTR_NAME:
+			name = mnl_attr_get_str(attr);
+			if (strlen(name) > MAX_KEY_LEN)
+				return;
+
+			strcpy(fmt, name);
+			strcat(fmt, " %lu ");
+			break;
+		case VDPA_ATTR_DEV_VENDOR_ATTR_VALUE:
+			v64 = mnl_attr_get_u64(attr);
+			print_u64(PRINT_ANY, name, fmt, v64);
+			break;
+		}
+	}
+}
+
+static void pr_out_dev_vstats(struct vdpa *vdpa, struct nlattr **tb, const struct nlmsghdr *nlh)
+{
+	uint32_t device_id = mnl_attr_get_u32(tb[VDPA_ATTR_DEV_ID]);
+
+	pr_out_vdev_handle_start(vdpa, tb);
+	switch (device_id) {
+	case VIRTIO_ID_NET:
+		pr_out_dev_net_vstats(nlh, vdpa->cvq_index);
+		break;
+	default:
+		break;
+	}
+	pr_out_vdev_handle_end(vdpa);
+}
+
+static int cmd_dev_vstats_show_cb(const struct nlmsghdr *nlh, void *data)
+{
+	struct genlmsghdr *genl = mnl_nlmsg_get_payload(nlh);
+	struct nlattr *tb[VDPA_ATTR_MAX + 1] = {};
+	struct vdpa *vdpa = data;
+
+	mnl_attr_parse(nlh, sizeof(*genl), attr_cb, tb);
+	if (!tb[VDPA_ATTR_DEV_NAME] || !tb[VDPA_ATTR_DEV_ID])
+		return MNL_CB_ERROR;
+	pr_out_dev_vstats(vdpa, tb, nlh);
+	return MNL_CB_OK;
+}
+
+static void cmd_dev_vstats_help(void)
+{
+	fprintf(stderr, "Usage: vdpa dev vstats show DEV [qidx QUEUE_INDEX]\n");
+}
+
+static int config_show_cb(const struct nlmsghdr *nlh, void *data)
+{
+	struct genlmsghdr *genl = mnl_nlmsg_get_payload(nlh);
+	struct nlattr *tb[VDPA_ATTR_MAX + 1] = {};
+	uint64_t features;
+	uint16_t max_vqs;
+
+	mnl_attr_parse(nlh, sizeof(*genl), attr_cb, tb);
+	if (!tb[VDPA_ATTR_DEV_NAME] || !tb[VDPA_ATTR_DEV_ID] ||
+	    !tb[VDPA_ATTR_DEV_NEGOTIATED_FEATURES] ||
+	    !tb[VDPA_ATTR_DEV_NET_CFG_MAX_VQP])
+		return MNL_CB_ERROR;
+
+        features = mnl_attr_get_u64(tb[VDPA_ATTR_DEV_NEGOTIATED_FEATURES]);
+	max_vqs = 2 * mnl_attr_get_u16(tb[VDPA_ATTR_DEV_NET_CFG_MAX_VQP]);
+	if (features & BIT(VIRTIO_NET_F_CTRL_VQ))
+		*(int *)data = max_vqs;
+	else
+		*(int *)data = -1;
+
+	return MNL_CB_OK;
+}
+
+static int get_dev_config(struct vdpa *vdpa, char *argv[], int *cvqidx)
+{
+	uint16_t flags = NLM_F_REQUEST | NLM_F_ACK;
+	struct nlmsghdr *nlh;
+	int err;
+
+	nlh = mnlu_gen_socket_cmd_prepare(&vdpa->nlg, VDPA_CMD_DEV_CONFIG_GET,
+					  flags);
+	err = vdpa_argv_parse_put(nlh, vdpa, 1, argv,
+				  VDPA_OPT_VDEV_HANDLE, 0);
+	if (err)
+		return err;
+
+	err = mnlu_gen_socket_sndrcv(&vdpa->nlg, nlh, config_show_cb, cvqidx);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+static int cmd_dev_vstats_show(struct vdpa *vdpa, int argc, char **argv)
+{
+	uint16_t flags = NLM_F_REQUEST | NLM_F_ACK;
+	struct nlmsghdr *nlh;
+	int err;
+
+	if (argc != 1 && argc != 3) {
+		cmd_dev_vstats_help();
+		return -EINVAL;
+	}
+
+	err = get_dev_config(vdpa, argv, &vdpa->cvq_index);
+	if (err)
+		return err;
+
+	nlh = mnlu_gen_socket_cmd_prepare(&vdpa->nlg, VDPA_CMD_DEV_STATS_GET,
+					  flags);
+
+	err = vdpa_argv_parse_put(nlh, vdpa, argc, argv,
+				  VDPA_OPT_VDEV_HANDLE, VDPA_OPT_QUEUE_INDEX);
+	if (err)
+		return err;
+
+	pr_out_section_start(vdpa, "vstats");
+	err = mnlu_gen_socket_sndrcv(&vdpa->nlg, nlh, cmd_dev_vstats_show_cb, vdpa);
+	pr_out_section_end(vdpa);
+	return 0;
+}
+
+static int cmd_dev_vstats(struct vdpa *vdpa, int argc, char **argv)
+{
+	if (argc < 1) {
+		cmd_dev_vstats_help();
+		return -EINVAL;
+	}
+
+	if (matches(*argv, "help") == 0) {
+		cmd_dev_vstats_help();
+		return 0;
+	} else if (matches(*argv, "show") == 0) {
+		return cmd_dev_vstats_show(vdpa, argc - 1, argv + 1);
+	}
+	fprintf(stderr, "Command \"%s\" not found\n", *argv);
+	return -ENOENT;
+}
+
 static int cmd_dev(struct vdpa *vdpa, int argc, char **argv)
 {
 	if (!argc)
@@ -836,6 +1026,8 @@ static int cmd_dev(struct vdpa *vdpa, int argc, char **argv)
 		return cmd_dev_del(vdpa, argc - 1, argv + 1);
 	} else if (matches(*argv, "config") == 0) {
 		return cmd_dev_config(vdpa, argc - 1, argv + 1);
+	} else if (matches(*argv, "vstats") == 0) {
+		return cmd_dev_vstats(vdpa, argc - 1, argv + 1);
 	}
 	fprintf(stderr, "Command \"%s\" not found\n", *argv);
 	return -ENOENT;
-- 
2.35.1

