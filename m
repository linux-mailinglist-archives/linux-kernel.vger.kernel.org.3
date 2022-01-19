Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9732D493DB1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 16:51:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352612AbiASPvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 10:51:33 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:30518 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238625AbiASPvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 10:51:31 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20JE428U010647;
        Wed, 19 Jan 2022 15:51:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=gNeZw4c2MPuFPPhSVw6KPCvroCU8HCkxci+QK9vxzuI=;
 b=CHRtm6v+4cffV5+GRAnnLMZDj1843etI90FRQKzEcGO7JH1dVWa9byYTJ8IrPvEUm53g
 8XqCwZhXfQZckEqmfof0Bv4q9pknyaIxuswpL5DxLwHcPboP13HfGAfpWa0aZdI7nlzT
 tPNXQs/GnpfBnHUvk+uaMBOQDrYNrjvx/RJ/d3KzoSbbC28G1WeGJbj37iW69GdfELn3
 6knboCWL2XCvUitKsxZYFW16CkRRgjrWrTUZzmOVXuwrKI5y0NearesblYV6BORMDuwz
 x7p+gk5MN/1K5Bg/K46k9mOTEv19PUgkGJm5jPn8o+y0xnB/zMMsgA9yFzN4CvMf5KZO uA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dnc52wggr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jan 2022 15:51:07 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20JFauJk120387;
        Wed, 19 Jan 2022 15:51:06 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by aserp3030.oracle.com with ESMTP id 3dkmadu4sh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jan 2022 15:51:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FbpxsO1Sy0Smll6Y+v3PCizcJAjCR3kTEFsjhgVfZXG6uObFcscYSxCq6lfJxRupOfbw5m0VyxLyJTDyYyEzixKkujmpvIH5+RkFveXEtEA9CzjP7TSruENLhQsqjRFzW9CtJqbRAPkJoyZnmiD9UjOgsuLccd+wqcEU7V2k29bGxKQ5WfD+vIfAh54l0y38Jkb43cOfWBu8S8xg/r5y9uL93/Oz5mVpKDojBR9wbkxNj+KopE4dgiCLYityQ6S0zqy1rwLiHJGdoJdwDERYIomHpbk8h7Pq3+Iy240Nawz5C1QchAlgbAbauhvmuBRBNyGtPJA6+axlNLPbIZAa6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gNeZw4c2MPuFPPhSVw6KPCvroCU8HCkxci+QK9vxzuI=;
 b=RXfenm8jLsRtvLF1Y8V8NNI8MgfFJ2J9UZqiMdeb1bbw/4w7Tj0QMJ5Bw1RUtfa+lNTvAPrIWoCNvm4oFOg4yoxiLPpgF+kmzD5Rr2whyK4oPoKukk9niSxdAMU0uG9DmwZIVgZj2a0Gh7wiYfn6X6meQTFLJdE6YsfOTsDrxFUovyNDJhD8PaavH8K7pJ6SG4brVGB3oV4i5pUb0LruNRrtj8iIOXK4qzDPlm2heRvKXbMBzScWwbvHcm7UT8c4PzzsxP9lIieiilm5ND5qXzpZomd8StHNZOelKezVczTBbGUNL+nmUE44ZI2JVswaJjEOQvKoSfSf0xt73a1RLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gNeZw4c2MPuFPPhSVw6KPCvroCU8HCkxci+QK9vxzuI=;
 b=axjNNpbvkUMMsah3UMs1nFa9k5IwLosfiUE7onEPw/82iyojT1ryRrQiP9UBvi2poWwvgHsSV9XMvWhSyRK9l0szbaNBSUUzoJ75EUDxuuflyZvZ6TENyqBtKFTXle6HRjxtKP//Vt+ymeb3omYRroS1JHzATGULVNo7qLAo4Zg=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB4638.namprd10.prod.outlook.com (2603:10b6:a03:2d8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10; Wed, 19 Jan
 2022 15:51:04 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3%5]) with mapi id 15.20.4909.008; Wed, 19 Jan 2022
 15:51:04 +0000
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
Subject: Re: [PATCH v4 21/66] mm/mmap: Change do_brk_flags() to expand
 existing VMA and add do_brk_munmap()
Thread-Topic: [PATCH v4 21/66] mm/mmap: Change do_brk_flags() to expand
 existing VMA and add do_brk_munmap()
Thread-Index: AQHX5r/rzykS1Bt/D0K2KeUVeWbMGKxhVuYAgAl0TQA=
Date:   Wed, 19 Jan 2022 15:51:04 +0000
Message-ID: <20220119153808.dyiuolvzsanfgdmu@revolver>
References: <20211201142918.921493-1-Liam.Howlett@oracle.com>
 <20211201142918.921493-22-Liam.Howlett@oracle.com>
 <d979a786-65da-11d6-8d81-14859f2c7d4d@suse.cz>
