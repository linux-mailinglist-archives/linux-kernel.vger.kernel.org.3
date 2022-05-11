Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8748523385
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 14:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242895AbiEKM65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 08:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237596AbiEKM6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 08:58:55 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B384195DE9
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 05:58:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V2jgalqTGAywuHU+ZnO2xGNvtatL5qwEeVXKkU43PX9mvdhCakxvQ9vVLEs/b2A49xtQCv+NOh2Wy2WSdTiRqXX56m1Zl5QSPiM6gb0U8k2ewPKkuCgYcHBDqCAYF3Dpo/N+C59QwXCSvmdJ3YLjQRhDuZTtG50c1DkI8hJCbos0Ai0KfsRyGkgLyhY3PDOjfAoVveOpt8Ya726QfGzGbn3upUdmF9pS213fW78IpUlrAV+xGaEVXVqb2rFbKIDkyiWKoOGv54iVgTPB9QGS8LVuiayEiQWlRcvpkiBEejWbiFw8RJuxAXLIdh8lauIM8fqwydzwzLDjQEKU06VVaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q4P3StwQZpOgAbWrsPJ0JmXcYbBFPZk8Mogeg4KG3XY=;
 b=OJz9pR3NZTLphkTTCPc3HNCUOa9LRN/2AJ5kir48i3ELHvziKPkh/yAr20HuoFDDXRG+tAg4EeAfu9BhspcJaI1N5GkqqVZuEJBoFs0lZEJIgLTA2XEbmd+DaxZg0x14OheH9dlgC3IerpXZrs2gJGIviPkvvmN90M7w33NIY4Tijd1lUII3AwN3OlhL3vJs/OKzjMjiN7DmrK2Xt3wYe/zvuB8ErrQ5cLRNxF8lzRJAR18sdCZWtWI0l7nWsFURbBK+SOetYCO2yY4jNjgTbRfiTr6CDU4ZHvzrvK/8ypSo2etjOCfE0AxFtSuNdIOi3gRLzuB3o0pTuTlxD38GRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q4P3StwQZpOgAbWrsPJ0JmXcYbBFPZk8Mogeg4KG3XY=;
 b=a/5Df9z5mkQdOE0nWbsFyzutGZaSGWK4NQRUfciUuZXaYTxreXfgwKkBohhfsY+SjrYtleeYs2ecHdAYH+hU5+b2QcUCGkUTLjHS/cqVF/H1wxdEXzwSFW/PafiTUw8vzscNDZajXs0z6j/WGyME/wevdZIEm2nZbuSJlyqN7vqPj7aStGU+2PpmC8IKFsaANkNdM+Hup1wZOT6UdD0V90qBjwDlHefm2GmPi6ghYMJhpKuAhLmLKem38dTkiS3gV/ig0+EOqSZFFYjbpGk4wdMzazZFMDRAMRwMOqpeD9iYGZt48oNHck6KGO3x1mRfBKBAPBCOer850ESFfu8H1w==
