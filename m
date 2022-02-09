Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8904AE6F8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 03:42:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244105AbiBICju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 21:39:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243065AbiBIBaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 20:30:04 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2137.outbound.protection.outlook.com [40.107.244.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1DDAC061576;
        Tue,  8 Feb 2022 17:30:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G8iV+mGN4dr+zdWnlvBDxJks55XQp+X8lWmaZYrqWJhtL5QU3ykLRURCr8PtNRdenj71V068sGlO9ufiqP567WrEVWllMYEtUF5zdS194UrrZZ9rNalzlWP3h/fgo7ESGpZceL7ksPoC+LzBz/RCESpxQw0KcrGKqrAbakVZilg0DFkBXmllFmXo3EcnoHVW8yP7XnT23S+Lz+SyHG7lN0LUaWhnOrvpqKm+GiKmVXH6mjA8h8cpfBOLERSzlBYbXq0h7uVz2D0hSyUHhCEpqdAPtBepuf0mj+azIOBWrGzqhYXMtUOVqEQNqXMOSgMykJkfoMeFeZzYlVgu6pfBAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+S2PwYrRuMaXTiJUB3yBLpeZXUg6x+SPbLQ/32kiiiQ=;
 b=RMPSi/BayQ8tnB8LBF8dkg5yZoYef6Osud9ovndwg/0fEM0pCe13YsyW4ULjGE0kKpUX6E8Zb+YqJYJ6AFmcS51YHUadbIMIm5m+Vm/F/uakV2GxHT6qmsGOZEIpLGarCt6R4Ri7bpXLcP1LnqNgVgut7CC1fjyuInogydFbdevISGZQ7r4LomZYrNlUrrUCPV/tYR0fjIdxzJuKpmPhm5qnumuU0AEUfKONgu+K+CTB5mmF79i3HUxqLLiFWVLqS8eZOHHmE9bIwMmDgZ8sndvBUNP0U7CffPWdgl/WemSSMDulIpZjtPbxJrF+gS5W8BHghY/+CS1GX6Oaoh6p9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+S2PwYrRuMaXTiJUB3yBLpeZXUg6x+SPbLQ/32kiiiQ=;
 b=ItbC0sg6ZitqflY+voAUM5QcZixschMFOAqpyD14YpTwQzz+UVt+3Z4z+UrRKZupqLceDEQRT2onkUzuUjSI8fdAqZ1b+r61klqobUfOBzZ6NPNi2z2H0xOaS/3VHEPSORn0EFdfoO2kPWfR3NehaZStLIs1hHcQ/9mFHhEtXOE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM8PR01MB6824.prod.exchangelabs.com (2603:10b6:8:23::24) by
 CO1PR01MB7355.prod.exchangelabs.com (2603:10b6:303:15a::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4975.11; Wed, 9 Feb 2022 01:29:56 +0000
Received: from DM8PR01MB6824.prod.exchangelabs.com
 ([fe80::bd40:379f:5b93:f800]) by DM8PR01MB6824.prod.exchangelabs.com
 ([fe80::bd40:379f:5b93:f800%6]) with mapi id 15.20.4951.019; Wed, 9 Feb 2022
 01:29:56 +0000
From:   Huang Shijie <shijie@os.amperecomputing.com>
To:     catalin.marinas@arm.com
Cc:     will@kernel.org, bhe@redhat.com, vgoyal@redhat.com,
        dyoung@redhat.com, corbet@lwn.net, kexec@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, zwang@amperecomputing.com,
        patches@amperecomputing.com, darren@os.amperecomputing.com,
        Huang Shijie <shijie@os.amperecomputing.com>
Subject: [PATCH] arm64: crash_core: Export MODULES, VMALLOC, and VMEMMAP ranges
Date:   Wed,  9 Feb 2022 09:26:42 +0000
Message-Id: <20220209092642.9181-1-shijie@os.amperecomputing.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR04CA0014.namprd04.prod.outlook.com
 (2603:10b6:610:52::24) To DM8PR01MB6824.prod.exchangelabs.com
 (2603:10b6:8:23::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a13b40ca-effa-400f-ddab-08d9eb6bad80
X-MS-TrafficTypeDiagnostic: CO1PR01MB7355:EE_
X-Microsoft-Antispam-PRVS: <CO1PR01MB73551D054A5C0494FF8E5E3FED2E9@CO1PR01MB7355.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 28MMteceLBr/2enHFhII2g/VMQZ/K2SjKomDJKd4UtReAZa05PmrP6dpX5T7SuQHB4IGcIAPwRNaj2VrK5sSPFZfzqJwJDUCHbrT9QKDR1Ah/Ysw5/kfZHKW0EADZaYfl2NqBEU+CAXQvytPCty692DlWWKQvtBXSykOkeqvyGeXK6iuO0DuxSUlpzoslsOzF8qtY6ldU/iBUVjLv3UqBzRVR15jERu3wv4ijNioGmcIXtgtAqCLt6YuLwyv94RAMUEtjlmHgzALeg8Wmj2Vo/PacmaiHEBYMoHrSHQMjiN7XX/VZr4Z8v2BXaa0QmN2WXWMONBTQvjDGJoA4lNhaQbjaCUe3jzPjW7ZGYJq+zSLLFbzHZe7BjAXeKZClV042vH6SHneHtoHsdd7OFIV/++rSA3ekZJ85wS3O74l48MA7OPkaLanE2rtZzp9wiyRms5Z/++BNmih6LU2K8vRaz84y9riStN/V7LLAuDOwEijVopsCicHyvlvAh/gkWzGfjR0uB9GwMQelUywzXwOjwPhqdHVfKBpfz1tSdMKNxdSL3EQAdxOZ8pS48ZvSqLymFcyMzM7GpinE/9Vy5WnY0IdmCpxRYQQU7dS2JNrsJRpkdUUP0rbuXiyFX23UQp8JoUfqmPjU/Vi4wnSChgtXRx9bHw+R3fnVtp28GzNARK5wRsanMRI9EIReNNVcPhXRgHrFSaH9XFGKsj5nMz9sg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR01MB6824.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(7416002)(38350700002)(38100700002)(107886003)(86362001)(5660300002)(2906002)(6506007)(66556008)(6486002)(26005)(186003)(1076003)(2616005)(8676002)(4326008)(6916009)(83380400001)(8936002)(66946007)(66476007)(52116002)(6512007)(6666004)(508600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?n/TsRYOfT3VPvL3gXd5ggIgh1gfUW9rBIE2afRdHSpj+zz49HcR41wE11m4p?=
 =?us-ascii?Q?2cWEehe779AH29hA2pO8l0ZfOY45vOeCBsrTWH55Oy2mb9ouENUYGYsYCZqu?=
 =?us-ascii?Q?v7Rp3LQAIKuRhQcpKR6peGPVv0JJ7RLl1soyiyhBnsnHCE4+mA/8thKjBztB?=
 =?us-ascii?Q?AUP+kQtUAHG3uNaUh4oniP8rPG9OLoudEqa4t4AMud6EgnsrG6RQuvfDYPR2?=
 =?us-ascii?Q?r29AGV9mYSIcfuVUB+vy2lsHkuAbLiIS25FFWJmY2YXpIkg/SNROiuyo2M+d?=
 =?us-ascii?Q?x/dbzjT9nTFTYmnT0DEaj5og51xr1xpGZkFy6yJ6b39eocYP8+YLKmzqmcrk?=
 =?us-ascii?Q?oN4b1v117V6o+Prce7Sb27UaJT8Ue5+FBqq0xCstB+DHyAdVoahqrXrSGQu7?=
 =?us-ascii?Q?ba68xG2IKY8L0q+lYxtZ1890+zIacfQn8dwj2w8/1bsAkSvjyTyL2Qk+O1mI?=
 =?us-ascii?Q?G62qdfkG9FoBCtdb44hg53UKZk6srDZ914WbrmrG+GBLEMrE+cpGgV2I4Dmb?=
 =?us-ascii?Q?SLO2w99Ir+uQTj25VN/uMmEhSgJZtOZrfIyFRTs5o+ai26Po72ChyKII3fmN?=
 =?us-ascii?Q?8Ke7FiY2IiqPhjEfttsgvrNjy97ngrl9NVSghouJUUFQBaLXPPMkok2nOzbE?=
 =?us-ascii?Q?Tal1BGdbrHliNPoZkPX8dL8mp4QdGqfMYpkH55pXJOVRlDFH9Gqx6i9wacGO?=
 =?us-ascii?Q?VgigAJ4SlAGn2dQ0KAyMbB/Tufzaddqu6TNUHO9LT0FPYOJUyQNdxsacTgzy?=
 =?us-ascii?Q?f2MPq3qc3k11bp8kQhoOFlcBbkOcaW5kXCDFnL1AgwPfETpbizEJXeULFKIR?=
 =?us-ascii?Q?be981dDlgEs6nqvvAMoH4dxzZow/BeceXk+R0UFkxuTK8f9otlr2BS4EzJoi?=
 =?us-ascii?Q?tFReVEPgImej8KBZkhiX7PtXZcV4doHWqbKqjsRM3j+Bh6viZ87dcKGpRsGi?=
 =?us-ascii?Q?hESLC02biLnl/4wNwaDVNJR0bNkcuVl0adkl1dFPYFyICNaw1peb9JC7KUDv?=
 =?us-ascii?Q?LeXKlWTDIqKsRlVM2xBMR/O97Bg2C2GP1aV2boL1IfCUCMdh56OgAVXnes8T?=
 =?us-ascii?Q?lE/o97eQzP6F5E3DFx8lcESWzk/Jqcxu18eL8hA7O5w6gRFT7CTRa67JFaIq?=
 =?us-ascii?Q?QLgx7BsaN0ocul7OGtkFqC9jPQmuOxEQFuxCn6Uio6Qrme5eqxsSy4M7Td/U?=
 =?us-ascii?Q?D7lc/kFfFjsy/Rn2SMDWCBu1KvZ4ERQSfWgyyAkXGQO6YBNEYZGADjJT/FNz?=
 =?us-ascii?Q?smAwaE/ZZfGIy6XKXNvVhesnPFYuUh5S75IxG2aKQS75r0qLx17ybzDfd2VB?=
 =?us-ascii?Q?wLthVg/iihdeb8e7+oskbmfUrVVsNddDhecIb6h4isPwbFr8Dt7m2ZII6vAa?=
 =?us-ascii?Q?Bd9BJ3Y25o6H+bKWjKtsNEYZtzGb1gOUgusjN49peUhvLUVhilxM7//8lEPL?=
 =?us-ascii?Q?aiuXYZfggVZ2/mMNsPTZ22xBBmyXmXehXMZaIM290ykRR9AcPyDMTbOnBCvd?=
 =?us-ascii?Q?7mRNvcgfc8uzvlb3v5zGexLpuuFlcvyeKCJkDN2sQgj8PtJwBTVzKxvS+AWZ?=
 =?us-ascii?Q?RDrS13kbXQfkPP6t5/L0JSb5r5xXTOrul0gPxjMSG0t3roCQWfHLajJmiTnj?=
 =?us-ascii?Q?PUMiwN3nzxA72jxEYT//NxSJLkzBNnx1CYBA+8FLggJtz13bNPjonqSFzp4e?=
 =?us-ascii?Q?xP02j1hZrW1Ou0sZL4aUccLtTtxUCV4DDobdPMjG2tyhY5++K/hE8G+McOyw?=
 =?us-ascii?Q?xwoL9uTZeQ=3D=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a13b40ca-effa-400f-ddab-08d9eb6bad80
X-MS-Exchange-CrossTenant-AuthSource: DM8PR01MB6824.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 01:29:56.2378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xnZezGtEH7ybg9z0LwQRXNmZE9AIskkiQBJAex5krRy4ud+zHkOBXbJIvscua3jTzfZNUeCRUXwRxIUGjxv0t2/Bme01x1mQ0g68WgjkcGOYYgC5FWEvNnnG2X/o3bbw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR01MB7355
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following interrelated ranges are needed by the kdump crash tool:
	MODULES_VADDR ~ MODULES_END,
	VMALLOC_START ~ VMALLOC_END,
	VMEMMAP_START ~ VMEMMAP_END

Since these values change from time to time, it is preferable to export
them via vmcoreinfo than to change the crash's code frequently.

Signed-off-by: Huang Shijie <shijie@os.amperecomputing.com>
---
 Documentation/admin-guide/kdump/vmcoreinfo.rst | 8 ++++++++
 arch/arm64/kernel/crash_core.c                 | 6 ++++++
 2 files changed, 14 insertions(+)

diff --git a/Documentation/admin-guide/kdump/vmcoreinfo.rst b/Documentation/admin-guide/kdump/vmcoreinfo.rst
index 3861a25faae1..a339af45a22e 100644
--- a/Documentation/admin-guide/kdump/vmcoreinfo.rst
+++ b/Documentation/admin-guide/kdump/vmcoreinfo.rst
@@ -494,6 +494,14 @@ architecture which is used to lookup the page-tables for the Virtual
 addresses in the higher VA range (refer to ARMv8 ARM document for
 more details).
 
+MODULES_VADDR|MODULES_END|VMALLOC_START|VMALLOC_END|VMEMMAP_START|VMEMMAP_END
+-------------
+
+Used to get the correct ranges:
+	MODULES_VADDR ~ MODULES_END-1 : Kernel module space.
+	VMALLOC_START ~ VMALLOC_END-1 : vmalloc() / ioremap() space.
+	VMEMMAP_START ~ VMEMMAP_END-1 : vmemmap region, used for struct page array.
+
 arm
 ===
 
diff --git a/arch/arm64/kernel/crash_core.c b/arch/arm64/kernel/crash_core.c
index 314391a156ee..2b65aae332ce 100644
--- a/arch/arm64/kernel/crash_core.c
+++ b/arch/arm64/kernel/crash_core.c
@@ -20,6 +20,12 @@ void arch_crash_save_vmcoreinfo(void)
 {
 	VMCOREINFO_NUMBER(VA_BITS);
 	/* Please note VMCOREINFO_NUMBER() uses "%d", not "%x" */
+	vmcoreinfo_append_str("NUMBER(MODULES_VADDR)=0x%lx\n", MODULES_VADDR);
+	vmcoreinfo_append_str("NUMBER(MODULES_END)=0x%lx\n", MODULES_END);
+	vmcoreinfo_append_str("NUMBER(VMALLOC_START)=0x%lx\n", VMALLOC_START);
+	vmcoreinfo_append_str("NUMBER(VMALLOC_END)=0x%lx\n", VMALLOC_END);
+	vmcoreinfo_append_str("NUMBER(VMEMMAP_START)=0x%lx\n", VMEMMAP_START);
+	vmcoreinfo_append_str("NUMBER(VMEMMAP_END)=0x%lx\n", VMEMMAP_END);
 	vmcoreinfo_append_str("NUMBER(kimage_voffset)=0x%llx\n",
 						kimage_voffset);
 	vmcoreinfo_append_str("NUMBER(PHYS_OFFSET)=0x%llx\n",
-- 
2.30.2

