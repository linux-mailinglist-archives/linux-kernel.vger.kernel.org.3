Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA68F483554
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 18:07:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235069AbiACRHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 12:07:31 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:14054 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235024AbiACRHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 12:07:30 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 203FVV7t003301;
        Mon, 3 Jan 2022 17:07:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=MMhVmUvUDIZrA+aWJ17cTqtTCUFzYXecndg5/9Z6fWo=;
 b=u2L2dHNb+vv6Szk0C2v4uWfHyaQAMEDcfDr6H7CkM02QHplqOhBUFcvIKCvNJQJjBNw7
 zqFgsUreYU1CHha9NI3GcHPBSIPkhsVjWtFIIt0YbdIegIcwovph7g/fpK0kOYuah6De
 YsjnfFan+8AOhVGy0/O5TOEWDoa8DB3a5XBxqsw3pVUHoJxPKi4G0XsUxWvJrlNk65bQ
 PsiakKVlQ9LG4sWBQ+g4j1IFWAqYAHeYiOCboqzNZC4vwbf9A1QSRSF5lHoFmlNINTm0
 8dnlMRFoulYFFhAkd3sHTyD/WFt/KJTzKdJ+3brlDNCPkP/BMYb6DoJoD2pA8TYQh99l zA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dc3v4g7ph-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Jan 2022 17:07:06 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 203H5BZt051154;
        Mon, 3 Jan 2022 17:07:04 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by userp3020.oracle.com with ESMTP id 3dagdm2m8f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Jan 2022 17:07:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RybHBI1A+q24yKIq6tPn2JNmMwrJoZFKS5rONEZd7LKaObmfNokPYu7kMs3SMFL2H5dpIZ0LiPFhuCwQ7e3bhWn82KcEI1UOPVGiz1K5xzutocQ+9qBbcIBle+1ua4dpi361yfi+2RUBpCCnW/NLJ2/cQ69XVV17JYD3Y/wkYsbyMgcu5boN2EAqz7NhJYSGHrrOv0y2oBe4GMgd5H9ZGKbGLs3KJZ32XeOGPZoV32wmalPBEFXXoPhxdg/voVeF7vzaWEUVX2ZbBRLMLd/91zZjamGDeNXs14eb0GaI3p+yLb3HOcIMoagh6fLuvEuOoXGTtePKWjLGL3jl+ARTUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MMhVmUvUDIZrA+aWJ17cTqtTCUFzYXecndg5/9Z6fWo=;
 b=M11LYAw6JtgY4UxM6gtS6XcJnVWocILeGZ2Ax1LQGuPov5+2SBjJjmLmu9uYm4sV46VUvQ7xM2iXihCnFrpe5njoS+0J0hkc7q62697K4Egd/JDDKTnDInbs1QZdlfR1jBzBSg+wPa/Q3SiDhgCVyr3oX0T4uBBsyy/cPP92UiQhCyUOkGSBPSOv8x03ymlpmsvmUCBaF5LD8Stq7DryNr8KgxcObhUtlDra0meYOgoQgHh/ICXI5X47DfDgvDTjBaFUsUjXbMrSOJgS+jbl4ZIlpJTuupj1u60VC/69dij/GvqLTV/KzLR/yDZUwQWs3AvVioZxjY/fa78grlHePA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MMhVmUvUDIZrA+aWJ17cTqtTCUFzYXecndg5/9Z6fWo=;
 b=U1Mhis/KuSz3661xPmxOXFDKpbY9fc7zxo/R9I3GXkepLN8hOJVdm2w+8wiOUTwFO1Zpuj0pRMl9nwInhjIDuA7j939znS1fZWNZCI50U4P190AiCMKsha5dDqVDH0m6R7uYL2w8Vd1Cnu3uY76Cn652MrOFGbGKVUNUu7xma3I=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SA2PR10MB4556.namprd10.prod.outlook.com (2603:10b6:806:119::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Mon, 3 Jan
 2022 17:07:02 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3%5]) with mapi id 15.20.4844.016; Mon, 3 Jan 2022
 17:07:02 +0000
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
Subject: Re: [PATCH v4 15/66] mm: Convert vma_lookup() to use the Maple Tree
Thread-Topic: [PATCH v4 15/66] mm: Convert vma_lookup() to use the Maple Tree
Thread-Index: AQHX5r/pa/3zIKn30USZuCbXNikPEKw2rXWAgBsNqYA=
Date:   Mon, 3 Jan 2022 17:07:02 +0000
Message-ID: <20220103170655.3jxk2xwne4xrod6z@revolver>
References: <20211201142918.921493-1-Liam.Howlett@oracle.com>
 <20211201142918.921493-16-Liam.Howlett@oracle.com>
 <1347d8f0-671f-35cf-e49d-9aa666c61eaf@suse.cz>
