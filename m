Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 766894910D3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 21:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242633AbiAQUDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 15:03:06 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:64276 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231292AbiAQUDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 15:03:05 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20HHmp8Y012148;
        Mon, 17 Jan 2022 20:02:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=53Pvs0yeXxCB+QLStV+2OLtnTJY9rh4MOO9zVnUhVOM=;
 b=1K4WaqArGVD920Ym52zI7ziHOHX01ptWB0Qc54Q9uhD0n0rIU2dd7GMkqUnsI7UnJ5yu
 cXM3r58rKEf2rJt6G+gLa0FkuXQpNGPCr/+WY2VavBqTFJHSPItY9B4Tm2K/ERD69Md1
 65Gv4aHv6oU2hoYPA5rZirJhVqQW/iatZu+NXFHNQG15PgH+YmFfq5fM4WRXypoigL93
 VLL9hfu/rVBBCHAMBiyvwHAZScM32CRaM5WqPR2ZSHZNhJune4wnmcMQNv/pIvIsTT2Q
 l6rqvaI7t9o8iLYIIqz2gtCplOTXtUSNizEK01E+U2ymq5lttzJc8rc481ux8M0vpPB7 Bw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dnc4q0a35-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Jan 2022 20:02:16 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20HJuKmc036374;
        Mon, 17 Jan 2022 20:02:16 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2047.outbound.protection.outlook.com [104.47.56.47])
        by aserp3020.oracle.com with ESMTP id 3dkp3387w4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Jan 2022 20:02:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W+n7wPvlAi5nyoj7BznFcV604Ga5dNf4SkhJTEH7j9OY9FM5QetHai/YHZt1dYBfHzrdIef8qqeIO+mWVptz01PCNBk5tbwp4LanZnnbTSlsDg+kp260ZgdpUoMH4pAiNqfYRHcifW/CjC3sQqk49IVeyFUrVWXStjKlI4/JnsX5KHq816WOeojmE0wV7+3g61B1t00cWTGkjGISXVnmt77bapvht5r66fagLaCGVItfZyWhbCcH3Pds0Uy9e0KFcnCVHVVo3jgCMZuSLWN3Vx3AL+u6420v5NInt9RlSPUJOU+Ec5+q8ADKYI+KdDLyHcqJs9zGHuuG4G5wB+Dt9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=53Pvs0yeXxCB+QLStV+2OLtnTJY9rh4MOO9zVnUhVOM=;
 b=NdxsYxbE0cfa5eLHzlsAmWHfv36MLsJXPP2F5loeP1Oe+GKkkE6y1HxcMD666BZtCGen8JHTu8vldPa5Y2reeJcR6ZL3+HB++O8b7rZLPzBXbQXHBViD5V1WZzGdbn1HbVtgIeeSHw4R3gan9i4KsVkNaiXRUv3pFuUSq++RI8QHFqU4kMCzcZatcQ9mTHermNuT1qSlYYVJYp38YN6bazmdfpNTImKJzuVKmkxlWMi6V4TJyNMI1DXBty9xmFo2935K5FvbY/6NxXIXfMssO+ibMtdD4kXLSt7S6dei9jjPZEitaIfnOjaY2g7yWSNySrjgeEv8b13zFYrmJyomEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=53Pvs0yeXxCB+QLStV+2OLtnTJY9rh4MOO9zVnUhVOM=;
 b=DTFrYmyDe6QLYgvfJHXcg4VEpYLJA/lip/TT+x0id+ZVilmdfEE8EhGT7OcyxmbZNYHuqkdWC9wvgqVA8hP0spKTl+rdZroSUfqAhkFeCVlcmc6bUe2quBHZxXtTISjnSIIk5JXYg8uNv5gdex7ZgrdKLvCkdX0+jjnfteRC8J4=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN6PR10MB2590.namprd10.prod.outlook.com (2603:10b6:805:45::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10; Mon, 17 Jan
 2022 20:02:12 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3%5]) with mapi id 15.20.4888.014; Mon, 17 Jan 2022
 20:02:12 +0000
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
Subject: Re: [PATCH v4 17/66] mmap: Change zeroing of maple tree in
 __vma_adjust
Thread-Topic: [PATCH v4 17/66] mmap: Change zeroing of maple tree in
 __vma_adjust
