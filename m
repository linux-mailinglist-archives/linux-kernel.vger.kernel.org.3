Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F41C48A096
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 20:58:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245235AbiAJT6c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 14:58:32 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:15008 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245263AbiAJT6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 14:58:24 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20AJlh6g007277;
        Mon, 10 Jan 2022 19:58:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=rytwSaytB2+YLfi4PwlydBUtV91SCy5lZa18VFpTkR4=;
 b=hA/frL/fBtepFb/pujm48TW1aw+cWmgBW8n0OdvGaC6xSR4btFyoKGv19JbyY01uciM+
 kYF/N4IXgwXE0l2t96tVc8mLE9sVSbEL9CgQaXlZ/AVHLFIwK/gPhxROHTaz+Ofy0lYj
 6ynT6BHMbEfqGsWgRWN5ImOt8qLnT2LGINLKkTrKlcciPR9oCvxbfL9XusUKThUnE5id
 OT7Uic9D2ONACHyFQhNkfeNmyc7EE4014hLrQLbojnzon5B/zExkYqQ3wBksp1TyVuPo
 bfdJalxudBHAvUySnYPW2eTuITpNKs4Gpqaz3CfwwxcZ9WHE+DKy4/rTKU2rhk249855 Uw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dgkhx1b78-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jan 2022 19:58:03 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20AJtZ24014331;
        Mon, 10 Jan 2022 19:58:02 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
        by userp3020.oracle.com with ESMTP id 3df42kfwbq-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jan 2022 19:58:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RiF+iaB8ObQIz5J+wN3UpjguGybCUxQC3mnF3io8szISE5zcoOpgAoC6hnjflXdfAPzwoz5oMg5xpWztwAxPyH79mcDTa0UqtIdFpcTnN87TEtuWKAr3Zj8qAL7LUPKsS21Oe5FBrAJLUMU3PvNTOrZH+PiQLY6o8q/KL4TtNk1NOQkNM4/cAuxcoyx68A/4XCt1zwyR4X/f3cl5DAgTorNAbYlg1dceJCy+E2+3IGuvpoqg9zGwjzBMxdDdMnm2qkisMo9/VEU7Eo4xOSZBKUaSZs7klghQEKaZHLrfYWRt7ZDWWAIETJNYterGFE22aVUX14LWaUBSNK+MbyCdZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rytwSaytB2+YLfi4PwlydBUtV91SCy5lZa18VFpTkR4=;
 b=e/GfMjvB7eC6YHq0WsqPg3XehF5SZMeiJCVieTFiQNFPKOBVNySRptssmZrxVIA8kXoy9uBr7z3Kgeu2eswfmFJIRdsiOvvwt4EWeitQZ3tPc7Co+HJvxTrMHYMHoEXuocEM/w+gfGcI9I8VcQAcIQ2/U9vfZS83vOKKUq6WW2Pi23/sCeoIQSNN2giLLJN/Y6skKe5r7Fp+X71iCrSTiah6uKxFBPFEaL2jawMqt7NLcIlmePzXVWkNlq/xrQkStvzNpiTqtW0PbTA2y+pFdsG2rxyhUgdyD63AUJ5EJdN6MXVQJJCYDis8RqMEVL3cLJ70QT1cuX+WLMMVCBH9wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rytwSaytB2+YLfi4PwlydBUtV91SCy5lZa18VFpTkR4=;
 b=izqmgS/TIoHdkkhZxnKWNT+jpW5dI1YvDLCS1/PWOhBsEVy4Cts8ZB6jB1SEZ/bLgYcpzzRzzpV/Mwxi2Fzqij1ksEnnwJnWIgYV2wvwfBe8qNrcHc7J+0eGwpUDmWWwq3bIQ7fmoIm7L/2pkwn0HyBzdkToAqDNVm9dwWoueM4=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by MW4PR10MB5701.namprd10.prod.outlook.com (2603:10b6:303:18b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.10; Mon, 10 Jan
 2022 19:57:59 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::d573:6cc0:c616:6f2c]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::d573:6cc0:c616:6f2c%6]) with mapi id 15.20.4867.012; Mon, 10 Jan 2022
 19:57:59 +0000
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
Subject: [PATCH v3 6/6] crash hp: Add x86 crash hotplug support
Date:   Mon, 10 Jan 2022 14:57:27 -0500
Message-Id: <20220110195727.1682-7-eric.devolder@oracle.com>
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
X-MS-Office365-Filtering-Correlation-Id: f0be0007-5d52-49f5-131a-08d9d4738081
X-MS-TrafficTypeDiagnostic: MW4PR10MB5701:EE_
X-Microsoft-Antispam-PRVS: <MW4PR10MB570163F1F170D4667F67F12697509@MW4PR10MB5701.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3nTMCjjnyqWSyIKa3P66DT8SnjYdvC3fyQ05XsGmTW3mZDnB6Rgb9W/dBlv8UFoh4AbN7WeRSnJUK0zVkabwmOECKa3M9P3BmA/PTMMJFmf/TEJA6I7mcbf/6e515X96dklrlIU0/2pDgjHgeKG3P/UvONhf5+r8BGpdY6b9jum9iScYLznkQjJkYtla0TuK8+r1cX1qw/64fksOgwHsil9GsZ+nA4SI/qBOZT0W8FvKhYIPzP36K/MeprRiTX1P3WQFAMcgNyRUf867TGI2m1y6lWZZX5xgCoLvuB+93F1JTOD7Dp7GkiMOPEZ2mmdFlWDk2R5Ou02LBpPBGYfa2wI8S5+es+I1WIFMqHSnm8LmTXDPXeNKeg+L4urPtjchCTjRuXsv+Z2gLHqN60IEtYta8xq8rygcHEQBYROZMR0Ot4PlhVF1g01oUCWKGmPxRpABWJ9cFAV9vHh46YRYBlz+Xg0KgMi//88rtLBPoci8mUHtR7E+jdK+qSauCmpY1dcGgK9Up0ZIzjwqapljoglXRzBQqcAZQ/ZaOose38/9wTd23hyjOo/d2BRn1qF7czC2454jL+ChqTCd4zo9AZLX/E2+x1hE3Cpew6591VeuuFKbCPAfk0bN2xRsXza9jasz+nASUL48bmyqKC+Nig31nhZqspNs1zXyqTyHw6vnPffTzk7hZyKXDoTYdV5OtY7GVIJ0/1uZtdcrdYhbAw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(86362001)(66946007)(66476007)(5660300002)(36756003)(2906002)(8676002)(6512007)(52116002)(8936002)(6506007)(4326008)(26005)(508600001)(1076003)(66556008)(6486002)(38100700002)(107886003)(38350700002)(186003)(316002)(7416002)(6666004)(83380400001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UWVZCBEB6cKL0HfB64F6q6NVGeoUTISt+LIJFjSn0Y7/oSTRF1+ExixC7lf6?=
 =?us-ascii?Q?ZdaK9TRb+PyjxvBCxWBQYx9xRw2snz5Nd1iV6g6wcmx2aAQA2ZHHhcvo3C2D?=
 =?us-ascii?Q?d6DXanEFfSXmzG8RaiKIAP3UzzFAFS3KDiAMwixru48xrAx2nkqqd4vxEVX3?=
 =?us-ascii?Q?k6DCqs2k2ger27Hsqg1+qrFFAY0pBfE9VAt/78tJBUVsYf5lSj+eqceO7GqR?=
 =?us-ascii?Q?sH+SltH8kS4nHnH5Uv3lKMuav7xq7O15msib+vi5e+GaER22owda7unpCCjY?=
 =?us-ascii?Q?bfYkeGBCI/I2UG+9NMhoOD1a/2HUhh0DWnnLuc9I7ltmzUwW0P9sq3m5KDlb?=
 =?us-ascii?Q?3JdLizU93yqj8/HRn7f2HFxEnblbQVxJnyg3AoZcAHc2uvQ63kQi8NNvGmu9?=
 =?us-ascii?Q?CtYjTy2ZwhsZmByUzHTMHHlf9XYmz4EyCDHkgGGErSuHAVtdGvpz4JMTTuFC?=
 =?us-ascii?Q?pdAymMcbUHJ6DsODW//AEXQtEX+JoJYB0IoTnGX6mBBtkYYDYy8b78gB0Rc1?=
 =?us-ascii?Q?Uw5L3SLKgNmaBb9EzHBBUOd6vBv0qdT/EVkguC7+D3PXUhyRsr5T7RuKI2nu?=
 =?us-ascii?Q?glnF0IziMf8mudUujSMD7mmYDiHHCa71RwoNNZEWMTuLjzPBgRKW1+zqw8hR?=
 =?us-ascii?Q?YKIeHFyplEcuT300BVzvTwqe3n4zjEKCUURrYFjnj7zJGUy4obMovipX0jyx?=
 =?us-ascii?Q?kwiU6QBjLnKsSlz6ICs1D4FOM2UPNjk0XdjGznUFV4hnSxYnLjEkUGgII787?=
 =?us-ascii?Q?Z9rVwwyGxiLRZxFLDy+PO1fm+o4Hn+y8uQY2hJ9Zzm7t6VPbqKJgs08aalXS?=
 =?us-ascii?Q?fEjrQhpbr3SMF370Mn77ucVHz2wksFlJr40+uq3AjI8J/gHXU1p8CRSyuGKp?=
 =?us-ascii?Q?6GJ450wmMelGvHiXyedYdvc2wO3z2o4YuW665zaqdScoInuYR/1a1GG9x8mp?=
 =?us-ascii?Q?bnKAthTmnWqF9ecLNfPKXaeGqANXHJJiyY6jrvUTaNO+isUqTC9bIXcdw4WS?=
 =?us-ascii?Q?3WHEj0CFh3FqCfjgQn76oQ+sizTlcQk1Ja9TO9+UlJjjfO70Bs7U9mH9e2Rs?=
 =?us-ascii?Q?73vbDmNLp3c0mPFwIgan/CDqfRQevyeS5BkrgzONAEz2RRCMoQ8SQQ0qgr7H?=
 =?us-ascii?Q?5/RwfncKrEsUWrFPH2diAi9RNtDXD7Kwp4+eHapay45Vd6nWFcI+VfkC/q2g?=
 =?us-ascii?Q?qe4CJXwto5A7kI+g0B/2+KYmdD6VAkHF9qg4lsWEm2TXCdDji/krzs8bV9ek?=
 =?us-ascii?Q?2ZFsdoQuvpxDDLhHb2SR294D/c5wLlzwDDn38jJ8SMMVRIyw7yaA1mAWb3e2?=
 =?us-ascii?Q?P4W+BF5arsTaizd5rqzAWxOBACesSLYCH22Aatcz+8ubbxjGZ6sxz3PcgUFQ?=
 =?us-ascii?Q?SyhSQ2nifv1B+W3iVRujeea7sRax7iqE5fHXzKhmuoqOQ6SD/SxYevWAJtgD?=
 =?us-ascii?Q?Fs7zeG2/ur3dLvSxwD+8MT5HXGObF79zeoM+lhXMq/hpOsg3mOaD1WYUtqLc?=
 =?us-ascii?Q?ADDrZ0sqObcVEdz8ukmwJhG7FYC0j8qH4S5mj0kYYlrQMcVYhtB66ygSf9kX?=
 =?us-ascii?Q?a5b4+uY8T8p943ZhhkX07HTwLRc0pUZtDiK7/SuUdvX4dkDs+JFDd+ZdJwm4?=
 =?us-ascii?Q?mY2q6Sk0qFtSqQw2WnRn3S5CbpopDHpQTadiXVdFEM1/6r0f8Do/r1v1uh6g?=
 =?us-ascii?Q?XTvemQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0be0007-5d52-49f5-131a-08d9d4738081
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2022 19:57:59.3936
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U5JVfGVGl0188k1o18G32++TX6fUGywYrBWhRArHq2TgtrQ+r3IiGVZyj6VtNUtp930HFZMV55v3YPrLdZnjONB3Pv39Yti5dk/MGoRwhV4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5701
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10223 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201100136
X-Proofpoint-GUID: kIYrDzGWkBb4-0duCrirXw-OWRDqU4LK
X-Proofpoint-ORIG-GUID: kIYrDzGWkBb4-0duCrirXw-OWRDqU4LK
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For x86_64, when CPU or memory is hot un/plugged, the crash
elfcorehdr, which describes the CPUs and memory in the system,
must also be updated.