In-Reply-To: <1347d8f0-671f-35cf-e49d-9aa666c61eaf@suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9d4a3b42-29f1-44a8-e345-08d9cedb7612
x-ms-traffictypediagnostic: SA2PR10MB4556:EE_
x-microsoft-antispam-prvs: <SA2PR10MB45565E174BF40E7B961AEC32FD499@SA2PR10MB4556.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3gxG34LHmTXrMpCL/CwWw3uJtfibxtvqu2d2VB/4ULG9nL29QstdmgiZvPve1rg0TSapK0V2fNCYuCq4ur9c9ZyyBv5lIr78v5JJYrkJ8sFGJbWvLKve3RzLn6xUKfjuupRjr98wCgmULKBpkBm7lps27aD1t4t3sCpfw0+QbQaG9HrrY/Q449R4fwa+d8OkSzWbZBSLPAl4KM1X2RuGBcCO0gnp8ZdTKy0hoqpdjANiLeAKpr23WbRFdjPK3VY3ihqIRaQ26MR4jFg5nD6DB8VWyNJzb7EZqNEDSyHkUqz6c9BBULDvf5tlwccSzUcuvkZfqdVcSz7OUvKGPhYdN4VgEC7gByL9UI5Sg5Ut91XnbBV6PrECO3jzPzO03D/QTzNNFQXzOsSQ5GGTEg8pPwvP/+VlL7yP40jpTKrF4X0aoqdVdzdWfKq3k9fhb3HDDFtEaGjcQdnYOAFHke5efadxI47k2bjkmL+HqHtbAjPXLceMk+hoGPO7RV8exzvVN8hp5D4MAffQig4TBi7HKFh2lW6xDgdZ0/6lHr1pCYUh7lzZA21UJJLcQorP8+zOjWt+mLGbfkUPBAYIlFKNzHDiNDH0cYBMUX6BtjBQr2yoSZxXfwdfspJ8cHTbqQpE99KXa50ZyJ8SzgC4m8sZv0JazZVsEHgWKNvmnrQ+KHOFZdQZhzMD/YU32BgHIEx36c/wS2uItci84n1OBn08OsGantQmzfA1Cws1e3I5L8op181YeZQ7oLdGLrGzbEEpDTyNSm2UZhUSl5/qyzcQIeebdQiX05hhJrWrpnjD2LU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(38070700005)(2906002)(66476007)(76116006)(66946007)(66556008)(91956017)(7416002)(86362001)(6512007)(4326008)(71200400001)(44832011)(186003)(6486002)(33716001)(38100700002)(122000001)(54906003)(6916009)(316002)(66446008)(9686003)(8936002)(1076003)(26005)(508600001)(966005)(53546011)(6506007)(64756008)(83380400001)(5660300002)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7OinEKx9NYS+Ubo+0bHqJYvyTJlMvqXsB9Rr62hqdIwoxR6XhM4jJHxWdRHS?=
 =?us-ascii?Q?BWfm93wPrajqJ85azkhq56+yYB16MGbH4x4MoQpPFXZfWz+skZDcz6qKGDYU?=
 =?us-ascii?Q?7OVXJfG6D+eHupd6cRzHCPC14HSTBhnxgzcqOWUx+7EVrylCsQeoIhOy83Q/?=
 =?us-ascii?Q?0rLmXsbIhnSVuY5HK9yHiC7gNXhwpcn4gNdiMKIXkWUH+aQmfoQ0CPbySUyS?=
 =?us-ascii?Q?vCsBS+XYShlFy83V06yWHEYyEpB2R3O3J85Nic+nwPnMTuMu2ZBRe9IlsyNo?=
 =?us-ascii?Q?EOw0+jHnKs8XU+OYzR7coJZ2tK+l7zdj69wB/zpphg4gAaFrkFZ9WKByeo6r?=
 =?us-ascii?Q?KXCJHyKOnVs6yvXMRG+EbHIpKFzGSawt8RfzkvqAA5SBs/4g09A3jHlFCBE5?=
 =?us-ascii?Q?yib3OaSY9JPajSs8wfljjVbZLMvngHEf7vPSELH6OJNaT/i0BreJO+6eben7?=
 =?us-ascii?Q?shB0PAMFQaPx6kpjXHFZp+YJmak7f0+tC02XddZKA6SZqfEFLdboGWDJdpXs?=
 =?us-ascii?Q?LOr7UbPYMUXFBvvN3z2+DtwAMKoCcjaPoQ6KlsO9aRpXYDl9J8jtliAkXQVk?=
 =?us-ascii?Q?nbY3hB78Mjo9lXHLGXciCY1TeDWaxalNIYloNV/8wdyuJYQ+3ts0sfPMaGAm?=
 =?us-ascii?Q?d8zURk6BzFWXrvBglTlH/dYqCwz9wzs/25V6sFAKJjc39wbJ2lPr2zRdWSvE?=
 =?us-ascii?Q?0N84Z90QuP6ToxgdIMsJYuSBqoeirRpnpwONay8p6FcWnpsIN2FBojE3J1hS?=
 =?us-ascii?Q?L9URYHsbYZ7IvDUKSukSA1Nxu2tVcOF/x2M4NuNBmq7jiVP231vWjB9I6x9U?=
 =?us-ascii?Q?gCLvdqr0Hh1RsbpMtgN6/dfUx/eKStzncmQAboJ2dhkRtWJEkcqTkJmrY6WC?=
 =?us-ascii?Q?liTboboEh5bgQ9C3kY14MKm7z25TfbmdXdJ8UqJaO9scyGPsFnEQJ0/YRzKw?=
 =?us-ascii?Q?KRPVK6d0U/7i6WTHsYgR/V4jmVjKA4lrGY0ONUFva4yCwvsnIp7WRUfYOOIx?=
 =?us-ascii?Q?tO45kfzcgexVI9aN2O7WFbsTsj+lETiSVEkdCMaA3bMtp+J7OwHVAv7mNvAe?=
 =?us-ascii?Q?Xj98CjyCKP2TloAlpI0tiGB+sd/8qg5eTz3CSiRqWEEhyegrv+yCgD4+bcmx?=
 =?us-ascii?Q?tAZLJXDr+z5gDDQjvDmFiqnsqwPatTDOCp/IEEA11V5l/d8kF+qN4Ja1awgk?=
 =?us-ascii?Q?taeH9cRsR/uXP+SwLcVeiB2lmNqNK8dObi/CrdC6ZtSs2dZk0C0A46nWgpdQ?=
 =?us-ascii?Q?r9OcotWCLHCtaiV52IMwp4GU9bTIz117TG3+20psAmEt+MwAUVmsE2QNrGnC?=
 =?us-ascii?Q?fANLVHRskbwk8r0gpx3AlDyz3TLa6CpP+aXoi+Pj9aIN19JbavOsr5H9eiYd?=
 =?us-ascii?Q?q4Pf8hebqhxOebPEfKUTmK20iadZzjkjktN9gApQiSaIh0quqTu3LX1uQM3A?=
 =?us-ascii?Q?YyHl8XRBHIfwg83iPXhqP8otNe0+CTnRFgn8akpJQPINiS8UUt/pORZsr6jv?=
 =?us-ascii?Q?76+RkCkNZzc5J0psU6ZzfsOJID92HaxuB/ryfcOxUuyMhYET3R6PhQH/gotL?=
 =?us-ascii?Q?78UJX8aTaIiJTEJT0A2p0y3biYoETAQNEMD9CBfpi5W6B6OXwoWQ1vd0Jjpd?=
 =?us-ascii?Q?M2iREbizrN3ZvBHhKbMAlyo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6A05DB0A749D6C478B80DEFB285004A5@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d4a3b42-29f1-44a8-e345-08d9cedb7612
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2022 17:07:02.3119
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Il6RxN8D3gvy8Nla5mHosYMaBFe1e9ZK1eRrQ0mq46h1ur2K5Qxujj8g6Skesx0r2drnUH77AxIu7xA4WG7PHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4556
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10216 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 mlxscore=0 phishscore=0 adultscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201030116
X-Proofpoint-GUID: OcPujYnJqypkLfgL-lnH0cwBkxxhI_mp
X-Proofpoint-ORIG-GUID: OcPujYnJqypkLfgL-lnH0cwBkxxhI_mp
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Vlastimil Babka <vbabka@suse.cz> [211227 11:58]:
> Re: subject. It already uses the Maple Tree via find_vma(). So more accur=
ate
> would be e.g. "to use mtree_load()"?

