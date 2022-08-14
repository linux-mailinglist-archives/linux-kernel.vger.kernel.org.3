Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0260759258F
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 18:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243389AbiHNQr0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 12:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243965AbiHNQrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 12:47:07 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B9C095AC8;
        Sun, 14 Aug 2022 09:37:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SCJroC69dGsPbqQfWAZy1GjXXaeQxXSPe2jBcRyU4SdIk7gKJnVuRl5WSFBJCv9mbkE+OiH90hK+Rxo7C/d5rd1n6Bj0fVuthlgiflmhi2gzponCZiTnG5gV7P3tCFhd+GKpPf+J+s5+LXZa9KKyfOtzk2hQhUwMFIxnheA6eYhoK0WuLT7f5FJ3VQXiOw7e/lo84Hkx+T7oPNXKky2GdPDq8/0nwtHBztloEsynrsSAPznSDMap61y1mOaDJKvj6iIN54V7Kml5u+kFJ+FGdKnMJux4y61/sKP5A9AguEQMitUBheWMXHrWPG2QCJ3FYVwNB3kquiUopyyfmyJGwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ybRtwuyt6S2qJNkz9GNQm+d4ydIhgbt3IuVG2m09KhQ=;
 b=CMP0Dkv4rZvglQAw2Y4CW26Ty54irChI+8NkcGGT2IjQP9r+oEjYFRxSsgEHxHyyVg6rUJFvpyGJkvU5ucw7A07k021xcJDgrlKFjOFnx7QJPdO9xQM2okSP6uIWHZlb6p6ME0lj5ZzQCXXbYEbo1jAp/+dpxXopj596TZNjus5c53prF5WUQyF5ASrFaQGoHc++e3+jrU1ywm+314xAfVqSyOS0B+7u0/mqYaXNOmapdfWYmOhNuuQxEdjOH/6/7Cvagc+R6NdiK8YRoAT52BzI7KxgdSNcP+k6qW1VUAdqbVAyxuQQsyDn7AeRvcp6OqeaLjqUU+aFpMnLyBWpug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ybRtwuyt6S2qJNkz9GNQm+d4ydIhgbt3IuVG2m09KhQ=;
 b=4e1ZsBLXxA+mQ8QQQSLjrql3V3xW5tgYMfptUwTv+Dqaj8coxqkjq8+Mv2rU8lhdADNtQRwVgRrL1lvLdhY2bDmQpWt9U9a/r5ajb93nqJQo0y3rurJ6NPRXSIw3isH31aPWTrmjv4WF+fw6BaWY26xFXY7FA3FZ2lkUZE76cd4=
