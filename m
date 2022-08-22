Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56EFD59C0D6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 15:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235312AbiHVNnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 09:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234656AbiHVNns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 09:43:48 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2060.outbound.protection.outlook.com [40.107.243.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE4B165B1;
        Mon, 22 Aug 2022 06:43:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cs0dT9am0LA2TD9ZlhtxRv7pVtT8fGyBZ0K8u8h04cHYvow/JHO9SP7ANMATJNOdKVXECUqsfh6laa4b1h43xUndVX1ImjYAxPy+cC+VKlwznf7CHc9YgIeurhHLAyiavdxWSr0LtP+uRF6wXU7IwSIxQqD4yqfY160lqLC0JbDRK+nC2yKpz6fhvMHU8/4zOvUzeS6ciEX5aX8b2aRruoBNgrLqwThZOfpdUP6b1JyHFxgug5tZQIizi27iLwjoo1IZGj5VA1zQHsIL2ZBLUAh/Kvf1RlBMACO86lWGYffscYt8kxwr777mybDeOJ2FyFpBWOA5+Cum/JI8zKkmcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+iiMtt4Yzok+WlTQJ/wmcZ2gX1D2kL8TGTNd5ktC4ko=;
 b=co7xXEE81pGbKOHjynQDk35bP6SEYWew6+8OqJPkkIWRZq2Z2ns48+kgzfHqqIm3QbyMxnjFquA0qWHcHJ52012Wm/96JqpcsWgB12xHjr7pyvtIqBIo3gAffM3wbZ14/WCMo9Rpl+1p8MWnNCiWIDTiT1b+SX60X3tmRb3adp3ISYb59Sa/rKq1MVfakrldyFeynFDBmpRCGvJLalGOqhlmGzX6k53us9AvJjYKB1kEkZgheHsUr217LnS0e4f4EOqeHcbmXH9WCF2Ht82R63VLu+ElU0nGrdESZyLssV8HoCIkviiORrcKGhpqX7UPK0iF4gQItc6pN+JITiBPHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+iiMtt4Yzok+WlTQJ/wmcZ2gX1D2kL8TGTNd5ktC4ko=;
 b=HW7lhzxIePBuNHH7IVP/7SmdhrCFDYOItPddum3zyg3Cymy7+uJwYRRpsp+Ohf0XGcangsxMaoZQNryhECir5BLUB6BnvdTqHImR58Sm76SOEfvq81qwz5OpnEZnj+jwiseIijgcTwSvRWRrneuAjxw1TIUWts5yDAIQKxfN5z8=
Received: from MW4PR04CA0075.namprd04.prod.outlook.com (2603:10b6:303:6b::20)
 by DS7PR12MB6143.namprd12.prod.outlook.com (2603:10b6:8:99::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.22; Mon, 22 Aug
 2022 13:43:44 +0000
Received: from CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6b:cafe::ff) by MW4PR04CA0075.outlook.office365.com
 (2603:10b6:303:6b::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.22 via Frontend
 Transport; Mon, 22 Aug 2022 13:43:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT003.mail.protection.outlook.com (10.13.175.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5546.15 via Frontend Transport; Mon, 22 Aug 2022 13:43:44 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 22 Aug
 2022 08:43:41 -0500
Subject: [PATCH v3 05/10] x86/cpufeatures: Add Bandwidth Monitoring Event
 Configuration feature flag
From:   Babu Moger <babu.moger@amd.com>
To:     <fenghua.yu@intel.com>, <reinette.chatre@intel.com>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>
CC:     <eranian@google.com>, <dave.hansen@linux.intel.com>,
        <x86@kernel.org>, <hpa@zytor.com>, <corbet@lwn.net>,
        <hpa@zytor.com>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <bagasdotme@gmail.com>
Date:   Mon, 22 Aug 2022 08:43:40 -0500
Message-ID: <166117582066.6695.7752000977572509392.stgit@bmoger-ubuntu>
In-Reply-To: <166117559756.6695.16047463526634290701.stgit@bmoger-ubuntu>
References: <166117559756.6695.16047463526634290701.stgit@bmoger-ubuntu>
User-Agent: StGit/1.1.dev103+g5369f4c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5dbb3eaa-326b-4880-21fb-08da844454d2
X-MS-TrafficTypeDiagnostic: DS7PR12MB6143:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZQaIv1T5sZJipZ6OkybIOSY4anwGRZmC/0oxOP47Yz5WsSnfHJcFkhFSOIKO5ZtFNRtsmrZkFaRxUzKX8ALRjxs201B8Ogk+5VDd7pJUKCJmjq2JTAwRgT35+qIrJdD8JopNuSO0AT4sJIGWox2yKyupEAnmO1Skjra7OoFr9x/FBkz+VsDjNKJ/0oMLv5txw0UMB3DUdDL/RRUbXq9eKjZuT2YEn6BAtdjgQkc01SNQJPz8dzM4XO/KgVDoRBuEITgrBdhl6u3RR5Y2SOUy7ZRqXWJEaCaqywEQHnlXvTVARVbrJ/ztogxTd26Hj6xV2lBW2Ley3aZRmzb9KTFRPNuN3gJdlEFG3tebc4zKouoj7neBpMqbEVpOM+HweUXUGgvcpZ4NvuJJG1f6LjCxaauiwQxvveUQje2IRjbID2RB53kU3opWAYLypqP/Gnllauw5eBhATM5DBTjLwa5C6ASFP21zqA4PwwujvOgh7EzPPgdx2hzfRNGSJ9IdMVCIoNA+5ClVOd5JwAyVfAylmufbAJHcTeN0pgXYZgmPdc/yg1R1fUBVWy6vVblRFWQznySuvbBoJwQ1lnWgMnDhim/lTJapglskyxNfkHj3HpGk4ls/kAyvChg3or04Ar1nHr7s83T9AeNrKiUsETJ4rh9lYNg3MpwgbZ2qq8fTDZnXm653zntnsOkj40n3eZSw5cjBmZb1PLLqjB6RU7A3RjAoEJ9UFacAVlIXYugnXAyBm2xDURpxcJu6QTNos1FtdvcUJ22F3Njm/VWgsP4FrKghVZNjAhhbgQfcEDFD4Grh7A2sWy7egR/t8hE5XuL2u2ymkV7LHButVgfu1bvk7+T0jFnRRlaV0Hr6LjQ+LVVKNjwT167cL/Dw2FahOMaoUfByH4s/stnoN8nKTDVpHg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(7916004)(376002)(136003)(346002)(396003)(39860400002)(46966006)(40470700004)(36840700001)(966005)(478600001)(16526019)(336012)(8936002)(186003)(47076005)(426003)(9686003)(26005)(2906002)(41300700001)(5660300002)(82310400005)(44832011)(83380400001)(40460700003)(7416002)(40480700001)(316002)(16576012)(33716001)(54906003)(110136005)(70586007)(8676002)(4326008)(70206006)(86362001)(103116003)(81166007)(82740400003)(356005)(36860700001)(71626007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2022 13:43:44.0171
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dbb3eaa-326b-4880-21fb-08da844454d2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6143
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Newer AMD processors support the new feature Bandwidth Monitoring Event=0A=
Configuration (BMEC).=0A=
=0A=
Support of this feature is available via CPUID Fn8000_0020_EBX_x0 (ECX=3D0)=
.=0A=
Bits    Field Name       Description=0A=
3        EVT_CFG         Bandwidth Monitoring Event Configuration (BMEC)=0A=
=0A=
Currently, the bandwidth monitoring events mbm_total_bytes and=0A=
mbm_local_bytes are set to count all the total and local reads/writes=0A=
respectively. With the introduction of SLOW memory, the two counters are=0A=
not enough to count all the different types of memory events. With the=0A=
feature BMEC, the users have the option to configure mbm_total_bytes and=0A=
mbm_local_bytes to count the specific type of events.=0A=
=0A=
Each BMEC event has a configuration MSR, QOS_EVT_CFG (0x000_0400h +=0A=
EventID) which contains one field for each Bandwidth Type that can be used=
=0A=
to configure the bandwidth event to track any combination of supported=0A=
bandwidth types. The event will count requests from every Bandwidth Type=0A=
bit that is set in the corresponding configuration register.=0A=
=0A=
Following are the types of events supported:=0A=
=0A=
=3D=3D=3D=3D    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
Bits    Description=0A=
=3D=3D=3D=3D    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
6       Dirty Victims from the QOS domain to all types of memory=0A=
5       Reads to slow memory in the non-local NUMA domain=0A=
4       Reads to slow memory in the local NUMA domain=0A=
3       Non-temporal writes to non-local NUMA domain=0A=
2       Non-temporal writes to local NUMA domain=0A=
1       Reads to memory in the non-local NUMA domain=0A=
0       Reads to memory in the local NUMA domain=0A=
=3D=3D=3D=3D    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
=0A=
By default, the mbm_total_bytes configuration is set to 0x7F to count=0A=
all the event types and the mbm_local_bytes configuration is set to=0A=
0x15 to count all the local memory events.=0A=
=0A=
Feature description is available in the specification, "AMD64 Technology=0A=
Platform Quality of Service Extensions, Revision: 1.03 Publication # 56375=
=0A=
Revision: 1.03 Issue Date: February 2022".=0A=
=0A=
Link: https://www.amd.com/en/support/tech-docs/amd64-technology-platform-qu=
ality-service-extensions=0A=
Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D206537=0A=
Signed-off-by: Babu Moger <babu.moger@amd.com>=0A=
Reviewed-by: Ingo Molnar <mingo@kernel.org>=0A=
---=0A=
 arch/x86/include/asm/cpufeatures.h |    1 +=0A=
 arch/x86/kernel/cpu/scattered.c    |    1 +=0A=
 2 files changed, 2 insertions(+)=0A=
=0A=
diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpuf=
eatures.h=0A=
index 1815435c9c88..a4ee02a56d54 100644=0A=
--- a/arch/x86/include/asm/cpufeatures.h=0A=
+++ b/arch/x86/include/asm/cpufeatures.h=0A=
@@ -305,6 +305,7 @@=0A=
 #define X86_FEATURE_USE_IBPB_FW		(11*32+16) /* "" Use IBPB during runtime =
firmware calls */=0A=
 #define X86_FEATURE_RSB_VMEXIT_LITE	(11*32+17) /* "" Fill RSB on VM exit w=
hen EIBRS is enabled */=0A=
 #define X86_FEATURE_SMBA		(11*32+18) /* SLOW Memory Bandwidth Allocation *=
/=0A=
+#define X86_FEATURE_BMEC		(11*32+18) /* AMD Bandwidth Monitoring Event Con=
figuration (BMEC) */=0A=
 =0A=
 /* Intel-defined CPU features, CPUID level 0x00000007:1 (EAX), word 12 */=
=0A=
 #define X86_FEATURE_AVX_VNNI		(12*32+ 4) /* AVX VNNI instructions */=0A=
diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattere=
d.c=0A=
index 885ecf46abb2..7981df0b910e 100644=0A=
--- a/arch/x86/kernel/cpu/scattered.c=0A=
+++ b/arch/x86/kernel/cpu/scattered.c=0A=
@@ -45,6 +45,7 @@ static const struct cpuid_bit cpuid_bits[] =3D {=0A=
 	{ X86_FEATURE_PROC_FEEDBACK,    CPUID_EDX, 11, 0x80000007, 0 },=0A=
 	{ X86_FEATURE_MBA,		CPUID_EBX,  6, 0x80000008, 0 },=0A=
 	{ X86_FEATURE_SMBA,             CPUID_EBX,  2, 0x80000020, 0 },=0A=
+	{ X86_FEATURE_BMEC,             CPUID_EBX,  3, 0x80000020, 0 },=0A=
 	{ X86_FEATURE_PERFMON_V2,	CPUID_EAX,  0, 0x80000022, 0 },=0A=
 	{ 0, 0, 0, 0, 0 }=0A=
 };=0A=
=0A=

