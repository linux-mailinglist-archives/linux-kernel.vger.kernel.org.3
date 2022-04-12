Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8AB4FE22F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 15:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355749AbiDLNR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 09:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355635AbiDLNPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 09:15:53 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2040.outbound.protection.outlook.com [40.107.212.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F5B41837E
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 06:04:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cDjQronwcxO6VJShDkmsIYbYPpVQDffwNXeQGsLFqQUcNP4c9JZDJN0y4EWgymldoaBRsP8Gfee0gbEcKklp0ffA9C2XUtab7FKvV8qaqBNbmOoH9btZOYJAx+uxtW7DCYh//kzqL4iqh1IEK/5fKY6LWA2Xikvj4QScXz7cA6C5GmD+57PKZ6uUMMBlvhT8RhilAaOQGYvn3T031eqXhROT33qp/lDszcqJlGja1B/pDP5REFqRfUtTLYpktJyJaSo6W08mA/bM4rwbC2FbyCx1f7V5rZMbZPB0wDgoGCJG5lnhlfSGKRqo5JvMl0vgbBwCtZWEk5qvk9HkctZ6Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LMRsLqdfwjWK6AXhPCfk5p10bJvcBL81nZDtFivhlLI=;
 b=jKzHdi31TPAnkX7AwTMb+vajeRq4+5hJ0Ea76wVoClWWj+YcgKgt9eaPgLy8YPgJziMlKGGnR6haDF2Zi2Bu4sX40hGngte4kz00K5HL6z7pCCXkzzacQ3oekXFgznPOiaYzYJUD1OET8e6Op1nrdpytdft3UaqQEo6X+O/HAaxkcJqQaVV2kuYSNab7kwhk4GsKveTIfaRkc+8GIXzk8KPaI/Kpw5rNecONe1WugP6VCRncAy0hxWX3YcYkmSVJUMaES2n/tT69+BB/5z+UJTxIx4pKqJUuG0dPFNIyXKWmJTuItfDpupPEbhy3xgmSYr7pQH9CECL7CxMnfo11Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LMRsLqdfwjWK6AXhPCfk5p10bJvcBL81nZDtFivhlLI=;
 b=leSgRWr17Ta4iNKj+7fkRdSXNXXQADxbv9kvLEwyXiJedBAwJKli/e6lDZz56Bi9yQqRxU4DSQcHrRlQjoQuXYDt/8O/1O9jjzoIcUPxR9hD0jQqXLZw/Gy2lPF+RTyqbPkRwI4qNpZo9X8VwCZCKvi7PdERHlQfh28Nc6Ib4KOZWoWBBDPRUCUSFfsKuV7bFotOWTxflAuGwUp/8ykauGkhA3MGu70aJsVgEKdao853bvUKO0UU+BEc18qw1NMxkmb6+PnyJjv1KBbufvnmN42eCWGTKGUk9GZiiXuweP5BKNnlgEoYuiwv/nYnm1WEGgqxjsKtmFq+P2iPv9WQWg==
Received: from BN9PR03CA0318.namprd03.prod.outlook.com (2603:10b6:408:112::23)
 by BN6PR1201MB0113.namprd12.prod.outlook.com (2603:10b6:405:55::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.30; Tue, 12 Apr
 2022 13:04:34 +0000
Received: from BN8NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:112:cafe::17) by BN9PR03CA0318.outlook.office365.com
 (2603:10b6:408:112::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29 via Frontend
 Transport; Tue, 12 Apr 2022 13:04:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 BN8NAM11FT066.mail.protection.outlook.com (10.13.177.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5144.20 via Frontend Transport; Tue, 12 Apr 2022 13:04:34 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Tue, 12 Apr
 2022 13:04:33 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 12 Apr
 2022 06:04:32 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.986.22 via Frontend Transport; Tue, 12 Apr
 2022 06:04:31 -0700
From:   Eli Cohen <elic@nvidia.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>
CC:     <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <si-wei.liu@oracle.com>,
        Eli Cohen <elic@nvidia.com>
Subject: [PATCH v2 1/2] vdpa: Add support for querying vendor statistics
Date:   Tue, 12 Apr 2022 16:04:01 +0300
Message-ID: <20220412130402.46945-2-elic@nvidia.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220412130402.46945-1-elic@nvidia.com>
References: <20220412130402.46945-1-elic@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fb22ecfe-b41e-4b75-e5ef-08da1c84fdde
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0113:EE_
X-Microsoft-Antispam-PRVS: <BN6PR1201MB0113AAB1878D000235A365F2ABED9@BN6PR1201MB0113.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /7U9Ty4Wyu3BYIOzo6+UImA96HTuajNFo5dtN7Tmo5uQGRByN/i7Sn4Dcv6OKT/2lJA/BKAAydQXKYDOnfOWb5DM1Fwzl+g/7dUAAZiQzcV+gOP0OIbv2y2YxFduPo4t4zblJU/pDJxj3zvm+BaVLyhhR4+sv2OcW3P2hT52NGx6E6m4+ofNLcUPsEKPaP+bo6cS85XsbWebYT+YuUrt11hc643dlBPtB8zD33aOh5hRu4o50Eartc+9Lnul9umIRHZv9mqxQ6lhCCYAFYuUd5i8ASHK/WIKolwgzs71WCtKyRzRpy6JAN3xo29n8+ypMwQi+sf8xj7Qw81QQuyJG0Tyd09T50pKSOfIgzKgSpjZEBwKDdq/EVtnOrqQ9fVHyh20ki00vZtMs+kTqyE8/jBzrqTngzyqhrbs92qFz6jUKG6/UUQThqjh3pjtTu4TOBFczXVpMhxrnpaSzRjNis2oln7SXfx/ne6u/hb9v3oPVF0U/XuNVb+bDYEICFBk5akA73M/s6s9vY2By7TBr9dJp1uxx5RWv2P7zDx/KcFSmf/8cFkydEscTnBR8Of9L7h9jvogIdYtT1UZi1eUOFU8Yfim/yJm9VtOKGvVKGg4x4V4AK9u0sSF1UZdlSM8UJbJgSL0cUIQQsygYhtlq7zsTrVXeIJB0Z4Hn+vkZyMtEe8aksnmg6f6jbEOQnvqIrW7laF6OsrLM+6Tb6vgfw==
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(107886003)(508600001)(40460700003)(83380400001)(70206006)(5660300002)(70586007)(4326008)(8676002)(316002)(82310400005)(81166007)(7696005)(6666004)(54906003)(47076005)(86362001)(2906002)(36756003)(1076003)(186003)(426003)(26005)(336012)(8936002)(2616005)(36860700001)(110136005)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2022 13:04:34.5132
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb22ecfe-b41e-4b75-e5ef-08da1c84fdde
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0113
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
 drivers/vdpa/vdpa.c       | 129 ++++++++++++++++++++++++++++++++++++++
 include/linux/vdpa.h      |   5 ++
 include/uapi/linux/vdpa.h |   6 ++
 3 files changed, 140 insertions(+)

diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index 2b75c00b1005..933466f61ca8 100644
--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -909,6 +909,74 @@ vdpa_dev_config_fill(struct vdpa_device *vdev, struct sk_buff *msg, u32 portid,
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
+	err = vendor_stats_fill(vdev, msg, info, index);
+
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
@@ -990,6 +1058,60 @@ vdpa_nl_cmd_dev_config_get_dumpit(struct sk_buff *msg, struct netlink_callback *
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
+	if (!err)
+		err = genlmsg_reply(msg, info);
+
+	put_device(dev);
+	mutex_unlock(&vdpa_dev_mutex);
+
+	if (err)
+		nlmsg_free(msg);
+
+	return err;
+
+mdev_err:
+	put_device(dev);
+dev_err:
+	mutex_unlock(&vdpa_dev_mutex);
+	return err;
+}
+
 static const struct nla_policy vdpa_nl_policy[VDPA_ATTR_MAX + 1] = {
 	[VDPA_ATTR_MGMTDEV_BUS_NAME] = { .type = NLA_NUL_STRING },
 	[VDPA_ATTR_MGMTDEV_DEV_NAME] = { .type = NLA_STRING },
@@ -997,6 +1119,7 @@ static const struct nla_policy vdpa_nl_policy[VDPA_ATTR_MAX + 1] = {
 	[VDPA_ATTR_DEV_NET_CFG_MACADDR] = NLA_POLICY_ETH_ADDR,
 	/* virtio spec 1.1 section 5.1.4.1 for valid MTU range */
 	[VDPA_ATTR_DEV_NET_CFG_MTU] = NLA_POLICY_MIN(NLA_U16, 68),
+	[VDPA_ATTR_DEV_QUEUE_INDEX] = NLA_POLICY_RANGE(NLA_U32, 0, 65535),
 };
 
 static const struct genl_ops vdpa_nl_ops[] = {
@@ -1030,6 +1153,12 @@ static const struct genl_ops vdpa_nl_ops[] = {
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
index 8943a209202e..48ed1fc00830 100644
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
@@ -473,4 +476,6 @@ struct vdpa_mgmt_dev {
 int vdpa_mgmtdev_register(struct vdpa_mgmt_dev *mdev);
 void vdpa_mgmtdev_unregister(struct vdpa_mgmt_dev *mdev);
 
+#define VDPA_INVAL_QUEUE_INDEX 0xffff
+
 #endif /* _LINUX_VDPA_H */
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

