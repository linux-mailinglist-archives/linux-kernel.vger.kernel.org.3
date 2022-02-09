Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12D454AFDE6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 21:01:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbiBIUAD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 15:00:03 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:53560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbiBIT7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 14:59:34 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E6E7E039C4E
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 11:59:26 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 219HURkU013354;
        Wed, 9 Feb 2022 19:57:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=ZRncpHAHj2qu/zCatvrXg0NFBmwphPEcMEWr3R4gXrA=;
 b=D1tpLKdTO/5V0rt47VUxJJqdKDY8PkJMhzEfpo3fVTtUBSRRdgN3uLAee7neWjSwyj3d
 dTkQ9DIbLhLxlK/MmHN6L3fH8l7zJ90SMkYubOERHicw2mSDN2E3PGzu2UYKbR4xBY1Z
 Pkp4cU8Bj2sfcOm13oOq9hu8Q5IABD3JTg+B2FRka5oqWCEueaqHtHNdcHkKrKPlzltU
 aGwb/Nl7Wx2dHma2bIHuXn+aIrhev8pN/TOU37wU/uj4C4ZvBA0i2rYjo/q91TGYYuP+
 QuFJ5ylTUXhffVYc63DVOPQzwh8dda83AVDHJQzVxohK7U3af0LxsrXAzb8Y3Q09E2xS uQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e368txv3f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Feb 2022 19:57:28 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 219JtqDU046306;
        Wed, 9 Feb 2022 19:57:26 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
        by userp3030.oracle.com with ESMTP id 3e1ec3b055-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Feb 2022 19:57:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PvJnAdmRehYRngg7W74VOVH9gB1Pp505hkdHZA5xiKzoPz+nObgoC0EuyEaePeJvZI9hBuYTMSygXuh9Izr4rsQKR49Me8NfJVKwAq3aUaDIojyDpRSLBe/stK36hVx9bsEsBoDTBRD8XZA96R4Dan901hKk+9ZzzrU2/XtJCHph6xcyrVJF9bioSQwQvG54zMQKJIDx4vPR4c3SD2xOYrvKrNod1kZvS+PNgWKAf827Wr831DYIuxdumTTfQpwC3h4M/dKweyVBjNzcElHtrsGGzqhgjwUsvfQpzObHwxMwHY2uhS0W/XiLvZvP18u/JTSHY9Tn5mIJMHRxFjdECQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZRncpHAHj2qu/zCatvrXg0NFBmwphPEcMEWr3R4gXrA=;
 b=oAUznhu+RpkMISnaHlQLXxk9GpX5uA68KKsBZQgPG7cv1QldqUljZv0XAflVgJ7UFsuAo3i6GQDthN87HxWgbC9x6urrzau1Arcew4kgiFktg5kDhOYHjZb0dLwaNgVm4mSdfYaWpwQyWR7a6HRWrSGqj7oTTouFSkgVwslvP5DPnzziWe4G+1uqbOOvFcClA9tvGIDHlLvSvxKuHCPKO96z0lm+MBjJoLBtE7XM3of6mcsiql0hRLDarnssbm58AzbCebRNimqwzfABZnRr4CFqLGBqvo7+cXkl0uey72A/xhaVFAtD8iHgoieaZGKiBmZPXL/9eP/7WdN7tBJT5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZRncpHAHj2qu/zCatvrXg0NFBmwphPEcMEWr3R4gXrA=;
 b=EXHoBhoQo9+mVz215HWbaRoK7y+vErwjzWTAWvxhkgR9r0OW5yQ5LL7b65Sc+hukm2QWePBXvQK8gZKq10XXvzWOGYwilyhfQGEUwbaZ28B69I1Ad/hg/6htCHlIiUzRdWuCiL44/lg/7CQhFwLd5SVALMwJizedhyh0Wp2u/mc=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by DM6PR10MB3721.namprd10.prod.outlook.com (2603:10b6:5:156::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Wed, 9 Feb
 2022 19:57:24 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::ac06:be4:5723:771c]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::ac06:be4:5723:771c%5]) with mapi id 15.20.4975.011; Wed, 9 Feb 2022
 19:57:24 +0000
From:   Eric DeVolder <eric.devolder@oracle.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com,
        eric.devolder@oracle.com
Subject: [PATCH v4 02/10] crash hp: Introduce CRASH_HOTPLUG configuration options
Date:   Wed,  9 Feb 2022 14:56:58 -0500
Message-Id: <20220209195706.51522-3-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220209195706.51522-1-eric.devolder@oracle.com>
References: <20220209195706.51522-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM6PR05CA0046.namprd05.prod.outlook.com
 (2603:10b6:5:335::15) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8cf3fd05-da00-40c4-0eaa-08d9ec0663ef
