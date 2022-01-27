Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D49EC49E8EB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 18:26:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237981AbiA0R0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 12:26:17 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:32174 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232577AbiA0R0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 12:26:16 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20RFu2gZ029453;
        Thu, 27 Jan 2022 17:25:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=uxwxlY2UAoPWXBHvzb7H29OKhLSAAKp7DMDwxqneBF8=;
 b=CBmliOXDI2rLBuKqWcLxwjU2LpS3LXyFvZ2iLgVENncU7eiI3vb+okbnEMN/+tlz1gJM
 Rz4wou23uaw9CuIDoVd5i4xEE/QkEAoplu7jlCNeU0wfjP/kkz8M+i3jMcixU1iyu8Ky
 z0rzsu4FvwVAk5LHRCyJF/LOnY0APl2Dlby3YUbwjALDxGQARmODt/4ZsOj+NNFg8Ql5
 8ssiW3MKBl413roAeDrpe5Qm++QMW4R1OEIYEBNLmlP23iPmBip57uUNdgWyEML1MG/E
 U4URtpwtwj1kbGdi5kgvD8/AnUgg1hLqrnHvsVpyski+d5BPBMx+BdxvuU2PKEaWV7G+ GA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3duvqurrfv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jan 2022 17:25:27 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20RHF6JF167795;
        Thu, 27 Jan 2022 17:25:26 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
        by userp3030.oracle.com with ESMTP id 3dr723xdgb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jan 2022 17:25:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TXzuJ0KoUkFvpVVafaQzdfGg8tddmijLf85gty6kKbiCQhC3NloCE99VsXyI0ecsrJ7+2DH0xr6NJnIDDhF55IKaChuq9i3aGDb5Qbpuv7hAEWYcX+1f/04i22YM/oiq0Kv9nppeO/WBbcvyb0NL1kY2eLZFyjOtNuA+8xJ/3Y/tToCYMJNrn44amoNFxru7B0CPET7r7C8f2uU/VClOfpvSoyfW/fhOZj0smwQ5JZX9IlaAKLYpXiJVIuowhrOVc4Yd5CMcmJcV98mGUuKunmbnPkcJ/oodEww3yd/dUUDe0k9tJIsqssNMZgZDKWx7n0sci0rUhFRqIwkb/8axeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uxwxlY2UAoPWXBHvzb7H29OKhLSAAKp7DMDwxqneBF8=;
 b=AkKvDIKI9rdhBF+VKv7ZxjEaMRas+TY+MpcvQ0bjpRknC2b/NqBAIuFzUlo3EaxZ7BUNn84sqz+b48LTZctljBrzJ2DA1KX2AIZriwXoEpClJbFjS0jcjVeCBtC3jRQxUPIJnKSUN5WchnfyZiUkHxqNIq1ZXIGU03TO7DcbmqRYDJNsbZE1nlrmKMXo+M4hXpQWZ4Kqr2vgZ6BVgKPaQMFkMZlm7ob4oe+tgel8AZRraR6VjgVA4TyRxePFA48oxvIddq5YRhmGGZzpzku/FZ0tU2UO0+wpgzkKKtxJy2rpuAvq8suLyfW9cGTSG2e4SGCV2HmvbVJyUS7L+avN7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uxwxlY2UAoPWXBHvzb7H29OKhLSAAKp7DMDwxqneBF8=;
 b=InuQ+3bHjhjToIsqTFJ/BzSrdEox6YcnT8zDgwFk2js+O5yuhS1gLtcuUBUV/5/1MWgTLstimHytD+bZbw2XkA6QWQmCttki6CyhQ27kFbDj4L7jrcq7ZC82/gb4H0k94ErADSi/1W74Hs/B+y9S2COKieJBCl8EGh6rYvYuI7M=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN6PR10MB2528.namprd10.prod.outlook.com (2603:10b6:805:45::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Thu, 27 Jan
 2022 17:25:24 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3%5]) with mapi id 15.20.4930.017; Thu, 27 Jan 2022
 17:25:24 +0000
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
Subject: Re: [PATCH v4 55/66] mm/mempolicy: Use maple tree iterators instead
 of vma linked list
Thread-Topic: [PATCH v4 55/66] mm/mempolicy: Use maple tree iterators instead
 of vma linked list
Thread-Index: AQHX5r/0Jk+tXlVP4UiIr9o8XNMVtqxsHKmAgAjUMICAAG4+gIACGRsA
Date:   Thu, 27 Jan 2022 17:25:24 +0000
Message-ID: <20220127172516.dj7mditbishetlxv@revolver>
References: <20211201142918.921493-1-Liam.Howlett@oracle.com>
 <20211201142918.921493-56-Liam.Howlett@oracle.com>
 <10798a7d-e157-03c2-abf4-f005a3507cae@suse.cz>
 <20220126024819.i35wd6uxh463wkps@revolver>
 <3dc23bc9-2b0f-00af-f85b-22c270356e96@suse.cz>
