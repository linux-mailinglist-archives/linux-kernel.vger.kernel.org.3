Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9F4D4ADFD2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 18:42:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384346AbiBHRkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 12:40:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232364AbiBHRkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 12:40:45 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2064.outbound.protection.outlook.com [40.107.244.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50C4EC06174F
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 09:40:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nrkMcDf39TNEDAwhpkbRFFq2lodS8MO9qYEJN0UeqU2cd/2AYafboyUUdsw7ZT7OqrOYPNL4Qiq8mk6th4NN4ddKLVq88xKbatzAVB/NNStqxGoN5GcVfcD0SFVCN2k0Togk0cEXd0CDpXCT15snBUWSYQfpcxMDplOO7lg6loW1HivYHSA0UeJHcBhZzeZYQARnUqkMN2HVQtv4Rjhr8Sv2NjgzGBFSpoLVFKJc9ek8zLBl0soWWS8c3bssWDWHEHfKuKnuJ3t+3ZwxwVDFsu3dSDXAOIOy+sFVAazHbGG3MjGARKggzTN9Stxyn6jbqxETfjOPY+JFoVgIPEoMSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vE/aSH8kntzLTJH8oTvR53EaEAWFNx83KbZFKDXAa9M=;
 b=XACXZl9DqnjRsE+zCe75FS2AiFxiV/qDGqoqIWsUN3HevOZpCs/qYIBwuDJgTuo5dSLk94IkDLJYvThOkTtJmKicjwKhdVVN0diaIKsAcp4RvOVaC9LI/iYwYr1Vjr2/7+H+CuPTHIPoWfq+Hali6ABKV5dpXs1qCf2Kljdlt7slrrDxK76Uf+OgoFBg0vcTXTAZ7pRdxXpzEroy7YBTw3h9fHg0K9lABsuR7vyBAEJRXqlXd7HfcKDPakimQWCi4UUF0mXqZA1QSZBScz2ryzHfakgIVtpzIKexNSAOn8M1Dlk0mCqQGkdUVe0RmY6RKKqXji9UQaJWDZ98BT2tig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=android.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vE/aSH8kntzLTJH8oTvR53EaEAWFNx83KbZFKDXAa9M=;
 b=dpt2d55o45DZt6NaaNgsuusodov/6DabbZ+N3B//Fzo4U5PBMtSdJVuLqv/Qr/S/YnBtrzbCYPdBQVRrHd2a8zXUU0/0QSDtj/uJyDOf6E1Qc0HeP8aP0Jg0zf96prdDKcKgAILaIQgsCLdiNfnEqnNU+as+mkZUYR0xXUEmTnQ=
Received: from DM5PR10CA0010.namprd10.prod.outlook.com (2603:10b6:4:2::20) by
 DM6PR12MB4730.namprd12.prod.outlook.com (2603:10b6:5:30::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4951.18; Tue, 8 Feb 2022 17:40:42 +0000
Received: from DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:2:cafe::81) by DM5PR10CA0010.outlook.office365.com
 (2603:10b6:4:2::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12 via Frontend
 Transport; Tue, 8 Feb 2022 17:40:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT068.mail.protection.outlook.com (10.13.173.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Tue, 8 Feb 2022 17:40:42 +0000
Received: from ethanolx1ade-milan-b0-babu.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Tue, 8 Feb 2022 11:40:41 -0600
From:   Carlos Bilbao <carlos.bilbao@amd.com>
To:     <arve@android.com>, <tkjos@android.com>, <maco@android.com>,
        <joel@joelfernandes.org>, <christian@brauner.io>,
        <hridya@google.com>, <surenb@google.com>
CC:     <linux-kernel@vger.kernel.org>, <bilbao@vt.edu>,
        Carlos Bilbao <carlos.bilbao@amd.com>
Subject: [PATCH] binder: Fix misspelled words in two files
Date:   Tue, 8 Feb 2022 11:40:24 -0600
Message-ID: <20220208174023.868438-1-carlos.bilbao@amd.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5ff2fb3d-d65f-4fef-a785-08d9eb2a20e3
X-MS-TrafficTypeDiagnostic: DM6PR12MB4730:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB47309022F16207F9E9C3AB58F82D9@DM6PR12MB4730.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YkB1eAZOu9cuijuyJviaZdK0Xj5mX+ti4n7X9IVDWBIEGLlgLL/5u9Jerg+jZahUYDkh9znWeFGbGMNJ9EaRFHOQw9KpTRJ8DDhhkzX/MdDlTkO6oPPl3c6cvcNoOEaBs9wub3JtXrf//7zSNBYEqvQMb5R8B1udX7brcqwCfqKu9t4+hTZs63bDkFE1JjOIZj1S1PyEvoVxrJbI5KqY4fOQcMEr271IubhTAcIKHcj7JBRCpOLU4bVLu3e2N86aRuZSsB+eM+1P7tgkc6W0JpANE77MAXaNKGHnppWMjUIymLad9nghTuJlG7/lq4iW5Z+wSrYmPDMzGRN17NBckO0ofBYQdPBkCojZT7NdboSGa/PGg9ZSm/Sno576sd872ahOpkj8DQK57pcwM51cm5Loe/CxiRCHW8Pv59jzr1Nef/z+ocXUyr7yMoOS2sIOJ/ANEt2k+9ciDuVUUpCFV/n+e79XzXAA2H//nwB+E7UU/qTWDs8ilZfUDeJkFBTLqfGusOyzyOzXTG1sPXWdt+mjFpuaXC7WlHsfKYp4YKqiywWP4R1yJdJ+MXvsf9ouV4DYzx0/0JMgcDNoZKtTjKWE2J4/NmQ+zU4NpB+tXosgRl74Y9nLgTWU8M3FW4XAfbgLjW8gSEegF/AT1k3hBdRpXSoMHIuXSy2e9DVhFVdzpYMzwASSmmPPOEPNU+0s3LhoclWUdZKt09Kys5Z1Uw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(81166007)(316002)(110136005)(70586007)(70206006)(508600001)(6666004)(8936002)(54906003)(8676002)(4326008)(426003)(356005)(86362001)(7696005)(36756003)(47076005)(2616005)(16526019)(336012)(82310400004)(2906002)(36860700001)(40460700003)(186003)(44832011)(83380400001)(26005)(1076003)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2022 17:40:42.1486
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ff2fb3d-d65f-4fef-a785-08d9eb2a20e3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4730
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a few words misspelled in binder.c and binderfs.c.

Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
---
 drivers/android/binder.c   | 2 +-
 drivers/android/binderfs.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 49fb74196d02..87b35074b01f 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -1394,7 +1394,7 @@ static void binder_thread_dec_tmpref(struct binder_thread *thread)
  * by threads that are being released. When done with the binder_proc,
  * this function is called to decrement the counter and free the
  * proc if appropriate (proc has been released, all threads have
- * been released and not currenly in-use to process a transaction).
+ * been released and not currently in-use to process a transaction).
  */
 static void binder_proc_dec_tmpref(struct binder_proc *proc)
 {
diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
index e3605cdd4335..3a7ce5117881 100644
--- a/drivers/android/binderfs.c
+++ b/drivers/android/binderfs.c
@@ -93,7 +93,7 @@ bool is_binderfs_device(const struct inode *inode)
 /**
  * binderfs_binder_device_create - allocate inode from super block of a
  *                                 binderfs mount
- * @ref_inode: inode from wich the super block will be taken
+ * @ref_inode: inode from which the super block will be taken
  * @userp:     buffer to copy information about new device for userspace to
  * @req:       struct binderfs_device as copied from userspace
  *
@@ -159,7 +159,7 @@ static int binderfs_binder_device_create(struct inode *ref_inode,
 	inode->i_uid = info->root_uid;
 	inode->i_gid = info->root_gid;
 
-	req->name[BINDERFS_MAX_NAME] = '\0'; /* NUL-terminate */
+	req->name[BINDERFS_MAX_NAME] = '\0'; /* NULL-terminate */
 	name_len = strlen(req->name);
 	/* Make sure to include terminating NUL byte */
 	name = kmemdup(req->name, name_len + 1, GFP_KERNEL);
-- 
2.27.0