In-Reply-To: <d979a786-65da-11d6-8d81-14859f2c7d4d@suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b78f2e1b-b833-469d-8a36-08d9db637ffc
x-ms-traffictypediagnostic: SJ0PR10MB4638:EE_
x-microsoft-antispam-prvs: <SJ0PR10MB463823AA4A9BA541ED2B09DBFD599@SJ0PR10MB4638.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZdH/vut32+t/EdZRYbnlsiMUyQRRn9h2N35nSzZeEdtu4ML/OzN6FrvDb3d0BksjUVzjrGkbe/wiOwgMyPDTg8inoWmDdKPtbVg4RR/qVeRudjazAatM7VfWLn7XXKLGdZ8lpCoC9Bk+eeYzFS72EYOXTECNr46Ai5gh6Rcqk+bE8w2rbpEVI7xLQoMIlCGQLjB3qrmS6vK7yFZyV7SN2MGu4vRC5FPTZboImmuBKKc5cMLoe/U5o0wgjPSLF75zCjxTHzZi6EkDuWnMcNPXbQ7Q4qOI7BzSm6KMt15pTjXEjU44c+zX7pdYYT4wxVHA70F9+J6pX738+z3vdTC3LM1IlUFvK6UyfTwq2sB35mavUFsPNYI+CwNs50Q5HnNiNoj9vkvMF+gM03jX52IiOLtryC5PdRtPI2gJKoQ2hVyMBC/vedJHAno0dl8bO3BMwqKMFItTh/pI1M94Gxv3xBVE6T1Xr3sZKX5ar5gB7s1lNJ2k+M99IgYmOOI8jNN5gpWGpSTkG3+qmgW9HcOIw70pobNq6o54XGVLtjnD5G7OscjG90qqLtKeSyBSn316ohrCAAb2nZEZX/+ddQZaOzA7zsOAApER/H7cyXa53HnZXFroq6gR49lRjwIVNuDLcp/UEoHlaFLfjjXCXON3GIMIr/wGzLIIsTrtDwIb+Q0MkYGMom2RGBYNW30+Td4Jz7gWCpH6En95X7PZkWQ7DA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(66446008)(8676002)(33716001)(38100700002)(6512007)(4744005)(122000001)(71200400001)(2906002)(54906003)(7416002)(9686003)(83380400001)(6916009)(6506007)(44832011)(8936002)(38070700005)(1076003)(66556008)(4326008)(66946007)(3716004)(53546011)(86362001)(186003)(508600001)(26005)(66476007)(5660300002)(316002)(91956017)(6486002)(76116006)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZwcGj80bt1q0GWRQZgxyHfbfLZ7BAs2X1cRkNzcD1xgAfRJXT74H5Gd4+zxv?=
 =?us-ascii?Q?p79Sn1Z94+rRQAt+ogpGE4FSRzroxnhRFn5SY2ue04AJUbn4cQvoQbP5Ay8m?=
 =?us-ascii?Q?GwqJFlV3lZQEwcgbj7XTGWTkxj1kylFR40eET4tockbN/2/0j9JbUgMW+HbA?=
 =?us-ascii?Q?bXsRcUMMsHKOhD6aqqxVrFlA9gOkdXELcjk42bc9x9GwJ+4oikjEA5Zn7LUM?=
 =?us-ascii?Q?SADUdlgFGSvxDD3K+wFsF98I3X7FJv31BxG9EpnyUjK3k74/XF+ws0OnKVS2?=
 =?us-ascii?Q?rkDNZ9tqScA24TQUYgngoD91lr5LKhqvq6QutwjeHDt9i4l54dtkqoKjL4s3?=
 =?us-ascii?Q?sKSjTtQzqBrg6YcmDYbLu+Zv++FjFgnCKD+1dpuwcfCpzYKbZwRORZrLyzBk?=
 =?us-ascii?Q?Dabtf9NhTC6f0/suw6thm6tI0xt/n4sErCww5pW0XAT40aqrkMjd8qigIgA6?=
 =?us-ascii?Q?ZsP9bW8pAOdqHrKxTQCPtBVuMXPTcol0EJ+MjKP3uCtWoW/YRc+bRg1CkbdI?=
 =?us-ascii?Q?glWtPjDaS5AWjN9suLDC8RPvXnbA0NL/FtmtnBuKI2o8gIz9UvBeeltnWu0I?=
 =?us-ascii?Q?K6JXlvK0d6N+C0jXXESEeqKIqUaLb1btglbHSY7MACltSFrSj+39lIH8m9hb?=
 =?us-ascii?Q?kt4YvbKs04bbttO/7n8HC7vFgBCDE5XJyW9U/FNKSDnw5yFvtvDbXmya+lgY?=
 =?us-ascii?Q?36VFK/PzKECCiLQJ+ybI6RhkhwtK7ftafqSO9UKH10CmLisqmcli556XdvQe?=
 =?us-ascii?Q?9PuippDziFTDi+8pTM0lktTqnRPygujrjhX7WxEK7DddFHCOO0clcDZ1iJVW?=
 =?us-ascii?Q?8vJN62n0JzGus71kI4/vXJLrXBFwDUFVVLe4kiHmjOQmjTxKQS/0c1YMPqWm?=
 =?us-ascii?Q?FOnq8qzsueoIK9GAgX6Pk4LsVZ6dsQxGjUHny+x1v6NGm6jWc0BMuhN4RV4o?=
 =?us-ascii?Q?9rI3XmZe0H7mItg9AqDX+F1aMZtFn/6rSZCD8Xrunl+1lOhncgIiQttWTmpQ?=
 =?us-ascii?Q?AsGbTV5qCrR5SIkMVom0tj3FLG6I00p+dkbRVMw9eJj+8vvrBDkWWCnXrJKc?=
 =?us-ascii?Q?9N83GVZP0FMbSY2TrmpDw9T+Rn2AEzI4+iipUHXiTWysyb++mUUmCcApq0yt?=
 =?us-ascii?Q?UGUT5860H7eZUWj7Ybu+m4tPm2rRZF1s+Lu7ccdpVUlDcmVEnS/p9cm0Ghoc?=
 =?us-ascii?Q?PBZ/387iPPrYVNArdRCMNapfmghqv77ZbsX28MhHnxIDUTrFvFNrsB7xS9Py?=
 =?us-ascii?Q?jBFGyJDKOK+vd2yph1A+Lpu8UXjC4ekj6ZSCNSoGQB3NYI7Dth6jK0S3IcLp?=
 =?us-ascii?Q?mjcBPRV3PPyGwzxhsTYsN13hLm4Vfm3s1gV6bGhd+QHrKcMQ6wyAwz2XX+38?=
 =?us-ascii?Q?MGdwkbhagAC2vxnBnV5Nat5Lv48gJOyoWrCqcC1X0Ek5dx7EQ3BoL4/jV4gO?=
 =?us-ascii?Q?0CllI0ttbQeFfya0U5sPVDVxyHfXIbNJyGkSPlX+CI8eDHXGXmbZeEg764/K?=
 =?us-ascii?Q?x1Gj/rdHwu5malqpH2azimrGPi01GMbM1U1TmI2btLfRUJJo/g+yJeD8ReHi?=
 =?us-ascii?Q?+W/YCEW0MQH3XTQhQFscJdUO9qWuF2Ft90RZnliOXFg9a/g93O/yeb/fnFg4?=
 =?us-ascii?Q?c1/GUoZqYypgEmO8yPXQu/o=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CBD7BF92829A7E40A79DE3B750E046D7@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b78f2e1b-b833-469d-8a36-08d9db637ffc
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2022 15:51:04.4356
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UGWIZiMtZK10CuSVM8DA4NVSMgwGskFlXn4GqoWzYVdfo0FcRf7YmT78EE0uLPWJTvoxR6b7nT1j91O2WviFYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4638
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10231 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 suspectscore=0
 phishscore=0 malwarescore=0 mlxlogscore=777 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201190089