To update the elfcorehdr for x86_64, a new elfcorehdr must be
generated from the available CPUs and memory. The new elfcorehdr
is prepared into a buffer, and if no errors occur, it is
installed over the top of the existing elfcorehdr.

In the patch 'crash hp: kexec_file changes for crash hotplug support'
the need to update purgatory due to the change in elfcorehdr was
eliminated.  As a result, no changes to purgatory or boot_params
(as the elfcorehdr= kernel command line parameter pointer
remains unchanged and correct) are needed, just elfcorehdr.

To accommodate a growing number of resources via hotplug, the
elfcorehdr segment must be sufficiently large enough to accommodate
changes, see the CRASH_HOTPLUG_ELFCOREHDR_SZ configure item.

NOTE that this supports both kexec_load and kexec_file_load. Support
for kexec_load is made possible by identifying the elfcorehdr segment
at load time and updating it as previously described. However, it is
the responsibility of the userspace kexec utility to ensure that:
 - the elfcorehdr segment is sufficiently large enough to accommodate
   hotplug changes, ala CRASH_HOTPLUG_ELFCOREHDR_SZ.
 - provides a purgatory that excludes the elfcorehdr from its list of
   run-time segments to check.
These changes to the userspace kexec utility are not yet available.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
---
 arch/x86/kernel/crash.c | 138 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 137 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index 9730c88530fc..d185137b33d4 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -25,6 +25,7 @@
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/memblock.h>
+#include <linux/highmem.h>
 
 #include <asm/processor.h>
 #include <asm/hardirq.h>