Agreed, I will change the subject to better reflect this change.

>=20
> Note there's also the side-effect of not using vmacache anymore (which is
> still used in find_vma()), thus again potentially biasing results of late=
r
> vmacache removal. But seems like vma_lookup() is not used from hotpaths, =
so
> it should be fine.

yes, this will affect the testing of the single patch removing the VMA
if left this way.  I'd like to point out that the testing of the VMA
cache removal was done with the entire patch set, so the results are
still valid.

>=20
> On 12/1/21 15:29, Liam Howlett wrote:
> > From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> >=20
> > Unlike the rbtree, the Maple Tree will return a NULL if there's
> > nothing at a particular address.
> >=20
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
>=20
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
>=20
> > ---
> >  include/linux/mm.h | 7 +------
> >  1 file changed, 1 insertion(+), 6 deletions(-)
> >=20
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index 4d5ab70b1f6d..c28bd97a4ecd 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -2845,12 +2845,7 @@ struct vm_area_struct *find_vma_intersection(str=
uct mm_struct *mm,
> >  static inline
> >  struct vm_area_struct *vma_lookup(struct mm_struct *mm, unsigned long =
addr)
> >  {
> > -	struct vm_area_struct *vma =3D find_vma(mm, addr);
> > -
> > -	if (vma && addr < vma->vm_start)
> > -		vma =3D NULL;
> > -
> > -	return vma;
> > +	return mtree_load(&mm->mm_mt, addr);
> >  }
> > =20
> >  static inline unsigned long vm_start_gap(struct vm_area_struct *vma)
>=20
>=20
> --=20
> maple-tree mailing list
> maple-tree@lists.infradead.org
> https://lists.infradead.org/mailman/listinfo/maple-tree=
