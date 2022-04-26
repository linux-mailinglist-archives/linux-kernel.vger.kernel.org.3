Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEEBF50FBFF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 13:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349564AbiDZLea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 07:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238202AbiDZLe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 07:34:27 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2116.outbound.protection.outlook.com [40.107.215.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DEB83DDDB
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 04:31:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JBXWfgwMi/ZnidiGTRZsx31ubJ979S7RwhuwTs5wysmKU/4ctkI46XekG+vkTVCGAgS4pCkjgU3rTI+9GqQqdOhxKMAdgeZDLwlyplk43oXu4/xKQ4kOJymADaci3pHEzgEiLy0vheRWgGbyTTPeAd9kjsL1I6FBUwFp3NhERwWP2aHzkWCU5sALTQmRTzSWyUi5KwXnYG+D0wUqPgKv6dkyFmiHAtdqgqzq7XbPuZoyJ3OI5vG3/z+0NVm55clQ7TdndgH5pJ9GMlDwXwmO7jG4yerkIId4j3qsS1ZMFgoQr6YV8OAU7EaWs3TzZjnY0cg923q0E1Md5qVT3j0d1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5pSMXUPuusSp5iDsqxuqJcvMeRSM6+th45x49r0aXHU=;
 b=FiNzzpcppb2iqxjdsYKWRaUqsRQK05hgXI4ndmwPWA4nYnkq2WH6DdSv32pkYwMb9tlLbKy0461eusE3qk3wOgLbNgHK+Sz2JwvOS6gnn5ssimejSNG41VsOZwZmNqEZtWrDFsihyO3W/trEymJZRUsXBilUWGQwKiTfrd4UW4FLLUmFixPHNld7Bdx+cAZP1UeFotobBGd+POHvnRqCGMp6k06TkpMfKB1av2avIPKlsRqdDzYgFzaNzxoletcAUt3WqUFLO1KA+UOIr6YCohzo20RIUp2jbz/T0Yjldel1HXSz2YseriVWatj2F0o52Uy6iHynLmPE7SsACba8gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5pSMXUPuusSp5iDsqxuqJcvMeRSM6+th45x49r0aXHU=;
 b=R3X8xfhOWkPjjHpMS4jTxGm5jta7l3zuaOvX00fCCC93TqDzSF11Hvt0P2jEE89aSWL9T6mqQaivZGTC/1Wu21gNn6tWXs6//K3VioRTy4DCD8oc0MODkNt3vxDgqbwmdCE+1JeEPO4tkb9Xefs9miFedvuj/77W5ghzzq+xu9s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com (2603:1096:4:78::19) by
 SG2PR06MB4897.apcprd06.prod.outlook.com (2603:1096:4:178::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.13; Tue, 26 Apr 2022 11:31:18 +0000
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::4591:4f3e:f951:6c8c]) by SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::4591:4f3e:f951:6c8c%7]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 11:31:18 +0000
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>,
        D Scott Phillips <scott@os.amperecomputing.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Wan Jiabing <wanjiabing@vivo.com>
