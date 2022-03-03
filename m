Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD57F4CC2B4
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 17:28:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234768AbiCCQ25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 11:28:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231447AbiCCQ2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 11:28:55 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 550B76E4DC
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 08:28:08 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 223EuRTT009253;
        Thu, 3 Mar 2022 16:27:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=//Nm0GyKPJLXDlLr4gVG1UR9DIkq2h+ZjG4yMtgNS00=;
 b=J3dep3DLA7Z3DdiSb9PeoP4BH2QgELIjaeeXlgEGo4qR5lonoB6ZLx7bA1PJRY2rPPpG
 qxOgPjvdnQ3dZQdfIwPCbu0Br+Wq7KzHlNfWlFk+k4Ocz96Oi3Q9/+pSp/Hw2d9ovLhT
 7+79Q5SO0Rn8PXjHyTk1brf1td4TtHKKJK0hhebec7NFbki+9eivhCYJB6sZUHXPjzsg
 57OqTimtdIpke0TsVV5g4R45ftYUi6hT/vJltmXUDQPM3afyYeyt9Yqn8fyLDmGoQZlx
 75L58O8AblnKUrM2JjetT3RERlcgoSxitwnTVvKhTL+c+1z4na6rcOOoMkQVFEVqT4Xu 4w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ehbk9fwxm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Mar 2022 16:27:49 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 223GFS6G176004;
        Thu, 3 Mar 2022 16:27:48 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        by userp3020.oracle.com with ESMTP id 3efdnt01a8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Mar 2022 16:27:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q60BFnlYBTiGUQTK3F6U8Rd7j+MmKRZ661tpJYnSHojq1lrMDncggDOoPT9frjuB/oJht87maZatiUtOSJAyUmLMI6AUIDv/jWmhiE9OiVQ5uWAWq6j4tlXF0e7rP8HEKSafAjZQKQsawP4WvlW/hKw1Bng3btrud9cIlU/bZJSSe9Egk91pXjefwf3DONS3qcWHuTa+8YNqQ3yITwGQ4P7JEzejuT7s5JzgoFJiZ1Pvs4Fk8ZXwS+jOLE12MUT9LxnvUg08iwYtlMK6L08GKAIxnhHOE3LseTDNA29ZUnE5ghaMgnKXzMoH+xi/WvOXSqtibWCNc2pvscJt/uWJhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=//Nm0GyKPJLXDlLr4gVG1UR9DIkq2h+ZjG4yMtgNS00=;
 b=SjPjop2HCUZpF5Fx6yU2U/NXTwbDWnLR1+dnQ/AG1XD4v/kiCAPoUyMQQLM391ETAy9wyXlAFELnn+JUVCNeUDkh4ijL7H2kBw5ZzSrRcX3rpXBoIifIuW93auNWNtryFIqD7H73BPWvRfp4nQ5LkiHawHJCH63fz2nGduYMWOx5Y1nRso86MMDSIrCcU998VPEnmAWudcLlsGArInyGBFSkYPFSofyZXRSScv7q2UHqCw6kvUTy1pxW6sm7VY3pDgtELw3/dJUybGz8ezXuujIe8+wqPaGnKwUriJaOZa1+urUTQraSco+Q53ou8n+8mcoB9uvWDxX+xnX92snhBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=//Nm0GyKPJLXDlLr4gVG1UR9DIkq2h+ZjG4yMtgNS00=;
 b=yCNfA0hKdXG8wWPB8/zshRMatABNH7iGTM0N5QxTGlF9EH9fiOaafpXTfClvsjEsmUgeowsbA8RfhzG71lRte2KZU7sXZdu/Jnw4Arnzzcm8Hg5YTBfmHHhwn0PbjFrEOkA+/Ir2739wH4Ztu8aleR8ZKjJd8q1kTiH/WSZAwMY=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by SJ0PR10MB4704.namprd10.prod.outlook.com (2603:10b6:a03:2db::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Thu, 3 Mar
 2022 16:27:46 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::3188:fe86:1d6f:53ac]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::3188:fe86:1d6f:53ac%7]) with mapi id 15.20.5038.015; Thu, 3 Mar 2022
 16:27:45 +0000
From:   Eric DeVolder <eric.devolder@oracle.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com,
        eric.devolder@oracle.com
