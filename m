Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A09F4CCD8F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 07:08:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234745AbiCDGIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 01:08:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbiCDGIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 01:08:38 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2693027CD4;
        Thu,  3 Mar 2022 22:07:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kzoe0XcOspvudSqD6V+zVHwV4f4uMkgMS24N3hc+IXMH0Nv9v5uHk6RF5Zh0iWSSnrDoGgFS2NpdtsbPEStv77T7fRumxiM8BDxjTg9zWIzEi+Mvhjh2+ZJ80vAwJrXXMl5V4spGR6BzpVDfROcV5TaFr5Gfb+3IUpF9vxqhM7fW2jeG2lYkIDtpJbPh4ApydwH7tiVuwRRTxyR/pUkR9kJ6TXGQOSBERmBG9uWUppR0GC66P7tC4VT7hoceSb/qyPUMqTuOWxPqmXigpJRPA1YtTZlfbaxYViguHUACLtBQ0NmMx4aSLTTJvf4GB1+jEqeKo7BU55eMzqBOOmEXAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dswItOAD4kxvG6RCbrehpzWCYfAXVsAC/C+7ltldqKo=;
 b=h2/0VONN5Y/LnqrU3dIIcC7RIkRTZDq7JLUlKu6yXWvZTw1e4dVjVR3XGiBmBTlgWWI877IodWZaE79W6fn9yf2jbeqAF6HGBNkpVQs6cO7ZKqZB9LC0FeI2m9oxNrr8nIe2oWcPzvRpXDmHRjLCFQ/KtgH5eBV2HYtpOcglb9Lp8tze0MTEjUj0POr6c9HFoyawzccZeTQNsrTniL3mPdU6qm5kYhwttjQJgso8bpgPprR8nb0pKefbB8TkDeBbZok7wCKJ21jRO4kUMn8B4pQg6hSEhr1ms8mLVcND3NE7FH/fZlwpQjwAZ0E9Zj2jhSqpBnRp/Tc0p267nXjHYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=rjwysocki.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dswItOAD4kxvG6RCbrehpzWCYfAXVsAC/C+7ltldqKo=;
 b=jG4LgLnob64ntfz+hrZSVbvK3LZfLL8jSdU8d0fKm9L8XdDMzEzvEEkxizPB+XABVcGQ/FVRrQwSfkir89rK625i+g6j0abfbXpmy8J/uwkHF4p2jS37hvFPp29Re48qZTqP8S6PQS17X0APr+102jvrZUQR9Jh6GWnWDYH09Bg=
