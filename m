Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE3574DBF87
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 07:29:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbiCQGan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 02:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbiCQGab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 02:30:31 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2063.outbound.protection.outlook.com [40.107.92.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C71B21A3A6;
        Wed, 16 Mar 2022 23:28:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jeuwob26zp+GexW6VhYH9gVdZli+ROysqJ1qMMEoB4768TN+36uxEsZbco/2xvF9qViGiFeu9n6YwO2EzqvrCxllgrKcjt7tnp8gwdCn0fWJ8Sqh0sRpg7xtc2a8w4XoVjLS0CB5e62mdtRx2moZtqKKnhe8lYG9ovWlBTsoSmA9UKmbpdqjkqLq7HNCaHHXow2hq04oZ1I1IhDrp0kVaFQllZaeQCerPDQU5+Uf9IC5ew9zsRdaaeyQCA80dcDWicKe5sNxjLIvR1GSzD+EEEJP8acPBJASqUGuUO7VlQ7ctBawwmX5qTEmSIdVdLxHP+TMeqkJSbqw2ZSVQbj9Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XhXo2Ed6CNiW40ZnkLUPGEPWNT/DYKlHMLmm/pE1xAY=;
 b=IILy0m0sh2IAnhtZpJ66Eauc1z79BrTwEMUW0krCV28OkiRf54w9ZgsOwY9us8/9HM5XyydTDt6Vn1+5gpmS9Sbo+p45GHitVqKDkEVmQN0DF3DUfZZGObODbtCKqqpcIzcB3tzDgXQobOi3rxROUe1v190dhrU7S9m707Z+IxXp9qHVe1u0kv16vlEYH+qUkl6IJfOTVret1zUCV/cWPG1Y1Su/O51/VwRcjbbXSfxi4xyjr9uX7wvPBFnJGkrnqovUvd+3Fy61z7IB1t2VkAMvDG5PpupMNpAxVHnVnDWd4tCBO/+VpPQnTfUiCS3CoFbi+51/PlkGyH77nncS7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XhXo2Ed6CNiW40ZnkLUPGEPWNT/DYKlHMLmm/pE1xAY=;
 b=lTuAL9oO/ACPwYuvgdg+Z1sGMIf0429kAnEVbhkIp9V2aapXnPK80RkH9CFi0v7guPvZ2PCjraj5wdqLSUNQx3QJtEiAcbrYklw2ieGUzv8zZ6gc/48+azo/PFgivw7SFcdUbJb/6WC5trqbqMVIH1Nq9Lln87Dx9+wct6tFUtA=
Received: from DM6PR06CA0003.namprd06.prod.outlook.com (2603:10b6:5:120::16)
 by DM6PR12MB4748.namprd12.prod.outlook.com (2603:10b6:5:33::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.26; Thu, 17 Mar
 2022 06:28:51 +0000
Received: from DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:120:cafe::d4) by DM6PR06CA0003.outlook.office365.com
 (2603:10b6:5:120::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17 via Frontend
 Transport; Thu, 17 Mar 2022 06:28:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT010.mail.protection.outlook.com (10.13.172.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5081.14 via Frontend Transport; Thu, 17 Mar 2022 06:28:50 +0000
Received: from sindhu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 17 Mar
 2022 01:28:44 -0500
From:   Sandipan Das <sandipan.das@amd.com>
To:     <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <x86@kernel.org>
CC:     <peterz@infradead.org>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <namhyung@kernel.org>, <jolsa@kernel.org>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <pbonzini@redhat.com>, <jmattson@google.com>,
        <like.xu.linux@gmail.com>, <eranian@google.com>,
        <ananth.narayan@amd.com>, <ravi.bangoria@amd.com>,
        <santosh.shukla@amd.com>, <sandipan.das@amd.com>
Subject: [PATCH 0/7] perf/x86/amd/core: Add AMD PerfMonV2 support
Date:   Thu, 17 Mar 2022 11:58:29 +0530
Message-ID: <cover.1647498015.git.sandipan.das@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ea2c156b-93ec-4387-3a8a-08da07df66c0
X-MS-TrafficTypeDiagnostic: DM6PR12MB4748:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4748BB8686082F9A4E9602238B129@DM6PR12MB4748.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mfciMM9LM6xvX03c8/GJUzVzaSA83HThG92XPTN72mRlkxtBVUCOD6PTiVhxbuRGili2nk9YJeYfaP+MgdICL+Ix6XitU887ezO49zvFRLLZPIDb1aTW4037HftFqKt/U4yY1qXgJoU1d8eYAD/LXAw9qSDF+bSytRYmvTu7evOJhVFvEr+O78YrNQIE7qg2aQh4R2bGZn3ffKjQbY1fEuA+G7To0HlH4L1prih1VgnY7++QINoTHVrwIgU81nqXZ75W4seE3fa5cRupp1rAjL0D6mgSwAZML3GUKXGiHvB+ZUw4PWKBF8zL4R2o0boiccMep6mQyFVwpQqbpRconNnrK7R5SmnphXeNMAc2mW0pnYWw4OuPn83K9fu671u9ujq2ZhVHOuO0wpERC8LfAb/OT0eov3MqLVCsBitfmlVIiY7dBb+xKi3v7BzU2qPkpXQrC4SideekbQDNbVN1c1Zhcb6IqRpcioJmcBYn+u8BpG1XAFNc/jHWlS0UJI58yLHLsLJX8jYC3c+4nM3KovKizc2vt7PCXhgKQd62gkMp4eumoSZ1pUXaAZQsjyuceMBUtCMinwYMnxNnSeXC5kR4RyWVD3AfjiDJWRKB2lIkRZWnDhVH1l+tMP59pxevr8xfy08ZBLObXEBN/Du+EXZkA/2lvP60/rrl5wlEQq3wHKVq1zzc6StuS87WcvNNxd/wa3RIHpzO5eiSYxk5WQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(16526019)(7416002)(2616005)(36860700001)(426003)(336012)(40460700003)(86362001)(110136005)(356005)(186003)(5660300002)(508600001)(36756003)(26005)(44832011)(6666004)(2906002)(70206006)(70586007)(54906003)(81166007)(8936002)(83380400001)(4326008)(8676002)(47076005)(316002)(7696005)(82310400004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2022 06:28:50.7446
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea2c156b-93ec-4387-3a8a-08da07df66c0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4748
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
(PerfMonV2) features on upcoming processors. New CPU features
are introduced for PerfMonV2 detection. New MSR definitions
are added to make use of an alternative PMC management scheme
based on the new PMC global control and status registers.

The global control register provides the ability to start and
stop multiple PMCs at the same time. This makes it possible
to enable or disable all counters with a single MSR write
instead of writing to the individual PMC control registers
interatively under x86_pmu_{enable,disable}(). The effects
can be seen when counting the same events across multiple
PMCs.

E.g.

  $ sudo perf stat -e "{cycles,instructions,cycles,instructions}" sleep 1

Before:

   Performance counter stats for 'sleep 1':
  
             1013281      cycles
             1452859      instructions              #    1.43  insn per cycle
             1023462      cycles
             1461724      instructions              #    1.43  insn per cycle

         1.001644276 seconds time elapsed
  
         0.001948000 seconds user
         0.000000000 seconds sys

After:

   Performance counter stats for 'sleep 1':
  
              999165      cycles
             1440456      instructions              #    1.44  insn per cycle
              999165      cycles
             1440456      instructions              #    1.44  insn per cycle
  
         1.001879504 seconds time elapsed
  
         0.001817000 seconds user
         0.000000000 seconds sys

No additional failures are seen upon running the following:
  * perf built-in test suite
  * perf_event_tests suite
  * rr test suite

Sandipan Das (7):
  x86/cpufeatures: Add PerfMonV2 feature bit
  x86/msr: Add PerfCntrGlobal* registers
  perf/x86/amd/core: Detect PerfMonV2 support
  perf/x86/amd/core: Detect available counters
  perf/x86/amd/core: Add PerfMonV2 counter control
  perf/x86/amd/core: Add PerfMonV2 overflow handling
  kvm: x86/cpuid: Fix Architectural Performance Monitoring support

 arch/x86/events/amd/core.c         | 217 ++++++++++++++++++++++++++++-
 arch/x86/include/asm/cpufeatures.h |   2 +-
 arch/x86/include/asm/msr-index.h   |   5 +
 arch/x86/include/asm/perf_event.h  |   8 ++
 arch/x86/kernel/cpu/scattered.c    |   1 +
 arch/x86/kvm/cpuid.c               |   5 +
 6 files changed, 230 insertions(+), 8 deletions(-)

-- 
2.32.0

