Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4C324B2F15
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 22:08:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353700AbiBKVGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 16:06:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353679AbiBKVGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 16:06:13 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam08on2072.outbound.protection.outlook.com [40.107.102.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E96822D2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 13:06:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DeTIId8+omAD8KE58xT2JBZPFGp4ikmQ2AgVHoLxTLmoIxhxClt+ToDROyuJWnW1kf7DtFi0DIxuumDbk9oR7+7Qi7JiLXu+db6R+05XeiK0/jffHBPah3MYgEC502OXGu+6YL7ZQeUDBRGdvGrGzMx2olhpYdiX8t1dinSaCK3nGjlY+TkRU0oHZ6nvedWDAUh5fS1GT4tXwiLRgCRheeJNR7LppkFbFjAogC8tYfNHQk9H1xJs8sSrRaAYMQhvXktQ3JVtNGUhCL1FTRS7nLmMSkTccn05LGirRHFNRX+aRZAxY9SpooLii6GqaRXhpkAitSqjPv/JBRioHfL0Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lLKnA5Fqtpw3bgpdoaA+Pq9MhdpOnrbaGO2HHYYFpxg=;
 b=J8nrJj22dE+7c9/GdVmkJEyfmD2VJuoJB5qXUGQCM6a84a7UuY8Th949zlym/e6hCYFHjjaOKYbGnfSVNGIrHjEs67xy+whVmXVgwdBScYPUpLXivjYpaL4tNcNOyavrkDt8knzIQBbf38v0ae/gJigmuWZRzNvaYHmWojjmkNZlmayBCFj4qlBx5GpYCQTyvNe2fYeMNmV93rDtADXwZHOlrFHrzZ0fV1C1WOX6i8VGRv3WP9KxClLXlgvtvHxeuLiOBUoZ2jHN4UtFufhq3hiiam6o24s0sJfZoxu7ssmJoYoLrYpC00MRunDN4SDA3kg7CwF9i+3+S/HL0BVO4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lLKnA5Fqtpw3bgpdoaA+Pq9MhdpOnrbaGO2HHYYFpxg=;
 b=1xcbKjWvMC6c1NGQfg4o5qTN+c4TO0rLtXpY75lCKoaOzPThqM7kmxxrogoIvowcjU0XfajGPsPLuyDlFg/2kqcKztDzMJH8HX1JUQouWLt2Lvhs/2ZcPJW8Ph3bkN8ba3/ywsugd9ua/WFWWs62qO4HY/eXnUb0uOM9KhecNbE=
Received: from BN9PR03CA0973.namprd03.prod.outlook.com (2603:10b6:408:109::18)
 by BL1PR12MB5271.namprd12.prod.outlook.com (2603:10b6:208:315::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Fri, 11 Feb
 2022 21:06:10 +0000
Received: from BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:109:cafe::a6) by BN9PR03CA0973.outlook.office365.com
 (2603:10b6:408:109::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11 via Frontend
 Transport; Fri, 11 Feb 2022 21:06:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT019.mail.protection.outlook.com (10.13.176.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Fri, 11 Feb 2022 21:06:09 +0000
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
Subject: [PATCH v2 3/4] x86/cpu: clear SME features when not in use
Date:   Fri, 11 Feb 2022 15:02:54 -0600
Message-ID: <20220211210255.9820-4-mario.limonciello@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: d7d0b3fb-731d-426a-909a-08d9eda253f4
X-MS-TrafficTypeDiagnostic: BL1PR12MB5271:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5271E62BBC53F707863F126EE2309@BL1PR12MB5271.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: De4ipHRIo750wm90RUlMfaZF/upaFr4jEbUNC8DkrX3dfFYUMoQtKGzu/oPIYuO3DpkkdIQdcpGLTX/Cwixd0An4e4FCfgkvIzF0Sw3OODTmGtz0AgDnoC9j2XpeO5+QxWEM4fPI2K43J1MU8JLKtsGEbcgnAK1RafwR0u6bseS0Qdh+0xrN5/Va5vWN3hjVbu5Oo2EM0xf9zqqZgkzS4EVpB/9L9Om+k3LOBCS/iHa4mOKGIxrZbSDEcOk5EtUvlxGDtlLadmRwh+gW3ht2cEx/RZ0pReCy0p6zUBYJL4Pa/23+nKPxOOx482dxPMlo/o5JQx5PCDis9vmADqfPe68eHooo5NwOdtcdFveJOEIti5LynkhyC0Hyrh7vbSnJXLwKA5ca/2c9mtgclHNClgA2Jp5LPGfMdZAB/LW15tTVgmz4wah6yXAOIW63lXOJpn/87GoiiXXUE+DlPkQcazsjcdDy/Wz7ix8WX3Quw6y8Or1DSUAuBx9LtpE7dMzjVSbLZ37AKGxznR+J6kGUrE8QpspFFN4ZEtLWaC9Yw24KQkj2R/gw6vmkps/qqjnhY/4HhISSjrh60dk1ZPYAj5a4NBtPaimoS8cBZw+rrqg2qDQiQqy7XnmEFaUAOkKMGtzT/bckXyGKlMxARWF5xmGDPrUca3pIXTrzRxOGSXT7Jh8DRRBUvuVTM5mDT8Hs1OGiiBVU4FaC1A8OWOlETg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(426003)(70586007)(70206006)(110136005)(81166007)(4326008)(336012)(8676002)(8936002)(2616005)(82310400004)(40460700003)(54906003)(356005)(16526019)(316002)(1076003)(186003)(26005)(2906002)(47076005)(36756003)(508600001)(36860700001)(44832011)(5660300002)(83380400001)(86362001)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 21:06:09.7876
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7d0b3fb-731d-426a-909a-08d9eda253f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5271
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the SME CPU feature flag is reflective of whether the CPU
supports the features but not whether they have been activated by the
kernel.

Change this around to clear the features if the kernel is not using
them so userspace can determine if they are available and in use
from `/proc/cpuinfo`.

As the feature flag is now cleared on systems that SME isn't active
use CPUID 0x8000001f to confirm SME availability before calling
`native_wbinvd`.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
A concern was raised whether the assembly generated from stop_this_cpu
is still safe.  Here is the assembly from compiling with this patch:

00000000000011d0 <stop_this_cpu>:
    11d0:       e8 00 00 00 00          call   11d5 <stop_this_cpu+0x5>
    11d5:       55                      push   %rbp
    11d6:       48 89 e5                mov    %rsp,%rbp
    11d9:       41 54                   push   %r12
    11db:       53                      push   %rbx
    11dc:       48 83 ec 18             sub    $0x18,%rsp
    11e0:       65 48 8b 04 25 28 00    mov    %gs:0x28,%rax
    11e7:       00 00
    11e9:       48 89 45 e8             mov    %rax,-0x18(%rbp)
    11ed:       31 c0                   xor    %eax,%eax
    11ef:       ff 14 25 00 00 00 00    call   *0x0
    11f6:       e8 00 00 00 00          call   11fb <stop_this_cpu+0x2b>
    11fb:       31 f6                   xor    %esi,%esi
    11fd:       48 c7 c3 00 00 00 00    mov    $0x0,%rbx
    1204:       89 c7                   mov    %eax,%edi
    1206:       e8 00 00 00 00          call   120b <stop_this_cpu+0x3b>
    120b:       e8 00 00 00 00          call   1210 <stop_this_cpu+0x40>
    1210:       e8 00 00 00 00          call   1215 <stop_this_cpu+0x45>
    1215:       41 89 c4                mov    %eax,%r12d
    1218:       3d ff 1f 00 00          cmp    $0x1fff,%eax
    121d:       77 49                   ja     1268 <stop_this_cpu+0x98>
    121f:       4a 03 1c e5 00 00 00    add    0x0(,%r12,8),%rbx
    1226:       00
    1227:       48 89 df                mov    %rbx,%rdi
    122a:       e8 00 00 00 00          call   122f <stop_this_cpu+0x5f>
    122f:       c7 45 d8 1f 00 00 80    movl   $0x8000001f,-0x28(%rbp)
    1236:       48 8d 7d d8             lea    -0x28(%rbp),%rdi
    123a:       48 8d 75 dc             lea    -0x24(%rbp),%rsi
    123e:       c7 45 e0 00 00 00 00    movl   $0x0,-0x20(%rbp)
    1245:       48 8d 55 e0             lea    -0x20(%rbp),%rdx
    1249:       48 8d 4d e4             lea    -0x1c(%rbp),%rcx
    124d:       ff 14 25 00 00 00 00    call   *0x0
    1254:       f6 45 d8 01             testb  $0x1,-0x28(%rbp)
    1258:       74 02                   je     125c <stop_this_cpu+0x8c>
    125a:       0f 09                   wbinvd
    125c:       eb 07                   jmp    1265 <stop_this_cpu+0x95>
    125e:       0f 00 2d 00 00 00 00    verw   0x0(%rip)        # 1265 <stop_this_cpu+0x95>
    1265:       f4                      hlt
    1266:       eb f4                   jmp    125c <stop_this_cpu+0x8c>
    1268:       4c 89 e6                mov    %r12,%rsi
    126b:       48 c7 c7 00 00 00 00    mov    $0x0,%rdi
    1272:       e8 00 00 00 00          call   1277 <stop_this_cpu+0xa7>
    1277:       eb a6                   jmp    121f <stop_this_cpu+0x4f>
    1279:       0f 1f 80 00 00 00 00    nopl   0x0(%rax) 

 arch/x86/kernel/cpu/amd.c | 3 +++
 arch/x86/kernel/process.c | 5 ++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 4edb6f0f628c..9cea774344cb 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -607,6 +607,9 @@ static void early_detect_mem_encrypt(struct cpuinfo_x86 *c)
 		if (IS_ENABLED(CONFIG_X86_32))
 			goto clear_all;
 
+		if (!sme_me_mask)
+			goto clear_all;
+
 		rdmsrl(MSR_K7_HWCR, msr);
 		if (!(msr & MSR_K7_HWCR_SMMLOCK))
 			goto clear_sev;
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 81d8ef036637..e131d71b3cae 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -765,8 +765,11 @@ void stop_this_cpu(void *dummy)
 	 * without the encryption bit, they don't race each other when flushed
 	 * and potentially end up with the wrong entry being committed to
 	 * memory.
+	 *
+	 * Test the CPUID bit directly because the machine might've cleared
+	 * X86_FEATURE_SME due to cmdline options.
 	 */
-	if (boot_cpu_has(X86_FEATURE_SME))
+	if (cpuid_eax(0x8000001f) & BIT(0))
 		native_wbinvd();
 	for (;;) {
 		/*
-- 
2.34.1

