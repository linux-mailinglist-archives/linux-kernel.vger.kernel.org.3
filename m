Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C44B34A6A2E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 03:45:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244745AbiBBCpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 21:45:06 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:39468 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244207AbiBBCnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 21:43:02 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2120Gv7a026579;
        Wed, 2 Feb 2022 02:42:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=9oXDIBGXs5l2VJ0a0gQKjxuZtcMnhHZqI4dSc7CPvDQ=;
 b=NVzo+hwJY00fyjsNC7b6tIoNFp5O719K36HW9Y43WhTzMZKlMva1KsC36nFjPt3dot87
 xZZDPppfT2xydtVDgQYMYyefMWnSx/o6tB1oVb0hgrr89DYdGgPb+FWUy/G3aegPSWqR
 1LUeHwBLDJMxTfdzQvsElhvcY4RZhLAQsvAuYU5FfNbRHCDUj02zMyrP5Et1tGHMSaZN
 NrdplBMmuJWWuXDikYVW1PYJ7IDb5l3D16hTZP9eukmc3Nno4Ae7yf414WfWQX3gvlTg
 Koyz67IO9Q6vo7p73GDMfFKHUlJVaGhRU01kE1IfbghHK+BZk9ybUmaDuoKSCAua/R9q 3Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxj9vcu1u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 02:42:55 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2122Zsu8007633;
        Wed, 2 Feb 2022 02:42:54 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by userp3020.oracle.com with ESMTP id 3dvy1r8aet-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 02:42:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NLBK/wzH2/8N5+UfNYHXm/5mC7BVlhsBYKzGUoh6P7SFy3cskZw0cQRsOVT2GyG3qDzyAovgFsPUV1dEbccGM9Mk2WnyIRDLBt/FWA3IbW7j0QqOzy4suaYqeuCWRiI3oic6d6iaFOuGenmbbFkouBmayYoaAlk2/eEQGnKCH/uUnNUwfs/CjRnsbTca52PCiYH9HmQv1Yig/8NOlvgkp08BptEvj5C23F7YSinibEpK76wu7NGcJbTYpXfzpo4mzpTV2Y5S01rvOUKAC5rhpSHynNZP6EE6GkxysOw+jOS/C1Ba82n3/6B4ysTcfQ3IT31fmBKRuGwDuBnNdSFA1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9oXDIBGXs5l2VJ0a0gQKjxuZtcMnhHZqI4dSc7CPvDQ=;
 b=fW9plw821o+LM7F/APkGn/huux+SjMIGL+yqIu+fs/Ncmd+H75tX26jdCSUqmYM+CQtTknk9mcY7clvE21ZSsrqRTrmi5sDxclhrNJ2KA6xEIbmMFzBDkhR/3XoaHMauYkeNgIQ3nIlSACaVC98h2LcVEgW6nPTyszcPTY8mUxbsjluP8MpbuHV6ly5uIK7fLvOuvhAoQA3TYhlsT5h+TRUGuiPLT7aTyUvh6+UeTlf2oIi2Dsf/QQ0rQwDwacUQwI0egs6XE86qbroglHWttoSvOLzUlnjHNTNT76tl0n/AZjDJeLCfTdQ7fyE7EGImI+5oqLX+21RHnak9zPL8ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9oXDIBGXs5l2VJ0a0gQKjxuZtcMnhHZqI4dSc7CPvDQ=;
 b=P/a9qZLqr8ZGxanVRSy34DzzrEWG7h8CWFpV/fd7mLBT4yC6aNZMy+hjjxmxHPDAAmltF2EH+89PLI5VSMQG7mx1dUoxx4NnQYKRZyZREINjPvAltkdIEqpXGoJjzWU470istfq0AZMQTlbYZ2egNYa8ZN5HzuTMxmwlFL4SYoo=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CO1PR10MB4801.namprd10.prod.outlook.com (2603:10b6:303:96::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Wed, 2 Feb
 2022 02:42:51 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3%5]) with mapi id 15.20.4930.022; Wed, 2 Feb 2022
 02:42:51 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v5 44/70] fs/proc/task_mmu: Stop using linked list and
 highest_vm_end
