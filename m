Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88F42505C50
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 18:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346051AbiDRQTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 12:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238135AbiDRQTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 12:19:07 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2047.outbound.protection.outlook.com [40.107.96.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D92135F8E
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 09:16:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NZc63K7jzGXgMg9TLRCLTDLZkMfCpziWqJdbap7qcK6yCpjikFCTpfGstlz5yjg1psk6L0jm2LUtQYqEBhSL/IWp2bo1qlj15ZRZTJv/i17xaXJZond+Ulh25BNWigc604qB7VCIh2zB9FA5zE6NTo7TZ2TPlJe5qIagv3QmwVt86FS66MmNl1qbMlvulIChMLTQhtrTPAf6fj6QhOEpUBIUm+DNpAtkMA5315ypPqiOwht1u7opjsRe+3ee+eUNJjRCkYOL6zJZnDSeMpJ5GRbz0SB5u6LKN0EcDLMcobAvZEykrbinDeJBO2sB7jiR3Z3pz6ztmHyrKqlDVfdgJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TiLIrLdTeJchuPW+ErHkipzDdDwk953CoaSwVIK+sbs=;
 b=K8EtFV2Mn4qMmzyLk5VJREDl2R13Fo7qdDJGvJH9mM8pzTTd5FPA/7qeK2p+q9++nEBm6VyH8NqkQi3UuuClk6EbAApXDRsJ+ouofSvmHk0Kdv22JifXQpkslNOyryIZDbfrsbcwHWl+B8SOWmC/bSVwrgx9R89BNqUfDlsudAlEeQRBLJLg0J6hGJ6bNRIPLzuySd0SEpCMVy6cSBm6dXV5WUI8OEUqeHHNjQw3FZy5GtzuHO9NREgeCwH+8wQ80vZPedu8HlIqP/6e4cC7FL/kuI6qin90mZcImKEXjIPbd6XfHQVXkoLo0Ab98B447QXSBq2+7dA79cMw3vQ/MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TiLIrLdTeJchuPW+ErHkipzDdDwk953CoaSwVIK+sbs=;
 b=zfx3b1/MCzOJyyY+VVlQHyKP8jRcfNn4ozEIW+QQor2+UbJpAv31pmW1pzWF8DfX2LjOLGwvtziV2as3Hx5pWuD0/Jao4rD+fwtHaiCyIdfGcPkByN9vfUEkXiQ2r8XXZURJJvtlQlc4hBUOULbAE8J8y9nxtiFVgcxcAKouZ24=
Received: from MW4P220CA0008.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::13)
 by DM6PR12MB4498.namprd12.prod.outlook.com (2603:10b6:5:2a2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18; Mon, 18 Apr
 2022 16:16:25 +0000
Received: from CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:115:cafe::27) by MW4P220CA0008.outlook.office365.com
 (2603:10b6:303:115::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20 via Frontend
 Transport; Mon, 18 Apr 2022 16:16:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT039.mail.protection.outlook.com (10.13.174.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5164.19 via Frontend Transport; Mon, 18 Apr 2022 16:16:25 +0000
Received: from tlendack-t1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 18 Apr
 2022 11:16:23 -0500
From:   Tom Lendacky <thomas.lendacky@amd.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [PATCH] x86/mm: Fix spacing within memory encryption features message
Date:   Mon, 18 Apr 2022 11:16:13 -0500
Message-ID: <02401f3024b18e90bc2508147e22e729436cb6d9.1650298573.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 03c78a11-30a2-4e79-0544-08da2156c952
X-MS-TrafficTypeDiagnostic: DM6PR12MB4498:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB449809799623A19AC819B643ECF39@DM6PR12MB4498.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YHRj5qlDWca398KkIXzIvDo915UxP2iqHsX/g2OUY06OS2Z1Jp99mOU5tVarD+XRjQU2QF1xGiht2oCru/HxJrpo72H3BzdOMg0CV19Km7bB5dE4pEY6MYAa2PUnlVM0VQ6MZmUUSD9vzN0lBJg4O5uXkhrxAkHAL9PGwhi21I2wCkq8G8Tjkh0deO5+gb0BuqA+kcP1POEfcnorCCyt8EbGATvu2hvPHFevlxTJRlNe0KnVinSiDdsR+pVhl7vMikC2F130Uwzn1364zsoF2eEzb+ZCsTq0l7DG7bZKe0oiqAoiGA8uPBl4KjPuUpbmqLMqmWIZxPoYw4IerKRohavD3WK9WyZYCmEzl31Fr6MJuip1YX4M4cMYrkW7IZkfeuUsYdE3QA/DEUGKv7q+sggfNZQVyjr9QoOQlWzI+8AgcPZddd5uR0kbx4GulqJGYQUHOrmeMcPhZ4+aequTVeMqlLmwlNzz/RFZ9gyQtfgr0qYx9DbFhdVe7j7KkfEGpuQUfjI5/hOJXEqILkYY15kdZEYK/kD1qxNE6yvKcjOa4HSzZ+Xu2vKIL08aPNR3kfs6KDvaeybVK93kWuLEhpayWyXsmAmkLw6k3FYwI42z+UW7z3IhNVsmxOr8RCjzHGC09vjZx5u4RfRzSs3KeNHp0paD2WLdYIzWab2uXXzKAAi5AbGM4WC17lNDjP8043SM3YowxcNqpt+FmV9CqQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(86362001)(8676002)(70206006)(70586007)(4326008)(83380400001)(2906002)(15650500001)(8936002)(5660300002)(40460700003)(7416002)(4744005)(36860700001)(16526019)(36756003)(110136005)(54906003)(316002)(508600001)(2616005)(356005)(82310400005)(81166007)(7696005)(6666004)(26005)(47076005)(336012)(186003)(426003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2022 16:16:25.2971
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03c78a11-30a2-4e79-0544-08da2156c952
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4498
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The spacing is off in the memory encryption features message on AMD
platforms that support memory encryption, e.g.:

  "Memory Encryption Features active:AMD  SEV SEV-ES"

There is no space before "AMD" and two spaces after it. Fix this so that
the message is spaced properly:

  "Memory Encryption Features active: AMD SEV SEV-ES"

Fixes: 968b493173ac ("x86/mm: Make DMA memory shared for TD guest")
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/mm/mem_encrypt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index 74c09cc46d38..11350e2fd736 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -49,7 +49,7 @@ static void print_mem_encrypt_feature_info(void)
 		return;
 	}
 
-	pr_cont("AMD ");
+	pr_cont(" AMD");
 
 	/* Secure Memory Encryption */
 	if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT)) {
-- 
2.34.1

