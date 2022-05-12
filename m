Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61078524516
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 07:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349980AbiELFkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 01:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234095AbiELFkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 01:40:16 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0758621A957
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 22:40:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RLuvM+miyljRfIdklrWwBvkbcz7b8TdK+RZfaZ+Cpve/rFJ4HmsSsRphgxY+NiZ1bBjhZWFgC3FdnU4sqlIymnyZ3AjmNQZ6+oM51+MjhC+V6rHPbgl+dxdQGq5W4PJ8J6kz4UwxWNHi5y6Mcu5oKOT4igt9+vXnfdV4FEJObXmvxI3b2J5nWq5YzJ82xA4CaLnFjkcUpBeZXHtDNL0tnFiz74zsqExMZkLGvAUrajkpHdJQAMI/jkeIAA3yRr+YUjTCQ7qlg4H1NReEJ7OIeUKnmJXzEBA7vTPHK0XSYyUAeVBsq3YkulLn3gYMe8HYguRS6kK2GyjcjIw/EkkS1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZPYKiPh3hQfHI/Yi6mGWTDDFDghfJBk/blSEIoFCtTQ=;
 b=H0YAJ3uBkakV2a4abqM4LcxoZTpIc5bFs71KKqpZCzSPhX3G2KAIvNNMjkVINDimOE8AhWC7T1vrhGFEsAOGwKkN8w59ow9+/ojX0UkTA73IRBxRPFnDRsoPbXMS+akqXAad0SU/1pXaMyo56X4HAu4h+YSpCoIqoaJkchqOkJ19th2PGZaMsC3N146Q/1mqDZm+UOnNGiM6/Ry0aHGx4/D9QRgDUjXm4vzVE9i+60fCe6R5bQhYM6TG+a7TxxS0kI1lvxPHKxZf1BYA+7o2BYUQLjn4S65a4OTTXjnhRgh/hKWG40QiPJ3DwRHye7WzToKzX43foiOCU8FPGocgog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZPYKiPh3hQfHI/Yi6mGWTDDFDghfJBk/blSEIoFCtTQ=;
 b=QC/IfMFib2dh97DjVbAbT+XxOQLO9loFsDn1gOKhNKm18amRH9fyKKX7Oic0n4Ud4KVU30Qv3IsxPd9Rl7CD2ieuH5Uv2XyCqkp9F26WtO/1ifMwdQ3DQF9nQ+o3iLwb4fpW9BWAyHneU/GPZ81aXgPe/0tIOfCUyo7OkzQRFM0SqJ6QxrMLgDbDXJBaP0WJW+i1tv1lpsA6AjJjhiz4UgTvmxLfZM/K1g15Z6c658WGllkFcAhkHPvNMjr5h/7OWrBR8t+c78TaeanCIDtsb8Ztt5eETlRVFOhKuUaoeIvBr5/xCbpiERAB3DjdEOoO9msMieC+m+HQS4cwAAwxng==
