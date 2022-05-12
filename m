Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D822525669
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 22:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358385AbiELUgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 16:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358384AbiELUf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 16:35:56 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2071.outbound.protection.outlook.com [40.107.212.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C492C63AB;
        Thu, 12 May 2022 13:35:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HX33RIRvfq12FFQOOOcZ7q1vIPMeXyIZv5t1aUnAWyc5y5uv8rr4w1mp92c/4nRjHfGtWnolkSmpxeo5Vh0qAUzMfZzzaU2+z1E5lmCvvMWm12+H37/VQIMOOR4GWEKwhQSt82anEtVx9wryZw2UaV+vz8dCIbY9fEp3bP+HVvKmCOv6XJhS424AomIn5k1cP9n4NTEWDUhFla2yv+WfSbqfOceGgh/1i8+L9+59Cn9SkIsm68nLgvgrSgP0AbUY4bZDeAkAGGXgsUu922QyCncT4eaikkHm+9oMT2c34EHxAYmAmVH8nzPdGrJo4wFITm9049W0vvif+Qkomai1+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mKXc9lWwmXF32NNeKoUQC2M4MJsdbL2PCeBURM/ukP4=;
 b=PUSXmxEnGoFWqQ8wfICJd/mpwBc5s782l59KNOABEkGnjBpDwRnj8nyhfNq+alF5VF4+/Vi7LUy7uw2LtBjc5jAivnlrbcgq6dSfennjK+DFXIbHnUugsfiGw4iZWyYCmuDTrDAA0Hu0NsfldK/I+UeLvabLhE9Eey6vUywvjKWmsS/pvK7GXSl/z/Hoe6Hi/AXE6NdtUJN5e/uKPd+cQADb2MNbEAhh/CpKtZK2y6Wa3jIHLUwHTX3pIbLsDzTeQbvUJj/ieJLvBUH2hxo3MVkMTSeLxmRnnOleRWT4dgQouljMZVVdQGPajVF56Aae99rlx6DyNiYjHMQUYDOxvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gondor.apana.org.au smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mKXc9lWwmXF32NNeKoUQC2M4MJsdbL2PCeBURM/ukP4=;
 b=eq+aHFDH2CQ0kegpsnPPRV5U/qVys8f9ywxbxnU/G/Fs+GFLH9wPNVOLwUG04H3HGjyuvlAlaFiN0N9qw+U83Vlgisp0r6oXUKnUJ3/bzV+cu56NEVdmWkjFHx8xPR47M42yEQL6731+mP/6rgjzYzSz3+Y5Y3fpsP+EGzp4Hpk=
Received: from BN9PR03CA0393.namprd03.prod.outlook.com (2603:10b6:408:111::8)
 by BN7PR12MB2706.namprd12.prod.outlook.com (2603:10b6:408:2a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Thu, 12 May
 2022 20:35:51 +0000
Received: from BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:111:cafe::97) by BN9PR03CA0393.outlook.office365.com
 (2603:10b6:408:111::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22 via Frontend
 Transport; Thu, 12 May 2022 20:35:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT031.mail.protection.outlook.com (10.13.177.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5250.13 via Frontend Transport; Thu, 12 May 2022 20:35:50 +0000
Received: from jallen-jump-host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 12 May
 2022 15:35:49 -0500
From:   John Allen <john.allen@amd.com>
To:     <herbert@gondor.apana.org.au>, <linux-crypto@vger.kernel.org>
CC:     <seanjc@google.com>, <Thomas.Lendacky@amd.com>,
        <Ashish.Kalra@amd.com>, <linux-kernel@vger.kernel.org>,
        <theflow@google.com>, <rientjes@google.com>, <pgonda@google.com>,
        John Allen <john.allen@amd.com>
Subject: [PATCH] crypto: ccp - Use kzalloc for sev ioctl interfaces to prevent kernel memory leak
Date:   Thu, 12 May 2022 20:34:55 +0000
Message-ID: <20220512203455.253357-1-john.allen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 12cd176b-9e66-46da-964e-08da3457009c
X-MS-TrafficTypeDiagnostic: BN7PR12MB2706:EE_
X-Microsoft-Antispam-PRVS: <BN7PR12MB270677289FE5D89A6A2301D49ACB9@BN7PR12MB2706.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VV7YR4xMnIw4u5su5whC2eqsogijUvICik82M6qZDC4/DUIOi3GYH6DwRH1G0ezLV1RTwr0VRafwJc7uRWm4INNXp5kIYaHkxU/kmoz5NTIPt2BJuQug5JUtLQX3s2pNMwy7Hfa1PGrFUsyoIcDOAEqp1CsCNZyViyLWtC1XOwwNgeYeOiEmQC2z4SWkm89hfvBOkZIFDaVmMOcY192Y4JPLXafAdwmbzxnjuyMOENHhqxM+CXaOiyu/8o/t7kV5Py+cGJHvsjYS3kNmDwlNwnqi8VCeZLpFmwQBtXLMHaGKtVH7s3i2NPVaA3cQYSoY+hLabdtt6qgeUXQCdPdA3CXK9TBFODiLRHzqAl+h8jkKlUOD2rSOEKEVv5dgVmSFAcLgEe72HoTJM3b3HOZpcMiRnGYsEhsy2GdAXSI64x0K/H/1ug/Pd08H3ODfnACW8nX2maiDYlUq7g2OSPlN0SLdZYHVWKRuv3tepZJzuo/ZkXAUMCKSAxPUCVi0nTfqv3gxZmBUw47TZXM8Gaw0Xr5wsu664MVK0Y/q0Np0MaBVS6JVydpF5dxWeACwFEPcMITXe4RuBWqTxz/iEv08c9UHBQP+SY1/tuFIMfpiBlLsJ2vaKRlcpKCP2zlSJq+uadeHJhLpPtdKk0JNDB6He0Bfd/1+8KnP3dRU5g1XvZCRlqyWH0uJC0PJd2Hy0ZHUOvyvISWOIWLNW+lQYu1SQw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(426003)(86362001)(356005)(81166007)(40460700003)(47076005)(26005)(83380400001)(2616005)(36860700001)(186003)(16526019)(1076003)(8676002)(4326008)(316002)(70206006)(70586007)(8936002)(82310400005)(36756003)(44832011)(7696005)(5660300002)(2906002)(508600001)(54906003)(110136005)(6666004)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2022 20:35:50.2782
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12cd176b-9e66-46da-964e-08da3457009c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2706
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For some sev ioctl interfaces, input may be passed that is less than or
equal to SEV_FW_BLOB_MAX_SIZE, but larger than the data that PSP
firmware returns. In this case, kmalloc will allocate memory that is the
size of the input rather than the size of the data. Since PSP firmware
doesn't fully overwrite the buffer, the sev ioctl interfaces with the
issue may return uninitialized slab memory.

Currently, all of the ioctl interfaces in the ccp driver are safe, but
to prevent future problems, change all ioctl interfaces that allocate
memory with kmalloc to use kzalloc.

Reported-by: Andy Nguyen <theflow@google.com>
Suggested-by: David Rientjes <rientjes@google.com>
Suggested-by: Peter Gonda <pgonda@google.com>
Signed-off-by: John Allen <john.allen@amd.com>
---
 drivers/crypto/ccp/sev-dev.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index 6ab93dfd478a..e2298843ea8a 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -604,7 +604,7 @@ static int sev_ioctl_do_pek_csr(struct sev_issue_cmd *argp, bool writable)
 	if (input.length > SEV_FW_BLOB_MAX_SIZE)
 		return -EFAULT;
 
-	blob = kmalloc(input.length, GFP_KERNEL);
+	blob = kzalloc(input.length, GFP_KERNEL);
 	if (!blob)
 		return -ENOMEM;
 
@@ -828,7 +828,7 @@ static int sev_ioctl_do_get_id2(struct sev_issue_cmd *argp)
 	input_address = (void __user *)input.address;
 
 	if (input.address && input.length) {
-		id_blob = kmalloc(input.length, GFP_KERNEL);
+		id_blob = kzalloc(input.length, GFP_KERNEL);
 		if (!id_blob)
 			return -ENOMEM;
 
@@ -947,14 +947,14 @@ static int sev_ioctl_do_pdh_export(struct sev_issue_cmd *argp, bool writable)
 	if (input.cert_chain_len > SEV_FW_BLOB_MAX_SIZE)
 		return -EFAULT;
 
-	pdh_blob = kmalloc(input.pdh_cert_len, GFP_KERNEL);
+	pdh_blob = kzalloc(input.pdh_cert_len, GFP_KERNEL);
 	if (!pdh_blob)
 		return -ENOMEM;
 
 	data.pdh_cert_address = __psp_pa(pdh_blob);
 	data.pdh_cert_len = input.pdh_cert_len;
 
-	cert_blob = kmalloc(input.cert_chain_len, GFP_KERNEL);
+	cert_blob = kzalloc(input.cert_chain_len, GFP_KERNEL);
 	if (!cert_blob) {
 		ret = -ENOMEM;
 		goto e_free_pdh;
-- 
2.34.1