Received: from BN0PR04CA0037.namprd04.prod.outlook.com (2603:10b6:408:e8::12)
 by CY4PR12MB1896.namprd12.prod.outlook.com (2603:10b6:903:124::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Fri, 4 Mar
 2022 06:07:46 +0000
Received: from BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e8:cafe::5a) by BN0PR04CA0037.outlook.office365.com
 (2603:10b6:408:e8::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Fri, 4 Mar 2022 06:07:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT016.mail.protection.outlook.com (10.13.176.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Fri, 4 Mar 2022 06:07:46 +0000
Received: from jinzhosu-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Fri, 4 Mar 2022 00:07:41 -0600
From:   Jinzhou Su <Jinzhou.Su@amd.com>
To:     <rjw@rjwysocki.net>, <linux-pm@vger.kernel.org>,
        <srinivas.pandruvada@linux.intel.com>, <dsmythies@telus.net>
CC:     <ray.huang@amd.com>, <viresh.kumar@linaro.org>,
        <todd.e.brandt@linux.intel.com>, <linux-kernel@vger.kernel.org>,
        <deepak.sharma@amd.com>, <alexander.deucher@amd.com>,
        <xiaojian.du@amd.com>, <perry.yuan@amd.com>, <li.meng@amd.com>,
        <jinzhou.su@amd.com>, Jinzhou Su <Jinzhou.Su@amd.com>
Subject: [PATCH V2 0/4] Add tracer tool for AMD P-State driver
Date:   Fri, 4 Mar 2022 14:07:20 +0800
Message-ID: <20220304060724.314582-1-Jinzhou.Su@amd.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 32e022e8-0988-4cf5-078a-08d9fda54d7b
X-MS-TrafficTypeDiagnostic: CY4PR12MB1896:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB1896C9B938E0F50C7B54053990059@CY4PR12MB1896.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1NRiONrkPdvIT7kc1HihnpDt8w846QdwVwnADvuAAnvTcjava2diAtoNs7exDFtMlg9EElrwqQzqVay5vwbsqPjwZuqeE1W3OIaJHfQJJE91mtCmf7NM0TErok2bpHGWIYt0yynxSvQ0CucjkB8azIqk2tmeF7ZwHg3gaDll7UIisGGqjwdcdRW4CYbfJoILtVh3+brL1hT1oq7ivIJPbSM55nwV0iY5R2/RwwVbe7jb1gizEX8Ry74Tco9n2M6KwkmgJE6o9/uLrkdkPd7BZnQWYhQGaMA0IkyUferS6+tL+YhFe+Kc836AcTFizeZrLlwCltgyjSILBCiaE1XW48a+Nbpa84N/eywYoTHYkFfhiO72esY4xUXIbEek//m+YmgF3ObsxVZH40VhrLXZUd6YoCA/MSDsmeR4xCaMpEvXWzPz53S9iEhXK3T/4u2yNI2QMAzKCFgfXuRmwoUUqPTL5M6mon9k6NAR18HHdrZClniUisFoZNEmsQ+nV7/hHxy21PWFYkMvicBXx/SYU/Q6q5wIWR/30tX5VERkWUPP3Zz10N6khnpPynXEPpTVTCwttoVkyY8Deiw7Z3qX3x2agin5vCKI29ZJCFcOIQmsNDiSdEULy90oN3uF2KKubtpMryAsHZEJA0RfxC/B9YlCyXtIMB9+EJ2fm0Hnw+IJMn99wun0dGM8+QcqvT+VrhRdvT7HbepXsD5QzVlSVQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(36860700001)(356005)(81166007)(70586007)(2906002)(70206006)(36756003)(83380400001)(47076005)(16526019)(2616005)(82310400004)(26005)(508600001)(54906003)(186003)(110136005)(426003)(1076003)(316002)(336012)(7696005)(40460700003)(6666004)(86362001)(8936002)(5660300002)(8676002)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2022 06:07:46.0350
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32e022e8-0988-4cf5-078a-08d9fda54d7b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1896
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

intel_pstate_tracer is a useful tool to analyze the performance of
intel_pstate driver. We upstream out AMD P-state driver into Linux
kernel recently and like to use similar tool to tune the performance
of the driver.

I modified intel_pstate_tracer.py then it could import as a module to
analyze AMD P-State trace event. Other trace event also can benifit from
this change once they need this tool.

intel_pstate_tracer could be used as the same way as before and the
original functionality isn't broken.

Changes from V1->V2
-Add tracer documentation in amd-pstate RST
-fix typo in amd_pstate_trace.py
-add "Co-developed-by" in patch 1/4

Thanks,
Joe

Jinzhou Su (4):
  cpufreq: amd-pstate: Add more tracepoint for AMD P-State module
  tools/power/x86/intel_pstate_tracer: make tracer as a module
  tools/power/x86/amd_pstate_tracer: Add tracer tool for AMD P-state
  Documentation: amd-pstate: add tracer tool introduction

 Documentation/admin-guide/pm/amd-pstate.rst   |  26 ++
 MAINTAINERS                                   |   1 +
 drivers/cpufreq/amd-pstate-trace.h            |  22 +-
 drivers/cpufreq/amd-pstate.c                  |  59 ++-
 .../x86/amd_pstate_tracer/amd_pstate_trace.py | 354 ++++++++++++++++++
 .../intel_pstate_tracer.py                    | 260 +++++++------
 6 files changed, 588 insertions(+), 134 deletions(-)
 create mode 100755 tools/power/x86/amd_pstate_tracer/amd_pstate_trace.py

-- 
2.27.0