Received: from MW4PR03CA0259.namprd03.prod.outlook.com (2603:10b6:303:b4::24)
 by SA0PR12MB4382.namprd12.prod.outlook.com (2603:10b6:806:9a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Thu, 12 May
 2022 05:40:13 +0000
Received: from CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b4:cafe::c6) by MW4PR03CA0259.outlook.office365.com
 (2603:10b6:303:b4::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13 via Frontend
 Transport; Thu, 12 May 2022 05:40:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 CO1NAM11FT047.mail.protection.outlook.com (10.13.174.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5250.13 via Frontend Transport; Thu, 12 May 2022 05:40:12 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 DRHQMAIL107.nvidia.com (10.27.9.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.32; Thu, 12 May 2022 05:40:11 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 11 May 2022 22:40:11 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Wed, 11 May 2022 22:40:09 -0700
From:   Eli Cohen <elic@nvidia.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>
CC:     <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <si-wei.liu@oracle.com>,
        Eli Cohen <elic@nvidia.com>
Subject: [PATCH v1 for reference] vdpa: Add support for reading vdpa device statistics
Date:   Thu, 12 May 2022 08:40:06 +0300
Message-ID: <20220512054006.3509356-1-elic@nvidia.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e3db05a8-8428-46eb-9330-08da33d9e29f
X-MS-TrafficTypeDiagnostic: SA0PR12MB4382:EE_
X-Microsoft-Antispam-PRVS: <SA0PR12MB438212C00154D50056555ED0ABCB9@SA0PR12MB4382.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lo2AzehKLcBeMilUOsNg/Djy4sleXWxftgOw6mybql/gcdjKTk2M1CTyC8XxInj37d0loCxI+nmKikublTWSe9+V7eTxNFhkgY256oZSUMXUDEtuvYh3StO8Su9WWdch4Sm7sqecoD4orXlKbwbuGWSFHuz9LLu8nTUtIWUSZukO1ZHlwMZkLCsrjGDB7VVEj5m0ysitOUqBNSFhf8gNzxaqSI/Hwu6QOc+CAzMk2rmNcmEGUbZk1YmpMxdNhsbq0YS857x0yYYZoBGmjkIZDr+zAe6tX8upCoYSqIpg/z0pyb3iXYXwzh7TL8ccT4FlRjfCzIKPTLLaq9soeCcs92FJg7HqacykUkvtGam5ZXj8Vzs0vOx3lBgzxhAxRib5qjrItIOMJLRASFsyoYQh+Loc7rn8+RbBAO77K9AN6mxxiaNvJfcSwB0BCDBikqO931VGbqBafX87Bxk7P5Sxtc+GcnD3a8lhhJExS5grkbmuociElK+qLP65YcoeZ/UJF/XCdotaRe4GpvuRaXPS19P8ioNh2/hOLbgmDmsD8EYdrkVmfOs3ecQypMZpPEMbBJnebZiKDSjREfninx7iULKvLEGfwxg0coqiiLJIkCWPZSw2ErSPXsVgB+9Jq6u+S5Dv42HsnWPU1Qe/GKci8Wks9tkkNqNLe0I0QbjJpgC3oKRaR2eCauwx98Ehp0CwgarZslxrA07qoinEnqD/pg==
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(86362001)(7696005)(8936002)(6666004)(508600001)(2906002)(81166007)(356005)(83380400001)(36860700001)(40460700003)(5660300002)(107886003)(2616005)(26005)(336012)(47076005)(1076003)(186003)(426003)(54906003)(70206006)(70586007)(110136005)(316002)(82310400005)(36756003)(8676002)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2022 05:40:12.8281
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3db05a8-8428-46eb-9330-08da33d9e29f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4382
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Read statistics of a vdpa device. The specific data is a received as a
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

Issue: 2888554
Change-Id: I137115fd3db258c5b95fa53dabc2cd4c364a174b
Signed-off-by: Eli Cohen <elic@nvidia.com>
---
 vdpa/include/uapi/linux/vdpa.h |   6 ++
 vdpa/vdpa.c                    | 153 +++++++++++++++++++++++++++++++++
 2 files changed, 159 insertions(+)

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
index 3ae1b78f4cac..4f217993c73b 100644
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
@@ -174,6 +176,17 @@ static int vdpa_argv_u16(struct vdpa *vdpa, int argc, char **argv,
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
 struct vdpa_args_metadata {
 	uint64_t o_flag;
 	const char *err_msg;
@@ -183,6 +196,7 @@ static const struct vdpa_args_metadata vdpa_args_required[] = {
 	{VDPA_OPT_VDEV_MGMTDEV_HANDLE, "management device handle not set."},
 	{VDPA_OPT_VDEV_NAME, "device name is not set."},
 	{VDPA_OPT_VDEV_HANDLE, "device name is not set."},
+	{VDPA_OPT_QUEUE_INDEX, "queue index is not set."},
 };
 
 static int vdpa_args_finding_required_validate(uint64_t o_required,
@@ -228,6 +242,8 @@ static void vdpa_opts_put(struct nlmsghdr *nlh, struct vdpa *vdpa)
 		mnl_attr_put_u16(nlh, VDPA_ATTR_DEV_NET_CFG_MTU, opts->mtu);
 	if (opts->present & VDPA_OPT_MAX_VQP)
 		mnl_attr_put_u16(nlh, VDPA_ATTR_DEV_NET_CFG_MAX_VQP, opts->max_vqp);
+	if (opts->present & VDPA_OPT_QUEUE_INDEX)
+		mnl_attr_put_u32(nlh, VDPA_ATTR_DEV_QUEUE_INDEX, opts->queue_idx);
 }
 
 static int vdpa_argv_parse(struct vdpa *vdpa, int argc, char **argv,
@@ -304,6 +320,14 @@ static int vdpa_argv_parse(struct vdpa *vdpa, int argc, char **argv,
 
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
@@ -594,6 +618,7 @@ static void cmd_dev_help(void)
 	fprintf(stderr, "                                                    [ max_vqp MAX_VQ_PAIRS ]\n");
 	fprintf(stderr, "       vdpa dev del DEV\n");
 	fprintf(stderr, "Usage: vdpa dev config COMMAND [ OPTIONS ]\n");
+	fprintf(stderr, "Usage: vdpa dev vstats COMMAND\n");
 }
 
 static const char *device_type_name(uint32_t type)
@@ -819,6 +844,132 @@ static int cmd_dev_config(struct vdpa *vdpa, int argc, char **argv)
 	return -ENOENT;
 }
 
+#define MAX_KEY_LEN 200
+/* 5 bytes for format */
+#define MAX_FMT_LEN (MAX_KEY_LEN + 5 + 1)
+
+static void pr_out_dev_net_vstats(const struct nlmsghdr *nlh)
+{
+	const char *name = NULL;
+	uint64_t features = 0;
+	char fmt[MAX_FMT_LEN];
+	uint16_t max_vqp = 0;
+	bool is_ctrl = false;
+	struct nlattr *attr;
+	uint16_t qidx = 0;
+	uint64_t v64;
+
+	mnl_attr_for_each(attr, nlh, sizeof(struct genlmsghdr)) {
+		switch (attr->nla_type) {
+		case VDPA_ATTR_DEV_NEGOTIATED_FEATURES:
+			features = mnl_attr_get_u64(attr);
+			break;
+		case VDPA_ATTR_DEV_NET_CFG_MAX_VQP:
+			max_vqp = mnl_attr_get_u16(attr);
+			break;
+		case VDPA_ATTR_DEV_QUEUE_INDEX:
+			qidx = mnl_attr_get_u16(attr);
+			is_ctrl = features & BIT(VIRTIO_NET_F_CTRL_VQ) && qidx == 2 * max_vqp;
+			if (!is_ctrl) {
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
+		pr_out_dev_net_vstats(nlh);
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
@@ -836,6 +987,8 @@ static int cmd_dev(struct vdpa *vdpa, int argc, char **argv)
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

