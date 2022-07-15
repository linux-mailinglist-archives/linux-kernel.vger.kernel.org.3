Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7ED575F03
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 12:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231860AbiGOKFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 06:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233370AbiGOKFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 06:05:15 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A8B479680;
        Fri, 15 Jul 2022 03:05:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dy7SDa0obj7g5bVAu+es//g35yqVDInwPgeD0lHbwBIcTRyBfLXUQi78pWBpz69/jSTPkNkzFeYwl4IhrlYIzYTXt48bYwQz/P8Eq3dbRp8yEVLZo5LlVqYmDepsIBQYH3ttNN5zM3LtSrzzgpYjXT5dhFDb/sqr/vQx3xGt0Vq+ZzLk+uWnHeXh+iquaHeHKUCwpLw2QYcywmqPPM5iMftRDPlacYPPP11LavogDF021y1FRKnbfvHWnCORKQRKela3+6mo4MbUlPRJLWXKorDfIEfOGTGrDNFWrL3Y0PtnFjoR1xUgDczuKxfj/FFK1lgNYZrqdzqxqJhp7r69aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zp3o4SR4uEqafdVURj/Agxl4+HI2mEwH9ygxUNMuVWw=;
 b=dN9X6W7DqYEd3I/vmrkmOW4nwRSVS+7HjEoGijQz989qWhs5PkyqhgcbGADLRTQxF3ClO5tov/W8Pnf/D8LZnvGvRp2Zbep+0pZTERdQTUC69Gd/4tuSRxOYCMUBZyutdxYFEDuZoXGornajU0Qyc/BALmyClUWJZ67BmFG4BLv7rH7antON97bQt9qE5r5WLmyNc65ns8bSbKJFHTSI0U/gM6sJ6c+919tyO9RntnX+lfogihRKBZJGKBYNo3qEDZcQUf9FmwlYO6N5Pt7+4xp5BTmTjP/0zCkKrk3sNtg9T6o8Qwqp6OFGjuAkS+ADWFpUfK3UcU/reK5qLv7cbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zp3o4SR4uEqafdVURj/Agxl4+HI2mEwH9ygxUNMuVWw=;
 b=WGsoROw4zUwtcykgdA0XB13tCFyLOcEyEBcDusjcojxOlUx3l64jLcJ3gCKi4bU+r4c0wQyjm3ZAIlFKh+bdeE1LyMaxJVQ3lfStDG/V7SU5+E4rTR7lKxnG60e/VMVxsApjsGX09nyvVyu3r0oerm02W9S949M4rYI5uE6Arm8=
Received: from BN9PR03CA0357.namprd03.prod.outlook.com (2603:10b6:408:f6::32)
 by BN6PR12MB1905.namprd12.prod.outlook.com (2603:10b6:404:fe::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Fri, 15 Jul
 2022 10:05:01 +0000
Received: from BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f6:cafe::d1) by BN9PR03CA0357.outlook.office365.com
 (2603:10b6:408:f6::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.17 via Frontend
 Transport; Fri, 15 Jul 2022 10:05:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT007.mail.protection.outlook.com (10.13.177.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5438.12 via Frontend Transport; Fri, 15 Jul 2022 10:05:00 +0000
Received: from AerithDEV2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 15 Jul
 2022 05:04:54 -0500
From:   Perry Yuan <Perry.Yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <viresh.kumar@linaro.org>,
        <Ray.Huang@amd.com>
CC:     <Deepak.Sharma@amd.com>, <Mario.Limonciello@amd.com>,
        <Nathan.Fontenot@amd.com>, <Alexander.Deucher@amd.com>,
        <Jinzhou.Su@amd.com>, <Xinmei.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Perry Yuan <Perry.Yuan@amd.com>
Subject: [PATCH v4 03/13] cpufreq: amd-pstate: cleanup the unused and duplicated headers declaration
Date:   Fri, 15 Jul 2022 06:04:22 -0400
Message-ID: <6fed848fc6694074ceca16a9a45e4084fa33b511.1657876961.git.Perry.Yuan@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6858c982-ef75-497d-9cf5-08da66497b0e
X-MS-TrafficTypeDiagnostic: BN6PR12MB1905:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jyfj0fe3+ZIEKRqAaegyufiTqGfyVxsawRKH7huMxAy3Lv446n2vf9LXKna00UEkw8R83HHipLYrIzv5CujDADd6+DOQ9d9cKPxdjS9ojtwCkRYyQpFpjI0252DH99rQwT2WLKNsOsE7wCDmVxOjtEtGOMtNGL6edXvCAYqCIMx5/p3SKMWE3gy+3Pwn3qlXaUUsJ+mm3rI7am2H3NeXykWGRlxE4L+Tkk1GPN/3IOjPEQy8g8pgIwd2nAq3uz3bJGgmcsFYq7FwS0LA2fYIj8qN4+Cc5W0wEUzFGgOVPayIjop5VRzMI11m40eQgwKdd80OaN2dHlvVrCgbyLVXLa/1r2AYNHZEJ3fpT/A4NQsHOJUNUX7XnRdTg+JrRcsfCrGK68/TMYRAt3qu5+yUoD74MDNXvOunPCtfG1yV09ZXTg1OA90PnrQ/bKMVC/BQuZovmNFKt6emgr11MjpLrlfANbfEUFuSoteCgsJ3eFWH4M68UuRw8hi5sOZf+31OAznFvRFqET/FMoXclb9uvrtT+kaZ+NgC4cALtp+r0Hp6uZ+L58315zDC9uFdvzpc9W1hCC0qBOLhVRcIUzD6oos5DtxiSZj7reNo21llYaD9hn1Vwr5m1TSbXevbtkdXamvnlgo/3rv2k9HkAn+02pPw4a2zjfeG4egdDdzGVkpwIwS9A65O/ICeMnN52kRG8/KaqUjtXOHUdBUrUyx+w/ZL8GtMEB/1yuU+DX0+6eT+DTW8PF2uXXZk1WPa6FMnol1t5vdMEIFEoHinD0tMwHilxLw9LDdiyxCx/fqlBFI5hXBqqiVQ75t3Ea4iBSZowcjTZc3P0SYERRPZjdIITLG/TewsaJ/CccFHXRX2ODc=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(346002)(376002)(396003)(40470700004)(36840700001)(46966006)(426003)(6666004)(83380400001)(47076005)(7696005)(2616005)(41300700001)(26005)(16526019)(2906002)(186003)(336012)(478600001)(40480700001)(5660300002)(40460700003)(82310400005)(316002)(54906003)(8676002)(110136005)(70586007)(6636002)(8936002)(4326008)(36756003)(36860700001)(86362001)(82740400003)(356005)(81166007)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2022 10:05:00.8922
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6858c982-ef75-497d-9cf5-08da66497b0e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1905
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup the headers declaration which are not used
actually and some duplicated declaration which is declarated in some
other headers already, it will help to simplify the header part.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
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
2.32.0

