Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB87A52BD34
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 16:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238015AbiERNiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 09:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236417AbiERNiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 09:38:15 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E228A16D10A
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 06:38:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MTtaMSCgRP/2LDEKqGJfFIBCgST9OPUYJl0U46P1mLiMgNbhsxYtQp4Bno8Lr+RyEBjAfxPWffOgl9Sycvbn9dw+uN5rC872P/kJSv3mPRK8o5BDVgsZoaATGfWQiljtk6QKIOreJNMXwgqtj3gf89boHH6PxplJ1Fu0hNI4u7c2IrxBs3lIV9YLyuTsM9lNZGGKzU3nGK6H16JRIV2Ad3PW+VgE9xDbzYGp5iMTc6kPJNhVlmBU01Kie8aTRo3laHSU10uyTIw7bhR9QRJUj2cuNdpbgRiyWm/FM6RLdvttecsy62j5gag0Fhm7M5UnVHBdWTokGYlY+1DBAbjEVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hp2CQkeKufDpXiu33CxbPm9FCMw4CDft+U6WNmlxzc8=;
 b=gbn7DPpQy8kydvYfD2CsD0brMEq2Z3TOPPV+NRaywSJI6gMY9JQhdcIUCL6i6mLaZ6q6xtHX4/sCAesNTfY+qRKLS6oc1E08TaITUievgMsR64BQUKe35pnYi55oH/5r00acpEQsMl6G0xOuZdyMJcMrCqWidOj6twm+GiZa4yXd5Z3GtviqC/iGzNL2B8tjrUN76uX4h/7/Z8VWW0R4346qysQirFNlvzcn5CEB+B0uwm9pgIQv6eQbkgKGJmoPW91nTlJw/kqGI2HXiLnCir/zLnuBuvBweK6laB+9MXHaX9uGQA8+ejEFEh8pHAE9ymW9FkZkNcxOz3qa6kW8ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hp2CQkeKufDpXiu33CxbPm9FCMw4CDft+U6WNmlxzc8=;
 b=aN0KBwYrophwxxXSmHF3yXXDFrMYxVh0znwvrg1pVL+k8fXYd8bbHK7vgAJaQzgrn8CtIs5oGLaGsZfJfS5rbUs/rYhEwu8xVspREycQo8Swjul6sA94AFtzrAiusl/Q6n1wtnJmTzGyWDoWlMce4399oVKYlwGJAO8mwIxh7yIFki2UGAycyukHovLm5Y2n90kHmPmSP/duV9bEJ9II0KchuFQhm7xhCWcmzkD6FHaWQTXzvCo8x0nREeA7b1uOGiWLsDqbl8KXe8Bq06Y9lsApHfvSKRnk6xYNZ9NO8+OtWCNBIMFQN2lmw4d8qJyPMYtl1bwU9zB5zp1Hzt50dQ==
