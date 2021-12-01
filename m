Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 953ED465009
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 15:38:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350422AbhLAOln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 09:41:43 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:53728 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350104AbhLAOf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 09:35:28 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B1DDP4d010062;
        Wed, 1 Dec 2021 14:30:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=UFpN/KUMA9HVx7Jym8QYH6boW1Es117/PipuwsG/in4=;
 b=M/grs6jMiPujZfLX9gwThlD9l/EcZ/z/yfSUbvKlW0zYmt3roRgdp0ap+CWLBgNycj0U
 /oeqntuK89hJkZTUvr6kc8fgJQsguLG/BYzsinGeq6pQM7wBsqJn7Cx4sKPNKjZ8pel3
 EbRpxEmmRzAQ44uPt29+4GIO4c2AM/uhxrCz6YeE50gTX1MGsDggD7NJECbB0m7865BN
 wijvpbTTIW3jPLiSWouaswHdq4GLPOV1+3jKJtR1b5Jy0IxojShZNU1plV5myZHiOQQF
 AHR+XXELdskuazsDnlNhe53gLdJW6wm3IBbpnAOfwzILQLWVqCAX1OpX0D0qf4cNzYaC Fw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cp9r50e4x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 14:30:48 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B1EUNPY108922;
        Wed, 1 Dec 2021 14:30:47 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by userp3020.oracle.com with ESMTP id 3cke4rv5ew-11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 14:30:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MoFhVi/5Y0F/gNsjkv7rBRjybXQ5/ID76zfg12NdBcoA4kF+ck7RPnpLyZbp93aY7wC8HCW5HvSckq3GdOrLiOxRnl+6ZKjP9vMQSO+UqxD7XiqRK82xZ7kfBAPoxvxgF2JlLEqdhG9HNDoMUvZEeI8fxU9bxBzKDBRhRIvkTilBlzjb00ZcZ5JumFonzZr0m2mNQSFoSkctHxGrVTFqIPci+SkvUS3kWUubi0RGIlZBemEvHKKX5S0hxOnfM6rPxRf/jCMCjwVo3qpOy0Ar1OBCo6VNUr4cg5WiytKPThtA37FPuuY8n/NmuaCATIoET/tDuHi56Ka8u2NmDjDG7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UFpN/KUMA9HVx7Jym8QYH6boW1Es117/PipuwsG/in4=;
 b=dNcUVS7lMBAdfDmXBIu5xke9S0Xjg+JBGhIOhO52gSA8ycrfk8sEj7tApMp8YQr51W/DCAznNULhuH0Nzko2mYx+NPVUxMQw3OUi1+2OwyWxBNhnqkTjiRSUOYQrWsc1tY9GXcFI2Ykk3nVFDkmrKGjOYjDKABhnnbzaU+9bUdizZ8C3h2tMg6F3UWSFhnLAimlfFkuCrWRURW7RlFIRGx5li0AGeR1C/mmqijwhtRKbpLTZ2e8NC2eFZINJRoCz2QNyhiJbUMUFKoAiQL/2xkiHqV0Eyb/OAxSIPRNF0bc7imlWS2Gw/WnTThGaxj8oKi1pOVkiOIuWsjYDCyW34g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UFpN/KUMA9HVx7Jym8QYH6boW1Es117/PipuwsG/in4=;
 b=MhTzF7h+frqdvdMMSn9WfUnDqQD8Iz6x+uG0aUpj/vTAK4iC56wMFDGF7KfdNhws0XYEWfzYdxlzxJzIW81B29T3rzuYce1KgngI93tt6hCeoy2/kasVAiCja5qgI10LQtPxZDdRjWFdVH3ZASSeH5NMspxBIWKQMporpbDgjMI=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SA2PR10MB4508.namprd10.prod.outlook.com (2603:10b6:806:11d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Wed, 1 Dec
 2021 14:30:39 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d0:8291:84d:ac66]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d0:8291:84d:ac66%7]) with mapi id 15.20.4734.027; Wed, 1 Dec 2021
 14:30:39 +0000
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
Subject: [PATCH v4 46/66] perf: Use VMA iterator
Thread-Topic: [PATCH v4 46/66] perf: Use VMA iterator
Thread-Index: AQHX5r/yrudiRO5KFEGLXGo6FgGccg==
Date:   Wed, 1 Dec 2021 14:30:11 +0000
Message-ID: <20211201142918.921493-47-Liam.Howlett@oracle.com>
References: <20211201142918.921493-1-Liam.Howlett@oracle.com>
In-Reply-To: <20211201142918.921493-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ba0fcdc4-7dc0-4d9c-cd53-08d9b4d7259c
x-ms-traffictypediagnostic: SA2PR10MB4508:
x-microsoft-antispam-prvs: <SA2PR10MB4508CC9A644CCB2670351129FD689@SA2PR10MB4508.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xltZo4SpS5mTQoLQFqklEZ3MOhoVf9JgsYwaLClRHZ+PmKfiia/f1lT24quT4ueAnejw/yA0Qx853OmlKiTX6m7cgE7cDwY9Tk11Fdb4W3YMHoj3AVuZT0JRo0I8caxoz7kdzTQl4e8LatNlnRfFS1lqsiY1kn3xzWHpCjZX4ki0+vN78HnC9exdfodXl+J5PbfYjtxN5emeAV/JuQQWYCr5wymJVEk5oSSQa07Zs4ymEWounMIbjziNfRVN7xQzR2khN0OW8uVr3nrDVThMIEEo9Mg5oTLuzNFpnul3/MnukEVawoyrSbfk4tfShdhKTKF8HmHR5MVAY2qqcgsyye3uxAfgGYYkbp6xniDN6FzERehcUQC+GFBbh31x+62HjiHN3SQz8fovjEG5U7zyJtjBG79l9CoqPSkrD97yKdfy0tqdRGpIOnaZ3UQhwk7SMiWRS/tFI/4WdDfjAN0uKfJA5gQHat62yHHOC65qIa98kwaFpucKHelMKkvE7R1aMSR+tIQisHDyd/PFGvRX1550EvTqpwkfAnT3YWzjXNI1I9UfFa2sATFvY0hz2vZbII7jtQI3J7UHTur4HQVmaWtHwBl108AZkfz0HJbRXHj4PCsYpnBHUmK4C1JuR2tBcWFUau5TEvsDzvGkvc8tmDQmjfxe1H+wCAA3b2FUs3pjO9kWKGqRvgahYfRWtcp/RFvTNTLjrP8UFIe7QmUpVw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(186003)(26005)(7416002)(1076003)(2906002)(8936002)(54906003)(83380400001)(2616005)(38100700002)(71200400001)(66946007)(86362001)(66446008)(8676002)(6506007)(38070700005)(6512007)(6666004)(122000001)(508600001)(110136005)(6486002)(64756008)(66556008)(76116006)(91956017)(107886003)(316002)(5660300002)(44832011)(36756003)(4326008)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?yMOV9lW5SVtAH+fz8eA/uN35eRZdRfcCaXWtV+JTNOIc39NtYFZI2jAlb9?=
 =?iso-8859-1?Q?zgrmT8mJ+pRLlKANHbD5Q9Oth4mxPSbIZd2HhxoMG8aq/Bg81juVVc33tz?=
 =?iso-8859-1?Q?Rj931+iCmgiY6nWbK36sD76eEww+poPU/QvVN4q0u1XowVlJzJeas3wqbr?=
 =?iso-8859-1?Q?O3SwlnII9nA3JvRC0Wf1HhfTTSNLN2nyr7k3hOFWc0MwONSip8I8bicOE7?=
 =?iso-8859-1?Q?3OIpA7ZSfWW1IHFuUbaG3Q8UcJ0EjlPTjEswltUmULi5wRSDXPUgmxcRAf?=
 =?iso-8859-1?Q?M8KbHIa7iqUnAIm4ccqYIeZJf/a4kKPgK5mAMVrvynL5tBei8poNaI6vt+?=
 =?iso-8859-1?Q?b/jC1yCjjZW4Kdaf03jkZ6Em8yakkWZ6XBB2M0ETqlCaRG908BWNFAqoBo?=
 =?iso-8859-1?Q?oxMhLveUMsufeXvbrqiSqeeMHzT2X0nwRPDNCgbJGu25ir2AteYvKFQPzu?=
 =?iso-8859-1?Q?Elc20KcU5frT6sRAIc+v97t/QGzvTNr2n77j9kvGZltBd2sQDO0Q7/5F3F?=
 =?iso-8859-1?Q?nn9zt9RDms+uoZzba8BaLkKAcucZYYyKLlDCpV2/dOtI3FmYnC5HHoA/rW?=
 =?iso-8859-1?Q?/vKB6qHNtAhdx0V1M2QRvehrdb08M8O95wz8R/bsmSo70nhPaMlJ1hVysc?=
 =?iso-8859-1?Q?MehIj743zXp+qev9WLXrg5iesokd/hlvwufLADZcsKZxhG4T72DokBLGsM?=
 =?iso-8859-1?Q?HTZsPTV4LxvaLBcVdXIUfUIT+8LsFwgHR4aCkeDZfkOwg3oT9caKxXCiKI?=
 =?iso-8859-1?Q?kQoGY7vb9F7YEZlK5mHBuK3xhjJu82hvaQAsNE76flLMRxOo9rwprz5BUY?=
 =?iso-8859-1?Q?LhGDds1or4oHshrroK39NW4lvvjWCaAV3/pMsFL88V92eHijUerXXpdLvP?=
 =?iso-8859-1?Q?PlvZDElX+HQiUFOKMPOpEmar+1XRdc5yT7Tr3kLIC3Ipm7YXNlVIFeBLoo?=
 =?iso-8859-1?Q?KqRhtuQQh0mJGQoiGMYRRoBnLl3anmFQiCoJOzxgOvPIAkYxjowRUcPY8d?=
 =?iso-8859-1?Q?EHxfnW2khkyW2G4xFDIKocMHGYiGGy7A6FglHX4j3jFvU/tSVd+U7VXSHd?=
 =?iso-8859-1?Q?stO9/rAI8T4eqSz6of9W3LbZoRccXK8xdmgHzVpTtPnhM3WFVUxIDd7f3E?=
 =?iso-8859-1?Q?0EavpmPs9tfKlNi2dJw8uBoNDgG4OgfpIKgRDZuDo+NX9xm53Wzg7QDdZj?=
 =?iso-8859-1?Q?asuHDryaMl5xp01ti/yGsI34w3sxcHsW46TvGH8Kz6jWVDRY//b4rl8Goy?=
 =?iso-8859-1?Q?OIGWB/cRaL6qzc4QsHDllffzv+5BRIHZF40gtRMEvO+/4TOJtdOaycsxN+?=
 =?iso-8859-1?Q?YSkjzm/DEmP/Db5FvJCO3LPnU1bU6onx5hkv5noxq69aRAlSsZ4gC6UPuO?=
 =?iso-8859-1?Q?caTx40oV2JSNbmgUlZ8DZHdVdOfq7Zo4YhZn2RNkOPXibWiEQLpgSDi+bW?=
 =?iso-8859-1?Q?mANs7GoN+FJyQd1cTGqEDyLUqf7Da4PkxHcgfvgojJF3dw0IEcBVAvTinL?=
 =?iso-8859-1?Q?hZqkFyZ3K/7F/OTDcgs0RSntBmmayTlSpaWBseJkoMb3MYOvwvwAGRx6Yb?=
 =?iso-8859-1?Q?HJ/5DR+21Is8sh0Fb4Bv8GmLMEgxMlXU3j+5WVJdu+vArURNJON9k4vOZR?=
 =?iso-8859-1?Q?RIcSiYcgVs1hmejvOOHtD0F7lZjZ4dG271tct+T6UyG1HOvYblxcsqiEsf?=
 =?iso-8859-1?Q?UG74ENO4ht7qKe1wyqM=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba0fcdc4-7dc0-4d9c-cd53-08d9b4d7259c
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2021 14:30:11.4335
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: imNN4nMP9RSePEHHfbNQLhU8RfbW8e6VTbURYVqtI718BpUxKuME+go0vpQ6ic+jn7fWiar3esjQVyWIKVbx8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4508
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10184 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112010082
X-Proofpoint-ORIG-GUID: LqVHJpqkWS5wfQXNFx4rCaNZqKcFYH6a
X-Proofpoint-GUID: LqVHJpqkWS5wfQXNFx4rCaNZqKcFYH6a
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

