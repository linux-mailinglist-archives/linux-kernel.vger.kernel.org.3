Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB6D552A2F8
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 15:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346316AbiEQNOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 09:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347348AbiEQNOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 09:14:02 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52C4341321
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 06:14:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eIHebVchMPWmgqQpfO35/Hm8dN+m9XTNtwn5HqRcr+Ts4egbI85qc+F8GQUltGGidxTQ1dxtlb2fLHLUdhqowvJ93dKhMw83iJeLurODvi5wcp+v4zHY/NOTAvKjkjHqcbg/ElPj/DscGdEA6liM+sVm4dA4JNsQZ23ShEQLb2Qzp4BZ58ksNxyPgRiUGN89PJQ0JKkBbjX6Pv+T01W10dAaNA4GHPCSiaHjTMxPmztUJzBCnGOvu/0Zed5eZmB7ehkX7WOLbqlFDgrA/Mxd7fMj9ZmHhrCheGFtxOTslY/4xXA6xNTL25xB2K3vu4k3Izc1z5Ba2Pqkg7E/XlGRSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s7Xp3B/QEmKF+xyKiS8NaVKV7cE5BcTn6B5Wl3+d+YM=;
 b=Kr95NjDptYUDPH82reBchvi7Vr+WXj3aD7BxsBfx5wy+NF+4//f+y5mD5Zi0/yNK4fEVWtP2PFtDGIeUeh6Z/pmaisXJT/ROv5iENxuA/ZrgO35PDwEXe+MXrXzWXoDM3useShY38UF45XnApH0rl7QrRWqG5+NrmNXg6jxD6PmIGNb3lLn8CLuTlCntRJB3o2dQdC3mWqggJdnpy3NY1lFYIrvbEkwP21ezw+hgAzPWU/R23RylA8b9Qi/TqXoHIJnTvICK5x3LtkNz0Y8PK7V/MqJkZBFw1bsaO/79I9TCidBa28eTZ3MZNCFlRBjFeK3VtAdMB46P34D1iC19Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s7Xp3B/QEmKF+xyKiS8NaVKV7cE5BcTn6B5Wl3+d+YM=;
 b=lXjQa/FGBuJ3z8zL0sHSswVeTtCSvXHNNSA+CBNBmw2rjPg53h+KH2Al3DL3TQgbsJi1rMKQprTeEgxkB/3NCrw6g8sTc5F7+EgIrKHmexWrDA/93JF/EcBcmOK4dHKUquVc4CqGTtS63HxEc0mhkg3ZYLhjdLvNsbI1QivCrr4NqiB/7Q8REZlyspA14EVOEMgEZ2l9OH2nl6mlZnAo/PuQVNJv/r9TxupMIVs/inua8x6OYK/vdWxLMne4+ddO+EPGIuborOziFhk3PTrFta2HqAQ0VIpbqhr5o9415pPI4SmvPPJpAs6wTaH3ZysQ630HiJYOyzcUh1BqGP6efA==
