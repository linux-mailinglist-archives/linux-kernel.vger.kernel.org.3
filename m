Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29E0C4B6F5F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 15:46:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235917AbiBOOqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 09:46:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239071AbiBOOpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 09:45:20 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9A99111DD9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 06:43:59 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21FEhhOl030901;
        Tue, 15 Feb 2022 14:43:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=oK0ImbEJTd2V2uCvo8kyJM73bPFmJc0hclUt2kEwjCE=;
 b=zbGJY7+G6IwuA8lPmPkqrrtfWMUfFtpCdvjYOeKgbuOSO8p1ksNUKH2/8T4NzawtfmwX
 9DsKV0O1xZky4iAxSI5aVXj58DFMFBVpTeCeXm8ny7UM3l1/BMyZFOwSmtYfLZeFIWW/
 5jyHRnMoX7thoaYBFfC9dtVAf679+oRTJj7a2WIovtJ95jGNtadAvf+6ijnaqHlFJlHa
 rqArW3tT/7kX/K8DxpEH6J9/aH8ahl4cctTjAztXOllCCuHLc/z/StHAqmwX9awlqwPB
 o5pnlQn9UFQloMBzbyzl7ezesaNulwjHfJzQCN6qIv31RCvW0txbJjg+EgXBv4GAJnw2 4w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e871psath-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 14:43:55 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21FEeT4E145723;
        Tue, 15 Feb 2022 14:43:54 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2042.outbound.protection.outlook.com [104.47.74.42])
        by aserp3030.oracle.com with ESMTP id 3e62xeqfex-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 14:43:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z5SgrPL749UXg2R7FjCOYzO8KuFO2ZNjSxEqN4wj91pzLo8+bEHnSxWcB8ENL3+YftnMYfJsNLDUl0yFt2OOElOp9nMtzRyu3EWjWuOJXDyAAA2ECxmlhtd5mUZyUfXvkLOfm4V+KgrR5MY1kD4Lv0vVOC7o4XdZCGit84hikVGllPmZF2Hbwd73wJAeS1s45orfRA8QPR2TQd2nqH3DyCuF6qRa8RNUP6C7jd7gKFr55QuvRhfe9SGIy/8hj7BdpApDL+vyydPlzVHMVjNwbdGleeXZdlunZ6yt+nECW1/cQUv7xSKxMflm8x0+2jM0nl35790W9D8IwO0GHdtHAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oK0ImbEJTd2V2uCvo8kyJM73bPFmJc0hclUt2kEwjCE=;
 b=To0qJXMkGbM0aOl85hqngDTnA1thMy1XELHUIuwcYgAmsuGBj+XaRDT+HuBXJDjmqkA3D6rlaJqTOK4lWQtFul4oM0MxvQGqN7rQR4vCCyiqL9eTXxZY6nr1fNVezrw1WNR6szfclfs+tdDHTuwcsqg2nFdPCJf4/8z71xTztbZp5lUW7W+Vd4/PpUipU65WETZmpw5k8NiJ3IivHydRsfiukFSlT/MWEosub0qJkuL4q9maZWdHFy7Gp4P2PHAqHnCgM+SLF/zqPgJ8/U21lnOVqXxMYJb/IkPO1W7z95x9n4uoF1dka999oz41bbdCr5adaV3FWLanGFfczcoSEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oK0ImbEJTd2V2uCvo8kyJM73bPFmJc0hclUt2kEwjCE=;
 b=xguBUXPa/+5ePjh4sMmklU/1ghuWOdTL3faE3ZkQEInknC8uxrfx8iwnPWBu/zx5TXoElyC5THL62em3tiz0+LBCSAXaPGbAYLp9GIoP5WBQggRwtqnJG3RCFy+SMsQ7yT8CZkj0p+4alfJTSgQSlW/IkcPAxH3+/JjcMR9KYFc=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH0PR10MB5578.namprd10.prod.outlook.com (2603:10b6:510:f1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14; Tue, 15 Feb
 2022 14:43:51 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1%4]) with mapi id 15.20.4975.019; Tue, 15 Feb 2022
 14:43:51 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v6 34/71] powerpc: Remove mmap linked list walks