Subject: [PATCH v5 2/8] x86/crash hp: Introduce CRASH_HOTPLUG configuration options
Date:   Thu,  3 Mar 2022 11:27:19 -0500
Message-Id: <20220303162725.49640-3-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220303162725.49640-1-eric.devolder@oracle.com>
References: <20220303162725.49640-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN7PR04CA0214.namprd04.prod.outlook.com
 (2603:10b6:806:127::9) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 472245ab-abe8-472a-6181-08d9fd32bfc0
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4704:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB47043CD479FB23AE06FBDAB697049@SJ0PR10MB4704.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AcasB77rKKamq+WKm6bXjMAUzls/IzdSSbpY40JgU3a68nobqMin1Foc8wzTF0CVwSRxZfNVSv4Av4Ftaz+gyJxpFAHrlWArU92EYjyMhgb1CClneQG9MAPve+VB6DApG/ogfCSFm14VUPT6ZNQsx9NL54kascoKYCJkwmd1jPe8S/XID+aIzGSvskHNLQcvzHh14B2T8zhWhD8KcZOJ2Y4MbPnEjnFzQHiGhvvJ8fmSq73/mrxHg72xrcQf2NniwFMRFd9F4U17xPA9CVVWddD3cpeXkpMFrRSDHKy59LomsVVAM/VGEmXrLHxnNepiOlgpokqIZIjTW7TgYteVgf7yurh2GpMpWhuwf8kWxvDQTOA+WmrVbAUYDoq6LG8WhhVGKxAgczln/BBGHIkJORvJMLvk1jqawrjY+W3vxoCgTRHnpIDSKmmTIM8kFaETVA8UHdtWIQ/iO+WqX5BUKBWHj8uLLBftWgZLxHks/DZbIDEGBfkE2OdrGZNMHL1yr+EMiuogJcE/i7O4UM1yiIiU5AzUALJRNRbNUvlzhhgSnNPl+MyWfueoMeF2j+L8sEmdsqbR2n6AMgIYVaUJXIirAaOnAafgt2z3++nbp95IDa5a3hmw5IYJ/z7onXSQUdVUK1biiYQZfYd1vbS2UC7s76y2gtzOO31yQGLwQ9ACsHIlCHTtp7QGl98HDiIYZku3j/4zOAVkmkOzbnAvlA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(7416002)(5660300002)(38100700002)(38350700002)(8936002)(1076003)(26005)(186003)(107886003)(2616005)(6506007)(52116002)(6666004)(6486002)(6512007)(4326008)(66476007)(8676002)(66556008)(66946007)(316002)(83380400001)(2906002)(86362001)(36756003)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OVQhVc4cFy80+HdjiCwicEtLIdrHegItY+CiPXetWz25JGBtFPiZ9c0PMG0D?=
 =?us-ascii?Q?8/UFiIJN3csg3Km6Kwykgjc/QU0bzLIGCVHORVQRCpXTIVg8D+v3c8QSgHdz?=
 =?us-ascii?Q?njhS8L7cxfZZPKsYv42EelenDQob9HIzivQIJQSlDT1iYDZRfKf5VbYckglV?=
 =?us-ascii?Q?Jr0GccgkNfRm4urBgdURTc5OhO5XfCFPRjrvzuyoGj3ogUTgvPGt+hkKAWw4?=
 =?us-ascii?Q?IPJVfoTpVoRF3++YX2Q8MC9b/q0jqYVe2KH01ulVWzdsn7dvm5nHFknYdr0r?=
 =?us-ascii?Q?ZCmpWkUP86u6UI7vQ08UKXDh0i37Zf4B+JeS99OldmfcvOSEf5m2clERwLsE?=
 =?us-ascii?Q?1sk1jDk3eIPKjj0HwnaK5kev8QJQt5MeqU6ZbxxrPx++BZNuXRJWc+BNHUjN?=
 =?us-ascii?Q?BNMthRNV5f5ZWJJG2Dqvl7cEYi03WpGgQYb3Ufvi6ud734eUBADNokRf+Xvi?=
 =?us-ascii?Q?nXe2oSPT/F199Xg4K9KslOSVk31LqU4I9vTnNEsN+TZDQZqPzCQkZOquDDXU?=
 =?us-ascii?Q?Gb3KvAG38M7ZBZnaT82UpKnsxS9K69TJZspgSlBJY3j0FnRRhiSN/gwIhPTe?=
 =?us-ascii?Q?w66cpcJ+BF3f9gaaBVh4Is9suZmmL5lwizhbxbAqh57IU2ZrFfP801TA00pZ?=
 =?us-ascii?Q?VfEYWYbkfzblS/MIU/A0+86yuataIRO8ZxAPPm/vLKJORcbJKmTsXBpLdrOl?=
 =?us-ascii?Q?IMhjUa6bqJDOlpZJBK8B3wYXhWVRII+Mx6SpSo8MmqEoBfWtDgXOyD6KwM9D?=
 =?us-ascii?Q?qPnHDpnegdyEmUxZ7471IJwZlwx43yEzVITzeNMczkUYkvmCvP/0AF93h1lS?=
 =?us-ascii?Q?JKyZPmFpdKg7Q6TBrG5+26Z3Mlc7ug4H4hfWtLhcBCRlA2fTomaQoDf0tbYJ?=
 =?us-ascii?Q?3vjugYIPq0ckQfxvjA9skxH2S2YHCncYwMINlQ0VQkSv2F1ewEiKoWJgh5mz?=
 =?us-ascii?Q?pbLwCcf56qsm05Yev/fhnPvTw0cXC8mbOMu401RjjIBVUhkoFHiM7gSX+cVr?=
 =?us-ascii?Q?MbLyDfRu6fzHVVws+uXOn/lrQo9rJY0NE06XGb9Kv1aYPujJ9mlK9JaWJR94?=
 =?us-ascii?Q?hIsOSN5glD93z/U9lR/h+53k2YmlawhNryM7eCBVjvcLY435YB0nR05m/Vo6?=
 =?us-ascii?Q?qvK+pnvNmb57tUB0vBkPticF8UXmOPMDokHaw0+hVndonbDqUcF/7+IdcVk/?=
 =?us-ascii?Q?7W3rI0M/lhxUtkz8RCsGdfCKflAvtBOwrantHQDvM8Lap1LffskNaDqofvMv?=
 =?us-ascii?Q?NNbcI+NlrQ+BOONf5FqGovy/2D6bm7kHGYL+Es4X+FvEJ8Ay/3GSMwfM+ifo?=
 =?us-ascii?Q?Oc7248wo2rFKqK/NK4ZSdID09cAaJ7C9Prjh2DkXqeiHnOHJfBBmBL3Czanp?=
 =?us-ascii?Q?qwLDx6K9VSmNylpqXFu47eXFkMK62yY/kPR1MF8f+a6zpqWtKY4p+TqB3lGv?=
 =?us-ascii?Q?eUWtNkq1CFGmJ4AfpF3OdKiJmzcl+iVat9Jz2BrJf9PmT7Uj3WFvDrWnYPK5?=
 =?us-ascii?Q?YENIS0O8HtcPcuOnMGmAlFi9tPw1xQanJKv1BRhXNQxBIS5Z8/NriCVr6i+M?=
 =?us-ascii?Q?VecB7JjeRdbkypSt71UgPV6lDhG27sLXWOZDQj1LW8MucQwES6gBm6fuZqtU?=
 =?us-ascii?Q?GBGM64hWyObwtmLzfMeuFOyTngsvw16GyIpJK+7Z9OaBBNWF5Uq+LHFgsRkV?=
 =?us-ascii?Q?Xseo/g=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 472245ab-abe8-472a-6181-08d9fd32bfc0
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2022 16:27:45.9071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bh98kMrw0I8VCiL3vaZp16cPbT7/02FcExdBVCm96rfVRQS/IQD5ykFv9B78qjJjsQwRlWFm6HWgw9ruZUpX1RIpb4O/Gxz3b3s4wNsRnHs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4704
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10275 signatures=686983
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 adultscore=0 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2203030079
X-Proofpoint-GUID: RTKFlRMymYJQ8GDYEg4chjO1LPbERjYP
X-Proofpoint-ORIG-GUID: RTKFlRMymYJQ8GDYEg4chjO1LPbERjYP
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
index 9f5bd41bf660..37eb26563f07 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2061,6 +2061,32 @@ config CRASH_DUMP
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
+	  For example, this size can accommodate a machine with up to 1024
+	  CPUs and up to 1024 memory regions, eg. as represented by the
+	  'System RAM' entries in /proc/iomem.
+
 config KEXEC_JUMP
 	bool "kexec jump"
 	depends on KEXEC && HIBERNATION
-- 
2.27.0

