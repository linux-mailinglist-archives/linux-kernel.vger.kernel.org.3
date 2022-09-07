Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4119D5B0C14
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 20:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbiIGSDU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 14:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230382AbiIGSCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 14:02:32 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3294FC00D5;
        Wed,  7 Sep 2022 11:02:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KeWc6riwbtqrHjY1DoJfc71z6Nl28NfcfUc82+u5HiENI2696RAcf3hgHc+4mRClV9zwEDapfTs945s5WJ1Gi1D3vU9cSpattqubPcO0RfF4qYRhXADHPET0PfAiH8Ouj8VyexnKVS17Q/ljBVVldSAqUcdin29KWamEomMZi+3VYUg6USj16ogXK/9PRNzVNq4ZBZLWzN/yPrjfD2z+sJTnnsY38OVOGe33qOjcDEcbtN88EqsTGRMaPsa5N647PdOEBBRBFf3/bVYUg+/xnLzTfhOES15Mn5VxGVVIZlng/5ny14NjM7csP2dtFwZcgtPtp/cfrkCZ6sgkmPyMSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+42HLXAQ75w09396nl79xaZct+aO9JFUjd5nXBsqVnM=;
 b=DyT0Kgn0/UEK2XgqVke63SOgM0eurG3IkhFXSBBDCOFNhMJaW44OKkJ6T2XR6XfN2Irqkj+QeQlxvf6RLxTEI1HFX3Lxyu/lxRi7xkZ9TSKqmBoN6yyzBXl5X3LBZBseuZd2FIvXqFxeefzzPgaAO5UWIt9Ix2B9RdS8Edb9f3utHuUGmrMrfIh8UPclA8SZS30bJ8+ER3+mSwmFn4wXUWbOGqKAsE3q2nvwJm5dLiehkyKftajYZd7u9dkTdyDrRQYL1JSts1xyXseBeMzDMv5mZFk8T3/Aanpr+JOP4ydkPWJLOXiNpKYahb8u2GcpSMDmDaIbHNn6cGsx+b7bFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+42HLXAQ75w09396nl79xaZct+aO9JFUjd5nXBsqVnM=;
 b=VxxcVrzr636T83NeabeMAp9br7YYYvw1y1oTkKe9pAqAbRKX+CaCSAbonJrpoNE9BfswOhkqGjia73Y+QsMIa7fF0oujGwh2/QFEuL5SJ+HH7sMpmbUijT835SQyIcbhjVKWnifM+w7PtqHRtkKfCdE3FMGbC6Bt5kJb7T/5Vb4=