X-MS-TrafficTypeDiagnostic: DM6PR10MB3721:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB3721116E8D67548BD0E9267A972E9@DM6PR10MB3721.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RyXKo0OjaJnSdtLZHcwCr2ltkfcLouvRYQDq7bjX6FZdNGcHsk3l8qPZoYkNab4LSODG7g/GBnpv7kK8dp24eK8kFC3kyI+kXnwArjBf0OzcaGHalFBolgmADJwBUblsEpj6qvUKnEnIRT3i3vf/wJ6COTvZCF0RGtxqjwLXsjb2uJszmTTXciDw31HoMb5K0ep73zALSHW0RuklmchDCc6c4+g5wu3ZSQSqncZm6RycK+zmAs3GyMUiFUA7zLbvvN4x2jX0XUhz7Jr1W/TMTqvdSTVaPQEw8b1t9hUbi2HObteBfVmq7dW88/KLGYzEGL3WdhgsioNfVSjx2yG3SYdkpzfMdMgl0bVZKnblVb1ryEBvmjlMKn2tQAinUqoUjqJNQCZ59oY0O1+8ArzTAhw8p//m/dZtBcAFGCcvz/9/4IjmEGOjveHuUuzEi750xzA2WgzNg8lXA2RSKm7PZ3XeKIpU4bxNuzX8URkM5l5pv23rVu3cxaGfpxE1cZYAatwv7Xm7eUwSofcD92HArwFNoJQCtfsTANdrnbh1fUyUgJxQ9Od9m0WsOwfMgF4iB+2BXyATwJceo+l1eIykt4mtX/ADC2bH5gHdzYz4/mocZ80bRKqhqweGHPl4Ufga6Ite4Lw9kmuO8MTbR2bcg+6XmUa3QYwYV0M33AkMkFNl93EDzOmohhAlDANSF7bDAUifVd7k6iQ70ZcBQoasGg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(2616005)(5660300002)(26005)(107886003)(1076003)(2906002)(6666004)(508600001)(36756003)(38350700002)(6486002)(38100700002)(7416002)(6512007)(52116002)(4326008)(316002)(66946007)(86362001)(8676002)(6506007)(8936002)(66476007)(83380400001)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bxl9zbKtfBaDo9+efrdM17hbJAemjg0nY5KCetHO8EnIil/50kH0N7LaMWVP?=
 =?us-ascii?Q?II2zkqvO8zoAZs9JKfXIPK8bwkT2F2npArQgnw7/VlxefgS54QoFZVffqV42?=
 =?us-ascii?Q?sFhnM5uoOSxfNZiJSi/GnkO4erckYK4SilTe5lgQqaIfgPwHZ+oJAZunU3JS?=
 =?us-ascii?Q?P1G1YNmO/meufuTlybHtbCSCtSaRsXYrT5YWIOSUbhMeHHChVZ3XPKXmgMsv?=
 =?us-ascii?Q?sfS4rJuUcPb+tuC2Fhhycxp8Ro7AKyBP6uvbL3W0+TPYGSpLM78pO2LtPGlY?=
 =?us-ascii?Q?Yd1hV8Vsdk/sSL8TdciXL5ItWzCl3yH1mEJPvuNhenRdTso9KUHwGoa+chCw?=
 =?us-ascii?Q?TVqV93AowoK12AdeROtu8xXqHvQZKPoR1S95QpohG1ozP9hun5N+c4jDbYXy?=
 =?us-ascii?Q?ZMVSvipHuldUCzAtn2uWjNBs3BmPq70hopBt2vNKFq7sSNRAajjTdMfAOJdv?=
 =?us-ascii?Q?buGRfitDmsGy5K29rRUhVW3vnw/cWEbxt4ybPmSQWHq7TggKQRgjia16R2+H?=
 =?us-ascii?Q?itIUM2AgDaP7AbTCs2H8GYPULiS8rUIhIlLjLoDC0KWklS/DsE3EXQuft12m?=
 =?us-ascii?Q?7C6MRm9BsEa+d4vndLNxfyYDIWtRc7+bZRwaVcIl3K7UCVXr97qNTWuo7U5q?=
 =?us-ascii?Q?urILUGJnInj2fIjobkR2FCe0bAL0GwwQG0tTrbl8on/0d4duz8RGMDTNth1/?=
 =?us-ascii?Q?efb7CrBJGWIWSHLnA2DDfY3pQArhoolhbA8rMiId6nQJFplHy1n+/leSD/rI?=
 =?us-ascii?Q?yn22FRLWRo6WUd9oN45E5AqYNXYQ6pv1CAvqH0QAlaG5BkWmYp2SPI/LIZG4?=
 =?us-ascii?Q?Dz8QWYb9S/YC5pYldsXBA7UcaBEG3xGAjy1wlCvHCGOBoZBda/nQvkIM5zJC?=
 =?us-ascii?Q?QjvOXtpmOAOQ6AnnU7ccOGDEijqIV2snVDyFthKr9Yfh/bV1kUxkvB1wTZzy?=
 =?us-ascii?Q?z12NPUZxAukzPASMTjJen3SD4D9MPZz18JO6ABWIFj1CvqOH0mxlsOMWRiCp?=
 =?us-ascii?Q?mXOCn5+ResRjBHJhPWbtEcTBi4K6kihHtLD/IV7ijYs+HntqknNumEKBVdR4?=
 =?us-ascii?Q?h3u4e+BTvw/Vjn/vxmADXCSC3rhoY/yGRNxDDL+1GsyvFQhxlyMg1+fpO9m3?=
 =?us-ascii?Q?0GI628sjNvsDatpT31bbTAPFF4mQ93Wcb3WyC0OpHpiBrFSdFkMHpyD4HOP1?=
 =?us-ascii?Q?d7jCdocoYdPOvLusLF8q5NmtGjEDNq/b2EzJByAmf6JX7mhvBNkIbqOfD5Vw?=
 =?us-ascii?Q?oFIokpw8FyUrviA3N212cUkI1H2I3vXtKWDj9qA0da0kOIDj0wsJaKKLLlIZ?=
 =?us-ascii?Q?HTOIukzzswsqJ2mJ/aCFHOc4aPRDO9ibhbW370xDbGGEZLVKAJhY9H18U0Id?=
 =?us-ascii?Q?wTnr7GRh7VoUN4Dgxe6AJegnmsFWX5qDArsUtgqRGECfMpT2GF3YwA6QQAQ/?=
 =?us-ascii?Q?Sku4mn1MbdC8QOvVmYuX9VLWI5pkvjEqsG3u4sWJOQ38bGvoGXYG0iOrMP++?=
 =?us-ascii?Q?HkVOxE7Ncev38ZSJXasDlM/A4lsbng5vlgCc7SnIHz5We5KEkB0pz1LynHk2?=
 =?us-ascii?Q?e7Z6jp/Ot0QGfwOTi2gDt0tEKNhIpnXn2ocs/ir2EKh3EqWdQyxFN7KL4gkg?=
 =?us-ascii?Q?cZrckYm7gCtS2IyX/IkosiakUAWiaCmyQOp+vUXjnXrsuSa/QBO4VExsfCCo?=
 =?us-ascii?Q?Q3im3w=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cf3fd05-da00-40c4-0eaa-08d9ec0663ef
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 19:57:24.2549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m3jxjUFalen7SVZM+kt3sMlMYmE3b+HlfbeEBZbil+7sRMR07fYlYllAnSlNjGxKmmAOdP6qD4/RGLEuOJbxJn4jqFL+3JFVPTFh4WUs2kk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3721
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10253 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202090106
X-Proofpoint-ORIG-GUID: K6F_XD6l24j7pJDiDwUH7uodwpmkT02M
X-Proofpoint-GUID: K6F_XD6l24j7pJDiDwUH7uodwpmkT02M
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support for CPU and memory hotplug for crash is controlled by the
CRASH_HOTPLUG configuration option, introduced by this patch.

