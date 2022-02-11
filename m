Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B04964B2F12
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 22:08:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353691AbiBKVGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 16:06:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233114AbiBKVGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 16:06:12 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08on2087.outbound.protection.outlook.com [40.107.100.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D222D3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 13:06:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ay+z5HmCNkmsEFwh94GPP6hQnUymuhPKFuYlZv578GtxQVrNVCi+2dMoyRMy6z7Bkt0yxsCJTU4KtBaG1Quyg3kAtPqnOuzxHkmC4JROV+IYIRuM94v8Q38I7cVB8XTnOLU7gDp07g5yg1+dylWEewe5AzvDtnFS89y894iuB9tKI8L/Up10IsakMT+ZB+Wky4DZk5Mvvf7CIye8usrMoIqaweZbIHKH80dOmlwoIS01Wm5io4RTh6dh4QeUjNP2lKMssxxwuSZ407F7X+s0n7cyCvWBEW7ARdi1+qDuBm40RqvrevIxppox2nRM7RtIk25NP7QEsSTCycBN1+MtOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/HrPn1mvJ2yLsE/t3LsXh3S2l1KD25pdkfq3UKQgvKQ=;
 b=AFy7CAv5OjzmMFuZQG4ukxbbyjdHKlk49BAWz2f/4bdS94HWxDbSvsOOs3AT12NtJUTnJp4LsM5fVzgPrmwlrapb9DH4orUOm6lxvwwz1eJ/Wvjo2c2tgW8Rfy9cGqnwjWkeXFWqLk8vZ8OOwBGDrRWTg4TzbHmWjNLy2dOPsjseSZrgW0MnnDOn1j3XLJ45fmwl8ea95JEGqQkcA1b6qF8QH8HvWSupvyzfiEnA8aBfHhn2UMbZM/0tUVzvwQcZX4S8nYjuIx8YtsUSOWtRzQDKTxkFn5puAKE1gfIaHJRQleA0duD7iJNrFGB6qoQfHzMjVqd2QgX/wJBgc+Fi8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/HrPn1mvJ2yLsE/t3LsXh3S2l1KD25pdkfq3UKQgvKQ=;
 b=TeOLSBDN1VO3PIsarbGjJ+OsOtXF97BDYpfdekfos1hhA8Y/dh93lebpSn0Oxdtq8s7LGWOrIPBqLVukAO9H94RvjjDjNuHZ9ZuTwVLOaejKExeNYuJahCk1qVY4CysBFEMu25h2g2okmTGmJAZm33Ret8kvjvrNSZmaMdC5Wbc=
Received: from BN9PR03CA0973.namprd03.prod.outlook.com (2603:10b6:408:109::18)
 by MWHPR12MB1789.namprd12.prod.outlook.com (2603:10b6:300:112::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.17; Fri, 11 Feb
 2022 21:06:08 +0000
Received: from BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:109:cafe::fc) by BN9PR03CA0973.outlook.office365.com
 (2603:10b6:408:109::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11 via Frontend
 Transport; Fri, 11 Feb 2022 21:06:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT019.mail.protection.outlook.com (10.13.176.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Fri, 11 Feb 2022 21:06:06 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 11 Feb
 2022 15:06:06 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>
CC:     Kees Cook <keescook@chromium.org>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        <hughsient@gmail.com>,
        Martin Fernandez <martin.fernandez@eclypsium.com>,
        <linux-kernel@vger.kernel.org>,
        "Brijesh Singh" <brijesh.singh@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v2 0/4] Only export SME/SEV/SEV_ES features when activated
Date:   Fri, 11 Feb 2022 15:02:51 -0600
Message-ID: <20220211210255.9820-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 14f7b6f6-85b2-4de6-996d-08d9eda2522f
X-MS-TrafficTypeDiagnostic: MWHPR12MB1789:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB1789826E798CE163C72B9FDAE2309@MWHPR12MB1789.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lhRBTkOOnUvtJtyLP3u+yxgpFv38rNjaRly5G2LIoETEj1KcPcqv4f6Aip7cSqMmmlG3f8wyXo0gA5v8aMxNKxzpczNvxCyP6AtqiVcVQqHOE14DxUO77VDNlGmU3Nc2sdB0H50qF0DMvKGMGhov2fyis0VYNhPH4+iCjmOubK6SF/L8815ewxHgoB0l2lakBkZ+TEo22HRy3BldENqoHeFFS4DSoXf8bywn90p2HHS/qiyrIfWwEJrcXbTC2sVVulS93nSM2ZD2OGBI4BbaPokcgGawtKhUuXCwtuWg6+e5FWVEAMedRlBg6n3ycpp7Pafc6rjnWGkCghNKRosajBFjZFuveCb8fGwA3FYyWx/1gXaOpD4ANY65ks/HQPWKXIAYC7JfpdcF/IqZ7IOuhlv1m7aMYHQGyQEvadZyI2J5Yg5GIg8m4xmvQyP9OcUbmZ4DTKZI44tyLy5UwqmV+xjqsGq3TVv7TQF4kARMT5R16cjMaRqAVHj9pZir4t6TY6EhlKixUsS3pPUBUUUWfL69wUaGAUkPnyXYyb4XhSCYjopDgli4jOMl3sY6pMk5TiD3MdYSZCV8j7NFsseDtP/1fZU10YVvIK0gM1VL9UJVAmobDC5nSQ4WxEmWjIf/azJD12OPF5t2BUU81hbPE3D8X4YM/o31XHYWACTcmOgGgNsWK/oPKviR2ddRcBqtZdwiBmuWrMN6kRexsbPzvg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(2906002)(82310400004)(83380400001)(1076003)(16526019)(426003)(186003)(336012)(26005)(44832011)(2616005)(6666004)(36860700001)(47076005)(40460700003)(8676002)(8936002)(54906003)(5660300002)(110136005)(86362001)(316002)(70586007)(70206006)(81166007)(356005)(36756003)(4326008)(508600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 21:06:06.8190
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14f7b6f6-85b2-4de6-996d-08d9eda2522f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1789
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently SME/SEV/SEV_ES feature flags will export if the CPU supports
them but even if the kernel has not enabled the features for any reason.

To let userspace react to these feature flags, only set them when the
kernel has activated them.

changes from v1->v2:
 * Squash old patches 1/2 together
 * Add new patches to KVM/CCP code to use `cc_platform_has` instead
 * Don't use `cc_platform_has` in the early code, just check `sme_me_mask`
   and `sev_status` directly.
 * Split out SME and SEV/SEV_ES clearing as separate patches in case
   SEV/SEV_ES need other more involved work that what is in this series so
   far.

Mario Limonciello (4):
  crypto: ccp: Use cc_platform_has to determine SEV presence
  KVM: SVM: Use cc_platform_has instead of CPU feature flags
  x86/cpu: clear SME features when not in use
  x86/cpu: clear SEV/SEV_ES features when not in use

 arch/x86/kernel/cpu/amd.c    | 10 ++++++++++
 arch/x86/kernel/process.c    |  5 ++++-
 arch/x86/kvm/svm/sev.c       |  4 ++--
 drivers/crypto/ccp/sev-dev.c |  2 +-
 4 files changed, 17 insertions(+), 4 deletions(-)

-- 
2.34.1

