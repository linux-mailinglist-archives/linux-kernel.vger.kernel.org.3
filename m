Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE8CD52476C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 09:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351189AbiELHv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 03:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351183AbiELHvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 03:51:15 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2045.outbound.protection.outlook.com [40.107.93.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CF622CC9A
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 00:51:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=isRQ5+Y9MLrVE51SnqEYUaG3PWi32ZNG5pN/vrmZCRi3YlFVVwj7ZRxRg7UYuvYM6llvJNCwVXk16araMbShWnnMAmzauF9I4TX43gZeSGEQS8MUFcsxTgVzOiiEXDl/yhj8sD5NbQqNsNG6J+Fa86Zmv0j5Nop61GShJGj0kCDAJZgCVUKP6eKfIFGuIUzxr0mz9wx0sArYBkx/ok9fGdUjs5VZbUFmOphciZx3wDb/weGIxZWm+7s+tx9T7KjTAEchT5k6kDRXsUdPkoIqpGsYl9IEsmSE8hYPkxLHhfN0sTjR40vXAX3rqt1Hrm9bELX6KH4E0lWg60ofegtoRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0NlhT34aUum4DMnzBqOmPoNGdEqSPSXY3Mw3ZCJCW9g=;
 b=DDD+V/Cio9WK35uMvXtEr+MAp8gq9otSR0K6AqG3vUkueXFAH34ZkOBh1ye68PEfkqamzpW5W6kEo6fMg3V7yhSre9vgKq4C4swjs8XZK7w0FvLBAelV1t+VNYgbLJkmHS4pqVP7FoKbtMjGTWxPUGxz47FlPWPac+JrUp33OpGOTk4h7D9i8Va+h4so7tu9hoECqwHtLriUeN1Faj62H2RqqTfNtOtHg15gueAz1x3j08zfEMrBboJefKjXNlnPcmT1uR13pXTC5DwFuEGfdCzAHOjfcSZrQqXF5xSFmZ0zZWACDz2WVE/0yOCPX35fzPUnMDIXz3oLryURJbQeKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0NlhT34aUum4DMnzBqOmPoNGdEqSPSXY3Mw3ZCJCW9g=;
 b=Oy+fDpUPtxO+hJgHnErFzD6+GqVg6ImMyQCF/zP9SnA1I/oxg3lZYN1IyTsbEFoB0ybfgEkD1LlfnDAXluOW2dR6h6Ie8JN4koUgkQj9zORSWx45Rf/JvGrFAYEEK58BLL8+4EzAGtL8RNoOKUE+f/Km3WXDeyFSNCKSoXBxzzH0kks+/o+xObuWgV6kmFcK15Vu+moVaEw/NTML33J7YVF4ayjvHnMGT+IVLKLfhzJXl3B+Q7hr4nvpu51NfpD3ceto+YjHXVvaVGBgULYVss2Z0KWhc7kMvoB/sxeH8AH/xxG4PdGAjkz+aeSOiMimTzxNOWgZJEWWR9co+8p6lA==
Received: from MW4PR04CA0196.namprd04.prod.outlook.com (2603:10b6:303:86::21)
 by MN2PR12MB3101.namprd12.prod.outlook.com (2603:10b6:208:c4::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Thu, 12 May
 2022 07:51:12 +0000
Received: from CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:86:cafe::87) by MW4PR04CA0196.outlook.office365.com
 (2603:10b6:303:86::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23 via Frontend
 Transport; Thu, 12 May 2022 07:51:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 CO1NAM11FT008.mail.protection.outlook.com (10.13.175.191) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5250.13 via Frontend Transport; Thu, 12 May 2022 07:51:11 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 DRHQMAIL101.nvidia.com (10.27.9.10) with Microsoft SMTP Server (TLS) id
 15.0.1497.32; Thu, 12 May 2022 07:51:10 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 12 May 2022 00:51:10 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Thu, 12 May 2022 00:51:08 -0700
From:   Eli Cohen <elic@nvidia.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>
CC:     <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <si-wei.liu@oracle.com>,
        Eli Cohen <elic@nvidia.com>
Subject: [PATCH v6 3/4] net/vdpa: Use readers/writers semaphore instead of mutex
Date:   Thu, 12 May 2022 10:50:59 +0300
Message-ID: <20220512075100.1715286-4-elic@nvidia.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220512075100.1715286-1-elic@nvidia.com>
References: <20220512075100.1715286-1-elic@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a6119fa8-4ab9-43a5-3c51-08da33ec2e9c
X-MS-TrafficTypeDiagnostic: MN2PR12MB3101:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3101987204A2142D25DFFE6AABCB9@MN2PR12MB3101.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YIuqT1xMrVD5mKIR/Mo7v3hNQ4+uQFtcKLjFij3rKQeFLZ7sWqmSFtYibQyUDvb6hMeYbEvMMpUWu407MI1ATX2yA4Nem1p/gaSElX2nSc0TXfSHMqONikDI3b3BBZVKQzS3AashRYrE6obeYZlxLQUc5LqY6Pv6iUAC9N/4BxM5mu4QLWS4s9NyAEPfTS0lIaVch9ZqzW5OORiipVhGRfUBJdElCgK+wCogkVWTbbRDarBGU+c9a3jBfgDwC7lKfSs7E8ikryRiYGqpRorOGYXRNoXZdjYyyGJNwj7dQT/D/rahWYYluW5OWKVXY1J/tD47WhBeYqwWh4DR6JxGFTvzySO/axO9UUX0xeEqH21AS7IiKqT7rQPOqQPFr67SH1+ESxbL75/Q2ALLO3JmvH6+ci448382nKBwSxAOI5TsiEbRSE80vg09TSoMDWgo+8voD00j4JQHQKc0+wyZfx+r4ajtMcGHsvJmIadkmY5pHSsgZXBGrYfN98gCv6xPeo/oYwYM+a3UECvm1wdEG4ebTtPKNsXyOueoSIG/LKfqhlTZNlvz4gGujbJcNCEhMMSO+WkUaj8cZRjtzzGIsLYq6YHbBIs1HUGxRQ99P1qMr+qGBwCkvk3basv9X+tZ0bCNuOIIgODryAqRpBGh87NT/7P5qUFMbfBITmbK/4sC2lXYUebNidU266r0P+jgetywDQaBLDD29azV1GMR9g==
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(8676002)(2906002)(81166007)(4326008)(70206006)(70586007)(5660300002)(8936002)(82310400005)(110136005)(86362001)(356005)(336012)(426003)(47076005)(6666004)(186003)(2616005)(83380400001)(36860700001)(26005)(7696005)(316002)(40460700003)(1076003)(107886003)(54906003)(508600001)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2022 07:51:11.2698
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6119fa8-4ab9-43a5-3c51-08da33ec2e9c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3101
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use rw_semaphore instead of mutex to control access to vdpa devices.
This can be especially beneficial in case processes poll on statistics
information.

Suggested-by: Si-Wei Liu <si-wei.liu@oracle.com>
Reviewed-by: Si-Wei Liu <si-wei.liu@oracle.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Eli Cohen <elic@nvidia.com>
---
 drivers/vdpa/vdpa.c | 64 ++++++++++++++++++++++-----------------------
 1 file changed, 32 insertions(+), 32 deletions(-)

diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index 7ce417ff0ea8..5308e5e34ff2 100644
--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -18,7 +18,7 @@
 
 static LIST_HEAD(mdev_head);
 /* A global mutex that protects vdpa management device and device level operations. */
-static DEFINE_MUTEX(vdpa_dev_mutex);
+static DECLARE_RWSEM(vdpa_dev_lock);
 static DEFINE_IDA(vdpa_index_ida);
 
 void vdpa_set_status(struct vdpa_device *vdev, u8 status)
@@ -238,7 +238,7 @@ static int __vdpa_register_device(struct vdpa_device *vdev, u32 nvqs)
 
 	vdev->nvqs = nvqs;
 
-	lockdep_assert_held(&vdpa_dev_mutex);
+	lockdep_assert_held(&vdpa_dev_lock);
 	dev = bus_find_device(&vdpa_bus, NULL, dev_name(&vdev->dev), vdpa_name_match);
 	if (dev) {
 		put_device(dev);
@@ -278,9 +278,9 @@ int vdpa_register_device(struct vdpa_device *vdev, u32 nvqs)
 {
 	int err;
 
-	mutex_lock(&vdpa_dev_mutex);
+	down_write(&vdpa_dev_lock);
 	err = __vdpa_register_device(vdev, nvqs);
-	mutex_unlock(&vdpa_dev_mutex);
+	up_write(&vdpa_dev_lock);
 	return err;
 }
 EXPORT_SYMBOL_GPL(vdpa_register_device);
@@ -293,7 +293,7 @@ EXPORT_SYMBOL_GPL(vdpa_register_device);
  */
 void _vdpa_unregister_device(struct vdpa_device *vdev)
 {
-	lockdep_assert_held(&vdpa_dev_mutex);
+	lockdep_assert_held(&vdpa_dev_lock);
 	WARN_ON(!vdev->mdev);
 	device_unregister(&vdev->dev);
 }
@@ -305,9 +305,9 @@ EXPORT_SYMBOL_GPL(_vdpa_unregister_device);
  */
 void vdpa_unregister_device(struct vdpa_device *vdev)
 {
-	mutex_lock(&vdpa_dev_mutex);
+	down_write(&vdpa_dev_lock);
 	device_unregister(&vdev->dev);
-	mutex_unlock(&vdpa_dev_mutex);
+	up_write(&vdpa_dev_lock);
 }
 EXPORT_SYMBOL_GPL(vdpa_unregister_device);
 
@@ -352,9 +352,9 @@ int vdpa_mgmtdev_register(struct vdpa_mgmt_dev *mdev)
 		return -EINVAL;
 
 	INIT_LIST_HEAD(&mdev->list);
-	mutex_lock(&vdpa_dev_mutex);
+	down_write(&vdpa_dev_lock);
 	list_add_tail(&mdev->list, &mdev_head);
-	mutex_unlock(&vdpa_dev_mutex);
+	up_write(&vdpa_dev_lock);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(vdpa_mgmtdev_register);
@@ -371,14 +371,14 @@ static int vdpa_match_remove(struct device *dev, void *data)
 
 void vdpa_mgmtdev_unregister(struct vdpa_mgmt_dev *mdev)
 {
-	mutex_lock(&vdpa_dev_mutex);
+	down_write(&vdpa_dev_lock);
 
 	list_del(&mdev->list);
 
 	/* Filter out all the entries belong to this management device and delete it. */
 	bus_for_each_dev(&vdpa_bus, NULL, mdev, vdpa_match_remove);
 
-	mutex_unlock(&vdpa_dev_mutex);
+	up_write(&vdpa_dev_lock);
 }
 EXPORT_SYMBOL_GPL(vdpa_mgmtdev_unregister);
 
@@ -532,17 +532,17 @@ static int vdpa_nl_cmd_mgmtdev_get_doit(struct sk_buff *skb, struct genl_info *i
 	if (!msg)
 		return -ENOMEM;
 
-	mutex_lock(&vdpa_dev_mutex);
+	down_read(&vdpa_dev_lock);
 	mdev = vdpa_mgmtdev_get_from_attr(info->attrs);
 	if (IS_ERR(mdev)) {
-		mutex_unlock(&vdpa_dev_mutex);
+		up_read(&vdpa_dev_lock);
 		NL_SET_ERR_MSG_MOD(info->extack, "Fail to find the specified mgmt device");
 		err = PTR_ERR(mdev);
 		goto out;
 	}
 
 	err = vdpa_mgmtdev_fill(mdev, msg, info->snd_portid, info->snd_seq, 0);
-	mutex_unlock(&vdpa_dev_mutex);
+	up_read(&vdpa_dev_lock);
 	if (err)
 		goto out;
 	err = genlmsg_reply(msg, info);
@@ -561,7 +561,7 @@ vdpa_nl_cmd_mgmtdev_get_dumpit(struct sk_buff *msg, struct netlink_callback *cb)
 	int idx = 0;
 	int err;
 
-	mutex_lock(&vdpa_dev_mutex);
+	down_read(&vdpa_dev_lock);
 	list_for_each_entry(mdev, &mdev_head, list) {
 		if (idx < start) {
 			idx++;
@@ -574,7 +574,7 @@ vdpa_nl_cmd_mgmtdev_get_dumpit(struct sk_buff *msg, struct netlink_callback *cb)
 		idx++;
 	}
 out:
-	mutex_unlock(&vdpa_dev_mutex);
+	up_read(&vdpa_dev_lock);
 	cb->args[0] = idx;
 	return msg->len;
 }
@@ -627,7 +627,7 @@ static int vdpa_nl_cmd_dev_add_set_doit(struct sk_buff *skb, struct genl_info *i
 	    !netlink_capable(skb, CAP_NET_ADMIN))
 		return -EPERM;
 
-	mutex_lock(&vdpa_dev_mutex);
+	down_write(&vdpa_dev_lock);
 	mdev = vdpa_mgmtdev_get_from_attr(info->attrs);
 	if (IS_ERR(mdev)) {
 		NL_SET_ERR_MSG_MOD(info->extack, "Fail to find the specified management device");
@@ -643,7 +643,7 @@ static int vdpa_nl_cmd_dev_add_set_doit(struct sk_buff *skb, struct genl_info *i
 
 	err = mdev->ops->dev_add(mdev, name, &config);
 err:
-	mutex_unlock(&vdpa_dev_mutex);
+	up_write(&vdpa_dev_lock);
 	return err;
 }
 
@@ -659,7 +659,7 @@ static int vdpa_nl_cmd_dev_del_set_doit(struct sk_buff *skb, struct genl_info *i
 		return -EINVAL;
 	name = nla_data(info->attrs[VDPA_ATTR_DEV_NAME]);
 
-	mutex_lock(&vdpa_dev_mutex);
+	down_write(&vdpa_dev_lock);
 	dev = bus_find_device(&vdpa_bus, NULL, name, vdpa_name_match);
 	if (!dev) {
 		NL_SET_ERR_MSG_MOD(info->extack, "device not found");
@@ -677,7 +677,7 @@ static int vdpa_nl_cmd_dev_del_set_doit(struct sk_buff *skb, struct genl_info *i
 mdev_err:
 	put_device(dev);
 dev_err:
-	mutex_unlock(&vdpa_dev_mutex);
+	up_write(&vdpa_dev_lock);
 	return err;
 }
 
@@ -743,7 +743,7 @@ static int vdpa_nl_cmd_dev_get_doit(struct sk_buff *skb, struct genl_info *info)
 	if (!msg)
 		return -ENOMEM;
 
-	mutex_lock(&vdpa_dev_mutex);
+	down_read(&vdpa_dev_lock);
 	dev = bus_find_device(&vdpa_bus, NULL, devname, vdpa_name_match);
 	if (!dev) {
 		NL_SET_ERR_MSG_MOD(info->extack, "device not found");
@@ -761,13 +761,13 @@ static int vdpa_nl_cmd_dev_get_doit(struct sk_buff *skb, struct genl_info *info)
 
 	err = genlmsg_reply(msg, info);
 	put_device(dev);
-	mutex_unlock(&vdpa_dev_mutex);
+	up_read(&vdpa_dev_lock);
 	return err;
 
 mdev_err:
 	put_device(dev);
 err:
-	mutex_unlock(&vdpa_dev_mutex);
+	up_read(&vdpa_dev_lock);
 	nlmsg_free(msg);
 	return err;
 }
@@ -809,9 +809,9 @@ static int vdpa_nl_cmd_dev_get_dumpit(struct sk_buff *msg, struct netlink_callba
 	info.start_idx = cb->args[0];
 	info.idx = 0;
 
-	mutex_lock(&vdpa_dev_mutex);
+	down_read(&vdpa_dev_lock);
 	bus_for_each_dev(&vdpa_bus, NULL, &info, vdpa_dev_dump);
-	mutex_unlock(&vdpa_dev_mutex);
+	up_read(&vdpa_dev_lock);
 	cb->args[0] = info.idx;
 	return msg->len;
 }
@@ -1022,7 +1022,7 @@ static int vdpa_nl_cmd_dev_config_get_doit(struct sk_buff *skb, struct genl_info
 	if (!msg)
 		return -ENOMEM;
 
-	mutex_lock(&vdpa_dev_mutex);
+	down_read(&vdpa_dev_lock);
 	dev = bus_find_device(&vdpa_bus, NULL, devname, vdpa_name_match);
 	if (!dev) {
 		NL_SET_ERR_MSG_MOD(info->extack, "device not found");
@@ -1043,7 +1043,7 @@ static int vdpa_nl_cmd_dev_config_get_doit(struct sk_buff *skb, struct genl_info
 mdev_err:
 	put_device(dev);
 dev_err:
-	mutex_unlock(&vdpa_dev_mutex);
+	up_read(&vdpa_dev_lock);
 	if (err)
 		nlmsg_free(msg);
 	return err;
@@ -1081,9 +1081,9 @@ vdpa_nl_cmd_dev_config_get_dumpit(struct sk_buff *msg, struct netlink_callback *
 	info.start_idx = cb->args[0];
 	info.idx = 0;
 
-	mutex_lock(&vdpa_dev_mutex);
+	down_read(&vdpa_dev_lock);
 	bus_for_each_dev(&vdpa_bus, NULL, &info, vdpa_dev_config_dump);
-	mutex_unlock(&vdpa_dev_mutex);
+	up_read(&vdpa_dev_lock);
 	cb->args[0] = info.idx;
 	return msg->len;
 }
@@ -1110,7 +1110,7 @@ static int vdpa_nl_cmd_dev_stats_get_doit(struct sk_buff *skb,
 		return -ENOMEM;
 
 	index = nla_get_u32(info->attrs[VDPA_ATTR_DEV_QUEUE_INDEX]);
-	mutex_lock(&vdpa_dev_mutex);
+	down_read(&vdpa_dev_lock);
 	dev = bus_find_device(&vdpa_bus, NULL, devname, vdpa_name_match);
 	if (!dev) {
 		NL_SET_ERR_MSG_MOD(info->extack, "device not found");
@@ -1130,7 +1130,7 @@ static int vdpa_nl_cmd_dev_stats_get_doit(struct sk_buff *skb,
 	err = genlmsg_reply(msg, info);
 
 	put_device(dev);
-	mutex_unlock(&vdpa_dev_mutex);
+	up_read(&vdpa_dev_lock);
 
 	return err;
 
@@ -1138,7 +1138,7 @@ static int vdpa_nl_cmd_dev_stats_get_doit(struct sk_buff *skb,
 	put_device(dev);
 dev_err:
 	nlmsg_free(msg);
-	mutex_unlock(&vdpa_dev_mutex);
+	up_read(&vdpa_dev_lock);
 	return err;
 }
 
-- 
2.35.1

