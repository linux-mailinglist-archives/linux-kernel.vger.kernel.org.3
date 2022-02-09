Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF7954AFDF5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 21:04:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbiBIUDU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 15:03:20 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:44096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiBIUDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 15:03:19 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ACA7E050250
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 12:03:14 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 219HLb9p013346;
        Wed, 9 Feb 2022 19:57:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=HsrvstylsM0OYg6AycH8OOL4tqodYwvqcGLzbWaic9M=;
 b=KUz/osWdUOb+qphjeTVBEiosIniTyUakrkuNUa28IUbjwF6lbGS2ZtSCOruoDXwBUFMt
 ChMIBihwG9wc8+2mhENeOJ38qmiJKSyhk1b20mxLPN95/E3X60UCkGdgpR37sbOClFpG
 CM8MoyGGKgyKdFtHV2WKsY03Hz6x+hsCoo0ONyT1g3Mnr1X97sgetvspwdduZUmSKqao
 XlvDYgZU/ODQbVJLZyrHI/2Y5lLx4Zv9e3OQiTd6LkMcOpiXUk7HBOnBiv4Z0jlWZ/TL
 GBc5yTgWxDi3cB2J7fiTPOMZaWhU89KN3ZOVefnpoKGkhH+rihm/pG5rllVfHRt/c1qx 7A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e368txv42-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Feb 2022 19:57:46 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 219Jtqrb046251;
        Wed, 9 Feb 2022 19:57:45 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by userp3030.oracle.com with ESMTP id 3e1ec3b0r4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Feb 2022 19:57:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PBKVbGyRuLfCs6S6UXRNbsFE5fGBR/SEAalCJbgSRT9HQaB6E19ewS6IxBGeWhQE4bMJHpebGfW0SOYkGHNxXfW3Zwvu9dYxrP1XXKhM6nCVXhGpRnEzK8xXP8Cfw90WSRMS4mETgUfm/2Ke6kcBZxsvO2a8OiptINzb5ibWk3hHkuFr5tCX2bs4ueLJ3dpQQZGuaEM/cLUYhdjhHvAei/jiBtJl7yItTrbenQbmW3zhnP9e1qUrKIeNvv7XGaNXhwJA5cVAlAzBWAsnupkNzcFR2MvNZShRLz9m6HriVAAhyEoWsgiBAZBA04ZRS7lBu4I+kYcGK0T7aj50iOM/lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HsrvstylsM0OYg6AycH8OOL4tqodYwvqcGLzbWaic9M=;
 b=Io+Y50BBaMEnetGY0mdz6qKgTnXWuOacgNuO7+RCEAvTZwEVLYsRN5+snC1693XxG/qtAg2i8fyF4iYUCVE5UkKc66yK1rsGWHZtGFzehShLrsh1nfQ9HqIc3U1xPHDesKYSRlIUAEDfBGd5LoVebIdogIPxYnOykUFa9jcEGv8Qufiaq35XDLai1PzTV3Vp4/21cQFOUXXZwtrTUpfIO+U/jqy+LxP+8E2mHp8OLbqFO9D3nqfq+0Bb989Y0gpyjOC0l5Y1wNcwsA7ry5YtlUmHE4QdJjTSFUC6QG3nWK2s7x2Z0foz0PYTi5M4eBQFS3/gtHhWX4SqGYQ+ByiuHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HsrvstylsM0OYg6AycH8OOL4tqodYwvqcGLzbWaic9M=;
 b=oDMBEmwrju2/QgtQoBRWma0OvAduCy60hMoz8USAjx5Kax5imrXdC6ZhOOYmAWb+oPgAz8balkrYVlcVeN9Q65CX0dusNm7vpJ0kIhNYgYB3Fss0RogUHtbIJ7eSiOg8CLoY1NtFap4O4f7gRA3C7iYEBEhylV7U/1Ph/OmjnlY=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by MW4PR10MB5701.namprd10.prod.outlook.com (2603:10b6:303:18b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Wed, 9 Feb
 2022 19:57:43 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::ac06:be4:5723:771c]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::ac06:be4:5723:771c%5]) with mapi id 15.20.4975.011; Wed, 9 Feb 2022
 19:57:43 +0000
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
Subject: [PATCH v4 10/10] crash hp: Add x86 crash hotplug support for kexec_load
Date:   Wed,  9 Feb 2022 14:57:06 -0500
Message-Id: <20220209195706.51522-11-eric.devolder@oracle.com>
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
X-MS-Office365-Filtering-Correlation-Id: 67d13670-768a-4443-2cc8-08d9ec066f1c
X-MS-TrafficTypeDiagnostic: MW4PR10MB5701:EE_
X-Microsoft-Antispam-PRVS: <MW4PR10MB5701441780B07C7CB322ED32972E9@MW4PR10MB5701.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JyajodsZ+7WTuyL9CIi2I/6Sff5qE7humu18+seaz7Va8DGq8NvUh3Kx3OyEI+83yVXWMq+N0QpfmxqmUS1CKZK9m3Tchqj/a7dKcS7Kfg+R7Dya2bhfWrAs83rFiOxdIvEJekhZtbqPao1R141keTsWKh36ET8jVqCm7AF8rSLwYswYdrERz5bgpnrK0bp6joKDuPSRIliokCkbIoZ6TTZWEC35IEnOpVI/ZFd2nU9dGWWp61bb/ZlgBzMxkkbc//tWpD26KmP7G9xWbutLCC+apgBRocwo2PqhQ5GHp27Em6Hf8m5IXJn3sJTlI2VGO45kJz134vYKuey+r1mEKXI4BrgASVYhZak5nSM9ndB2BvgM0d60sXUm3/VkJtkEUYdOjoPe5MxNX/fz+YCYe0cEQFJQP6o9J+XMODNS5+KoyaeRw/v8Qid7ETxmrfHX7z2mHcb0UFItA1BjKBj8otgD7o6aN/DAVmxolRqEtp4RkHB1LEyzn7wekoT5gs3YgjRqgczJE9TYeNOVD6KC/jsMnxkMbJstr74U36C62sFUhyFnJwT0LJ9Zd2MDzn/RTa8D2vKefAveBtXdj36QwpuHQn+6V7gn7m5ojDE/nMaary3ph0sXv5y0/ODlYF0tbObCGnFpjYhtjPvNI3YyaGU/IK20tDdPmpiTp5DMZmPSC2PNOF7XAjBg3TF0UcK2GW9Iv1u2IgWAVKAI5vhW6Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(7416002)(5660300002)(1076003)(26005)(107886003)(2616005)(186003)(38100700002)(2906002)(38350700002)(8676002)(86362001)(316002)(6486002)(508600001)(6666004)(6512007)(52116002)(6506007)(8936002)(4326008)(66946007)(66556008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?E1BGOwbVOPqqZ9/xwpLIYz8n+ex6YyrHE3yys15a149nDW3ATv+wry6lH0HR?=
 =?us-ascii?Q?/tBmc+WVRAAgyoCcKmPs8xtXmJMKO/QipPC16LAlIEePrVeJYUuNlW5zLJ0F?=
 =?us-ascii?Q?5PU2wVVFGbfUa4SVEEtwiAHRP9RqQjQn2uTtEtL31M9l1Zq4Q9c7Y+kmWoBw?=
 =?us-ascii?Q?+Hy3BwG1n5s3yhWNeyjZKsN+eFOOvrzAh3LAyH4DCEMCnZLE3Rt27hIQWgEt?=
 =?us-ascii?Q?IiMrkZtAqW6zLMadOIOzBtEZU8djHkGgIXdw84ugaQMF4oejMO/z8xWOPSwZ?=
 =?us-ascii?Q?98CxRPJBq7Kg+Pm8F7qby+pYbQyOorlx91tdWDJcBFEaKl4qmVy83gyyHpG9?=
 =?us-ascii?Q?aGYMrKhrX+41lCfEUx7YZyscaOl7ZOLUf6mryk/lIArRQrShsYUM28UVj03V?=
 =?us-ascii?Q?sQe+8qNhs/jWoLsb0kz+zwradJtDs5NazQeCZCl+fC5LyuDP04C/ckzxfLNS?=
 =?us-ascii?Q?8cqRvyMKQ+fiTyRndu3A+Oj1YCIqmdEGP4scYj2FY1n3n5l9YUXzCfWY9zgs?=
 =?us-ascii?Q?ngCsbB0AKwmc8x6mmO6BoZOKJtxt+Vj24M5dtkApwB2nD10nhuqKv6Rx2ev3?=
 =?us-ascii?Q?k1VsiFmTPObPh5lnWwyrH4laUehPlM5yEC+gFLj8u1Qnh9VtBjtV866KAViK?=
 =?us-ascii?Q?gv+PxTqjKu2O7KboHNpP0sk8BMWtXt+yUVUGB2nerlSEUNtErowfvIAVpo8w?=
 =?us-ascii?Q?gK4khh0ensGW+WA7lfaefDLUEnWnW5kP+fKWME2jsCUIVt4jfMDgzMPPbl4/?=
 =?us-ascii?Q?PtLX4BCLalghyJbZXZz93GdZaODKHX6q/L7445Z9hGC4kGZXrfveJJvzTOR3?=
 =?us-ascii?Q?of+hD3VtysGEZmvZS/eg43OjJu9qU2OILDAGV2t3ht+8rDWm8MTk93Zt5GSn?=
 =?us-ascii?Q?Lzk8D5FGE42qlZ7yi3VqnWsJ2stiHtYp9rDUnCNl56YL/wK8c6VdZTRDtrCq?=
 =?us-ascii?Q?BNHIuUO/N32AOZRdqEheMjiy6T7LaohrDunJLQqqfaYZSoNHsChXFc4yqjtY?=
 =?us-ascii?Q?Ee6iK7vo6Sh8vTHmtX1YsYQTN6kTzevlVj3ZimMtaliKmz0sE12bLFn1WrVU?=
 =?us-ascii?Q?bO6zelL8cBU+fsI6Ca4uU5jaHvTg1LWGfLPI9EHJuYsInZyrARwvAJEJTncR?=
 =?us-ascii?Q?HkideLNUfqgj8D19o1MUQlUzFAhyaX4jCFVFDTrOJsn6+4pPQuV8gphcVtmM?=
 =?us-ascii?Q?8QceYm0F6W9eMGDLJPJhVmM2TRLsLfLStdH/NYpPxva5d/ATjFn2t5MXgIzd?=
 =?us-ascii?Q?9mAMaC35RbW6n6E7ljJY4qkO5A9z07IuvnUgaRORMxJ8JSBhz2/+ylOgfOHf?=
 =?us-ascii?Q?2aNdzbQnvBGRdE0C7obxhlsKOA9eBC9Bjr9ug2XEU8ynRcP9Jkl6LttRH8wf?=
 =?us-ascii?Q?y55kHg/2IleNCtJc8pd2Mpt+V5PtZlaB8ZrToWSLuwZhhsmj6mhcFz4nOplv?=
 =?us-ascii?Q?YHfR03evlb9os3fbPR6WVYLhpqsCJZCvW7qLArz9QXPY+4PYBiH5JDjDdXjJ?=
 =?us-ascii?Q?7w8K5i9rG9t/7WHfNKsykz8Xd1KF8/l3peqUVD+RUEEMDYVT6MywpbkA88em?=
 =?us-ascii?Q?WYLYc1sbPtZoegYHUqoXsBmmb12ESV6WfCbFl1J0LLcbiytAmNKhCWuCNnuI?=
 =?us-ascii?Q?9D/+BE/zrtK41+aRhSC1Ts96T++C0T5LmVaIvT1ew95yFgcyaH8ku6XW6NU0?=
 =?us-ascii?Q?oryA5w=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67d13670-768a-4443-2cc8-08d9ec066f1c
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 19:57:42.9743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CaJljvaj9JC/geCeu8tzFPCTHtrgUNC1ouVazchicPe4G2IN1XeUty3qBaC2JdCxLBkFKryQPJqbVPzv0BqTd6ThE/G7vGsQZbTK3Ark+r4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5701
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10253 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202090106
X-Proofpoint-ORIG-GUID: upeg15oOpP-cvAN8ySc-CaRv6vRL2928
X-Proofpoint-GUID: upeg15oOpP-cvAN8ySc-CaRv6vRL2928
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For kexec_file_load support, the loading of the crash kernel occurs
entirely within the kernel, and as such the elfcorehdr is readily
identified (so that it can be modified upon hotplug events).

