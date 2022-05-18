Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7EAB52BC2B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 16:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238062AbiERNig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 09:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238035AbiERNiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 09:38:21 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BFCC16F900
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 06:38:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RvOuhfA0UcehccA/jUx69U0CCC1nAVCytxv8OoibtFs6YoR8xoxtb2ciQ0iwSI0ffDu1FO2doEiPzi1bBmybmnA4oIfhs/FRJB5QTyfy90AtLTxR/3KtmY/2E1vyGXhGmyS5L3801pGkAfPZAElUCspAx3DSMNlUUYFsOvWawRB3gw/Pg6wQIsVvu3qWBFfB0rL/L1nlQaMiXwrJO3InEJ+a80zDz/1ep7NGwV9K92jtEaq3GaIPCRMCmGqQeudaYbdUS+KUZo/i1eQqqyGiFNAuci9KSpahxvdYqGyy3pT3Qro1g6eO86n7qIn6ilVFtFbfOjY7kqJDSnQO1ev5Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GrHGLJT9Qh1aJ51+qIXB1anzlEgXHR/GNVOAVeDnpaE=;
 b=KaUr3MEIQsnY8iUxe7REtYkBSYijdp80fdyNSYr1lUTA3enQUu88TxcxHuwR2D4r8D6BjzQQTcJXEykefGknnVmKpi6A54tZ+2BUTHh641uAX6/Z0s6+Vf9kKGLrniqNkiCdXAQJOmK0BmzAnvi2FPgKbnSw/8uW7BejnYtLPVcl8t7Z62eDi7Hs4SBV2mYroqwTxfOcWq7uVIV+YGamnIUL7/EdHgbXaUTkLHUHlTcNlnKS4qXIgcMx61PCyCkJkBReoY3WI7bDDfMtlbwyuMgqFu1MnS+sttlN5WQjDXkgrqnT7mjHdAtiPyYeRMrpFuPDfClQ22IyvFqUTLGTHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GrHGLJT9Qh1aJ51+qIXB1anzlEgXHR/GNVOAVeDnpaE=;
 b=hc37T+yJOZWI9fNCWrPSw0fESYEANYORPAa/nYuV9rcCsv9f9yyzFrMVO0VdDlq4Ntl856aUKDVUbkpPfZCVdKFSnrBOHaG/heaWn9NFbCzLtWjoINgGm1OVfAgDMAT0CELvAfPTuYCTjFGFYIM7yqruz18Kf8XXlXAZJf3lBhHaILLllN6ST9SnIhBnKM79ijleYyd7Sk/AohvMQmB4JrKIU80qUkE3nsmEDg4tzsnBaOFt1U1QC4Qa4yPSn1SA5oOn3v/k9rlI6vFswGoEvZrNR3JP0XIVYEr7GfkojZNSPjc0DihbjoqCU/hcVM0OiiVvJudhbcmwKK2s8S1O+g==
Received: from BN9PR03CA0461.namprd03.prod.outlook.com (2603:10b6:408:139::16)
 by MW2PR12MB2361.namprd12.prod.outlook.com (2603:10b6:907:7::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Wed, 18 May
 2022 13:38:17 +0000
Received: from BN8NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:139:cafe::64) by BN9PR03CA0461.outlook.office365.com
 (2603:10b6:408:139::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.16 via Frontend
 Transport; Wed, 18 May 2022 13:38:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.235) by
 BN8NAM11FT057.mail.protection.outlook.com (10.13.177.49) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5273.14 via Frontend Transport; Wed, 18 May 2022 13:38:16 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Wed, 18 May
 2022 13:38:15 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 18 May
 2022 06:38:15 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.986.22 via Frontend Transport; Wed, 18 May
 2022 06:38:13 -0700
From:   Eli Cohen <elic@nvidia.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>
CC:     <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <si-wei.liu@oracle.com>,
        Eli Cohen <elic@nvidia.com>
