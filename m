Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C02264BC13B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 21:34:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236277AbiBRUfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 15:35:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiBRUfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 15:35:06 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B0DD33354;
        Fri, 18 Feb 2022 12:34:49 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21IIhSNG007058;
        Fri, 18 Feb 2022 20:34:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2021-07-09;
 bh=mjRLopMwDXjigbAwuugYvkgDKJOpMX9Uw1+/NzjcWFc=;
 b=O9HgrO7nz/64Pon/LPu2Floa/nxPlaWBzzaX4V0Lr0Y7FDSpuHUjbIA2ZGIROKsdtvmY
 3RAnPOzMPTgzDCvtbedRwrC1pWrcv2x/brOHVV4lBGUcA7jIpMcj4UvaJaFtnbpCm6RZ
 II0JCEEYboMS1W+9C5m7/jsltX9hPTnRmkhNzc5/URH82fDAFdUxvemZOW24TlDfnUf4
 /mKRDnqdYHD7Ew9Rqn/9lSamOquCnopG26tPCo01N7/xBg0Ubd/qGoM/t01YlGC5k8pO
 IiqN3kbjQI7aU0E8tx7NOtVyDpseyrCfOB50MydM5VQtjUwj7rQ4KZAhecqsBrVJ8yxd UA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e8nr9av7q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Feb 2022 20:34:35 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21IKUfKR170742;
        Fri, 18 Feb 2022 20:34:34 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by aserp3030.oracle.com with ESMTP id 3e9breb3xt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Feb 2022 20:34:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EPsVYgxoPtSO4OoWF1Mp/YWTpvjogCwmK+qSwcpIflRl811Wrbx7480ZhjyB0TIncjXZJtWvhPmHto+DyJuF/NWBE+rxmUY7CwlLnxV8Ujqmqj/JLnbaYxB+DHPvDHyRSuJb2pheomIul1fcH/qNyQVOPR395arnbCNj+UXBlhXv2E3GDykex7EljKDsMjgzv9IxKHW/F93EqZvR3Fa6PnA0Ap3pRC8rGrdMrmk3gC7q76AWeYDUBowXBajwAvj8bhf+bAYj92CWkaw5USyc8+lJbcsNfFPfASkchLl3SGkcJlh/E2mj4CFNWUsSrFmnNIKx/i1uNm/j3b8DW8pW7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mjRLopMwDXjigbAwuugYvkgDKJOpMX9Uw1+/NzjcWFc=;
 b=bRzkYB4Zt9Fi/AfOWYUD7QLN60jQkNs0hysv2R43/MN2b56NYhLBzW51JM08WVHLOaav8o1z0n+Udzs0SKJsNtmzmOe7Q37ZHl1Xboq0v07a6m2xDuhYRMqmuqf4PQacobAOdLpiEYPH20+lMmCzXx+iYFIWL6gaCmsaP1hMrL4tSSrMXA1Yo/unsMbgxN8xq6HMwjJ+jNLF16+T2Qm9EGqqr1aHi3Xp6S3di3popX/z4mS0V5R35LMLWliOU8SwHQ6Nk5/BlDT6HGCi90jje/asoJqcYx4i0Y6aVzgvdOM/Q8TPcnfRusdW/aBY4Wgr7IqS9F8Bm252LTE2s4ajCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mjRLopMwDXjigbAwuugYvkgDKJOpMX9Uw1+/NzjcWFc=;
 b=nSoFwjnIJ7moxfG/vPT8P28iTJLyearHa4rmfPew/VFi60eQjwFK2yyThNVbAkeBS41NI6XmMJt6UHJquFcPp7B10QHAk/QI89GuxjmiLwArUtKvMUBVVmccBRi7/wo4QDK2PwQqj1JLPnR72yRA7WjR2lRweXEsozBHQHxpKbs=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BY5PR10MB3971.namprd10.prod.outlook.com (2603:10b6:a03:1f6::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.19; Fri, 18 Feb
 2022 20:34:31 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1%4]) with mapi id 15.20.4995.023; Fri, 18 Feb 2022
 20:34:31 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Helge Deller <deller@gmx.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: [PATCH] parisc: Use the VMA iterator in the cache handling