Received: from BN9PR03CA0071.namprd03.prod.outlook.com (2603:10b6:408:fc::16)
 by BN6PR12MB1282.namprd12.prod.outlook.com (2603:10b6:404:1d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Wed, 11 May
 2022 12:58:51 +0000
Received: from BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fc:cafe::3c) by BN9PR03CA0071.outlook.office365.com
 (2603:10b6:408:fc::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13 via Frontend
 Transport; Wed, 11 May 2022 12:58:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 BN8NAM11FT038.mail.protection.outlook.com (10.13.176.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5250.13 via Frontend Transport; Wed, 11 May 2022 12:58:51 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 DRHQMAIL105.nvidia.com (10.27.9.14) with Microsoft SMTP Server (TLS) id
 15.0.1497.32; Wed, 11 May 2022 12:58:50 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 11 May 2022 05:58:49 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Wed, 11 May 2022 05:58:48 -0700
From:   Eli Cohen <elic@nvidia.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>
CC:     <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <si-wei.liu@oracle.com>,
        Eli Cohen <elic@nvidia.com>
Subject: [PATCH] net/vdpa: Use reader/writers semaphore instead of mutex
Date:   Wed, 11 May 2022 15:58:45 +0300
Message-ID: <20220511125845.1332586-1-elic@nvidia.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2e3a556b-63dc-42cc-0f1a-08da334dff62
X-MS-TrafficTypeDiagnostic: BN6PR12MB1282:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB12827C5AD3522EEB740DC796ABC89@BN6PR12MB1282.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JlQ0tlvfVl4beKGv823Rm1VrPRCZbREZioVNLUrHunNXJJygjatF4tJOKf2fQ5niP95u05PyWXUnHWkF73vmjiywoM5np32YpkcIj6Eqsr9E9c2mWJ/NLXMWulnp2hAbgIbx+53wqy03FRaYOVIpsRGp4DwswdsZCYaZsbeaQDLxWvhZjN9VGIVQyD7dJu1Yd+atYzTrYcrgJtLsF03VouUObR58Jl8WDWNu/hLR2Qf+evE2QrhaNS+TeN8NGGALzNLgVbH6xmTmdDcta2ccaoQFam9ynkEakrRJwIAqrq9UEEfhdBGsHIG9a2sftPX6YAyj6W2Z3x6LXK9WKnDkJY8hNnHulHl9Ut4rug45w0hvVM7jnprEBThjEVegCwP3To8kzBsPe3Tvec20taaKCLWQLcQjl3BqUejy1DqS8mpsm1mpnjfAbwjCjyR840tAMUxE/m6iUbpW5F/Guz0HbL7hiaPG6wTz+zPioCtzHHUW1yHikfXn2gC29WSi0acN906aFNlLF2X6FalUy0C95GgLfRkGQmKthqVUA54I2d15xmKJjLIWm3uyoZt68U9xOZQCgbLChapYD+lAeowoA4VU9tHJMFYOCMJWEk9KECnbOKdu5dsbXnKh8goPwuYNpQ0T3Y5WrHoqWnryJEliQB3cUqUoz7+FwgulOIb27KBYlAGvBgwDGRqmLRu4lNQO3yp39lmcPqSe4gipoL9ziw==
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(26005)(70206006)(70586007)(426003)(6666004)(110136005)(47076005)(316002)(2906002)(81166007)(36860700001)(508600001)(40460700003)(7696005)(186003)(54906003)(8676002)(4326008)(336012)(82310400005)(86362001)(356005)(2616005)(8936002)(83380400001)(107886003)(1076003)(36756003)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 12:58:51.4742
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e3a556b-63dc-42cc-0f1a-08da334dff62
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1282
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

Use rw_semaphore instead of mutex to control access to vdpa devices.
This can be especially beneficial in case process poll on statistics
information.

Suggested-by: Si-Wei Liu <si-wei.liu@oracle.com>
Signed-off-by: Eli Cohen <elic@nvidia.com>
---
 drivers/vdpa/vdpa.c | 64 ++++++++++++++++++++++-----------------------
 1 file changed, 32 insertions(+), 32 deletions(-)

diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index 0fb4a615f267..ced634f94f76 100644
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
@@ -630,7 +630,7 @@ static int vdpa_nl_cmd_dev_add_set_doit(struct sk_buff *skb, struct genl_info *i
 	    !netlink_capable(skb, CAP_NET_ADMIN))
 		return -EPERM;
 
-	mutex_lock(&vdpa_dev_mutex);
+	down_write(&vdpa_dev_lock);
 	mdev = vdpa_mgmtdev_get_from_attr(info->attrs);
 	if (IS_ERR(mdev)) {
 		NL_SET_ERR_MSG_MOD(info->extack, "Fail to find the specified management device");
@@ -650,7 +650,7 @@ static int vdpa_nl_cmd_dev_add_set_doit(struct sk_buff *skb, struct genl_info *i
 
 	err = mdev->ops->dev_add(mdev, name, &config);
 err:
-	mutex_unlock(&vdpa_dev_mutex);
+	up_write(&vdpa_dev_lock);
 	return err;
 }
 
@@ -666,7 +666,7 @@ static int vdpa_nl_cmd_dev_del_set_doit(struct sk_buff *skb, struct genl_info *i
 		return -EINVAL;
 	name = nla_data(info->attrs[VDPA_ATTR_DEV_NAME]);
 
-	mutex_lock(&vdpa_dev_mutex);
+	down_write(&vdpa_dev_lock);
 	dev = bus_find_device(&vdpa_bus, NULL, name, vdpa_name_match);
 	if (!dev) {
 		NL_SET_ERR_MSG_MOD(info->extack, "device not found");
@@ -684,7 +684,7 @@ static int vdpa_nl_cmd_dev_del_set_doit(struct sk_buff *skb, struct genl_info *i
 mdev_err:
 	put_device(dev);
 dev_err:
-	mutex_unlock(&vdpa_dev_mutex);
+	up_write(&vdpa_dev_lock);
 	return err;
 }
 
@@ -750,7 +750,7 @@ static int vdpa_nl_cmd_dev_get_doit(struct sk_buff *skb, struct genl_info *info)
 	if (!msg)
 		return -ENOMEM;
 
-	mutex_lock(&vdpa_dev_mutex);
+	down_read(&vdpa_dev_lock);
 	dev = bus_find_device(&vdpa_bus, NULL, devname, vdpa_name_match);
 	if (!dev) {
 		NL_SET_ERR_MSG_MOD(info->extack, "device not found");
@@ -768,13 +768,13 @@ static int vdpa_nl_cmd_dev_get_doit(struct sk_buff *skb, struct genl_info *info)
 
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
@@ -816,9 +816,9 @@ static int vdpa_nl_cmd_dev_get_dumpit(struct sk_buff *msg, struct netlink_callba
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
@@ -1016,7 +1016,7 @@ static int vdpa_nl_cmd_dev_config_get_doit(struct sk_buff *skb, struct genl_info
 	if (!msg)
 		return -ENOMEM;
 
-	mutex_lock(&vdpa_dev_mutex);
+	down_read(&vdpa_dev_lock);
 	dev = bus_find_device(&vdpa_bus, NULL, devname, vdpa_name_match);
 	if (!dev) {
 		NL_SET_ERR_MSG_MOD(info->extack, "device not found");
@@ -1037,7 +1037,7 @@ static int vdpa_nl_cmd_dev_config_get_doit(struct sk_buff *skb, struct genl_info
 mdev_err:
 	put_device(dev);
 dev_err:
-	mutex_unlock(&vdpa_dev_mutex);
+	up_read(&vdpa_dev_lock);
 	if (err)
 		nlmsg_free(msg);
 	return err;
@@ -1075,9 +1075,9 @@ vdpa_nl_cmd_dev_config_get_dumpit(struct sk_buff *msg, struct netlink_callback *
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
@@ -1104,7 +1104,7 @@ static int vdpa_nl_cmd_dev_stats_get_doit(struct sk_buff *skb,
 		return -ENOMEM;
 
 	index = nla_get_u32(info->attrs[VDPA_ATTR_DEV_QUEUE_INDEX]);
-	mutex_lock(&vdpa_dev_mutex);
+	down_read(&vdpa_dev_lock);
 	dev = bus_find_device(&vdpa_bus, NULL, devname, vdpa_name_match);
 	if (!dev) {
 		NL_SET_ERR_MSG_MOD(info->extack, "device not found");
@@ -1124,7 +1124,7 @@ static int vdpa_nl_cmd_dev_stats_get_doit(struct sk_buff *skb,
 	err = genlmsg_reply(msg, info);
 
 	put_device(dev);
-	mutex_unlock(&vdpa_dev_mutex);
+	up_read(&vdpa_dev_lock);
 
 	return err;
 
@@ -1132,7 +1132,7 @@ static int vdpa_nl_cmd_dev_stats_get_doit(struct sk_buff *skb,
 	put_device(dev);
 dev_err:
 	nlmsg_free(msg);
-	mutex_unlock(&vdpa_dev_mutex);
+	up_read(&vdpa_dev_lock);
 	return err;
 }
 
-- 
2.35.1

