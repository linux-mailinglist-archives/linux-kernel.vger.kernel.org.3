Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C54952A2FD
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 15:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343579AbiEQNOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 09:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347321AbiEQNOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 09:14:04 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2083.outbound.protection.outlook.com [40.107.92.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14292419BE
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 06:14:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FldDUklDM4qmEPSZOvdczdjicLZUYo24uFxEsiTr6cALOeHPlzgKzDwSJhw0cbzlFQBFxExfsO/tUqKeccyN1MHSgV4ep8li11EzXXZPdCkbBL0d1cAjZJHxbc5UJ2DfAHlw3s+CWB0zofIh+QlklCRtdruG+sqBLV4j/iGGehmeoMlbJYQZ5TBcBH2JZNDnOoruU3Cs7xNJcD3/qsisUvbcy4E9xg16f5wFNWaLJIzrIapn+xJROVq+rQs40Orw70UeV0sI84EgX/sGiiXSuKLiKUt66BCQNSelJSjhQdqKYS2xgSlzRtw+E89sER9ZZcpvA5Mkljo78EJGuieYaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O+qpikeUqbOTtf4YHXHaIKDL0bLc39FNIb5j2geOlwQ=;
 b=cGHBQtBVuNFx+lxOdNsiKzrtYIykR5mU9EGmt4S0f+wluwwMJzugAovPHfzgs4Ko+9D/46ef5LxtZRhigZsKajn4H3aSmPVZ2CJ25jsPSRU7tXLzlxq9a5Aud1yVD4wZK7RpjQPycSO7WgZF6vQ+L1Eo3oNTPLndBrmQu+4mTuxBHiYkcCTjmRRWeekseWCHoGiFrP2iyurMesmne+uFkKTSP+C1x6WQMp2tl/ghPm9wQIZORSbG+BQn36DgtnUATlMY3DiEviIA1OAE1n5x9snPLQzOXAyibC+TrPURKHoEwvCOqS9VZvJhi2IT3m7tXQ44VcR2Wv8Kwu9N8C+IKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O+qpikeUqbOTtf4YHXHaIKDL0bLc39FNIb5j2geOlwQ=;
 b=DLCAxoOzJ/fpYoHWS9CyCZpfqTQWAMiI1YbdJ8nT5Gp28tIqBPv3YGnI8yeghnWSfsb/+1OU0ITErurNsAcxoC1GORm0Hl9ZeTevHFHdc3pc3wTKUXkNtUk3KauWRwR+v51fYBFkNn8CDq5LuMI52EX58rOVaX5FIGwfXVc/DBJ+hfvt5eOgLlmBjeW9o8dJHeCkUYAtvK+W05+Yv8SfY6f7rm2LCHGZKQvcFs+ogJB53gZzQ/dl1Edho3OPY7pKPlQBGoCRs8gx6AGqnhTIdGAHERS3SOznMc1QQrw1s9hNZwzdhXJmQ2kgMAix0uwSzwyY2Sw0DHvEyh5wEI0nOA==
Received: from DM6PR18CA0017.namprd18.prod.outlook.com (2603:10b6:5:15b::30)
 by BN8PR12MB3619.namprd12.prod.outlook.com (2603:10b6:408:46::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.17; Tue, 17 May
 2022 13:14:01 +0000
Received: from DM6NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:15b:cafe::7) by DM6PR18CA0017.outlook.office365.com
 (2603:10b6:5:15b::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13 via Frontend
 Transport; Tue, 17 May 2022 13:14:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 DM6NAM11FT031.mail.protection.outlook.com (10.13.172.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5250.13 via Frontend Transport; Tue, 17 May 2022 13:14:01 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Tue, 17 May
 2022 13:14:00 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 17 May
 2022 06:13:59 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.986.22 via Frontend Transport; Tue, 17 May
 2022 06:13:57 -0700
From:   Eli Cohen <elic@nvidia.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>
CC:     <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <si-wei.liu@oracle.com>,
        Eli Cohen <elic@nvidia.com>
Subject: [PATCH v7 3/5] net/vdpa: Use readers/writers semaphore instead of mutex
Date:   Tue, 17 May 2022 16:13:46 +0300
Message-ID: <20220517131348.498421-4-elic@nvidia.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220517131348.498421-1-elic@nvidia.com>
References: <20220517131348.498421-1-elic@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ec95bea3-4449-44c3-7eeb-08da38071bf6
X-MS-TrafficTypeDiagnostic: BN8PR12MB3619:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB36191312522AB5D0D689A113ABCE9@BN8PR12MB3619.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AUox9JppODhN4vRZY4rnYsP/y0q4Q4C3Ljz8fRQQWLtkYV0G8TGd+JZ7RuFlfUWV2Snh+BGQI6gdAh4vtjRISLsU/jJuVL/dGkZ8+8TveXZzVkrcB2ONlqZ11gBdflT9YkRrM8FOhormAZtAEbwzZBgf+jlGt+vww0+hn3QwBxGEt03BdGs9/kH7AfAMfBZjE6I94KjYUcxfJtc8sd1aDWNtencIbJoXkGk3W4zKL8LR4j0Zm1Y/47VsVBSoCXZO18N1Oz4mwtfzvxUjPSCaOFZbk5+wZchV2o9+CfpnfRMlc2oppkaT3pwSajYsOJwHKWawvfTliQWEV9V4yCy0ameX8Zbo0GWe8xzQDAFXEwCCI7PFMs2SJePcvcs1zWFSTuyB9TSkKMdt0pBHMuiyVZYAqFVBHRUA7RJWsh5zpfn0iIMiacXbbMP3n6b+cNAoce/TpXi0I9wip9mgQI4dJQnRL8zWikRozlLN2vkZDtco5/C6YrtPf90BCvPyXiFc0UqKvzcZGr9wRG5ot3XG3Sn9BjukChW8/gyiZ9qUZm77xkTGktIWRIALsTGWENTe3HdMpQeKwTCpPGQFLI8hXM3lncJXNmIqK13Kxvt5Pwb7aVf1+XLp8qgdcDVgxbxRBrn6Cg1c8KK9nF4XVNYAnjnzlWi9/SU6P97av3NxJCj4jZNJINE9/aMkAOnS2TzDoO0DovREbI+5lnG/oW7i3w==
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(316002)(36756003)(36860700001)(81166007)(8676002)(4326008)(7696005)(86362001)(6666004)(2906002)(5660300002)(70206006)(2616005)(356005)(1076003)(107886003)(54906003)(186003)(40460700003)(110136005)(82310400005)(8936002)(508600001)(83380400001)(70586007)(26005)(426003)(336012)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2022 13:14:01.0162
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec95bea3-4449-44c3-7eeb-08da38071bf6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3619
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
index 1b810961ccc3..510a82c2bae6 100644
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
@@ -1029,7 +1029,7 @@ static int vdpa_nl_cmd_dev_config_get_doit(struct sk_buff *skb, struct genl_info
 	if (!msg)
 		return -ENOMEM;
 
-	mutex_lock(&vdpa_dev_mutex);
+	down_read(&vdpa_dev_lock);
 	dev = bus_find_device(&vdpa_bus, NULL, devname, vdpa_name_match);
 	if (!dev) {
 		NL_SET_ERR_MSG_MOD(info->extack, "device not found");
@@ -1050,7 +1050,7 @@ static int vdpa_nl_cmd_dev_config_get_doit(struct sk_buff *skb, struct genl_info
 mdev_err:
 	put_device(dev);
 dev_err:
-	mutex_unlock(&vdpa_dev_mutex);
+	up_read(&vdpa_dev_lock);
 	if (err)
 		nlmsg_free(msg);
 	return err;
@@ -1088,9 +1088,9 @@ vdpa_nl_cmd_dev_config_get_dumpit(struct sk_buff *msg, struct netlink_callback *
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
@@ -1117,7 +1117,7 @@ static int vdpa_nl_cmd_dev_stats_get_doit(struct sk_buff *skb,
 		return -ENOMEM;
 
 	index = nla_get_u32(info->attrs[VDPA_ATTR_DEV_QUEUE_INDEX]);
-	mutex_lock(&vdpa_dev_mutex);
+	down_read(&vdpa_dev_lock);
 	dev = bus_find_device(&vdpa_bus, NULL, devname, vdpa_name_match);
 	if (!dev) {
 		NL_SET_ERR_MSG_MOD(info->extack, "device not found");
@@ -1137,7 +1137,7 @@ static int vdpa_nl_cmd_dev_stats_get_doit(struct sk_buff *skb,
 	err = genlmsg_reply(msg, info);
 
 	put_device(dev);
-	mutex_unlock(&vdpa_dev_mutex);
+	up_read(&vdpa_dev_lock);
 
 	return err;
 
@@ -1145,7 +1145,7 @@ static int vdpa_nl_cmd_dev_stats_get_doit(struct sk_buff *skb,
 	put_device(dev);
 dev_err:
 	nlmsg_free(msg);
-	mutex_unlock(&vdpa_dev_mutex);
+	up_read(&vdpa_dev_lock);
 	return err;
 }
 
-- 
2.35.1

