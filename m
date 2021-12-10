Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 440F546F89B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 02:35:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232063AbhLJBj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 20:39:27 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:17932 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229379AbhLJBj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 20:39:26 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BA0Yxtg016419;
        Fri, 10 Dec 2021 01:35:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=BQk0DqwmJcTBVjzi9wUuc1tZaN2ZkFdKkPm0xC1l+28=;
 b=tjbfUSoN0FkROQSzYzkAAXu9r++e3lN9u1I0d6crXjdA2QlFxdM/lkmcB0Q4Vjyd9E0Y
 Egg1+G7HNM0vHfNPhG7GSIyVOQtGGtllFR8D//FLp6ut7uOi8RFFc+c3gnX07dyt9YfH
 NYDvtwTpeS5eODY6BM0D/cntHNu/fBXvh3UJmT5mqe7zY7SafdTkAKqKWXH9ZE05Y9sL
 So1Fom00546LolPKFCb03jIdtIgQnVidhsfpWSncF6hJXWoylXreCtR5BbS+/wpRqy0S
 s1Qmu+WkTqCkqSdm4vCG3d2+gpPJ0xRQxsc6HkAcPYGNuVW1uQ0GfzGoUsyjV8ukLLDl Iw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ctt9mvt4p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Dec 2021 01:35:14 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BA1WEfp040908;
        Fri, 10 Dec 2021 01:35:14 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2041.outbound.protection.outlook.com [104.47.74.41])
        by aserp3020.oracle.com with ESMTP id 3cr058nfwy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Dec 2021 01:35:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C37wrZfY1FBsIRWIHA8IcgFw4RwXBo50FCbGcG1WJegub7GCJ8bvNkUsLerj+yaMjao5mUVwW1H40BTUczjyBvwG2qKnxnAtwm2sTYnYjj7KT9gqqsekxPSnaX+ij13lmzELrQSSfJXik8rQcAPzIWOh/UVPaNw+ArzpN92RxomfDKPySffsSEbGwRwwCk+zbeqmzvdMrdGc+cZ6A86gnhf+SlN4AfWi+agNSs/u6vFPDZRnSMrJhM4Z/97fIRcFj8E7L9wYFT/uRfTm0q/oh5g2eo/S0kED2UCc+V92UZkxBBVXi9oDVBEztI91RG1HkNYEGSDaViE+a4PoEtrauw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BQk0DqwmJcTBVjzi9wUuc1tZaN2ZkFdKkPm0xC1l+28=;
 b=NM6MaN6zPd1T8O+w4TogFf6C2aeDgGCJq1KbIVRrGyUNYzUtCcqxfTCNxBeBSU4zohfRLjVhDUGOqfHWZhx/t6L63pI+AvAt/Gck/RtFZ3r9lxll+98s/JauNSmfdqeiA2hdYOqffrVvjnx1IqBuBf3hLTFvJl4ZjjM9MrTVUNYimZQCm0uwQI7URwA6WJJ9+1Dzn+BNyJrutpbeex2kISme3ClBaBk8wLLEpLDXLdOSIBl4NPfKaurzm1o9otnP7cJCU1JkquNszFc7Fo3/Snqu01QtX9N27XT4HalM2+6JI6wEUs4p7VJHxHzbOs/9lAer2IBSFg6+UuIx0Q9zHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BQk0DqwmJcTBVjzi9wUuc1tZaN2ZkFdKkPm0xC1l+28=;
 b=IO+knhmGE43lmtG9ZCn9ixfOwgnG9gHQBT34iD3iX+ChfgV72kiWfQJ/nZonBgM5JfogTUazqY20Tzx4wY8qn4Wnx5vN4Vxhz1zN2suhe70HRGHnNvodL6TZlvLEx87h1NsyIsyKlNNys2PmuoCV5J45aaGUt+DlfijuFzG62kQ=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN6PR10MB2623.namprd10.prod.outlook.com (2603:10b6:805:46::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.25; Fri, 10 Dec
 2021 01:35:11 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3%4]) with mapi id 15.20.4755.025; Fri, 10 Dec 2021
 01:35:11 +0000
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
Subject: Re: [PATCH v4 08/66] mmap: Use the VMA iterator in
 count_vma_pages_range()