Thread-Topic: [PATCH v5 44/70] fs/proc/task_mmu: Stop using linked list and
 highest_vm_end
Thread-Index: AQHYF959yCQXeHqUIEiI6rrKD9luNQ==
Date:   Wed, 2 Feb 2022 02:42:16 +0000
Message-ID: <20220202024137.2516438-45-Liam.Howlett@oracle.com>
References: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220202024137.2516438-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1a4eb053-58d5-4f76-c82f-08d9e5f5b515
x-ms-traffictypediagnostic: CO1PR10MB4801:EE_
x-microsoft-antispam-prvs: <CO1PR10MB48011E76025D09069D0761CBFD279@CO1PR10MB4801.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:873;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5DRvxc4eH2Bg11dp/KIbakjNQTlsL/AVHJNZk1LLkaC0VqtjrVlL5q4EbqP0XAzonOUqKAg35n+VzvDFjZaqkUarwL/a9/XrtdbL1RdAzKEMTa6wfY3EkMBUA7hLJkaZ/vKQ+A2DJCc+KvnyScXoRZjDr5m8QJIqpWpkG5/DrQaGAxBqoZwhgt0pootQ82mFf3HDw4jv+sp/C81Bsr7gvvEMWzndvkywikW7OZr+lfY9CCkfso+ds5ye0fgmn6nULyasD0X6z1vI3pHzutsPMRqwjjALa6FnHx3JWtigRn3z0eSygRpqd3cvxM6/grMumb8EtXMo7mviTd3UlO5rQxIyUSe64An9YhBXuphvRmqz/q8UFQPG+Q8Yf552hKZVNtxR7KbrAnCOvuWmePE6ow+4RxBf+yv8b0kzaZT2FWAn6jD6xCzXUIYyfi9kCDt033OAnSG4DTCXgdkWisPe0cHYyyyYYYz4GWCBDFdbwFQIhM+2Za9RhpvWHDKPjkGAfdCZs0cNwmmwwpFU3VUgl9VfyoMA05sXAQRP4pv7s1oBG1zXerTHfSiFrkaXT2FUx/lnvS7EB241IWGx7t0Aw8mvno0ZfZ+t+euSFouZmNSCabzajpJd2HM/veW31DR92FmJIyGHZmwnD0MRBBBe6IawsPLDtIGl44G9CmUx7FKp1dCiheoeeGTjAswBKuoeAJNmhzmP8I1oyBPMkRqQeA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(508600001)(1076003)(26005)(6486002)(122000001)(5660300002)(36756003)(44832011)(2616005)(6512007)(6666004)(6506007)(83380400001)(2906002)(38100700002)(66446008)(76116006)(86362001)(38070700005)(91956017)(71200400001)(110136005)(66476007)(316002)(64756008)(66556008)(66946007)(8936002)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?d4MbBHoEAnps1g0ekUo7BuBWvJH6cUKqYR79wX/4u7f7XuCOmfQJexMswN?=
 =?iso-8859-1?Q?foMaVWovnhZ2OZmevOMpYIi6zb8mkPr/H2s/JVwkWfQ0j3lCWozJqAb0Fe?=
 =?iso-8859-1?Q?W+0RfwpSijI31Isq9dKN3abUMgcPy7uUY93qWwwgDOsZuKaZ5S5770afmi?=
 =?iso-8859-1?Q?mPh0twU8s2z3qvrAbQTez6WSExXs9C9TGUnd0sxdInelRx96LXc9kN+ef8?=
 =?iso-8859-1?Q?aUQH0l5bAs7/6DFonRtCvhXPi5YtAdcbZfsYF5sCZgoAA/BBa9gD4PXD/U?=
 =?iso-8859-1?Q?H4C+vmtxhXH+M5GDEv4uOXbeFhSm8NpnWvgV2jOPmtbo+hRym5Fvuvxps4?=
 =?iso-8859-1?Q?uIY8d5nM/Kaf3ngxTXpWHllQexpufWrJcGK3u9EfV4Nj5nYd+8cML2yCtm?=
 =?iso-8859-1?Q?VOGIwMJqVMFheBysdQu8tTR8rYNgwFqAMSVF4dHX68N+NIyq70GWOzdIpA?=
 =?iso-8859-1?Q?18avqiOY3yMH615Uax8k/9hI2UqnIqaEWIf56rUQlQnlQczHmeOL9ARv6U?=
 =?iso-8859-1?Q?anylrH1BCjhOFDVMdAcPhXRm/LkGSIAoRAgKYHTnZ5jvkjH+MznMcpI/GU?=
 =?iso-8859-1?Q?MqLEUIUhfNWxswzZvUcKoxN9OGr07uhhgjwwTrkqlcxxguhQrlobeFroSR?=
 =?iso-8859-1?Q?E+uKvqTnxVL6pHKf4QMsyq6PI2DF87Uq1FQHHMU4VA3aA0W+cbawsMrzgp?=
 =?iso-8859-1?Q?cCMUzMaM0glQaw1VjNovKM2fDNlnmQFqK+bQ2EXVetO0ogVxalEyHEdBiV?=
 =?iso-8859-1?Q?j8Oc8fcJdPNPLxzRXXp9sNGzF3+wsncmWTIq/CwsPH6Tlr0A2er7NK96Wc?=
 =?iso-8859-1?Q?qOjnQRH7Hzg8KqgtvxVJJRDKzL4Qp7AEfKMMYX+B/snlOMJr8nxcE98qVW?=
 =?iso-8859-1?Q?vUio2f3Ehzw5T1hNKcQ35LnXbuKGE3WxpqmaNSGAHW9ZsrUYAwpTFBwQK2?=
 =?iso-8859-1?Q?3h9HYgdO90rgQBfcv+X+Kp4xV1u+gug996mXdl+AGegML72awTAjNbE/bo?=
 =?iso-8859-1?Q?NfgsWu5S2kNIl8sGKASqQQJL0iN6UGvx52XxQCvy8Uctu8i4DqRe6FdSgf?=
 =?iso-8859-1?Q?vFMTuAnBjG3AZbvOLBm8c2Au7MFyGH7Z6muTx75ddTYP4ohV4KsgEneKGo?=
 =?iso-8859-1?Q?Q6PI9o1Kl3fEigmF0u/hi9ath/y/g6GyDN+I+QF3ioNSCtTReU7TTyBixK?=
 =?iso-8859-1?Q?Xen65iR0d25oIboKxNNPBrVe7X7zhbUlV/aLyef1kE3U4wEQbGUbeh8VTW?=
 =?iso-8859-1?Q?rzmmVKE4eOUA4F0nwkpUQGSQI9sKt5/QczH+ldhVvizMdeQfzLBzKXG7dF?=
 =?iso-8859-1?Q?9Z/AZ3L63eZ5J8jjM8bnSAjlfxbfa02ByF5aQoJ54Ezer9gb5fKIWW+iNa?=
 =?iso-8859-1?Q?VzZgcjUD/kB++XcyUP9P2zLQm/tx1yzQ1htdGBrGpfQ9gvJq2Ll8Fp93P3?=
 =?iso-8859-1?Q?vq0FZRy3qS9AecXSmYeK1AeIY9/Aa1V6n3xH4mBo6Sfm9CS+B/veFolh++?=
 =?iso-8859-1?Q?Z2yjCQ++FM8CyPRrtykPbzQHcqIwcu6ziK2HKafTr5/3xuGfDHnfW1CTRQ?=
 =?iso-8859-1?Q?KC7qcTD4jgjROytZ9RmymwVqu7VKZRl6sw+THqx6b0XDf/1aipWyoemQqe?=
 =?iso-8859-1?Q?4UJLZBcY6YGA384idRHe5zRITGalHZlHFXfCoLkpiQzhz73SR9rb1NorT0?=
 =?iso-8859-1?Q?LjVJ7ERumDo2F9Tv4pA=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a4eb053-58d5-4f76-c82f-08d9e5f5b515
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2022 02:42:16.7042
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K4zAZQDhsmed2x9R8gjgOaXebligUhD+HMP/ctmXQp1fasIqTHTHlb1z/jVvDXSkwFz+jfQIRXtGN39oaYJoDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4801
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10245 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 spamscore=0
 bulkscore=0 adultscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202020010
