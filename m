Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 883DE587295
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 22:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234869AbiHAU4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 16:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234741AbiHAUz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 16:55:59 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6008A2ED71;
        Mon,  1 Aug 2022 13:55:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WusqwZtznrwu+chpRvIHbQogJTMCSv50ZimvV+XqGHYn3WIuD7FFJ+SXAAGRazGUAtGIxNWG6v0awig928oOOBHuO9Wo806S1rrMgkqplmPNGeh2M/WK5gpbcRKQLwjwEaeIp3riRtiClwB7HNE7T73zYLee9jSuXTmajpCdQnNsgzXb9IudIS9StHAM57kyAu5wodmBv5MPWY43DGQbnddxfd4G5EmxuTs3v7GZxMeq0bJD70q4eXl4I8u5aXzE2I84AIGWEOhT3ehbCvor5bttWjGxnsI7X9gvhahXHp7jcC36MLNMK6fm3gYFMyPw46+ve3synJUyibW8VyGF9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cAPC+/0pPZjLINrW2aMLR421RjOQFbPxaM1soFYrU2o=;
 b=LuX5oGelLhYIle47+W2DniQl9HxHi17y2lJ4DKpUIRl57No+/EKfVnllnpWeoRJzbO6GncMd7owHJfsG3oqCy9Vlby9lM8wnrm9YDxo8JhlaBUVnw65KygaA4Ngr6bcoNELyBXRJd19gPwja+PcXUDf0f8HYBjzr/wHIQ1Lk25Bcef1ueuW8tKQuCLGCOzAvT0EeZIwc21l8pMg3R+y0DYJSsAkZKnFidzv5ldSyjFUm2fEhwIJ0sJPsfc2YotsEx4t3MAdK6qufMQs8rzMwWHS9OmNlus2BxRYELwEs6ZY5DzZsKc2CnJ9g4OLvxBcQXL23L08YIzIYfRXpDlXj8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cAPC+/0pPZjLINrW2aMLR421RjOQFbPxaM1soFYrU2o=;
 b=HIcU935TNXyjMC58Wwa01JLD5cjWGm2VNKz6EBJNtceYSYAr1KjGMQXeetsaclP4tY9fgjxlzziYv+LN+R7WSKE8GZpBHo+cDrRF1SAPbBJaSWhai10OHaeBDA5/waNROMlyYpTLkPx7BAGhaGR050PzIkw7O1N4+uios7ZVNJE=
