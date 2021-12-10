Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15CF946F8EA
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 03:03:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235730AbhLJCHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 21:07:04 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:10952 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231148AbhLJCHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 21:07:03 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BA0cXdH025244;
        Fri, 10 Dec 2021 02:03:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=JlDNebAobFNpvSvaZjtcjZFMIej8XN72ko8LhI9HEyE=;
 b=T8xUYT97USOf/0Dw8FWNewC7Ojk5237rI1G6mpIkQLzg+jgtsWm2flMGbnNtR82DkwgR
 KSRlFEamDbTGyyiZvgrdUkVygT2d7ex5hJzrm/d+9FU0eoEhkgsta159QhBIjMqXGR8B
 6XC09Elq0vnA1VLx2wZMLDNrmABeAMllcOs5qN1QhEDC2/twv7HBbQGS4xOqumF+W6bH
 CKnVuMjyeuqzEchYRReWopVcKhQfwTSP53om/QGIT3rYSPWy7PBjFaDY6gVcbKNSsuyt
 pFCrF92N6NN56HKDXKOOvnhShfyt4B7rZD10SqxhyOzS6SOLcU9pdke7d7RsQNrQz3Ho 1w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ctua7mkhq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Dec 2021 02:03:02 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BA1toDB056328;
        Fri, 10 Dec 2021 02:03:01 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by aserp3030.oracle.com with ESMTP id 3csc4x357j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Dec 2021 02:03:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a4w18kdRUIt99oMKCSuan7xwnqoSaMHxO10ZEr4z9dQUUXtZmhyfpMYMFnmsu8xk/vpZzL/dGip3uqRubw+U9lrQ6cwjhUjTYXgQVTsiQJjDBRZD55xl2BI4CRG8ru0wg0IqqthMFezMmC7gA1JnwozxENN1iV2WA3NNhbcdQgyMH6Ja5B3ZkN7hEHgs+dV4i+wysODT6CnrnV4L82rC465pwgJgwnxs7L+18jhkkkNqnzHWtLaxPSi2jlZUGVjDNt3/AcIJjkZo+JuJjDSZ2j94U80T9O3cer5mHyYLrr6JTcYmRRAMejImuvzKERsUAw7i4XSKKIbuVXMYF+ToeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JlDNebAobFNpvSvaZjtcjZFMIej8XN72ko8LhI9HEyE=;
 b=FKrZOXYJpkR6XFJ9OMi+naJ3EpIkDz7E8xFLcGagmDeXuxTtpzreC12EEQ92g0YKm3ozodKEKEas8eZblcwkX+K+TGoYVCfYuNWFAQWOCQti0e5s7s/e1t5sHJfJm3diVJva59SdHDMPkHCN2VWhuPx4tzjkJDgvZ71wu8Cuy5zdGx2baSaI2TQFqfgwlLlHAybs8D5BPRcS6HFT7AZyRw6HFV8dtPU9WGmq30C3AFIXQ/uMee6QsmjW2878mkSVY7vhOORmzBnS2dcap1a6Tswitni5Plu47l9boCjMBDkmGl6r8p5lavDtskvdbhAXPDCDs42Lz3fFkmqBl0CNqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JlDNebAobFNpvSvaZjtcjZFMIej8XN72ko8LhI9HEyE=;
 b=D2IqMlbEB8JQaQctMc+WFUoKjJp5nEvI2DqM5tk+TvXQ1ouEQGBJelLvEg8lvtHPIh76k4cKMIND4JuSzNWta3nFFpqZvQSOqLx8zBgDiD7pKvH7DRhaOCNxW7N0CXGxHNuvDUb3v1Hd1NJNMNyOWcXxLDikn/mBxmbCDXTrpsw=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SA2PR10MB4795.namprd10.prod.outlook.com (2603:10b6:806:11d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12; Fri, 10 Dec
 2021 02:02:59 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3%4]) with mapi id 15.20.4755.025; Fri, 10 Dec 2021
 02:02:59 +0000
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
Subject: Re: [PATCH v4 07/66] mm: Add VMA iterator
Thread-Topic: [PATCH v4 07/66] mm: Add VMA iterator
Thread-Index: AQHX5r/m765iFHbPa0ejviOTbVUOwKwqVMuAgACxxYA=
Date:   Fri, 10 Dec 2021 02:02:58 +0000
Message-ID: <20211210020243.jciodseey2ckf2sk@revolver>
References: <20211201142918.921493-1-Liam.Howlett@oracle.com>
 <20211201142918.921493-8-Liam.Howlett@oracle.com>
 <f68de664-434b-d8f4-44a2-cbb0090abb87@suse.cz>
