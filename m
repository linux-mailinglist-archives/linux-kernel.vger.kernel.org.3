Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34B5649334A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 04:04:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351168AbiASDEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 22:04:06 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:39708 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345120AbiASDEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 22:04:04 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20INx76U002457;
        Wed, 19 Jan 2022 03:03:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=zT2pkC0s7H2M9ZDyGhjyyvKWyGqulEOylLn3w0uu9V0=;
 b=ZGrkorkTtwHhDzyi4FU3dqCOQQ2wUfNEvcEZQrsH1stwQ656gbrKh/LJeGniDJU9s8fX
 RNa5A8QblxtzfkvY0gNHj1G+NB2LxdKjkpaLrCu3/qaGdzZGtALpe6iLKopyM7v++HKw
 TysmgZonmPFfqPvQ8tVT0JiAUok6uEzzm2kJmeED35/u9FPIp8DBWOXtZ1F+8b4Yep5p
 CAECfGh0es93bk7UXQNhneIrwJMixQ1gCozt513ZqnkqK03KmbIsdFEOn0nQeWBjW0cV
 XAzYWxg9XjMWQ/scURgqh939NKbgJjBgNFFp5dMtcd6MmiXsl57rw74xeRKErgJqMXmb Gw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dnc5f3q70-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jan 2022 03:03:24 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20J30sxU137917;
        Wed, 19 Jan 2022 03:03:23 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by aserp3030.oracle.com with ESMTP id 3dkmacyb9r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jan 2022 03:03:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M2emfBDLG7g+R4ye8UjGysKNsYYrfWtwYtLiy/GEEeqWx7AwaQULgqRiUhd0wzn9wedlmTCpcyD/VnI2YMp+H24kcSNv08AY3qd68gkS8M13VDiHlQaUGfm4fAMxWu0Yy6SI3IdDgk/5ekd87XrmzA4LePO84Q3e81Nmw/8Gp73lDWxr2/7g5VMirBPanGUXHRXI3RPKXMHKLHvJYG18x3T54YqiZpqAT6FBOTcGwMAcwgY+cX4y+xiAWSXbt8lf/RTlTUmRvct/ZAaGF3xRRHTWDbhsRlIJaZFza2tGf0TKDnyk0/IBa876XDHa8UKg4QbPCluD/gdLhShEm6h1AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zT2pkC0s7H2M9ZDyGhjyyvKWyGqulEOylLn3w0uu9V0=;
 b=IcwoTKuESTzP8jAlKKgpHSg+K6Ukleo5VxKwidO91tT95dzQL6iTWyatiLY6AHpEAteZWrU1z/AtubDGSo71eypotM7sDiFuj66B0L3ZXfwWjJVzI9UgLLHhITIFMYoa3s70/5Vg7UvxUjPdi46G2Vux0RudBUcPr8/HWnxVW1Zf31Ms4Jkb/2xmP7a1m3spqhCBwPDRHPj/v/PErzKYuqSTm5WHXuPH16T9pMLtwM9S9voqU9KLILOupnD2WZjzCrsISTm1c7T7LfihAuBTAKSi4jSlx0dy9TsI17xAnfcBN/gMvm0RJ9EuOTpHm45YqRSttE4AxDbhiRygnPLVtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zT2pkC0s7H2M9ZDyGhjyyvKWyGqulEOylLn3w0uu9V0=;
 b=jwyp5Hl6+1avuTfg4h8Amp0Vf1QV3PRdQrCrJ7HHYxZrLEXeJrB2mq0oxTFqQ3+pnXMT2d+q7/Cz3WaYu9xxNejfNdb7EIipv+JKDi10xcvTLN3E01hEOnln7491IwS0EmNmUbOju6tAi5VGbxlYBNqn+npcrVbGmjV7CrHI8kE=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BY5PR10MB3748.namprd10.prod.outlook.com (2603:10b6:a03:1b6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Wed, 19 Jan
 2022 03:03:19 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3%5]) with mapi id 15.20.4888.014; Wed, 19 Jan 2022
 03:03:19 +0000
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
Thread-Index: AQHX5r/rzykS1Bt/D0K2KeUVeWbMGKxhLT8AgAjHcIA=
Date:   Wed, 19 Jan 2022 03:03:19 +0000
Message-ID: <20220119030311.qblhmf6yk6l7sl6b@revolver>
References: <20211201142918.921493-1-Liam.Howlett@oracle.com>
 <20211201142918.921493-22-Liam.Howlett@oracle.com>
 <90334a13-8a4a-d8bd-4971-e56b77ff9001@suse.cz>
