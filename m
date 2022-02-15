Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DAF54B70ED
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:39:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239251AbiBOOsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 09:48:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239117AbiBOOpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 09:45:45 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A28D113AE4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 06:44:05 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21FEhv1Y022185;
        Tue, 15 Feb 2022 14:43:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=xNzRANR5EmyGNTyOTsg93HrDHS8Rd9c8SvI++TWpXkU=;
 b=Nh7XTzFNPqv0pYkrxYql80krIksKWVuTcPnSNt8N/EHz++x9hAbwQVArpxTBZV7Fw1lI
 rxW8DO6YHMOxTadw1zjPYnQqMrcnB8LAvO1T7FM2nTSuoBdW6FonzIkyXGKMHIp9rXdG
 9h96AjT0bzVdfuwN0WHeWqnABdp2dqMiu6X/9aL9wrBGlHBMOhTXbKr1loQj0oWwsLrX
 +BBD1wSvm3xdnGi/ByvkqiLTOq6+fUiXn5ZW2KHHOqMgbazoiaQ5S1A5y4LFdl/jdmE/
 pqS8wxTKWNB6z+YV6x0vJjTmSO/1+YM1vouTnj0DaF1g5qNDzIXUuu7NbFMkZEVsEbR6 RA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e884r97h4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 14:43:57 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21FEeT4D145723;
        Tue, 15 Feb 2022 14:43:53 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2042.outbound.protection.outlook.com [104.47.74.42])
        by aserp3030.oracle.com with ESMTP id 3e62xeqfex-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 14:43:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KvJy7qiSuRAShqs7ZeWF1XhyiQF8gRrLB+j4XrJ/w2jrNtP0YW8PL9Vaq3G3pX6YCPW04t1jmnzsGJHCtuZsX2XoJOdwDUEBHesxAJKuTNHwBtkrObgngd9F77P3lvQyvnqxoI+hm6i88nQGp5dOScaiTfvGC1OrMmhlBtYDInov9qNxA7E5UsQe64RdWSarAi40r5rVzbAEyA13wd9b2b1OWKXh8HgsSO1ja0311N2AYT8sJ50cp2f4Ltl+nnmJW+jgKyjp/8+OL9oHme9iDTGYaBC7xKr+d/S/zqCA719AO4zrNmNTHy4IlYvzw+UlPc70J22uvo0wCbttZxSyXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xNzRANR5EmyGNTyOTsg93HrDHS8Rd9c8SvI++TWpXkU=;
 b=RZv1TJQUk2UP6gRA2SnEi7zpdt2IWYC3+ly797IvZdKEYh/vnPCeoi7pD57MI0QtQUMBvVwRITcDuNxNwXkgrQpIJ3sKOq2r7LJ/d1rfZWtzOxFGN3vlqxv4ANRnKafm79RrIB+n8jEgORIeiOsIAFF9p9Z3b+oW2PqedkD0thjHTfe86EpR30jpF/c9m2sfh2z2wWecafRmoi61tcjXcFPL9iClf2MNr1mi10aRrCJ0PZ3MNNhbGdljEy/J1iQT9k6cCNFy85dpozf8LCz31XJ3V6cniG1f8ta3i5wcCbBVBwCpYK2qqwNjq2+ncnvZUXnl+ZljKJ2YKGX3jgGzXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xNzRANR5EmyGNTyOTsg93HrDHS8Rd9c8SvI++TWpXkU=;
 b=DUVUAF3cfaQUD8KNw1SVCQkiQvsLygEGolk1LidVxojNHQFFzOjV14KrFEtzBAPfruDwrbDup/xP6RbGi5tZnt8eeL6h4odnJVWF1JFM/fcm5fYMWtini8VExD+B68SywhDLmSYOyYpcZlZLlSpgwN9cXni3mF7/+ihdn9W0BsA=
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
Subject: [PATCH v6 33/71] parisc: Remove mmap linked list from cache handling
Thread-Topic: [PATCH v6 33/71] parisc: Remove mmap linked list from cache
 handling
Thread-Index: AQHYInpd/pYuYD+o6kuJZlpynxbOdA==
Date:   Tue, 15 Feb 2022 14:43:15 +0000
Message-ID: <20220215144241.3812052-33-Liam.Howlett@oracle.com>
References: <20220215143728.3810954-1-Liam.Howlett@oracle.com>
 <20220215144241.3812052-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220215144241.3812052-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f0af0a33-2a13-4abc-2b94-08d9f091954f
