Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 873F949BE29
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 23:03:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233488AbiAYWDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 17:03:40 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:42758 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233479AbiAYWDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 17:03:38 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20PJVh6n010476;
        Tue, 25 Jan 2022 22:03:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=2ZFdvV9dl6iVyRAPIUfr2XIpsjCVr1YtnW0KaO841EM=;
 b=Vlf5we+9LmY/nsFOrBbVxZa3AewRX4cv2zJ2IzPdbSnjSiPjuN+KwKnNcASAzXd2mv7y
 GjZgICGVATibfkFJKeSYH7jLWoA6/JQPempFTMjDHswS5h7dtLFGtHOe8BgJxFBo3ov5
 CwQ88HEkKzZ81A3U1MgiahF84KXYqnLM0ag1Talhom7c1XT64j/grWz+AdsgufpSABjp
 DC6HIudeiV7nwTWrCshtO6GOmcu1qZML4s/Vz+gFCW4kUwY4c1ouIM+OO2JL2u3HxROt
 I0mvTDOo5J75paDDC9SzpZUE6WrisHAMSTxMCZ8FjkcTAxVi3tY5axcsX/ZALZ6YNaxi rA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dsxaachfs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jan 2022 22:03:17 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20PM0lBr101727;
        Tue, 25 Jan 2022 22:03:16 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
        by aserp3020.oracle.com with ESMTP id 3dtax7aakw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jan 2022 22:03:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h3TZAAIBIiQYzkvaB0bXtKMUl/Tfe0yMxVHTu/R3NE6bc5HPbNwqQzJCkrCkPhZwaPU6oZesLtwoD8I5a+ZmiFjfcf94ARpC3F+foMFEeTS2csDNT8oJs8qowSx30BHprzHhhhOTSvL9XMRETCt0SH9UZSP9gNvX9YABeXQnCnSDiWFGUfCJVIVXIOoXgVsaU/UPze/SR2+lcVJyZ4xG7I4316ued+ZWueqYp7LM3B2BfFHY08KBV61J9qWtIW1+hngQ+z364uyWWLUFhzuZVHpML2kXaGKlMaEIBc/uuKk1Q8elYDMCzNGnmovn0M+WbkkMDWDVQzye94KjcZ6GiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ZFdvV9dl6iVyRAPIUfr2XIpsjCVr1YtnW0KaO841EM=;
 b=ACzCyWl/zjQwtXyUGJ623JcBiLEZr/DLIY60Iua18BuaB4OoYeZwetgX5x9IVQvWuRcfUjBYvTcLen7J75ZRsCFynUDydcI4HDeRLr2i8FBxtgSKM6GB8mBY+HE69KOs1nkLCq3P30FmMz6WpURSYSJF12Nca9XTVSgeKBVV22XCIp3kd4yDpzgqJt8zdjWnlJv927oEbV/oxmRHRdAaLyq7bndNmmIbigONTckqP9EmHGBa7XsTIg++mc6etwM330ge2s8yHcnwsT2CxrC0sHSeiaoaXWM4IUJa5OQX4Vhl5hrMjcH2H5YfGXvQECEf38Asg4FZj6ae+C+sva0kRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ZFdvV9dl6iVyRAPIUfr2XIpsjCVr1YtnW0KaO841EM=;
 b=TR9BFe5y/pNTkJwxy0rp2ooD4/6/55U9XLw8XbqlYehxKXtFY4Dnea89CA1yJBmPHc5SqXgKzK/XutRc1qmozUD8xFb0SsZr9wGIHzJjZvn20oMWrxnL/PV67hBM/qfRimkXW4iYBFBIze2FVIWedG0/UkBd+MnY/pbUf53TN0U=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH0PR10MB5498.namprd10.prod.outlook.com (2603:10b6:610:ed::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.14; Tue, 25 Jan
 2022 22:03:14 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3%5]) with mapi id 15.20.4909.019; Tue, 25 Jan 2022
 22:03:14 +0000
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
Subject: Re: [PATCH v4 51/66] mm/khugepaged: Use maple tree iterators instead
 of vma linked list
