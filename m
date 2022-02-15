Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C886C4B6F61
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 15:46:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239137AbiBOOqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 09:46:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239075AbiBOOpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 09:45:20 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC55E111DFC
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 06:44:01 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21FEhhOm030901;
        Tue, 15 Feb 2022 14:43:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=OUZsrnLeC+MA10co9wH7Xuo0qBt9iIF3VeVIf3DdGng=;
 b=T7LcLdRGbElQZtIbYPPLxdhPM0MU/aB8RPWR3zWrN2Mn8XfuLU3rwpOlTN9xrvEsvYQr
 ZeQ7avkU7nQGbsYuVvTjMC7Dgzq4eaU8UrVNLUjStRsPT2x/fHW5zF6LmMqtl65WtDHX
 HuO2KZjUJ+pksHRxeRM3VCy4DTyVLCjpfqGSj8eAGarHt1MXYbFwEsKnPIaHQdz4VVRY
 O1pmYBzv8cHCE4Y/fVozdMo5RkEFb3hz5sJUnW51MfFbnW2Xl/QaHgMdgEBF6BJXIRRs
 1zDX5lKEd5dRLk4DIn0sUp+N+cy8HgyMtZXpHg0kv28TMr8ThkjciwDZ90WUh1r+CoND wA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e871psatk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 14:43:55 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21FEeT4F145723;
        Tue, 15 Feb 2022 14:43:55 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2042.outbound.protection.outlook.com [104.47.74.42])
        by aserp3030.oracle.com with ESMTP id 3e62xeqfex-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 14:43:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UUjrmctc10jqBq3WqMqhGC4xr+wscqLbU4Yyl31PW9R2SJMhogc+OHSSAr9nUsO8y6BfVqee3g+04k51U5pKslkkkI3e4iYLo/A8UJNT3Q5mukoZd7cinicaobEfb7PKv9PrwcUL4CGIAcLUPXDVoltQimRAHxwL5QVVzxNiTk/S3tB38uMdt8ONEKEr5s8JJzaUz1qYkh2iCibxN0lXwZYlXH6JYOQ0qaYhpHjeMhNK+rkBUpRfudYZSGgdTehsAxsFFhMjT3ln1tLEX7JgVjJSF/2oSWd9RyY5HKSo9KJXWpoMyZFtJGJOJmmznBMLkMc675NRW52eVOCEkIbrwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OUZsrnLeC+MA10co9wH7Xuo0qBt9iIF3VeVIf3DdGng=;
 b=ZiR0eg6idag31tz5daU6qmaWJHV4mcFVkzKNoMgSy19TTzT73b8h9EIJ0sztwPX0h/s4mTpJs0UaDBqdVPf0vB1D/xO1YBTFhHdkonyCw4yLOWnSpwQwFWw6kqQnuDGNSgwCgFVIXVIegwAuEOM1BTtAKaBiaimrikSRuw8y6MuDV0W3wtydcVzyNwIbi011Anwb9Lqfwz7IhQWvRUxkJ1kPR1q6yJqy7P14ipkhF5tAgrTOcHsKKbduy5i6afOTXe8wgucfgEWAdpHhMYgScl/fKCYKW69Qs81SCNd4lCfgzA4D8OJKUHeKBcsLqFLYJz3D9pi3mGf8ZwnaAd2lPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OUZsrnLeC+MA10co9wH7Xuo0qBt9iIF3VeVIf3DdGng=;
 b=usFqaKDMpfy6dbdrhF6Qc1TPUTaicMV0y6aRaahtEAmnnGAtsfqi87B/UyAC5kM69wTxMABxuUotll8bc7T35dSasaMBTZU/a0ybY7kySK7XZAI2s0Wa650qCQ6iSjyhTk2rIeDsGhgpemB7A5m7/SQOBPtCZjUPHoAo//FHBzk=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH0PR10MB5578.namprd10.prod.outlook.com (2603:10b6:510:f1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14; Tue, 15 Feb
 2022 14:43:52 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1%4]) with mapi id 15.20.4975.019; Tue, 15 Feb 2022
 14:43:52 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v6 35/71] s390: Remove vma linked list walks
Thread-Topic: [PATCH v6 35/71] s390: Remove vma linked list walks
Thread-Index: AQHYInpdBGAmgVP8WEmjvUh38RJySA==
Date:   Tue, 15 Feb 2022 14:43:15 +0000
Message-ID: <20220215144241.3812052-35-Liam.Howlett@oracle.com>
References: <20220215143728.3810954-1-Liam.Howlett@oracle.com>
 <20220215144241.3812052-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220215144241.3812052-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fe3e5c6d-2907-45f5-aee6-08d9f09195b5