x-ms-traffictypediagnostic: PH0PR10MB5578:EE_
x-microsoft-antispam-prvs: <PH0PR10MB55781AC6AF6488F25C2693CDFD349@PH0PR10MB5578.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Jvg6Mpz1yt8OzkYSbg+1ANRYzjMp89aEjg/0uAXNLaW+xIHQV4x2zDVM2TCzJ8asXaL718FvL9xWb3WKmNe8S2blK/7c5jg6vJFALmnWzgpsPgzk5Uu8uf8k+lzlw1AbRQ4IlEV2J9J4pOAUNGu2z5cGkd8QJm4UwqU9cmLD6BSFIWNaJJryy1vDA5y+r7YJb8Mws8Va1RGwMHpBqGmJYxfGN2CPNcwffrN5/D7lrfyhZy/HsgXTAb5QfZcG/MS4FPEZwmZ/P68rY+opttqRbpV9697VWaZQvdXbYNgpKGBPfivtj/ilNj/2cAReMsA//RLzZcTMbexUqenNAursmxkC0Tpduq6bmRIfJoBzt0S/gw3yLm/dSDcXqdCdCnUiIkI/yBcvL6bKprKVZGMwC1docGd7v5ltEPOzqO92TNLpYDNdw2w/GT61/AhRIOs3REpGj/eMOPqaPI2D20dwB9MsyzinKupKRDF6adEoknLzSVyzSv5ziXEQoINqlqBpEjjBaEJsQUfRIEvbBukjxxiO1f8YPaXS1z1MfnzDJ0ABXNphZPL/myW5U91sJ5/fmkZmzSFkRCg9jGqA9v5BbHtDxO9YPIkoxZztfaYXgBJKB1eD/7nnhsU5Ob/2naauiFaG8QLQxZ5Nm1x9GVSDwHjf6V+P/wMWCkvuBNhb2vMPyP/pCKnuSgwHGfkSMqEoY7BSGUEq9n9dYk+pOqs5zA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(2906002)(6486002)(83380400001)(38100700002)(110136005)(508600001)(91956017)(64756008)(66556008)(66476007)(66446008)(5660300002)(66946007)(76116006)(8676002)(71200400001)(38070700005)(44832011)(86362001)(2616005)(1076003)(122000001)(6506007)(186003)(6666004)(6512007)(26005)(8936002)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?NHcm0A85Fe/g4NGxDNocg40bcg4IaK/iAGAV0TPCi712SI6ubWCAqYtuh/?=
 =?iso-8859-1?Q?+m8aMUsbdJXKLpP4sScC9za+URCbY3kpohxNlNdjv3kAN0WsOC+cjqkO0p?=
 =?iso-8859-1?Q?gxEZvTb+0R+e5MfKUw660X1Toad/tMQb0LsaucxS5kZ5N/ip7wl2t9A4HB?=
 =?iso-8859-1?Q?/mJB3wSUhXLCVROYYrSI/0Hy4zBp7lRKG/Lvm+Rm/BYA7gwQXHeMnk5Q1R?=
 =?iso-8859-1?Q?AgE4XJbSJsiXIvmT87M/8SQJrVpDv0xj7S/DS6UICZEv3YQNH7jOe7FxzG?=
 =?iso-8859-1?Q?0sno/mABBdH3fKaKg65Rcfa1KhLgABro4r4Or6S62Jf7D3SodOwBFFyOHy?=
 =?iso-8859-1?Q?gq70i5nJPHtbi2QOCbylG/4F8yTTF54jNxA3mLM6gn85bZRtcuNGBpCwBL?=
 =?iso-8859-1?Q?QdlSUPmzq6OmhKOzWDjVprKce8FEznGFWf307lQQKwJNFZZbfIcTHUKuJE?=
 =?iso-8859-1?Q?k5Xbegs2r3Di9QwYQbNiUFOtB0v9V7nCI8jBY+VnP+RsRc6dY7aWd+yrzc?=
 =?iso-8859-1?Q?hjVAb7STV5pUNs7Of2OOqKAL6DcBFNBkE69yfvvF8PfS0lnlfPf9xQb+8h?=
 =?iso-8859-1?Q?x+PzEhGJPygKyJBBe8fIzngZJ+rzmN4FtR++vWF+J6JcgF7+MXuC0aZQqj?=
 =?iso-8859-1?Q?DazDzmyG7HlcFFPzwXRxGLoTNPmaDKd8o4xPFrSgIKaD8soFDjdRTXzTxi?=
 =?iso-8859-1?Q?74XPv720kS/5Y5nSXsQ5hYkEWkJWNOObg2JsgyqTgah02FOOa5OfNciS5y?=
 =?iso-8859-1?Q?NcUGeQhVBcf2wepwX2Hmd5ZGa9Xdjr1jGceNA39FXplxAkkogEWNYhcPZn?=
 =?iso-8859-1?Q?Nx9Ii1imWYDc2JjR2oPW/bpXFgMFljh2BeEPFqCojL/BPnfOE+H6C8mZwn?=
 =?iso-8859-1?Q?8JdFDepxsDdGr/GC+grf7KB1TH4OJ6W77w4pDfHUbj2mrumCAX1NlaAfGc?=
 =?iso-8859-1?Q?AY9kXZEmNH40AB8kyvWiUINb/QczhIgc92MZUiz40QvYvEuw9c1f9kDgAL?=
 =?iso-8859-1?Q?fexlH+bsdAhxKYpcUJ1cbyGOVzdP56HNSPEb1lFmE7mBR1jQOkkLwJM13z?=
 =?iso-8859-1?Q?fBjXFLZSizykkjMSxOOW7eGEutD+OsElDTBkl9HsjgnSptFRsjU7OhTpEp?=
 =?iso-8859-1?Q?QfAViQl4+qRj8lUKrvTsCfVAAAIhAdjiuHCLih2mabsKO4dTtgFrqJowAf?=
 =?iso-8859-1?Q?TR8ESxJFUplpmg/Be2LLDIU8Cup+jRilNamlpRzONcZEvjY5SXbKTofEUV?=
 =?iso-8859-1?Q?OmPkYA67U3ePjxblbE5PADF8NgHNhXknHEq7yffgN6a6WTr9hT//wFp0uS?=
 =?iso-8859-1?Q?chHMSRHVthD3yXMuVEPbWYnNqC91z8ugbSiiUYKDzO6fPmd6wCCle1Iavr?=
 =?iso-8859-1?Q?+ex4CHOHC5XsbanVaWxVPqrPp1PkNzsrYVR5j5SWEuq3SfWt7pBa2kmu9Y?=
 =?iso-8859-1?Q?KV8YKQCpI/9YSULbgys7rMjGkCQ6eat7XXZxk1XOPSq3pHeLvZd3ymxM7y?=
 =?iso-8859-1?Q?737co9Zc7ukWhYW3PLIaToThl+0Qj9xvsz9Wt+kq1MjNaTsPGKMmG1HqbQ?=
 =?iso-8859-1?Q?nbeDEAG5ftGK641k56cohh9rEs4waDVj0uTpfpQGYGFvivVfG2khMJM2+0?=
 =?iso-8859-1?Q?afs4siHS0Yg3fX4myMsbRSMQeL9x634CqNHox5jnR+9CvkbMK43HhlK13+?=
 =?iso-8859-1?Q?CJ/ckFv76g2eOSPInlc=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0af0a33-2a13-4abc-2b94-08d9f091954f
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2022 14:43:15.1672
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BK6/jVP5eH+p7xo8qO790qQMyQ5//bTuR8n2v1McjRWsZAClMFGbac/jUbk2boBpjryMEY377ArruQ0x6o+//A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5578
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10258 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202150085
X-Proofpoint-GUID: 6BMpzEmGvzkP-iNBiAV1xYhy6EL0KWyt
X-Proofpoint-ORIG-GUID: 6BMpzEmGvzkP-iNBiAV1xYhy6EL0KWyt
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
 arch/parisc/kernel/cache.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/parisc/kernel/cache.c b/arch/parisc/kernel/cache.c
index 94150b91c96f..c3a8d29b6f9f 100644
--- a/arch/parisc/kernel/cache.c
+++ b/arch/parisc/kernel/cache.c
@@ -519,9 +519,11 @@ static inline unsigned long mm_total_size(struct mm_st=
ruct *mm)
 {
 	struct vm_area_struct *vma;
 	unsigned long usize =3D 0;
+	VMA_ITERATOR(vmi, mm, 0);
=20
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next)
+	for_each_vma(vmi, vma)
 		usize +=3D vma->vm_end - vma->vm_start;
+
 	return usize;
 }
=20
@@ -570,6 +572,7 @@ static void flush_user_cache_tlb(struct vm_area_struct =
*vma,
 void flush_cache_mm(struct mm_struct *mm)
 {
 	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, mm, 0);
=20
 	/* Flushing the whole cache on each cpu takes forever on
 	   rp3440, etc.  So, avoid it if the mm isn't too big.  */
@@ -583,13 +586,13 @@ void flush_cache_mm(struct mm_struct *mm)
=20
 	preempt_disable();
 	if (mm->context =3D=3D mfsp(3)) {
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