X-Proofpoint-ORIG-GUID: 1pXA_oiO-ekVFvehmX4U-MebydhtoJn1
X-Proofpoint-GUID: 1pXA_oiO-ekVFvehmX4U-MebydhtoJn1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Remove references to mm_struct linked list and highest_vm_end for when
they are removed

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 fs/proc/internal.h |  2 +-
 fs/proc/task_mmu.c | 73 ++++++++++++++++++++++++++--------------------
 2 files changed, 42 insertions(+), 33 deletions(-)

diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index 06a80f78433d..f03000764ce5 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -285,7 +285,7 @@ struct proc_maps_private {
 	struct task_struct *task;
 	struct mm_struct *mm;
 #ifdef CONFIG_MMU
-	struct vm_area_struct *tail_vma;
+	struct vma_iterator iter;
 #endif
 #ifdef CONFIG_NUMA
 	struct mempolicy *task_mempolicy;
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index f57a98a39152..bf87258dfb68 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -123,12 +123,26 @@ static void release_task_mempolicy(struct proc_maps_p=
rivate *priv)
 }
 #endif
=20
+static struct vm_area_struct *proc_get_vma(struct proc_maps_private *priv,
+						loff_t *ppos)
+{
+	struct vm_area_struct *vma =3D vma_next(&priv->iter);
+
+	if (vma) {
+		*ppos =3D vma->vm_start;
+	} else {
+		*ppos =3D -2UL;
+		vma =3D get_gate_vma(priv->mm);
+	}
+
+	return vma;
+}
+
 static void *m_start(struct seq_file *m, loff_t *ppos)
 {
 	struct proc_maps_private *priv =3D m->private;
 	unsigned long last_addr =3D *ppos;
 	struct mm_struct *mm;
-	struct vm_area_struct *vma;
=20
 	/* See m_next(). Zero at the start or after lseek. */
 	if (last_addr =3D=3D -1UL)
@@ -152,31 +166,21 @@ static void *m_start(struct seq_file *m, loff_t *ppos=
)
 		return ERR_PTR(-EINTR);
 	}