Thread-Index: AQHX5r/qRw6GTTvMhU6NoVDrpLJFC6xfu4SAgAgxLQA=
Date:   Mon, 17 Jan 2022 20:02:11 +0000
Message-ID: <20220117200204.opgeyxywautq67dc@revolver>
References: <20211201142918.921493-1-Liam.Howlett@oracle.com>
 <20211201142918.921493-18-Liam.Howlett@oracle.com>
 <7bd61a52-57ef-04e4-6298-039308bb8f86@suse.cz>
In-Reply-To: <7bd61a52-57ef-04e4-6298-039308bb8f86@suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: df57a8e3-e6bc-41a1-023c-08d9d9f44032
x-ms-traffictypediagnostic: SN6PR10MB2590:EE_
x-microsoft-antispam-prvs: <SN6PR10MB2590C57E18D7E1720137ABABFD579@SN6PR10MB2590.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zZqc0LLiGIsxO0yRUIoaGvo4LhW/ZZ8GODMdhPdRaLX1yN0XxFtawDFfICZygoX4HG3/Y+FOANqyeRQg6Oqbn5lOZgfIVj5p/leW9kOBsVl0KyoJ1S2c7KnApHALtbw7frQje4pg44ukpTV3JHLmt5A3+ObYR+56mAsMZpz+DY8FsYNVOFEqLvCeMeoLzkGzi85bktHyBH17vMgMvP1DLkWsxpkwDgmva89cPvXJsSKd/hv06WAuZmk0ZNM8FBGJOWjOy88ChmON3cc3pG1EZDsPuMbh6NrEiIBlll1dUUj4ed1+HeSw3WPNwH7/zP6z6mHv2eXXpiDShZ7VS4qxGi1LaYYtngPnI76Xk4Bf22gHImfDVROiY5RPTNEmmDh3ssB5xLzAN9HOv/vUHqdi2Heo8h9gfr/EvkDs/Uexmc5pyTFUyr5Vv3gmpd0wJGL/zn6m7DLHysk9aHozL6GN8zoVFhn2Oo6Rt1tmCuOhyfO12HI8OC2rqE+Irge56I8LlJqQD3NNCRixt+m+tCH4McDj0hHbc2eWVc1Hms4Vkc+Y8Df86sBx0AvF/tLCf1rXkiZpz7Jyhvx7ME2yaXGmBZ71RkfNaEhRUSTS7fFmyDzJpQy9JA7UJPRMmIEK7+YaPW7T5L7YgsuZ9Dt/DiSLAC3LLH4kL98Q/fYX4/1vf6YCBkoeFipE5KNagSs/5uMk6CJMoIVShS9fsJwe87URkw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(9686003)(7416002)(54906003)(6512007)(8936002)(1076003)(6916009)(6506007)(6486002)(53546011)(8676002)(83380400001)(71200400001)(64756008)(66476007)(66446008)(66556008)(86362001)(5660300002)(38070700005)(33716001)(186003)(26005)(38100700002)(76116006)(2906002)(91956017)(316002)(66946007)(508600001)(44832011)(4326008)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?t0hE+5xJKyf3O7NA4WwPgzAfDeBs6m/RKJQUZ8v0qwGhCxOxuBv+tHNvyog+?=
 =?us-ascii?Q?PVtJFt0xIhzlnpS0F2/OZCgSfUg7vUdRn9lx99uElfjEU7PJziE+lfNerfkp?=
 =?us-ascii?Q?M8K53uGSi36w7rvKdRkVkriR71o2u9p+xXS1KXWH3i9q7UDlj0yYm28/8ilQ?=
 =?us-ascii?Q?igucZ9/OS0/E/vbaVYMfhKqLCChoUd0QtcU9XRg/S/ioPYw3XrkTsPw/eEv5?=
 =?us-ascii?Q?pT4RBZfglujhq9005BTEULbaQ1oSx1o9QqfSbb1mwWmaUFV04oxJU3wqBncL?=
 =?us-ascii?Q?6TfQ2L4bv9j61qGprcxIBXV1yrmNQKUn0dEZYSVREVeDwioOKVXR8+90N5zh?=
 =?us-ascii?Q?G/H1btq69Fyt45MTaoDA70xkx+vGXr1w/Uotj5IV2z0TWVYyN+CXr1ohylmn?=
 =?us-ascii?Q?KdeZjKhimQm4E7QPv3oEMpSrDriOr4OJ8DqfLGKL32QCtv69yonvdBgxBWMY?=
 =?us-ascii?Q?Uf08wWyaB3k85rlFSgdDyRM7vQjtYqB1an6D/TXl2JOjIeiEDcPth2tlsQCZ?=
 =?us-ascii?Q?2MrJ8n6fVjYZbKzFbG04Xw6y87pqykMzihusEdTWhKU3VCcbWaY04p8y5AsA?=
 =?us-ascii?Q?MWbcfkzQYVAfJOIJT6E2LLXv6qWfU9oPSPbETiNhnTQ9B00swDLBYXypDBxP?=
 =?us-ascii?Q?nLBgOUMGORit5hALsNwsKduWDGUBK/A4cjV3z3uyJogwdnxsyitYM9hs9f1P?=
 =?us-ascii?Q?hxSjPEqSckAgf6ovDLTAkuGImYsyf5/gbAQrXtt2cMe70c/gZdqkbzxWASWD?=
 =?us-ascii?Q?Zj3RjyM7FYqdeuoh9NvUqQmd6T924waIj8N+V2YzwdhxEu7gbvNdfSUrdUzv?=
 =?us-ascii?Q?o2+2mzPBnbz7ZbaNOuXK0Q8TbYBWk+BgQTNYNs6+zIxGefwETogJJRtSlBBg?=
 =?us-ascii?Q?8BLx6/laQmcH0Ndb2vwZTeWi1KJvCq1mGH87TGCJuBl2V5Jg95NQi4kyzpE+?=
 =?us-ascii?Q?azIJOSfLa9s6kbaYV/R42WhpaqyXFKX4098k2a6ARZE4PFgYE1vBM1Xwmjuu?=
 =?us-ascii?Q?CkgzCcvmdoeikyebuwlPYZZRcCQQUottOrJbgVPOcqSPsFEWoqV8/2+eO9Q1?=
 =?us-ascii?Q?YkC0waTVXiNmyn17f0zXWxV2Bql3yuVlsG74tisoD35+gNj+J1M/wzE0Qijd?=
 =?us-ascii?Q?xt4PmsFbxP39k/yBDvpAPShMU6T4UMIxuDXgQzJ2R1b8xZB5IB6NIcnFs86G?=
 =?us-ascii?Q?dQNgH2UxqqagZinRUo7qG9VByc/GtTO/cAZyxlaxVasvzBOIhD8MTs4iEDOA?=
 =?us-ascii?Q?mpgN3sj02GufxSWrJ/Dg03fZ9M9UbKv+zNvpAr9yKlERNLWygBl+ddjKC8+6?=
 =?us-ascii?Q?OblFkL9ZwA5rMV3qYEGTvhU9O1SblNpKNcG3lD1/cLABlMXs1etYjvVcyHSl?=
 =?us-ascii?Q?6OiiYxXTFbbEPuez28zVg57xNDGEJZeDpQ19dEqLBWaHkToapQnDcsAqDmj2?=
 =?us-ascii?Q?4qjK1vyIv11f9X0IO0pxDYKAzO/98Cbskz7PzWPAMM0577O9MSXHe2hpd1X1?=
 =?us-ascii?Q?8Vrbic+/5Pj4T7OVzN2fQmsOB9qdgaVSJXd1YpQYtv8FLOcRE8a3anQ9ueFv?=
 =?us-ascii?Q?05FWhlUkvU1B4lbSpkca9Fy53OXA1kKcC/yE6ZPkjRUEh1iCFXxyRl9l789i?=
 =?us-ascii?Q?BajcDRWQTAv/xgQCdXi2Df4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <490056A9F0E39C44BB2CFC47E7D3BD8E@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df57a8e3-e6bc-41a1-023c-08d9d9f44032
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2022 20:02:12.0652
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hxtgLaFHnRh5ONeQhYWZWXvJmzTM99JardHvykJRSyOkiULJ2MXT2nqUQh7PUMou6yj/2rtvIjgKM9WF2IM7eA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2590
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10230 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201170124
X-Proofpoint-GUID: 2dVC6VnM6VZz3mK7tu9q7fsHwxSvfJHc
X-Proofpoint-ORIG-GUID: 2dVC6VnM6VZz3mK7tu9q7fsHwxSvfJHc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Vlastimil Babka <vbabka@suse.cz> [220112 09:56]:
> On 12/1/21 15:29, Liam Howlett wrote:
> > Only write to the maple tree if we are not inserting or the insert isn'=
t
> > going to overwrite the area to clear.  This avoids spanning writes and
> > node coealescing when unnecessary.
> >=20
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> > ---
> >  mm/mmap.c | 21 +++++++++++++--------
> >  1 file changed, 13 insertions(+), 8 deletions(-)
> >=20
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index 93ed19b2c6ce..c5f92666d145 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -615,6 +615,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsign=
ed long start,

