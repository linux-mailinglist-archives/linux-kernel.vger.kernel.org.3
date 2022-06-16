Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF8BE54E022
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 13:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376873AbiFPLi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 07:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233009AbiFPLi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 07:38:56 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2047.outbound.protection.outlook.com [40.107.237.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB3695D5CD;
        Thu, 16 Jun 2022 04:38:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yz4RLxghkpUzEhc4FlHOaLY414/heVTmU/D0HwbbpJfroAHBx6+oJD3EwFSV2p/wJHs0sk8Ta3Ogsy4mwx0mm1btsvhbqF9X1CVhcqS12JwBfsmnXomwJINXTTyzA/1MughAxraqGtqPKWAFrnh5cGh11ybW8ZAoi5RPpJWTr0nMlhZKMZ0AMVqsZ6dJNVJy9EgOfWXqyCwzuGV2svuaDWeZmEMyFlbBQC3aqYuctCLhhJZDCkEk9/vvDz+jMWXNCzP9yFs1XxIr/e99PCEV7gVWUYKANTnc+tAlMDGvwr2PZ1qcVleXD9pX8ZdOry3ZvXjkpCDgie6uO5F8AHWc2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lJfXpIxpeMOccYL/x48Px3+t//tkT9knW2nYeGpr1wc=;
 b=gkc3jnCE2xowOf6a8sdUDsh57qXRoterymrujqnIFMTcN4qLLeZxsecWqw/3ZuXAxJcCmrw6YFFzOBI3U6knXrl3WS8ISpbPOigeBxezZPxY/UolbKLaz43q2w2pCpU3knRv3/eqK5VjPoSkphLiL2tAmJkIG31L4ccVkAKp2k5AvuCxQH59NiBOjkcj4KlEI/3R3zioR+OxgmJw4MsF9ZGhmNxdxA2HOXqpUKKN0gkakx6CYD2dzxnMVTUCs4Jc6+WG/0mrlaqCwC+RST2QT7aeNIq6dkJHjssmLIvTrjagYdqYGCIomBzv65gPE5pcZcvDzrJiW4U0Qfg/bvfwfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lJfXpIxpeMOccYL/x48Px3+t//tkT9knW2nYeGpr1wc=;
 b=DES0J6pzOMrcIGLmzt0fJfhRs8nxiHrBX/VSFTSOXt/fmOSvKkfXLbiQPYoBEy6X1T/+WYkbf80CuPeVV+kG5sxucr4ZbedlfCc3BRXYiuh4luQ5xYrZmrnVH6UhyNADH3Q+SAEZCJTktkrfCrNx+6Th8WxP5a+mq50/KJ7XYco=
Received: from MW4P220CA0018.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::23)
 by MN2PR12MB3263.namprd12.prod.outlook.com (2603:10b6:208:ab::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.14; Thu, 16 Jun
 2022 11:38:50 +0000
Received: from CO1NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:115:cafe::78) by MW4P220CA0018.outlook.office365.com
 (2603:10b6:303:115::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.16 via Frontend
 Transport; Thu, 16 Jun 2022 11:38:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT012.mail.protection.outlook.com (10.13.175.192) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5332.12 via Frontend Transport; Thu, 16 Jun 2022 11:38:50 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 16 Jun
 2022 06:38:08 -0500
From:   Ravi Bangoria <ravi.bangoria@amd.com>
To:     <peterz@infradead.org>, <acme@kernel.org>
CC:     <ravi.bangoria@amd.com>, <jolsa@kernel.org>, <namhyung@kernel.org>,
        <eranian@google.com>, <irogers@google.com>, <jmario@redhat.com>,
        <leo.yan@linaro.org>, <alisaidi@amazon.com>, <ak@linux.intel.com>,
        <kan.liang@linux.intel.com>, <dave.hansen@linux.intel.com>,
        <hpa@zytor.com>, <mingo@redhat.com>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <tglx@linutronix.de>,
        <bp@alien8.de>, <x86@kernel.org>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sandipan.das@amd.com>, <ananth.narayan@amd.com>,
        <kim.phillips@amd.com>, <santosh.shukla@amd.com>
Subject: [PATCH v2 01/14] perf/mem: Introduce PERF_MEM_LVLNUM_{EXTN_MEM|IO}
Date:   Thu, 16 Jun 2022 17:06:24 +0530
Message-ID: <20220616113638.900-2-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220616113638.900-1-ravi.bangoria@amd.com>
References: <20220616113638.900-1-ravi.bangoria@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 69e62296-dfc6-49f5-5144-08da4f8cc87c
X-MS-TrafficTypeDiagnostic: MN2PR12MB3263:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3263E24C9985242FA32D56B0E0AC9@MN2PR12MB3263.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nsa1SVz1FGY5dKq7gY2QiHVE/C5ydEFp+rtIqNWNRoV/9bvNyo1VpUJveymKCreB6ofrCVIwphHFD6FvAUj61m1Wxgr+dxHy6PkWPEyaJhuIh7MSxjFwsgE+3xkLgPWkXpV74vMbVM80s+c8BjKKFRquFnF7P5g2ucP8QOHQi9YUojADUL4rE3jUBWld0zfsDbGSuRfe1TdgLr6MyK9O5n4+eEKz/kiPp07U+wbkRbPcO7r1ZNmOjBBFasNjUTxsQP6twl2Zc38vIBPfAhtj1dLUOeaYkpHEh/K0Y170aK2+1j2R3GQxoU41WRntMWFWxEBgmo5CUNKsj+6uApZuGZ3enJsQtjhHqXO/GZfDV7GiywrgwjIg3ekbxIoX4EqTxPRcjxAdBiEPek65ObUse2yuPulTLRAykXrhfWiypCONmbPiPWzv8tAgeZmK+6ecAJrk7SSQKdBggxYQZ3f90D9akNgDDveOmocqb+rlxkaVRMJf9uib1LgbiZa8Rw86r2hdlOwi7+GND10dvjo7yYkimNqkZpjQPuC2YuyP72H77UatNlO/exGn4C492cXcxYg6U7FhprZaXc3EWPF+J4g82zDwNl9huMlHBiXobECYKd/MU23PwcdAMkpctJcNSI+WU4/qaH9jZ5HeL5as5P/MpgsEIx1jzqxcNNj4JnNlHEoNGtIUL9WSTPC7VipVQ8hZyG663nX2g364OOUlJ3wlYfRmi063346cz3E88Vw=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(36840700001)(40470700004)(46966006)(47076005)(16526019)(6666004)(86362001)(336012)(40460700003)(8676002)(186003)(83380400001)(426003)(36756003)(7696005)(82310400005)(36860700001)(316002)(8936002)(70206006)(54906003)(26005)(2906002)(7416002)(1076003)(70586007)(2616005)(5660300002)(498600001)(81166007)(110136005)(4326008)(44832011)(356005)(83133001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2022 11:38:50.2077
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69e62296-dfc6-49f5-5144-08da4f8cc87c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3263
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PERF_MEM_LVLNUM_EXTN_MEM which can be used to indicate accesses to
extension memory like CXL etc. PERF_MEM_LVL_IO can be used for IO
accesses but it can not distinguish between local and remote IO.
Introduce new field PERF_MEM_LVLNUM_IO which can be clubbed with
PERF_MEM_REMOTE_REMOTE to indicate Remote IO accesses.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 include/uapi/linux/perf_event.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index d37629dbad72..1c3157c1be9d 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -1292,7 +1292,9 @@ union perf_mem_data_src {
 #define PERF_MEM_LVLNUM_L2	0x02 /* L2 */
 #define PERF_MEM_LVLNUM_L3	0x03 /* L3 */
 #define PERF_MEM_LVLNUM_L4	0x04 /* L4 */
-/* 5-0xa available */
+/* 5-0x8 available */
+#define PERF_MEM_LVLNUM_EXTN_MEM 0x9 /* Extension memory */
+#define PERF_MEM_LVLNUM_IO	0x0a /* I/O */
 #define PERF_MEM_LVLNUM_ANY_CACHE 0x0b /* Any cache */
 #define PERF_MEM_LVLNUM_LFB	0x0c /* LFB */
 #define PERF_MEM_LVLNUM_RAM	0x0d /* RAM */
-- 
2.31.1