Received: from MW4P222CA0017.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::22)
 by SA1PR12MB7125.namprd12.prod.outlook.com (2603:10b6:806:29f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Sun, 14 Aug
 2022 16:37:03 +0000
Received: from CO1NAM11FT106.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:114:cafe::e1) by MW4P222CA0017.outlook.office365.com
 (2603:10b6:303:114::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.10 via Frontend
 Transport; Sun, 14 Aug 2022 16:37:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT106.mail.protection.outlook.com (10.13.175.44) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5546.7 via Frontend Transport; Sun, 14 Aug 2022 16:37:03 +0000
Received: from aerithdevpyuan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Sun, 14 Aug
 2022 11:36:30 -0500
From:   Perry Yuan <Perry.Yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <ray.huang@amd.com>,
        <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Mario.Limonciello@amd.com>,
        <Nathan.Fontenot@amd.com>, <Alexander.Deucher@amd.com>,
        <Jinzhou.Su@amd.com>, <Shimmer.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Perry Yuan <Perry.Yuan@amd.com>
Subject: [PATCH v5 1/7] cpufreq: amd-pstate: cleanup the unused and duplicated headers declaration
Date:   Mon, 15 Aug 2022 00:35:42 +0800
Message-ID: <20220814163548.326686-2-Perry.Yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220814163548.326686-1-Perry.Yuan@amd.com>
References: <20220814163548.326686-1-Perry.Yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6944583f-9002-4d42-81b3-08da7e1337f9
X-MS-TrafficTypeDiagnostic: SA1PR12MB7125:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hLZPdxcUI1LIUvYLbyHLQXM0NnFZ2tCxALGYwc6J061VycN/Yl+YvBQvmD/2Pezzj1H+n7X2LxluFR9LjEEUyrGjDrvrY2JGhtxijjfC65tK94CuWkG6qVGhox5Rb3e5ElOkgDKgZNgvMKU6nr3bDz3ni2o1GAjhvCLqylz1Ke8IUvyhiZtrMkySG8fRMU++dfzlcIznW7SPkTOqIaZ5B1l2H7kEWlEKb0F9N+8OQeXlsbDRMCTjJ/UGsbu/OwNoo4T8nEYkxZmvDVQXFnaPPASSZcajAI7I9YmMn5Ft9sIklI3MensEETflY9jRt8tvH7rB3vCs4PB5TAhByP5Q/qDIhz7qoF+u5fzBIMRCMDVdfLiwlEeBFChsoDKhmCnitwU9DqdVQFKZrbnO8X5WGF++A08Qyg0vO1+2hF3/Ls0BWe3D++v09OZmQQfgU67fQK0JKBWn5t6cGx2Yyj1KjUJhkMVNYRUZoxX/dAJdHi6Z+2RqdzN4Huu6o3vtc1IOxxVqCBEuNiWuqL7YitBytYOMAI0WZimYlDZUQzeubNNQxVx4LZOxT9IBK8/x6ZBUtz5Muq8vG3dzoXGKyDa69xi/ryiVCRF+jL633iUMzISoxwpxZrXtm30RQYojvIoefXPRYeUpnPmNk1JskwFBugS/qKrf+pKZhNWTfEvj8JCtnU2VYr1rJCbuBXfZFakeFx/JdscdVAs2nCMBP2pW7Mjx5ZV9XopA+D5Amvj6GjJAS/YULLFlH7QKZabKAmU0s6kDtKL2AAfkM1EOKu81CxcqRVQI5QNaN/RI3lX4c6lvKG1WFWh7nmv5u4ne6D99X2qplRPHNEiV6l9F2BNRT8CyZW/lzF+LloU2J9ZempY=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(346002)(396003)(376002)(39860400002)(136003)(36840700001)(40470700004)(46966006)(478600001)(36756003)(6666004)(7696005)(86362001)(2616005)(26005)(426003)(47076005)(336012)(186003)(16526019)(1076003)(41300700001)(83380400001)(82310400005)(40480700001)(40460700003)(70206006)(8676002)(54906003)(70586007)(110136005)(316002)(4326008)(356005)(36860700001)(81166007)(5660300002)(8936002)(82740400003)(2906002)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2022 16:37:03.3048
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6944583f-9002-4d42-81b3-08da7e1337f9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT106.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7125
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup the headers declaration which are not used
actually and some duplicated declaration which is declarated in some
other headers already, it will help to simplify the header part.

Reviewed-by: Huang Rui <ray.huang@amd.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 9ac75c1cde9c..19a078e232dd 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -31,19 +31,14 @@
 #include <linux/compiler.h>
 #include <linux/dmi.h>
 #include <linux/slab.h>
-#include <linux/acpi.h>
 #include <linux/io.h>
 #include <linux/delay.h>
 #include <linux/uaccess.h>
 #include <linux/static_call.h>
 
-#include <acpi/processor.h>
 #include <acpi/cppc_acpi.h>
 
 #include <asm/msr.h>
-#include <asm/processor.h>
-#include <asm/cpufeature.h>
-#include <asm/cpu_device_id.h>
 #include "amd-pstate-trace.h"
 
 #define AMD_PSTATE_TRANSITION_LATENCY	0x20000
-- 
2.34.1

