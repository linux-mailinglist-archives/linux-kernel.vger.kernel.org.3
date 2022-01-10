Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEF3248A094
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 20:58:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245365AbiAJT60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 14:58:26 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:25516 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245063AbiAJT6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 14:58:20 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20AJm5i7026301;
        Mon, 10 Jan 2022 19:58:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=kaWYFH0urKPFOrOiQHfoJph8AW1cJGi/yRevqR8ldI4=;
 b=FBgryBSH/9tp9fxTNlvBRMwcWQ7V8wuAwqQdwklH7SonLGDxa84rP1M4BDzWEnaMqbqQ
 /p1blkAmsIdjAPpFvWlTaAD+PdG4f/rq1K+BOyVBbO+8bx+RtgHK4D+k1O+dn4UOdKF/
 d1MKVFvtQtAGJT0hDD+G05tx+ATLcolcM2GzFb5t4PBeNRZbp1KwOvno8H4U88y93qEm
 ui8pwKYVdTc/DPdnqU/G7zQtyRPzO2fbLvg/0B8em3i1AFNbl6CMWSbV/pfEk9fHPpXT
 7sAU3IIw5BzpXy2fBbBAM6Ibz4RGOzDbLT9bDQ06hurd5ffzQn/cXU1EIZ8mkMJLUhos YQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dgp7nh0sc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jan 2022 19:58:02 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20AJtZ23014331;
        Mon, 10 Jan 2022 19:58:01 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
        by userp3020.oracle.com with ESMTP id 3df42kfwbq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jan 2022 19:58:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IlNHypxYTLFDKL4oMKaOaMwNAtzU4xfVlU2lhdF3t+gpK/MiVEGH25kP42+cudX5sw9R0EAjD23HRAs05irTxEQOakLyCDdGGOx7lIDdaD8P3uadjjrAW3++++2fXcYb70eBSc+RWdfzRfOUUnZWLg0Z1nqypisswzMXcfhRftsg1yySXn4NTfCy7sX/TJonp7NWuyrmdoyMqfUkSt7ItHaW8cnIkPJqTom6FBm76y9Z1ONHi7DBl6rVgq5zjIGWacHjh00iaLG+MF8J6K1bcEGtVisSRDKn96t0xdoupAFt0qGvGmBj9kRaFOxSCpNxzKXwdOq2A5nmKzayapRsEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kaWYFH0urKPFOrOiQHfoJph8AW1cJGi/yRevqR8ldI4=;
 b=kIAC+H6yFzYXp60kyj1euyGuHNNJCMyfO2Hdlj7q8lS2LwApcXJcPp4bMgH2rtsB7PUcIublsFdxDGProPhTBVkk68FS9AuK/2Ip41HjzlFEBhpA400q1nlVrrRMokSOw4cqKummQOHJanZsM2KJNdHfp/XVWhYPnVO62y1dvF2HZ+d5BBjneA/5DRRVCVfLWw//EwadpxaiG9bdzPRNRTae8I7d0xMv74t5UpOCU00lC+IFnPKB8jGPHNzDH9uNlpB8scZixpmixqQcwb923TKQOIDPB8atQECkTIh7EE/HIn/uhXhujTbhllQ4+D0rGRWjv7F1Mv32zkt0FQw/5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kaWYFH0urKPFOrOiQHfoJph8AW1cJGi/yRevqR8ldI4=;
 b=tprNLMMWexZej1Bw7l4XXQS9hP0IYyzZr0xULDraEcSPp0V0YEawmyJqb7/BwI2M+mFcldjXI4XZWyhyzMmfJ5DLpgq0AF7Z2cTBTCByPjV8OPPQUbaqx4jtRD4idZ5BEa7FXNqxh5nuWKsp6OdB3b4kHDIX2UKV+vMYnjXWGAA=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by MW4PR10MB5701.namprd10.prod.outlook.com (2603:10b6:303:18b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.10; Mon, 10 Jan
 2022 19:57:58 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::d573:6cc0:c616:6f2c]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::d573:6cc0:c616:6f2c%6]) with mapi id 15.20.4867.012; Mon, 10 Jan 2022
 19:57:57 +0000
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
Subject: [PATCH v3 5/6] crash hp: kexec_file changes for crash hotplug support
Date:   Mon, 10 Jan 2022 14:57:26 -0500
Message-Id: <20220110195727.1682-6-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220110195727.1682-1-eric.devolder@oracle.com>
References: <20220110195727.1682-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0149.namprd11.prod.outlook.com
 (2603:10b6:806:131::34) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9d25a1e9-7f36-42e9-0a57-08d9d4737f01