Thread-Topic: [PATCH] parisc: Use the VMA iterator in the cache handling
Thread-Index: AQHYJQbuSUNoa6ShH0WeS5y3Qkg+Tg==
Date:   Fri, 18 Feb 2022 20:34:31 +0000
Message-ID: <20220218203418.831810-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 85f01349-cad9-44fc-8e96-08d9f31e1142
x-ms-traffictypediagnostic: BY5PR10MB3971:EE_
x-microsoft-antispam-prvs: <BY5PR10MB397116A108253FD571DD7524FD379@BY5PR10MB3971.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JVObaZnA28n2sgxbwSUNxoLd1H7NFLLRdu+hQr8YWAepe7yXd5ZPgRMxntvNLXOh8AVDyG3buPNm+IGiIZvN1iutyvUh1eK6DirPYi9WQRXVIUpsWq20wbLI5y0xL1/P86CpTMBA6SyLYmu/AY38+JQy9MKfF7S3DrMsVbLZ5AyXI3j9Ve2udH90Rz3hTeMMunNHYtRBop5BK1Me9dSO0z2lF9cXeOsjCvSmpHEYbqTfAyblcfr6DhZ5uFWZcjm9Vxm56QaP/+Vpx9I7PtUiQ/ZmKrDgQmUXgQkZOB0g0WMlAISt8yQtSdrHoIvFPEeNhqd1G2d0dDeaGwhvjW9ux/bStXAyvXnCLuDlja4O4zDNduz19jD6tccKRW4tOhK8bTfLNvEs7K27RbqtKelrYCXOTDDhq+vOxVakqB93H2JAbTSOvqqvSR/PiRXs67e4Y42R3WCk12+yR9dfH1P0X4CoXgTlSJ0TGjtLpmN/WLWqyjJg3FA2PtZy/gWNbr5M2tTK720X1O64hnYu5lCl3GHAQq2bNEc9PprXIoou2Q0TO+MfZTIggVsnThyw1rSITGYT98oUEhVGfax6ukDUYYulVjPROYDPYferwN+EsoZSj+9oThRXfdOhWaXyyNcQNfRDsx0QbyhoWAtitN/SpmehEKLdg1BOZ90V+n504L/Vtbvw4RUHR7vtHk/Kh+jvqI2utLQfMa3k/M8jA9Tcxw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(26005)(6512007)(86362001)(91956017)(4326008)(66556008)(66446008)(8676002)(64756008)(2616005)(76116006)(66946007)(83380400001)(6486002)(54906003)(66476007)(110136005)(8936002)(316002)(508600001)(5660300002)(38070700005)(2906002)(38100700002)(122000001)(6506007)(71200400001)(1076003)(36756003)(44832011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?/KmtWYk6+/HAZPbqjPAunHLlWz//uZSVtUDPn/KweXx3ZVK860GBVF0THn?=
 =?iso-8859-1?Q?GfUKrHKq8cA842jmimIkn8ahCUgR3cQjtbczpcScb97UFNYF4/kVt93yPM?=
 =?iso-8859-1?Q?LZOUdVi2FXRQVGjIbqr/9yXkWy0YwKQ5GAyjurLilJT+k05+iQUwerUu82?=
 =?iso-8859-1?Q?Xl7PQRuq0EYtMOGW/CZGVTJ2l0AQWK4wAZv5EzhUQsmkORcrXsB5752BYi?=
 =?iso-8859-1?Q?Y0JEeWZp6x/aAvglysopBFZ9hRZmI17t6G514YRHw//PHfhAq91mrPJOoT?=
 =?iso-8859-1?Q?MVSbLRWYcDupLQYXhejDXe+FJHHTVz5f/tgwU7z2SDEmr8/XvlwbeLTBK8?=
 =?iso-8859-1?Q?tKFkqBq7cp6Ck7BXC5kVF7rDhA1R4DJqRy8+uVjsJpPmBzIyxWjxfvaDBu?=
 =?iso-8859-1?Q?XOj/tuSw91jKu2p9/mQuYvUZMx4C/FRtx/nYZXiqUkbAbSk0KU8N42HfHv?=
 =?iso-8859-1?Q?FeSaV+u0wqWLCxGrmsY4ewHUX2Hy/IncrikuP24/ghL3Lj2I5ldhkp7+el?=
 =?iso-8859-1?Q?/dH5YyTHTCwYDq+kEE7ln95NiRzyHZqy5pqawoFLuUdgtvVosZMRTmCxJZ?=
 =?iso-8859-1?Q?1ZDXxIwP+H0fji6z3oRZbZItY6wMhnXqb+PnGHx3yhCRBl8In+8Yxsi5dY?=
 =?iso-8859-1?Q?Px6wa/Bt3ymgSjdmwvn9K9U5B8Y3fbGWAAQ9uGp5Q5owkkoE+YqSN+lXzY?=
 =?iso-8859-1?Q?Juu/IUiO7AgLZLPbCKCesSjX0VNqc4CPKEeVMyWSh08IybSJPU9YJMv3G1?=
 =?iso-8859-1?Q?1vUhLCE0WluK5ZuR+lFT3AWcXzzpCLa0mB2y1jcOUlzYAQ+ZNyavTzTyeK?=
 =?iso-8859-1?Q?15vNGvXY4MAYoYB6KSmf0STv7Xsi9W4nuDNVECDKwk/K+ELxyPlqxncGtd?=
 =?iso-8859-1?Q?P+b8Y/pq8H9qfYhEwTTAuNjuwxobwglR7OpkLulwYVHrzYzXqGauurZUgb?=
 =?iso-8859-1?Q?sIdwnzjy50VJpEo2RZq7LGpGpQVgmElmGgI/RymRlrUkkD9apKO0UeBlLo?=
 =?iso-8859-1?Q?H2heyE75yiVFR8h99qO3VwoDdjSYErATckyTLTa5TZiIsfeXQQa62MDX2L?=
 =?iso-8859-1?Q?AqRH/CRAfe/ZSsJDt3ZxzL72oJlmvnQ+VYDV1Qux4VEYy+4MJPimBCNIxW?=
 =?iso-8859-1?Q?uy48T4RHSzu/ddlo8OfNYgDYS8k0pXYp4P3z+0r67CWnzGRl2SIEqxXJb3?=
 =?iso-8859-1?Q?FpKSyjFYoSymndwRbE5DnfRIdL/cLDKyqu/a2O2F6xSbggOq4OUwIwYNpk?=
 =?iso-8859-1?Q?MsyKNXqh7E8oPSUeD9NvW20th8lwL8Qcjb3dMg0hT9WrNv3zv7JhGX77FV?=
 =?iso-8859-1?Q?1j2guzwA/3jnHfn+Kto7wdMiVHecSjPkkmAKW6lTbqPEr9CqfMwtkqnZKp?=
 =?iso-8859-1?Q?6L/zxG/uk6tvyVtLrQli88Ph01eyA9uc1sxcaLvSUw/E4DZru7EDbwsImE?=
 =?iso-8859-1?Q?T4wi7/QYhpBRzi5RKQVJIJ6Fdd2hnsQYxdxLIls5u+sY5XBw891meZh272?=
 =?iso-8859-1?Q?X0teLMBH3sLj7ZlX3zA/V+2gL+lnHS5YyFE1DGwUf1eQhaegwvKGh2tDN4?=
 =?iso-8859-1?Q?UCL80IXdz+Cj+0TU8GM4cT1Luq/0LVFPJSZW7pkJO36e8BHtiX10f2IECU?=
 =?iso-8859-1?Q?1jvDNAtXfzqMntKnDegsYvrTXh9rrs/CK6phEfFhfgbsHKNHJl/u737eq9?=
 =?iso-8859-1?Q?uS1Td5hnvRGhZEzBmBw=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85f01349-cad9-44fc-8e96-08d9f31e1142
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2022 20:34:31.3466
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zp1ijlj9LA5mdmdeuhT+Inhy/63Y79rDP8VPdNtOt8KmICf5V9qYAWljwnEOhzrHmGtDXK3Sf6IBas9r3M059g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3971
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10262 signatures=677614
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 phishscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=923 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202180125
X-Proofpoint-GUID: yzTswokC85rgbofhckVPUYHE87UsiyHo
X-Proofpoint-ORIG-GUID: yzTswokC85rgbofhckVPUYHE87UsiyHo
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is on top of the parisc branch for-next.

Helge Deller identified a conflict between the maple tree next branch
and the parisc next branch.  This patch removes the vma linked list
usage in the parisc next branch identified by Helge as a conflict to
maple tree "parisc: Remove mmap linked list from cache handling" and the
parisc "parisc: Add vDSO support" patch.  I do not expect this to apply
cleanly after the maple tree next merge, but the resolution should be
made clear by this patch.

This is an untested conflict resolution for linux-next.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 arch/parisc/kernel/cache.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/parisc/kernel/cache.c b/arch/parisc/kernel/cache.c
index e7b8e74dad8e..05b4498a1244 100644
--- a/arch/parisc/kernel/cache.c
+++ b/arch/parisc/kernel/cache.c
@@ -515,12 +515,12 @@ void flush_cache_all(void)
 	on_each_cpu(cacheflush_h_tmp_function, NULL, 1);
 }
