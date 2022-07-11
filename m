Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BCA8570CD0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 23:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231409AbiGKVit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 17:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbiGKVis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 17:38:48 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E4D32DBA;
        Mon, 11 Jul 2022 14:38:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PbQvZmnVwKN/aC8PLFz7/baO5U1JazoMNfBYATPgzvxzfFFHzcYJ/jr/p+hRyvlNhPiSSavR+3hVumeuM1VPgoJmXJu76cVI70T5f1aHq3Mw1SUdf4Q7AzQ+VkSmDdhmgIaCGBbt5jvqhGYY9iqFNgbqqRMxNE1YpLBH+dhaBIut1oShGewV40VjH/kGjOj6xCkQPzMOtG5guJdkypVitKCLxej/+S+1oJLEaGQUBXkIuqMqEu3BHfsYV8xHSTeRdQ54HV1gHA44xlZfKxj+pT9cKAWxB0jutxIIqCeALrtWVN3W3c4QIBKA2xVi+y1OQSzsRuEtvyzs9CoKocb0BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QCDQSz77ns8uLD/q1JRBPNQ/X+74FPskGJxPBcmtr0Y=;
 b=dRcrIAeBK2MHi3wQFtQCvX8hd7/id9Kdty7XfdlGhXWmtcicJAQu4Z0Q4Yu33N8QVHL3HazPY9kTmM2TmQPCSmmbF6xjcBSyQRGP1AWQjo/zrI+bXcxmkTL2UAHudtftPQ7sYPGsRWbxkbQt+XvOY4OJaGqpf+ZZXgHMkjX9/R4dqtj9XlJQOexyyURIWnAkAYDHYXa5DUVhX63WBIHpfIgeMNFjzWmBE2PQxrU/82yn5T8Jc+26+ACXkj8IWYb7mTC6xjGL8P4oWa5dw6n0W//2UBlf3e8k8jR8hPoorRUP38kBgIAsTUYwkRciEMSBYrZZG91q26d0DxA91mzglg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QCDQSz77ns8uLD/q1JRBPNQ/X+74FPskGJxPBcmtr0Y=;
 b=gBa1OnBSPg7Oo5+j204XRYVvOdvDSe/2WAlzcV18dUJ1zqHVQcch2qJ/UbmgREjOeXGT99V/u5Dc9NN8JLl9awxwBkDCfe/y4cRAODn4ZMjugOxpqHp1eX7P192/nMBnLu5SkA1FXe6313uoO7DW23vrIPy8EGLX+qUorjcizTw=
Received: from BN8PR12CA0003.namprd12.prod.outlook.com (2603:10b6:408:60::16)
 by MN2PR12MB4653.namprd12.prod.outlook.com (2603:10b6:208:1b8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.25; Mon, 11 Jul
 2022 21:38:44 +0000
Received: from BN8NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:60:cafe::c7) by BN8PR12CA0003.outlook.office365.com
 (2603:10b6:408:60::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.19 via Frontend
 Transport; Mon, 11 Jul 2022 21:38:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT026.mail.protection.outlook.com (10.13.177.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Mon, 11 Jul 2022 21:38:44 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 11 Jul
 2022 16:38:42 -0500
Subject: [PATCH 0/9] x86/resctrl: Add the support for AMD QoS new features
From:   Babu Moger <babu.moger@amd.com>
To:     <fenghua.yu@intel.com>, <reinette.chatre@intel.com>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>
CC:     <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <corbet@lwn.net>, <hpa@zytor.com>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>
Date:   Mon, 11 Jul 2022 16:38:42 -0500
Message-ID: <165757543252.416408.13547339307237713464.stgit@bmoger-ubuntu>
User-Agent: StGit/1.1.dev103+g5369f4c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: df446ab4-ce4b-4db7-f558-08da6385bacb
X-MS-TrafficTypeDiagnostic: MN2PR12MB4653:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rzH1f4haVNEnSvjhlFxvAYYVVDMJze8VWy3qozJsRJIaU89zaenI3MJWuSCpnjgErbPpcdvso9kMyJkO0zL5pX8HByPPqg2kmSN7ZCbcy8WqPSfxRATo7QJ7gIm2S70+4UN590ues5wPXNMimFNbRJhyEct2b6UpJXQw3REKzhLtLgFXuWrD+O0pMst+uzjsKX7tDbqKNP4Xxyv8aVq6w1L/L7AhAX/AM5pl/lOQ7qKIta7t1J8xqhmcFcZvph8su5jeCcjXojO7MWLtXBt4z8VPkeAa8MXTPfC8sl2HM5RGGlKvXJd0wyLfFnK5RA6k1oRaYON4qLDPzwcvsoLlO02V82KEloT9TtV42WyUVJSMsRITagVIuxIPbfhJQqf2vp3aXz2hKwxKvRViKyBtTG9Gh9adqzXV4PFGXTx8331cbIXffBLfbqsTcnQRYGjeTmDAfCTRp4cAqem4mjN/F7WCKba4isOK0XWSZjBzowdWzcR8/j9h1Gz6Up6/dipOg3X0BpxFK8VGXGhep8CIr+stjew2GV3Kc4eXg8paLmzRQKnoWmfcvlvfw+2ys5NFrC3u1RmsDKGRZEiqR6rpIy033ftaHSYKoa3hQJHKHMphdeBfaV+tKiVsDjN6ATbbl/5BCyD6CRKdUoOCT4yt1xjrV9qFxLaX3HeT2SMD7zukJwa6oT4I+F/i1LAketgOOLn1NFzd1TCBALeLTvNFsBLkx48nHR6OmghyaMLcgfWFQ//ZU5yeTRW3b0PgM924n4PcR4EtIuJIESxXz1t9Wxy57uFGRo5f2eHl4sbFcs+xC2GvqipbQdFcps3ob34UIGg3GiJqe4j/eVdmLquuOF4tGmKHhAud3SIMORNpNi80peRG7Z4yazdVLt18vh+cBWPOnNrYORMepxHTROj9NnzaOhp7ipa4IxzxDXMnzeHs3ENSKDbvd5P0KFiB0Yyx
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(7916004)(4636009)(376002)(39860400002)(346002)(396003)(136003)(46966006)(40470700004)(36840700001)(966005)(103116003)(40480700001)(478600001)(54906003)(2906002)(44832011)(7416002)(33716001)(81166007)(5660300002)(83380400001)(36860700001)(40460700003)(8936002)(336012)(66574015)(426003)(186003)(26005)(9686003)(8676002)(4326008)(47076005)(70586007)(82740400003)(316002)(110136005)(70206006)(41300700001)(16526019)(82310400005)(16576012)(86362001)(356005)(71626007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2022 21:38:44.1450
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df446ab4-ce4b-4db7-f558-08da6385bacb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4653
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
Babu Moger (9):=0A=
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
 arch/x86/kernel/cpu/resctrl/core.c        |  62 ++++++=0A=
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c |   2 +-=0A=
 arch/x86/kernel/cpu/resctrl/internal.h    |  26 +++=0A=
 arch/x86/kernel/cpu/resctrl/monitor.c     |  16 ++=0A=
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 237 +++++++++++++++++++++-=0A=
 arch/x86/kernel/cpu/scattered.c           |   2 +=0A=
 include/linux/resctrl.h                   |   1 +=0A=
 9 files changed, 467 insertions(+), 4 deletions(-)=0A=
=0A=
--=0A=
Signature=0A=