In-Reply-To: <90334a13-8a4a-d8bd-4971-e56b77ff9001@suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 33e94f39-183b-4c4d-6ee5-08d9daf83f3e
x-ms-traffictypediagnostic: BY5PR10MB3748:EE_
x-microsoft-antispam-prvs: <BY5PR10MB3748C02D6A8CB59180D87A39FD599@BY5PR10MB3748.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ExEMvjhdQ2xUiSu5rEEtO6Wwc01j4N4XmPzqSlMg3hEiTDaKu6sCT+ACqibMW/TPYGIfBRVi7GlEwx8Z8f+X0fhZfDvdZFr5T2Z0MT5Ch4q5Ln/7OzJtj1lxC+0Jlhw8y3Y+VpnUpjccdzBdPiQ72+TMGIwuIm3SSE6fQRN2tZ+tYQBO8jUHwX4Z6fo0cHgNLNICEBnp78XSp+mgsDg5AZa9Xzp1KMGH8lriTml5O/C28XGanujkJDT9PzOJ2XPv+s2ATDmJ1wdhuAz3CcTviIwXQzSFYzaqkttFNxAuIZvp8N2mlCdQivmUDJn3n9hg83LP8HJJns3yiygWitXdeusCnWMjUIv3EV2iDOj6IlqxHQ58V1XfCa1+wEo3TuDzUSBc8om8qfRnzyGLap0Zc7zp7cg9zRqduRuTPAuyuqN9+afuAS3oy/Oqz9YdByf8CaxJbq7uW8XPa1nMnp5W1oNwUIRxiPKp0MGRAszJP4bUPlhDhdkF2sd8pYV6ju/8qGdwakm7m2bJRelZSlgy7BS4Z2VzqJqg+VESgTfmcJ0bims+c83h7qfjtYnlqgXGL8Gi5CzqaqaQZazSDd6/8eVvNs4ecDbPf73LHyUQC62jaibeMD/N+1nyh4xz5L3vzzPgDhubH5U9wWdu6NN8fIcQVWrjfWxcnmN5DFOjblTOMcBlRr5Bb68bfDLtUUzek/kuhiEuBmdjt1IsU/zH1w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(38070700005)(7416002)(86362001)(33716001)(83380400001)(122000001)(508600001)(6916009)(53546011)(6506007)(38100700002)(26005)(54906003)(5660300002)(91956017)(8936002)(76116006)(6486002)(8676002)(71200400001)(66946007)(66556008)(64756008)(66446008)(66476007)(4326008)(316002)(186003)(1076003)(6512007)(9686003)(44832011)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DnQSTZwykcruBEIP3AaS/oCQADNM9+UZDc82gF4bEN2dRw+sRVowxxUuATwx?=
 =?us-ascii?Q?gfl5/QIZXrp9SDa5C0i3rcd2puvBxEGGToyeVj0neuBOv5aLYUQywg5Mh/TB?=
 =?us-ascii?Q?eBTByIhrn9WgkRJoqzxRrYdp7cMJsV6v0XcdLrcmWuml/uSdPixYKnyvn+up?=
 =?us-ascii?Q?3pi3kKk6YX2jT72irBodIF+SV5u5eh+CiLJ+3I0SnbRIsVhB90pwBSSd1E6f?=
 =?us-ascii?Q?Lal12ASSBxC6x/ZWlICyZJ6uY+WhkXQm/FJebZvmy7NL6DNSRb7LSVwEA8n5?=
 =?us-ascii?Q?pmunM+CsL08olTnC+nOg3QmLtmxfE+INzuU5dXWUhLjFFrfVcO/5+TW8lp7h?=
 =?us-ascii?Q?uk59qJt3MOFHCQoKmKNWMgS668d8vMGPoHttCZ/xDSpjCcudXpD3A9sjK9/j?=
 =?us-ascii?Q?x8viWPn5ZOB+Br4qPV+iK6Pz6PU3SgHWmx82L9SoFW8nWbLfKksLgHiXjVBK?=
 =?us-ascii?Q?T2prRTGIXMLxWVUYjxCcmNCByN+Q6JRNgLrpo1diuNPCHIMxxDB5p8kHYf5C?=
 =?us-ascii?Q?j0PO3aV8YNk5Vc5VPltM3YnTDzGQiPS+maenEpd7ra0NsbAZAOqFwcBOEYmr?=
 =?us-ascii?Q?KnSWcybBX3DwoX7jXVVSQe0HY3Y3FVz5s6L9p3QkGBus/XdQyxVSMX6mfGQC?=
 =?us-ascii?Q?YDVSWdrGCHRtR0o2G3b8IhVH8IbqMMJN1SKmaxu+CodupKCQZiL2SzAmZPkw?=
 =?us-ascii?Q?XeESNJvhIzRT34lxV5igU08uwGCFeY0fJFt0s6/e+7ChZocMlD8oTmpTu3EW?=
 =?us-ascii?Q?v9OsLR+NSBb9FTglmxWvstd0Lm65GWPks3hS1xqTL7ZlR2LnpMORaUJMi6J/?=
 =?us-ascii?Q?vfiPcVqJUfuGU221ULLXU0JCwsTDy+GnNEVM9Klz/ZqAydeJw7VCgfNJAV6C?=
 =?us-ascii?Q?g2FU3hdkmGWbC9/hjLdYzPgGdRWARX5MlR2nnA+WELe5wdvWCjuIfjzIJfkj?=
 =?us-ascii?Q?MLcUl7E4hPex8yJN1OZy1AluXTennZeRmvWl2XZY8NYphSITwxu+b4skHW0G?=
 =?us-ascii?Q?2KGQuL4r5ZlOYuLiDsF7+qmJT/Qqv48dgGrmZ3Nm6RZfzaNq306VA5YCa/9C?=
 =?us-ascii?Q?Sx2sKl2+nn5lxQ4GOeF83P6U9M9+yWqFyCb/kwsBdK2SGCe2F6MOHPHHiTRI?=
 =?us-ascii?Q?6GEN8sJLSfpbrUO0xnGxWoAzaZBLyX3O6/Qc/iY7hb0SXPExxByOn9Hv2wyl?=
 =?us-ascii?Q?Y7ig5R+zx/rAQzo24jitO2jewUcWiezoB7IakqfxpEiRRL2m+LUAV1FCKAQG?=
 =?us-ascii?Q?F8bvbG0DgD65c2mGFad+O96Np9u7pNfcBNPkhr/F1lAi78UMqqkf86TztZ/x?=
 =?us-ascii?Q?P4Vk0vSB4k8rqj3MqoIB2PIsNdxGP+pwYCtGGI/d1pLKWdwMAzy4ZZzFQk3F?=
 =?us-ascii?Q?V/JLPANng6+3mTOWcfpnz81D9qpcQARFV9aL1LNJKQijJxDNw96luoSaJeBR?=
 =?us-ascii?Q?GAS3mdX/Icwv07cAWsjkH9VFp7FAlwMOvJfAxH7qUoh6WMBF5MK+3DRCwCSJ?=
 =?us-ascii?Q?b9l4ECdT76gOW/h1M4t8f2/XSsXTMCL2O8qZU+S7mcp+98u/JdKqtzJpNuRe?=
 =?us-ascii?Q?EO0swaN0y/9/8oRrpX76a59WveGBm4L7iAYnx8/J17uLDWmVGGGL4ggXN9my?=
 =?us-ascii?Q?7OYXPF0Vi7DKr8n8iJGnE7w=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C4CF602C78F7F740A3C380A972DAF9D1@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33e94f39-183b-4c4d-6ee5-08d9daf83f3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2022 03:03:19.6343
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wrfvZA4A9mzf7UTgrtVhB/Wjc8b/BwETv13QjD+qL4LT1SUmf9tRuq/ljGDlsicHUUq99xFD3r5dwPIYICoSNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3748
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10231 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 suspectscore=0
 phishscore=0 malwarescore=0 mlxlogscore=998 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201190012
