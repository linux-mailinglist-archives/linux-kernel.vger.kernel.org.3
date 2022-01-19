Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65207493EA7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 17:56:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356243AbiASQ4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 11:56:48 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:14926 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243606AbiASQ4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 11:56:40 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20JGiP7G031241;
        Wed, 19 Jan 2022 16:56:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=WvawcolBf7ADS66S1CjhRkmj8xqKWS55mc6vcK7F92U=;
 b=WxVsihv6xZyxN4nHR/McGOEK33N/bJoVna+xI9vP33KsWAyoSGRxTzY03Q/Z0GNgcKnR
 EgO8VqQL+BFCDaVS6VmAhTXnaqSusguRnJCHJVCyzDE6X5sxVdUMjQ6HXD54T4+paE7I
 EKsI19956/9Jvg/wmUQX5lKOUnr589nw7KLJcTZdZq0144UFdlT9nokGZjWmtRUxkcey
 h/Q/ZArEOROoXkDo+5I2STXItBwXdW6tyGa9WGyM+aeAGTnp8anMayLzvfilW7vJXnqK
 0PfguLxUi7ns02o9XECLherou3KGLklDptiKsPBLJIxcLsyD3XMRpC0apDqgPjK7JLVl og== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dnbrnwm6u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jan 2022 16:56:11 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20JGodHh030829;
        Wed, 19 Jan 2022 16:56:10 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by userp3030.oracle.com with ESMTP id 3dkkd0pym6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jan 2022 16:56:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gh0cLAt+IL5S/jIyxC0Z9CTVfM7aGgAgZrTiRMU/PBlpHWLEdIgVs26i2yEck3jiJNWQ12FzKIxpVLDGhEiGPDdroFN4DY95gDjrttGXMMXG8XrZ1Dk9wKdNFuaAvKOuLhVUMhuX9+CsZ4G//oVGYEUPFPOdSaZi6lwmzWSTbesxi/j2O2WUb+g7lgMwRSPiS+r70dvn3zthJB0kbzd+lAUMykA8AuSGyvdwLw7PZxZLnK9U1Ux1sajuenH4NEB3fZZ+V/Vwddcd6IWRBnVO0yNRElGLzb16nRVMD0rp2U+IrMIt+mkLeQLVn32u1pgIcj6tu0suN+FNf5RSAb+GZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WvawcolBf7ADS66S1CjhRkmj8xqKWS55mc6vcK7F92U=;
 b=nI1vhE8y80/3Iwq5r2Z+Z2XS/Jzrs0IkKeoN3vcaEHxV4+TfKnRf2SbDt4YvoweG9fr7OhZi9knW8cphxvuNn0KnATvFXV/IHz307w1CON08D7KHCMWprI43PR8mG1RbjPZwYEeLPOPtIIFdT9sYKaAKMl2Eui9g3qF90ejIE1M91yFlnF6v7iC5h9uBv6tfIs1N/agNUvPb6ajRW3Dbu7qtrN34pH3iuZanNeymmALTk6eyHLp0QeAHob9XMj4pquO5xfn87iZQg7xuoa9pv8+KNNbie2lgEJ8KYx9YJaSHs0NbIiErg3yQl8Fv4/foMi5lHTYuVcCAmNHsvDXB0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WvawcolBf7ADS66S1CjhRkmj8xqKWS55mc6vcK7F92U=;
 b=UU3rS15wJs5iYZ3TBAa+DNU56NjlozRGG4W0RNdzy+e7mnzPbxrWvjooPMQuvOdiD2syYm5a9RzKfNpz2hLRGOXcSnP4paovpADObamdhfZdDjbr0o38D9/03JFV58LGN+3eZi0Mlc7F8ejk92Kkp89iOKUBFtTrXG9lp802ca4=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM5PR10MB1563.namprd10.prod.outlook.com (2603:10b6:3:13::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Wed, 19 Jan
 2022 16:56:07 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3%5]) with mapi id 15.20.4909.008; Wed, 19 Jan 2022
 16:56:07 +0000
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
Subject: Re: [PATCH v4 22/66] mm: Use maple tree operations for
 find_vma_intersection() and find_vma()
Thread-Topic: [PATCH v4 22/66] mm: Use maple tree operations for
 find_vma_intersection() and find_vma()
Thread-Index: AQHX5r/rmzhEuZidmEqFF4ul+BVT5KxhXfkAgAl/YwA=
Date:   Wed, 19 Jan 2022 16:56:07 +0000
Message-ID: <20220119165558.xefdpv4trolc43ui@revolver>
References: <20211201142918.921493-1-Liam.Howlett@oracle.com>
 <20211201142918.921493-23-Liam.Howlett@oracle.com>
 <252fddef-209a-66b3-31f8-e58024c35b60@suse.cz>
