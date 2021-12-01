Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22C1A465011
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 15:39:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350754AbhLAOmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 09:42:22 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:43770 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350182AbhLAOfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 09:35:51 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B1EGXgI017179;
        Wed, 1 Dec 2021 14:29:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=qPUXANS/+3MnCzF8TwO6wHkbynztV9tHawAwN4AOS/c=;
 b=taUhp5G9uHihWZsBW3lcxWLc3Cdbs3dqQLrcwndf46pww8IWssGYjJZekYcIlbycvQCz
 vqJPSU+k+cROwyudgPu8iiWbGI0QkScdiuiKz9Ng4tPv5bmGaJI8jofQi/SmBlskrIjY
 pms5EmvBP2zu5+WKGQdRk/nA/xuKZyow/CAtFz0XnAHBTKyBu+4IdxW7XQ9549Obg93j
 cqomdHdjCa/qI6cFq0zSTa91PqY82Ti5yygOoo+aJhbe0WAJm2Gm1NIFGqiKCyA2f47p
 1fcaWjUkbN91Qudl/XW+1EmeUNb+PqKUz6y+sQGDttW/d9cAx50rv+nYiDGxOABisJeO 9A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cp7weh2p9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 14:29:57 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B1EBMFF049269;
        Wed, 1 Dec 2021 14:29:54 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by aserp3030.oracle.com with ESMTP id 3ckaqgkcte-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 14:29:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ghTwCoUtdkzWTSk79ty/Sn3PRaBkvDYgD4HtHO8Mo5gGjZE8vYEz0aQXX6dfNE9T1vACwBST8i6vie7mI0JHuqtukT+ckCl5V+5rzNcjBTkfSZQvCMnxiJMQUeCN2d4NqsjEbR4CLoyk3OmMxfE/jHfhU0UXjhzc7wp52pdY0fFK/OtzGTjj9WePEAyFC2BnCnDFpm3QH79EDqg969R0x1HP5ZXHludX+abuAM+I3LI6NPbGlTB4KkHyou67GI8xOZTFNNXsFGYVJaghCQ/UcPreVjSmSdoDB7LzouVGSvJ0/HlJi7uMkDhw2zgqQtzjA0x0x4GCJm6XbQQ7uxEwcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qPUXANS/+3MnCzF8TwO6wHkbynztV9tHawAwN4AOS/c=;
 b=juVtut9Oo3q4IGjffwj85S7zsq8QVful1uT02kCZJIiZDKkQ0kXznqkaywPKhO+oZq8YyVZoy2ATbrqVt5vMm3fNDTBVy8LJhEkjmsxyo5UtLedzeINzFrbdpYgo+zVuT0G82Ba16FeOLE7jS8nkAVs+Vh0ZIO/X55P5ZvX+OESRoWpgHIUUOHhIDKQp/vAScbsO+VU4mMxw8oi/2PBjf3cYtEGpv7JjOQMyKbQUUAV8UVyDvk6L69C/m2xbCCsypdrI2jCwLOG5yoeDFa0h2kbZehNo+ZBZn0NGGA/ZRT0EziCz8RaROYankuU6NmyeZi9tq3IjNJkUFUJexHBV9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qPUXANS/+3MnCzF8TwO6wHkbynztV9tHawAwN4AOS/c=;
 b=ZXzKQGi6AaXRKYhsDdzj7/XBNcqbU2rxsaPnhJLF6CjESHxTn4Ad2u7DWYW6HlNxF+amz8sw2jrKFg9BT1e8iYPIAGLfj3rFHV3aieXD4D5XPx4vnNnbjtUsKw5HiZVDJ4mNLPfU82/sTwk+YObaW7x/K+VFxspMgLe2GLv9zkQ=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN6PR10MB2768.namprd10.prod.outlook.com (2603:10b6:805:4a::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Wed, 1 Dec
 2021 14:29:52 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d0:8291:84d:ac66]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d0:8291:84d:ac66%7]) with mapi id 15.20.4734.027; Wed, 1 Dec 2021
 14:29:52 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Song Liu <songliubraving@fb.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Rik van Riel <riel@surriel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michel Lespinasse <walken.cr@gmail.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Minchan Kim <minchan@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Rom Lemarchand <romlem@google.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v4 07/66] mm: Add VMA iterator
