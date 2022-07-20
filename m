Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9945457ADDC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 04:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241245AbiGTCWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 22:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241133AbiGTCVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 22:21:10 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFC356C138
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 19:18:41 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26K0Kfc4017922;
        Wed, 20 Jul 2022 02:18:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=4SPxAHmLj31ouRAlcX/JHknvMOStmgpaQQOju3HYq/Y=;
 b=VFXNlTHNfOuVvNk+QZwpxe0srVU1W77P4QlKZN6OXNnsE2/H6EsXI/TStfewy57APi0e
 kewI4fcYKFvMJWghVEJacHvc24wGChUN2iK84J9aEqXULRkRf5NdIVKq9mLYa/WpdQAY
 xeH2mtYQA5NHQd2/1pqHn1EmBUQiJMQYx2zMJSTgsSeVLjz1+nMPh0OduivxWI8H5qI3
 VAKmI6fUO/O+X9xDgQeYvMHod8qvXDBWXEb5lHJ4DYvgALpxhWg+VaadddH0deBsKSZZ
 SYKQHxWN1c9AFDsoyzU0DKFgOb9oxsaBhn6HlMblpEbYv+B0LkbuKWeSYGn41A8AhHpN 8w== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbkx107u0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 02:18:34 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26K1UAlh002689;
        Wed, 20 Jul 2022 02:18:33 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1mbnuv5-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 02:18:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fgjbv7fsx4ycUebjY8q3AyONLX/1PBHXSmnvtlIv9L+pEApvqpwIlhryv5wW49tar4FODdGAlUM56LRK+kNLoF/7YmEwq1ndTz7EkdnfnyQmnLYSYUns2dHhFmuW8AjvBoKrSI/Ek7453YEJJF0atItvOT9KDqeMmEGqQ5UafDIZp68r/PpU8hdtDPiTq8lgEdjG3nrIYc1Zc6xaVGQTlHtbUlOE8MI7OuldSrnROX4wcMqiUk39t6CYc1Ohla1OJPT2g4XH6qHfh+fihncPA9IarMLFw0VkgR/RDg8D2S+EI+UxXjbUacWPIjtai88Qt90whWhaKuaWMXC/JhAKIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4SPxAHmLj31ouRAlcX/JHknvMOStmgpaQQOju3HYq/Y=;
 b=bAZiYH5kU5m6dPt+kc4bo+H2+8CV/hKt87S5bD2mlDuwHtHAd11s6bfpjz8+wUDZroe8SR5ZbDGWYqfH9lT2shWq2uieaTKj2GuPp+oG96j3CmhcNTxg/VkKx9t5nR1lqF4k8zOk4k0meQFcVfwYn3HpXasBR+LBv4LF4aA9+Ve15zX4Ya19ZeF6PvtW6sTn9ORf66YD34YGSZQY0GSSkxmcvqUraeOSEXjBo3FDYx7GrjvjilvIp4olP0mHkNtGBaO820Sv8av8mtWyB4PdhwIOqjVvaR5FWhCyfubnV5/XSim0J5eHzKGQ/MgHnoRP7SXikGMTC9h9a9E0wWZ/3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4SPxAHmLj31ouRAlcX/JHknvMOStmgpaQQOju3HYq/Y=;
 b=SrIbo+ZGKivKpS01096Kj3MbA1Vyw+EikKxP1ZNaOyaut7jszbc0rw9h17eyfsRNeftfNmwkUkvWLm1MiUeiderZsnR87gSInV8rDYokCKCdxcA7ps5MaSZKJ/Wvd7IPtlniQHnVBhoWaTYBJyrglatxY9p3ItZGG9o4CcE4we8=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH8PR10MB6316.namprd10.prod.outlook.com (2603:10b6:510:1cf::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.22; Wed, 20 Jul
 2022 02:18:32 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.024; Wed, 20 Jul 2022
 02:18:31 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>
CC:     Yu Zhao <yuzhao@google.com>
Subject: [PATCH v12 36/69] xtensa: remove vma linked list walks
Thread-Topic: [PATCH v12 36/69] xtensa: remove vma linked list walks
Thread-Index: AQHYm97sMA9k1qbhxUOVQlVAtXzXaw==
Date:   Wed, 20 Jul 2022 02:17:55 +0000
Message-ID: <20220720021727.17018-37-Liam.Howlett@oracle.com>
References: <20220720021727.17018-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220720021727.17018-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f3a91a2b-a232-4bb8-50c9-08da69f6245a
x-ms-traffictypediagnostic: PH8PR10MB6316:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: L6QP4SkfSZsta1wQW7Ig/DPFg/GtImxbnLYF9srq/9Ir10VHm+CPOI9QxvtEhH4YeozxPYA6etHNp9zYY2szRIQsUPhXwK1qR8GOCq3vNQbG8IwWwBDNKMjVnvb8tdqu0irFQOIZbZ5KisUSF7i6V/fqFmYkWij9P6kAq1q6DFTi1mM68lb1fZpiOH0FjIg8yxCgrsQWLx6wAfS2Bsam++DOP46urxE1G4xeTnQC1f+ZFR8VaCqULIEQciqyhs1JqKTKytvNlp/BLFwzQWL6RyYPPjqXxHUncBSoyzv52C0LdGE65MqU0N9E8TSCspJ6IMFdmIjF6/8vi07jajWCyIlu6AJE0lz2jHAftYd6S0VKHQ+Sf4j1a7Sl+YC3XFtyDxkL6TTLE6JBYZuO9So81KTEZT++9cFwFTUzBG3mmCig01/E+cZ9MpUVclbUkr4/c4HL7G6qr6k5djdZfEUnImmsa92/IFShojfhz16YEUEhYLyi9Nczd6Q/jKftKnnyihoLwqkmjBKvXHQIewTvG/mXh+arzOL/CeaoP/+KE2olT0smIrTptOgk8h/e379T9Zntj1dPmDisyopHEQ2NVEcwj+pgyrdMnjiXYGl4G+kJLCSdWp3DQQdmjE2KZcSttfGNRFPa5PAFMkjp1Zbpp8ymJge+QUGlTcqyAiYhMkuUqpcr/DsobAt7tfTER2SonEeUoHtYbwWbtOQB0FW1gtm83gHxpPkm9K2bU9GZ33b068rmYLAGtlwIEKpDm6kQetvFHnrlL8tYP8Xm5sQKyQd2OyEIAbVC/NS2zPPFZqMwoOn+JwAZRQbWuPoKuCzyN1cfaLmInsXH7w3S9JQL7jE6HG66Q7HI80m+bJZCOU/BOJlCM+A7nFslWBbm7Sio
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(396003)(39860400002)(366004)(376002)(136003)(76116006)(122000001)(44832011)(8936002)(5660300002)(186003)(1076003)(83380400001)(2616005)(4326008)(66446008)(64756008)(36756003)(66946007)(2906002)(8676002)(91956017)(66556008)(316002)(26005)(41300700001)(966005)(66476007)(86362001)(38070700005)(478600001)(6506007)(6486002)(6666004)(71200400001)(110136005)(38100700002)(6512007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?xJwXy5lqJYn+OpIclEc7fRTUircLa9CJAzd1+vNvZjwIM/74I4GP8DhTJS?=
 =?iso-8859-1?Q?0lpgEBui3oNxkz2E7dwRIt1FJrPscti5+VWu7Hp7thMLOytXMnUmNwW14/?=
 =?iso-8859-1?Q?rmxtwlXxHAh/Wa8+/9o0u+Ma8rIPfaim5OIjM53wzQiyPiHAQKq/K65qZO?=
 =?iso-8859-1?Q?xGxzZHXeq02JGvN1k/EN5DB3i0og8FIl6A6lmD1Kn6QhOVMDSPXflHU/KX?=
 =?iso-8859-1?Q?0p4/8inEdoxzbiFCFJQOy4w2WFl5macpshVC+3ridYsN7zchc4r/imYYOq?=
 =?iso-8859-1?Q?oZVAZNL0jtOQFLp4DusHOkxRtc/YA6wymQJkq4zSATCVIJj1jkrmpIa+RV?=
 =?iso-8859-1?Q?UciP9y619FOAWW6uybmfWKVwHhHPZBLFJiFbVeH3BS5G79o6ksjPURuH+s?=
 =?iso-8859-1?Q?4KFBCGvADK6ak4ssjtbYpu6JS3fCyNhxLBU7FX/WWz9cwljk51vdy/s9+V?=
 =?iso-8859-1?Q?HQWemzUlZDV/rvekq5cec/WgSGHQCa1x/DBdkZfqm4/cFabd6/OS5TYMam?=
 =?iso-8859-1?Q?p9kKE0TVYLzb/Ti4haZ/+t0GCS+GGVxzRQ3ow3H6jVXQlOiH7k1NjQauuo?=
 =?iso-8859-1?Q?fJ/uoz73VibKQ35OqERF05duuLZqdrK1YEycYVbeVUAsF7xzSmoQY0oopc?=
 =?iso-8859-1?Q?xcp8xXjslYOYnFXFES5DkZAGE3O58QP+AjcKQWHr79pbalEn2RYSd1GugB?=
 =?iso-8859-1?Q?gm48j5k+rZfnmC2I39dzgKRHKgkPKg6nMolKUtYYYBxVSb876nUwyt2IoS?=
 =?iso-8859-1?Q?MFBxFeizrUJ2Q86AWh/WALKlktSrumupYidOA3jYPGLzeSkd2kC75zGAPP?=
 =?iso-8859-1?Q?941klo+UlCMUP8V2Q54Gww6qjQYv60+tOr4Mw9as4tlveQR6amWapAbBDR?=
 =?iso-8859-1?Q?2CMa3lOinFdDk3L1Lxe0ABYQVCatX3aIMjiWZLGu6liZ1m8gGkGTzbqD2y?=
 =?iso-8859-1?Q?QSW5m/BzkjQOC87M8fP89LQ24kMpSL/45IEP+DGbtknDEGWFBN7VarAKP5?=
 =?iso-8859-1?Q?NAYYNq7bPiRLzFljU4VJbHXL1387dO/F6JYCI8pYhsC4GNA5PJhw205LH0?=
 =?iso-8859-1?Q?IbNZJyktoNxcFWBUuIxLfgC59J9G4EdyZv5001t78XM9LmCyUQF/6pIgRN?=
 =?iso-8859-1?Q?mA+lz6rWzQCjg8RrxpfRjOaOPK6raR6HvWjDHr1hZ0TTD6NauVoSr1XYyk?=
 =?iso-8859-1?Q?UFNsraMnaWUx/eT0Of5me7fuX/7AX2gxeizFGtER4cNSE/NeaxSum3AgCP?=
 =?iso-8859-1?Q?nbpE8Il57wBXnf0aBVDAUq1CbDIuInADz1ZmepipPZMY8wq+r+ddP2w8tq?=
 =?iso-8859-1?Q?Z5qbO/t1ABT0NvVCbPmPtFs5xIy3Re4ipK55idltTCqj6EF288CmtOd4rI?=
 =?iso-8859-1?Q?xxOmuq46ElwJk6kb0PWgdk1Ql9pneY0bZlD0q5LKw07AokRouotEWT/myu?=
 =?iso-8859-1?Q?Xv7ELSdcq+YzJNwAZ1BkySLtDGc07buyhzwa+vsP0v7sBbIo3D2Om3V/1f?=
 =?iso-8859-1?Q?p7FywsLBp4vrEaahOdz9jx45d45zJCWkcPzuVY64qsZGIZrKjCVv54dc0d?=
 =?iso-8859-1?Q?1BlTV0aDxMKwXngUuRasy4+S1YAGDgBg6f6/qe6lcyjP6OItlm4eDVBFNa?=
 =?iso-8859-1?Q?+crPaADMN0pMZY8j6CWduhyxDd8pxenIp93NRaE/DFkhu1dgAALgVuYA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3a91a2b-a232-4bb8-50c9-08da69f6245a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2022 02:17:55.7743
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bwb3cri2FetMW1t7xs+LOl1zQWgXZRPqYyMw2IuHHkN9XRXSMPys5wM+v2QUiHatx258rU3WVGNEapMzRpX3jQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6316
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-19_10,2022-07-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 suspectscore=0 mlxlogscore=944 adultscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207200008
X-Proofpoint-GUID: dY5_nI0rLuOkqE9qLib3oL0Jq7qfNPBr
X-Proofpoint-ORIG-GUID: dY5_nI0rLuOkqE9qLib3oL0Jq7qfNPBr
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Use the VMA iterator instead.  Since VMA can no longer be NULL in the
loop, then deal with out-of-memory outside the loop.  This means a
slightly longer run time in the failure case (-ENOMEM) - it will run to
the end of the VMAs before erroring instead of in the middle of the loop.

Link: https://lkml.kernel.org/r/20220504011345.662299-21-Liam.Howlett@oracl=
e.com
Link: https://lkml.kernel.org/r/20220621204632.3370049-37-Liam.Howlett@orac=
le.com
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: SeongJae Park <sj@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Will Deacon <will@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 arch/xtensa/kernel/syscall.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/xtensa/kernel/syscall.c b/arch/xtensa/kernel/syscall.c
index 201356faa7e6..b3c2450d6f23 100644
--- a/arch/xtensa/kernel/syscall.c
+++ b/arch/xtensa/kernel/syscall.c
@@ -58,6 +58,7 @@ unsigned long arch_get_unmapped_area(struct file *filp, u=
nsigned long addr,
 		unsigned long len, unsigned long pgoff, unsigned long flags)
 {
 	struct vm_area_struct *vmm;
+	struct vma_iterator vmi;
=20
 	if (flags & MAP_FIXED) {
 		/* We do not accept a shared mapping if it would violate
@@ -79,15 +80,20 @@ unsigned long arch_get_unmapped_area(struct file *filp,=
 unsigned long addr,
 	else
 		addr =3D PAGE_ALIGN(addr);
=20
-	for (vmm =3D find_vma(current->mm, addr); ; vmm =3D vmm->vm_next) {
-		/* At this point:  (!vmm || addr < vmm->vm_end). */
-		if (TASK_SIZE - len < addr)
-			return -ENOMEM;
-		if (!vmm || addr + len <=3D vm_start_gap(vmm))
-			return addr;
+	vma_iter_init(&vmi, current->mm, addr);
+	for_each_vma(vmi, vmm) {
+		/* At this point:  (addr < vmm->vm_end). */
+		if (addr + len <=3D vm_start_gap(vmm))
+			break;
+
 		addr =3D vmm->vm_end;
 		if (flags & MAP_SHARED)
 			addr =3D COLOUR_ALIGN(addr, pgoff);
 	}
+
+	if (TASK_SIZE - len < addr)
+		return -ENOMEM;
+
+	return addr;
 }
 #endif
--=20
2.35.1
