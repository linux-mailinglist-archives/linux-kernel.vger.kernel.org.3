Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B72D49D041
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 18:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243445AbiAZRDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 12:03:08 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:5362 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233367AbiAZRDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 12:03:03 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20QFolww011465;
        Wed, 26 Jan 2022 17:02:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=BPrDkGTsqkwr0CA/zTRc4p5fOd3G5uQu9rD0vdyWH54=;
 b=EPyhuvGfx3F2SeqU55XrpsFFepkUjwn6kzYMrVkbbNBnl/gCSIhcp59mmkftPHhBR4Dy
 4PRiUONTE6/ZaKBqMtVtROlv65zZI6uyNPkdFcsMppiqMlNny/Mpeil+vfs4zZboAaik
 1/egDDlXhr/EDlRN0GOCVC6YbCCfGQ57OoW3hEQ3r8cL9AakNbe1W7rrt0s6kl+srauC
 Nil/Buneybk2E3IBGDFlmLaFveM+satenkaOfeTwgjAmxcss/Bq3dq9pVOEinnR4/LHE
 IIZNT1saP0cMJESfjVCudtXvT7t3qYCkopAqcBXIHPe4ljIXAREej6KRkJ5fjQHn0nQG rA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dsy7axtx1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jan 2022 17:02:38 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20QGtLIK193684;
        Wed, 26 Jan 2022 17:02:36 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by aserp3030.oracle.com with ESMTP id 3dr7yj4k6v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jan 2022 17:02:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M4XlL9QXO55eA8L3inlTzpbKQdcYKtvkOcafpprOa/wtGTuI7W0PfuDY/+hKaMAPVe8++2S8lMDHXkQakSXVVtfFnZp5DVkubyqFZ9KPgKh209R9vQtXqOiMnr3dMcMygmtEWhSPSDGsLqDdWFNPPINbtR8mklgucx6K0SeFG/Ueeoim0IOF5EWHPNlikiGI/eLoIOCaKcVFEldC3H2HUQYbFe/AiG/TCudgP2yOj9NjF8dtF8YUbyiiYhmXi9Yl77cntJW84qnD/gURQX9ngJ3wS3SXpVloU+EmNkOYqE0HM0YRN25FzUt6c1764ctZq8ITfKYkJjVs0JErKwR3UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BPrDkGTsqkwr0CA/zTRc4p5fOd3G5uQu9rD0vdyWH54=;
 b=UL7RcBFOQqSE6JMNAW9yKX5indFwZg/A/XBHg8TnlJHkI6av0TOPL98p6lf6IKUj7RMBfUhOjHB7Dgfs3gd4KH1nyeuWFGQZ8QUpOu6U24w5SldZcV524GgwZa66vcan5gJWwGoXRGKjGB/NyhRaOP99PLIAR5KgXAsuwgALqn1Ss0nVe4idxWEstZ1ee2bvhHJbg4CN94hdbsMC3nYsLDjwCrVlCvG6lilun61G4VIo7u6IUNk5Z7osfQwY+JdA7BO5biULhvXyLcwIjQ6IkVgoDoSavPh3apmpaPQvu7t5iAKJgUWV1B3eACukWGRzkCmahov2pIM3qpDsJ0Z2DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BPrDkGTsqkwr0CA/zTRc4p5fOd3G5uQu9rD0vdyWH54=;
 b=Dw/aVUTcL8T9PB8FKmyC5kGT9pCQ8rKqOSa07MoubbvYSDpCmODM6zFtQW2By0XBRihdOeWWC8/0bXjFTK0xuRKKI4+iDrcVLWFNBndDwfQ9xpkOAvvJYQF2Y1FFLMajb2Q+fiWQTGTDRjsoist5ReqT1bFK2p6ARrDdZn9vtLU=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB5630.namprd10.prod.outlook.com (2603:10b6:a03:3e2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Wed, 26 Jan
 2022 17:02:34 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3%5]) with mapi id 15.20.4930.017; Wed, 26 Jan 2022
 17:02:33 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Vlastimil Babka <vbabka@suse.cz>
CC:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Song Liu <songliubraving@fb.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Rik van Riel <riel@surriel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michel Lespinasse <walken.cr@gmail.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Minchan Kim <minchan@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Rom Lemarchand <romlem@google.com>
Subject: Re: [PATCH v4 60/66] mm/oom_kill: Use maple tree iterators instead of
 vma linked list
Thread-Topic: [PATCH v4 60/66] mm/oom_kill: Use maple tree iterators instead
 of vma linked list
Thread-Index: AQHX5r/1JcpotnygX0WFLv6DsIVZ1KxsKSuAgAm2UQA=
Date:   Wed, 26 Jan 2022 17:02:33 +0000
Message-ID: <20220126170226.ict3brr4hhw6ajfi@revolver>
References: <20211201142918.921493-1-Liam.Howlett@oracle.com>
 <20211201142918.921493-61-Liam.Howlett@oracle.com>
 <bd20144f-a443-9761-a50f-7d08ea922dac@suse.cz>