Thread-Topic: [PATCH v4 51/66] mm/khugepaged: Use maple tree iterators instead
 of vma linked list
Thread-Index: AQHX5r/z3Gacp+cvzUm17P15Z51O06xq7AiAgAm1IQA=
Date:   Tue, 25 Jan 2022 22:03:14 +0000
Message-ID: <20220125220306.y2bt6fn3wfeij5p6@revolver>
References: <20211201142918.921493-1-Liam.Howlett@oracle.com>
 <20211201142918.921493-52-Liam.Howlett@oracle.com>
 <e331709e-e650-d28c-e86a-11e188cef1bd@suse.cz>
In-Reply-To: <e331709e-e650-d28c-e86a-11e188cef1bd@suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3f308edb-c8c2-4d28-5a89-08d9e04e7c0d
x-ms-traffictypediagnostic: CH0PR10MB5498:EE_
x-microsoft-antispam-prvs: <CH0PR10MB5498AF04E0B11D3C04EC31A4FD5F9@CH0PR10MB5498.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Bof4Q8mY6nayw+UfYiXkQpD5qfP26yJ11NJ00p6tDpbOjeKVN7Ts94iOMuS+jIpFw85hJ85CvsiaQEPDuBkvi0ht0I9LuYcGzKEgfXHYtG5+/l0+lVPfYvWH2ppnBfAiFyfLadw0TrFSW5nxL1+Nbol0GbPvRLqhVkbXVTFS4H2cioelbaADmIz7G6h2ItkPVVljwH5/bjd9PTuj9mdgRAc27amrSIHTvELlsMXaLfrEi31wYjz/SFS1rc2A53v1A9+52mr03n/ojEuYh0gQxoAyIFEJglZPlUqdbKAFHVoRV+PHn8t93ytr57Tx/wZM4OHRjWrPKCcvJpOS3oD7agsgicKQP3WVj5Ya6u5EfZkXpCqFCWjpkDeOZ5NM2UprSZMUVBWj1uK60fEs7fUeWGDauxyKXqS0ISBYgU8WMXFC+BN2rFor0bSSRV+ReUVhVAIN5s7wdK0l6eDVwp8P0LTpEC+ACvn9AK/OKocmpFAq34M3eG9Omp0Qqi/1bo1vpCr2/BW8C4IHKWryy8IK/zUTl1DSdE+80kLKpKtHfSBIq+cX+oeGK22pKPpzEvU9+OaeOCMdsmPjoAq8PSbW7sZGC2SY+kiNQWdeEx0ptlNd8+DEFrCG7TwD8wAJtutdHEIO0wWdk8QQ7Qw7pRs28Nc5cMzd6HNSzyS3fULU0oQxtZH1I0guJU7qSFMSrULMCboOinWxcgdw0DlC4bvioA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(8936002)(54906003)(8676002)(66556008)(66476007)(316002)(4326008)(5660300002)(71200400001)(6916009)(83380400001)(1076003)(91956017)(38100700002)(66946007)(122000001)(44832011)(64756008)(7416002)(76116006)(38070700005)(66446008)(2906002)(186003)(6506007)(86362001)(33716001)(6512007)(6486002)(508600001)(9686003)(53546011)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lsgq0smzzzY9umMEJX4stnb2rFoeXK2v13qXvz4S5gwLPLYBbKXKDn10FMq1?=
 =?us-ascii?Q?RgvpTVUKkiA65ItQAtY4wwCjMDC+AgeWHfhJSQz/OuBF21vbR7OjJhTbw2Bh?=
 =?us-ascii?Q?2tXnNLeKCHplpOzfnZEqpnJbJkkTSq8+VEuYOpSmy9gl73e1cLqU2KNyPuQT?=
 =?us-ascii?Q?y4ErSzCWz9OmlQQpuJWUcz5wRmIPSq2i0BqhdF2olkZULwKL9qHopOEB0ExU?=
 =?us-ascii?Q?qw4HeteZpWb8epXEph6nGj5EyEtPmYCSX66tTIZ5PjrngTSNzzBadeOHPNtm?=
 =?us-ascii?Q?we9O8lWvFBSVJS4WcO5UnQCmycmRJVS/ytiigos2gMTe9tHZ5f9/uXhPSRFh?=
 =?us-ascii?Q?XdTV3hgUcDLEYJ3FQMvU4BQutVgDmXuoufahF6PO8vaSPpqMlB2GHAwRkJeg?=
 =?us-ascii?Q?fTghjvDu6BP3JkBB8u8Lj5U062pMCLb94mU8TZHWmXUSgSdAUhi4E9Igh+gi?=
 =?us-ascii?Q?AjYi4Q3c31hUAlDuHV6MIemKD01IzsY6Jj0ItBVmWLx+ToH//mK+GoxLvgJY?=
 =?us-ascii?Q?ow/qgS8OBuFTHB8lcPBPasB5sYqgWdV1Mdie9J6eLGHP7Lo06KglwEl78hb8?=
 =?us-ascii?Q?EjrCk9eTrKRlWmMHpmxTMXK7cdPB3cVyLM330yEjM1i8mVVQwIX4CKhPgNo8?=
 =?us-ascii?Q?vQHcKFdcqVPqPyrF+Zt8wLMSmf6WPqqkb1knUaYSdLmchMUtwWKN5X4YIdjQ?=
 =?us-ascii?Q?aVwszdTZgqTbcakkuCDMzxo2ToPHJEso6+NVWPaKBy+xBnt1FNccnTvWqn31?=
 =?us-ascii?Q?cLSU9dlMk5inl+VFYHwZoC8bbxs97o32kqvjJpyXcGhngK40zT5VLLawNHP0?=
 =?us-ascii?Q?xaDmH+qqcM6o8kXD6hW9vuxjKmz495Cmxx2CWyDGApGaR5lqdhpXyDCyNxMn?=
 =?us-ascii?Q?lqItmU4Cc0JBH8YqjfgjlCTPzZgs36cKMM87IeufYmCxRnDW7jMCWfXQOTSg?=
 =?us-ascii?Q?fEBHdw5SEyZkKUl/z18rtsVv7EHBpognqbRCVD6UZoG7mGlHA4VqBQfhzYmI?=
 =?us-ascii?Q?WiVu+IMEhH1KoaBPEnEWaeYMHTlLUdkTkV8nsW1uuZWRCc2qttyQUHC/YRGp?=
 =?us-ascii?Q?9IwOMxQycLx2yf3AJGiqlFdtrgpl3M9orP61ASMp4yKkGAulKNqRplAXgQwm?=
 =?us-ascii?Q?CT4Pog2Fy4AqD5baSmI66kDukr6ZJWK/Qon2I6SXkxqIbJuL5fsegORx+lZV?=
 =?us-ascii?Q?If/qYKMDoQq/6SEDKMgurupwR1pZa6p72oJG22/Hb8yejcexqf4otfkeSTcO?=
 =?us-ascii?Q?wxLoo622Ci4EL39P764IwvtQoxnnNeq+MvYN4sxZqWaNBhGUqqqEHrX+b8ax?=
 =?us-ascii?Q?mFkIrBZSYpTk0uVo1a2q+Wrg0Dhp4qK0nnplPGkiYbLVrCMTH4aUFPa7VpXN?=
 =?us-ascii?Q?DwOPLgVVQspBLAgMx43kZRO2uhEKKBrc1/4AX8zzZZtO2LRNk2Mr2BZ0Rks2?=
 =?us-ascii?Q?uLZtqh0wRef+kfQvo5Z+E1nbU970xAUSJpaKCa5h0TGF5yEdYcgOUDnnBw8e?=
 =?us-ascii?Q?ap+CmCRzOFI/oLxZuCZ/9/2CalblShHR0D9IQuK7QDKPAIlYM1llmVQBvy+Q?=
 =?us-ascii?Q?VCMqHBE4zZIEqnYXo2pFCEWpb4pziG2xc7isxEwk+yrrw5YgltCy4CmhUoIy?=
 =?us-ascii?Q?7jhVHq7zqMVuZaZ4/1gQGfA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F050D79F00D05845B647A32B05B7F9EF@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f308edb-c8c2-4d28-5a89-08d9e04e7c0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2022 22:03:14.1863
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U87AnR+cOYFvebCP6chqBoyu7UTAx2NTWs8AG8dsUuyS4ftcXtQJOnRT5r28zIHabypsGLbkNEYJolCpTZe/Xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5498
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10238 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 mlxscore=0
 phishscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201250132