=20
+	vma_iter_init(&priv->iter, mm, last_addr);
 	hold_task_mempolicy(priv);
-	priv->tail_vma =3D get_gate_vma(mm);
-
-	vma =3D find_vma(mm, last_addr);
-	if (vma)
-		return vma;
+	if (last_addr =3D=3D -2UL)
+		return get_gate_vma(mm);
=20
-	return priv->tail_vma;
+	return proc_get_vma(priv, ppos);
 }
=20
 static void *m_next(struct seq_file *m, void *v, loff_t *ppos)
 {
-	struct proc_maps_private *priv =3D m->private;
-	struct vm_area_struct *next, *vma =3D v;
-
-	if (vma =3D=3D priv->tail_vma)
-		next =3D NULL;
-	else if (vma->vm_next)
-		next =3D vma->vm_next;
-	else
-		next =3D priv->tail_vma;
-
-	*ppos =3D next ? next->vm_start : -1UL;
-
-	return next;
+	if (*ppos =3D=3D -2UL) {
+		*ppos =3D -1UL;
+		return NULL;
+	}
+	return proc_get_vma(m->private, ppos);
 }
=20
 static void m_stop(struct seq_file *m, void *v)
@@ -854,16 +858,16 @@ static int show_smaps_rollup(struct seq_file *m, void=
 *v)
 {
 	struct proc_maps_private *priv =3D m->private;
 	struct mem_size_stats mss;
-	struct mm_struct *mm;
+	struct mm_struct *mm =3D priv->mm;
 	struct vm_area_struct *vma;
-	unsigned long last_vma_end =3D 0;
+	unsigned long vma_start =3D 0, last_vma_end =3D 0;
 	int ret =3D 0;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
 	priv->task =3D get_proc_task(priv->inode);
 	if (!priv->task)
 		return -ESRCH;
=20
-	mm =3D priv->mm;
 	if (!mm || !mmget_not_zero(mm)) {
 		ret =3D -ESRCH;
 		goto out_put_task;
@@ -876,8 +880,13 @@ static int show_smaps_rollup(struct seq_file *m, void =
*v)
 		goto out_put_mm;
=20
 	hold_task_mempolicy(priv);
+	vma =3D mas_find(&mas, 0);
+
+	if (unlikely(!vma))
+		goto empty_set;
=20
-	for (vma =3D priv->mm->mmap; vma;) {
+	vma_start =3D vma->vm_start;
+	do {
 		smap_gather_stats(vma, &mss, 0);
 		last_vma_end =3D vma->vm_end;
=20
@@ -886,6 +895,7 @@ static int show_smaps_rollup(struct seq_file *m, void *=
v)
 		 * access it for write request.
 		 */
 		if (mmap_lock_is_contended(mm)) {
+			mas_pause(&mas);
 			mmap_read_unlock(mm);
 			ret =3D mmap_read_lock_killable(mm);
 			if (ret) {
@@ -929,7 +939,7 @@ static int show_smaps_rollup(struct seq_file *m, void *=
v)
 			 *    contains last_vma_end.
 			 *    Iterate VMA' from last_vma_end.
 			 */
-			vma =3D find_vma(mm, last_vma_end - 1);
+			vma =3D mas_find(&mas, ULONG_MAX);
 			/* Case 3 above */
 			if (!vma)
 				break;
@@ -943,11 +953,10 @@ static int show_smaps_rollup(struct seq_file *m, void=
 *v)
 				smap_gather_stats(vma, &mss, last_vma_end);
 		}
 		/* Case 2 above */
-		vma =3D vma->vm_next;
-	}
+	} while ((vma =3D mas_find(&mas, ULONG_MAX)) !=3D NULL);
=20
-	show_vma_header_prefix(m, priv->mm->mmap->vm_start,
-			       last_vma_end, 0, 0, 0, 0);
+empty_set:
+	show_vma_header_prefix(m, vma_start, last_vma_end, 0, 0, 0, 0);
 	seq_pad(m, ' ');
 	seq_puts(m, "[rollup]\n");
=20
@@ -1240,6 +1249,7 @@ static ssize_t clear_refs_write(struct file *file, co=
nst char __user *buf,
 		return -ESRCH;
 	mm =3D get_task_mm(task);
 	if (mm) {
+		MA_STATE(mas, &mm->mm_mt, 0, 0);
 		struct mmu_notifier_range range;
 		struct clear_refs_private cp =3D {
 			.type =3D type,
@@ -1259,7 +1269,7 @@ static ssize_t clear_refs_write(struct file *file, co=
nst char __user *buf,
 		}
=20
 		if (type =3D=3D CLEAR_REFS_SOFT_DIRTY) {
-			for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+			mas_for_each(&mas, vma, ULONG_MAX) {
 				if (!(vma->vm_flags & VM_SOFTDIRTY))
 					continue;
 				vma->vm_flags &=3D ~VM_SOFTDIRTY;
@@ -1271,8 +1281,7 @@ static ssize_t clear_refs_write(struct file *file, co=
nst char __user *buf,
 						0, NULL, mm, 0, -1UL);
 			mmu_notifier_invalidate_range_start(&range);
 		}
-		walk_page_range(mm, 0, mm->highest_vm_end, &clear_refs_walk_ops,
-				&cp);
+		walk_page_range(mm, 0, -1, &clear_refs_walk_ops, &cp);
 		if (type =3D=3D CLEAR_REFS_SOFT_DIRTY) {
 			mmu_notifier_invalidate_range_end(&range);
 			flush_tlb_mm(mm);
--=20
2.34.1
