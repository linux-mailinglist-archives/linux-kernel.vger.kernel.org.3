Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9134B2F19
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 22:08:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353706AbiBKVGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 16:06:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353681AbiBKVGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 16:06:13 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2083.outbound.protection.outlook.com [40.107.236.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A5F2D3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 13:06:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TiGX9U46772h82HsHOv7KQLr5J859veCEADCQXbAEEVH9Z5z1y17TvXMHCOFZ5SW0AquwumKBF0FUQGQihoEIsbclhgm6uEmypQNExAfycwjyKD2U4uqzypX46qQ+9G1uGvWcve7LfCgSrkdHjhM6Zk+qA9g2NkFcsvdQc8qxFcDh0oH02em5GCWMVciOCNZOOcmFr9i4LdH2B/mgzFCWMibYiYNnFq/Cn/R8SsojrVEhAz+VowZ8jFp0uXJc7Iy5iA16Oi2V4f1RsmsD7to9+f2dIp3HaSJmj3EOW5cVYHSIqqpFXk2f0NKim77BWpY/dXJ3baVBDN3yFahng2/8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ffWasgJ6Jh4cc1Xc3Eab+SwyAEnO9S0VmIWUJJUOP4=;
 b=TFuNPBhhmumJ7sgDXQV7dOAL+gdWQ7h5g/LXtavIsu9TKAGGVjvInImqcu0uUZ74a6CCClVNNuDcZgf6GWWM+c0UnyqNKa9ywvRdM9fxBawtrg97ICmZdVSHHhE/I4vwJaLgH+5Ld2ObgpklMNxx8KlvFYJrrB0BdH/iadcJv4CWUrHAvVJ/Fd6jTA8D+Y80sdS4snSmIVTJDsMtxDY8ADQid2LlYX6y0FmKnzUcjrY8NxIRGzwzlXl5uVxJkrDaxaeOdGJsdgSJEC6VzkISr55IZ/N4oGDsCYqfCDsiDTpW7Q2RSsEXBr9z8+46OzQUvg39dSMw6f3a6Qqd21+INQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ffWasgJ6Jh4cc1Xc3Eab+SwyAEnO9S0VmIWUJJUOP4=;
 b=mrnhUnupQKUx51h3bZ09Qv95RLDD5p+NhdbRXlvwXUPGIXXZnQOINzrQTJJBF8LvRjMWiPfn6k3VLF/MBAPn3WmGWIQM7l/JTsF3aLP8Woz4jnZmW99oPFJ7E/3NReuhZSLNpvJFgjlvFae2LwNuNzF1C8+jMHm2ZtYH/xhg9IY=
Received: from BN9PR03CA0978.namprd03.prod.outlook.com (2603:10b6:408:109::23)
 by MWHPR1201MB0126.namprd12.prod.outlook.com (2603:10b6:301:57::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.14; Fri, 11 Feb
 2022 21:06:09 +0000
Received: from BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:109:cafe::1f) by BN9PR03CA0978.outlook.office365.com
 (2603:10b6:408:109::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11 via Frontend
 Transport; Fri, 11 Feb 2022 21:06:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT019.mail.protection.outlook.com (10.13.176.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Fri, 11 Feb 2022 21:06:08 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 11 Feb
 2022 15:06:07 -0600
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
Subject: [PATCH v2 2/4] KVM: SVM: Use cc_platform_has instead of CPU feature flags
Date:   Fri, 11 Feb 2022 15:02:53 -0600
Message-ID: <20220211210255.9820-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220211210255.9820-1-mario.limonciello@amd.com>
References: <20220211210255.9820-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5b900485-28cb-4fad-fea7-08d9eda2533c
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0126:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1201MB0126DC466FEE4A63EE35084DE2309@MWHPR1201MB0126.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5a8OmJJPvKkEbyPKde+zesjiZ3R+1Jwd8DlJzbBCtjep8PJUsWv1TjpjKFhFaBfYc36IFQr8EANc9ZuqIgl+qs9Xq19/I4lbeUaRjEzjrbLHWJUhelSNuY0lVg7i5V4zy2Z2IH4mfMOnstX3+Tmh1YsecJZPmhc0UFcu/ZGTiLrt9aA5Uz/GzntH66KGVLxsy6vcS6SPr+jrmHmNC9mCMNWGVSsAbaMWhvahKVF0xMjtTA4rnBmJQ6dxwZ2HROAfHrJte4c2s4glx5aDk5Fx90rhJN3Jt/Ul/m9GRQgk9TT+dX9W8Y6DV2bA4A6jv61zDoRDNGcJaFUCFxvRcr+9/7FPYtgomyUEDvoSCnL9tQ+TDUqRlVFGKQYxv246w8fXW0FH6ZAA1BIHl/rbVNXxTUroemVIeR2t+Po3mS99nW/4RX4bZ6TCkdAZgUuq1nw11EcPeiQ9OcWH5tn5bP8TKoSfv/wHcGV2JIyw8TJiX2a/JoIKkGY0365b7JmBa/ZfSWUUzsSOuLJiKnISBn/udVQU3iuBYq60HF2G2gVe014h17slsDuKyUwIuRXTvQ94rjA36iy/5Cfe3Y4XOU0InbUxr8XpPUf/ppEbRjOluKcxfWvTvuOOF79ZEMtfZML1FjKTcVvIl97M6mHvnW8nNUThyZEmBjkoqgnodzyQ0inI07Pq48+uFqYwM2LZalGr+LePuCKdXw7hOJOgpd2B5Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(36860700001)(83380400001)(47076005)(336012)(2906002)(36756003)(426003)(2616005)(26005)(16526019)(186003)(40460700003)(1076003)(81166007)(356005)(82310400004)(6666004)(508600001)(316002)(86362001)(110136005)(8936002)(54906003)(4326008)(8676002)(44832011)(70586007)(5660300002)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 21:06:08.5845
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b900485-28cb-4fad-fea7-08d9eda2533c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0126
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CPU feature flags may have been cleared earlier by the kernel
if the BIOS didn't activate features.  Instead use `cc_platform_has`
to determine that SEV was enabled.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 arch/x86/kvm/svm/sev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 17b53457d866..d3d1ec78d927 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -2105,7 +2105,7 @@ void __init sev_hardware_setup(void)
 	 * CPU supports decode assists, which is mandatory for SEV guests to
 	 * support instruction emulation.
 	 */
-	if (!boot_cpu_has(X86_FEATURE_SEV) ||
+	if (!cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) ||
 	    WARN_ON_ONCE(!boot_cpu_has(X86_FEATURE_DECODEASSISTS)))
 		goto out;
 
@@ -2153,7 +2153,7 @@ void __init sev_hardware_setup(void)
 		goto out;
 
 	/* Does the CPU support SEV-ES? */
-	if (!boot_cpu_has(X86_FEATURE_SEV_ES))
+	if (!cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT))
 		goto out;
 
 	/* Has the system been allocated ASIDs for SEV-ES? */
-- 
2.34.1