In-Reply-To: <252fddef-209a-66b3-31f8-e58024c35b60@suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3d24224c-8be3-4420-2241-08d9db6c962e
x-ms-traffictypediagnostic: DM5PR10MB1563:EE_
x-microsoft-antispam-prvs: <DM5PR10MB1563E423447DEE8F753B70FFFD599@DM5PR10MB1563.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: G5dPbWCCpt6n0QfpIvx+TDqxe9G8dvhep8i77YqbsegiuIfbhz7dhUYOCkaknKvI44yViWkrb7+0rfzPaq1HW0WRon1z8vf/OmgjVaJrI8UdBEZQ1iiVOJFLW6N/51nyqEgmAmRdKWIkf5FItK1r4kK/zdPySQZxWFFC5/DSPuxmPxaKMBLVcmgVSis/Kv/u0ffAFtTnuuWjFsoIHYvJKnC/mw54XgCF+uRpZ/fIHWnH0KEY8ZjT7n5Dn+dZJZRVgjC4c8QqPa/eLXJxoQVFtjJPIxxZVbMFapK72x2Q+ybKGEkgd3LkkcLnKQaeqcZ2UsRduSvd2kVwEv74TxA2a8eLdHjl/KmYfz17L0sxa+Ry+dFVpPo4+aFzqK3RznO66vr+DwBD4i44wkt6UdWDThhA2mb5EtPZyUlf9IG8HfbxSqocYE34zOwxsCWAssr1DrbuuxmA6eHIpEiwUQK6QxgZAjBMhsTnzNkUoXLLkztxmsbZmilC98cycyc1TQ1ixxMcu6dZ94DkHvKX2OShvEr1dFDFayAFV0JTwcBlBzVecotNlTANgR6AP8SS33JxvKDavcgGioBpMkgup+8sVgNMKZzwoXIM9EZYKdgcDTvwVDOLtGy+TLWM7cZ+IUx5P6tj8qrNOP2v2L0GqGIV55OM00Gko+egqwzySGNM3L5SrclozJHwWfgrRf/m0VN7zLzkw1js2Mry35GeNN3Diw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(54906003)(9686003)(83380400001)(86362001)(53546011)(6916009)(6512007)(6506007)(8936002)(508600001)(38070700005)(8676002)(6486002)(66946007)(1076003)(5660300002)(66476007)(91956017)(7416002)(76116006)(2906002)(66446008)(66556008)(71200400001)(64756008)(26005)(33716001)(44832011)(186003)(316002)(122000001)(38100700002)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jvArm/FXg5Da/vQwHpVg6a+SsB06i9Jnm5Nf/I0zb5dmoJoaNtGZQeyzXkvn?=
 =?us-ascii?Q?40UAgEcqDiyJK3O66nyXZLJu0XYw4zo8UH3MZ5nL2nvYg2Q8j5OXESYZ6SQs?=
 =?us-ascii?Q?K5zH4yU+exjOCQtIpf3yjHDFav9ptWREtB72JJU5HIgBq+T7Fx3SiLuPjGdX?=
 =?us-ascii?Q?0sQJ0Lo0AcEVqH4kGVYSJNN2WyNwvtT01Rmb8Nuojv3NMSEYnWh1p4NFzpf4?=
 =?us-ascii?Q?wkALtKHBfXQsQVJPtU2rI9EhPnMYoi5+/g4hHh17SDdlY0RryLkWKnZAvAPg?=
 =?us-ascii?Q?AkElDv7omx6HBjvJ/U29z7VSYvecbHbMlN0gnOpH4ISm8QgYB8LrSnyzJNpX?=
 =?us-ascii?Q?3ZqhM6BQHesYzBzadC7/q9+OnJTHdadfsD8PvNS8QHLBg/lgRCpoVU+BIJIF?=
 =?us-ascii?Q?cw0svyx+8nEp9liUdK4Mhw0esG0bvJJLzxbWXv9p03cg/6L2ztU6AvVnGthz?=
 =?us-ascii?Q?iuXwgvYd37Q2+clVGPsiwFdHbh2PQg8n2TXDxhrCyREXmd56QgIuF2OA9lBZ?=
 =?us-ascii?Q?gAe4qgL8/7rEbqFajkQooiQxbZ5t/BTe0v5lCiEDjsDVZP9lQfsNn4GKPN5K?=
 =?us-ascii?Q?VWsNNUeXC4XKn+oFNODO6eirxInTXPK8obvd5CP067DqF86EcGARS+bsjow9?=
 =?us-ascii?Q?Am4gtOfnQk9+b+xJp660/H1WylLw2RBvqQjsoGzTvz2uY3dMsQMA74dKMsCN?=
 =?us-ascii?Q?ik9vmZ3fAd4qFjWzU8xnvTeHEB1EHuWq+C88LiwzNDJkvHutRoAoMj6qTt3I?=
 =?us-ascii?Q?3yySAojTnQMRRRezmqy6awcJp2DUiuCgXbTS9V8gJI0wh2gCp9QGjInEIUUU?=
 =?us-ascii?Q?Z5pshtB95LpxYTfqRrhkmaXRKJ3OH9R+HBhUV/3QhRbCghDq1MwFzWmv+f5h?=
 =?us-ascii?Q?ukt512BwHHyXyuWDBnkWvhMb8qWrIsGO3+D6HEXpsRFXK1QSOFOyYgnH2f8Z?=
 =?us-ascii?Q?USZeptbWkVbsfb6EdeKvV27TBHDsUSOaZqPFG1Vm3a3L0I49RfDu/I2dQr3Y?=
 =?us-ascii?Q?AMbteKlyzuiKfuMsZXSWbvVK7O3evF38l3ZbmPyT/xfV2l8sz9/eZNqY/XzV?=
 =?us-ascii?Q?og/muJp5OaK99z3hb+xNHaI4v/UawzUbToXiIxe7veGxiKC48XLXmaamPZEj?=
 =?us-ascii?Q?8aOshpbj/Tt0uA3wuUC8o2wUu8orG92iX7cFfXIgjtG0EkRZYfbyLFwN87y2?=
 =?us-ascii?Q?2gzvpOj4nqWIlNakai64aZL3yEaCTn+NFj1aW1H8RjFR4GVfGyjnTzWX6qUs?=
 =?us-ascii?Q?9Z6Hd8Bs0tLOAyT0ZIuyBtLaKBloRkblFN0uNluNtKgLsePARSTJKqXrPYvp?=
 =?us-ascii?Q?hlreWoV2lbegfgeUbOhEDvNkXHsubIRK5RmVgBd7L4prTkWBLf5WAKk1RGXu?=
 =?us-ascii?Q?PZ0BSPxfxFGPyigapHF9OVj+5hid04tB3gP5YWw/wr9hmEDqL5cOoAaYDrIr?=
 =?us-ascii?Q?1SkaF0fQXI43OtLQDqNoo8J7QqwYyEm3RvDCb72WstQF9ZK3QD1+mS8GA/YW?=
 =?us-ascii?Q?dV+8/eK7uffflCJ1JP5nHYaGH5YBxU1javYXYaK6+OmfBjVJpsM63fhCT/DA?=
 =?us-ascii?Q?Z0qwfpF2JSfQmhB2UjQoQuyNuWwfXdWCLPBvrEOi1qqASaGJMUkVGcAdbL+e?=
 =?us-ascii?Q?M7YWCYwOyvrVlL8EoLnbNw8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CE20C2F419E6A249B6B000EB6B1E1D8A@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d24224c-8be3-4420-2241-08d9db6c962e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2022 16:56:07.1723
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +P2yAOdpopZ/80G2ZWZrwdUgCAGF62KAP3jsoz+8Rr1rLVXZF+Srbm0lRENUbVk0lJD11Wm6UEi3BQW2LcVSUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1563
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10231 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 malwarescore=0 adultscore=0 phishscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201190095
X-Proofpoint-GUID: zuOD02GElSkNImLk3g4cOw7oc_rZMx55
X-Proofpoint-ORIG-GUID: zuOD02GElSkNImLk3g4cOw7oc_rZMx55
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Vlastimil Babka <vbabka@suse.cz> [220113 10:53]:
> On 12/1/21 15:29, Liam Howlett wrote:
> > From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> >=20
> > Move find_vma_intersection() to mmap.c and change implementation to
> > maple tree.
> >=20
> > When searching for a vma within a range, it is easier to use the maple
> > tree interface.  This means the find_vma() call changes to a special
> > case of the find_vma_intersection().
> >=20
> > Exported for kvm module.
> >=20
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> > ---
> >  include/linux/mm.h | 25 ++++++-------------------
> >  mm/mmap.c          | 38 ++++++++++++++++++++++++++++----------
> >  2 files changed, 34 insertions(+), 29 deletions(-)
> >=20
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index c08f6d541b8a..39a947f29f6d 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -2812,26 +2812,13 @@ extern struct vm_area_struct * find_vma(struct =
mm_struct * mm, unsigned long add
> >  extern struct vm_area_struct * find_vma_prev(struct mm_struct * mm, un=
signed long addr,
> >  					     struct vm_area_struct **pprev);
> > =20
> > -/**
> > - * find_vma_intersection() - Look up the first VMA which intersects th=
e interval
> > - * @mm: The process address space.
> > - * @start_addr: The inclusive start user address.
> > - * @end_addr: The exclusive end user address.
> > - *
> > - * Returns: The first VMA within the provided range, %NULL otherwise. =
 Assumes
> > - * start_addr < end_addr.
> > +/*
> > + * Look up the first VMA which intersects the interval [start_addr, en=
d_addr)
> > + * NULL if none.  Assume start_addr < end_addr.
> >   */
> > -static inline
> > -struct vm_area_struct *find_vma_intersection(struct mm_struct *mm,
> > -					     unsigned long start_addr,
> > -					     unsigned long end_addr)
> > -{
> > -	struct vm_area_struct *vma =3D find_vma(mm, start_addr);
> > -
> > -	if (vma && end_addr <=3D vma->vm_start)
> > -		vma =3D NULL;
> > -	return vma;
> > -}
> > +extern struct vm_area_struct *find_vma_intersection(struct mm_struct *=
mm,
> > +						    unsigned long start_addr,
> > +						    unsigned long end_addr);
> > =20
> >  /**
> >   * vma_lookup() - Find a VMA at a specific address
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index e4c8ce377f2c..c06c5b850e1e 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -2003,29 +2003,47 @@ get_unmapped_area(struct file *file, unsigned l=
ong addr, unsigned long len,
> >  EXPORT_SYMBOL(get_unmapped_area);
> > =20
> >  /**
> > - * find_vma() - Find the VMA for a given address, or the next vma.
> > - * @mm: The mm_struct to check
> > - * @addr: The address
> > + * find_vma_intersection() - Look up the first VMA which intersects th=
e interval
> > + * @mm: The process address space.
> > + * @start_addr: The inclusive start user address.
> > + * @end_addr: The exclusive end user address.
> >   *
> > - * Returns: The VMA associated with addr, or the next vma.
> > - * May return %NULL in the case of no vma at addr or above.
> > + * Returns: The first VMA within the provided range, %NULL otherwise. =
 Assumes
> > + * start_addr < end_addr.
> >   */
> > -struct vm_area_struct *find_vma(struct mm_struct *mm, unsigned long ad=
dr)
> > +struct vm_area_struct *find_vma_intersection(struct mm_struct *mm,
> > +					     unsigned long start_addr,
> > +					     unsigned long end_addr)
> >  {
> >  	struct vm_area_struct *vma;
> > -	MA_STATE(mas, &mm->mm_mt, addr, addr);
> > +	MA_STATE(mas, &mm->mm_mt, start_addr, start_addr);
> > =20
> >  	mmap_assert_locked(mm);
> >  	/* Check the cache first. */
> > -	vma =3D vmacache_find(mm, addr);
> > +	vma =3D vmacache_find(mm, start_addr);
> >  	if (likely(vma))
> >  		return vma;
> > =20
> > -	vma =3D mas_find(&mas, -1);
> > +	vma =3D mas_find(&mas, end_addr - 1);
> >  	if (vma)
> > -		vmacache_update(addr, vma);
> > +		vmacache_update(mas.index, vma);
> >  	return vma;
> >  }
> > +EXPORT_SYMBOL(find_vma_intersection);
> > +
> > +/**
> > + * find_vma() - Find the VMA for a given address, or the next vma.
> > + * @mm:  The mm_struct to check
> > + * @addr: The address
> > + *
> > + * Returns: The VMA associated with addr, or the next vma.
> > + * May return NULL in the case of no vma at addr or above.
> > + */
> > +inline struct vm_area_struct *find_vma(struct mm_struct *mm, unsigned =
long addr)
>=20
> I think the inline does nothing here (except maybe for LTO builds). Calle=
rs
> will do a function call to find_vma() and then probably that causes anoth=
er
> function call (likely a tail call) to find_vma_intersection().
> You'd have to put this definition of find_vma() to include/linux/mm.h to
> make the callers inline it and just add the 0 parameter before doing a
> function call of find_vma_intersection() - which would make sense.

Thanks, good to know.  Upon re-examining this change, the find_vma() and
find_vma_intersection() function is later reduced to a few lines of
code.  I will change this change to reduce churn.

>=20
> > +{
> > +	// Note find_vma_intersection will decrease 0 to underflow to ULONG_M=
AX
>=20
> Nit: this comment syntax using //.

Thanks, I have checked the entire series and fixed all the ones I added
(and most were later removed).

>=20
> > +	return find_vma_intersection(mm, addr, 0);
> > +}
> >  EXPORT_SYMBOL(find_vma);
> > =20
> >  /**
>=20
> =