=20
-static inline unsigned long mm_total_size(struct mm_struct *mm)
+static inline unsigned long mm_total_size(struct vma_iterator *vmi)
 {
 	struct vm_area_struct *vma;
 	unsigned long usize =3D 0;
=20
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next)
+	for_each_vma(*vmi, vma)
 		usize +=3D vma->vm_end - vma->vm_start;
 	return usize;
 }
@@ -570,11 +570,12 @@ static void flush_user_cache_tlb(struct vm_area_struc=
t *vma,
 void flush_cache_mm(struct mm_struct *mm)
 {
 	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, mm, 0);
=20
 	/* Flushing the whole cache on each cpu takes forever on
 	   rp3440, etc.  So, avoid it if the mm isn't too big.  */
 	if ((!IS_ENABLED(CONFIG_SMP) || !arch_irqs_disabled()) &&
-	    mm_total_size(mm) >=3D parisc_cache_flush_threshold) {
+	    mm_total_size(&vmi) >=3D parisc_cache_flush_threshold) {
 		if (mm->context.space_id)
 			flush_tlb_all();
 		flush_cache_all();
@@ -583,13 +584,13 @@ void flush_cache_mm(struct mm_struct *mm)
=20
 	preempt_disable();
 	if (mm->context.space_id =3D=3D mfsp(3)) {
-		for (vma =3D mm->mmap; vma; vma =3D vma->vm_next)
+		for_each_vma(vmi, vma)
 			flush_user_cache_tlb(vma, vma->vm_start, vma->vm_end);
 		preempt_enable();
 		return;
 	}
=20
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next)
+	for_each_vma(vmi, vma)
 		flush_cache_pages(vma, mm, vma->vm_start, vma->vm_end);
 	preempt_enable();
 }
--=20
2.34.1