Received: from BN0PR04CA0054.namprd04.prod.outlook.com (2603:10b6:408:e8::29)
 by DM4PR12MB5261.namprd12.prod.outlook.com (2603:10b6:5:398::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Tue, 17 May
 2022 13:13:59 +0000
Received: from BN8NAM11FT062.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e8:cafe::c3) by BN0PR04CA0054.outlook.office365.com
 (2603:10b6:408:e8::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.15 via Frontend
 Transport; Tue, 17 May 2022 13:13:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 BN8NAM11FT062.mail.protection.outlook.com (10.13.177.34) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5250.13 via Frontend Transport; Tue, 17 May 2022 13:13:58 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Tue, 17 May
 2022 13:13:58 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 17 May
 2022 06:13:57 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.986.22 via Frontend Transport; Tue, 17 May
 2022 06:13:55 -0700
From:   Eli Cohen <elic@nvidia.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>
CC:     <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <si-wei.liu@oracle.com>,
        Eli Cohen <elic@nvidia.com>
Subject: [PATCH v7 2/5] vdpa: Add support for querying vendor statistics
Date:   Tue, 17 May 2022 16:13:45 +0300
Message-ID: <20220517131348.498421-3-elic@nvidia.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220517131348.498421-1-elic@nvidia.com>
References: <20220517131348.498421-1-elic@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 58f64a6e-8968-4137-dd8d-08da38071aa1
X-MS-TrafficTypeDiagnostic: DM4PR12MB5261:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB5261B46E5A5ABF757A960778ABCE9@DM4PR12MB5261.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nQpwYcdyk6oxXra441qvmuxO812JhEh8CYz1/qUnwmE/Wk2dSGKS9wpZ1hKVb2hHbUxZlPB1HK9hL1znNsuQLILEHLEdGd9Y7TVZHvvFrSUeQWvMdom480QJfoKqqzXrbLEilSAkFa+h7EZBKbuSRlVMmcP/sPC8sL9CRtSMd23bbxxak5uQE93O6Qt+DkeNtP0ayalClEx+m+9fQpn7iyRpK5x6V4A9/72mlq3HrtxsmchQqRj/9GS8FmVdRKqFFaq4PNlH2Tj2GhODv7QXoB+evhOCm6vMZrfidyGFAY1xzWLJsNFEvd7X1rVcZzdGTpT2mwTcuVpuDa+axpgxYbatirYVPDIMwG1VUlPPIWM6iz0oJBQM5IKe7GnVtOm8Y2L5Mu+eQr/hx7HLCL3HQzV/cKPrk/P6++7SWtCpEOhXCs+zrr6aZxuKC0vYELJ8jLsto5N86AoPS2MHL4QAX64zBBWLeMVQYt6zkGMFbTOaIswMb7Xi+Z3EzoKTvcyukALwHQCFG4VcFUtA8DH9/899yh1nf3HwLKCONOqAUx3nxGsux5U72YxUpWn+w5SzODDoLspIfGG60bcHzCR3zBhwYJT+npn84H3E/h/a8uiIydDWBX7WcJMtDJlx/U7GwWYXWGD+ssx29G9+r/4NLTKo5UE8Le9k2DNtQyqv1bzFD7MIILhe9Z5r1Yzgl75hSg6eZYqvBFG/Mp18kDfmrA==
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(81166007)(6666004)(2906002)(426003)(356005)(336012)(47076005)(83380400001)(186003)(1076003)(82310400005)(316002)(54906003)(110136005)(36860700001)(7696005)(40460700003)(508600001)(70586007)(70206006)(5660300002)(4326008)(8676002)(8936002)(26005)(2616005)(107886003)(36756003)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2022 13:13:58.7370
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58f64a6e-8968-4137-dd8d-08da38071aa1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT062.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5261
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
 drivers/vdpa/vdpa.c       | 160 ++++++++++++++++++++++++++++++++++++++
 include/linux/vdpa.h      |   3 +
 include/uapi/linux/vdpa.h |   6 ++
 3 files changed, 169 insertions(+)

diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index fac89a0d8178..1b810961ccc3 100644
--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -914,6 +914,106 @@ vdpa_dev_config_fill(struct vdpa_device *vdev, struct sk_buff *msg, u32 portid,
 	return err;
 }
 
+static int vdpa_fill_stats_rec(struct vdpa_device *vdev, struct sk_buff *msg,
+			       struct genl_info *info, u32 index)
+{
+	struct virtio_net_config config = {};
+	u64 features;
+	u16 max_vqp;
+	u8 status;
+	int err;
+
+	status = vdev->config->get_status(vdev);
+	if (!(status & VIRTIO_CONFIG_S_FEATURES_OK)) {
+		NL_SET_ERR_MSG_MOD(info->extack, "feature negotiation not complete");
+		return -EAGAIN;
+	}
+	vdpa_get_config(vdev, 0, &config, sizeof(config));
+
+	max_vqp = le16_to_cpu(config.max_virtqueue_pairs);
+	if (nla_put_u16(msg, VDPA_ATTR_DEV_NET_CFG_MAX_VQP, max_vqp))
+		return -EMSGSIZE;
+
+	features = vdev->config->get_driver_features(vdev);
+	if (nla_put_u64_64bit(msg, VDPA_ATTR_DEV_NEGOTIATED_FEATURES,
+			      features, VDPA_ATTR_PAD))
+		return -EMSGSIZE;
+
+	if (nla_put_u32(msg, VDPA_ATTR_DEV_QUEUE_INDEX, index))
+		return -EMSGSIZE;
+
+	err = vdev->config->get_vendor_vq_stats(vdev, index, msg, info->extack);
+	if (err)
+		return err;
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
@@ -995,6 +1095,60 @@ vdpa_nl_cmd_dev_config_get_dumpit(struct sk_buff *msg, struct netlink_callback *
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
@@ -1035,6 +1189,12 @@ static const struct genl_ops vdpa_nl_ops[] = {
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