This change enables support for kexec_load by identifying the
elfcorehdr segment in the arch_crash_hotplug_handler(), if it has
not already been identified.

In general, support for kexec_load requires corresponding changes
to the userspace kexec-tools utility. It is the responsibility of
the userspace kexec utility to ensure that:
 - the elfcorehdr segment is sufficiently large enough to accommodate
   hotplug changes, ala CRASH_HOTPLUG_ELFCOREHDR_SZ.
 - provides a purgatory that excludes the elfcorehdr from its list of
   run-time segments to check.
These changes to the userspace kexec utility are available, but not
yet accepted upstream.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
---
 arch/x86/kernel/crash.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index 6215c51919db..1b3e5e4fb965 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -458,6 +458,32 @@ void arch_crash_hotplug_handler(struct kimage *image,
 	void *elfbuf = NULL;
 	unsigned long mem, memsz;
 
+	/*
+	 * When the struct kimage is alloced, it is wiped to zero, so
+	 * the elf_index_valid defaults to false. It is set on the
+	 * kexec_file_load path, or here for kexec_load.
+	 */
+	if (!image->elf_index_valid) {
+		unsigned int n;
+
+		for (n = 0; n < image->nr_segments; n++) {
+			mem = image->segment[n].mem;
+			memsz = image->segment[n].memsz;
+			ptr = map_crash_pages(mem, memsz);
+			if (ptr) {
+				/* The segment containing elfcorehdr */
+				if ((ptr[0] == 0x7F) &&
+					(ptr[1] == 'E') &&
+					(ptr[2] == 'L') &&
+					(ptr[3] == 'F')) {
+					image->elf_index = (int)n;
+					image->elf_index_valid = true;
+				}
+			}
+			unmap_crash_pages((void **)&ptr);
+		}
+	}
+
 	/* Must have valid elfcorehdr index */
 	if (!image->elf_index_valid) {
 		pr_err("crash hp: unable to locate elfcorehdr segment");
-- 
2.27.0