Thread-Topic: [PATCH v4 07/66] mm: Add VMA iterator
Thread-Index: AQHX5r/m765iFHbPa0ejviOTbVUOwA==
Date:   Wed, 1 Dec 2021 14:29:51 +0000
Message-ID: <20211201142918.921493-8-Liam.Howlett@oracle.com>
References: <20211201142918.921493-1-Liam.Howlett@oracle.com>
In-Reply-To: <20211201142918.921493-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b1f7e999-e1b0-4857-92b8-08d9b4d709bf
x-ms-traffictypediagnostic: SN6PR10MB2768:
x-microsoft-antispam-prvs: <SN6PR10MB2768FF4525AC505A008E7726FD689@SN6PR10MB2768.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1332;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nTheGkJ1Z2N7wtzBBF2JXntgUn+hGadc2MTuR0WnvTRho3kX5V5vYgP23BcZurkGtTXOABqFgj7uf2eDx84Zc8Kb57MPL5vCQ1FtRkGps9bj+AuI6uCwfzZwMZdqFZDg84T1SB66xsTzTQw6oCT37M4Gm3P/nC34aaqsOtC59SWd3rvtToiOie2Maq67QTf7yqgBTaFdRU36xrWCoKdu2HZyIfCcwTZhANpCuBiIYEYi+xWWRKxSl8ncmLA7jMPq7PS9f/kVdVMWGd9TsGOzdsAvJ+F4pMggrJFasKE/CqxrsrVbn/VxIHSf957lfFlrkkIb2wWU1k21MFf5tI6RaSpZ7HNHskrz2Xma9iSm7M8O0akHbO4jT5voagWU6OT1iZZo6t9Dev8NMvU91NrkXzb9UuEPd/R1YyPMsAIlSuvCISZ23jYqAOfZQ3wvtrCPROO5RicagLA6JIlNalO3+LxSY2qBLJRPShtWHUhkfRILOJiMLuV9QUXCELIzJMmJXuDfbBh3ygxEAkUiwjBxxHPOWaA+iEBOGBLDrX8FQjmZzf6Xo81/xyqVhI113/ftnzhf9mjbPZVAvdmFaEY6B7ZVk4cwPahNmBfXst48G+2VY5Ry91SdLYQTPAfKeBgFhFHAIWKOiwdknil0caxDvnhfNO1Muk5AcVjYNpFJK4snS6oQQvSRW9gkbKp9EN25RUownfCOjNyt8BwTd4V6Pg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6512007)(508600001)(66446008)(64756008)(66556008)(66476007)(44832011)(7416002)(66946007)(110136005)(316002)(36756003)(122000001)(6486002)(54906003)(2616005)(4326008)(186003)(91956017)(5660300002)(71200400001)(38070700005)(26005)(8676002)(86362001)(83380400001)(76116006)(2906002)(1076003)(38100700002)(8936002)(6506007)(107886003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?pwUHtkVPYnL8Wu2ulFSvhm2SuU0QXsVfDGR+S4ExyKzwkGmKQ5TBho21PP?=
 =?iso-8859-1?Q?IoroJzXTObsusK2kgubun4kr8rVVDVYMqtYx7al8tv9lFpElhkkgAE3bqP?=
 =?iso-8859-1?Q?1GcuKQ94XF5PDUisa4ZJv9dXKzAT2K/JsGVhmfrubg25EsslIHJgGNWoNr?=
 =?iso-8859-1?Q?EH9BkGlj0UqGnU6Z9SwTrwCYiG40DSk4cUvBIuYX9VjuxP+XJ3HYO1Z6MZ?=
 =?iso-8859-1?Q?Uywp6XtTAMF+Vdq96TcqT40k2xCTQ2wGy3EIwGaSxK3fCS0xQOUDUz3lze?=
 =?iso-8859-1?Q?wF2Qf6DcQkEKUyjrzmQhkPGk3esFxs5uBJDFvv62Ze4gqf6H1P5nHPrypu?=
 =?iso-8859-1?Q?+nv8ASssEnZjKiEV5T0YmRLmv4h15w+vPer+eOBmLnUbMf5fS/t+NCe6/J?=
 =?iso-8859-1?Q?ul+4MAwS/6aolF4OcAGdzyWlce24JKn918zg4GGSPDS12HayiUS2JLbALg?=
 =?iso-8859-1?Q?C9tSpdZxsVB7pb8fixZH/JoOAxjtjX8jW5FmFY/SNWDG51YcGCSMVi6irz?=
 =?iso-8859-1?Q?js1/gfK4l6I4RPJuGiTxVTb+T1BJdI9IQJWEZ2IrliWGZO8o1k9J1WiHUq?=
 =?iso-8859-1?Q?Y6INuRHEdNm30qVOKUVz8kMJojSkKuNHKbcHIVafHGWXto/bX/6h6IjyZG?=
 =?iso-8859-1?Q?dTzvznWDwmPZzuBm7Ycc/Fu/btRJ2dOWsKWQ91UeAII2+FjTtboRoNCwHJ?=
 =?iso-8859-1?Q?i41x3NkM+DMjdJhwReyfhByUiP2ynOS2Uk8gvovpD6A/gisXowNKBqrJ3K?=
 =?iso-8859-1?Q?AeOb0qdkLSIwLellmNQe1C9ab+9VGZTWpxG69HWcVAFccZKqW2tw6DgXY3?=
 =?iso-8859-1?Q?EvtNVNZeEB+NAF51whKRcZDDwoz52HDo1QTYVZPP8OX5MYWpaPmFkqOqio?=
 =?iso-8859-1?Q?nRN6mINJo8zu9MmUZ3JaGmkD33PdjPTvXUNhxuZyzN49AFtPfKCBuCZ/YT?=
 =?iso-8859-1?Q?AoY6Zepdtl4/TkFlTuRzRYGiTV0VPPsBzmbfrsV0YCHEtlGjvBkcsga0pF?=
 =?iso-8859-1?Q?Nk7SR4cDxBwcAmqr0xnUJq+R3DgNvf0lJAoogpev7hPxZzx2iBiMNDItBI?=
 =?iso-8859-1?Q?sntpxEmZiPwsQ2WJfQva+STz9XPx02430RQB2vpzRHTXhQ+EwMt05qO8eG?=
 =?iso-8859-1?Q?AMOGyxnRDZe/GLIMNnJGnMdTMfpJblvrO94cK95hqrEytBTf2oj4253Ib6?=
 =?iso-8859-1?Q?QkTAew+h7jqYS3FD1frnQr1pPdE1Koi8HjnMowSK2Ao83gH76ReKY3Fnnb?=
 =?iso-8859-1?Q?+/Rsh6S4LfgV45GYv4YJM1j9DHQjDOqTEWnjHMSHJK9EROqDVbon26xeym?=
 =?iso-8859-1?Q?fVdu7EAKxHQyrMcyF8P7kSPDU4brRzwUocb59KLhgfQ70dCCZbGsjPYj8I?=
 =?iso-8859-1?Q?kEJ8ImeV3oCDk1r2PSFrgT64XszLPjepOpZmRzH8YH+Rr31rAruULmkPmi?=
 =?iso-8859-1?Q?b77Drl7moY20JDQEfCAPx1u1haCg5iDJI2ss+xK5tGk2d7ef7tDVB8SQYQ?=
 =?iso-8859-1?Q?d61KF0hQWj6fcng5M0lZxKBMYJlexEe0xe5rUl/FMqn9rmG+7V3k1EZ1TR?=
 =?iso-8859-1?Q?L4YeOC7BY/WiSNGhTsjrFS2B3D4Bw+ueg8Yh4F4HhVwpagndxLyqNHiTs/?=
 =?iso-8859-1?Q?yIPeEnqRr4u0+Pvx26nhv93YBWR/L17oP2+W1bxkNiLEP+XavLJh4k+h2V?=
 =?iso-8859-1?Q?9CCUMic7KC2grMo0ahI=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1f7e999-e1b0-4857-92b8-08d9b4d709bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2021 14:29:51.6368
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DluY6L2tPu2g0gqVhwGnZL+mK+8U4+Ti4oXwG2tcHgltHWues4d8DzheCP4UeJGwoD171s8ChJQ/kkhsAOL4QA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2768
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10184 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112010081
X-Proofpoint-ORIG-GUID: SrMVDagNO3cx1jOjHRey6ncOurrZOGk6
X-Proofpoint-GUID: SrMVDagNO3cx1jOjHRey6ncOurrZOGk6
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

This thin layer of abstraction over the maple tree state is for
iterating over VMAs.  You can go forwards, go backwards or ask where
the iterator is.  Rename the existing vma_next() to __vma_next() --
it will be removed by the end of this series.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 include/linux/mm.h       | 27 +++++++++++++++++++++++++++
 include/linux/mm_types.h | 21 +++++++++++++++++++++
 mm/mmap.c                | 10 +++++-----
 3 files changed, 53 insertions(+), 5 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 9eae78a155be..acdccbe9b96b 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -696,6 +696,33 @@ static inline bool vma_is_accessible(struct vm_area_st=
ruct *vma)
 	return vma->vm_flags & VM_ACCESS_FLAGS;
 }