Received: from MW4PR04CA0138.namprd04.prod.outlook.com (2603:10b6:303:84::23)
 by CY4PR12MB1862.namprd12.prod.outlook.com (2603:10b6:903:121::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Wed, 18 May
 2022 13:38:12 +0000
Received: from CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:84:cafe::ae) by MW4PR04CA0138.outlook.office365.com
 (2603:10b6:303:84::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18 via Frontend
 Transport; Wed, 18 May 2022 13:38:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.234) by
 CO1NAM11FT026.mail.protection.outlook.com (10.13.175.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5273.14 via Frontend Transport; Wed, 18 May 2022 13:38:12 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Wed, 18 May
 2022 13:38:11 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 18 May
 2022 06:38:10 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.986.22 via Frontend Transport; Wed, 18 May
 2022 06:38:09 -0700
From:   Eli Cohen <elic@nvidia.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>
CC:     <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <si-wei.liu@oracle.com>,
        Eli Cohen <elic@nvidia.com>
Subject: [PATCH v8 1/6] vdpa: Fix error logic in vdpa_nl_cmd_dev_get_doit
Date:   Wed, 18 May 2022 16:37:59 +0300
Message-ID: <20220518133804.1075129-2-elic@nvidia.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220518133804.1075129-1-elic@nvidia.com>
References: <20220518133804.1075129-1-elic@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4b180372-0f07-4b5a-ffb0-08da38d3a744
X-MS-TrafficTypeDiagnostic: CY4PR12MB1862:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB1862DFE08B6349916176040DABD19@CY4PR12MB1862.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jpq+zk7mlk/TY/cQrNspzarbjjM2DdsRgHKoftzQntK8SMDfmw+g7ao0+GLAS5Eex1x8wZyzOZYKhRflSAa49XYsN6YbU0xdiEyDV1OqqwVXxcRvrHGdDcq4s3iYg82I/WXbqYXtbEPUUq+KLyYCEIR05H6Y1itqxPgui7JRK5l5ZDCiBTeWAy3+guRm2rHulcirRco5OyP7BdU/WpoNz/pRiPjL4rTQhmDstSzCShlnlmtUosS5d5X2DJkuopE8QHeXP0cLspWmj9dRcLAer08IrdRMJXsM1MXsIIG1G1VFcxVB5bQYiw+lrOJ5m9cCni4au1NrtaT8P0o7zKmY2txBh+Gafd9VM2EaxfVV6LbeBhbEoWgXFa23b8fv0hO5uYJ6muyrsnspBHjBj/OHEZ1SYjJPBRKJgUHgA/qvcnjh0ndSsTwckz7PpB3uzxKVIJV4bJu1KXdQqircMGnLvyxdDdDXestvoVa3Wa3Ead2uftWXChu4nLtbUI+jnF5/MX73g3VzDQ3PqoHdlzLb+DLGqxmH6R3aw5EiFv9X0Iy+mD/H1NJLkPsMX8bS5gUDacDpvkUM6cAhKY8CuC1gUTPhkmEp0T26Pfub1UwqVFqOZiStBrs/xQzTRae7Al01kq71MKc4mbdfMTqj/IQY8Jv9sak4ahCUxWiLjeOdvVzAwRZoc6za8QaAOQ03SM0GhUe5P/gA118LkezNJ3OrVQ==
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(110136005)(40460700003)(83380400001)(36860700001)(508600001)(8936002)(54906003)(316002)(47076005)(426003)(336012)(86362001)(4326008)(82310400005)(356005)(186003)(2616005)(107886003)(1076003)(8676002)(70586007)(6666004)(70206006)(5660300002)(7696005)(2906002)(36756003)(26005)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2022 13:38:12.0824
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b180372-0f07-4b5a-ffb0-08da38d3a744
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1862
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In vdpa_nl_cmd_dev_get_doit(), if the call to genlmsg_reply() fails we
must not call nlmsg_free() since this is done inside genlmsg_reply().

Fix it.

Fixes: bc0d90ee021f ("vdpa: Enable user to query vdpa device info")
Reviewed-by: Si-Wei Liu <si-wei.liu@oracle.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Eli Cohen <elic@nvidia.com>
---
 drivers/vdpa/vdpa.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index 2b75c00b1005..fac89a0d8178 100644
--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -756,14 +756,19 @@ static int vdpa_nl_cmd_dev_get_doit(struct sk_buff *skb, struct genl_info *info)
 		goto mdev_err;
 	}
 	err = vdpa_dev_fill(vdev, msg, info->snd_portid, info->snd_seq, 0, info->extack);
-	if (!err)
-		err = genlmsg_reply(msg, info);
+	if (err)
+		goto mdev_err;
+
+	err = genlmsg_reply(msg, info);
+	put_device(dev);
+	mutex_unlock(&vdpa_dev_mutex);
+	return err;
+
 mdev_err:
 	put_device(dev);
 err:
 	mutex_unlock(&vdpa_dev_mutex);
-	if (err)
-		nlmsg_free(msg);
+	nlmsg_free(msg);
 	return err;
 }
 
-- 
2.35.1

