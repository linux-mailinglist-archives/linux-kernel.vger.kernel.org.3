Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 240915213B9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 13:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240998AbiEJLby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 07:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240935AbiEJLbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 07:31:44 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52218200F64
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 04:27:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YCarfAuLyKD0mK3fAUEhrljoXUZwt0GXZQJGqyf9/uZAftmDAZQHcjiugDBdyfJpBei8spXTResHC6HiuoXORw8XLjg0CnK+PB8Xe39fRIxpTTPfWDR1iYhAHakqJnyxcl9h5TMMxXW1GcdvgbP6xMnpmotMydMhIaL+yM4yYbbICGADDn3dcFwOfwRBcsRQcDQrJQgbf4fWCvQXa6rx4jBUsvgEHpUO9sCRQ8CfrWH0HoZiyQ3Oop9TmTiNLQTxrZSS1bjP92MdKZAWL1JujYyP4nA1SvPicy8GOBqoRGBM8KhTlScZjBxivINz5orvcvAc3I5jW4Jao2/Nw5T18A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JK9ABtKU1pWJk8TRA4/EmRxFs6pzKzWskwukOBQle3E=;
 b=aijy99+Fa9IYRrIDM5nbY3o3m5m/wsDXwhBDIQZDo6NKMpfg9f2WaowM8vKpbvp2q3HH3/VQh6Ck9Gwg63MeozjxZRF21cqbETXYgPvxNFN8Vt1qSz3kqi6U2L9QuLFG0rxeb6AjXJdce6vTCqkdof6HW2F1Ek927Mu5aai05rAlodxhVkJtF9PC9BhK3WGij3QkqN8dhly7yO9bC6U02Nw3w6da8YWA5tcZ5eoxxuAHo0RxGS5qFUJ+CLIpViFLVoCdLaKd+rxbKd0HSUppWVL3uuVgJPWtqoJnkEGBeU/oraiCEJII+AnW8qKVldjZtEPsv5OwFLKPiacfDTL7+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JK9ABtKU1pWJk8TRA4/EmRxFs6pzKzWskwukOBQle3E=;
 b=BSepboYCmA0dJpGX6rBlzG5k4QuE3EnA/RjawVVFQEuojZY0tBWdkqOGgOoGyPBkjC8/IbmvauUjqSb3sKX1kAbAgiUmgrL6HeXyxDaP4YwWH0iPEmXcD8BXXziOn+jnITevztnzCHVNb5lGCk4sJIFSAg2YaT4FwGBCyANKUcr6RIlg1Q1q7sTWb1RmGvFQUz8FHwiQY5v9UQzc7WLkuvPAf7il9nO2IoqW7pgytB1CHu1HiYfnTnK/ngUVB7mkdds8x1/vO4TbXkBTKqgyls23tcfJOA/vDU7Y5uHF/fb81n4J3fhAb0wZwdVdPImfChnE8kKSGby/yIHUxmwmwA==
