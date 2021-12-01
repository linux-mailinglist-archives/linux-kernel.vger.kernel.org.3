Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAB3646501B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 15:39:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350672AbhLAOmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 09:42:18 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:48012 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350188AbhLAOfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 09:35:52 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B1DCrqJ009641;
        Wed, 1 Dec 2021 14:31:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=5OY3Zh8f4p0O9Bvmit2Vv+Nhi5qVKduABQ3emqmOco4=;
 b=gi3Bg3TrjMJZecvXla/rVgQZoXEanolyujvZloxWY7GjblTHEYmwt1cqGLBZwIHZrzIJ
 RLwPe44ViEFK1gEAzAvKeIgMbtHCz/0nmo0KusR0RGDVGmHvC17SMfFNjo0kh7zhLVOD
 VShXdIQ83kG8nO/pcTO7qrVQV3UHgpcnwh+8gricZVC/TbPnTkzyRdYDAYNKbg+zlyEh
 1eLe5uQ+lS+JrYEYmc3d9MXqTrY+J76b2W4MB5C15vSSD62IInRtCpUg0ZpzatAqv1L1
 ycJYGagQ2QYZiJURQ+pvyszY+WDZ66eZCsUlsS2bivKN56ASfMR8UE/CFLVn/VT5JXS5 Zw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cp9r50e7g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 14:31:15 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B1EBlwV109866;
        Wed, 1 Dec 2021 14:31:15 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by aserp3020.oracle.com with ESMTP id 3cnhveqdaw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Dec 2021 14:31:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vj2MVyW5PuqcNAdCw+2XmaetJ1lMtC58oGo+XR+yFkBHj33DqzMoQ7WjmF1M1l9aTF38PtYXxisvQEsJKmVXcNThBL2HjI71A2FMmAxQ9FKag7dI2xoiBWqP6hoJKQnUVAloPfTIFQ85z0XHBfzUcdee05YcunOxL6Zm5/0iN4B90kCaAa/pwhUXVdW8OkYYHPYEhY6JOYql+pgYrMyZxE+AtYnBR5cpJS7jLfAN82+XrtZnk6INtUr0K9+Cq3RnbhzRRzzdrRB6DDa84e4IpJNX7nJgetDZBDonU7+J6NiZkL/9dweRhH3cbckdjZgXRdzF2FKfpWu7Zqx0Eq9kxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5OY3Zh8f4p0O9Bvmit2Vv+Nhi5qVKduABQ3emqmOco4=;
 b=OsPXydCxBsa1BPdmMVCyC8jX6kpF2ZTCqimeAh1y4HlkLs5aGoydkGz2TT/c1RTd6l6oW6s4qgTLsbAe8CHlbQf5geJMSbDUcizUtNZJTLDolmAkqV3UObOY+L5KnZp4zxMK34G1n6IxtbTk7A40o6MRwz1DiEaGopVml/4m9ztO0i3Oj14IeTUlv4EX5JrYidn33bsri4NcDrHfLtUSVoi9phLMyyifICcT8Od4YCJv5FtRYfqfcns6bZ9WKmmezS6mybUuu4OiptGgOmOZqdRaXr18GwgSHq/lF8KNBd20k3FnzK5YRuZkhni9G/ZL+EL2ATRIuMMWQ3+340FPOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5OY3Zh8f4p0O9Bvmit2Vv+Nhi5qVKduABQ3emqmOco4=;
 b=OxItCwkSpDCPD5uLrT4NNuLN/pr0rqkW27Zzu30/zrpnsc3RopnFrUwJ07qLvBkycTdc+DZgcnbCKMYTFUSiCWMCxDsWS4zorW81NJw3p4M0jIdLnowwPveIC4BBIfjeB4yG6Dij7U5Gmg883pZiUIuixK3SFOdl3yTqhYngFpo=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN6PR10MB2464.namprd10.prod.outlook.com (2603:10b6:805:4d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Wed, 1 Dec
 2021 14:31:12 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d0:8291:84d:ac66]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d0:8291:84d:ac66%7]) with mapi id 15.20.4734.027; Wed, 1 Dec 2021
 14:31:12 +0000
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
Subject: [PATCH v4 60/66] mm/oom_kill: Use maple tree iterators instead of vma
 linked list
Thread-Topic: [PATCH v4 60/66] mm/oom_kill: Use maple tree iterators instead
 of vma linked list