Received: from BN8PR04CA0017.namprd04.prod.outlook.com (2603:10b6:408:70::30)
 by MW2PR12MB2362.namprd12.prod.outlook.com (2603:10b6:907:e::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.12; Mon, 1 Aug
 2022 20:55:52 +0000
Received: from BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:70:cafe::d5) by BN8PR04CA0017.outlook.office365.com
 (2603:10b6:408:70::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.24 via Frontend
 Transport; Mon, 1 Aug 2022 20:55:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT050.mail.protection.outlook.com (10.13.177.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5482.10 via Frontend Transport; Mon, 1 Aug 2022 20:55:52 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 1 Aug
 2022 15:55:41 -0500
Subject: [PATCH v2 00/10] x86/resctrl: Support for AMD QoS new features and
 bug fix
From:   Babu Moger <babu.moger@amd.com>
To:     <fenghua.yu@intel.com>, <reinette.chatre@intel.com>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>
CC:     <eranian@google.com>, <dave.hansen@linux.intel.com>,
        <x86@kernel.org>, <hpa@zytor.com>, <corbet@lwn.net>,
        <hpa@zytor.com>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>
Date:   Mon, 1 Aug 2022 15:55:40 -0500
Message-ID: <165938717220.724959.10931629283087443782.stgit@bmoger-ubuntu>
User-Agent: StGit/1.1.dev103+g5369f4c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 964b2e38-e43a-4265-4524-08da74003890
X-MS-TrafficTypeDiagnostic: MW2PR12MB2362:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: slnww9YCOwUoqbGkxYJHB55sZi5271iL+I11KOpHMB2/mvKX+o2hIHy3bjQVTzwKhRxcRTxxkruqpCviEBEqIJPcedqo7QGkx33x/YDRQFuCI+m6eQqYguFj1J4xe7NopwTUVjnOtBguCjRi0VBMdJirEShXHocRVI/wLnIVUfxgfKIGlToNLeOfxgpZn5HcBZtGP+J5pqVzCPkGwKKHqWA7V5jcowcdjk54oYlwMCwfijvtjxkSy8G+FDNMDC/ZwenDfy8CCi2xoUvxpOi+L1i6dfuJa1ZD/XzI3dRIesL4jDuj0rts+Ezk2mD/YpIL+WXD/70sY9rkpDUmbfVGN5sOx0C05K+I+WImoG3Su+CXXqgzGHv7LoIuWyxg6fap/s2A3MwVI990nwogKtwST1l+98a7nG03p10jnLeY7Bt6Q1ML0ZxKjKcDjgr5UsV8kFFoiCxwJxTKqnRFFMpGrxf8IOBW2qhlBg6SWixiwI1JR0hEi9AdQuUngJVg0t0Q06Oh41zjwl+983Nuvt65ovjzTjZzFaGFemniR7NdaJcwOWzy3xYGUVvwACkB50TMJOhsJurIEbjJa7xRrinyhMN1tCPK3ay2XnQBmTW1VVSr+nuYcVC66RiGOAAf+rgUxZF7/bZsFpdRFSEQMNMTDx0FCZm4Bfw0Z464jhceohUWC3IfSfQx34w0tlyM5chBs1OWZiVROx/6kyXujtnIJU9u4cnyFVGzRBQV/IoI5NXIyjzCxe6e/3sNDKxNK8vizxj8Eue1M65LnLYg/29L9i9YLMF7rGKcayYySR5axHhzi5Xk3xQDOyq9fhSjzmy9r2v3soEo5rkDNcj+wQXAj8vwzhst4SrVr06RbWyIGTVtHufnDdx95b70C8S4whjj8pTfJvBZvHJwYFtDFwQdqErYJKJ5m0BPszSUVkZB77VzNsqvY+SLcvJye3BqZwhY
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(7916004)(4636009)(136003)(396003)(39860400002)(376002)(346002)(46966006)(40470700004)(36840700001)(86362001)(110136005)(2906002)(54906003)(40480700001)(81166007)(36860700001)(41300700001)(16576012)(316002)(9686003)(40460700003)(82310400005)(82740400003)(26005)(356005)(426003)(83380400001)(336012)(47076005)(8936002)(7416002)(966005)(33716001)(66574015)(478600001)(70586007)(5660300002)(70206006)(16526019)(44832011)(186003)(103116003)(8676002)(4326008)(71626007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2022 20:55:52.3366
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 964b2e38-e43a-4265-4524-08da74003890
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2362
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
=0A=
Also added a bugfix submitted by Stephane Eranian.=0A=
=0A=
---=0A=
v2:=0A=
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
 Documentation/x86/resctrl.rst             | 123 +++++++++++=0A=
 arch/x86/include/asm/cpufeatures.h        |   2 +=0A=
 arch/x86/kernel/cpu/resctrl/core.c        |  70 ++++++-=0A=
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c |   2 +-=0A=
 arch/x86/kernel/cpu/resctrl/internal.h    |  26 +++=0A=
 arch/x86/kernel/cpu/resctrl/monitor.c     |  16 ++=0A=
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 237 +++++++++++++++++++++-=0A=
 arch/x86/kernel/cpu/scattered.c           |   2 +=0A=
 include/linux/resctrl.h                   |   1 +=0A=
 9 files changed, 469 insertions(+), 10 deletions(-)=0A=
=0A=
--=0A=
Signature=0A=

