Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E3B9575EFF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 12:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232764AbiGOKF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 06:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232684AbiGOKFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 06:05:10 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2070.outbound.protection.outlook.com [40.107.244.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E6882F95;
        Fri, 15 Jul 2022 03:04:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hexZHENE4tjFFtsrMSez40gypjcnHzCrdMP/dtnYc8T2i3V8f88qqfo1k0zZ8XC4VanxeQxnt7SKD1EdD71tfaxYMhnVI1h0BtHZ7Aq8D9E8WyGk07ErkfCw4Iro6hHLX+fk9dtivSgWnoJ1A8F2C4BvSH1zq1qn1zYVuwX1eUC5P23cSq0KFWFmU+BiZxL3HqxfwPBnN8hq+slELmGQBihRDd3E+eR2nhXMsiRAHlkN3tBGE0IvXPy/FMngvDgdbXc0v+nHAEK2u7ygezmvdh/SMK+1RUW8qzuWEtaLTfXWZ7rjimQplrlyhe5zhiXliH+9oxXb5zfPTkV4KJYtwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pXVfjQaeiZA12KoI9/XHeAV8GzSiN8BYTgOJedGrHB4=;
 b=GFhpcWIgkWjgXX45+fOgwKdmZ89X1UgIXgecO9SF4zlRwYMH830K8GAlDCpCT5MtF936z+nEgMXf72gPNaFaIo1a3eN59QfiRCZA11w8v5eCIz2KXH2gqjoqPFTqLxEG1njhKnLEgLfsaLM/kPinhqLI9oLaiGck16ObdnCk8nmF5xJZG8p0gHMsopr75a4TrFbSHe+1/A/J2lLNGYMNYEXkgzFD8sGoRRRJbRyimMHGvFexPfuazMEDay657ZsOLzVccN8gzBmqc9senSRsPcRmRpeNLIRg/aFe9642/oKTGGgLIJqLm2SoRTA76qZBpQNpEUSmRdiQhQejZZTX3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pXVfjQaeiZA12KoI9/XHeAV8GzSiN8BYTgOJedGrHB4=;
 b=XVZKiZGcitkidedOY3/s6ikiYiURt3jpvDSKSVGZZN5ZGSPdWoNu3h0KoEFACgjfdhS2MCrsCUQqolYjpOIrMZFrYgqFTsFelbqM12H3NVO9nqsPSQKQFDUf8Ba1OCc9hohAcucKR9+h3Sg2U+ta4Kaa8lW8XPVrrezHM61x7Dc=
Received: from BN6PR22CA0070.namprd22.prod.outlook.com (2603:10b6:404:ca::32)
 by MW3PR12MB4522.namprd12.prod.outlook.com (2603:10b6:303:5f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Fri, 15 Jul
 2022 10:04:52 +0000
Received: from BN8NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:ca:cafe::55) by BN6PR22CA0070.outlook.office365.com
 (2603:10b6:404:ca::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26 via Frontend
 Transport; Fri, 15 Jul 2022 10:04:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT057.mail.protection.outlook.com (10.13.177.49) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5438.12 via Frontend Transport; Fri, 15 Jul 2022 10:04:52 +0000
Received: from AerithDEV2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 15 Jul
 2022 05:04:47 -0500
From:   Perry Yuan <Perry.Yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <viresh.kumar@linaro.org>,
        <Ray.Huang@amd.com>
CC:     <Deepak.Sharma@amd.com>, <Mario.Limonciello@amd.com>,
        <Nathan.Fontenot@amd.com>, <Alexander.Deucher@amd.com>,
        <Jinzhou.Su@amd.com>, <Xinmei.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Perry Yuan <Perry.Yuan@amd.com>
Subject: [PATCH v4 01/13] x86/msr: Add the MSR definition for AMD CPPC hardware control.
Date:   Fri, 15 Jul 2022 06:04:20 -0400
Message-ID: <ca830355f1470ce53cd56917b0adee66c0b50f00.1657876961.git.Perry.Yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1657876961.git.Perry.Yuan@amd.com>
References: <cover.1657876961.git.Perry.Yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bb677de1-3489-4cdf-c13b-08da664975d8
X-MS-TrafficTypeDiagnostic: MW3PR12MB4522:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ++99bUqeRG2RfTv4szQcl6WOdfRJML0FyP3/LPueCKRjFmWwshILYSWYw0GMKtnxtwlKa1DdNe3Yqzizo54Eo2dDkinFXAtcUuvXzy9GYHS1iTxnU5oPtMFnF+jxOd7GNjkfM//1CvfTUfHjlzefIcutiuWSgHh3MtBXR4eKSnPtN1tpHAkeBEFS4x7857x4oqGI+pDQtvxlRz/S2Oz1wFQpEfz1L9jS7JZvlyuMX5yrgx953l8pEmQgLuhJYG2dhBoshf6+kGvoq/K1kpq7AnM1Dbxa5ryLHe6zTaqxb6QCeX1JrgJ/18c0AxzfuzRnJtAEu8dxP0Z0bkoE0v3u8W5qIO+h8cqbBY0tSGssJz5jx4NiJ4k6yincNoR6cOvjr9d3B2rXaAGgTuO5tthDoIgKuXlI07nC4O92CAKscrJ78r3pX68M4TpkQTZ3ezqcB3+rBgGP9dA2tXt44neYu7Efnfz6jJbQxeCYxN+WHC9sQSr8Izui/Q0ZaAyoC8UanVCqXK7UhrJLDWkZCw4wWNqmDh1yjQW06NsrxMn3WZgiqTyzy/fYYozp2mp9UZsoYwe0iHH/vBtt4inlsSSNyvTRbyOQwybrJktykb0C6szeV07FIgUS0g9hCPzyxYHUObVRkyctzyZhKE1n25a0Y0vT/AS1QNhVa2ecuoJZb0ni0mes7TVCdQY3loiRL0APbsNffMqLR7k9cT/sFKmVk6p7m1H1nGeGpZLyDN7Z2vW2K+M9sxuefRT6Nz7V8/OkngbYaLB+1haI0KtnheEOzBZclgAdd2/3jYogZTeExWcJjH5Gzo/6GXlMqy4IgviZ11Ttqs6z7WOn5M9DAEm1uUPRz2KIcNaSMiFVG6kZAz00Z3Lx5w+CtM7w5PBR8HtOUMwjrBw91j6dUgaY9H2zGITW1rwGvHhhBX52uedHkf8=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(136003)(396003)(346002)(46966006)(40470700004)(36840700001)(966005)(70586007)(110136005)(316002)(426003)(6636002)(54906003)(26005)(40460700003)(70206006)(186003)(2906002)(4744005)(6666004)(36756003)(336012)(41300700001)(7696005)(16526019)(4326008)(8676002)(81166007)(82740400003)(47076005)(82310400005)(86362001)(40480700001)(356005)(478600001)(5660300002)(2616005)(8936002)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2022 10:04:52.1506
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb677de1-3489-4cdf-c13b-08da664975d8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4522
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This MSR can be used for controlling whether the CPU boost state
is enabled in the hardware.

AMD Processor Programming Reference (PPR)
Link: https://www.amd.com/system/files/TechDocs/40332.pdf [p1095]
Link: https://www.amd.com/system/files/TechDocs/56569-A1-PUB.zip [p162]

Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 arch/x86/include/asm/msr-index.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index d27e0581b777..869508de8269 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -548,6 +548,7 @@
 #define MSR_AMD_CPPC_CAP2		0xc00102b2
 #define MSR_AMD_CPPC_REQ		0xc00102b3
 #define MSR_AMD_CPPC_STATUS		0xc00102b4
+#define MSR_AMD_CPPC_HW_CTL		0xc0010015
 
 #define AMD_CPPC_LOWEST_PERF(x)		(((x) >> 0) & 0xff)
 #define AMD_CPPC_LOWNONLIN_PERF(x)	(((x) >> 8) & 0xff)
-- 
2.32.0