Thread-Index: AQHX5r/1JcpotnygX0WFLv6DsIVZ1A==
Date:   Wed, 1 Dec 2021 14:30:16 +0000
Message-ID: <20211201142918.921493-61-Liam.Howlett@oracle.com>
References: <20211201142918.921493-1-Liam.Howlett@oracle.com>
In-Reply-To: <20211201142918.921493-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6f2d0740-b986-41dd-5bf2-08d9b4d73999
x-ms-traffictypediagnostic: SN6PR10MB2464:
x-microsoft-antispam-prvs: <SN6PR10MB2464EF567E1E02DDE4F27E48FD689@SN6PR10MB2464.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:208;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Vwbtlg7qxqXPshAvMtnKrUlBuBGJNWowQV5FByowuN1KDPsjDrOIyNKDIsmA5674Z9ycLEvRPlW3wEMVYN+r1K7BSJ2SDHuZBF5b44y41OYjMx7bv0qwZ0L7OoPhJi0ciaEKZMXTzTo9Q1QNNRjIVZ0SvqqDTJjkwAUczXVWUCmQg3at7LbUYHlr/9FkKj71H9eC96lT8VGspRn3XF7H/qUwRGEUc0pfDcsAYtrY16p/cccjsgsEMMgB9hLVPb+KymqgliPdNbT4OLa2Y301q1qSfw96EI2qmtD+2GPKExe2p8BgVGOPdHuqbkHqHLymciJ0Y7IajUk/SqOpcKpW9zFCBAZ1pDifMFlErUT2u+1JHde5mRL29M0eXZbLvEV999AnDw4vkHIH6SILimYcuUlo7+B5rXTqbf2Szd4DplKg6brXPE7934U1shNmGGSAJf/vYrO/h7N0id19oXI6k0hLKU5hvfVrPAZlIIh3Wp4DKPsF08eHcjI8403IB6U+iwu8WLYsLZuMPfH/pZsNkvbaDCxqDH93BQRmp0jv1VS9htb2jDI4NRY2KFMx16P/Cf74E8FKdjEspws7/Yrnm9qXSq0gKT7MWp7Aab3Ilz8M/hRQqGCQfpEku2XgqPReJDkGhJD6TzmoXDXgH2JnSjbj+ZTrcd10uCfIci/33pN2LdvR131czj42BHBhBmBemOlsCy+hRZQ1tROGnu9SQQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(91956017)(6512007)(2906002)(1076003)(5660300002)(76116006)(83380400001)(186003)(4326008)(26005)(38070700005)(36756003)(8676002)(7416002)(54906003)(107886003)(2616005)(316002)(86362001)(122000001)(44832011)(508600001)(8936002)(64756008)(66446008)(4744005)(110136005)(38100700002)(66946007)(71200400001)(66556008)(6486002)(66476007)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?x1UzzFkvMoAjbqT2AwLIvJJJ2HIZMNDw5D1fURBf8HV4guSYg6uiwMJ0Vf?=
 =?iso-8859-1?Q?8we/TXqqtPhb7aa63W9FJgvqBO2ls7h6okzpek48xVVzcZNFKKrxTAyPjB?=
 =?iso-8859-1?Q?xwJgthz/bHYRMqlUZlOvOGFu3AhznNsViNn3Vl2tGmYHrdAZURJVmI2ClN?=
 =?iso-8859-1?Q?TIPa1Ld6r/kE+ydG4dDLeDkHzr6aIyqxU08eFrXCTQSd2hmy6DzlYBZpl5?=
 =?iso-8859-1?Q?xMSRgny45bRolDQQx9p4nd/y/v+O3MAR1TvSM/vR2OyQkJlvrg0MUY4GF+?=
 =?iso-8859-1?Q?ZdRCYDA30+S8cPIJJBh4eWwd2cj3Og319pt4FuJgQR5PfV7uluTu3ZcSPN?=
 =?iso-8859-1?Q?oIMaaqlc09cA8yayfiQSx3NdnWllkPQVhtA+dCijHwez67LJlJwXgsWCEl?=
 =?iso-8859-1?Q?DPJuPIovxFe7XyM7nosjTYT4NcEyeFn2xFkKg0xvYuIDOMi7/brZYDni7T?=
 =?iso-8859-1?Q?/ary78B2o1mjHX3baGJcs3zYuxVk8QYAvD0WjagKkqEQ5pLLfh3buz6Wly?=
 =?iso-8859-1?Q?7hV09akqSrIZ+o7tRqfxmjNfc77AASSsnJmEGHOkgCxO9FoMPb+K3pBsEN?=
 =?iso-8859-1?Q?dgSgFaht2aiGdyYLOOjHKR8LxJr8a8OYgKZYvOmAZwKLzHzvUXcrGd1bfB?=
 =?iso-8859-1?Q?hceRKG3acB6zuJuakPBwsqIpmyaCWYAHRGPWwZc5kUZs1NruyUEN1wb/kQ?=
 =?iso-8859-1?Q?MT2Wbs+e3D53ZWhwyu5Qk2MFnk5/PVEVTyzyFNzhR6WU9EyKgeBQbBjLyY?=
 =?iso-8859-1?Q?uibKTBVsnosmRZx/jjbBu4JNoz8O9gPK/jLsoj4dYy/Xm+oaanHLv7js6U?=
 =?iso-8859-1?Q?GcmzSiJarRd/WSu6hYgbqi6iH1+SyRUfamK6wP22gD1N0rHtfggTiK/oJq?=
 =?iso-8859-1?Q?Xrw7AITi/4/ieq95t2RVaimF01HuuJbP6e+M5iT1PFwOhh7H1luyCN9TJT?=
 =?iso-8859-1?Q?B1A32vV/hUPTDq/ByluWxG8lu9+MrT8R8Ma6Q3tXKmaMy6om+N5BvYfb2W?=
 =?iso-8859-1?Q?QlC6fK9qjtX2PfIOc7vUn8Oy9KMU+70VnxtT3kTHJ5s71xsEo3qHAwICQC?=
 =?iso-8859-1?Q?Ta8kZI/CzdKHa1k+jgXkegesL+K07/0OrS+y7KaDYdp8Sv3JzlhCA2RTCY?=
 =?iso-8859-1?Q?exa8EHeNAsw0k0hm3o9VjZER3i36vongUsdieggGu1d3d6SHy/LL/OX7eq?=
 =?iso-8859-1?Q?5f2qaan3CVBP1TQtJBS3CqHHSbAcO3UGjU7RcNWjTX3VL5lFHVtr1rEmro?=
 =?iso-8859-1?Q?8C7+BVs9hAVHzcK2V2y/SOKS21kI3tfMSpDGGNkCYGYQrSfHocF8CPIphr?=
 =?iso-8859-1?Q?p4By/8CLZTIkwPuAGyr7twYQGzPWAzT98eWcqJrRL30un100qbhcfIrn7j?=
 =?iso-8859-1?Q?PbIsO1r6SWTgFAFIRRAB4bQahFvTiIOa3r5Mc+DiyZUMCmja/+RSQfHtpN?=
 =?iso-8859-1?Q?YvUGvoo9OCVN5VEK/hAKZDjy531tLllqZ3AHV51u7VnYtAqJaInng+VYDF?=
 =?iso-8859-1?Q?+b+j7vkrcbs1inZosgSv+d7DqbWZ6QEcbUwI6D4I9i05GnQ03otp2sPl2a?=
 =?iso-8859-1?Q?0YnN0bVcBEUj817lFsXIl09Xm2EQlEcRpWqpX4ffc9IfT/9T2aD7MB70eF?=
 =?iso-8859-1?Q?lp1H8ecPSnAO9l7DzpwBOUUktx6VXnul+1F/zFjss30qVUp/OFH3jSY1VT?=
 =?iso-8859-1?Q?1QOJMI1HlQ81HKX4JrA=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f2d0740-b986-41dd-5bf2-08d9b4d73999
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2021 14:30:16.8224
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pbsn6XHEqwysxU76BCKz5YBeKvLtB+dPmqd0JFximuXoRlqsifOQRrNrVl1dDWjztikCxoviue8B3OKkp5ulHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2464
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10184 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 adultscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112010081
X-Proofpoint-ORIG-GUID: GB0mtEJqmP8D2BuGM91ZYFbuWDTzijbZ
X-Proofpoint-GUID: GB0mtEJqmP8D2BuGM91ZYFbuWDTzijbZ
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/oom_kill.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 1ddabefcfb5a..1694b30eb46c 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -516,6 +516,7 @@ bool __oom_reap_task_mm(struct mm_struct *mm)
 {
 	struct vm_area_struct *vma;
 	bool ret =3D true;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
 	/*
 	 * Tell all users of get_user/copy_from_user etc... that the content
@@ -525,7 +526,7 @@ bool __oom_reap_task_mm(struct mm_struct *mm)
 	 */
 	set_bit(MMF_UNSTABLE, &mm->flags);
=20
-	for (vma =3D mm->mmap ; vma; vma =3D vma->vm_next) {
+	mas_for_each(&mas, vma, ULONG_MAX) {
 		if (!can_madv_lru_vma(vma))
 			continue;
=20
--=20
2.30.2
