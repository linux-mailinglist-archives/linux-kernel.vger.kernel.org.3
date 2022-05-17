Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C50C52A2FE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 15:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232369AbiEQNO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 09:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347356AbiEQNOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 09:14:06 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCFB5419A6
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 06:14:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UJm7oWh2bu8SoTRU3HPS2JLhRnLbBjAm9xzsmlqNI0mU7Rtpgv7RZj6MOtgMeeNli3V5jTHBWBJ/bB7wgA9wjcEGaIFvZWYsxyPiNIP61TvjrXUskHEJauKb/yI4mZYexuHrbtEZMBPMQ5QmqFKWILQ+UR5/o18uhUGOk/+Vt8e0jkFt8PCr3uEkQLrcQYrGq7pUCEQD3kkaqTxeememslV1CPYGajqNESlnXBxWZHf91zBQRHnilRrdoTbD6eJX07MtGgn/IXv1DsD76T/AITqcC8iKM3XbV03pKXvHPHRTogAsjCgZ0oKQsRaVPK88hpj8goz5MPieMNaJU4eEAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hp2CQkeKufDpXiu33CxbPm9FCMw4CDft+U6WNmlxzc8=;
 b=WTNkb3qzYlJADiqWum8H+BZqxJ5ELqn4JrR2WQPvyB2hT42MYijrs1RhbKBcl6fRme/qa8uWFQcH7QoQ3acLJPQemihL2zq1ZkGlXN5QA/rdgmTq3FvPd5wQ0zzUOKz1u62neOcAqN+yKZmGXCEABxHxd/LPAby7alyKwQx+Jv6bwL8bh4DIyT/WA4qdRKD3Zwqx+VgIEvs+n+erFZKqSxSyZgMPQ7fSfFZE7Q4ALAo7S9Rbg72bgMcIH0d4skQwpmF+VeVhksm1vIQp8Y3k6t5tLQIFPD1lUW3b3zkIpws9TwQLcVZoHsGh53Ieneon9kZOU9AK0kgSOHtMHRIKZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hp2CQkeKufDpXiu33CxbPm9FCMw4CDft+U6WNmlxzc8=;
 b=V6guPVxcdHKvv0oJHVATh7N9kO0WQM0IzSGVGv8HZGFCySMvifdPp39bQxbQ4ib0x0rlYr4UwGxLhCG72cmScXNTWXMxA9yAzZVa1F/X7MjPonBWB9VSt4EUceUlm9xzAi59hoOe3uEOVVj/BCW1HEV6RnsnGMD9r1nZU8uk9W6RtzD1TGpZKd68+WrzKFFrPxgBBAB8/kpTM13F6YXWvA+/g7FdMVy0xfMyogW8i3nMjkopZjWyrIXRjSDK8rhV1ViJJYGXZfsVi80uHjFOvNY8QQCR0tbaH0UShZSweRMjyItEcJou2b4thW+aC1iSKYvuxF0svbnjaU8p8NmLRA==
Received: from BN9PR03CA0543.namprd03.prod.outlook.com (2603:10b6:408:138::8)
 by MWHPR12MB1245.namprd12.prod.outlook.com (2603:10b6:300:13::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.15; Tue, 17 May
 2022 13:14:02 +0000
Received: from BN8NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:138:cafe::cf) by BN9PR03CA0543.outlook.office365.com
 (2603:10b6:408:138::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.15 via Frontend
 Transport; Tue, 17 May 2022 13:13:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 BN8NAM11FT003.mail.protection.outlook.com (10.13.177.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5250.13 via Frontend Transport; Tue, 17 May 2022 13:13:56 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Tue, 17 May
 2022 13:13:55 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 17 May
 2022 06:13:54 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.986.22 via Frontend Transport; Tue, 17 May
 2022 06:13:53 -0700
From:   Eli Cohen <elic@nvidia.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>
CC:     <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <si-wei.liu@oracle.com>,
        Eli Cohen <elic@nvidia.com>
Subject: [PATCH v7 1/5] vdpa: Fix error logic in vdpa_nl_cmd_dev_get_doit
Date:   Tue, 17 May 2022 16:13:44 +0300
Message-ID: <20220517131348.498421-2-elic@nvidia.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220517131348.498421-1-elic@nvidia.com>
References: <20220517131348.498421-1-elic@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dcfc7f22-e9a7-4e3a-bc7d-08da38071936
X-MS-TrafficTypeDiagnostic: MWHPR12MB1245:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB12450F822C5CF5373AB21D30ABCE9@MWHPR12MB1245.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: arL523cJnI0rrVd8tV495ZeHbLdI+NYdui2p8tEskGg8OKXYQf/dHvU4fw3QfnwMDpgSiPMG6Vxw8OzoWVMFLR9jZnJb5s4iB1IJZrNoYmQaOa7jHAus+He5gYzikOevMPWf8mLTpgzbn4h6pra/jJ0z9bUQF3VGFqWZbLhDRJ5GDiiwPxpKWw+VfEweMoYseEs/MEfVQA0kbCb691hVmKbsarovLuCXky3YQskFHyFXalda0ZTI8vZ1ZHCU9+D6+O10hVpdDOEsm96hPWJ1DryVBdk1OJjxqlXS3trW+uJ+JqwMX6ju6qX+X/g/zS00LjIBpzuQj/YB+xipg0l+Roj2nDL2no+ZJCFn47bxy3uH/N3mzz6lSjEHs8M2SW/QgZBPRO0IIpAq+Xow2kHCUFAE4zNtmoq9vgOTwjAEOaBZTMKrMODxxKX9MUSY4hy+9VofkmJygI2+atqBqqy/Gs2jO109vPlO5VSb80Q78pmkHK7ElKdHyeXKU6FjBxiBlTYykvVrgWY4HZyDwHYU76sx7o1XPiWHxCFCHfCV6gDjyrOzAZAOHxhGXuIyw2iuzJshY0TzWfj0u4levQTtCDdEN5NHwaRB9IFGnvP0crw1TZzPzKfo3K860Onz4CdZrsXhy1zqjOKAZRRGX2sw9RWGNXChL53SgXagKVX0ihoEnNxqQdWlGwjvdTifaMq3sZ1BU+JdYrwYgc/Y9SSnMQ==
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(107886003)(82310400005)(36860700001)(2616005)(70586007)(47076005)(336012)(40460700003)(36756003)(1076003)(186003)(70206006)(426003)(81166007)(316002)(2906002)(7696005)(6666004)(26005)(110136005)(8676002)(508600001)(83380400001)(4326008)(5660300002)(356005)(8936002)(54906003)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2022 13:13:56.3728
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dcfc7f22-e9a7-4e3a-bc7d-08da38071936
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1245
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

