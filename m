Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 035DF46C407
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 20:53:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241115AbhLGT46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 14:56:58 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:41056 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240779AbhLGT4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 14:56:32 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B7I4cUq023471;
        Tue, 7 Dec 2021 19:52:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=rytwSaytB2+YLfi4PwlydBUtV91SCy5lZa18VFpTkR4=;
 b=FlNfCu5yJAtzu+nNQIU11hF90MBunMBT590PG1VSSIM2O5dsCDJEb3ixYaB1R9b/oBhC
 EPlfjbsQbwZ4v1NoKEgS63hA+vVcU9kCzMHKmGgsgGkbhfR7ZxQk9cYZpZXGEVU6kGhR
 mCG7drRzUnz8X60SEz2xN4qs3DDAnsRXpyS5XoqaujVZuZT5Zb8yzZKJHtUv3L86O4OM
 uGC0NgFD8xtpXav1pd4gBnruGQIF5RT0mhEpSDekXZQRwIXlR8445hmBneF2BT0c6rs6
 Ci0+zZBVqPqTn8wk0F5oKlOLPjhbcYysJX54zPzqPFR0hbK1gtSGWjSH1KuRwHLl8tCo JQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3csc72ee5m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Dec 2021 19:52:36 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B7JjGoK044961;
        Tue, 7 Dec 2021 19:52:35 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
        by aserp3030.oracle.com with ESMTP id 3csc4trbua-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Dec 2021 19:52:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kWZUV3q0kQdW8WADbzNdwbmK9P6J/xbWp+JaKzhLtyZJ8UpiFCQwVMG4ZpXbPiLUC4uYjqzDyxF62rxxrmfNsZmcIgICekYY8pVvjZE1LFBAcCTzE8opa35M0k3DW7H+EwA4jSSUTuL3pfY1TKsgNLDDc+pzckx74WK1W9PpJP0ts7jT9JoqpXytwYo6SxpU428Gom6Gpp+27xgI21tn3WVrzjSF1vVa2dJYSt0eNcdD4h75s3ryrKCwpNMTQgM8XngcvrCNsBbUltsoCuKShY+kp5jM9uB5U/Ype0rhxgNO/Hukm/7L2iRmchz8vM2jQrI8ybC2f9GjKJ0a6afLgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rytwSaytB2+YLfi4PwlydBUtV91SCy5lZa18VFpTkR4=;
 b=S5uzn0c2VuGtsO6gu97aCLI32mveGJ3cMv7g4ePS7rwFdO6/Yled4tM9PbDXMGv/Ry6ZVyroOmc7qvZ1aC4+nMKQDhb1Zzt1PFFEOjq62jdAJ7pvZ4ffBR0hcGSRx0sDfRiEh+yQXk2jN9Mnc4jH0Fm63vRVQvq/qYBxtecqqK5jO4dB2YupWMwPtnNnV7L3ISpUA//mMsBL35SqA5kTKa0sXaGQ0rLNMwttQsmmXwur4qiSSMnsxGt2SXWix8MD20CH6tqtlEmL43udx8ZvWbyVw1HiQJsb21K+KEzJdhXEj2xHumeqg44JKc0LKutHsJX779u8ydtYhZVwZnZX8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rytwSaytB2+YLfi4PwlydBUtV91SCy5lZa18VFpTkR4=;
 b=dXloYJQzgUSbupBw9knm8Vls3SfCtnN1ErKg4nIxgYS/tZcnOxikwU2y8P2UESlAG8fAzZKpUrK6Qrz0ygPO+f3/xPObdBiLMTi0R4VCzkYfqtzvxOF/9KnVoYt5/U4KOof8gS4J5wW8GrHw+gk8W8uKiHszoGi4qfalwLlA9Bc=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by MWHPR10MB1695.namprd10.prod.outlook.com (2603:10b6:301:7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Tue, 7 Dec
 2021 19:52:33 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::143c:ea64:7017:19f]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::143c:ea64:7017:19f%4]) with mapi id 15.20.4755.022; Tue, 7 Dec 2021
 19:52:33 +0000
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
Subject: [RFC v2 6/6] crash hp: Add x86 crash hotplug support
Date:   Tue,  7 Dec 2021 14:52:04 -0500
Message-Id: <20211207195204.1582-7-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211207195204.1582-1-eric.devolder@oracle.com>
References: <20211207195204.1582-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0210.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::35) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
Received: from localhost.localdomain (138.3.201.23) by SA0PR11CA0210.namprd11.prod.outlook.com (2603:10b6:806:1bc::35) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Tue, 7 Dec 2021 19:52:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 812ee938-b20b-4fdf-7b9c-08d9b9bb1c0a
X-MS-TrafficTypeDiagnostic: MWHPR10MB1695:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB169593BA4F12A0D86F3F1351976E9@MWHPR10MB1695.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rthVE9CeYarwfFc+TZYe7P1uRI7TgNt3Ae8tqvLho2qCOcSeGPdaB4jEzRytOXhweTEgWcT1agq0LeRMqYkjgvUieXbsiN57FBOygo++0JHVumdll4tifWfxirrWEWi2DkIW+FmMHkRVvUFqx6hcAaQaXEib1Rzn0U02BVL/hCKUsd8O3CfjddvSve2dO9jVpHmSaiTCn0nY03Pa8HBsNAggL4vG9dC8BYHlWLa9JQ2X2PoLFpX8OGUGFLycuANjq7rPiMpWlKPohCG8iblo6NBKlk0yyjMt9KC+2aFLh9qIJhvSDuPQnbByKAnJeSmAERGIc5XUMSg961NNvQukYUfEWB2E7hNXH1fGEYlA3CIJHw4DovurIh/Vq2HWpEYkSXrUd7rctBgL1k6Al1bOBhTMEywkwdb429v1rmXiDbNsxFaxjMfqo7aIITnyhi0AuznqdmsqDDZTd7GoaBNm6GAzhteEttahWAuP9QNjXT/xC9tSt4Zo6PeI1Ws1J9ZnK10/3AL3hF8BeO722OWWkRBiaCaUIBXQL35wTBlLy4bvJ3duYMPsxb2/OV0U/j9Pl/kHTimSvcPmDna1juL5/Ux3cfLAddOShbdEK6UGEOHd53V4xaD4YNUp1U59U3VX9zIcMyLwfk7EoJAhhel2zLmk/QwY5SJo+Mzw4V2zq7JbfslDSJRdDcZZjAVP+zflGLnGW1tYbXhnEpe728+boA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(316002)(508600001)(7416002)(6486002)(36756003)(4326008)(6512007)(6506007)(8936002)(66556008)(38100700002)(2616005)(52116002)(38350700002)(26005)(186003)(6666004)(2906002)(86362001)(956004)(107886003)(66476007)(5660300002)(66946007)(1076003)(83380400001)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QerpKLdCKpoTBzPhZ967CX6up2eOaUSZdt422ULtD4xpkB80S7L9DwS5LOEi?=
 =?us-ascii?Q?uqEqVkPYuqfCQgO6YriSSUxk3w19Dt1IWWE/GX8zW/gPiqykn4h4+WDlAbqO?=
 =?us-ascii?Q?/CbztHslzakE1iU+CX/ZOCdxqyD4yJwOfzG57EZG1SZW4qYktan+r6OLA+NW?=
 =?us-ascii?Q?V7w+9Sl3dtzQ65dg75QJlMgp8rCSniHD8ds9I/2KEz1Mf2uipymOtUO6mwc4?=
 =?us-ascii?Q?+h0TrQmGLlReqac5d6UZAgq/5K1Rhl4yh1ZridmVp2EDWpEKECNQbpnO6oeO?=
 =?us-ascii?Q?vqhi5O202JxWr2ExRqdLcW9EEItqmc3DAk4lgYQfpSDI1+lSJxs7Na2MGGmR?=
 =?us-ascii?Q?EiaQWncRHIhMBEhwsilgdnsBRDDPv1Y/Kw7w7z9ut1c7/3GzX6riYTVLoZty?=
 =?us-ascii?Q?+7N93VBZXsttiNaDlj+ENLQ3RqbUluhmRbWW01VkwWO1QUIGiZXgOBQy2kPZ?=
 =?us-ascii?Q?sYYf9CcXyENflANtsIxsU9nBtqsMDMMXp/LQDRSxSv22A65947qmm/rWQL+/?=
 =?us-ascii?Q?86ae92+ZwrpdvGV+bmEDrSjkR+oZ/A8IhgybEDWi3LjN32XEMa7GoVLMpApp?=
 =?us-ascii?Q?UIHZlz+bKyKbZjap++mSynS+BAjHiNCCTvSk5zCdrCKW/bAQ4nQ4Ae+YuR5U?=
 =?us-ascii?Q?tNpxTlVPSCrMq0ZTKoay+v4j7Z4DXAKuTIw4LXrPoXjNwyYZRvoupIHbj3zE?=
 =?us-ascii?Q?cnK6jKeDwKnn8GLlBrVyp1kEmUeuBDEFQLlWmwW3UCXzoVhPSTS4iB4DWD/U?=
 =?us-ascii?Q?I2o9COx3JwqL5dVWepeS4zzclcwYGpWKHTXvU4adU+vrjIp4rZa3rqPe5p6w?=
 =?us-ascii?Q?L0IdJDlaFTwTGA0zo4a7LKhs645+Xq3/9fRsVre4dOicSD6J0/csut5WyyDq?=
 =?us-ascii?Q?FYKQ4f2kqs67XY4oA0c5CS2BM3jjb8d2AEytAOKzbqF69LQbdiDdQITuOxaA?=
 =?us-ascii?Q?Rta/8IjTThAP750vbjik9gs2oJakGhDTnJdeNoXJwv11wYm/ZP5yHMtTkusd?=
 =?us-ascii?Q?Fm/LrsDTLY3Qt/GepLDQF+jb7KIOqQ1sqThIga48sc/xVBZfdoqODm3S8oDR?=
 =?us-ascii?Q?JXAqDuPrUQThgKQlRFLkVIveG9UALUbVUPx3e7CgrNAUq21one99YfIfTJ/N?=
 =?us-ascii?Q?9XYwKn0Jiva7kBmvJOTAZO6hOJW9QlcoiKoNIu0YK3e/oUI56S0n3hleA/9C?=
 =?us-ascii?Q?BccQpw4UHu+tBzqjknBk46aUg6bI1gfxoeinIeYLvbYSTCwqWkR8w/mwfQoV?=
 =?us-ascii?Q?9Ug3zcMJArB4wKtW1oBz0DOpWvhzSmlvlXyZ3PfjbiEYuuT9mSjPn+p56d0x?=
 =?us-ascii?Q?0z6Uoy9LY2iPIGgodVuw46OpWUxwr72C6rS2LJIzsmCeoAiVmKqGzMx0FQA3?=
 =?us-ascii?Q?ii0HakYHgqryhDP5yY0BXNBh4gIeGDRG1ytwcu2PtbGKW3VqM0uFnCpNOdiY?=
 =?us-ascii?Q?w66Gw6wOe/qzpdAofEykcJLP37K8CmrVWLKaJbYuQpxDmOFeX5YusKlQkiBK?=
 =?us-ascii?Q?n/1Pr2RpupasREyrY2Cvx6n4q5mR7G8BPPd28hd5YJgplJGhIp9u70KIx6fb?=
 =?us-ascii?Q?9oneyNtrqbaDgwFvI2rSufuXbiHBnuaPZjFCW3Am/5jvU4axxrhNm0TswBsw?=
 =?us-ascii?Q?3ivu0I4jxb02zH8sgEbbdfSiixEDMAQthDxEO10+tkmGdsoWSgzXfNyDJzSu?=
 =?us-ascii?Q?o3fviA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 812ee938-b20b-4fdf-7b9c-08d9b9bb1c0a
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2021 19:52:33.1826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TJuxAxrL3ezdcXXrXR0raEizPTgfqIsruAJdbUIIL8KB2Y8rZ/OmXdlblkPIdbKLAh4+pQxMoJm9VkkVEzUtwdQ40jvNsxSw/7bjqXMer8I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1695
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10191 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112070124
X-Proofpoint-ORIG-GUID: sfQ3M-02FvFkDJ-MNg17E_2SVG-J1GI5
X-Proofpoint-GUID: sfQ3M-02FvFkDJ-MNg17E_2SVG-J1GI5
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