The CRASH_HOTPLUG_ELFCOREHDR_SZ related configuration option is
also introduced with this patch.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
---
 arch/x86/Kconfig | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index ebe8fc76949a..4e3374edab02 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2060,6 +2060,32 @@ config CRASH_DUMP
 	  (CONFIG_RELOCATABLE=y).
 	  For more details see Documentation/admin-guide/kdump/kdump.rst
 
+config CRASH_HOTPLUG
+	bool "kernel updates of crash elfcorehdr"
+	depends on CRASH_DUMP && (HOTPLUG_CPU || MEMORY_HOTPLUG) && KEXEC_FILE
+	help
+	  Enable the kernel to update the crash elfcorehdr (which contains
+	  the list of CPUs and memory regions) directly when hot plug/unplug
+	  of CPUs or memory. Otherwise userspace must monitor these hot
+	  plug/unplug change notifications via udev in order to
+	  unload-then-reload the crash kernel so that the list of CPUs and
+	  memory regions is kept up-to-date. Note that the udev CPU and
+	  memory change notifications still occur (however, userspace is not
+	  required to monitor for crash dump purposes).
+
+config CRASH_HOTPLUG_ELFCOREHDR_SZ
+	depends on CRASH_HOTPLUG
+	int
+	default 131072
+	help
+	  Specify the maximum size of the elfcorehdr buffer/segment.
+	  The 128KiB default is sized so that it can accommodate 2048
+	  Elf64_Phdr, where each Phdr represents either a CPU or a
+	  region of memory.
+	  For example, this size can accommodate hotplugging a machine
+	  with up to 1024 CPUs and up to 1024 memory regions (e.g. 1TiB
+	  with 1024 1GiB memory DIMMs).
+
 config KEXEC_JUMP
 	bool "kexec jump"
 	depends on KEXEC && HIBERNATION
-- 
2.27.0