Thread-Topic: [PATCH v4 08/66] mmap: Use the VMA iterator in
 count_vma_pages_range()
Thread-Index: AQHX5r/nCuIxHsF9tESS2yzv8mvmIqwqXJGAgACiPYA=
Date:   Fri, 10 Dec 2021 01:35:11 +0000
Message-ID: <20211210013503.uabxmsumxhslyn4g@revolver>
References: <20211201142918.921493-1-Liam.Howlett@oracle.com>
 <20211201142918.921493-9-Liam.Howlett@oracle.com>
 <ffbb5843-4c5a-99c1-12a6-2ff3ae818e3c@suse.cz>
In-Reply-To: <ffbb5843-4c5a-99c1-12a6-2ff3ae818e3c@suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cecd68c6-c868-408a-47a6-08d9bb7d4ebd
x-ms-traffictypediagnostic: SN6PR10MB2623:EE_
x-microsoft-antispam-prvs: <SN6PR10MB26230998CDC3DA73ED6661D1FD719@SN6PR10MB2623.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:901;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IZkEpcsNk5WRLZelnXc7Bdc4WEuwT64F1bxrdJ6aFxcVNpW0cA/er2QNEmR3igUEEBiKlfzKm6ft/8r3K2OKccYbkgyUTwBxFRHuhY34Rb19ZuLEwFuPMNCieX1iNCPGetjpHXEtNF27oP/EYBeN9agOMuwZkk0eibSmE1pRhYp41TGKQTutZmtSThW6XtEl1rpI+HNCZpA5wAHamU3Y2fPqTQtdi1hPVx7Vfxjy2HtDJyiDJW/pymAnD7ONK/JQkOY8k0vYjZLD+HiZXtErpJQFRVP7wa7lOqycQ/ZKvDFnSTkYqBOnVa/UBZKHiWJ/ZX/wG1SE/S5P2vTUkeFZfLrnkud+Xlv8xqCRlvRJKMLCi5ZGbf0eaOLESkL3ua4o9DaGjJMjnmIuO6DogGcfoZUYHfGOf8xV2bLpxYD9IvJKpzMU5krvg+gX0PEMQFS+Q4XbgcsuKnhK2KfSm1X9wvXN74iV1L8KMS28VT8tyx/5d0yVXlQ1e4+ST9vWniJAce7Jgq2G5AUxZnirOj0dgw/xCjs7uvGkydPjHIRT1dvHXmzIKPnQChs4jqHSCwchMJJJcdfRiMxH1pylsqvBYINLLWzpIO0n0tR9z9YG1dnGebO3DkKXRGznTkQMoEihuz1iqkwzGWWJarrLEX6RQQmygnRolPpZlw3Wu11hodNoFXI4SgmvlB6o2qVSps+MOtFGAjwmXS1eSm0TXt9FpA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(71200400001)(186003)(26005)(1076003)(7416002)(33716001)(44832011)(66446008)(508600001)(91956017)(66556008)(64756008)(76116006)(6506007)(53546011)(66476007)(8936002)(6916009)(66946007)(5660300002)(6512007)(9686003)(6486002)(316002)(4326008)(122000001)(38100700002)(2906002)(8676002)(54906003)(38070700005)(86362001)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xEKVZ4ML8jN3UDR3FWCYbSokPal9nJmNyyQIHgPkXr7cj7kCWp+B2Z2doz4/?=
 =?us-ascii?Q?s/I5+LKlw4IKoMySCk7t/+oQKgcRfLY7Laqcm7PEm2wnoqAnsFD28mnKwbYl?=
 =?us-ascii?Q?Z9KQK3DYQKerp46G6+u/D8RUaAMsn8+L0wBm63FGpx8kQ3jsBQgPuT1h/WI7?=
 =?us-ascii?Q?wlhQ1GNG+nGnq6clAf5Is8lkkGabqtVfpPzEEvFh1Udlrr+j6WUlqCFac3zh?=
 =?us-ascii?Q?F1Vxl/oUQmoLk9lVAJAt6mE0wTWh3TUUr7aWUEoj+xSYujYjA6zZLBXQpsAJ?=
 =?us-ascii?Q?sAGt8+uUkAPB0RSXuUVU5Z8ajuSxRsFaaG4iZqnhozILuOB43TJWV+567l9b?=
 =?us-ascii?Q?z/RHbOnrnZzCvK4l4KVNfMBjG05yHw6HeQDxah5ZsiI0gIqHsW1/5F0A1mPx?=
 =?us-ascii?Q?L03DKG89WS4nlSeB6P8/WY6K4wdMmJ6sKiZ+aozjuMGMOXQr3Pajf+9MooYi?=
 =?us-ascii?Q?qyFpgkDQfFJUn4JLorhxDgJ5hguj1Q6Wsh9G8W65i+XH5XKm9yZjMF5Ek8q1?=
 =?us-ascii?Q?koMpLjw8ByNTBLeY3a7jwOPN5vedfoPPuwiTjtkOpApxFB0sKmRAktRNaLlN?=
 =?us-ascii?Q?liutcpmD2umaf0yB5a0Yh/2Uwu5F38/N4tZd8sQ42YCke/r4qQtLDPxrKfWJ?=
 =?us-ascii?Q?wza20jBV4RKfm0JrAtPP/OOaIUWvav44V7yOjUuSrl5BzIoQ7lKO60qM6iR3?=
 =?us-ascii?Q?Q/QGF9jNa9LMqF3HhiUUSVShAV5/yAmhBqi2gQPoCGSq0Xj/6F8ecbwIxpMa?=
 =?us-ascii?Q?raDIRu73GD42szZrd8noL4pso/vC+WeDoHpAtrNIqr7Lqtt83Pm1Rmrg4jHH?=
 =?us-ascii?Q?m0Z5tKBz28kzQUqdpkJ9p5sBUEidqfRlliwJUpaz5jnpewRZ+KePzU94HR3n?=
 =?us-ascii?Q?Qx+EJ+oGYlzd6r4CI94EWffLSQ8nGJXA03seWEl+j7q64mGOGBLVELYFXYnt?=
 =?us-ascii?Q?2KC4oFAq14QOQfgZ7yQX2CiI34wsozouQKKKMxemCJpBgwvKm6XknrjXYxPL?=
 =?us-ascii?Q?YGPZqRqD0SZtIaI1wUicruzF17QkUmEhUoOY+fYz8h0zjgS4XvkszNgPL1yK?=
 =?us-ascii?Q?Lj/7It+aSJNu7NMOIwZA5dMJe0gR5Qe06iJQEVMMylBK7u5Fj3QfyrC6cW1R?=
 =?us-ascii?Q?lmQXJB8EAeaEh8C0rtalzpyJKYHlGv4aaqE3RFzVlNSo2iBRNV5D9GeUg9VE?=
 =?us-ascii?Q?A+hRTKD6mtbSzNA4qpYWPpPIwq4J61kcKdGPish8qctE6BJuzlWRecXAlZHg?=
 =?us-ascii?Q?UQP17Ww/vbdg7W7FPiFNhcT4NT9VbFw3clHcXUmW0j9x1GDQUKI5+/QSKGop?=
 =?us-ascii?Q?FRX7yf9Go/bsUY1Ajaa/rdDFw6Ws/Gs4nplyCp5LTRBiyy/OenrTUaFeyxNY?=
 =?us-ascii?Q?0vH/68YkjS8MJArl23q9P1ROPY/Rg2RAwrLi3hcJVi1KoL2uKcZJ5GnYeYPn?=
 =?us-ascii?Q?cmde4ODKalQVAlaGhtgaRuaun9NvZeLc0v694qFIOBvpoDANO2C2m67b8G/c?=
 =?us-ascii?Q?pg5o7oyZGN6uKF7VdFKJlBVaLJsbMnznscNHOXSQiCZgxE1PDnSY3L6AkX1l?=
 =?us-ascii?Q?EcVXDQdlV1AatUnmvlYlHi/UtLykcLj3uKp+RaRtlZOxrJZ2nSH3CvZQ1yv8?=
 =?us-ascii?Q?QBslUCeH/xOPkcb9MX+v29Q=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <196B0BE107C42546A6698986708C7158@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cecd68c6-c868-408a-47a6-08d9bb7d4ebd
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2021 01:35:11.5188
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F+vjRfu17BaABibdlKdYPExQ6/kUwkjkoYlXYh3PlHTH94SAJT19Hd8T/sReGgeZ2qEAVBq+HoR91iy5tLlzBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2623
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10193 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112100006
X-Proofpoint-GUID: 6PkXocODSc-Iq8VlQvW8CIrevV2nzudZ
X-Proofpoint-ORIG-GUID: 6PkXocODSc-Iq8VlQvW8CIrevV2nzudZ
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Vlastimil Babka <vbabka@suse.cz> [211209 10:54]:
> On 12/1/21 15:29, Liam Howlett wrote:
> > From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> >=20
> > This simplifies the implementation and is faster than using the linked
> > list.
>=20
> You mean faster because more cache friendly?
> OTOH you do max(addr, vma->vm_start) which wasn't the case.
>=20
> I doubt it matters though and yeah it's much simpler...
>=20
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
>=20
> Btw, no signed-off-by Liam?
>=20
> I now also notice some other patches (e.g. patch 4) have From: and s-o-b =
by
> Liam followed by Matthew, despite it's Liam sending them. I guess that's
> less of an issue than the missing one.
>=20
> Anyway something for you to check and make consistent in the whole series=
, I
> won't point it out individually.