=20
+static inline
+struct vm_area_struct *vma_find(struct vma_iterator *vmi, unsigned long ma=
x)
+{
+	return mas_find(&vmi->mas, max);
+}
+
+static inline struct vm_area_struct *vma_next(struct vma_iterator *vmi)
+{
+	return vma_find(vmi, ULONG_MAX);
+}
+
+static inline struct vm_area_struct *vma_prev(struct vma_iterator *vmi)
+{
+	return mas_prev(&vmi->mas, 0);
+}
+
+static inline unsigned long vma_iter_addr(struct vma_iterator *vmi)
+{
+	return vmi->mas.index;
+}
+
+#define for_each_vma(vmi, vma)		while ((vma =3D vma_next(&vmi)) !=3D NULL)
+
+/* The MM code likes to work with exclusive end addresses */
+#define for_each_vma_range(vmi, vma, end)				\
+	while ((vma =3D vma_find(&vmi, end - 1)) !=3D NULL)
+
 #ifdef CONFIG_SHMEM
 /*
  * The vma_is_shmem is not inline because it is used only by slow
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index d9ce412fca04..b0c3494011bb 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -675,6 +675,27 @@ static inline cpumask_t *mm_cpumask(struct mm_struct *=
mm)
 	return (struct cpumask *)&mm->cpu_bitmap;
 }
=20
+struct vma_iterator {
+	struct ma_state mas;
+};
+
+#define VMA_ITERATOR(name, mm, addr) 					\
+	struct vma_iterator name =3D {					\
+		.mas =3D {						\
+			.tree =3D &mm->mm_mt,				\
+			.index =3D addr,					\
+			.node =3D MAS_START,				\
+		},							\
+	}
+
+static inline void vma_iter_init(struct vma_iterator *vmi,
+		struct mm_struct *mm, unsigned long addr)
+{
+	vmi->mas.tree =3D &mm->mm_mt;
+	vmi->mas.index =3D addr;
+	vmi->mas.node =3D MAS_START;
+}
+
 struct mmu_gather;
 extern void tlb_gather_mmu(struct mmu_gather *tlb, struct mm_struct *mm);
 extern void tlb_gather_mmu_fullmm(struct mmu_gather *tlb, struct mm_struct=
 *mm);
diff --git a/mm/mmap.c b/mm/mmap.c
index c2f1431886d4..9fee6e6b276f 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -626,7 +626,7 @@ static int find_vma_links(struct mm_struct *mm, unsigne=
d long addr,
 }
=20
 /*
- * vma_next() - Get the next VMA.
+ * __vma_next() - Get the next VMA.
  * @mm: The mm_struct.
  * @vma: The current vma.
  *
@@ -634,7 +634,7 @@ static int find_vma_links(struct mm_struct *mm, unsigne=
d long addr,
  *
  * Returns: The next VMA after @vma.
  */