X-MS-TrafficTypeDiagnostic: MW4PR10MB5701:EE_
X-Microsoft-Antispam-PRVS: <MW4PR10MB5701772610FA0AD1EECC376197509@MW4PR10MB5701.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OTAbYkqv7hQyuFrcpmNyFdUbP30eD8LzCJzVWlU7Bo2Qowl3L7KparXz3yerjFJtWk2hxHiVXMwt+GGhvwqmlVJRdXx5cNuipz/UvxnWzw8jZZgbTdvrzXI8IuMoAE1E8Oa/snoYnDZgXhL2hyv7hYEBr0Xcu5IBJQkYlu9wcPQey+NX7wUaDYZlPQfzHVig8Hp+709PgaXRt0iwfCxnNfFOY4Lk6t8uDFvDLX0gJ3A0ETpFdbNe+RVqzgN2wRxffKJPO0LgNCJ4IRfZlLycHWK7+VvfscQNfEpKBPdIg/kkL8t1vqd9cDhqFysri2Brq/BBJWhS8UQBguM47MlLITwu0WJtxlrS0lidk6pS+SRtMW+mLadXIq+MSWkIILB9mJ+FTNpElePxgxhUP5laSK+02P17wbAnjoOLEO7Dxq/D5A9E7cKzHx6qg9puHOGBtMe+J9sA9/PdlT+5lafSQ143BLClQJsLgl1tWYfmws/vUMCLFsGDD0pf1hxMjClYc0gE2zANzTQlRZ6gpbWqow0SDrVxMa0S2WKKUMGVCdk4osW3qDIvuTWLKgHvuEIvXEPHMzhgNJ4O2qsYRSyHM9+apjvcjUJq+S49gyavjt6Ww5fJIV4GvQ8UvyD0CNUElo4EQ+/huTATeZj9mF+K0Ghmo2m3RYHerKKwA69S7xdGh0bLVsDNGauB9nqqhZrUNSF50ydZWolXb864Xo1z8Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(86362001)(66946007)(66476007)(5660300002)(36756003)(2906002)(8676002)(6512007)(52116002)(8936002)(6506007)(4326008)(26005)(508600001)(1076003)(66556008)(6486002)(38100700002)(107886003)(38350700002)(186003)(316002)(7416002)(6666004)(83380400001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZeK0Z8AZz/3nJcY/iacB2Vu5UiItHNbkndi2bBMuRFylrOPKk5dNehk1ylb6?=
 =?us-ascii?Q?8xXzDAfFuf2Fz1c6SsVwxr1yRCp6h6WLwngZycccPeFMc2oQAyUwZ5d84+du?=
 =?us-ascii?Q?k2UIuBNTf7jkAM3xTw/JsyVF8Lfi41orXZwD/nTL9dsbUeWyPD+FzxZJegux?=
 =?us-ascii?Q?dWpmcu/ur1xr255nMZe10tjm0laloPim2wyKFiUIu2Atk5T0kokqXFrKRZBO?=
 =?us-ascii?Q?/HQYnUrlF3jvSlqsqNQMGz8kDs49C2O6AooOyillHGy33lEopTcAdE1QKdkF?=
 =?us-ascii?Q?Xtrhd8kBAs4n+KU4gSiWWFa5+4gYkmyzWS/aqvQwb0D69C/02VYGB2ftKf8M?=
 =?us-ascii?Q?QD3kwrrIhFHSCsMjzdNObSqEunuzcSP1vxZqDimQihtLUh/ztIZZxjYPJBRz?=
 =?us-ascii?Q?XdWsQsfDtOwXv5y+TGYH8E0ENtRlR/QdJv14wHxfVjdvMsjWG2y3Gfcr5kzI?=
 =?us-ascii?Q?rQfg1lI8vb9fc5pmaPY5EbcliSywuYNlyzkKuI9F1eEES2h1xGW0EefHNfli?=
 =?us-ascii?Q?5IZVXYTBffJ4pu4c6dOKfBv1aAYsV6cnDj66aAnVObgDci+uX7ZB+xi7PKoC?=
 =?us-ascii?Q?kVrEYvYTCFovEDcWFOuhRAtKWLeLy/5GxRI8JyYTclRLsjhzGfMuuXUvtTBm?=
 =?us-ascii?Q?9M2KpHbTy0F5W3Spwe7APrtnWudptkqd878CpGi8H5+t1XvJWrmXPfqnZHWf?=
 =?us-ascii?Q?hE16nexMcYXLowpEy3BP5rmHq/OYJ8uucUxsCjrYexuracwQGa/PWYJRHJGC?=
 =?us-ascii?Q?q4nifTS1G37zbIF0ULjhoT73+MzkrraQnVdClr6RvvHDv+cnrJvE3Eo4klY1?=
 =?us-ascii?Q?JmEgxmkQ7Kr2rejxjO5NibfJ6ehiTA283DiEYGAbDJ+pUJdesH4iebcf0/Uq?=
 =?us-ascii?Q?ZFDI19afTz5ZXK1v03nJFVU8adHSv3Ke00y+ebQsz5RYnD4/0SGnt6QwvHDj?=
 =?us-ascii?Q?USbFNG78ym6jpR+JehRgrnjtcWTha3gwO5Ec7HXGLfRN93QcJ+XnOqxHVQcH?=
 =?us-ascii?Q?hvEpEQ13Ot5S/UJ4uq66Yo6Mi/AvnsTR4uaU9MHXuYVwSPOUji2q41vX+BfQ?=
 =?us-ascii?Q?HL1HURKPApxnSthymuaotowQaMx7jhHo+wFYjtSh+rqjXUxnsR7JHD3v2dBF?=
 =?us-ascii?Q?klABG1Vwy1Z5S9ILtjKnjGP6v5S5ML69pAhA/o2pnDo+W/7v1rD8cLJWfjek?=
 =?us-ascii?Q?EjleR1dGhNGk5VKaqI79V74DBNaecMEGc+u/kp7hbLasOx0ER4r3Wngf++dN?=
 =?us-ascii?Q?PH/Bu9v1llBJgvGXejb+wbLpfHeCJqHKJYP3rgjkcORdCPHAOi6x6pXJIVqo?=
 =?us-ascii?Q?PUmBW+fJmhWVmu6c7qL6xV/6aHly9RTWIqD9SjytHbwN0tZ5EGdu4kUOIXl7?=
 =?us-ascii?Q?Gd2ma+uqUMmUbcYqiGHlMqymic+zrXwXJs/hKqKxPjGc9JlWKW5brnqKGMpu?=
 =?us-ascii?Q?eni/2xxHYYEOWgN/TFCJ4dLmNQW+9dxFIt2gkaJGCT+TsbiuI+NiCk7OL04U?=
 =?us-ascii?Q?uD7z/nymARp/2b0q/dRvIuvakBpbQ3oRU0vbI7rlapZkbwd88a9SDg0bb9Oo?=
 =?us-ascii?Q?Td8pH/hx30yAt21WBKV3E0WXwuZZDuUekIG1xmvZlkZQCHaXdYxFcsEbr9vf?=
 =?us-ascii?Q?5VZLeDQFTlnT10qKAyhl+W1Pb6WXscxHt1s69X64eGMfTSERyyVLq5+SheNQ?=
 =?us-ascii?Q?4rl5fw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d25a1e9-7f36-42e9-0a57-08d9d4737f01
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2022 19:57:56.8925
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /oochbNlnC78xit7DG91KpJ1MzPzjyevwFC+6BYnq5fvuz8Zk3amGX8p56FYajTR78pcDuHaI2chsqIN+mTG2hnkMuI0CZzbT0gHIYLMdSs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5701
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10223 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201100136
X-Proofpoint-GUID: FnuLXuzcaT08lyDebYow9zsC58JHNlp6
X-Proofpoint-ORIG-GUID: FnuLXuzcaT08lyDebYow9zsC58JHNlp6
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