Subject: [PATCH] arm64/sme: Fix NULL check after kzalloc
Date:   Tue, 26 Apr 2022 19:30:53 +0800
Message-Id: <20220426113054.630983-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR03CA0044.apcprd03.prod.outlook.com
 (2603:1096:202:17::14) To SG2PR06MB3367.apcprd06.prod.outlook.com
 (2603:1096:4:78::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1d574488-b1cf-4df7-8d3a-08da277847bc
X-MS-TrafficTypeDiagnostic: SG2PR06MB4897:EE_
X-Microsoft-Antispam-PRVS: <SG2PR06MB4897F31BB3B2F88DEBB06846ABFB9@SG2PR06MB4897.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DTWGD4bH3yCj1ve0PW2OMW8Bb1aqOBbSNyDE4/ttwH0LCa5F0wx+6c64WS/KJw4QOJp0swDJun3t+4mCOpkO8CB5tZ31A6pIVR13OK44G0i6g7e/MGC06+TYWMoOWHNCSl/mLQ+0g2w1ma+9UDtSHUVQYDQPaJ+dp/zV/zN3sw4FdJ1JMRmCA6oOBTVUfvmDcEKf6PiZIO+TJwHnqivmE1uxhLoOrEfJSGEJDb6b+vjDMCcZUOcdRZD6fsE8e3nGQBi3FAXHXRMTVeaQaX/mQLmRXmHv7W4a2PNpUZHYxvFxI/phJr+Tcnwg2idl84tOstNrQWTrpgEsB9heczTHRfiQzP2Lor3/LXgg4rcd2/uRJGlIOFzfgcSOQ4DAF56EKe5iyWl39jw8E3UGJPdOngnK6f0KIpquN2UkjdRBeBmGJPMmFP77C1fuB6RSbGBn5gVZqCcxXygI7qwo2gtRGRpUv5//D575uxjMKSNEI2Zl22Eq71mbIfX4f5d4jIYsEh2rh1nES2ZGelcn2EqWFlrtQxpPNQrYzLZobKe+NIe/WGIuFN60JzqZ1JIFccEUtvgM7ME3+2RVgejLkqpjOnsaIsSTcFYdpPHCvUHz2K3W9UDhGk5T+3omiPfjDJsme5GCjiHyC91y8f9ZHQrAG38TyuiO+zSyk1LEqftDdhTY/0A/MD7k3PVRp74AZO/nJySpd/xQvmGhgyXXYqlPGA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3367.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(110136005)(8676002)(6486002)(66476007)(5660300002)(38100700002)(83380400001)(38350700002)(6666004)(6506007)(86362001)(8936002)(4744005)(66556008)(508600001)(4326008)(107886003)(2616005)(66946007)(1076003)(186003)(316002)(36756003)(26005)(6512007)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6y9KiYsHn3ljFF2mtWyBbr1zACPcUqQn8rZyzWYBFlODBQ6+ZAmE5NCbr4YP?=
 =?us-ascii?Q?vTeRu9nB+RDVj6isIYcrAbyqCKDfUDP2Bah7KgV1UO04tdbr/tOBPv2UjaM7?=
 =?us-ascii?Q?09GTQCcNvHr61/iSM4rwUX7pEZDkQOVlfA+yGE3ySC43bFhtXMdjymhnILps?=
 =?us-ascii?Q?zUnxuxrCJfYbKKwXndRVMQPaie9D62jc3LgwESI+UuE4t1lKhePsfj7kxJTX?=
 =?us-ascii?Q?mw68aCeezLl1bcdErlkFJbdgxvHJqqLQbAJOLYR4QCH2wbZywTADI/VG4tDR?=
 =?us-ascii?Q?bQUpRxNq6V7bP/EOo2vAHjtLbRlkDHhnvv2G3Sl2+IvNWmXsBnnjFHu61SS5?=
 =?us-ascii?Q?dnG/wF24vb0ApFXyv+kvFQJ5taEFebePyR/cyVbZUnKBZEmuy7XaPb0Uh7os?=
 =?us-ascii?Q?dEVNWXW26E6XvETJwZTpAUmhG64ZQMAyIhMox/b7cxm1/VF3nnX7jOjVGrbT?=
 =?us-ascii?Q?D1a9JDpB0/v1OY8A2hF6f2F8F3O7gN2SbXteUn4ryHuSK2drOtls3a5lsc0A?=
 =?us-ascii?Q?zRvkV3x6kiLQAi5tIPo6bSMwuBsinNSZbYkhqh7jYvohUXN9kjdcCmVzLmfq?=
 =?us-ascii?Q?opDnXxmEjmw22/4Nl0raFD5XfWaAvMYLv37HHNnAxpYfm/nhd2NwM2O/UY/t?=
 =?us-ascii?Q?sj4t14F/pw7Nry6Qe7Ty3YrQOsx7hOF7S4OXTTh3+qw5Ch6cd682bumfagE6?=
 =?us-ascii?Q?InhplDFtjAyK3Pz9aJG7j0IsWQ7FhCfxgPUoetw4WzjakZYhlNEixhz5ynO/?=
 =?us-ascii?Q?zeHE6R1tbHET+P/MjB8zhStAQiAoHHUwe5h3LnrxItSzw4pUi7zcA4d8btoI?=
 =?us-ascii?Q?SX1+O5UWmOe1szxsk8s9O0sJ3pUr0a9QuNgRbr14nM3L0v17+uc1a0stPiUG?=
 =?us-ascii?Q?ig2DxcvIWlQgTmOV0XvHtys70dbGs9eoAZGyAliMsoZNM36XfF3gsmEqrEMJ?=
 =?us-ascii?Q?ivZZ2CzfXT2MTEoEJCW2wBJrLj0b/ODTf1tzvdDtH3URggX9mmbvXqej6I98?=
 =?us-ascii?Q?T+CV0Cs/fyKxXmIDXaAJLvTLzHsW67IPTUlUhBtGQ5z2HrAatvCH+FrjX9CE?=
 =?us-ascii?Q?jZCR1ZvUW27+Fjs1eTvsKfYzvV3G5YJVXSuV6elbs0B/h7xiGWqPzZhBPmvm?=
 =?us-ascii?Q?OuxO03VkxN/5xKYvFpVLFfq7tjfMSeJxUFWFwgKkecpqCNELXxKvHna0FkYf?=
 =?us-ascii?Q?RRjY5ZAmFiRED60wzN2bnqVq8a1htr6ZNNlgJQwckT7+s5QbJDT5TH8lDpN7?=
 =?us-ascii?Q?InL6lJCaugXJw1omR3dlOaX6QHp8KZKGQvJbdOpkcvb81f+CuWmv8YP2zXln?=
 =?us-ascii?Q?DKoTxRmQARHie+f0XFZrZ+Z06w7+P0NyWa+MdcTxWgZUqPcnvtswpISa+fge?=
 =?us-ascii?Q?kWZK9cAkOBomdWrdwPzLoWAO93kro/X2ZFGhYY/aT64T0n6FSm3uHJcnsbkn?=
 =?us-ascii?Q?Z5dT2hrQB6zyXTyv524VrBvy0cWHzpaHBJ0r2WXLltdE7ANeoYY9PDsaE2F/?=
 =?us-ascii?Q?kDe5qduDEt9kfibcSelIez3LoWQNFzk5v3tYs21gUN4gQj1Ckl+dCwApcbb8?=
 =?us-ascii?Q?sJUx+iRNuKHyqSXYoFDdnfYDhQxblFw8cZaySzQsT+qOdv1cwhp+HOrH3yvD?=
 =?us-ascii?Q?xyyZXxeHQb5Os+kDGg6QFfNF9hEvcv6moSqbEn/p0L36c4ycknm24n//NwLF?=
 =?us-ascii?Q?RyP97c5PEHiclVscy8n2g5ihcNvV4TyM/ZXA+4xqZKwabiXtA1u8O1+vmbiW?=
 =?us-ascii?Q?xIto4iF8nA=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d574488-b1cf-4df7-8d3a-08da277847bc
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3367.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2022 11:31:18.2256
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L5rTAPWcqb+IwiNN/qtL903Exh80oVKIMNtlPpCmey30OUpoa3eeCLk5NqHzcHGUsJt+yUJTSWCjrqD3riCPXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB4897
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix following coccicheck error:
./arch/arm64/kernel/process.c:322:2-23: alloc with no test, possible model on line 326

Here should be dst->thread.sve_state.

Fixes: 8bd7f91c03d8 ("arm64/sme: Implement traps and syscall handling for SME")
Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 arch/arm64/kernel/process.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 99c293513817..9734c9fb1a32 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -321,7 +321,7 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
 	if (thread_za_enabled(&src->thread)) {
 		dst->thread.sve_state = kzalloc(sve_state_size(src),
 						GFP_KERNEL);
-		if (!dst->thread.za_state)
+		if (!dst->thread.sve_state)
 			return -ENOMEM;
 		dst->thread.za_state = kmemdup(src->thread.za_state,
 					       za_state_size(src),
-- 
2.35.3