X-Proofpoint-GUID: t03-PCdRU5jRUxybPJ5QyvB4VMBDaPCu
X-Proofpoint-ORIG-GUID: t03-PCdRU5jRUxybPJ5QyvB4VMBDaPCu
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Vlastimil Babka <vbabka@suse.cz> [220113 10:28]:
> On 12/1/21 15:29, Liam Howlett wrote:
> > @@ -1989,6 +2013,7 @@ EXPORT_SYMBOL(get_unmapped_area);
> >  struct vm_area_struct *find_vma(struct mm_struct *mm, unsigned long ad=
dr)
> >  {
> >  	struct vm_area_struct *vma;
> > +	MA_STATE(mas, &mm->mm_mt, addr, addr);
> > =20
> >  	mmap_assert_locked(mm);
> >  	/* Check the cache first. */
> > @@ -1996,7 +2021,7 @@ struct vm_area_struct *find_vma(struct mm_struct =
*mm, unsigned long addr)
> >  	if (likely(vma))
> >  		return vma;
> > =20
> > -	vma =3D mt_find(&mm->mm_mt, &addr, ULONG_MAX);
> > +	vma =3D mas_find(&mas, -1);
> >  	if (vma)
> >  		vmacache_update(addr, vma);
> >  	return vma;
>=20
> Oh and this change to find_vma() was supposed to go to the next patch, no=
?


Yes, thanks.  I will relocate this change to the next patch.=