@@ -265,7 +266,8 @@ static int prepare_elf_headers(struct kimage *image, void **addr,
 		goto out;
 
 	/* By default prepare 64bit headers */
-	ret =  crash_prepare_elf64_headers(cmem, IS_ENABLED(CONFIG_X86_64), addr, sz);
+	ret =  crash_prepare_elf64_headers(image, cmem,
+				IS_ENABLED(CONFIG_X86_64), addr, sz);
 
 out:
 	vfree(cmem);
@@ -397,7 +399,17 @@ int crash_load_segments(struct kimage *image)
 	image->elf_headers = kbuf.buffer;
 	image->elf_headers_sz = kbuf.bufsz;
 
+#ifdef CONFIG_CRASH_HOTPLUG
+	/* Ensure elfcorehdr segment large enough for hotplug changes */
+	kbuf.memsz = CONFIG_CRASH_HOTPLUG_ELFCOREHDR_SZ;
+	/* For marking as usable to crash kernel */
+	image->elf_headers_sz = kbuf.memsz;
+	/* Record the index of the elfcorehdr segment */
+	image->elf_index = image->nr_segments;
+	image->elf_index_valid = true;
+#else
 	kbuf.memsz = kbuf.bufsz;
+#endif
 	kbuf.buf_align = ELF_CORE_HEADER_ALIGN;
 	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
 	ret = kexec_add_buffer(&kbuf);
@@ -412,3 +424,127 @@ int crash_load_segments(struct kimage *image)
 	return ret;
 }
 #endif /* CONFIG_KEXEC_FILE */
