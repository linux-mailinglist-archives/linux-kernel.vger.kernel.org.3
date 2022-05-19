Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4564352D00E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 12:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236438AbiESKD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 06:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbiESKD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 06:03:56 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD147994F8;
        Thu, 19 May 2022 03:03:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n93KgrbTeelFw0pawgDikSLhrzzQ0Tx+U2hMImO6s+6gy6ts9Xxx5uFBAsS2l+RGeFJtVaNz5a0nJK6z9Vc0Jz3rLbn+mxuXPnHKeZA8yJXhrWsg6Uy/khevuteKZZjCmqQr0qKBNkHqqj2u8SBE/np5OLaA6jIEYKQ8+OrDA71Lqy0Z7Zb/tpFjrymbbJj6rHHfOmF6d3cycQ4xwdxQy3IBbzwNcK490/juoBvoxPfGMRe2mfeXOIUTp6YA6vBw1bwmcsCY6PAIl7VjuSz3YS8jN4ne7JTD4otGHfptNPNXF8miEj2Yp+Rmj5LcziFmK0GlcHrbe3vawv6r1L7svw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lxf6nL5ciwjc0Yn0KRYpEXYuyMN6pPxZXhe6+CcqxA8=;
 b=Y74hBxs6eMPSVN7eg76zAElH+6Gee2b0uFbGV+V8Ko7uOjDNsP3FmcHF3TuQ2mp2F3m/zSZkMqGe9x0AL98IJ0C2i2enwsDTr8rMGvcCkh//pxQlGYidGevWJ8Q9uQPbH7sp9vW5SsdxN4awNS1LeRn/GMZzuaENKnf6QPnbRzAOdhUa7DdIz3olZ1ozgols8l+cyiPQ69+RdjTYT0IYeoN+YB3hpQV4t8AvVBAzpAZeJ3iD76Oqstpxw6O8rr7CM/lWlFX3votJy8UTCmlNSG7QjtcQcMZhX2aqV/wVQAX5YtFQjm/R8CzSFhAaUAr0LrnOcthI9pEaBAHIieoY5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lxf6nL5ciwjc0Yn0KRYpEXYuyMN6pPxZXhe6+CcqxA8=;
 b=r1QZCmxv+WZ+en3VfV0/j/U7942FmjShiDbOpa5PzVYwzIm1E4W2XcK+MVv+ImE0Ku8kVBXXiiZVykLsPY+FN4mhPrjEQfWS844PH8IThNIaEQWEgm0IuKCWmxMU7enSr+rNeCzHysW5TzcyjJYiLzmiko6AZpTPjpAw3a+EkXE=
