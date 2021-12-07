Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6661146C405
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 20:53:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241062AbhLGT4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 14:56:52 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:11822 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240690AbhLGT42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 14:56:28 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B7I4U1C029677;
        Tue, 7 Dec 2021 19:52:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=kaWYFH0urKPFOrOiQHfoJph8AW1cJGi/yRevqR8ldI4=;
 b=co3m3od2MagSLQBfjIZtTKF3uyjxknEC7T4LUSWlTUNvioMdKUON4xrSqNgG6w0EEYuK
 eZwi9Rs37PuV7gabGV0alkBrKoMkr+2jVrSeKzSdaW+WbSUXDcHN0r4EI9SKc+ORlvoL
 9yHIrbQHub7BmL9OvO2uwGLGR6GamRP64SYaGa/tfAkw3lBkD2wyij3jBr4kxxXp6wHK
 6u9Dzi1YFr0W1C9+X2+QI7ydDH+Ml65UjvPwmcUXx+nOsDQyPaw7HSmasb2lui4BWYeq
 JY0EbKgNtD662qSGEnt6rVfNWcQcROSP7WQ8vZ+RlWgkjpJN7GWbGjM9mRufKZdKazVN lA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3csctwpe6q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Dec 2021 19:52:33 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B7Jk80S065019;
        Tue, 7 Dec 2021 19:52:32 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by aserp3020.oracle.com with ESMTP id 3cr055cnte-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Dec 2021 19:52:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jmoUtD20d0KiVYVIXF3EbeZvcgGB2qwsjEM2C6OP9QlS9Syzx1x+is/jebAjcvxzt+vXNL0ohNZgX7dYqfjPxVcxeg/CSpfjEKOx84Kt9ke0xCDBUg5p9g8eF73B6ZWbkXAB/J6lNU40BdKKBe6ubOHfM5Ua7NhY3IkHUPaWmmo2rUkkQ0pyELurbC6NL3U9wM8HvC06Ec1SemqwM4K1//Z9iGhVl3XPsIndnOrfSWi6ZWxgXMpSeXYsf7MF5jzElJt9auxe0JDOvHth6snbk6pKOxKmGl6Gf9/tairY3oFWrPwN8hdyAOAW2BUEOXwaX9ZaiEyfYxoLfCNkYACCWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kaWYFH0urKPFOrOiQHfoJph8AW1cJGi/yRevqR8ldI4=;
 b=RnlY4iNl2AZi4f0God+UjkYDdpU8I4L264Qu9pVDIoAgvm1fwUfFSAoI+vrNOe9weJbl9kVKk7IlaAlhHYEXY5WaHpkvdBFuDRrSHrzOAQkQggwsyjNaL3RaRQt2RArytcw4kO5JISqN7rwPnBvoPXAoL5ZL61VycjtQuipGue7FTn1OIM+qGEVKJG9sC1SJmkZVbdajMLXTAkwUjsU9tFsL7cER3x4vb6xhu+7gVv6b9c3TGIk4S421BZSQwJkC+6lYLGhBSXvaY8OwRkSETuz/Fh32zjmMv3vS0Jdp36zi6W2QnTs7M2o5vfSTTJ/IO9x2YzGrHcVvQQli+YW7ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kaWYFH0urKPFOrOiQHfoJph8AW1cJGi/yRevqR8ldI4=;
 b=o1qDOukNiiL1L3TMwfPXQDqPgFTB3yuzyXAZH/pcyweyVdZSTsSamElFeHetvlDCPkw0aXBjzqjejkv32NJm5fC7inWlRSbSjlqn28bywBoIoI8OE2FdtDXTLe4F3DWhZbqtqFdQMki4XBOBKrZofzp4anNasgoWbmeAToOI0c0=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by MW4PR10MB5750.namprd10.prod.outlook.com (2603:10b6:303:18e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Tue, 7 Dec
 2021 19:52:30 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::143c:ea64:7017:19f]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::143c:ea64:7017:19f%4]) with mapi id 15.20.4755.022; Tue, 7 Dec 2021
 19:52:30 +0000
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
Subject: [RFC v2 5/6] crash hp: kexec_file changes for crash hotplug support
Date:   Tue,  7 Dec 2021 14:52:03 -0500
Message-Id: <20211207195204.1582-6-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211207195204.1582-1-eric.devolder@oracle.com>
References: <20211207195204.1582-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0210.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::35) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
Received: from localhost.localdomain (138.3.201.23) by SA0PR11CA0210.namprd11.prod.outlook.com (2603:10b6:806:1bc::35) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Tue, 7 Dec 2021 19:52:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8a4d17a3-6451-451b-0a3f-08d9b9bb1a94
X-MS-TrafficTypeDiagnostic: MW4PR10MB5750:EE_
X-Microsoft-Antispam-PRVS: <MW4PR10MB575085456541A2E2079A9E27976E9@MW4PR10MB5750.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZhnT/6HNLoVMEIlK3uCEMc2kPgCqGyQ1DQBFGoFrQz9zXFITBpCkbgRbCtdhaygDTabi1IvBGwG7bKNkoGFPctI/dYaEQ/v7q6aZvnw+ZNQExoPreBIeZXXRCnph+sJbEe9IH3YrWG/oL/n+kPDpzM/xAFPZC08VKK5ruGFwc/MqL0SGZnXmfHJhKGWsOljKO3iU9Wvv+aOfO/A7iCZ4iYpo4SU/VZa7aC1SDsVWuYxH/MxG5BxW+BVwVRhYw2cHbNqvVqy92q5OrjBCgucfeD7bYO/Z9OTGPr7CiHwNr/Y5iD6Kxe4q1SHY+PLII0IgViXzakKloI3CGhx1biNihxwamyHfgb0bSDEG2ghAq8Pi2wU480crOrr+eu2jZAH66Wz9e+4id7lfTMIlZW2C0strWAXIR6i4d/XsxSoVr25QYT6pgzMBYbpTYrNvAumypP7eoTgL1I+7T4BrkicpJ9g47ogQLRRAsllcLTsG5pNvTJmT2ogebl/4kk9dyirHBD6O9FsRv5pp6FoPriu2Ldh/2dK/Sob2Wxh1FwREupJxtfyKDWqdOAJ5sK3J51cCw1SkBWiJu6kQ/S9w09JKWrujRz+odQgaXLwqLr8XuWDavqUKUjJW1Ffe17P0Z+5LBEbdkflnGc0YgQarARu6VBYOeWKekVS+O4JRllcf0+PTYXAKcy13Im4EQuM1LN++D5HWJttOllLqkF+qlEWjMw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(508600001)(956004)(107886003)(38350700002)(1076003)(83380400001)(38100700002)(26005)(2616005)(66946007)(7416002)(2906002)(52116002)(66556008)(66476007)(8936002)(4326008)(86362001)(6506007)(316002)(36756003)(6486002)(6512007)(186003)(6666004)(8676002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Y1vj7g9PpnJlZblcnQVntp+OpDbwsIevUozWn1Z/w1ikhTMS+C4auFc7k+O7?=
 =?us-ascii?Q?aMfu25sW0/VLYf0M5mJhzko1xyZDVJL1ggsj8klgDkpVGLaj9l+XtRSAW797?=
 =?us-ascii?Q?XfFUGOSirpRG628HimIccCS5NGC6T3yGB2m6oa7yZ14Pe2P/dVVaccf55HX0?=
 =?us-ascii?Q?i/6D7YcA2x0/m8x3kBtAzgEg0pgQ4n7/cKmVonDq5o3qbqGw4oCfG4AswC6n?=
 =?us-ascii?Q?n0j6gmqvtEzNGQFg8P0g9KChjXJWBguYOG1YM7lVglcOuuQOKUYTkG4MkuG2?=
 =?us-ascii?Q?poPpG6axmHwNNdmNh1MJhJ6f9xI//xybC6+BhU7KGDnYI2DD0vj+/X1IbC9N?=
 =?us-ascii?Q?f5DxvmU8jh10jjD85/FTkCCfv3IT2kIQ230iwuxjI4C12SWtaOqrKd2fm8E+?=
 =?us-ascii?Q?0PsiwPzLCf9h1PMCRmvmW+8jKkr0m5/a2axFUMcnJoqCt/EEcLN7N0x6PJAn?=
 =?us-ascii?Q?5g45Zs9ugVP5tdJfqxdMWYku1ut5R9nugtDcGlIt9dxju5VsAm4vRvUUryTr?=
 =?us-ascii?Q?47Ff4Cx8mpFX8hs0j1fk1Lr1D6YEKlQXxlc09dqoO74AxiHoH5qOZ+XCiqoY?=
 =?us-ascii?Q?q3FxkiHoqFyMLE3wM/MEEBmzAkTS8A1MidMdtSXQ7kGWZBtE50Yy7H57PLVU?=
 =?us-ascii?Q?//d9CcoXoMvAlPqepV7aXH915KxbF2gFvAA2ua3sLWDMe/TNMs5siXbpRe1F?=
 =?us-ascii?Q?DtkWnfmstj3kte7qcM4ta24UDbhP21BtdVN3iZQu0JA5f+Wy4wMMOwdRRMMG?=
 =?us-ascii?Q?8dnNkBAahciNTvWYgRm8M/fvs2+Dp7eIEKmkxmtZCWQnA8Nc0M8vM1FSB0bC?=
 =?us-ascii?Q?N1+GbeR5okp+yJq9WfaMGHBwC97yWsrFPyqVUGyOwuIKiyeQYe/6dpyMuyzm?=
 =?us-ascii?Q?FNgBagyHEhFEzrcVSIXX4dg05voKzNT0VDiU1tQ37VqJsXOU9GtqT0fAhQ3k?=
 =?us-ascii?Q?SYyBy0zSXFgEYpO98jkBv2UTe3d7Xw+7nc1wp+8Z72/ZHBSQLG8TN8i6TkBA?=
 =?us-ascii?Q?t3uNBPvkLc+sg5UEqw3I/PqVH5F97UY0yiIdz6koAWrPR7AMIDM2CfBQhL6Z?=
 =?us-ascii?Q?62dZvyXJDUzzYVWpUz7tk/Xu6zVL8nNG39QhM8fEGulbh3Dqh0mY2PtdznZM?=
 =?us-ascii?Q?OiQOGzA5gKjucm62mEseYCHclKVQALtsFIXASRoPczruAbx5rT1WUY4iWSuB?=
 =?us-ascii?Q?Z2faDA3pBCfL2LAglz3EfWjsQ0U5a+ozvpU4Q3NvEuKAwGsEYEiL3+xBlTBC?=
 =?us-ascii?Q?mKHsgPGc3h7H8ri85if/g9lBb2RC4EWnYZqoFt1youtdlw4MNKGDq6dabMdn?=
 =?us-ascii?Q?xJ+j+XNpXh3hsBdsaqfR1IvdtKwn0OdTwMlkbc2AuGT2KVTTb732cDJ+SN94?=
 =?us-ascii?Q?ilOOEFe9GojH9hrYDUwSjfZofp57Nzs+wdElRg0gkl4eRSUO5jKFN1mSu8eQ?=
 =?us-ascii?Q?6F1OBGv9E3a+8tqMR4J+IRAmJOU/LEv0/wNYHhta7XAWWniYja0/VeThY4Ov?=
 =?us-ascii?Q?uAUkTl9vuj/xnTZjyytb8lK1fv+Cm2etQ10defflhFAHwp0cvAmxTovyzWFi?=
 =?us-ascii?Q?q+kccH8xQ4C84FyolurBdnfvIsOyrVW9+SsYdCHg/XnknM2oOtx+KWVgRm5+?=
 =?us-ascii?Q?ZpiP+2RSezbe91H+hf1boCdGKBYWrqdecwU6zDsNOawXfWOYbb+jlmrym/iF?=
 =?us-ascii?Q?8FVUPw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a4d17a3-6451-451b-0a3f-08d9b9bb1a94
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2021 19:52:30.7442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OExLJbt70FcJn7PATrNjeAyb+lUPPjdz7nen23xXbufcQFJpmHhwFUaiL31XtGKV3isz64TYc/WXQT2XbBwLhnEG8Os8fKyIFKJas4WvJk0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5750
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10191 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112070124
X-Proofpoint-ORIG-GUID: 1RNHSfk8bPVOwDypJ23foxXvQ4SeKJoq
X-Proofpoint-GUID: 1RNHSfk8bPVOwDypJ23foxXvQ4SeKJoq
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two important changes to note:

The kexec_calculate_store_digests() changed to specifically EXCLUDE
the elfcorehdr segment from its list of segments to check.
This is an important change as it allows, in a hotplug environment,
for the elfcorehdr segment (which contains the list of CPUs and
memory regions) to change dynamically without the need to update
purgatory (with the hash/digests of the segments it checks) as well.

The crash_prepare_elf64_headers() changed to look for the offline'd
CPU and exclude it. This due to the fact that the offline'd CPU is
still in the for_each_present_cpu() list at this point in time on
the cpu hotplug handler path.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
---
 kernel/kexec_file.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 8347fc158d2b..339995d42169 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -765,6 +765,12 @@ static int kexec_calculate_store_digests(struct kimage *image)
 	for (j = i = 0; i < image->nr_segments; i++) {
 		struct kexec_segment *ksegment;
 
+#ifdef CONFIG_CRASH_HOTPLUG
+		/* This segment excluded to allow future changes via hotplug */
+		if (image->elf_index_valid && (j == image->elf_index))
+			continue;
+#endif
+
 		ksegment = &image->segment[i];
 		/*
 		 * Skip purgatory as it will be modified once we put digest
@@ -1260,8 +1266,8 @@ int crash_exclude_mem_range(struct crash_mem *mem,
 	return 0;
 }
 
-int crash_prepare_elf64_headers(struct crash_mem *mem, int kernel_map,
-			  void **addr, unsigned long *sz)
+int crash_prepare_elf64_headers(struct kimage *image, struct crash_mem *mem,
+	int kernel_map, void **addr, unsigned long *sz)
 {
 	Elf64_Ehdr *ehdr;
 	Elf64_Phdr *phdr;
@@ -1308,6 +1314,11 @@ int crash_prepare_elf64_headers(struct crash_mem *mem, int kernel_map,
 
 	/* Prepare one phdr of type PT_NOTE for each present CPU */
 	for_each_present_cpu(cpu) {
+#ifdef CONFIG_CRASH_HOTPLUG
+		/* Skip the soon-to-be offlined cpu */
+		if (image->hotplug_event && (cpu == image->offlinecpu))
+			continue;
+#endif
 		phdr->p_type = PT_NOTE;
 		notes_addr = per_cpu_ptr_to_phys(per_cpu_ptr(crash_notes, cpu));
 		phdr->p_offset = phdr->p_paddr = notes_addr;
-- 
2.27.0

