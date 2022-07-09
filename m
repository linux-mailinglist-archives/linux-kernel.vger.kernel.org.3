Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA7F56C9E5
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 16:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbiGIOS2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 10:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiGIOSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 10:18:25 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 480C1CE32;
        Sat,  9 Jul 2022 07:18:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KZeYtFrYLBj+GG+ivt1Y4xhk/A/kBDMU/jOsMXrqVpyJArsQlpnv384+dxIQEgZC/GjL9TBPJ5cwJJGFhRT+GCZHwiznor1vdubPKx+0lbxSONKwV4KQtEQUk7eCsy+i09GxCXX0vcs3MvMV3TMgik+u1+HeZP4U2qojvs4vnffhhlnwKVOWH74bYCR6evi826Iq+35qxgbptbnRjGGVMAuCmvI/vusw5WeSk5ZBd2dzGQqGzTj+U48l3VBbLUWwSdrZnBvXu5aBmyvaABVH7txu0Qw65rO/lqM39dhckSReToUrbbutm31tQ/uavhnLkEE9rwfBI+BwV3EPa0SlLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uN5+9MjVFTE9bOeD33YGoFoU/Kg+Vigkk4Cy9BhX4dg=;
 b=HX+pIvxIAnuGZfQ9X5apITCoR3AjtcNkzpJz0v/iIRdQNRppCc6DKKVhoXjmzhuOb3W/NKMCZj4cPRbaYx1Eqfq92v1/KjdkpL9cqVPaUJvWssDdk75hZ1bI4GMPNYLIBuWjeVan7B6IOxyLlS+MCAxwzLEH0rwrZgB/CCdrRZbbtRQbR0Ae4KfXnx9ggnDdQIYTVbHKfA+OJj5T6tTdAL9OzUE2FKp91V1chg+s0McF2XkAPgs52XVhs0JPIlqJPeV3oFYKeV8xZ9t8RXNTJtNSXT5UgPAD4GjaXrfWw0uT4oJZMlZeWJndMvwWm+Kbwcq8DCn8UdXWnGsqGpFTBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uN5+9MjVFTE9bOeD33YGoFoU/Kg+Vigkk4Cy9BhX4dg=;
 b=jLfKqwVXIPRQq4ZCC3quERbR0NaDyISD4vUMhWdKjiCwxWiFtKSzxl3CxyLiR4KEob4lUZZcQ5eR505WAGVuRh+kUaB1WHZgM6+6mvxRo6W+wBQropGblNxU4tw4sGaIarmXTOcz/pYh2BWluWJ8XPZQiKjIBGKVc8cdTq87Eic=
Received: from DS7PR03CA0343.namprd03.prod.outlook.com (2603:10b6:8:55::17) by
 PH7PR12MB5710.namprd12.prod.outlook.com (2603:10b6:510:1e1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Sat, 9 Jul
 2022 14:18:21 +0000
Received: from DM6NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:55:cafe::e6) by DS7PR03CA0343.outlook.office365.com
 (2603:10b6:8:55::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20 via Frontend
 Transport; Sat, 9 Jul 2022 14:18:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT009.mail.protection.outlook.com (10.13.173.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Sat, 9 Jul 2022 14:18:20 +0000
Received: from pyuan-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Sat, 9 Jul
 2022 09:18:14 -0500
From:   Perry Yuan <Perry.Yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <viresh.kumar@linaro.org>,
        <Ray.Huang@amd.com>
CC:     <Deepak.Sharma@amd.com>, <Mario.Limonciello@amd.com>,
        <Nathan.Fontenot@amd.com>, <Alexander.Deucher@amd.com>,
        <Jinzhou.Su@amd.com>, <Xinmei.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Perry Yuan <Perry.Yuan@amd.com>
Subject: [PATCH v2 03/14] cpufreq: amd-pstate: cleanup the unused and duplicated headers declaration
Date:   Sat, 9 Jul 2022 10:18:01 -0400
Message-ID: <20220709141801.835177-1-Perry.Yuan@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4814d927-8e72-4178-8596-08da61b5e066
X-MS-TrafficTypeDiagnostic: PH7PR12MB5710:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iI1F+ef6w4jR/ekk9rFNde/YaP/Do+qhFIo9Z1vSZgIYpr4vkU4au19TDbTtVocIuALXEnI9mehnbY17GPPpoHVgczgYGUQgUXPzHeAjrnEZWEvWgZ+Q5Z82da3jlDZzudtR2b8SRXGVSrz3ML03AiuXjGgsTfJkZ5GvyGuLdNvcLrqmQq+ZikwBw510zCbWc573P26q9SOTlefn0nlw8wgPa8R2CLQA9EjQKgajGSLDYSxTfCKBBPxiwK0XvaBW2SwRoguMQuQzYKmJSOaF7rvYUc3DQM0jb3KedbfY/JSLI4eoP8Vs9vVEkqlVzUxTq8oBK2iuL33uy0eWuaZEUxeSbdL0urJPdT7wgzzo08Z8XZHpKLdpzc/BVNxGo1tLr59Hthxbonru/G6Tlcrv8abd0DMiGgKW7pgTENHdxr5BDDYcHMNOL0Nh2IKvBvZLVa+DWcecrcbNjiLaIihJXxF2PKQfTpa5RAVc06V8Oka150Q0mmCS6e/2gW/7Y6WZKb1+Wrhy2mMHIIoxUC8E8XW+pkNbptaHsDIYlwZIw0Oc5RJyo/Iri1qxPkHr1fJQQsXmM+Q7r+/EhwGdVzVyAA95yteGgoV5fS+5Ao8RyghavAyB30VODXc6c5yxPajsZo+Gp0HsYMzyYgv8iBn061QPyvjJMNeHJYRq6D/wyeTKsvhC5h0Oh9iK8S/vQ07N74fm9nmpeUQYT+moknqFGpGh7D5KevSKTm9ysbjFe8YQQUV3E7Pp+UA5Q/Isy0LC41lGRmHsejErc0arvLP76kVUCpnPn3nMeNAhr3NAQzZudQVk+uyJ9OMTMT+5JCMIlwwiFlB3xUrwPo2njyZZRzUzHqhIlbc7KT9le0FjNua24zMwhuIpZFBoPx7wRm+X
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(346002)(376002)(39860400002)(46966006)(40470700004)(36840700001)(70206006)(316002)(70586007)(26005)(8676002)(4326008)(1076003)(8936002)(2616005)(356005)(5660300002)(86362001)(7696005)(478600001)(110136005)(6636002)(426003)(2906002)(34020700004)(83380400001)(81166007)(36860700001)(336012)(40480700001)(41300700001)(36756003)(40460700003)(47076005)(82740400003)(186003)(6666004)(54906003)(16526019)(4744005)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2022 14:18:20.7199
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4814d927-8e72-4178-8596-08da61b5e066
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5710
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

Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 188e055e24a2..43e6df9f67f6 100644
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
2.25.1

