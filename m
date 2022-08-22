Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9AF59C0CA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 15:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235265AbiHVNmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 09:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234133AbiHVNmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 09:42:50 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C171FCDF;
        Mon, 22 Aug 2022 06:42:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i4n8904Oiza95QhIZNFzAGkTyxAdFi9RWdRc21Nb55V0kwprpIGbOEnucqzkJbcvbVRh9w4G1phmagBz2qiQsGRVGmcgJDgUiIO31qrcx/FRlmVBwUTmh1Wj8Y5UtWZtimM2C3IsXgFnFLbk6oWffzRAB1bGNqfS/S+DxdYTOEf38tfib3+pX92G6vjZsVpSWIwoI5X0EkMNcWBDempZsQ8OpMvTfSEs3TvzmWdmIE/2vum8VeRCE4Z1JGaRBu+2T/WerGhO9ZDjxNgdQ6H3CMAQC9xtpgDThbr6B2hkrlwDRZXfAs6gZhohUhH9hDzXQLqfp1fUPQkTZjZzff57pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5CWh9dUNBgxMwmkRuHJF9BjjfW3XOkXJfFyNvQbNw50=;
 b=lCKZBaLfNiAHYQ+VlUodj8W6HH2zEG4HqqigkQ0XLnDUKthyfw5bqsuo0uJz8x6GTANLH0dyQjyvWallLOV4i8Fgi7RgsjuUchKgrw70bh5TVCADYoY4QOueY5hr5E6Kjaguk36M2OM545Zpb3SkUZSnJGVaQpu/mut80rbiELHCxRkSH0qsHolv8VVHEln3UZIgZDtJqcieBD2QFIizrLtTn+6UOjQx6kHpJQaMbaV4VncWaAjjFlj8PioFF8g80maHBM52Fe7EYto1ivFkJSyKP0wS1zEtbCFvoWGfYjQ7sVWqMnFasGxE4MrB9Rm464cOcT+IToWj0WI2Qg9P7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5CWh9dUNBgxMwmkRuHJF9BjjfW3XOkXJfFyNvQbNw50=;
 b=Uy557vuHMn6phMdnuQrKFJptos4yXkyXSYQcZSRcrKSO922+qZAsQthGMurg8vxJyXvXPsK2FPQLSuFZEpamiWl4QdbrES1bSEvExyFt79k+DkfWN/DCbXmLOe5/S5HigbnuIt62QOymRA3AXjJdrBTs8chZCPkiMSBivEF6QHk=