The VMA iterator is faster than the linked list and removing the linked
list will shrink the vm_area_struct.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 kernel/events/core.c    | 3 ++-
 kernel/events/uprobes.c | 9 ++++++---
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 523106a506ee..d839ba79fe5c 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10218,8 +10218,9 @@ static void perf_addr_filter_apply(struct perf_addr=
_filter *filter,
 				   struct perf_addr_filter_range *fr)
 {
 	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, mm, 0);
=20
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		if (!vma->vm_file)
 			continue;
=20
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 6357c3580d07..5dee6c41f36d 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -356,9 +356,10 @@ static bool valid_ref_ctr_vma(struct uprobe *uprobe,
 static struct vm_area_struct *
 find_ref_ctr_vma(struct uprobe *uprobe, struct mm_struct *mm)
 {
+	VMA_ITERATOR(vmi, mm, 0);
 	struct vm_area_struct *tmp;
=20
-	for (tmp =3D mm->mmap; tmp; tmp =3D tmp->vm_next)
+	for_each_vma(vmi, tmp)
 		if (valid_ref_ctr_vma(uprobe, tmp))
 			return tmp;
=20
@@ -1237,11 +1238,12 @@ int uprobe_apply(struct inode *inode, loff_t offset=
,
=20
 static int unapply_uprobe(struct uprobe *uprobe, struct mm_struct *mm)
 {
+	VMA_ITERATOR(vmi, mm, 0);
 	struct vm_area_struct *vma;
 	int err =3D 0;
=20
 	mmap_read_lock(mm);
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		unsigned long vaddr;
 		loff_t offset;
=20
@@ -1989,9 +1991,10 @@ bool uprobe_deny_signal(void)
=20
 static void mmf_recalc_uprobes(struct mm_struct *mm)
 {
+	VMA_ITERATOR(vmi, mm, 0);
 	struct vm_area_struct *vma;
=20
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		if (!valid_vma(vma, false))
 			continue;
 		/*
--=20
2.30.2
