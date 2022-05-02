Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36146516E11
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 12:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384543AbiEBKZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 06:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384504AbiEBKZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 06:25:42 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam08on2086.outbound.protection.outlook.com [40.107.101.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E03E8B
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 03:22:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZzkMfgizbMnvQWdLEga4tdnnwJ+5Ox1kjxim+iLAYt6iwEFL68FXr2t/oUROzy5kDKI6DwsF3SWTXPuhdSD/WM83l7CfKI8dGXFoGWHAYZpeTdxFkfAPSBF8dnIk68DdFTV+VDiXAwgb2xQ5JPHiZqVB7JGxpaoz03GR276yejOI98Ncko/cvBymx1cSw/VJ4rf7UN6iYZSdHPwcPuq5XNPwvZVPI9o7oNvV3vZCbvOBakD+l6hNSgFYROpz5DFiw/V7zxhH2JaF8gUV2ANJk8XQbaOrOm8R+DG9/1tentLGtB6jsj9q+Zmw/nuYVbDd/LDgG7+WA3f1jlDn+9PW6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LMRsLqdfwjWK6AXhPCfk5p10bJvcBL81nZDtFivhlLI=;
 b=HYNi/WZX500V3d2BvnkWFk9iXlBRygy+IeKzBPL0/777H6fXtINkUYUW83LW2+Xjwe3mswFFh/7lBRLj670V4wMdHFnZ+uJ+M9dp3t+MI6WeWZxaLUoQdNok2hSkp0cj+ua0IeGrWh25dRyLVi54hGE/bsSH09bWESs3BAFYWOykjg05vDdOoyAPQ/8Pj3wYSj4/NUW7g57RKEYN9XwvgIUECRVweWz0+83+AdVQDCdicqA2fbmmmLXY1MKLk16kgs+jcpMJXmKtKLiZLo/T0+2rZiYJEg4LWOXpNySdeZXb4+miTNQsppgM/Hvo1IaHf2oOi2O2X2kB1dTcVlDsNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LMRsLqdfwjWK6AXhPCfk5p10bJvcBL81nZDtFivhlLI=;
 b=F4mPj6dW9VCw0THOcer2tmceu65udp+coBy2f+cptbTQ/t4Vue5shoUe8WXAiI0AVVmmp2W+5vG4hW+CMqWJIbVUbH42Yf8tKI/XGN0AHQ0Rg18GiPkLAGBTFFP9qQcvyAGIf37joJe8rA7+pRYarggCfKzt2XNkJpseCG8jdV/0CCVUTkmFgNKQl5y0OVXv25ezY/s3xZawJV7A9UtbccMD+vet8Mg3ROsyqLgOpniKowZrDnJCyW2tk5M0ChpDHf39uBTfDFcccoTLXdWkQxDrTFb11Sr3cbwQsGEHqfFrWz3itVjeQtg9RzctKigcrgSlWD3d55+eDHjT86shEw==
Received: from DM6PR02CA0048.namprd02.prod.outlook.com (2603:10b6:5:177::25)
 by DM5PR12MB2568.namprd12.prod.outlook.com (2603:10b6:4:b5::35) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Mon, 2 May
 2022 10:22:12 +0000
Received: from DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:177:cafe::8d) by DM6PR02CA0048.outlook.office365.com
 (2603:10b6:5:177::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.12 via Frontend
 Transport; Mon, 2 May 2022 10:22:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 DM6NAM11FT057.mail.protection.outlook.com (10.13.172.252) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5206.12 via Frontend Transport; Mon, 2 May 2022 10:22:12 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Mon, 2 May
 2022 10:22:11 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 2 May 2022
 03:22:10 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.986.22 via Frontend Transport; Mon, 2 May
 2022 03:22:09 -0700
From:   Eli Cohen <elic@nvidia.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>
CC:     <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <si-wei.liu@oracle.com>,
        Eli Cohen <elic@nvidia.com>
Subject: [PATCH v3 1/2] vdpa: Add support for querying vendor statistics
Date:   Mon, 2 May 2022 13:22:00 +0300
Message-ID: <20220502102201.190357-2-elic@nvidia.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220502102201.190357-1-elic@nvidia.com>
References: <20220502102201.190357-1-elic@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 81b73623-a294-49dd-56d7-08da2c259f64
X-MS-TrafficTypeDiagnostic: DM5PR12MB2568:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB25681A1A7A9C94438B2A286BABC19@DM5PR12MB2568.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tGv5x6NRhioqxf/0QKcSkFVtrTxy9qhDMNsTMEbm1ZhoH7fPxuHXMe0NaFgsAJDfJcfW95JQj1Jv8HA0t2naK205k3QG7ra4ib0wq7gU+IOaFvz88NzZN2i9M/tEAYY8bIgiMx0to3sFnasdgRlWj3AvHyO/5QHbW5ucxq+//ix812w+1HqEmK9OP0YroJdDG55eJm39rsdx9EAb9YxV5doRWIuIae7NzeP5bTc2NLwFsm5N4o+4XxVnfeCSEpe5irib9YSV4bPOddhU0bG7wcvuDniKUwpdx9EbJgJXD4oZCFprEemSPUrs0iLqEI3t9DtmxXvOpSUdUzYHd7FVTwnyoWJn7OgBv3i4eiJPJguZ6LABJRuFEHyWkEFdu94QcvqNb2KJPefrYgnNSxTnS3kWHGBpAUheziVsQy1Ann+lKdJ514UhAuW1Ev6bd1MJlZoAxJjHC0xf1okUZ/vr3DNuicDSxuQHBQwJKEscw9wSFWCvMO7JO/QIAg2deQc/gDrsAXl0qCiHwAmQFxr22d8Aimtb6jqKqySd5jgOiOY5V6qNptquyVp7YF2JpdlXD8QCWnseNnzkeOgtUFvL3OkgOjBTkZnIJ4oyO9GU/Whi90aX7W5E13fP0ReQFwZdPpGS5dzQD7tDgLEFQ43OY6JsfYgKOhRvOYmhKhOmZ0t9zZ3kKA+Pw0CgZYj9iT2icTL7aKRvr3NgYcTtL4cw/Q==
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(336012)(83380400001)(356005)(426003)(8676002)(40460700003)(47076005)(1076003)(186003)(36756003)(8936002)(4326008)(5660300002)(2906002)(107886003)(82310400005)(54906003)(110136005)(7696005)(6666004)(2616005)(70586007)(70206006)(26005)(36860700001)(81166007)(508600001)(86362001)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2022 10:22:12.4661
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81b73623-a294-49dd-56d7-08da2c259f64
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2568
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