-static inline struct vm_area_struct *vma_next(struct mm_struct *mm,
+static inline struct vm_area_struct *__vma_next(struct mm_struct *mm,
 					 struct vm_area_struct *vma)
 {
 	if (!vma)
@@ -1286,7 +1286,7 @@ struct vm_area_struct *vma_merge(struct mm_struct *mm=
,
 	if (vm_flags & VM_SPECIAL)
 		return NULL;
=20
-	next =3D vma_next(mm, prev);
+	next =3D __vma_next(mm, prev);
 	area =3D next;
 	if (area && area->vm_end =3D=3D end)		/* cases 6, 7, 8 */
 		next =3D next->vm_next;
@@ -2815,7 +2815,7 @@ static void unmap_region(struct mm_struct *mm,
 		struct vm_area_struct *vma, struct vm_area_struct *prev,
 		unsigned long start, unsigned long end)
 {
-	struct vm_area_struct *next =3D vma_next(mm, prev);
+	struct vm_area_struct *next =3D __vma_next(mm, prev);
 	struct mmu_gather tlb;
=20
 	lru_add_drain();
@@ -3028,7 +3028,7 @@ int __do_munmap(struct mm_struct *mm, unsigned long s=
tart, size_t len,
 		if (error)
 			return error;
 	}
-	vma =3D vma_next(mm, prev);
+	vma =3D __vma_next(mm, prev);
=20
 	if (unlikely(uf)) {
 		/*
--=20
2.30.2