Received: from DM6PR06CA0082.namprd06.prod.outlook.com (2603:10b6:5:336::15)
 by BL1PR12MB5176.namprd12.prod.outlook.com (2603:10b6:208:311::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.12; Wed, 7 Sep
 2022 18:02:07 +0000
Received: from CY4PEPF0000B8EE.namprd05.prod.outlook.com
 (2603:10b6:5:336:cafe::2d) by DM6PR06CA0082.outlook.office365.com
 (2603:10b6:5:336::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12 via Frontend
 Transport; Wed, 7 Sep 2022 18:02:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000B8EE.mail.protection.outlook.com (10.167.241.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.9 via Frontend Transport; Wed, 7 Sep 2022 18:02:06 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 7 Sep
 2022 13:01:30 -0500
Subject: [PATCH v4 13/13] Documentation/x86: Update resctrl_ui.rst for new
 features
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
Date:   Wed, 7 Sep 2022 13:01:29 -0500
Message-ID: <166257368995.1043018.8665350782054895088.stgit@bmoger-ubuntu>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000B8EE:EE_|BL1PR12MB5176:EE_
X-MS-Office365-Filtering-Correlation-Id: addbbdd5-cef2-4e17-ff3d-08da90fb13ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /M3prpOG2DH9NPGAWuOCMFpI2JNjLWg/ogz6h5MEBj5DTqYxSyAiQdvuRSC0G5ad4kZGnqVhmUTLjU6pG4/L6SheFmgmq1LF+/3B5BJ3bgZDxIvdvsgPvQC8A1dtmxw2MrKZpUox+6d+U5RRv1YJib1aMRbtUV9hMyqfYIxSbxCS48hBAoCSScUnpuIBEHEn1Q66sFSEVDMgGAFJF/kBfoQzGA2k1A4WTyQNFcSX4WOG+2srZjlUvmCflNsa8reCXOnAfyknLL0RFHkuxWDR/tbrZPuLDtLtmJWAP4VMBZOvvhPM4phDTniWb4K56zuzaWl4rknQVpvFT+gdWw5UnuKUkygjYjIXH5256ZiIULavfxLVOh5+krzKdriuvsUvcL1a3WAnFk3dxV4zXmH7gDta+yWZkYFlj7VouwvYFQ7RWJUi8DFQ6nYUXbdNyYEBiRtozssp5PORBoihnqCLb5wV7T1PWnP9g4Ui/QnGB6P3VKm1vCB+txGh7JwFLK1YFJdGCDe8dM4lJ1z0kH//HrNyQFTYJ+x0LB8xK3AvfKwwEO9lZK4CO5+8aVOGC8dx0O8fEVAr4NigBmWWBOccda7hPy2RNIAERGwjODSm7RNSFXGalLZA8bi6s+7fftFHMxuVYMcZayBOBGG08Iq26UOUHrj9TkKJ5/vYgtwbDqkRaYegYULWHUTErBfbRMRu5ASfM73fO/UrGUVKrhZ4fHKXSEXniAKxzLSBIo9vBjbpDX8RfEa3ebL+GgzWzkfozJjZkfTLj6On4Do3BXi5vjDnejPMo4HBgBF44pK36c7HU2blUMjGrXv2vi/J8m+KwOKiPfkhcTA2aOIuaDvb3g==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(7916004)(4636009)(136003)(346002)(39860400002)(396003)(376002)(36840700001)(46966006)(40470700004)(36860700001)(33716001)(70206006)(70586007)(26005)(4326008)(8676002)(103116003)(83380400001)(41300700001)(54906003)(110136005)(316002)(16576012)(82310400005)(478600001)(426003)(16526019)(2906002)(40480700001)(82740400003)(47076005)(40460700003)(9686003)(8936002)(186003)(336012)(15650500001)(81166007)(86362001)(7416002)(5660300002)(44832011)(356005)(71626007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2022 18:02:06.3202
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: addbbdd5-cef2-4e17-ff3d-08da90fb13ca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000B8EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5176
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the documentation for the new features:=0A=
1. Slow Memory Bandwidth allocation (SMBA).=0A=
   With this feature, the QOS  enforcement policies can be applied=0A=
   to the external slow memory connected to the host. QOS enforcement=0A=
   is accomplished by assigning a Class Of Service (COS) to a processor=0A=
   and specifying allocations or limits for that COS for each resource=0A=
   to be allocated.=0A=
=0A=
2. Bandwidth Monitoring Event Configuration (BMEC).=0A=
   The bandwidth monitoring events mbm_total_bytes and mbm_local_bytes=0A=
   are set to count all the total and local reads/writes respectively.=0A=
   With the introduction of slow memory, the two counters are not=0A=
   enough to count all the different types are memory events. With the=0A=
   feature BMEC, the users have the option to configure mbm_total_bytes=0A=
   and mbm_local_bytes to count the specific type of events.=0A=
=0A=
Also add configuration instructions with examples.=0A=
=0A=
Signed-off-by: Babu Moger <babu.moger@amd.com>=0A=
---=0A=
 Documentation/x86/resctrl.rst |  148 +++++++++++++++++++++++++++++++++++++=
+++-=0A=
 1 file changed, 146 insertions(+), 2 deletions(-)=0A=
=0A=
diff --git a/Documentation/x86/resctrl.rst b/Documentation/x86/resctrl.rst=
=0A=
index 71a531061e4e..56581587c1a3 100644=0A=
--- a/Documentation/x86/resctrl.rst=0A=
+++ b/Documentation/x86/resctrl.rst=0A=
@@ -17,14 +17,16 @@ AMD refers to this feature as AMD Platform Quality of S=
ervice(AMD QoS).=0A=
 This feature is enabled by the CONFIG_X86_CPU_RESCTRL and the x86 /proc/cp=
uinfo=0A=
 flag bits:=0A=
 =0A=
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=0A=
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=0A=
 RDT (Resource Director Technology) Allocation	"rdt_a"=0A=
 CAT (Cache Allocation Technology)		"cat_l3", "cat_l2"=0A=
 CDP (Code and Data Prioritization)		"cdp_l3", "cdp_l2"=0A=
 CQM (Cache QoS Monitoring)			"cqm_llc", "cqm_occup_llc"=0A=
 MBM (Memory Bandwidth Monitoring)		"cqm_mbm_total", "cqm_mbm_local"=0A=
 MBA (Memory Bandwidth Allocation)		"mba"=0A=
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=0A=
+SMBA (Slow Memory Bandwidth Allocation)		"smba"=0A=
+BMEC (Bandwidth Monitoring Event Configuration) "bmec"=0A=
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=0A=
 =0A=
 To use the feature mount the file system::=0A=
 =0A=
@@ -161,6 +163,23 @@ with the following files:=0A=
 "mon_features":=0A=
 		Lists the monitoring events if=0A=
 		monitoring is enabled for the resource.=0A=
+                Example output:=0A=
+=0A=
+                # cat /sys/fs/resctrl/info/L3_MON/mon_features=0A=
+                llc_occupancy=0A=
+                mbm_total_bytes=0A=
+                mbm_local_bytes=0A=
+=0A=
+                If the system supports Bandwidth Monitoring Event=0A=
+                Configuration (BMEC), then the bandwidth events will=0A=
+                be configurable. Then the output will be.=0A=
+=0A=
+                # cat /sys/fs/resctrl/info/L3_MON/mon_features=0A=
+                llc_occupancy=0A=
+                mbm_total_bytes=0A=
+                mbm_total_config=0A=
+                mbm_local_bytes=0A=
+                mbm_local_config=0A=
 =0A=
 "max_threshold_occupancy":=0A=
 		Read/write file provides the largest value (in=0A=
@@ -264,6 +283,32 @@ When monitoring is enabled all MON groups will also co=
ntain:=0A=
 	the sum for all tasks in the CTRL_MON group and all tasks in=0A=
 	MON groups. Please see example section for more details on usage.=0A=
 =0A=
+"mbm_total_config", "mbm_local_config":=0A=
+        This contains the current event configuration for the events=0A=
+        mbm_total_bytes and mbm_local_bytes, respectively, when the=0A=
+        Bandwidth Monitoring Event Configuration (BMEC) feature is support=
ed.=0A=
+        These files are organized by L3 domains under the subdirectories=
=0A=
+        "mon_L3_00" and "mon_L3_01". When BMEC is supported, the events=0A=
+        mbm_local_bytes and mbm_total_bytes are configurable.=0A=
+=0A=
+        Following are the types of events supported:=0A=
+=0A=
+        =3D=3D=3D=3D    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
+        Bits    Description=0A=
+        =3D=3D=3D=3D    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
+        6       Dirty Victims from the QOS domain to all types of memory=
=0A=
+        5       Reads to slow memory in the non-local NUMA domain=0A=
+        4       Reads to slow memory in the local NUMA domain=0A=
+        3       Non-temporal writes to non-local NUMA domain=0A=
+        2       Non-temporal writes to local NUMA domain=0A=
+        1       Reads to memory in the non-local NUMA domain=0A=
+        0       Reads to memory in the local NUMA domain=0A=
+        =3D=3D=3D=3D    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
+=0A=
+        By default, the mbm_total_bytes configuration is set to 0x7F to co=
unt=0A=
+        all the event types and the mbm_local_bytes configuration is set t=
o=0A=
+        0x15 to count all the local memory events.=0A=
+=0A=
 Resource allocation rules=0A=
 -------------------------=0A=
 =0A=
@@ -464,6 +509,19 @@ Memory bandwidth domain is L3 cache.=0A=
 =0A=
 	MB:<cache_id0>=3Dbw_MBps0;<cache_id1>=3Dbw_MBps1;...=0A=
 =0A=
+Slow Memory bandwidth Allocation (when supported)=0A=
+-------------------------------------------------=0A=
+Currently, CXL.memory is the only supported "slow" memory device.=0A=
+With the support of SMBA feature the hardware enables bandwidth=0A=
+allocation on the slow memory devices. If there are multiple slow=0A=
+memory devices in the system, then the throttling logic groups all=0A=
+the slow sources together and applies the limit on them as a whole.=0A=
+=0A=
+Slow Memory b/w domain is L3 cache.=0A=
+::=0A=
+=0A=
+	SMBA:<cache_id0>=3Dbandwidth0;<cache_id1>=3Dbandwidth1;...=0A=
+=0A=
 Reading/writing the schemata file=0A=
 ---------------------------------=0A=
 Reading the schemata file will show the state of all resources=0A=
@@ -479,6 +537,44 @@ which you wish to change.  E.g.=0A=
   L3DATA:0=3Dfffff;1=3Dfffff;2=3D3c0;3=3Dfffff=0A=
   L3CODE:0=3Dfffff;1=3Dfffff;2=3Dfffff;3=3Dfffff=0A=
 =0A=
+Reading/writing the schemata file (on AMD systems)=0A=
+--------------------------------------------------=0A=
+Reading the schemata file will show the state of all resources=0A=
+on all domains. When writing the memory bandwidth allocation you=0A=
+only need to specify those values in an absolute number expressed=0A=
+in 1/8 GB/s increments. To allocate bandwidth limit of 2GB, you=0A=
+need to specify the value 16 (16 * 1/8 =3D 2).  E.g.=0A=
+::=0A=
+=0A=
+  # cat schemata=0A=
+    MB:0=3D2048;1=3D2048;2=3D2048;3=3D2048=0A=
+    L3:0=3Dffff;1=3Dffff;2=3Dffff;3=3Dffff=0A=
+=0A=
+  # echo "MB:1=3D16" > schemata=0A=
+  # cat schemata=0A=
+    MB:0=3D2048;1=3D  16;2=3D2048;3=3D2048=0A=
+    L3:0=3Dffff;1=3Dffff;2=3Dffff;3=3Dffff=0A=
+=0A=
+Reading/writing the schemata file (on AMD systems) with slow memory=0A=
+-------------------------------------------------------------------=0A=
+Reading the schemata file will show the state of all resources=0A=
+on all domains. When writing the memory bandwidth allocation you=0A=
+only need to specify those values in an absolute number expressed=0A=
+in 1/8 GB/s increments. To allocate bandwidth limit of 8GB, you=0A=
+need to specify the value 64 (64 * 1/8 =3D 8).  E.g.=0A=
+::=0A=
+=0A=
+  # cat schemata=0A=
+    SMBA:0=3D2048;1=3D2048;2=3D2048;3=3D2048=0A=
+      MB:0=3D2048;1=3D2048;2=3D2048;3=3D2048=0A=
+      L3:0=3Dffff;1=3Dffff;2=3Dffff;3=3Dffff=0A=
+=0A=
+  # echo "SMBA:1=3D64" > schemata=0A=
+  # cat schemata=0A=
+    SMBA:0=3D2048;1=3D  64;2=3D2048;3=3D2048=0A=
+      MB:0=3D2048;1=3D2048;2=3D2048;3=3D2048=0A=
+      L3:0=3Dffff;1=3Dffff;2=3Dffff;3=3Dffff=0A=
+=0A=
 Cache Pseudo-Locking=0A=
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
 CAT enables a user to specify the amount of cache space that an=0A=
@@ -1210,6 +1306,54 @@ View the llc occupancy snapshot::=0A=
   # cat /sys/fs/resctrl/p1/mon_data/mon_L3_00/llc_occupancy=0A=
   11234000=0A=
 =0A=
+Example 5 (Configure and Monitor specific event types)=0A=
+------------------------------------------------------=0A=
+=0A=
+A single socket system which has real time tasks running on cores 0-4=0A=
+and non real time tasks on other CPUs. We want to monitor the memory=0A=
+bandwidth allocation for specific events.=0A=
+::=0A=
+=0A=
+  # mount -t resctrl resctrl /sys/fs/resctrl=0A=
+  # cd /sys/fs/resctrl=0A=
+  # mkdir p1=0A=
+=0A=
+Move the CPUs 0-4 over to p1::=0A=
+=0A=
+  # echo 0xf > p1/cpus=0A=
+=0A=
+View the current mbm_local_bytes::=0A=
+=0A=
+  # cat /sys/fs/resctrl/p1/mon_data/mon_L3_00/mbm_local_bytes=0A=
+  112501=0A=
+=0A=
+Change the mbm_local_bytes to count mon-temporal writes to both local=0A=
+and non-local NUMA domain. Refer to event supported bitmap under=0A=
+mbm_local_config::=0A=
+=0A=
+  # echo 0xc > /sys/fs/resctrl/p1/mon_data/mon_L3_00/mbm_local_config=0A=
+=0A=
+View the updated mbm_local_bytes::=0A=
+=0A=
+  # cat /sys/fs/resctrl/p1/mon_data/mon_L3_00/mbm_local_bytes=0A=
+  12601=0A=
+=0A=
+Similar experiment on mbm_total_bytes. First view the current mbm_total_by=
tes::=0A=
+=0A=
+  # cat /sys/fs/resctrl/p1/mon_data/mon_L3_00/mbm_total_bytes=0A=
+  1532501=0A=
+=0A=
+Change the mbm_total_bytes to count only reads to slow memory on both loca=
l=0A=
+and non-local NUMA domain. Refer to event supported bitmap under=0A=
+mbm_total_config::=0A=
+=0A=
+  # echo 0x30 > /sys/fs/resctrl/p1/mon_data/mon_L3_00/mbm_total_config=0A=
+=0A=
+View the updated mbm_total_bytes::=0A=
+=0A=
+  # cat /sys/fs/resctrl/p1/mon_data/mon_L3_00/mbm_total_bytes=0A=
+  104562=0A=
+=0A=
 Intel RDT Errata=0A=
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
 =0A=
=0A=