Thread-Topic: [PATCH v6 34/71] powerpc: Remove mmap linked list walks
Thread-Index: AQHYInpdoXP8H9UxVEiX6te1bMcgXQ==
Date:   Tue, 15 Feb 2022 14:43:15 +0000
Message-ID: <20220215144241.3812052-34-Liam.Howlett@oracle.com>
References: <20220215143728.3810954-1-Liam.Howlett@oracle.com>
 <20220215144241.3812052-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220215144241.3812052-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 16619745-acca-443c-7776-08d9f091957c
x-ms-traffictypediagnostic: PH0PR10MB5578:EE_
x-microsoft-antispam-prvs: <PH0PR10MB5578FCF8C2AF2B1CA95D4D56FD349@PH0PR10MB5578.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: x84hXJrNnHOxpVGTkSesjEVBeP8vaH65lxjrOGHr6YtLRdwcB/IzeANBw41SbKiAimrjpNoKx6/y5LpWZcsJbzHCJ7Ye00UXjXdDVr/BOFk9wB4NDa9gJWxPasy2Hxf1LpyEsunBZBffaUwkn/3sA/zTVFwslScwt7Cs7cfisGMbcTqLyWdY6TT1peO7oR8vc8nq1ALJSvpnraiyV+H6FsIzP67tRDEuBi3U5y/Q07s9NhGKLYmcXMkkViOZkXbnXfBBU90W70mAzSd3cUo+F1xSFVXa7K4e8+JKhJOrHyvbTSyI7qGqT6KRjRU8tGK7rXpsGlTriruUkDxY7VcdJO+119ZCHUDvxruUATPNAvkMpTmt0uRhhQQzbti0XPg7vtHbOi4tQJ1XJ8pX+QVIDVmXKh1hOFmIvGjL2cdB3Sd5rX32umQxNhnvD0HDCkdCnlUBBsJKClmygA195k8zr5zSNpVA35CfJ57KgR2e6ABmxHfN2XCLScFefHbCuXFJCzuaqHJizSElDM97IC/YfXTwxVX+V5z2hA8lHO0Cuu+2QT/WdeP45Ea7JZY6ul5tfC9x7L96uw5jCg42zQTsNr4ClcFE/sRhrObkzH4mYaZl8Qi+d5QeXYVy/3eQZNp+Zw4662fp9t3EFFSNWTIXk1BprbsRntQdScs/ZcM1nyu4dBOwd7exy6JO9oz0d2acmE6OXmVQ3xnvV7eC1lgtNw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(2906002)(6486002)(83380400001)(38100700002)(110136005)(508600001)(91956017)(64756008)(66556008)(66476007)(66446008)(5660300002)(66946007)(76116006)(8676002)(71200400001)(38070700005)(44832011)(86362001)(2616005)(1076003)(122000001)(6506007)(186003)(6666004)(6512007)(26005)(8936002)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?dLF9GNikQ0L8uvYRbUXsFszgqeAq79VWksRpwfeAWLSEVW5n/3AG0+7NtJ?=
 =?iso-8859-1?Q?Hy87VagE1y4/9HyOYAfUR8LB55KQeILbRfGFLHwV9Toda0TCLYHVlt1QAI?=
 =?iso-8859-1?Q?9aYHgaAUFZXE/4Hv7bMSw3Si8lpP4ZqkNH8R/18k0bwybhkIGRbu9ZYNV2?=
 =?iso-8859-1?Q?lh99U65jNIeDWPhLOUFW2trywHFlXrjCWGX2SbmaKWiI3cbndGpgmlFuKj?=
 =?iso-8859-1?Q?Sw8X9QINlmWKSuqneM/B/YVkglJFx3VTWjI5lXkNg4WjZCoqQLSBso8/TW?=
 =?iso-8859-1?Q?uTWzuma7S2k1EBc4ogSdXMO6cr2IHKHU7YDBjkTGUaqWOZRPLcvdy8CfbJ?=
 =?iso-8859-1?Q?11kBOtVy0n8JZ1vn7pPmcFJ4t8Has+4yvYgthmIxQHQ0H5wUcZDUVLgiou?=
 =?iso-8859-1?Q?29QbKIPYj0eKQVKeISsCbi/QLRg9RiMrzE7HPDwzfvxbqRe2bVdADKcqaw?=
 =?iso-8859-1?Q?i9unlKbw5jWtzyFbzT/jQFmgEJX9kLLLkAvAMl78kAs/H0B/Ll/tIGrk9k?=
 =?iso-8859-1?Q?5HCM1tXBeW7FuGNqdbc2ilMwmy7OAb45/2TMucwRg/uyXMhDat/mN3VKHM?=
 =?iso-8859-1?Q?BWhrLO02m6ADuXn2V+GK4eAezVf1ZPytPLDgVkzkOsWQI8Re6EXetdUiUB?=
 =?iso-8859-1?Q?oq/nhpUPIb9rm5fisqRbKrqa+zojV70Z4WyiMIZa6bKM7aLt0cK3hJVyvo?=
 =?iso-8859-1?Q?7YYi/RbhedzxW+R9CRSUExtwAwjpXHiPhnIy+iepT/StjE8neeEPcaqUyF?=
 =?iso-8859-1?Q?0YIjzgk+RX7OaE44aCDsE7Rbtn7zCQucDu6njlgLhvMu1IVJT10D59Ts7P?=
 =?iso-8859-1?Q?VQBnSOM9ywa2jopUYD/kupV4Oz6dO1RN8MxEScjZU4bQKIlHM8Jy8STeQ2?=
 =?iso-8859-1?Q?9DIl/xJcak7bIcWSFXxoCcw6giJoCcTXrzsOYVgd1ss6drcA2+lLHqL/Ih?=
 =?iso-8859-1?Q?/+KhsANpwZWj39xX8s+1i3aYIqMX6MLJPY21KLP1FSwMrBRnUrZhfBZK7H?=
 =?iso-8859-1?Q?PuNdodoSSQn91ahqTq/QnqwMiAB1iT2ZY9GcEy9Slu4G/gyu+9T/85SyqK?=
 =?iso-8859-1?Q?H+kfDwxRhSleyXFmNxthX/0PFzrTGdLHJKCVNz2HUEgAKvWyZqzTZH1VWU?=
 =?iso-8859-1?Q?hjGzDUrBuNAUWeSJQrBbOA0grRE2g6R4uJjzI8TPZcdvoxheW0zcjRswpM?=
 =?iso-8859-1?Q?4o6q5YPqXnT7Eui9gg6JK4UlAVKNeTVxZC0TjPrIBwS3ZP+nTTvKQEYbcA?=
 =?iso-8859-1?Q?BrxgzGb+QdIppUC2TXYx/cLDih0xkgiTrFwDF4r98AHTfcshcSRFRejSO8?=
 =?iso-8859-1?Q?8RHLPhMHxnOq3uuO9ZKBGV0kBTytdWU+1cxMGlREhns5T/ENRNHFqN4XHP?=
 =?iso-8859-1?Q?RbPWiODgECpl7j4YCKG03xRx/wwDHXMXIbVK8oaZv707JPGbJINpSVGPze?=
 =?iso-8859-1?Q?SUhaqz36fk1IbOjYW6JFPnhwgi2lMN1rAtbBuoE6WXAMP4YhydsG+zSE3i?=
 =?iso-8859-1?Q?MHqV4RafI4t8W60Ev8i/u+3WgyT9DfBzcMOd8lw93Hq8yeHjTYpbGZ4D9A?=
 =?iso-8859-1?Q?ASlAqXOHDFxtu2IQHTE9JT8fVMtPSj5ANx9wYcVoA4jYefMEYA/aJtHhdY?=
 =?iso-8859-1?Q?jvnu2fSrDLgn59xTOCOBGE3GldZGYkXkS4ug4fO54lh4OUmaXIFu3A4maw?=
 =?iso-8859-1?Q?UjkkzRWAvzS7cGTs6lU=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16619745-acca-443c-7776-08d9f091957c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2022 14:43:15.5578
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dsoRhydweeBH0TYQ7xhN0mlpVLC1tZO5AzsldTd09tn6T35Tpth+NDhoodCbfxUML9fSAgB/jJi+639M4Bm7dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5578
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10258 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202150085
X-Proofpoint-GUID: _HVecz3zLec0moPZtX6B2gz7wHD7VP77
X-Proofpoint-ORIG-GUID: _HVecz3zLec0moPZtX6B2gz7wHD7VP77
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Use the VMA iterator instead.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
---
 arch/powerpc/kernel/vdso.c              |  6 +++---
 arch/powerpc/mm/book3s32/tlb.c          | 11 ++++++-----
 arch/powerpc/mm/book3s64/subpage_prot.c | 13 ++-----------
 3 files changed, 11 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/kernel/vdso.c b/arch/powerpc/kernel/vdso.c