X-Proofpoint-GUID: DwDECnj_IIZ29gib36ASKhlwYTLs-5LC
X-Proofpoint-ORIG-GUID: DwDECnj_IIZ29gib36ASKhlwYTLs-5LC
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Vlastimil Babka <vbabka@suse.cz> [220113 07:59]:
> On 12/1/21 15:29, Liam Howlett wrote:
> > From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> >=20
> > Avoid allocating a new VMA when it a vma modification can occur.  When =
a
> > brk() can expand or contract a VMA, then the single store operation wil=
l
> > only modify one index of the maple tree instead of causing a node to
> > split or coalesce.  This avoids unnecessary allocations/frees of maple
> > tree nodes and VMAs.
> >=20
> > Use the advanced API for the maple tree to avoid unnecessary walks of
> > the tree.
> >=20
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> > ---
> >  mm/mmap.c | 258 +++++++++++++++++++++++++++++++++++++++++++-----------
> >  1 file changed, 207 insertions(+), 51 deletions(-)
> >=20
> > +static int do_brk_flags(struct ma_state *mas, struct vm_area_struct *v=
ma,
> > +			unsigned long addr, unsigned long len,
> > +			unsigned long flags)
> >  {
> >  	struct mm_struct *mm =3D current->mm;
> > -	struct vm_area_struct *vma, *prev;
> > -	pgoff_t pgoff =3D addr >> PAGE_SHIFT;
> > +	struct vm_area_struct *prev =3D NULL;
> >  	int error;
> >  	unsigned long mapped_addr;
> >  	validate_mm_mt(mm);
> > @@ -2740,11 +2854,7 @@ static int do_brk_flags(unsigned long addr, unsi=
gned long len,
> >  	if (error)
> >  		return error;
> > =20
> > -	/* Clear old maps, set up prev and uf */
> > -	if (munmap_vma_range(mm, addr, len, &prev, uf))
> > -		return -ENOMEM;
> > -
> > -	/* Check against address space limits *after* clearing old maps... */
> > +	/* Check against address space limits by the changed size */
>=20
> Can that cause spurious ENOMEM because now the check assumes 'len' worth =
of
> purely new pages and no reuse?


I don't think so?  I must be missing how anything could exist in this
range to begin with?  The brk syscall checks to ensure there is enough
room and the other two users are the elf and a.out loaders - could
either of those two map over parts of themselves on load?  This seemed
to be there primarily to set up for an rb insert (set prev, rb_link,
rb_parent) in the current code.  Sort of like how get_unmapped_area()
with MAP_FIXED appears to be used to sanitize the addr and len.


>=20
> >  	if (!may_expand_vm(mm, flags, len >> PAGE_SHIFT))
> >  		return -ENOMEM;
> > =20
> > @@ -2754,28 +2864,57 @@ static int do_brk_flags(unsigned long addr, uns=
igned long len,
> >  	if (security_vm_enough_memory_mm(mm, len >> PAGE_SHIFT))
> >  		return -ENOMEM;
> > =20
> > -	/* Can we just expand an old private anonymous mapping? */
> > -	vma =3D vma_merge(mm, prev, addr, addr + len, flags,
> > -			NULL, NULL, pgoff, NULL, NULL_VM_UFFD_CTX);
> > -	if (vma)
> > -		goto out;
> > +	mas->last =3D addr + len - 1;
> > +	if (vma) {
> > +		/* Expand the existing vma if possible; almost never a singular
> > +		 * list, so this will almost always fail. */
> > =20
> > -	/*
> > -	 * create a vma struct for an anonymous mapping
> > -	 */
> > -	vma =3D vm_area_alloc(mm);
> > -	if (!vma) {
> > -		vm_unacct_memory(len >> PAGE_SHIFT);
> > -		return -ENOMEM;
> > +		if ((!vma->anon_vma ||
> > +		     list_is_singular(&vma->anon_vma_chain)) &&
>=20
> Hmm I feel uneasy about this part that mimics what vma_merge() does. Look=
s
> like something e.g. we can easily forget to adjust when changing vma_merg=
e()
> itself.

vma_merge() is overly heavy for what brk() is doing.  I get what you are
saying about it potentially being missed and I think brk is already in
the 'potentially overlooked' category as it stands today.  Honestly, one
less user of vma_merge() (and thus less __vma_adjust() users) seems like
a win to me.

> Is this optimization worth the trouble given the comment above "so this w=
ill
> almost always fail"?

vma_merge() walks the tree for next and next->next and does a lot of
extra checks before arriving at the conclusion that this will fail.
Maybe 'almost always fail' is too strong wording; on boot of my VM, 63
expands happen out of 517, so 87.8% fail this test.

>=20
> > +		     ((vma->vm_flags & ~VM_SOFTDIRTY) =3D=3D flags)){
> > +			mas->index =3D vma->vm_start;
> > +
> > +			vma_adjust_trans_huge(vma, addr, addr + len, 0);
> > +			if (vma->anon_vma) {
> > +				anon_vma_lock_write(vma->anon_vma);
> > +				anon_vma_interval_tree_pre_update_vma(vma);
> > +			}
> > +			vma->vm_end =3D addr + len;
> > +			vma->vm_flags |=3D VM_SOFTDIRTY;
> > +			if (mas_store_gfp(mas, vma, GFP_KERNEL))
> > +				goto mas_mod_fail;
> > +
> > +			if (vma->anon_vma) {
> > +				anon_vma_interval_tree_post_update_vma(vma);
> > +				anon_vma_unlock_write(vma->anon_vma);
> > +			}
> > +			khugepaged_enter_vma_merge(vma, flags);
> > +			goto out;
> > +		}
> > +		prev =3D vma;
> >  	}
> > +	mas->index =3D addr;
> > +	mas_walk(mas);
> > +
> > +	/* create a vma struct for an anonymous mapping */
> > +	vma =3D vm_area_alloc(mm);
> > +	if (!vma)
> > +		goto vma_alloc_fail;
> > =20
> >  	vma_set_anonymous(vma);
> >  	vma->vm_start =3D addr;
> >  	vma->vm_end =3D addr + len;
> > -	vma->vm_pgoff =3D pgoff;
> > +	vma->vm_pgoff =3D addr >> PAGE_SHIFT;
> >  	vma->vm_flags =3D flags;
> >  	vma->vm_page_prot =3D vm_get_page_prot(flags);
> > -	vma_link(mm, vma, prev);
> > +	if (vma_mas_store(vma, mas))
> > +		goto mas_store_fail;
> > +
> > +	if (!prev)
> > +		prev =3D mas_prev(mas, 0);
> > +
> > +	__vma_link_list(mm, vma, prev);
> > +	mm->map_count++;
> >  out:
> >  	perf_event_mmap(vma);
> >  	mm->total_vm +=3D len >> PAGE_SHIFT;
> > @@ -2785,15 +2924,31 @@ static int do_brk_flags(unsigned long addr, uns=
igned long len,
> >  	vma->vm_flags |=3D VM_SOFTDIRTY;
> >  	validate_mm_mt(mm);
> >  	return 0;
> > +
> > +mas_store_fail:
> > +	vm_area_free(vma);
> > +vma_alloc_fail:
> > +	vm_unacct_memory(len >> PAGE_SHIFT);
> > +	return -ENOMEM;
> > +
> > +mas_mod_fail:
> > +	vma->vm_end =3D addr;
> > +	if (vma->anon_vma) {
> > +		anon_vma_interval_tree_post_update_vma(vma);
> > +		anon_vma_unlock_write(vma->anon_vma);
> > +	}
> > +	return -ENOMEM;
> > +
> >  }
> > =20
> >  int vm_brk_flags(unsigned long addr, unsigned long request, unsigned l=
ong flags)
> >  {
> >  	struct mm_struct *mm =3D current->mm;
> > +	struct vm_area_struct *vma =3D NULL;
> >  	unsigned long len;
> >  	int ret;
> >  	bool populate;
> > -	LIST_HEAD(uf);
> > +	MA_STATE(mas, &mm->mm_mt, addr, addr);
> > =20
> >  	len =3D PAGE_ALIGN(request);
> >  	if (len < request)
> > @@ -2804,10 +2959,11 @@ int vm_brk_flags(unsigned long addr, unsigned l=
ong request, unsigned long flags)
> >  	if (mmap_write_lock_killable(mm))
> >  		return -EINTR;
> > =20
> > -	ret =3D do_brk_flags(addr, len, flags, &uf);
> > +	// This vma left intentionally blank.
>=20
> This comment using unintentionally bad syntax (// vs /* */)

Ha!  Thanks!

>=20
> Also if we leave it blank it means this path won't ever expand an existin=
g
> vma, while previously it could succeed the vma_merge, no? Or all callers =
of
> vm_brk_flags() in a scenario where there's no expand anyway? Maybe just h=
ave
> a more verbose comment...

Is it possible that other code paths lead to a vma merge?  From what I
can tell the other entry points are for the BSS or after loading a
binary anyways.  I guess the next vma could be anon and have matching
flags, but I think they will all have a vma->vm_file.  In fact, if I
change the do_brk_flags() to check !vma->vm_file and pass through the
vma in the case of vma->vm_end =3D=3D addr, then it works - but there are n=
o
merging from this code path that I can see on boot.  If you think this
is necessary, I can add it in, but I don't think it's needed.


>=20
> > +	mas_walk(&mas);
> > +	ret =3D do_brk_flags(&mas, vma, addr, len, flags);
> >  	populate =3D ((mm->def_flags & VM_LOCKED) !=3D 0);
> >  	mmap_write_unlock(mm);
> > -	userfaultfd_unmap_complete(mm, &uf);
>=20
> Looks like this part is removed completely from vm_brk_flags() paths?
>=20

When I removed the call to munmap_vma_range(), I dropped the userfaultfd
here as there was no need.


> OK it seems the whole patch makes some asumption that vm_brk_flags() neve=
r
> has to unmap a pre-existing area, and in the brk() syscall this is now
> delegated to do_brk_munmap(), and do_brk_flags() loses the support. While=
 it
> might be safe, it should be discussed in the patch that vm_brk_flags()
> didn't actually need to support the unmap part, because x y z. And best i=
f
> there are some DEBUG_VM based assertions supporting that.

Yes,  I do believe this to be true.  I don't think do_brk_flags() needs
to unmap.  If you look at brk() syscall, it actually ensure there is
enough room for the expansion + vm_start_gap(next), so that one is
probably safe.  brk() already depends on do_brk_munmap() doing the
unmap.  The other callers are the elf and a.out loaders, which also
don't appear to use the functionality.  I thought the call was only for
setting up for insertion into the rbtree.

>=20
> But then again, is the optimized scenario happening often enough to warra=
nt it?

well, 12.2% use the optimization to the fullest, the rest fail faster.
I am really after the faster failure optimization here.  I especially do
not like the fact that vma_merge() gets the next vma and the next->next
vma prior to seeing if it can be merged.  I get why, but is there really
going to be an anon vma with the right flags, no file, etc, etc, etc
often enough to try this?  In fact, it's not possible at all to need
next->next when we unmap the area first.  Out of the 8 cases in
vma_merge, only 1, 2, and 3 are possible.  Of the 3 possibilities, I am
suggesting that 2 is really the only one we should check as 1 and 3 are
so unlikely.


>=20
> >  	if (populate && !ret)
> >  		mm_populate(addr, len);
> >  	return ret;
> =
