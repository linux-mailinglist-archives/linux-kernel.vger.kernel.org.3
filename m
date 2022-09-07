Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D7EA5B0BF0
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 20:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbiIGSAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 14:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbiIGR76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 13:59:58 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B1394331D;
        Wed,  7 Sep 2022 10:59:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QXEldiAI+5N2La+xY97ezl92fHlzIoKHaeMwKtw8WrOqDknlfwtpao3yuug+k66tWX4YvGMhyHE0tuOOaS6XLy8UkL3Skmo+oA9PALIHM3gL25uifXBI63zLGLjAtz08x+Yxl9vW2IBs0gDaOAvQirHtcyHZ7oxkyT4cVTF3zbFr178zIbJw19S2bDPawX7QTqJRs5kVjzO4e5hfCOHO7wh7JbPg8zEldbSI1Iri/PzXYZh9S4L8LjEOj+5mluIzaA5dN78vTRFQdR+qVATHiDYu1JROsQUV0+nJ4o6H1iFntYPRlHvPKoTH0QF8tMtme+w0GfHTOuckCSQ+SaoUXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ET60Kioy4nqhMu0z5ylJhuywsjb8u5B74UmZAqrr+VE=;
 b=FrOdxeKDsMvEJLEkjPynTFLsrUo4CllYUgozeAuc0ovb9E8L1BU5I2gpmp2pcCWUtbsLMGUq+FQLqV5TGdo0bJGfhQWq2tVKHhVjvikBBDXf3K+4XFbMKXX1c/QkJsDOcYvX0QHZZZIoaThm3jKcGw/zNs3lL8HPvgZCL63/0wYjIx6TH2z4EtVUJKDRuJ4tl/MjCGaQwWiiKlZF33r8PRNlSNQHzrJDLvJ6AMlBZ2yHkUASzXej2RaDMFxU/x7xKA+06TxnV2w9LEIEIqljSUcF6z7ExNNMNOXGb3Ld5KQpblHMdQIMzzDZG9/C1wE78QLNIp3z6t/rRm8Fp2u52Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ET60Kioy4nqhMu0z5ylJhuywsjb8u5B74UmZAqrr+VE=;
 b=eemM7gy9dgEsA4dZ0nspb1MaSHvW1hl72Qpdi8tgNWkYns86+11QZ+q8xNkyt1R+PSSwxdVXW1Q0RmlI/grgUIzdGy6UTEgyXDpPB/mW541/+aLveFsK3PThCYpPaJZVVl87b2ujxLGRu44EewqF4U4Y8CkkQY6lq/isXrX3yQo=