x-ms-traffictypediagnostic: PH0PR10MB5578:EE_
x-microsoft-antispam-prvs: <PH0PR10MB55783CD9A5191C0FF77C8B7AFD349@PH0PR10MB5578.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UfJwlmokMiMy1Q7924gVjOP6brxOLP/MAJS76zMcKDkmU6nW4zf0xRliS09eLRfn2zH23CY9wBN+FU6qnuK/26Kiep3S7FVOwAUL403XBDJQ/hIYwUSOL3EBeoP74+BwC5BnHED84/jn8h9V2saLaOVbJ39voyI1Ajq63TS3lYn6k31PcQXPzYoTjxZi0OS64Dt/6RnqQ788TgmqRvN85NB2gVeOdsxsPit1mlv4J+DB0yqjWy/aeh9eXPQzynfNCdykCDU1RWat4rWmlIaDhF5FpW+M704kbMhCRqIFLedn9aJErfoEApzla12EzDTM0yuGHcrHooVWeEHhbnhMWZFjGIHOjRvwDBXIptYoZnrq1EQ0dQafjs58boh/hbzzZMxZBDFYrirq08l/OYwzw12OOm5XXPtpycljcNZZPmqVy+HL6ZGb6JoMWTrh8xIZqjum2bvm5Eab/Zjp5eAfqWLF0SyMDl0XP9Sw1TGSkYvaq01wX7gLeaOAUwUoYkr/fIRm5MAxh8UO5JieMFtmzOhkr5gAFYq7aw490tpi5x4xlh3ERH/BxYbG7+kmIDJF6s+XRhS3DeKVaanbKV5/h+FuCNtlGcinizEgFZd/rRChCYW3cxuFvTNwkYdPf//110nFy/I0aqRuVgN35j1IaNrvxkigsAzVsOQgj+nK9n75tnuMZkE3xF13We9/F5D1qH0dXFPc5N+lvkeOKCijqg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(2906002)(6486002)(83380400001)(38100700002)(110136005)(508600001)(91956017)(64756008)(66556008)(66476007)(66446008)(5660300002)(66946007)(76116006)(8676002)(71200400001)(38070700005)(44832011)(86362001)(2616005)(1076003)(122000001)(6506007)(186003)(6666004)(6512007)(26005)(8936002)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?fgzELy19l9r6tZTGB9fyZITIOPGnftI4E/cAMxM50rdBH/mRl+7ko6sMl3?=
 =?iso-8859-1?Q?VjyZfIMuAHhl8zN9cQd9r3Px9uGZwu0oeYGlMXK5cQS7n+ZI6dwDKgmiV2?=
 =?iso-8859-1?Q?WbTGAyjFZUA6ZVkzz+Y0HoUStFuzVTrIygg9C9bSU1/v+KZp2TvwIx6AVN?=
 =?iso-8859-1?Q?NDhWYX6gRWgzd06IKTQjJIkycCQVHcZa2qy/BynjDTwf/G25tj3OSxBNdW?=
 =?iso-8859-1?Q?fFW/U6KdefLRQgmFqFmsk/FnaG+ZvHQHSqjD6IqVq5qlO4J9eLYK9v8sIe?=
 =?iso-8859-1?Q?9Py+ft1yIItYCfV7lVn931Xi+8ID/DkvOvD3Q+GT+nLNbWlSar1h9tq5gs?=
 =?iso-8859-1?Q?USY3uDwyDveMcO316K9WxKSWVEpzYty5hjO7Yu9xjMeBgYuGhRQKJVJ061?=
 =?iso-8859-1?Q?eCXikIWtO9JKOZg153rzFG48A4bhIqkJaTvOsGJfNQMm8Z/HOujnMMW93e?=
 =?iso-8859-1?Q?3fBv9XO44wqcGqUUNmFhLibwabKLRi4GTRwma2sa6p6fGG07JVMGNPJFlL?=
 =?iso-8859-1?Q?+5Y5lxh7W05uKExCdN7y6JQCWdSs/UFWRQcxZwG3LEJOZCV+d/gH0E4ADc?=
 =?iso-8859-1?Q?+9BiCl0FH98rfr+zeppgtkIq/2OvuKQ0mKLBtEjl5wGFv7PTIavkEw142g?=
 =?iso-8859-1?Q?tu4i4jTDNbNWxGAYXwxdppiU2Kl8k1yLXQKhyLhEv1XDJVuEWQuyAF4MTF?=
 =?iso-8859-1?Q?7PCzhFUm6gyDvXNspOXie2HeHHyKg+EeJbJt9lGzh0FYvo/ho+m1UvEvGn?=
 =?iso-8859-1?Q?1/URR024tB+QAB+dt7x+0mK9MhZnmww+4CJrzM9zhp7I408NmS+3jvfr5G?=
 =?iso-8859-1?Q?v59VxbnINGvLgjEc75jrkPa7zPrGhUs2KCp9AXZZipwG+fVUSNUtTjk4dn?=
 =?iso-8859-1?Q?HEnTguL4bf3EZWX6gqCY8WjyAtgYxp+7CW7+n5REZknu5zS8jrR+rJ0PNq?=
 =?iso-8859-1?Q?p5hzt49FHaOlaBhyOUTpYylNRcARtBbdfxTINz2IDjXxt6sgv+wk8/LJWL?=
 =?iso-8859-1?Q?bvC4Rc4x5zoMhLLP4H+CuT568Np3CTcj2DD2TCayn+vTDrVh+HDavgqPKV?=
 =?iso-8859-1?Q?l5TADF3EmC5+Ydvw/0tTr6m09OX0ihOWdaQeQfCtmqSRkYw43B5rWI0MOO?=
 =?iso-8859-1?Q?8FSAJgtqXOf2I4TKLwvhaJvsp6mcI5v7US6UpCJlYdDtOHl5ZU4vx4t9yq?=
 =?iso-8859-1?Q?b5dsZnNYHEenSDdEB2Fk8uB6W0H8KUAS8I05/jtIO2DUUc8guRY9jkCZ6l?=
 =?iso-8859-1?Q?GVJXxxkHiwgrvwCEdcKpZnhvvZuKvQ9Z9Jxr2MMO8Ju16pv9yoNGCONef6?=
 =?iso-8859-1?Q?u/ZQ0/aumwYatB2SVR4P2aB3iRo0HhIK9rS7JyzJQMORA9vvVR1rI3lfoZ?=
 =?iso-8859-1?Q?MiIsqa+zoYSesBk0To7BtfG7ZLFIsydB2fPFVBJIqKoxWOcizdbDBMP95W?=
 =?iso-8859-1?Q?z4VsSKGjT3zYaWVa0iCCdZ5wSAo2uDrJA3fPBMkU3fMlS89id3CYRDXT5d?=
 =?iso-8859-1?Q?f1l7YGEOj+UUtG3GNMLXlWkUUsLGYfXQBIopBPf6UBil+O0bCy6KtT8RjV?=
 =?iso-8859-1?Q?VX892j/mFrO3goUp8xjTdz9rY920rs+vRiaGp6pjCJjLBLMSjC5RMGg6ej?=
 =?iso-8859-1?Q?XKAppUM+i6MmwR/n/fipwWB1cPH2RZ6kMHVbAnSKXn5oQ2DOk4HMoOi9pU?=
 =?iso-8859-1?Q?PRlAsSHrstT4M4mbWWw=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe3e5c6d-2907-45f5-aee6-08d9f09195b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2022 14:43:15.9327
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ql0O8IrDXTowDEhaTXv0+os5vQRRXFsNkv6dwkcNRkN5TCswhKbi2RtWUUY1s+P2vs6i8x6Bb9E0zsDE8criDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5578
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10258 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202150085
X-Proofpoint-GUID: sCqBWSzlEMK4Q48ZKW00GaGCSB1fDSPw
X-Proofpoint-ORIG-GUID: sCqBWSzlEMK4Q48ZKW00GaGCSB1fDSPw
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
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 arch/s390/kernel/vdso.c | 3 ++-
 arch/s390/mm/gmap.c     | 6 ++++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/s390/kernel/vdso.c b/arch/s390/kernel/vdso.c
