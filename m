Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32D8152476A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 09:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350193AbiELHvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 03:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351181AbiELHvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 03:51:15 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2044.outbound.protection.outlook.com [40.107.237.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF2E252B4
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 00:51:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oEQhy2D5IteO27hj912u1u1pAsWAMzNIzLJuK5ZCYSfLoiJ9pnxB8vBWPvC2bT0AO6qRqEZb2Xbw4zCSy9eSy4YOyQCPkrGoeEl8alACRBMfrQ3YIDBQeoHQRHFqTENTZFpBXYMURhX39DRsSvtf8Hgu3IWJmiezwzWHwm1XmYH+xOGzHYqNDDtGqY5MOztD/ELbL0ChPQCG7cFrOqbSgdFa6M/f3Abf8lX2aXHosG9ScIqFGLOOz0J0P+JvxnwUYtJVD+nzOGdrcwe3CKOyg7FRYN4Q6HlyGE+WoW2fGPs0zQKkSkkPeMa69fxHEmSXgrWPHRR1RhgDkPMeQq9IAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gboDTsKE01o1+b2sLmGkXtuDr3NFEN8qVqRx+iYtE58=;
 b=ZaEcu4U6xZQlXmxeXIKErlRkvKhm/lIMdmalfGJYgOX9LuSSgiO5ZINPm1conFp1nSWfqt2xP9/vCusGdUJzeM9MJ5kbnJj/JLvW9TRRsNUyogv1roSQ5KgHpcjviUv3sRi5QD82Ef6qpZMKflZPfFiQh3jqRrvDwD0SnWnmG+fT6qAEAJ0lIwnPGAZXAMX9MZFciUKNxRAIIraURJ2QKSlQMkOwvVLPdUADmQq4yUD7/NdiHnOOrATEe1+0uSaJF4myfCU9Zk+r7l9JToa0ZESy3VeXUOB5JkH+zFbjC86Ta8ALu88IN6OGTMh2GXYXOEd47HUq0FSYCJaemv4TCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gboDTsKE01o1+b2sLmGkXtuDr3NFEN8qVqRx+iYtE58=;
 b=pX2DT2I7WIC85+R9eoriPDyMbIYUnaS1hypL/w0TwAZClfAGhzdICKGc5ifrBt7j9L+yLDVMCJ1cuwbzakE23K1o5xcOnwfu57LGhaRNRdG61pv4oH7NcAoz3yf6XrNHunZcAc9S16z6+jokUylkvfO6vX6pvTY5J1aEp8Nd1NDKhXXRIbutbb0PP5ofYuYyCr3hRo15NFxhbmZi9e9Eftiwl/vK1RoCAzr+hrRbDh1I2OlQD3stoIL+G8rd0Op44+Uzqzqjrmjczy7AYqeV6RXMenquOy5QmMhq3WjxfuGhKdIngbIdXKKM46hVdUi7bnQFJdFPAwaE/VWXIE4PNg==
Received: from BN0PR04CA0163.namprd04.prod.outlook.com (2603:10b6:408:eb::18)
 by BY5PR12MB3779.namprd12.prod.outlook.com (2603:10b6:a03:1a7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Thu, 12 May
 2022 07:51:10 +0000
Received: from BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:eb:cafe::a5) by BN0PR04CA0163.outlook.office365.com
 (2603:10b6:408:eb::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13 via Frontend
 Transport; Thu, 12 May 2022 07:51:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 BN8NAM11FT056.mail.protection.outlook.com (10.13.177.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5250.13 via Frontend Transport; Thu, 12 May 2022 07:51:09 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 DRHQMAIL105.nvidia.com (10.27.9.14) with Microsoft SMTP Server (TLS) id
 15.0.1497.32; Thu, 12 May 2022 07:51:08 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 12 May 2022 00:51:08 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Thu, 12 May 2022 00:51:06 -0700
From:   Eli Cohen <elic@nvidia.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>
CC:     <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <si-wei.liu@oracle.com>,
        Eli Cohen <elic@nvidia.com>
Subject: [PATCH v6 2/4] vdpa: Add support for querying vendor statistics
Date:   Thu, 12 May 2022 10:50:58 +0300
Message-ID: <20220512075100.1715286-3-elic@nvidia.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220512075100.1715286-1-elic@nvidia.com>
References: <20220512075100.1715286-1-elic@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cb790163-e69d-455d-c917-08da33ec2d8f
X-MS-TrafficTypeDiagnostic: BY5PR12MB3779:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB37799C4E13326A5420569601ABCB9@BY5PR12MB3779.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hC4h5K6WexvypT13W1rwgp2eJEBirts0GwW9l8DGg7Kb7WKWpnPF9lCRSjc80QvGWh0Rq1WsxFSKhaPH81ETUVqCxLf7Ku+K7ZGz+xohxZjFa0hcWziX5/VKC1HcN+ZbTO/EICDU7myk4VNw9MDbwomeagFa8rSgthPEqPgdJweax0CekYAigzVv+E4VpcnLzeqqDbcol8SbOe8XKmcJK7q3YKLPtqLXPjbhINIKveJgSRlLwY6rzpJCEX6Niq0vIjfgPqKmnJTvYo08XDWOJUpsRIF71y2L7mjQepFkdFcpm1VGdVeV7NgDG9LXSOCSmVXmBjrYgLLKQXd9twxQdTpx/x6ZQ0xxFSSjoYI83yBW7Gj1YTVJvbmhPZ58AkjlWV71aZXdAvcGeNV5fDevxXzZWyPKANbyvUCkkGXkBiP7BbR9Gw4/bzBxYT3EkxEjtE5GNRnNS2FdC9+maod+VZOHW3O47xdITrMPoEcG4Bzrgm7bNJx81CaJRm6QdLAuhQVeSjAqn/fitmnwmeeBaNR9QyrRi8j/vGUGJOsqohaU1gAuanbO28A0i1q6v6uF6GtI7CscmnRyKWEGX70OwjUFSyFPSp9DdQ4qDWGDmGfOUrUuXzgTyn3p5C09nRegGVAU2buPJ493ic62avzNFGh9aqw5yXDFAG/FfxLQq9KpswGcuqIwZgfPejOw8Cyecv2LxjWx598rbyFJdRf8Ig==
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(70206006)(356005)(86362001)(6666004)(4326008)(70586007)(110136005)(8676002)(36860700001)(426003)(47076005)(54906003)(336012)(316002)(508600001)(40460700003)(186003)(1076003)(107886003)(81166007)(7696005)(2616005)(5660300002)(26005)(8936002)(83380400001)(82310400005)(2906002)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2022 07:51:09.4011
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb790163-e69d-455d-c917-08da33ec2d8f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3779
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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
 drivers/vdpa/vdpa.c       | 153 ++++++++++++++++++++++++++++++++++++++
 include/linux/vdpa.h      |   3 +
 include/uapi/linux/vdpa.h |   6 ++
 3 files changed, 162 insertions(+)

diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index fac89a0d8178..7ce417ff0ea8 100644
--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -914,6 +914,99 @@ vdpa_dev_config_fill(struct vdpa_device *vdev, struct sk_buff *msg, u32 portid,
 	return err;
 }
 
+static int vdpa_fill_stats_rec(struct vdpa_device *vdev, struct sk_buff *msg,
+			       struct genl_info *info, u32 index)
+{
+	u64 features;
+	u8 status;
+	int err;
+
+	status = vdev->config->get_status(vdev);
+	if (!(status & VIRTIO_CONFIG_S_FEATURES_OK)) {
+		NL_SET_ERR_MSG_MOD(info->extack, "feature negotiation not complete");
+		return -EAGAIN;
+	}
+
+	features = vdev->config->get_driver_features(vdev);
+	if (nla_put_u64_64bit(msg, VDPA_ATTR_DEV_NEGOTIATED_FEATURES,
+			      features, VDPA_ATTR_PAD))
+		return -EMSGSIZE;
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
@@ -995,6 +1088,60 @@ vdpa_nl_cmd_dev_config_get_dumpit(struct sk_buff *msg, struct netlink_callback *
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
@@ -1035,6 +1182,12 @@ static const struct genl_ops vdpa_nl_ops[] = {
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