Received: from DM5PR18CA0072.namprd18.prod.outlook.com (2603:10b6:3:22::34) by
 DS7PR12MB5790.namprd12.prod.outlook.com (2603:10b6:8:75::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5250.14; Thu, 19 May 2022 10:03:49 +0000
Received: from DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:22:cafe::d3) by DM5PR18CA0072.outlook.office365.com
 (2603:10b6:3:22::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.26 via Frontend
 Transport; Thu, 19 May 2022 10:03:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT010.mail.protection.outlook.com (10.13.172.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5273.14 via Frontend Transport; Thu, 19 May 2022 10:03:49 +0000
Received: from sindhu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 19 May
 2022 05:03:43 -0500
From:   Sandipan Das <sandipan.das@amd.com>
To:     <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <x86@kernel.org>
CC:     <peterz@infradead.org>, <bp@alien8.de>, <acme@kernel.org>,
        <namhyung@kernel.org>, <jolsa@kernel.org>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <pbonzini@redhat.com>, <jmattson@google.com>,
        <like.xu.linux@gmail.com>, <eranian@google.com>,
        <ananth.narayan@amd.com>, <ravi.bangoria@amd.com>,
        <santosh.shukla@amd.com>, <sandipan.das@amd.com>
Subject: [PATCH 0/5] perf/x86/amd: Add PerfMonV2 DF ehnancements
Date:   Thu, 19 May 2022 15:33:29 +0530
Message-ID: <cover.1652954372.git.sandipan.das@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 50270943-96b5-486b-8cb5-08da397edebc
X-MS-TrafficTypeDiagnostic: DS7PR12MB5790:EE_
X-Microsoft-Antispam-PRVS: <DS7PR12MB57902FEA6A5276228AB573728BD09@DS7PR12MB5790.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xw12mWh6cO2oULS3ini7vG/6ugTydbcIkNK9/nusiXo/unmqEHIm4Th0dP+q7X1JkfalMInpBlqVx9nYpIaTKf4fLB0meI+5KL+rEAoOwFV/Z8uRuEodKQH/X4N1ZeXEe2lYm689DNKZZ17s8mTjvSXVmD1HCXm+la7CzF+BfOrK6iHYtn2CetImdu2EyEeVri0cBFfOHvW9YPu/EDtOLooFDBowC/kVv7jOzuswY9N89cEU1JiwKqzHy/eAF/D3XkSPPQE7JK8E59sMv40kUysaGst1so+yfev2OJNcTjqCFU0YYkAVQvb2XTHvSVMnmEN09+XvzVKSejggCKbyrAE+EpDnbdqs3s9TdWHxMn7NpKdlu30D+rojvUvHKA7deAYKa3uFN4B5ohb9KNE7P8Pft3lFZjhpl5ofrPWj1OBCzLrnJBhIGwYJ/YsHAtBiWI/Mps3bOgym9zeRQZpZxLMFkDHrKmN52CD4KW9PrVLJQftFWByMdRAms+jbmZWzegT5JleVu8CLScLWz3Ngt/7X0SxNMH5uMMdWGSCnT+WH++nRe74XJ9BLr4NtySsHL/D6js8bkha3Orm1cULOuDVkzraoHVuHzE0GmOPeVlMWSCU0xogcf80jBTrWdK+bvUKTzHiayrtnUdmqniBrxLYLf+oIzrMgd2uTMbP8Ard9cDlg5YYJgXwVPyl7z8sa9i+p6b9mPcMjwmcSiiJXyA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(6666004)(70586007)(86362001)(7696005)(81166007)(26005)(36860700001)(54906003)(110136005)(316002)(426003)(336012)(40460700003)(47076005)(44832011)(356005)(2616005)(508600001)(7416002)(5660300002)(4326008)(82310400005)(36756003)(2906002)(83380400001)(8676002)(16526019)(8936002)(70206006)(186003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2022 10:03:49.0970
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50270943-96b5-486b-8cb5-08da397edebc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5790
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for using AMD Performance Monitoring Version 2
(PerfMonV2) features for Data Fabric (DF) events on Zen 4
processors. Utilize new CPUID leaf to detect PerfMonV2 and
determine the number of available PMCs. Also introduce the
new event encoding format and RDPMC mappings for accessing
additional DF counters.

E.g. larger metric groups which require more than 4 counters
could not be counted even on a Zen 4 platform that supports
16 DF counters. Only partial counting is possible by using
"--metric-no-group".

  $ sudo perf stat -M nps1_die_to_dram true

Before:

   Performance counter stats for 'system wide':

       <not counted>      dram_channel_data_controller_4                                     (0.00%)
       <not counted>      dram_channel_data_controller_1                                     (0.00%)
       <not counted>      dram_channel_data_controller_6                                     (0.00%)
       <not counted>      dram_channel_data_controller_3                                     (0.00%)
       <not counted>      dram_channel_data_controller_0                                     (0.00%)
       <not counted>      dram_channel_data_controller_5                                     (0.00%)
       <not counted>      dram_channel_data_controller_2                                     (0.00%)
       <not counted>      dram_channel_data_controller_7                                     (0.00%)
             886817 ns    duration_time

         0.000886817 seconds time elapsed

After:

   Performance counter stats for 'system wide':

                   0      dram_channel_data_controller_4 #      0.2 MiB  nps1_die_to_dram
                   0      dram_channel_data_controller_1
                   0      dram_channel_data_controller_6
                2838      dram_channel_data_controller_3
                   0      dram_channel_data_controller_0
                   0      dram_channel_data_controller_5
                   0      dram_channel_data_controller_2
                   0      dram_channel_data_controller_7
              896438 ns   duration_time

         0.000896438 seconds time elapsed

Sandipan Das (5):
  perf/x86/amd/uncore: Use dynamic events array
  perf/x86/amd/uncore: Use attr_update for format attributes
  perf/x86/amd/uncore: Detect available DF counters
  perf/x86/amd/uncore: Add PerfMonV2 DF event format
  perf/x86/amd/uncore: Add PerfMonV2 RDPMC assignments

 arch/x86/events/amd/uncore.c      | 146 ++++++++++++++++++++++++------
 arch/x86/include/asm/perf_event.h |  16 ++++
 2 files changed, 136 insertions(+), 26 deletions(-)

-- 
2.34.1