Subject: [PATCH v8 3/6] net/vdpa: Use readers/writers semaphore instead of vdpa_dev_mutex
Date:   Wed, 18 May 2022 16:38:01 +0300
Message-ID: <20220518133804.1075129-4-elic@nvidia.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220518133804.1075129-1-elic@nvidia.com>
References: <20220518133804.1075129-1-elic@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e0d684cd-f073-4875-a90e-08da38d3a9f7
X-MS-TrafficTypeDiagnostic: MW2PR12MB2361:EE_
X-Microsoft-Antispam-PRVS: <MW2PR12MB2361C1E41C4A7A84D548DF35ABD19@MW2PR12MB2361.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: orbuvbv/tyGNrhTkBu9F06XpBkf8iaWG22hhvePmx2UkPy3M+AkiK2kpqwpG/0K4DztoxFWwPhFQaroEsKI+mh3W0DXwJgSfDrVfAJXj8wTd4JJb//WkRePZ0pDXotver3I8PDvMOd3etua8/7oL4xWGmNObGS+BHNoSCCegTBG1Y3CxzlqOrpl1tQRneH/VzugQ0D1dJTmrAF+SvRs5di9zXZhM83sP1h1lMImncXph7/vha9nt2ejMtWLTOJomr7cdNMeqIkA1aWFf1mxKE9rs8e6pnpJuYMc9+1uiqiAZWJfHecXGjdxO3YXSlEXYUE43d+2059IkkHOQInoYkkApLyy9MsaQ1kmi8lyStFe9025JD1Vq3Unl9cwxerX6+nCZwarRa9zjCOE2PikRFQqR8HMiNzEkX0e05y0AoYr/uxVuBj5nVtmzQh6KOk26QrhA3gybn+I5nmN85PbMtNkrsdJxNQk47juXMqBDQR72yI4c5A82BD56inJv/pxgtn7ic7og1Mv/Dxr4s0M+gnq5nX6xaPyP/DwhFXuCGRfliPLl6L0crv9+OCmrIomMvuVYlQp+HwaZohw3Z7LMMOoJMkvrKUMHulesYJWeIx56BzR6e832wsUqyIDH9IqMYM0weLBAO28WZmFFuhyNs1mDEyiWhvuavpivSTAGFGcBm7tLkmU9+DS5PLHHHXs0AhaxzJ4F/k+uuv6GqgB9Ew==
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(82310400005)(40460700003)(186003)(336012)(426003)(47076005)(83380400001)(356005)(81166007)(7696005)(36860700001)(1076003)(70206006)(6666004)(110136005)(54906003)(316002)(70586007)(26005)(8676002)(508600001)(2906002)(2616005)(107886003)(5660300002)(4326008)(86362001)(8936002)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2022 13:38:16.5462
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0d684cd-f073-4875-a90e-08da38d3a9f7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2361
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
index 31b5eb2c0778..2ff7de5e6b2f 100644
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
@@ -1031,7 +1031,7 @@ static int vdpa_nl_cmd_dev_config_get_doit(struct sk_buff *skb, struct genl_info
 	if (!msg)
 		return -ENOMEM;
 
-	mutex_lock(&vdpa_dev_mutex);
+	down_read(&vdpa_dev_lock);
 	dev = bus_find_device(&vdpa_bus, NULL, devname, vdpa_name_match);
 	if (!dev) {
 		NL_SET_ERR_MSG_MOD(info->extack, "device not found");
@@ -1052,7 +1052,7 @@ static int vdpa_nl_cmd_dev_config_get_doit(struct sk_buff *skb, struct genl_info
 mdev_err:
 	put_device(dev);
 dev_err:
-	mutex_unlock(&vdpa_dev_mutex);
+	up_read(&vdpa_dev_lock);
 	if (err)
 		nlmsg_free(msg);
 	return err;
@@ -1090,9 +1090,9 @@ vdpa_nl_cmd_dev_config_get_dumpit(struct sk_buff *msg, struct netlink_callback *
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
@@ -1119,7 +1119,7 @@ static int vdpa_nl_cmd_dev_stats_get_doit(struct sk_buff *skb,
 		return -ENOMEM;
 
 	index = nla_get_u32(info->attrs[VDPA_ATTR_DEV_QUEUE_INDEX]);
-	mutex_lock(&vdpa_dev_mutex);
+	down_read(&vdpa_dev_lock);
 	dev = bus_find_device(&vdpa_bus, NULL, devname, vdpa_name_match);
 	if (!dev) {
 		NL_SET_ERR_MSG_MOD(info->extack, "device not found");
@@ -1139,7 +1139,7 @@ static int vdpa_nl_cmd_dev_stats_get_doit(struct sk_buff *skb,
 	err = genlmsg_reply(msg, info);
 
 	put_device(dev);
-	mutex_unlock(&vdpa_dev_mutex);
+	up_read(&vdpa_dev_lock);
 
 	return err;
 
@@ -1147,7 +1147,7 @@ static int vdpa_nl_cmd_dev_stats_get_doit(struct sk_buff *skb,
 	put_device(dev);
 dev_err:
 	nlmsg_free(msg);
-	mutex_unlock(&vdpa_dev_mutex);
+	up_read(&vdpa_dev_lock);
 	return err;
 }
 
-- 
2.35.1

