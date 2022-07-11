Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26D95570CE2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 23:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231769AbiGKVkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 17:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232136AbiGKVjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 17:39:48 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2086.outbound.protection.outlook.com [40.107.94.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F06823A5;
        Mon, 11 Jul 2022 14:39:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XG6q6NhlFlJCB2MXyab53/ZJJwXONr73bWpqDZqh87S1Mph+d5CDRBzfYoUAZlER7ukDccCh0qRGwSezulfLXTp9aVnrTew6faTMtuy0GgKxOTX/C/p9S/6Wg4QTMEklyOcIR4GxWH/nFc85MN2Cti5VJuhqPbcicXm3xu+bJkjDdfJWbmc0OG8FxLAKuechVTuI1mUyeVR8Lz82qmWuq3heiErBl1zwvCZ+RzYaRiwFWetH+2RyCTG5NMY8IxM72eZsnYfXO0KVrAeQTdA6zsbNXKf4WZUgwDNU+mfBzupwd0XgWcuSLrpADSCSGznbfBy7/W92aNo1jqybgEhR2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vzV/5UKOEXQ1aWkvy3MLfQYcwg/lS7eP/U+HnXFQCOY=;
 b=lgQa11DEz2cKnYUJ0my07ferX2VQ6+2bdCoUFMgiH6pwrBsCWyLVHMykiUJ1yhovfCuwfPGVzYzhQVCqDzyxaEa4U68S0w6OOwiul+taoxTlyYdzlrUp+ma6Trs/qkVLIiYdBgnKLnkwtl0qCuOc7X21lXqoEjCSn/0IJrWtGWSSGsIcRXqdrIwZEtZQ5x5B2zjeaX1l0Rp7sFjPb8dwWrOBSmnE97ADG+45MGv3WPWMsK3aTSxAVp1Aj9nTcJAjGsKBPkfu7JNwc8S3Zp8mPDoX/OBcRBJ4ZBiaPq07eEw4hMIGZ6+3v6EIXhbcumERz3JRWjKaAIyk7inOrxqELA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vzV/5UKOEXQ1aWkvy3MLfQYcwg/lS7eP/U+HnXFQCOY=;
 b=GDBtPNAPQGn6Z1vfXwOll0JW84D6ISkxRapBYLhc+GfV6uxEx/efyJxyIAYf4Ol5OCBqNu7YRRLiHeOxrIMTn6SX1egAyIlBLuZaMh19Ic996rVJu+YMcetM0vnZqn8s7nctHY8+8r9ZenEFQpZgu3NA48q9olHnTt/cLk5Yj0E=
Received: from BN0PR04CA0164.namprd04.prod.outlook.com (2603:10b6:408:eb::19)
 by BYAPR12MB2616.namprd12.prod.outlook.com (2603:10b6:a03:66::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Mon, 11 Jul
 2022 21:39:43 +0000
Received: from BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:eb:cafe::93) by BN0PR04CA0164.outlook.office365.com
 (2603:10b6:408:eb::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.22 via Frontend
 Transport; Mon, 11 Jul 2022 21:39:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT068.mail.protection.outlook.com (10.13.177.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Mon, 11 Jul 2022 21:39:43 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 11 Jul
 2022 16:39:41 -0500
Subject: [PATCH 9/9] Documentation/x86: Update resctrl_ui.rst for new features
From:   Babu Moger <babu.moger@amd.com>
To:     <fenghua.yu@intel.com>, <reinette.chatre@intel.com>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>
CC:     <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <corbet@lwn.net>, <hpa@zytor.com>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>
Date:   Mon, 11 Jul 2022 16:39:41 -0500
Message-ID: <165757558140.416408.6012140649170583649.stgit@bmoger-ubuntu>
In-Reply-To: <165757543252.416408.13547339307237713464.stgit@bmoger-ubuntu>
References: <165757543252.416408.13547339307237713464.stgit@bmoger-ubuntu>
User-Agent: StGit/1.1.dev103+g5369f4c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cbf3cc2b-891d-4d93-2737-08da6385dde7
X-MS-TrafficTypeDiagnostic: BYAPR12MB2616:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: otH3uJb993JgGwDaWOoVefR33t6E5hX/w94E2EgfWGJQLuiE0B7XFRZkWVC5TEacPVlrCHuhsAjTV6+hzA3nyD1/Z4F5th+pQnYvj5jkBtxbRdTJyFtameFBfY5uf4btFCAzvEUR7uyvHl1F/9JeOzgLcySk1Ie6kDcuQcWMGX/e4JipCiT9xf61rT0qeP/xIKjfe5ZX+PZD05YmTlxd/rh/OEgOwHB0aCNZLC1J2S0qmH9OnmsVSGatDMy/Tm+bYat110HigAgsGodCXZ7WKYOq8AgB4sag3QNhAFOJDo5uibnMpU7GrE0lMxXRFn5sxlKlm7xITM/qztRxpdFIYiTAZL8odbCS+LbT9d1B/T5z/YDKYLHgrJtXWuru1iWQK7gnGooDhNuDzHMmSMq7LP27dh/1kZNYbiRyDCgN6i/slvx9MRQcYYsV+2okppMF1CJphKmPd7wq8Jx7kjDLPa1oHZODPhe9QorvqGJAlR1y8PV4fIEcXzw4r8Q4Cb5eAekWkF6zTJ9Kb+8nmwqGzkkNx8HLbfROliETpE+4WsAUUWiJf8IUuCmnozQx+T+pSc4yBk7g6xB6mbJowAPK4y9bokbfRArQ1kAn+kjOiYzotGHXwDfxAuxS6J1DgVdZOb4LkxGXdYoTMAtw7x0gC24B2IPaGX+wGUlOnFAyxnTy8ipBkDAjSryeCXXlmtY4r+15i+5IAhhXq7pfSjGQIgTBVRKJhxqyMbJeAG6Rn+NE7INyKkin0SkdnbbURFlq86wWWWMqLt23XILRahQ5Jaqo3jMsoo3/ZiWA3bz5oNY8NuJL879fUxGTQRBVChbqsAJt+JP7TJxyzgm4CdQweARcWddNp4rgDb+VjwOUU4E1iSRGD4ZjKjOCBdaGfUlr
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(7916004)(396003)(136003)(346002)(376002)(39860400002)(40470700004)(46966006)(36840700001)(110136005)(44832011)(2906002)(478600001)(81166007)(54906003)(36860700001)(316002)(7416002)(16576012)(186003)(103116003)(15650500001)(82740400003)(356005)(5660300002)(336012)(40460700003)(86362001)(16526019)(8936002)(9686003)(426003)(41300700001)(47076005)(82310400005)(40480700001)(83380400001)(70586007)(70206006)(8676002)(4326008)(33716001)(26005)(71626007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2022 21:39:43.0435
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cbf3cc2b-891d-4d93-2737-08da6385dde7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2616
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
1. Slow Memory Bandwidth allocation.=0A=
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
Added the instructions to configure with examples.=0A=
=0A=
Signed-off-by: Babu Moger <babu.moger@amd.com>=0A=
---=0A=
 Documentation/x86/resctrl.rst |  123 +++++++++++++++++++++++++++++++++++++=
++++=0A=
 1 file changed, 123 insertions(+)=0A=
=0A=
diff --git a/Documentation/x86/resctrl.rst b/Documentation/x86/resctrl.rst=
=0A=
index 71a531061e4e..bae36a4d1b2b 100644=0A=
--- a/Documentation/x86/resctrl.rst=0A=
+++ b/Documentation/x86/resctrl.rst=0A=
@@ -167,6 +167,12 @@ with the following files:=0A=
 		bytes) at which a previously used LLC_occupancy=0A=
 		counter can be considered for re-use.=0A=
 =0A=
+"mon_configurable":=0A=
+                Provides the information if the events mbm_total and=0A=
+                mbm_local are configurable. See the configuration=0A=
+                details for "mbm_total_config" and "mbm_local_config"=0A=
+                for more information.=0A=
+=0A=
 Finally, in the top level of the "info" directory there is a file=0A=
 named "last_cmd_status". This is reset with every "command" issued=0A=
 via the file system (making new directories or writing to any of the=0A=
@@ -264,6 +270,29 @@ When monitoring is enabled all MON groups will also co=
ntain:=0A=
 	the sum for all tasks in the CTRL_MON group and all tasks in=0A=
 	MON groups. Please see example section for more details on usage.=0A=
 =0A=
+"mbm_total_config":=0A=
+"mbm_local_config":=0A=
+        This contains the current event configuration for the events=0A=
+        mbm_total_bytes and mbm_local_bytes, respectively, when the=0A=
+        Bandwidth Monitoring Event Configuration (BMEC) feature is support=
ed.=0A=
+        These files are organized by L3 domains under the subdirectories=
=0A=
+        "mon_L3_00" and "mon_L3_01". When BMEC is supported, the events=0A=
+        mbm_local_bytes and mbm_total_bytes are configurable.=0A=
+=0A=
+        Following are the types of events supported.=0A=
+        Bits    Description=0A=
+        6       Dirty Victims from the QOS domain to all types of memory=
=0A=
+        5       Reads to slow memory in the non-local NUMA domain=0A=
+        4       Reads to slow memory in the local NUMA domain=0A=
+        3       Non-temporal writes to non-local NUMA domain=0A=
+        2       Non-temporal writes to local NUMA domain=0A=
+        1       Reads to memory in the non-local NUMA domain=0A=
+        0       Reads to memory in the local NUMA domain=0A=
+=0A=
+        By default, the mbm_total_bytes configuration is set to 0x7f to co=
unt=0A=
+        all the event types and the mbm_local_bytes configuration is set t=
o=0A=
+        0x15 to count all the local memory events.=0A=
+=0A=
 Resource allocation rules=0A=
 -------------------------=0A=
 =0A=
@@ -464,6 +493,14 @@ Memory bandwidth domain is L3 cache.=0A=
 =0A=
 	MB:<cache_id0>=3Dbw_MBps0;<cache_id1>=3Dbw_MBps1;...=0A=
 =0A=
+Slow Memory bandwidth Allocation (when supported)=0A=
+------------------------------------------=0A=
+=0A=
+Slow Memory b/w domain is L3 cache.=0A=
+::=0A=
+=0A=
+	SB:<cache_id0>=3Dbandwidth0;<cache_id1>=3Dbandwidth1;...=0A=
+=0A=
 Reading/writing the schemata file=0A=
 ---------------------------------=0A=
 Reading the schemata file will show the state of all resources=0A=
@@ -479,6 +516,44 @@ which you wish to change.  E.g.=0A=
   L3DATA:0=3Dfffff;1=3Dfffff;2=3D3c0;3=3Dfffff=0A=
   L3CODE:0=3Dfffff;1=3Dfffff;2=3Dfffff;3=3Dfffff=0A=
 =0A=
+Reading/writing the schemata file (on AMD systems)=0A=
+---------------------------------------------------------------=0A=
+Reading the schemata file will show the state of all resources=0A=
+on all domains. When writing the memory bandwidth allocation, the=0A=
+user only need to specify those values in an absolute number=0A=
+expressed in 1/8 GB/s increments. To allocate bandwidth limit of=0A=
+2GB, the user need to specify the value 16 (16 * 1/8 =3D 2).  E.g.=0A=
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
+---------------------------------------------------------------=0A=
+Reading the schemata file will show the state of all resources=0A=
+on all domains. When writing the memory bandwidth allocation you=0A=
+only need to specify those values in an absolute number expressed=0A=
+in 1/8 GB/s increments. To allocate bandwidth limit of 8GB, you=0A=
+need to specify the value 64 (64 * 1/8 =3D 8).  E.g.=0A=
+::=0A=
+=0A=
+  # cat schemata=0A=
+    SB:0=3D2048;1=3D2048;2=3D2048;3=3D2048=0A=
+    MB:0=3D2048;1=3D2048;2=3D2048;3=3D2048=0A=
+    L3:0=3Dffff;1=3Dffff;2=3Dffff;3=3Dffff=0A=
+=0A=
+  # echo "SB:1=3D64" > schemata=0A=
+  # cat schemata=0A=
+    SB:0=3D2048;1=3D  64;2=3D2048;3=3D2048=0A=
+    MB:0=3D2048;1=3D2048;2=3D2048;3=3D2048=0A=
+    L3:0=3Dffff;1=3Dffff;2=3Dffff;3=3Dffff=0A=
+=0A=
 Cache Pseudo-Locking=0A=
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
 CAT enables a user to specify the amount of cache space that an=0A=
@@ -1210,6 +1285,54 @@ View the llc occupancy snapshot::=0A=
   # cat /sys/fs/resctrl/p1/mon_data/mon_L3_00/llc_occupancy=0A=
   11234000=0A=
 =0A=
+Example 5 (Configure and Monitor specific event types)=0A=
+-------------------------------------------------=0A=
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