Received: from MW3PR05CA0015.namprd05.prod.outlook.com (2603:10b6:303:2b::20)
 by DM6PR12MB4340.namprd12.prod.outlook.com (2603:10b6:5:2a8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Tue, 10 May
 2022 11:27:45 +0000
Received: from CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2b:cafe::94) by MW3PR05CA0015.outlook.office365.com
 (2603:10b6:303:2b::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13 via Frontend
 Transport; Tue, 10 May 2022 11:27:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 CO1NAM11FT056.mail.protection.outlook.com (10.13.175.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5227.15 via Frontend Transport; Tue, 10 May 2022 11:27:44 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Tue, 10 May
 2022 11:27:44 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 10 May
 2022 04:27:43 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.986.22 via Frontend Transport; Tue, 10 May
 2022 04:27:41 -0700
From:   Eli Cohen <elic@nvidia.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>
CC:     <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <si-wei.liu@oracle.com>,
        Eli Cohen <elic@nvidia.com>
Subject: [PATCH v5 2/3] vdpa: Add support for querying vendor statistics
Date:   Tue, 10 May 2022 14:27:33 +0300
Message-ID: <20220510112734.205669-3-elic@nvidia.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220510112734.205669-1-elic@nvidia.com>
References: <20220510112734.205669-1-elic@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b899484d-af58-45cb-81d2-08da32781a66
X-MS-TrafficTypeDiagnostic: DM6PR12MB4340:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4340298C43C5864A3D38352AABC99@DM6PR12MB4340.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PhyxdRoczrq81GJsjQw8d4RgXBkFry1U92OItPaT/UP+76KtIb+kR3DIPHaPPJhSp/E0tnyx3ZpnambUliHZXXQIskE2Ono0AqLskOOF/zrkv6FwQ23fwivFahMdxObkQbdWi0hSEIH3ar+SEyoHG1zkBXCNCl7Drs/IoN9ewUBmov9M88+rulgcEJraXh+F9p5JDV21qEzZ37FabowX1l0AiqmhRZaAQeTvWLVKbqe2wPOpm6By3pPq2txAZlQ+ibm8IC6MEBd464SPU7+FOrz03NY9XOjTw4SFCZbIj7m1fxElrcn00GbOrBRRBf8H8WUJfzDVyaROeOnI3XggSHFXH8FFWgB3/b2N2uaSChrSRCqxk1ZALy+0cm6T+bDl/yyXa7we4Z5a+7xi/6+yCos/hR2YCiCFeSjWnLAjnOe60Jf/vb//Vas5RP8ZDUIC5eAZGJMcJc8e2OTArriELiopcqcEQ8oPyVr2ETk9sZ6uRw+mu3ciPwKnC/O9i2trsHfK8Ve/6SQjKdZURr7x3Nr0qL+9VhxWISlPZ/kNEAbHiGm0UKqaR/bKRLevgNTihRd+Ai0kLt2xoBE8gY/yPkDPl5yDYdLHzAirr1eRyB5SHmduFQYj2UiD6nmlAzHmRih9BCfC3epd6CgA1wa/CuW/oBLAveeX2LZBuhnDJwFP/xnZPj0o9b7BhY1mkCmZlEaycAFijT3ZBsKVUWsgBA==
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(6666004)(36756003)(316002)(36860700001)(110136005)(1076003)(2616005)(54906003)(186003)(426003)(47076005)(83380400001)(356005)(107886003)(336012)(40460700003)(82310400005)(4326008)(26005)(86362001)(8676002)(81166007)(70586007)(70206006)(8936002)(508600001)(7696005)(2906002)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 11:27:44.5642
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b899484d-af58-45cb-81d2-08da32781a66
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4340
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allows to read vendor statistics of a vdpa device. The specific
statistics data are received from the upstream driver in the form of an
(attribute name, attribute value) pairs.

An example of statistics for mlx5_vdpa device are:

received_desc - number of descriptors received by the virtqueue
completed_desc - number of descriptors completed by the virtqueue

A descriptor using indirect buffers is still counted as 1. In addition,
N chained descriptors are counted correctly N times as one would expect.

A new callback was added to vdpa_config_ops which provides the means for
the vdpa driver to return statistics results.

The interface allows for reading all the supported virtqueues, including
the control virtqueue if it exists.

Below are some examples taken from mlx5_vdpa which are introduced in the
following patch:

1. Read statistics for the virtqueue at index 1

$ vdpa dev vstats show vdpa-a qidx 1
vdpa-a:
queue_type tx queue_index 1 received_desc 3844836 completed_desc 3844836

2. Read statistics for the virtqueue at index 32
$ vdpa dev vstats show vdpa-a qidx 32
vdpa-a:
queue_type control_vq queue_index 32 received_desc 62 completed_desc 62

3. Read statisitics for the virtqueue at index 0 with json output
$ vdpa -j dev vstats show vdpa-a qidx 0
{"vstats":{"vdpa-a":{
"queue_type":"rx","queue_index":0,"name":"received_desc","value":417776,\
 "name":"completed_desc","value":417548}}}

4. Read statistics for the virtqueue at index 0 with preety json output
$ vdpa -jp dev vstats show vdpa-a qidx 0
{
    "vstats": {
        "vdpa-a": {

            "queue_type": "rx",
            "queue_index": 0,
            "name": "received_desc",
            "value": 417776,
            "name": "completed_desc",
            "value": 417548
        }
    }
}

Signed-off-by: Eli Cohen <elic@nvidia.com>
---
v4 -> v5:
1. Remove unused macro definition
2. Avoid policy on queue index. Do validty check in the implementation.
3. Restrict to VIRTIO_ID_NET devices only.
4. Improve netlink error messages.


 drivers/vdpa/vdpa.c       | 140 ++++++++++++++++++++++++++++++++++++++
 include/linux/vdpa.h      |   3 +
 include/uapi/linux/vdpa.h |   6 ++
 3 files changed, 149 insertions(+)

diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index fac89a0d8178..91f4c13c7c7c 100644
--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -914,6 +914,86 @@ vdpa_dev_config_fill(struct vdpa_device *vdev, struct sk_buff *msg, u32 portid,
 	return err;
 }
 
+static int vdpa_fill_stats_rec(struct vdpa_device *vdev, struct sk_buff *msg,
+			       struct genl_info *info, u32 index)
+{
+	int err;
+
+	err = vdev->config->get_vendor_vq_stats(vdev, index, msg, info->extack);
+	if (err)
+		return err;
+
+	if (nla_put_u32(msg, VDPA_ATTR_DEV_QUEUE_INDEX, index))
+		return -EMSGSIZE;
+
+	return 0;
+}
+
+static int vendor_stats_fill(struct vdpa_device *vdev, struct sk_buff *msg,
+			     struct genl_info *info, u32 index)
+{
+	int err;
+
+	if (!vdev->config->get_vendor_vq_stats)
+		return -EOPNOTSUPP;
+
+	err = vdpa_fill_stats_rec(vdev, msg, info, index);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+static int vdpa_dev_vendor_stats_fill(struct vdpa_device *vdev,
+				      struct sk_buff *msg,
+				      struct genl_info *info, u32 index)
+{
+	u32 device_id;
+	void *hdr;
+	int err;
+	u32 portid = info->snd_portid;
+	u32 seq = info->snd_seq;
+	u32 flags = 0;
+
+	hdr = genlmsg_put(msg, portid, seq, &vdpa_nl_family, flags,
+			  VDPA_CMD_DEV_VSTATS_GET);
+	if (!hdr)
+		return -EMSGSIZE;
+
+	if (nla_put_string(msg, VDPA_ATTR_DEV_NAME, dev_name(&vdev->dev))) {
+		err = -EMSGSIZE;
+		goto undo_msg;
+	}
+
+	device_id = vdev->config->get_device_id(vdev);
+	if (nla_put_u32(msg, VDPA_ATTR_DEV_ID, device_id)) {
+		err = -EMSGSIZE;
+		goto undo_msg;
+	}
+
+	switch (device_id) {
+	case VIRTIO_ID_NET:
+		if (index > VIRTIO_NET_CTRL_MQ_VQ_PAIRS_MAX) {
+			NL_SET_ERR_MSG_MOD(info->extack, "queue index excceeds max value");
+			err = -ERANGE;
+			break;
+		}
+
+		err = vendor_stats_fill(vdev, msg, info, index);
+		break;
+	default:
+		err = -EOPNOTSUPP;
+		break;
+	}
+	genlmsg_end(msg, hdr);
+
+	return err;
+
+undo_msg:
+	genlmsg_cancel(msg, hdr);
+	return err;
+}
+
 static int vdpa_nl_cmd_dev_config_get_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct vdpa_device *vdev;
@@ -995,6 +1075,60 @@ vdpa_nl_cmd_dev_config_get_dumpit(struct sk_buff *msg, struct netlink_callback *
 	return msg->len;
 }
 
+static int vdpa_nl_cmd_dev_stats_get_doit(struct sk_buff *skb,
+					  struct genl_info *info)
+{
+	struct vdpa_device *vdev;
+	struct sk_buff *msg;
+	const char *devname;
+	struct device *dev;
+	u32 index;
+	int err;
+
+	if (!info->attrs[VDPA_ATTR_DEV_NAME])
+		return -EINVAL;
+
+	if (!info->attrs[VDPA_ATTR_DEV_QUEUE_INDEX])
+		return -EINVAL;
+
+	devname = nla_data(info->attrs[VDPA_ATTR_DEV_NAME]);
+	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	index = nla_get_u32(info->attrs[VDPA_ATTR_DEV_QUEUE_INDEX]);
+	mutex_lock(&vdpa_dev_mutex);
+	dev = bus_find_device(&vdpa_bus, NULL, devname, vdpa_name_match);
+	if (!dev) {
+		NL_SET_ERR_MSG_MOD(info->extack, "device not found");
+		err = -ENODEV;
+		goto dev_err;
+	}
+	vdev = container_of(dev, struct vdpa_device, dev);
+	if (!vdev->mdev) {
+		NL_SET_ERR_MSG_MOD(info->extack, "unmanaged vdpa device");
+		err = -EINVAL;
+		goto mdev_err;
+	}
+	err = vdpa_dev_vendor_stats_fill(vdev, msg, info, index);
+	if (err)
+		goto mdev_err;
+
+	err = genlmsg_reply(msg, info);
+
+	put_device(dev);
+	mutex_unlock(&vdpa_dev_mutex);
+
+	return err;
+
+mdev_err:
+	put_device(dev);
+dev_err:
+	nlmsg_free(msg);
+	mutex_unlock(&vdpa_dev_mutex);
+	return err;
+}
+
 static const struct nla_policy vdpa_nl_policy[VDPA_ATTR_MAX + 1] = {
 	[VDPA_ATTR_MGMTDEV_BUS_NAME] = { .type = NLA_NUL_STRING },
 	[VDPA_ATTR_MGMTDEV_DEV_NAME] = { .type = NLA_STRING },
@@ -1035,6 +1169,12 @@ static const struct genl_ops vdpa_nl_ops[] = {
 		.doit = vdpa_nl_cmd_dev_config_get_doit,
 		.dumpit = vdpa_nl_cmd_dev_config_get_dumpit,
 	},
+	{
+		.cmd = VDPA_CMD_DEV_VSTATS_GET,
+		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
+		.doit = vdpa_nl_cmd_dev_stats_get_doit,
+		.flags = GENL_ADMIN_PERM,
+	},
 };
 
 static struct genl_family vdpa_nl_family __ro_after_init = {
diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
index 8943a209202e..2ae8443331e1 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -276,6 +276,9 @@ struct vdpa_config_ops {
 			    const struct vdpa_vq_state *state);
 	int (*get_vq_state)(struct vdpa_device *vdev, u16 idx,
 			    struct vdpa_vq_state *state);
+	int (*get_vendor_vq_stats)(struct vdpa_device *vdev, u16 idx,
+				   struct sk_buff *msg,
+				   struct netlink_ext_ack *extack);
 	struct vdpa_notification_area
 	(*get_vq_notification)(struct vdpa_device *vdev, u16 idx);
 	/* vq irq is not expected to be changed once DRIVER_OK is set */
diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
index 1061d8d2d09d..25c55cab3d7c 100644
--- a/include/uapi/linux/vdpa.h
+++ b/include/uapi/linux/vdpa.h
@@ -18,6 +18,7 @@ enum vdpa_command {
 	VDPA_CMD_DEV_DEL,
 	VDPA_CMD_DEV_GET,		/* can dump */
 	VDPA_CMD_DEV_CONFIG_GET,	/* can dump */
+	VDPA_CMD_DEV_VSTATS_GET,
 };
 
 enum vdpa_attr {
@@ -46,6 +47,11 @@ enum vdpa_attr {
 	VDPA_ATTR_DEV_NEGOTIATED_FEATURES,	/* u64 */
 	VDPA_ATTR_DEV_MGMTDEV_MAX_VQS,		/* u32 */
 	VDPA_ATTR_DEV_SUPPORTED_FEATURES,	/* u64 */
+
+	VDPA_ATTR_DEV_QUEUE_INDEX,              /* u32 */
+	VDPA_ATTR_DEV_VENDOR_ATTR_NAME,		/* string */
+	VDPA_ATTR_DEV_VENDOR_ATTR_VALUE,        /* u64 */
+
 	/* new attributes must be added above here */
 	VDPA_ATTR_MAX,
 };
-- 
2.35.1