Received: from MW4PR03CA0352.namprd03.prod.outlook.com (2603:10b6:303:dc::27)
 by MN0PR12MB6053.namprd12.prod.outlook.com (2603:10b6:208:3cf::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.22; Mon, 22 Aug
 2022 13:42:46 +0000
Received: from CO1NAM11FT072.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dc:cafe::22) by MW4PR03CA0352.outlook.office365.com
 (2603:10b6:303:dc::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.21 via Frontend
 Transport; Mon, 22 Aug 2022 13:42:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT072.mail.protection.outlook.com (10.13.174.106) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5546.7 via Frontend Transport; Mon, 22 Aug 2022 13:42:46 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 22 Aug
 2022 08:42:44 -0500
Subject: [PATCH v3 00/10] x86/resctrl: Support for AMD QoS new features and
 bug fix
From:   Babu Moger <babu.moger@amd.com>
To:     <fenghua.yu@intel.com>, <reinette.chatre@intel.com>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>
CC:     <eranian@google.com>, <dave.hansen@linux.intel.com>,
        <x86@kernel.org>, <hpa@zytor.com>, <corbet@lwn.net>,
        <hpa@zytor.com>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <bagasdotme@gmail.com>
Date:   Mon, 22 Aug 2022 08:42:37 -0500
Message-ID: <166117559756.6695.16047463526634290701.stgit@bmoger-ubuntu>
User-Agent: StGit/1.1.dev103+g5369f4c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6de1ee81-7462-423c-df11-08da84443255
X-MS-TrafficTypeDiagnostic: MN0PR12MB6053:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xZzoeVbRQbZNCnZMAZOzIj8/79OT5Tg54dHdVdZ+u9H/8FBR842jcYM/5M+hh/kJ0rxcDh8lnpfTVWJfNMNzvJ6CWm0cNWR1+DppPYY76eqCxoIe273LWedQMGT5bwja2Lk4U0EiHSKFgwgT8lf0HyjzQpdeg/NIh225k11RwXGGFXSVhI2Wto03q8UuaL9MUK6UaDZBcXPZI1dFieFLqExW9si/20FeIAaDj9GbqeOQElLnnLWtu+V4BOiXIlv5GqUGFsyBQ5/7AtX9Z+GIVLNyAvQJGIE1dIAlR72FpuCvLfYZYs5kwoUUfDArK8JHTVOCy530WMZW2dJK5R1FClrBWqXqIs219NrbfR2F/IsYZZdelsZykIn4Tad1P0yna0rV74CKdOv90sojIr6/AFi0NqHJYKe9AUnVSg7XNGEYrYkLm2djHBwRDYaIbhiP5df/u19snFvy48lZrwt+qhUYI0YuaPlAaKYhCiJIO8OTDvrbn560E0qZEAKzDBO+9DbIMSnBmXXBwuQUeGFUdGVdIBvr0IMYTGAsTipKx41Hp98+IMZMZQ+5SgnavplhMx5wHOLC0Lodf8csD2PBWXgieuA5KUkZmKLCFxwgerUPpIq2eT+uH53FOD90kCyGn7WmTUtokTdDPdegzTyVYFnmQHBdVnLj9eCkGnkYqUpnUnua0Y9Jby6l2b7p5vR/q3ilHEGRMINjiQPn4Yc4XS0t9UL6320/dUn9maEO2ff4lGWzYv7sT3YoT3UatFTf/LpEcddQsA8u/QxmQ3Dj97CKFtSEI2GEoNqv5iWOqAshL5dptu06aJ0QUe41ul4oc0mRb5eU7zDDIcnpCFuz4oqEvIs35jByqWgA/Zg4ePmuNk/u9fZK9Dov12L/KyTNq0o/VfUwdNtPwmnojQBeMA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(7916004)(4636009)(136003)(376002)(39860400002)(396003)(346002)(36840700001)(46966006)(40470700004)(82740400003)(70586007)(70206006)(4326008)(8676002)(54906003)(110136005)(81166007)(356005)(86362001)(36860700001)(426003)(16526019)(336012)(83380400001)(66574015)(186003)(9686003)(26005)(8936002)(47076005)(6666004)(966005)(103116003)(41300700001)(478600001)(7416002)(40460700003)(40480700001)(16576012)(316002)(82310400005)(33716001)(2906002)(44832011)(5660300002)(71626007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2022 13:42:46.1758
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6de1ee81-7462-423c-df11-08da84443255
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT072.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6053
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
1. Slow Memory Bandwidth Con=EF=AC=81guration=0A=
   With this feature, the QOS enforcement policies can be applied=0A=
   to the external slow memory connected to the host. QOS enforcement=0A=
   is accomplished by assigning a Class Of Service (COS) to a processor=0A=
   and specifying allocations or limits for that COS for each resource=0A=
   to be allocated.=0A=
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
This series adds support for these features.=0A=
=0A=
Feature description is available in the specification, "AMD64 Technology Pl=
atform Quality=0A=
of Service Extensions, Revision: 1.03 Publication # 56375 Revision: 1.03 Is=
sue Date: February 2022".=0A=
=0A=
Link: https://www.amd.com/en/support/tech-docs/amd64-technology-platform-qu=
ality-service-extensions=0A=
Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D206537=0A=
---=0A=
=0A=
v3:=0A=
  a. Rebased the patches to latest tip. Resolved some conflicts.=0A=
     https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git=0A=
  b. Taken care of feedback from Bagas Sanjaya.=0A=
  c. Added Reviewed by from Mingo.=0A=
  Note: I am still looking for comments from Reinette or Fenghua.=0A=
=0A=
v2:=0A=
  a. Rebased the patches to latest stable tree (v5.18.15). Resolved some co=
nflicts.=0A=
  b. Added the patch to fix CBM issue on AMD. This was originally discussed=
=0A=
     https://lore.kernel.org/lkml/20220517001234.3137157-1-eranian@google.c=
om/=0A=
  https://lore.kernel.org/lkml/165938717220.724959.10931629283087443782.stg=
it@bmoger-ubuntu/=0A=
=0A=
v1:=0A=
  https://lore.kernel.org/lkml/165757543252.416408.13547339307237713464.stg=
it@bmoger-ubuntu/=0A=
=0A=
Babu Moger (10):=0A=
      x86/resctrl: Fix min_cbm_bits for AMD=0A=
      x86/cpufeatures: Add Slow Memory Bandwidth Allocation feature flag=0A=
      x86/resctrl: Add a new resource type RDT_RESOURCE_SMBA=0A=
      x86/resctrl: Detect and configure Slow Memory Bandwidth allocation=0A=
      x86/cpufeatures: Add Bandwidth Monitoring Event Configuration feature=
 flag=0A=
      x86/resctrl: Introduce mon_configurable to detect Bandwidth Monitorin=
g Event Configuration=0A=
      x86/resctrl: Add sysfs interface files to read/write event configurat=
ion=0A=
      x86/resctrl: Add the sysfs interface to read the event configuration=
=0A=
      x86/resctrl: Add sysfs interface to write the event configuration=0A=
      Documentation/x86: Update resctrl_ui.rst for new features=0A=
=0A=
=0A=
 Documentation/x86/resctrl.rst             | 126 ++++++++++++=0A=
 arch/x86/include/asm/cpufeatures.h        |   2 +=0A=
 arch/x86/kernel/cpu/resctrl/core.c        |  70 ++++++-=0A=
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c |   2 +-=0A=
 arch/x86/kernel/cpu/resctrl/internal.h    |  26 +++=0A=
 arch/x86/kernel/cpu/resctrl/monitor.c     |  16 ++=0A=
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 237 +++++++++++++++++++++-=0A=
 arch/x86/kernel/cpu/scattered.c           |   2 +=0A=
 include/linux/resctrl.h                   |   1 +=0A=
 9 files changed, 472 insertions(+), 10 deletions(-)=0A=
=0A=
--=0A=