In-Reply-To: <3dc23bc9-2b0f-00af-f85b-22c270356e96@suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 127fa1f2-f8f5-44f8-0a4e-08d9e1ba00e8
x-ms-traffictypediagnostic: SN6PR10MB2528:EE_
x-microsoft-antispam-prvs: <SN6PR10MB25287039D3B9C98E41558C35FD219@SN6PR10MB2528.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GDUeTpytT0aio8+mx9/TVEPRTbp/MhafSNOLd4pBMMkhEBa1CNazG3t0CVcYzXUaRxdmgxuyxyGCVUJ3dLY4EpyZq9wFqqz0Lhs8Yh9ZiVWT0DNy+WpXWfA+Y2U7d9Yv3WxlO1KcZv1TGO804nfR99wbghTXUeLP4BOYTZLHkwB5kX78tCb8I44u27Y/6GLbFJjUYnCi4hO6CVU3nUr9EIygUq8neIiu43Mu/VbN/+vgkzQRxOV0r9G+2TLszeuFXA1kFKMu748ZaA4BKJJshuZhcZqmEUgtp7QLRiw4Imz1+PKZt1izfVf7pw4G5gtsddlwyI3LLSQ6/ea+2ohTcVjEjisFD3u97D8chsPUU22B+alsk2w8Wq4H1XAO6eLhkYgmV/P0o5isOOMckkFO2cttCaQQN1ETT+ZbpyRzi90X6NTz7RRm6V5G7nS7cJmxMTZd21q0lX8KwxdEsvz+Pn6XsoLepw/3hxePWfDkPp2dk5VdOnY5E1KA/yt8x/ZnDZoxwXgNgraZH3YUi28R0JadCpvJVWNSQ9LqCYcTFErlJlFwa9BnqKeg+Eb0LNfLLaPRdrXHIqMpBctErQaVxq+IjrgAdg0bG/Cks8TGstmw5HlU+kEjPzLikyh1eFGP92oqRW5xcip02r8Af1EsgGiPhs2f977hKPa2wU2oUx2CQw34kKkpDCJCvVjsV3d3w3SPysTGLZfUjJQkX7lknQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(83380400001)(38070700005)(86362001)(2906002)(71200400001)(53546011)(54906003)(6916009)(6506007)(38100700002)(5660300002)(122000001)(316002)(64756008)(7416002)(6486002)(508600001)(8936002)(4326008)(6512007)(8676002)(186003)(9686003)(44832011)(91956017)(66446008)(66476007)(76116006)(66556008)(66946007)(1076003)(26005)(33716001)(20210929001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pKi4jwTFba3areNkUo4a95amy0wdomlJvTyc9yo4ezpPXDcf0YL/6lnViG97?=
 =?us-ascii?Q?UQLHlvlE4iJ0ZPIsTb/Gu/AjOIkJ3t1k0r0Is5HueJ5Kwiv93mYa9ERHj6XV?=
 =?us-ascii?Q?k5E8YEceF5rcerkEnoA3jw3kmMnox/tvaeLxt9ZBDs4nkKrMAwPwdkq5MeF5?=
 =?us-ascii?Q?DTSpcHXCkTo5CfG2XC4VC1B4uNgmuRgOPpcZtkx5sJOHsOWJqz0oO71kuaAn?=
 =?us-ascii?Q?1q/YvPVyuyrSQRIUTviUcxMQmi6c4XnST146VnJTM6V1rHW2UXXqbJzdOuxE?=
 =?us-ascii?Q?M0KROVP0DrgPPX86wGcg1UQSt32VcoYwjW/JE+AMPcR/CrEkTM164mkSBy+j?=
 =?us-ascii?Q?StGrgaICVSoxqjWDgW/KwLh6fTQAcU0ptaG7B2t7b0wChoNLRDdd7BtFqugX?=
 =?us-ascii?Q?IKCB2sePn7wvY2rpcLg/XhDUoAfkUy3VA1d5vOEkJVW9PaqnvOG2WJZHTPdG?=
 =?us-ascii?Q?Eks5Df3evPX4KD4Yj4lBXyTokI5EjehVuiFOCqxGOF/fhZW0pay3wxqg+/V1?=
 =?us-ascii?Q?O+JSPVdiPWwwu9VdoqffZ7HLkE9WHcUtKAB9Qo4XEBnY4w0f/kGreb5yRnaJ?=
 =?us-ascii?Q?IAXUyzvKOEuHXId/tU2enK88HpyFbJTydYW/FlU+ac1N2qWDCHaimJIZo51C?=
 =?us-ascii?Q?n2Om1vZxSpAkA+o0VNjtSYz/8cuPe+nlvAQVR1DOAiqb6Rqbi7IxY2h09ZG3?=
 =?us-ascii?Q?wqsD6CJyxWVhHp7HUYLfMAk7nVrKu420yEwLO8OgaTY1VWT7h456YrsdeaG8?=
 =?us-ascii?Q?Xl/RO2f11z+94hL+noglvNACnSTRGw+UtkNW7KEn+EeUJ/4GQGvQg6kErgFz?=
 =?us-ascii?Q?Sm2DRRsPP9MQg2eLYgeAfYL/lo6N+fPwT3Obt6ixAceSGro/g+ETZahYSmjm?=
 =?us-ascii?Q?a946Q820NUZPK4BRRV36IdPV4+BmbDwb8MZvTppo49X/pwR0YfMTZqM6nzw6?=
 =?us-ascii?Q?EVv6GvqhO3bdUugVspVp7rjkH1kLO9reRL6F2W42mNZWRfaaEd4+mOQQwvcT?=
 =?us-ascii?Q?MoLQy9YJgf7T5ZL6WX3dN5WF8yBoWHTrVNaHhj7uGag81w051cTi/NFqfdXo?=
 =?us-ascii?Q?HCuA91Ugvdi6US9sA8J/fDZO+nlBbo90+CKVuuEJg5lBhsLzhvG3yUzcicrx?=
 =?us-ascii?Q?85zdUILJFJsZeUe8S1WH0bOp/M13fkYmlQES1nDo4wMhyQdrId/ZLdzqa5+u?=
 =?us-ascii?Q?TLoCW2wYGb76O5+DcRFtPGN52HlQa7tlQTahrZFb7fjSwrMHXjlibGoHIwX0?=
 =?us-ascii?Q?jt/co6wGuMKKOYJSc7JXvvveP9Ur5/StTnBfZ27Yqv1oDFubPRYYjY3qDDEd?=
 =?us-ascii?Q?+tCs4sfIjOkGf9VMtmYQHI440pxejLrbpjc1pZ+JXkfkgtZ+kE9mwLRuS60J?=
 =?us-ascii?Q?6ajQ6Ilt6qL8QZw5k1TNeaTPVXJgbR+3olYQF4TLeYX24B3v4ql3lI6qoBME?=
 =?us-ascii?Q?moT2GxArS9zTI6n6/EXg6CuiWpkXQYgA+HwwHy+lejrdFD5i/dMRhJLQ/8ry?=
 =?us-ascii?Q?8Q7axopQVK14aKf0L4qKfmarRrH4ZprQpuc1O7tAw/+p0fZgVeNzoFJpLpO2?=
 =?us-ascii?Q?nIQYJ3oSRSzcSGEPqa+/j9Qh99NWbQmvkDTnysok/VfBgnOsy0xUUkPxiqyb?=
 =?us-ascii?Q?hA5r1x5JdxDYg9FdxvhW2ZA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F8E73E00485421459B5F92FA1C95EDBC@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 127fa1f2-f8f5-44f8-0a4e-08d9e1ba00e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2022 17:25:24.4072
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lQyl9eCb1jmJwK73q8zfbJ4ruk/Vg0iIg0IAcYdJIVLKDxjFqr0nIYEDEnzpmif8ueKg1e0OxX/aMHkDGNQq7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2528
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10239 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 spamscore=0 bulkscore=0 mlxscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201270102
X-Proofpoint-GUID: qLIkmsgHKfILU5ZnE9m6MoAGEHl9-xR5
X-Proofpoint-ORIG-GUID: qLIkmsgHKfILU5ZnE9m6MoAGEHl9-xR5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Vlastimil Babka <vbabka@suse.cz> [220126 04:23]:
> On 1/26/22 03:48, Liam Howlett wrote:
> > * Vlastimil Babka <vbabka@suse.cz> [220120 06:58]:
> >> On 12/1/21 15:30, Liam Howlett wrote:
> >> > From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> >> >=20
> >> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> >> > Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> >> > ---
> >> >  mm/mempolicy.c | 53 ++++++++++++++++++++++++++---------------------=
---
> >> >  1 file changed, 28 insertions(+), 25 deletions(-)
> >> >=20
> >> > diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> >> > index 10e9c87260ed..0e2d918f4f30 100644
> >> > --- a/mm/mempolicy.c
> >> > +++ b/mm/mempolicy.c
> >> > @@ -377,9 +377,10 @@ void mpol_rebind_task(struct task_struct *tsk, =
const nodemask_t *new)
> >> >  void mpol_rebind_mm(struct mm_struct *mm, nodemask_t *new)
> >> >  {
> >> >  	struct vm_area_struct *vma;
> >> > +	MA_STATE(mas, &mm->mm_mt, 0, 0);
> >>=20
> >> VMA_ITERATOR?
> >=20
> > Yes, I will make this change.  Thanks.
> >=20
> >>=20
> >> > =20
> >> >  	mmap_write_lock(mm);
> >> > -	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next)
> >> > +	mas_for_each(&mas, vma, ULONG_MAX)
> >> >  		mpol_rebind_policy(vma->vm_policy, new);
> >> >  	mmap_write_unlock(mm);
> >> >  }
> >> > @@ -652,7 +653,7 @@ static unsigned long change_prot_numa(struct vm_=
area_struct *vma,
> >> >  static int queue_pages_test_walk(unsigned long start, unsigned long=
 end,
> >> >  				struct mm_walk *walk)
> >> >  {
> >> > -	struct vm_area_struct *vma =3D walk->vma;
> >> > +	struct vm_area_struct *next, *vma =3D walk->vma;
> >> >  	struct queue_pages *qp =3D walk->private;
> >> >  	unsigned long endvma =3D vma->vm_end;
> >> >  	unsigned long flags =3D qp->flags;
> >> > @@ -667,9 +668,10 @@ static int queue_pages_test_walk(unsigned long =
start, unsigned long end,
> >> >  			/* hole at head side of range */
> >> >  			return -EFAULT;
> >> >  	}
> >> > +	next =3D find_vma(vma->vm_mm, vma->vm_end);
> >> >  	if (!(flags & MPOL_MF_DISCONTIG_OK) &&
> >> >  		((vma->vm_end < qp->end) &&
> >> > -		(!vma->vm_next || vma->vm_end < vma->vm_next->vm_start)))
> >> > +		(!next || vma->vm_end < next->vm_start)))
> >> >  		/* hole at middle or tail of range */
> >> >  		return -EFAULT;
> >> > =20
> >> > @@ -783,28 +785,24 @@ static int vma_replace_policy(struct vm_area_s=
truct *vma,
> >> >  static int mbind_range(struct mm_struct *mm, unsigned long start,
> >> >  		       unsigned long end, struct mempolicy *new_pol)
> >> >  {
> >> > -	struct vm_area_struct *next;
> >> > +	MA_STATE(mas, &mm->mm_mt, start - 1, start - 1);
> >> >  	struct vm_area_struct *prev;
> >> >  	struct vm_area_struct *vma;
> >> >  	int err =3D 0;
> >> >  	pgoff_t pgoff;
> >> > -	unsigned long vmstart;
> >> > -	unsigned long vmend;
> >> > -
> >> > -	vma =3D find_vma(mm, start);
> >> > -	VM_BUG_ON(!vma);
> >> > =20
> >> > -	prev =3D vma->vm_prev;
> >> > -	if (start > vma->vm_start)
> >> > -		prev =3D vma;
> >> > +	prev =3D mas_find_rev(&mas, 0);
> >> > +	if (prev && (start < prev->vm_end))
> >> > +		vma =3D prev;
> >> > +	else
> >> > +		vma =3D mas_next(&mas, end - 1);
> >> > =20
> >> > -	for (; vma && vma->vm_start < end; prev =3D vma, vma =3D next) {
> >> > -		next =3D vma->vm_next;
> >> > -		vmstart =3D max(start, vma->vm_start);
> >> > -		vmend   =3D min(end, vma->vm_end);
> >> > +	do {
> >> > +		unsigned long vmstart =3D max(start, vma->vm_start);
> >> > +		unsigned long vmend =3D min(end, vma->vm_end);
> >>=20
> >> What if vma is null? Shouldn't this rather be a "for (; vma; vma =3D
> >> mas_next(...)"
> >=20
> > We have already found the vma above.
>=20
> AFAICS if the range intersects no vmas, we might have found a 'prev', but
> 'vma' might be NULL after the "vma =3D mas_next(&mas, end - 1);"?

Yes, I agree.  I was going to restore VM_BUG_ON(!vma) after mas_next(),
but that's not the same as the existing code.  The VM_BUG_ON(!vma)
only catches if we search for 'start' above any VMA.  It seems
mbind_range() would have returned without error if there were no VMAs
within the range but would error if the 'start' was sufficiently large.

I think it is better to write it as you suggested to restore the
functionality of not failing on an empty list.  I don't see a decent
way of checking if we searched for an address above any VMA to restore
the VM_BUG_ON() which existed - although I see little value in it to
begin with.  I will mention this in the commit message.=