This function is the worst.

> >  	bool vma_changed =3D false;
> >  	long adjust_next =3D 0;
> >  	int remove_next =3D 0;
> > +	unsigned long old_start;
> > =20
> >  	if (next && !insert) {
> >  		struct vm_area_struct *exporter =3D NULL, *importer =3D NULL;
> > @@ -740,25 +741,29 @@ int __vma_adjust(struct vm_area_struct *vma, unsi=
gned long start,
> >  			vma_interval_tree_remove(next, root);
> >  	}
> > =20
> > +	old_start =3D vma->vm_start;
> >  	if (start !=3D vma->vm_start) {
> > -		if (vma->vm_start < start)
> > -			vma_mt_szero(mm, vma->vm_start, start);
> > -		else
> > -			vma_changed =3D true;
> > +		vma_changed =3D true;
>=20
> This says vma_changed =3D true even if vma is shrinking, so below we migh=
t do
> an unnecessary vma_store(), no?

I think you are correct.  This should be handled like the vm_end case
and how it was handled before.  I should only zero if an insert won't be
overwriting the area that is being zeroed and store in vma->vm_start >
start case.




>=20
> >  		vma->vm_start =3D start;
> >  	}
> >  	if (end !=3D vma->vm_end) {
> > -		if (vma->vm_end > end)
> > -			vma_mt_szero(mm, end, vma->vm_end);
> > -		else
> > +		if (vma->vm_end > end) {
>=20
> In contrast to the above, here vma_changed is only set when expanding
> ('vma_expand' would be a more descriptive name maybe?). So why are the tw=
o
> cases handled differently, am I missing something?

I should not have altered the above case to be so different.

>=20
> > +			if (!insert || (insert && (insert->vm_start !=3D end)))
>=20
> Note: thanks to lazy evaluation, "insert &&" should be unnecessary?
> More importantly: is "insert->vm_start =3D=3D end" a guarantee that inser=
t
> covers the whole interval from end to vma->vm_end? Probably yes, but a
> VM_WARN_ON would be in order?

Yes, the insert will cover the whole interval from end to vma->vm_end,
otherwise it's a split followed by a vma_adjust().  I will add a
VM_WARN_ON for good measure here and above.  I will also fix the
conditions as you pointed out.


>=20
> > +				vma_mt_szero(mm, end, vma->vm_end);
>=20
> I guess it can't happen that insert would cover a later part of this
> interval, so we could zero only between end vna insert->vm_start?

Well.. it doesn't happen right now. I believe that insert is always
passed as NULL except in the vma_split() case.  If you think about how
this works with the rbtree, it cannot split a vma by partially
overwriting the middle of a vma as that would break the linked list, the
vma start/end would not match what the tree expects, etc.

>=20
> > +		} else
> >  			vma_changed =3D true;
>=20
> Same nit about { } block as previously.

ack

>=20
> >  		vma->vm_end =3D end;
> >  		if (!next)
> >  			mm->highest_vm_end =3D vm_end_gap(vma);
> >  	}
> > =20
> > -	if (vma_changed)
> > +	if (vma_changed) {
> >  		vma_store(mm, vma);
> > +		if (old_start < start) {
> > +			if (insert && (insert->vm_start !=3D old_start))
> > +				vma_mt_szero(mm, old_start, start);
>=20
> This condition looks actively wrong, no zeroing at all if insert is NULL?

I think you are correct but it did work because we never shrink from the
front today.  The insert is only used on splits so this was never used.
The resizing of a vma is done in shift_arg_pages() which grows lower
then shrinks the back and mremap which grows the back but leaves the
start the same.  The only other place is vma_merge() case 3 and 8 which
also don't need zeroing here as they expand other VMAs over it... case 3
is when a new vma can be merged into the next. case 8 is when a vma is
overwriting an older vma and can be combined into the next vma=20

Moving this code back to the first change block simplifies the statement
here to just a store.

>=20
> > +		}
> > +	}
> > =20
> >  	vma->vm_pgoff =3D pgoff;
> >  	if (adjust_next) {
> =