Thanks for catching this.  I will clean up the s-o-b for the next
revision.

>=20
> > ---
> >  mm/mmap.c | 24 +++++++-----------------
> >  1 file changed, 7 insertions(+), 17 deletions(-)
> >=20
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index 9fee6e6b276f..de78fc0ce809 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -669,29 +669,19 @@ munmap_vma_range(struct mm_struct *mm, unsigned l=
ong start, unsigned long len,
> > =20
> >  	return 0;
> >  }
> > +
> >  static unsigned long count_vma_pages_range(struct mm_struct *mm,
> >  		unsigned long addr, unsigned long end)
> >  {
> > -	unsigned long nr_pages =3D 0;
> > +	VMA_ITERATOR(vmi, mm, addr);
> >  	struct vm_area_struct *vma;
> > +	unsigned long nr_pages =3D 0;
> > =20
> > -	/* Find first overlapping mapping */
> > -	vma =3D find_vma_intersection(mm, addr, end);
> > -	if (!vma)
> > -		return 0;
> > -
> > -	nr_pages =3D (min(end, vma->vm_end) -
> > -		max(addr, vma->vm_start)) >> PAGE_SHIFT;
> > -
> > -	/* Iterate over the rest of the overlaps */
> > -	for (vma =3D vma->vm_next; vma; vma =3D vma->vm_next) {
> > -		unsigned long overlap_len;
> > -
> > -		if (vma->vm_start > end)
> > -			break;
> > +	for_each_vma_range(vmi, vma, end) {
> > +		unsigned long vm_start =3D max(addr, vma->vm_start);
> > +		unsigned long vm_end =3D min(end, vma->vm_end);
> > =20
> > -		overlap_len =3D min(end, vma->vm_end) - vma->vm_start;
> > -		nr_pages +=3D overlap_len >> PAGE_SHIFT;
> > +		nr_pages +=3D (vm_end - vm_start) / PAGE_SIZE;
> >  	}
> > =20
> >  	return nr_pages;
> =