Received: from BN0PR04CA0027.namprd04.prod.outlook.com (2603:10b6:408:ee::32)
 by BL0PR12MB5505.namprd12.prod.outlook.com (2603:10b6:208:1ce::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Wed, 7 Sep
 2022 17:59:52 +0000
Received: from BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ee:cafe::9f) by BN0PR04CA0027.outlook.office365.com
 (2603:10b6:408:ee::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12 via Frontend
 Transport; Wed, 7 Sep 2022 17:59:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT046.mail.protection.outlook.com (10.13.177.127) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Wed, 7 Sep 2022 17:59:52 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 7 Sep
 2022 12:59:50 -0500
Subject: [PATCH v4 00/13] x86/resctrl: Support for AMD QoS new features and
 bug fix
From:   Babu Moger <babu.moger@amd.com>
To:     <corbet@lwn.net>, <reinette.chatre@intel.com>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>
CC:     <fenghua.yu@intel.com>, <dave.hansen@linux.intel.com>,
        <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
        <akpm@linux-foundation.org>, <quic_neeraju@quicinc.com>,
        <rdunlap@infradead.org>, <damien.lemoal@opensource.wdc.com>,
        <songmuchun@bytedance.com>, <peterz@infradead.org>,
        <jpoimboe@kernel.org>, <pbonzini@redhat.com>, <babu.moger@amd.com>,
        <chang.seok.bae@intel.com>, <pawan.kumar.gupta@linux.intel.com>,
        <jmattson@google.com>, <daniel.sneddon@linux.intel.com>,
        <sandipan.das@amd.com>, <tony.luck@intel.com>,
        <james.morse@arm.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bagasdotme@gmail.com>,
        <eranian@google.com>
Date:   Wed, 7 Sep 2022 12:59:49 -0500
Message-ID: <166257348081.1043018.11227924488792315932.stgit@bmoger-ubuntu>
User-Agent: StGit/1.1.dev103+g5369f4c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT046:EE_|BL0PR12MB5505:EE_
X-MS-Office365-Filtering-Correlation-Id: bcda94b5-0dd4-4d74-6cf7-08da90fac369
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qQEZYEPpyqap/R87OuCWlVEhldMr9raOcz2BjCzWby1dcCT4WqzjUoD6rP0DuDK/PIsPTYQN34yvp+x/64pOhGvj8aiP98ty2SS5eMCGbozdz88NvO9ITpZ2siCn8DqHkbEb6PYLPvOiJCBdWVyfC0MWIw17579Fq9p/YXpXuII2IESsg/ZjxEPYvEeQd225cDkpTvRGnkaq+ycTfkBSwc18s9GcS4NplEaZYnaQRHJEiqA8fRTrGFHEUofSt2co5XUPR4Q1z48uieg1hQ1cAAIbdWsLAtFZ7szwZbpgR/JM60jBoYJUGDqbGMV6nqzpRJM7Vxi+FoZz0xApe2QFWINzNQKTTrlTi5psqr0UEUTNwkUpemfYpWSXenE6ydd8LDdqRBkHrwm64nVKtMoxr6g9I6niUPR3elo2XyG1vYkx/pN2Hfy5z9NiUMi/rtNcGcLGG8r0L+dj0NHFYGtg9XsR8sebduuwcmQgjIbccnvoDsi9Po216Z08nSUwAMXvlZZGzDsyHtsb+TU0LEz0vpk3VOSXESB0mqRlkKX3xJSB6Ws6VcKo+mPOFKj37ySdrTbDJdkK51aSArMTyZGnYVhZeSBWQaclOaeC+irjPxfc9ML6+6r0UGPpCg9N7SiodufsqSTmKqeFYwWb4OugSOGOiqR9YxSiMVPbA1wb364j75WU/PlHw0TXVgRoF4KtOqWKPMMYbGlJWkvd1PjcMDLskGdAB5c4wakGOAIaKBlRiVtztjH401RVWv1INaKvBAql3tb6Rks1pkXFjP5oMeILZmPw+N1TfvmGPyQcIeAEDk0ibkcuxre9PeZm1Eua80fEmYZHRpUagH0E0BlpMlHpu/MO63qksimiXJ43zOFpejJcbrhMAO3YMyizEiNKKe6ePAezXPEjXivVEybV5g==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(7916004)(346002)(136003)(396003)(39860400002)(376002)(36840700001)(46966006)(40470700004)(81166007)(316002)(36860700001)(356005)(83380400001)(2906002)(70586007)(82740400003)(4326008)(33716001)(8676002)(82310400005)(110136005)(70206006)(16576012)(54906003)(5660300002)(426003)(26005)(44832011)(40480700001)(7416002)(9686003)(186003)(86362001)(478600001)(16526019)(8936002)(47076005)(41300700001)(966005)(40460700003)(103116003)(336012)(71626007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2022 17:59:52.0255
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bcda94b5-0dd4-4d74-6cf7-08da90fac369
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5505
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

New AMD processors can now support following QoS features.=0A=
=0A=
1. Slow Memory Bandwidth Allocation (SMBA)=0A=
   With this feature, the QOS enforcement policies can be applied=0A=
   to the external slow memory connected to the host. QOS enforcement=0A=
   is accomplished by assigning a Class Of Service (COS) to a processor=0A=
   and specifying allocations or limits for that COS for each resource=0A=
   to be allocated.=0A=
=0A=
   Currently, CXL.memory is the only supported "slow" memory device. With=
=0A=
   the support of SMBA feature the hardware enables bandwidth allocation=0A=
   on the slow memory devices.=0A=
=0A=
2. Bandwidth Monitoring Event Configuration (BMEC)=0A=
   The bandwidth monitoring events mbm_total_event and mbm_local_event =0A=
   are set to count all the total and local reads/writes respectively.=0A=
   With the introduction of slow memory, the two counters are not enough=0A=
   to count all the different types are memory events. With the feature=0A=
   BMEC, the users have the option to configure mbm_total_event and=0A=
   mbm_local_event to count the specific type of events.=0A=
=0A=
   Following are the bitmaps of events supported.=0A=
   Bits    Description=0A=
     6       Dirty Victims from the QOS domain to all types of memory=0A=
     5       Reads to slow memory in the non-local NUMA domain=0A=
     4       Reads to slow memory in the local NUMA domain=0A=
     3       Non-temporal writes to non-local NUMA domain=0A=
     2       Non-temporal writes to local NUMA domain=0A=
     1       Reads to memory in the non-local NUMA domain=0A=
     0       Reads to memory in the local NUMA domain=0A=
=0A=
This series adds support for these features. Added a bug fix and a code cle=
anup.=0A=
=0A=
Feature description is available in the specification, "AMD64 Technology Pl=
atform Quality=0A=
of Service Extensions, Revision: 1.03 Publication # 56375 Revision: 1.03 Is=
sue Date: February 2022".=0A=
=0A=
Link: https://www.amd.com/en/support/tech-docs/amd64-technology-platform-qu=
ality-service-extensions=0A=
Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D206537=0A=
=0A=
---=0A=
4:=0A=
  Got numerios of comments from Reinette Chatre. Addressed most of them. =
=0A=
  Summary of changes.=0A=
  1. Removed mon_configurable under /sys/fs/resctrl/info/L3_MON/.  =0A=
  2. Updated mon_features texts if the BMEC is supported.=0A=
  3. Added more explanation about the slow memory support.=0A=
  4. Replaced smp_call_function_many with on_each_cpu_mask call.=0A=
  5. Removed arch_has_empty_bitmaps=0A=
  6. Few other text changes.=0A=
  7. Removed Reviewed-by if the patch is modified.=0A=
  8. Rebased the patches to latest tip.=0A=
=0A=
v3:=0A=
  https://lore.kernel.org/lkml/166117559756.6695.16047463526634290701.stgit=
@bmoger-ubuntu/ =0A=
  a. Rebased the patches to latest tip. Resolved some conflicts.=0A=
     https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git=0A=
  b. Taken care of feedback from Bagas Sanjaya.=0A=
  c. Added Reviewed by from Mingo.=0A=
  Note: I am still looking for comments from Reinette or Fenghua.=0A=
=0A=
v2:=0A=
  https://lore.kernel.org/lkml/165938717220.724959.10931629283087443782.stg=
it@bmoger-ubuntu/=0A=
  a. Rebased the patches to latest stable tree (v5.18.15). Resolved some co=
nflicts.=0A=
  b. Added the patch to fix CBM issue on AMD. This was originally discussed=
=0A=
     https://lore.kernel.org/lkml/20220517001234.3137157-1-eranian@google.c=
om/=0A=
=0A=
v1:=0A=
  https://lore.kernel.org/lkml/165757543252.416408.13547339307237713464.stg=
it@bmoger-ubuntu/=0A=
=0A=
Babu Moger (13):=0A=
      x86/resctrl: Fix min_cbm_bits for AMD=0A=
      x86/resctrl: Remove arch_has_empty_bitmaps=0A=
      x86/cpufeatures: Add Slow Memory Bandwidth Allocation feature flag=0A=
      x86/resctrl: Add a new resource type RDT_RESOURCE_SMBA=0A=
      x86/cpufeatures: Add Bandwidth Monitoring Event Configuration feature=
 flag=0A=
      x86/resctrl: Include new features in command line options=0A=
      x86/resctrl: Detect and configure Slow Memory Bandwidth allocation=0A=
      x86/resctrl : Introduce data structure to support monitor configurati=
on=0A=
      x86/resctrl: Add sysfs interface files to read/write event configurat=
ion=0A=
      x86/resctrl: Add the sysfs interface to read the event configuration=
=0A=
      x86/resctrl: Add sysfs interface to write the event configuration=0A=
      x86/resctrl: Replace smp_call_function_many with on_each_cpu_mask=0A=
      Documentation/x86: Update resctrl_ui.rst for new features=0A=
=0A=
=0A=
 .../admin-guide/kernel-parameters.txt         |   2 +-=0A=
 Documentation/x86/resctrl.rst                 | 148 +++++++++-=0A=
 arch/x86/include/asm/cpufeatures.h            |   2 +=0A=
 arch/x86/kernel/cpu/resctrl/core.c            |  58 +++-=0A=
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c     |   5 +-=0A=
 arch/x86/kernel/cpu/resctrl/internal.h        |  32 ++-=0A=
 arch/x86/kernel/cpu/resctrl/monitor.c         |   9 +-=0A=
 arch/x86/kernel/cpu/resctrl/rdtgroup.c        | 272 +++++++++++++++---=0A=
 arch/x86/kernel/cpu/scattered.c               |   2 +=0A=
 include/linux/resctrl.h                       |   6 +-=0A=
 10 files changed, 479 insertions(+), 57 deletions(-)=0A=
=0A=
--=0A=