+
+#ifdef CONFIG_CRASH_HOTPLUG
+void *map_crash_pages(unsigned long paddr, unsigned long size)
+{
+	/*
+	 * NOTE: The addresses and sizes passed to this routine have
+	 * already been fully aligned on page boundaries. There is no
+	 * need for massaging the address or size.
+	 */
+	void *ptr = NULL;
+
+	/* NOTE: requires arch_kexec_[un]protect_crashkres() for write access */
+	if (size > 0) {
+		struct page *page = pfn_to_page(paddr >> PAGE_SHIFT);
+
+		ptr = kmap(page);
+	}
+
+	return ptr;
+}
+
+void unmap_crash_pages(void **ptr)
+{
+	if (ptr) {
+		if (*ptr)
+			kunmap(*ptr);
+		*ptr = NULL;
+	}
+}
+
+void arch_crash_hotplug_handler(struct kimage *image,
+	unsigned int hp_action, unsigned long a, unsigned long b)
+{
+	/*
+	 * To accurately reflect hot un/plug changes, the elfcorehdr (which
+	 * is passed to the crash kernel via the elfcorehdr= parameter)
+	 * must be updated with the new list of CPUs and memories. The new
+	 * elfcorehdr is prepared in a kernel buffer, and if no errors,
+	 * then it is written on top of the existing/old elfcorehdr.
+	 *
+	 * Due to the change to the elfcorehdr, purgatory must explicitly
+	 * exclude the elfcorehdr from the list of segments it checks.
+	 */
+	struct kexec_segment *ksegment;
+	unsigned char *ptr = NULL;
+	unsigned long elfsz = 0;
+	void *elfbuf = NULL;
+	unsigned long mem, memsz;
+	unsigned int n;
+
+	/*
+	 * When the struct kimage is alloced, it is wiped to zero, so
+	 * the elf_index_valid defaults to false. It is set on the
+	 * kexec_file_load path, or here for kexec_load.
+	 */
+	if (!image->elf_index_valid) {
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
+	/* Must have valid elfcorehdr index */
+	if (!image->elf_index_valid) {
+		pr_err("crash hp: unable to locate elfcorehdr segment");
+		goto out;
+	}
+
+	/*
+	 * Create the new elfcorehdr reflecting the changes to CPU and/or
+	 * memory resources. The elfcorehdr segment memsz must be
+	 * sufficiently large to accommodate increases due to hotplug
+	 * activity. See CRASH_HOTPLUG_ELFCOREHDR_SZ.
+	 */
+	if (prepare_elf_headers(image, &elfbuf, &elfsz)) {
+		pr_err("crash hp: unable to prepare elfcore headers");
+		goto out;
+	}
+	ksegment = &image->segment[image->elf_index];
+	memsz = ksegment->memsz;
+	if (elfsz > memsz) {
+		pr_err("crash hp: update elfcorehdr elfsz %lu > memsz %lu",
+			elfsz, memsz);
+		goto out;
+	}
+
+	/*
+	 * At this point, we are all but assured of success.
+	 * Copy new elfcorehdr into destination.
+	 */
+	ksegment = &image->segment[image->elf_index];
+	mem = ksegment->mem;
+	memsz = ksegment->memsz;
+	ptr = map_crash_pages(mem, memsz);
+	if (ptr) {
+		/* Temporarily invalidate the crash image while it is replaced */
+		xchg(&kexec_crash_image, NULL);
+		/* Write the new elfcorehdr into memory */
+		memcpy((void *)ptr, elfbuf, elfsz);
+		/* The crash image is now valid once again */
+		xchg(&kexec_crash_image, image);
+	}
+	unmap_crash_pages((void **)&ptr);
+	pr_debug("crash hp: re-loaded elfcorehdr at 0x%lx\n", mem);
+
+//FIX??? somekind of cache flush perhaps?
+
+out:
+	if (elfbuf)
+		vfree(elfbuf);
+}
+#endif /* CONFIG_CRASH_HOTPLUG */
-- 
2.27.0