X-Proofpoint-GUID: dFPsuN7tyuVEyQ6bBBtrgFTE5Ny1e6Vd
X-Proofpoint-ORIG-GUID: dFPsuN7tyuVEyQ6bBBtrgFTE5Ny1e6Vd
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Vlastimil Babka <vbabka@suse.cz> [220119 12:48]:
> On 12/1/21 15:30, Liam Howlett wrote:
> > From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
>=20
> Ah, got tired of copy/pasting for a number of patches, I see :)
>=20
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> > ---
> >  mm/huge_memory.c | 4 ++--
> >  mm/khugepaged.c  | 9 ++++++---
> >  2 files changed, 8 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index e5483347291c..f0f4ff5239ef 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -2270,11 +2270,11 @@ void vma_adjust_trans_huge(struct vm_area_struc=
t *vma,
> >  	split_huge_pmd_if_needed(vma, end);
> > =20
> >  	/*
> > -	 * If we're also updating the vma->vm_next->vm_start,
> > +	 * If we're also updating the vma_next(vma)->vm_start,
>=20
> vma_next() takes an iterator, not vma, though.

I will fix this comment to be less code-specific since next isn't used
anyways.

>=20
> >  	 * check if we need to split it.
> >  	 */
> >  	if (adjust_next > 0) {
> > -		struct vm_area_struct *next =3D vma->vm_next;
> > +		struct vm_area_struct *next =3D find_vma(vma->vm_mm, vma->vm_end);
> >  		unsigned long nstart =3D next->vm_start;
> >  		nstart +=3D adjust_next;
> >  		split_huge_pmd_if_needed(next, nstart);
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index 0ff7d72cdd1d..8f0633481791 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -2083,6 +2083,7 @@ static unsigned int khugepaged_scan_mm_slot(unsig=
ned int pages,
> >  	struct mm_struct *mm;
> >  	struct vm_area_struct *vma;
> >  	int progress =3D 0;
> > +	unsigned long address;
> > =20
> >  	VM_BUG_ON(!pages);
> >  	lockdep_assert_held(&khugepaged_mm_lock);
> > @@ -2106,11 +2107,13 @@ static unsigned int khugepaged_scan_mm_slot(uns=
igned int pages,
> >  	vma =3D NULL;
> >  	if (unlikely(!mmap_read_trylock(mm)))
> >  		goto breakouterloop_mmap_lock;
> > -	if (likely(!khugepaged_test_exit(mm)))
> > -		vma =3D find_vma(mm, khugepaged_scan.address);
> > =20
> >  	progress++;
> > -	for (; vma; vma =3D vma->vm_next) {
> > +	if (unlikely(khugepaged_test_exit(mm)))
> > +		goto breakouterloop;
> > +
> > +	address =3D khugepaged_scan.address;
> > +	mt_for_each(&mm->mm_mt, vma, address, ULONG_MAX) {
>=20
> Why not via mas_for_each()?

I will use for_each_vma() here.

>=20
> >  		unsigned long hstart, hend;
> > =20
> >  		cond_resched();
> =