In-Reply-To: <bd20144f-a443-9761-a50f-7d08ea922dac@suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 99717fea-f8ca-477f-30c9-08d9e0eda598
x-ms-traffictypediagnostic: SJ0PR10MB5630:EE_
x-microsoft-antispam-prvs: <SJ0PR10MB563052364645CC8E41EF9BA1FD209@SJ0PR10MB5630.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:248;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +9M6+GX6B5s10HY2hzRbwR3DIgYTZc6MybukmFtWpKCLR6DllNGerfaL7fo9f/DKrDFhiNM7fuD+qKv/92Ew23dcuW9D8ho/GiSitD+tT1eg+IdvyyQfT+mj2l7t+dDzcTwWeeRuVq7NnY0xmZUBjAFgo71Vw11pqRJ6RajFr5tET3r6Ae3NRmF3kgW45Igmm8+o9KvTq/4k/L6tWb6FfAR/Zn1escPdHkd6jg+WIgrwhIlPJGc1u9K2HrkyZfK6pPo/W5gXdeluBXfv073KPLlag4yjTSzmUtRUk5NDwOb/khbA64gtlirImK8TYEcckYI7+bl0SnIvnmLG/MU7w7IQPBYxvNl0Yq5lztS0r8GKjhDqcXrZUrJ8uQ35a+DHmzf1q8FutAZEVZJmTCxBgpy2Vf3V4sk3/xPX8tv8bioKmMsYKQR7//LBB+IasHGJzmPXAjBLEomgdKKU6IVSZs32zgfSUf/pSC5CnIeuqCV16hkepwyWqHhyrBCCGDyI4NsRrlKR5PPLHSadDoUgJu1on3XFCqaeICZmAwmrIfclcYJKapfQBtzsS3hydNDXLGXomQfjpDh1Wdtr99BeGD3KsDoLCamyWGcxTTIj7vVjyy46WmE19SM9SGq/6+QBCZg3D3kN0BoXpW1vuSNhj/DMAi+JfBiVuK1Kr97/Y9FJc5zL9L9Yx+5xv8uj6wesgv1LH5b3qPQl726jdaVDEQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(122000001)(6506007)(26005)(186003)(9686003)(38100700002)(508600001)(86362001)(83380400001)(4326008)(91956017)(8936002)(66946007)(54906003)(6512007)(38070700005)(44832011)(5660300002)(8676002)(6916009)(6486002)(53546011)(76116006)(1076003)(2906002)(7416002)(66556008)(64756008)(4744005)(66476007)(33716001)(66446008)(316002)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vAi1Xeo9g50qiwCM2zQ2MD+qimtJIvyQjIOKXLjUz1ChhmmC/vpTH1ie4NJM?=
 =?us-ascii?Q?iiyns/LfTgkbiyMeMnL5AyFOee5SneyHvvjphGmpWhLyolOjoR+bM+TB15aI?=
 =?us-ascii?Q?PG463FFPsSKvmDijpaQ9P0vORLAWP4vPISRSFMbUt8h4wBvi4VoqPfe9/Z1i?=
 =?us-ascii?Q?zOdQ8tOfo34BOadFDR5HmlQjGtgVAKBASK6jXg9v46PGCjH/EboUWKg//Pmw?=
 =?us-ascii?Q?FVhWVBSKLLV30TNHWlGjHdSiZ22ErdX6Q38FOO24mhttEMi0QnfJpSYZ/7YW?=
 =?us-ascii?Q?PwF/2XAZFFi3H08Qj3bfY269NaTrNddn2X9pBXiwkarIr0azRJMNkhwbRR2m?=
 =?us-ascii?Q?ytr6Z9bNAkx26pQdYEv+Og21IW1T1TWTVEF54vDdD1/g4e1xnNP3l2ltRENL?=
 =?us-ascii?Q?rqsctXH+CulEDzCyB06snNGDl6z4fqLhJR/GOpDfCqWqhpC9P1qr8h8DjTh0?=
 =?us-ascii?Q?+zk/4U3GyGhHQcP1IEvGKJBdTR550mCnr8rxVc2yng0+/KbbzJR8mQvYIAqz?=
 =?us-ascii?Q?bJILO76o2zvoSJDmObBFisF/1RiKGOptbKUSnS2LzXjEJPcbcRIXsMLDbN4I?=
 =?us-ascii?Q?a0YIETGzGi2rEhDWYyDpODF8IyGxTJEiyz5UkAFSTHq2EHBCcD0LX46lmN2A?=
 =?us-ascii?Q?qrxRvk/A8clgHGfYt8b2eK084btsvzbxHOXvudHVYMpX4m2+2z50XY9m/QgL?=
 =?us-ascii?Q?EbfGzrpz1a9z9YwDZ2VCw3oCX2VmDE5dgsOa5Z6D0jxA5Fx19CaVcmO2PKtD?=
 =?us-ascii?Q?qE/p5fs34CSSv29TmTFJwbWIeb9M6A8XAGAiI1HxPFZOn6ip5tvdp/NyApZR?=
 =?us-ascii?Q?31oSRHB8ZJr6RjcQOZ3X9aH/4j11+LCweRe7rw2iks60Grvl20F5ee8hBr3F?=
 =?us-ascii?Q?sWdjxzKpsUxQe/hPxar70LXTbHT9vLcTcPLDyugcK949x/ds6OkH1642IlO3?=
 =?us-ascii?Q?5wF8YWOZQTCkHMexnsH8yRija+jZc2fE5h6moz3ysdrrM24VooEDmgjojyVc?=
 =?us-ascii?Q?6bGzxfr92PDe4VOJWqAvlmZcw0ZMFGzs3G8Rxc877ItyVQXe4du1R+GH5Elc?=
 =?us-ascii?Q?6YYgdiwNgp++29sDa3kE9hQ8ohFA7gMqiNPFMNAkvE5rDlcYK20bUmYe7+8q?=
 =?us-ascii?Q?xqe9UGatK3sHigQn4wacEV2DLz6xdyrCglfFaakCcQR68A6uem+NnMfRNSws?=
 =?us-ascii?Q?87jqBse8qPfNdIbD9cF6j7sDWHecFk+D6eakjRLJCFRaT/gqjfPXhki7kO+1?=
 =?us-ascii?Q?qz0csAsDZXMeSM3vZfFr8VoE0PFwzd+2WqxEgSQVSLri0nRkiBjULRLTIyoi?=
 =?us-ascii?Q?dYWCwHaRZEyaXpY96h4rL0wg0n62UCZsXKqzFWK9pAmJEGq4vHEA42N5c3s+?=
 =?us-ascii?Q?NnZOCp6Fd+j3DnoxBQEPgFiJrLn8qzw1rGbKxQ+um19mLMTGYCd1hixTeW4h?=
 =?us-ascii?Q?9BWA2mWHJVkfq7rgur4aS2/5v6Cpzur1mA3j485/5YDpjHxdz+86Z0VuLPge?=
 =?us-ascii?Q?DvA/DTcvP14fub+1zZpVc7EHM0Mr99sxFmzpevOlbBUvBKybyjYxX+djQ1Pv?=
 =?us-ascii?Q?Gogtrk0F0R5SeB7wcsx0Q0PADq3Hu620Mtp28MSefd8P5x+baJ9fOfefPy1M?=
 =?us-ascii?Q?e6jtJ4w7S9s+jz7sgst+THE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <98F404D2D0EB6E4FB56C97988A334A82@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99717fea-f8ca-477f-30c9-08d9e0eda598
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2022 17:02:33.8159
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V8PSD+9n+6Fe4NZGH5RVm8LHL1AtNKK84X9n//soE23Y951FfXPfgubAxsGsZ5D0lTIfUSEJeYMP23uEiOtEPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5630
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10239 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 adultscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201260104
X-Proofpoint-GUID: BVB8eFFSOfjpo5BTrK2Aj9XTvyCLoSio
X-Proofpoint-ORIG-GUID: BVB8eFFSOfjpo5BTrK2Aj9XTvyCLoSio
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Vlastimil Babka <vbabka@suse.cz> [220120 07:43]:
> On 12/1/21 15:30, Liam Howlett wrote:
> > From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> >=20
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
>=20
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
>=20
> Could be VMA_ITERATOR?

Indeed, I will do that.

>=20
> > ---
> >  mm/oom_kill.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> > index 1ddabefcfb5a..1694b30eb46c 100644
> > --- a/mm/oom_kill.c
> > +++ b/mm/oom_kill.c
> > @@ -516,6 +516,7 @@ bool __oom_reap_task_mm(struct mm_struct *mm)
> >  {
> >  	struct vm_area_struct *vma;
> >  	bool ret =3D true;
> > +	MA_STATE(mas, &mm->mm_mt, 0, 0);
> > =20
> >  	/*
> >  	 * Tell all users of get_user/copy_from_user etc... that the content
> > @@ -525,7 +526,7 @@ bool __oom_reap_task_mm(struct mm_struct *mm)
> >  	 */
> >  	set_bit(MMF_UNSTABLE, &mm->flags);
> > =20
> > -	for (vma =3D mm->mmap ; vma; vma =3D vma->vm_next) {
> > +	mas_for_each(&mas, vma, ULONG_MAX) {
> >  		if (!can_madv_lru_vma(vma))
> >  			continue;
> > =20
> =
