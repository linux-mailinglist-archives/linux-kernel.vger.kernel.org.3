Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5E0F5B0BFC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 20:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbiIGSBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 14:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbiIGSAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 14:00:50 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2088.outbound.protection.outlook.com [40.107.212.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E87E2BC824;
        Wed,  7 Sep 2022 11:00:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dHBfCSNToG3tUEEVFuQSitybnhTOjh4cSL9kf9tAIC54z9zXC0XcBBbcD+iPwUdxodyNWQeEXRq3JMthstSOhw499cPbPxtawMQBci1u8kXWLj/YuIBJVVLi2VPClc6N8GRVR/UpcwyeAquirknXpRnkSAW7CVK8Rdwu9xVezx27Vt9RxcPrubuLjUbjLf2QKCjueB5SLlOJZ3FBkEXsj7ZPl7vhq1mgZlaQ0r8Jm4QJcyqEWOtaa8LyY2wr3/l6HKYy+DmZXWGc/sPh0atMmzF2aEaZVZkPSt5xIbqeC5IeLo4uCU4TmT9rjhBQwLzWuWXgtXM+OmWUeNBkS5ij7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mISyJIbLLegDHXVjwe3QTTiLNTRpN+hYyJ98M6PkeSw=;
 b=VckjX2lxYbUC5YzWfubHe8ioT2MBOZW52meLnVdRhUW84aruqHRvEM29Dz5qHG4kDgyz3gFHLYb7mdwMTLOOqDkuBcpoDO7yN2SqDLq3k16tZtUBNfucNLsDF6zwR1GdLRCGnO9vtE/v0gJON0np4sbYQaEbRp8WjhRq2h7sKjUbAm7Ckq/LOBSyB9Nyuf5KqPYG8ZwILSktGSIIQvPBYSNrzE1JeEapoE2rDXA493kzhXTN9qKdX2cuUkIsd5a9sRmU2XKOccQbSDm9qHSI+P/EhRurzyzpbM8MP+q5xGNusI2SUbOW/GDLt4hHMx/5tVX6KAg+VFnPfDJwg+AEHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mISyJIbLLegDHXVjwe3QTTiLNTRpN+hYyJ98M6PkeSw=;
 b=IX9MfXmJ/2gvDXOAJ6h/PGGSOUHSMfdA8bK9MlLMJrJLdl/yPVb+vbCAvHWo3wonCofcwEoJQ6M6leuvkSfsUvfjJEA6Jl6Iio3//oZf6vMbUo022sdhf7Q5MKScehx0hDdZ44d+wvmdyRfY1Kf2LIoMB07H4X1+WzbvgDpmLpo=
Received: from BN0PR08CA0029.namprd08.prod.outlook.com (2603:10b6:408:142::15)
 by MN0PR12MB6293.namprd12.prod.outlook.com (2603:10b6:208:3c2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12; Wed, 7 Sep
 2022 18:00:43 +0000
Received: from BN8NAM11FT099.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:142:cafe::60) by BN0PR08CA0029.outlook.office365.com
 (2603:10b6:408:142::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14 via Frontend
 Transport; Wed, 7 Sep 2022 18:00:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT099.mail.protection.outlook.com (10.13.177.197) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Wed, 7 Sep 2022 18:00:43 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 7 Sep
 2022 13:00:41 -0500
Subject: [PATCH v4 06/13] x86/resctrl: Include new features in command line
 options
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
Date:   Wed, 7 Sep 2022 13:00:41 -0500
Message-ID: <166257364128.1043018.12636485490608845145.stgit@bmoger-ubuntu>
In-Reply-To: <166257348081.1043018.11227924488792315932.stgit@bmoger-ubuntu>
References: <166257348081.1043018.11227924488792315932.stgit@bmoger-ubuntu>
User-Agent: StGit/1.1.dev103+g5369f4c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT099:EE_|MN0PR12MB6293:EE_
X-MS-Office365-Filtering-Correlation-Id: ffaee25c-60fe-4199-56b1-08da90fae23b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nE4uISu+S6M1mibd7SlZUkjTWPTlfZTyaNnjI2w7RxlaXOXnSufNaSnhR1NREHgTCPa8RT9USBJME+vFb4zrNrzNDAXzNdSRZiuCHiwXVJjgpe0yvHGz3szPLIRHgkH23x5gicxHkllSW16DuSVdHwwbAx3M1VfeCWFmpeCOjRUm7M1Tjnn0tQkodMEmdlRyCo6n6oe6ptc6QAmcXGzmUfWexfamUdo3rQek+15cLxINhn+OPeR6rSKQtS2ePB40LFQfEfZivFmWHYfA97ZYkHlSIk3Xmr7KAet4lfoytZVje9yMn+MLZWt8x/uSN4ulJ4Q4Y6tDHmQZNxVYECvKivtIFS17x/Kj+IUcRll5Dy8+a1es2GKh4ECJAjQzm3HOmLDc3V/MJoVgjj2kqsQUW9vamZzQ1alYxjwUoCiZu3lEjuhIXh+YJ4vS5OVl6X/OYn5rI/bsD+3p7/CtNj9QQrUMaQJ627dyUzCPOFbyJS00E4hS029sktC9dXhw4xUomCb9ovWNmgpeCNeGpKkFGJVpreEyn0Hm4kOUYKVWrjmWiUQsW5RTWTPsAoT7IIDjMspNB49w1M7EWg8MixWsLq19DoNAWvjdsuRIlFNHa5SvrORcfAq1jyAcyjIx36DoPpj/JtLHhStTzVedIVXt+W0T2olUDM7aqcKuMmjZMSVAjDnoYF3Azvq7/o55k+CAgHbTjzZwWynbk6vKKq/0CwpXdbyTXkLyI0xtFgBGXpRPKsmNKmzYiUDS/XfqkOl0HLcX1TVt8fL0jO2t26k6VomCI29LyR5bYjJC90ZH4FqkcAD1sbF2Yz4oULYyWNJP9TOojvxsrcFaO+v9M3rbGw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(7916004)(39860400002)(396003)(376002)(346002)(136003)(36840700001)(40470700004)(46966006)(8676002)(478600001)(103116003)(4326008)(70586007)(70206006)(83380400001)(44832011)(336012)(2906002)(5660300002)(40460700003)(26005)(9686003)(426003)(8936002)(186003)(86362001)(47076005)(16526019)(7416002)(41300700001)(82310400005)(16576012)(33716001)(81166007)(316002)(82740400003)(40480700001)(54906003)(110136005)(36860700001)(356005)(71626007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2022 18:00:43.7484
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ffaee25c-60fe-4199-56b1-08da90fae23b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT099.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6293
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the command line options to disable the new features.=0A=
smba : Slow Memory Bandwidth Allocation=0A=
mbec : Bandwidth Monitor Event Configuration.=0A=
=0A=
Signed-off-by: Babu Moger <babu.moger@amd.com>=0A=
---=0A=
 Documentation/admin-guide/kernel-parameters.txt |    2 +-=0A=
 arch/x86/kernel/cpu/resctrl/core.c              |    4 ++++=0A=
 2 files changed, 5 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentatio=
n/admin-guide/kernel-parameters.txt=0A=
index d7f30902fda0..c109fecb93ea 100644=0A=
--- a/Documentation/admin-guide/kernel-parameters.txt=0A=
+++ b/Documentation/admin-guide/kernel-parameters.txt=0A=
@@ -5169,7 +5169,7 @@=0A=
 	rdt=3D		[HW,X86,RDT]=0A=
 			Turn on/off individual RDT features. List is:=0A=
 			cmt, mbmtotal, mbmlocal, l3cat, l3cdp, l2cat, l2cdp,=0A=
-			mba.=0A=
+			mba, smba, bmec.=0A=
 			E.g. to turn on cmt and turn off mba use:=0A=
 				rdt=3Dcmt,!mba=0A=
 =0A=
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resct=
rl/core.c=0A=
index a7e9aabff8c8..53fbc3acad81 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/core.c=0A=
+++ b/arch/x86/kernel/cpu/resctrl/core.c=0A=
@@ -700,6 +700,8 @@ enum {=0A=
 	RDT_FLAG_L2_CAT,=0A=
 	RDT_FLAG_L2_CDP,=0A=
 	RDT_FLAG_MBA,=0A=
+	RDT_FLAG_SMBA,=0A=
+	RDT_FLAG_BMEC,=0A=
 };=0A=
 =0A=
 #define RDT_OPT(idx, n, f)	\=0A=
@@ -723,6 +725,8 @@ static struct rdt_options rdt_options[]  __initdata =3D=
 {=0A=
 	RDT_OPT(RDT_FLAG_L2_CAT,    "l2cat",	X86_FEATURE_CAT_L2),=0A=
 	RDT_OPT(RDT_FLAG_L2_CDP,    "l2cdp",	X86_FEATURE_CDP_L2),=0A=
 	RDT_OPT(RDT_FLAG_MBA,	    "mba",	X86_FEATURE_MBA),=0A=
+	RDT_OPT(RDT_FLAG_SMBA,	    "smba",	X86_FEATURE_SMBA),=0A=
+	RDT_OPT(RDT_FLAG_BMEC,	    "bmec",	X86_FEATURE_BMEC),=0A=
 };=0A=
 #define NUM_RDT_OPTIONS ARRAY_SIZE(rdt_options)=0A=
 =0A=
=0A=