index 717f2c9a7573..f70db911e061 100644
--- a/arch/powerpc/kernel/vdso.c
+++ b/arch/powerpc/kernel/vdso.c
@@ -114,18 +114,18 @@ struct vdso_data *arch_get_vdso_data(void *vvar_page)
 int vdso_join_timens(struct task_struct *task, struct time_namespace *ns)
 {
 	struct mm_struct *mm =3D task->mm;
+	VMA_ITERATOR(vmi, mm, 0);
 	struct vm_area_struct *vma;
=20
 	mmap_read_lock(mm);
-
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		unsigned long size =3D vma->vm_end - vma->vm_start;
=20
 		if (vma_is_special_mapping(vma, &vvar_spec))
 			zap_page_range(vma, vma->vm_start, size);
 	}
-
 	mmap_read_unlock(mm);
+
 	return 0;
 }
=20
diff --git a/arch/powerpc/mm/book3s32/tlb.c b/arch/powerpc/mm/book3s32/tlb.=
c
index 19f0ef950d77..9ad6b56bfec9 100644
--- a/arch/powerpc/mm/book3s32/tlb.c
+++ b/arch/powerpc/mm/book3s32/tlb.c
@@ -81,14 +81,15 @@ EXPORT_SYMBOL(hash__flush_range);
 void hash__flush_tlb_mm(struct mm_struct *mm)
 {
 	struct vm_area_struct *mp;
+	VMA_ITERATOR(vmi, mm, 0);
=20
 	/*
-	 * It is safe to go down the mm's list of vmas when called
-	 * from dup_mmap, holding mmap_lock.  It would also be safe from
-	 * unmap_region or exit_mmap, but not from vmtruncate on SMP -
-	 * but it seems dup_mmap is the only SMP case which gets here.
+	 * It is safe to iterate the vmas when called from dup_mmap,
+	 * holding mmap_lock.  It would also be safe from unmap_region
+	 * or exit_mmap, but not from vmtruncate on SMP - but it seems
+	 * dup_mmap is the only SMP case which gets here.
 	 */
-	for (mp =3D mm->mmap; mp !=3D NULL; mp =3D mp->vm_next)
+	for_each_vma(vmi, mp)
 		hash__flush_range(mp->vm_mm, mp->vm_start, mp->vm_end);
 }
 EXPORT_SYMBOL(hash__flush_tlb_mm);