index 99694260cac9..66f7e7c63632 100644
--- a/arch/s390/kernel/vdso.c
+++ b/arch/s390/kernel/vdso.c
@@ -68,10 +68,11 @@ static struct page *find_timens_vvar_page(struct vm_are=
a_struct *vma)
 int vdso_join_timens(struct task_struct *task, struct time_namespace *ns)
 {
 	struct mm_struct *mm =3D task->mm;
+	VMA_ITERATOR(vmi, mm, 0);
 	struct vm_area_struct *vma;
=20
 	mmap_read_lock(mm);
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		unsigned long size =3D vma->vm_end - vma->vm_start;
=20
 		if (!vma_is_special_mapping(vma, &vvar_mapping))
diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index dfee0ebb2fac..20ae7f8f1c01 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -2508,8 +2508,9 @@ static const struct mm_walk_ops thp_split_walk_ops =
=3D {
 static inline void thp_split_mm(struct mm_struct *mm)
 {
 	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, mm, 0);
=20
-	for (vma =3D mm->mmap; vma !=3D NULL; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		vma->vm_flags &=3D ~VM_HUGEPAGE;
 		vma->vm_flags |=3D VM_NOHUGEPAGE;
 		walk_page_vma(vma, &thp_split_walk_ops, NULL);
@@ -2577,8 +2578,9 @@ int gmap_mark_unmergeable(void)
 	struct mm_struct *mm =3D current->mm;
 	struct vm_area_struct *vma;
 	int ret;
+	VMA_ITERATOR(vmi, mm, 0);
=20
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		ret =3D ksm_madvise(vma, vma->vm_start, vma->vm_end,
 				  MADV_UNMERGEABLE, &vma->vm_flags);
 		if (ret)
--=20
2.34.1