In-Reply-To: <f68de664-434b-d8f4-44a2-cbb0090abb87@suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2b0ba544-962b-40a8-dd89-08d9bb8130a9
x-ms-traffictypediagnostic: SA2PR10MB4795:EE_
x-microsoft-antispam-prvs: <SA2PR10MB4795831FE0592A248D890C54FD719@SA2PR10MB4795.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g/uR/eQRugoYSFmDz3YAvhF1uQ4jqLQ6NJ11JTg/XmZuLzi3l73O0AUb7qTFMDxe9xPvRr7JuqXpHQhlckdZUsoya66mxaJPR71TDW4QmUFkQVhGeaofqgZ940py7wacMdzY2Iu/EzxFlqwAUhs0CH7fFFSxw/IAtFP3VPTD7P7fUdrm2WFCTRX5nVEoUz06ugatAAgDlsuvOANjrliSiRVlfaE+lSyuhEMdqbcqtyJBMAJBm5ZNAx6OFo4qgj2GStNkZxLYOQQ+CxMh2cU67iPw3DyWHgtNMLCpT9bnWmWtJ27XdfQd5D39cvKEU99939Plwww4ZskNJcMqJrxVrGWv5BATZfPUnCAK8ccY2qvasLYPc3b6O0iTVfBOm0egApACCEt0AOQGVSU3Cd+NNiAobe5ymBbvblD/ReErnqLGD2bF5jpsHlGUrbjWBVqFS+BUAkgT8zzaPJN2vh5lsdkswrUCGVrBy76SQUF6t2EKNOrrnT5AILJTh+H+YSku/iDEUAgdxJtz/uqaoYlmRFxEKrcxEgFsXv56RF9rxgulJZGjV/BClTWHK/gmyzUcGV36hvG9GYuuAYMUj1d6mDPuat4sJnMaCkKj9vaPrvC+jgYVul8R6Vm4sA/X+NoswP37LgbxFBptDI6fSOiYdpJxLvo8fa1bFhay/JMwsTJrYtwJ9r8gpbG9bXzC6TPCWvdTF+PXX92d/HbkZmS7fg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(66946007)(91956017)(76116006)(38100700002)(6916009)(122000001)(6506007)(9686003)(2906002)(6512007)(66556008)(1076003)(64756008)(6486002)(66476007)(66446008)(7416002)(5660300002)(44832011)(53546011)(8676002)(8936002)(508600001)(71200400001)(54906003)(38070700005)(33716001)(83380400001)(316002)(4326008)(86362001)(26005)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?unFYRdSCK2va7UTe9klkKhgjYRTktRyGfAu5F7GGOXXavL9ESzzfteWXQX9B?=
 =?us-ascii?Q?Mllo7brFNhLEhqOHwcEeDxfU3hip9Qx/s2RBP3g32d2GAd2hiNwYsQoZqA3g?=
 =?us-ascii?Q?iHcqy3B4FlcvZcn7UMNpQ0AZVDTS3Xgc4k6ELPEXdNJG3iBrHI6QcKaJoYfb?=
 =?us-ascii?Q?ubmhnro2umu+6sJ7Tinip/2zFa8OAwvPfQDm3NuXRYYKbL5JP1joYj1VeYT9?=
 =?us-ascii?Q?zlY1iGl3f8mucGYN3sxc5SD1JcsLaF4v/SHkcJc8QNLkUUtgB6yj+JeERq5d?=
 =?us-ascii?Q?ciW2chSYsbcDkx/cDKtpo7SRB/vvHCquz67GrJWh3FIQ9kJWssVq6FqJW1jL?=
 =?us-ascii?Q?msupKii9UJ5YGFv0thkvVOsjTntDksDY+k5Jp7zZ0YkJkT0cFTEv/4CEOyCe?=
 =?us-ascii?Q?bijPZRhkWNmY5OV4UYkmaEZbvnLltsptRF2XJbtlRenV+EgA9i/oOo5luwOM?=
 =?us-ascii?Q?A4/A7HpXEN5LgodyxAgQZNa6aOeM8DWVjpkOSJ/lQTGKFbeCNW4rCOtr6hIb?=
 =?us-ascii?Q?WaFiivCj9ga9Xf9P7xvwfeok7hOVNS36jjmTTnhgUjK8E0nVyWuRomrtaLfC?=
 =?us-ascii?Q?pmZp2BJihsVSUsXt+Qbw1Y3yPVkJCzGsUMaIC+brku0O0ak3F9LMOCjk7tvP?=
 =?us-ascii?Q?CS1dqqi85faCKF7+F7zGK/Y1wNASwM6V4ybahXQrOcFYBhEZya5P2LgAR4Eq?=
 =?us-ascii?Q?BT1NzusNPUlm80bNzsL3R/mlA0uHnaH6ax9LfpbDZ4Q7Gq7dkzKEXVsEcBK+?=
 =?us-ascii?Q?Ct8lWDlBJhZtK4lp+lAwiALuvejcN7WBnrRirIGImEn9/sm4HXyA/ewVTDu0?=
 =?us-ascii?Q?ojExD4gmJm537IBNoXSu3RbXhaurTVQvPMCZmN3KPLYJ2LWAwRqYAteAd2OQ?=
 =?us-ascii?Q?4WAv01YCR02gn0xOlRYJDye37kg7CSfzRqTu4Kzm2QUd4eeBy14PhGokBG42?=
 =?us-ascii?Q?h/0wYup1whNGoAs5LLUkBrWv5CM2cSMuTK0256ViGDRE9pWKq1jVWj3mlhMx?=
 =?us-ascii?Q?dtwUTurp3Cqhs9M84+u31wgi3WHpRDLGNhTPJcvWW9Z1GL/4SEKsx/Hgrvxc?=
 =?us-ascii?Q?2xult/bjohYV7LLOM4V68aL4VWU5QkC/pmN9mbU2458e0mMyf75rUYbZGDsl?=
 =?us-ascii?Q?G98RsMv71iRlYWgQnHDvHSCmIijjUZdWwfUCdJXJSk952qks7a4GiHPWLFj5?=
 =?us-ascii?Q?Otnt7c+v7E97iok7aCWqwYKIkgEjnVu0c6f+cM4PyOSux2X21Awhy+ed4pbr?=
 =?us-ascii?Q?4nyZlaiWMnrNqkZWW9/DirtSBh4SohtOJZ/oU5yrqIiu9H+M4fJufKLEF3D7?=
 =?us-ascii?Q?3+8y2OoYHljgmXKb9/6/RIDTyuQr3HUiZf1xj1hS89NpNl7CL6Ds5fuS1/LB?=
 =?us-ascii?Q?Ji2eYD49ZmWNTP7ieApBcVh3BX1C755Vhy0/xnWb0kKSJIRgw0k/c+r5Y2F9?=
 =?us-ascii?Q?lcdiTV/eK9DioL43ubo3qInjKsLxqk23ZaJsa3OJ9c9ePQh46jeDkIh58Fw3?=
 =?us-ascii?Q?0BEVN8kh5t/sk7uE67U0Z7fYTVCFGYRgpp7Ku1v/kNBtluv6CYSdGwX1mIzX?=
 =?us-ascii?Q?jyrOb7bEPDzMCCokBgZBFIW9bNDLdyITfad9w3RavesYo5fk8bV2EOoBHBnq?=
 =?us-ascii?Q?i8yOu+Bwi/Y9CUvCjR6pNqY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4B0664CF4F12F5479B1558A5774B9481@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b0ba544-962b-40a8-dd89-08d9bb8130a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2021 02:02:58.8749
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CO+S0iIRXZxY1a6+p5nus3AvBYfco3Idf0mPTvlnIONbTdhjTZXj17INacuyeJjb6EFUi/uPAmwK4KzoebznoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4795
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10193 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112100007
X-Proofpoint-ORIG-GUID: KOaPvIDEfUc07DwD3suSgvKBr0gSTTyC
X-Proofpoint-GUID: KOaPvIDEfUc07DwD3suSgvKBr0gSTTyC
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Vlastimil Babka <vbabka@suse.cz> [211209 10:26]:
> On 12/1/21 15:29, Liam Howlett wrote:
> > From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> >=20
> > This thin layer of abstraction over the maple tree state is for
> > iterating over VMAs.  You can go forwards, go backwards or ask where
> > the iterator is.  Rename the existing vma_next() to __vma_next() --
> > it will be removed by the end of this series.
> >=20
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
>=20
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
>=20
> With a question below.
>=20
> > ---
> >  include/linux/mm.h       | 27 +++++++++++++++++++++++++++
> >  include/linux/mm_types.h | 21 +++++++++++++++++++++
> >  mm/mmap.c                | 10 +++++-----
> >  3 files changed, 53 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index 9eae78a155be..acdccbe9b96b 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -696,6 +696,33 @@ static inline bool vma_is_accessible(struct vm_are=
a_struct *vma)
> >  	return vma->vm_flags & VM_ACCESS_FLAGS;
> >  }
> > =20
> > +static inline
> > +struct vm_area_struct *vma_find(struct vma_iterator *vmi, unsigned lon=
g max)
> > +{
> > +	return mas_find(&vmi->mas, max);
> > +}
> > +
> > +static inline struct vm_area_struct *vma_next(struct vma_iterator *vmi=
)
> > +{
> > +	return vma_find(vmi, ULONG_MAX);
>=20
> Why not mas_next()?

vma_find() uses mas_find() which was created to implement find_vma().
As a replacement, the search looks for an entry at the address and if
nothing exists, it will continue the search upwards.  The result is that
the first entry can be found at the address passed.  Every subsequent
call to vma_find() would search from the end of the previous range - as
saved in the maple state, or the vma iterator in this case.

mas_next(), however is more of a traditional linked list operation that
finds the next entry _after_ the one containing the index in the maple
state.  The only difference is on the start when the maple state is not
currently pointing at an entry at all (the node is set to MAS_START).

mas_find() can be thought of as:

entry =3D mas_walk();
if (!entry)
	entry =3D mas_next_entry();

return entry;


mas_next can be though to as:

if (mas_is_start())
	mas_walk();

return mas_next_entry();


Matthew uses mas_find() for his implementation of the vma iterator so
that the first entry is not skipped.


>=20
> > +}
> > +
> > +static inline struct vm_area_struct *vma_prev(struct vma_iterator *vmi=
)
> > +{
> > +	return mas_prev(&vmi->mas, 0);
> > +}
> > +
> > +static inline unsigned long vma_iter_addr(struct vma_iterator *vmi)
> > +{
> > +	return vmi->mas.index;
> > +}
> > +
> > +#define for_each_vma(vmi, vma)		while ((vma =3D vma_next(&vmi)) !=3D N=
ULL)
> > +=