diff --git a/arch/powerpc/mm/book3s64/subpage_prot.c b/arch/powerpc/mm/book=
3s64/subpage_prot.c
index 60c6ea16a972..d73b3b4176e8 100644
--- a/arch/powerpc/mm/book3s64/subpage_prot.c
+++ b/arch/powerpc/mm/book3s64/subpage_prot.c
@@ -149,24 +149,15 @@ static void subpage_mark_vma_nohuge(struct mm_struct =
*mm, unsigned long addr,
 				    unsigned long len)
 {
 	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, mm, addr);
=20
 	/*
 	 * We don't try too hard, we just mark all the vma in that range
 	 * VM_NOHUGEPAGE and split them.
 	 */
-	vma =3D find_vma(mm, addr);
-	/*
-	 * If the range is in unmapped range, just return
-	 */
-	if (vma && ((addr + len) <=3D vma->vm_start))
-		return;
-
-	while (vma) {
-		if (vma->vm_start >=3D (addr + len))
-			break;
+	for_each_vma_range(vmi, vma, addr + len) {
 		vma->vm_flags |=3D VM_NOHUGEPAGE;
 		walk_page_vma(vma, &subpage_walk_ops, NULL);
-		vma =3D vma->vm_next;
 	}
 }
 #else
--=20
2.34.1
