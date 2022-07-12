Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF149571FA2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 17:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234181AbiGLPkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 11:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233932AbiGLPkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 11:40:19 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9025EB9686;
        Tue, 12 Jul 2022 08:40:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q4ayTy5lXIHmhbzVrEcQ+/LVGkVz1H7G735y1B+gfUl6dtnIQ3pP2P5Oz/wZEFnyojfpiORADtar8FKopzQ4fbNRV9hMKqxKuIFgQJDlnCnlf6PdCY8uqtufJK8ozWf5zkoBU1IiALJatNajwy9keRL+aOb9kIFZeLDNA42fyOQ6hvpBYLT9NI2cPJDDiifWgDlD+qjMh+Ulznkj62/nV8zRKihQ40xE9ywCxmLbPqeDO9Wvz/kkMpjzqUKzRb9Dy2nGolWA8GvrKmNKLBq8q5uLnnqXl6veyDRtsEHizAUtCLin5i7mz5LJ0WfBn8cJXuWLUr1huVM4YzwMFOjOJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uN5+9MjVFTE9bOeD33YGoFoU/Kg+Vigkk4Cy9BhX4dg=;
 b=gPzcJROc2SSbTgFa4xWh9p2FBc9GJGwwpvfdHcLThGFk1aUlxkCQA4KlY+SkA/Aayi4s5Q8nCb5eRKHMdQopvIIhG+3Cw8L5JRCywBzik7/73JzfZtamHgTPibhyI4SWv5cbzF1JGJEzUlrPrynkmZHpsCguBXN5Wsci50HeE2SxFdKEhn7/SOWDLUO1s4dADOf0xAdsHMvC5eVgbEEDHv5pWFEebhO7/W/bA5BdWsnotk5qSchXmtnhjuZkI364BFn2QVME+o3NKQPvMnQbnmL8lmcd3VCyITZhZDJ/Iifi6rXkt7bm6Kv4TEQ86Y7Pcu4+3XSWgwMyAzaoVJpqUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uN5+9MjVFTE9bOeD33YGoFoU/Kg+Vigkk4Cy9BhX4dg=;
 b=YKV4lyfTFrL2CIeauUCxfj/KNUf7+ikRhn9ywsxDLP3YkTKxGYPZikj7jj+XGvRnMfuwfIGtsAxRSk/hftLNXL26AhdANQRHYwzUjzALCsdx9HkMxEQJ/yXPNcB+CDcShqtdcxq0UdKO55v+Na1SHpNDdNvm0z+gxyY1ViHhIX4=
Received: from BN8PR07CA0026.namprd07.prod.outlook.com (2603:10b6:408:ac::39)
 by MWHPR1201MB0191.namprd12.prod.outlook.com (2603:10b6:301:56::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.25; Tue, 12 Jul
 2022 15:40:16 +0000
Received: from BN8NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ac:cafe::8d) by BN8PR07CA0026.outlook.office365.com
 (2603:10b6:408:ac::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.25 via Frontend
 Transport; Tue, 12 Jul 2022 15:40:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT009.mail.protection.outlook.com (10.13.176.65) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Tue, 12 Jul 2022 15:40:15 +0000
Received: from pyuan-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 12 Jul
 2022 10:40:10 -0500
From:   Perry Yuan <Perry.Yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <viresh.kumar@linaro.org>,
        <Ray.Huang@amd.com>
CC:     <Deepak.Sharma@amd.com>, <Mario.Limonciello@amd.com>,
        <Nathan.Fontenot@amd.com>, <Alexander.Deucher@amd.com>,
        <Jinzhou.Su@amd.com>, <Xinmei.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Perry Yuan <Perry.Yuan@amd.com>, Huang Rui <ray.huang@amd.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v3 03/13] cpufreq: amd-pstate: cleanup the unused and duplicated headers declaration
Date:   Tue, 12 Jul 2022 11:40:00 -0400
Message-ID: <064c323b016dd0cb369d3f2d1301b218abb2b6e7.1657638462.git.Perry.Yuan@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1657638462.git.Perry.Yuan@amd.com>
References: <cover.1657638462.git.Perry.Yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 13de8244-9d9c-4f09-ea58-08da641cd0dd
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0191:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: omrWxJhVOdwdVGpoRUcCOX3XXqt0YOtAMg5ZZ0/j5kX5hpj3D2hzn5cWi3DgXWfMklUrv1TEY9nPkJZnLAAnua9eiLttjY3jeoZjgA5S0KtAP4pO/EiRfOuLpnbJEPRfOcRJj4kIdALnsK07NS2db7oqorz+PVwNYs+Pt+2V/qRmTyFxQ9ZJw9hib7sgavE4LzNlg/DayDmwvYBTP4WWMjUEvO/qzrviGnSKafvP/bRuyX242SNeXFfU03dxTJHhX3M40/oVo2/Y08oCejr5/kETK7/U4bJEBLl71BxhQXUgiv53hdFib+GFHiOFNVthKgQtTDJ52TvVFO+spuOXbKrwA5ZGjdMbbQ/ycntokdYkE4DlWv6m67JUm+GsZv4V9yZKgHGQlHnNmcVnXoDcal1AJm/bVXvUtuPjsrO4YVptrIFQ1aaiAEPu+NS+WoPmT0gSzjLh6MbKh6TH3XHspcVQCaifLk+exdlgpvw3+gKod/uKl5UTZJbC7VfTkp3Y8AM8fvlDKz0PRTLIEJ9obMcCQt8pWVL/KsbxiXzFH6Hjelluf7lzq1YE6BdV31wYNyGjgpdpuNqwPurzTxK0ewG663qj3M7IW//MKXRZSgeVohqPNcJcsQL0Jjcihl+tkdX/thNWGj1mANlusEiwvoKhnAfKqkZ7B71EArg6Ph4U9xhRzXM9Qq/fsfFOPDZ3aXFulRjGWMJiTeTHsGZsi8DvccLmaoTP2dPs9Znh16wdKNQuIQk6wGvwaoIGVLYXscj8BIKdwnVZzKOuvFqgQe9CyBRa2Vinv+lK7FaJEl0B6hSBAGAhEt1sPBQ+QH3BQ3IEc2ZeBttXdpb73vMRu4t9ZuayH/TNC5lvDuY+tlc=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(136003)(376002)(39860400002)(40470700004)(36840700001)(46966006)(316002)(8936002)(36860700001)(8676002)(4744005)(54906003)(40480700001)(83380400001)(5660300002)(36756003)(478600001)(110136005)(2906002)(6666004)(356005)(336012)(82740400003)(41300700001)(426003)(81166007)(47076005)(70586007)(70206006)(86362001)(2616005)(16526019)(6636002)(4326008)(186003)(40460700003)(26005)(7696005)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 15:40:15.1787
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13de8244-9d9c-4f09-ea58-08da641cd0dd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0191
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

