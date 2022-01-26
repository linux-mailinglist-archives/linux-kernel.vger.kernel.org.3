Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6830549D36B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 21:30:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbiAZUaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 15:30:04 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:1468 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229907AbiAZUaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 15:30:03 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20QKQJiY026180;
        Wed, 26 Jan 2022 20:29:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=k1jVj5aypZvAtQ2fLKC+dD8lHE4keg5995ELcuMCN2I=;
 b=hGUQEDaZZQrcirbLi/lmDhMZQUR93XWi738yxLBnDj5NMkdRtbB6N+PniLJk3cckD7xg
 ZFh5wCB2OGi3EmsB8M1nbopEE5IoUKaqlIv8ipclS+hXld9BgZXdl/om3N3FrvLN2Bis
 jH4sXRWxmTp9JGMgnB0Fll34lvoCpfOarHr7mz+B7LMWEj/08DA/AXnUz9CWrk4Th010
 qooxAwpU/PAtFDyQuYLHBFqblmDxOgFW90C4Kl89iTHyDcM+tWzCFQbPmeH79i63UCkC
 HlqoBaftJOD4lkrI/MJtsG3xTJZgCzzZN4zRCOkQGJ0LHBuF3yJOmNqNyeeMP2YR1vwa Lw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dsvmjfs3n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jan 2022 20:29:16 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20QKF2Xq044732;
        Wed, 26 Jan 2022 20:29:15 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by userp3030.oracle.com with ESMTP id 3dr721xeky-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jan 2022 20:29:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f1jL5hvwGxlVIIkMfFhGxAj/2aFCwIbuPcjqSA+b+uf7GYnPDAJgkMMVnrUYr0HneB1UtAq8v9mUKnERgIISM0R3A1OWtEyyaxU05RxCJXGi+ZvsHK7BxdxPeU1V4GeyhdJHqJFRNdTuLt51nUYaoyCioVThPLJB9Llk1ZsRzSG9p2BQogeIizQVrja3gHij/gi2vfodWFxqb6qXppyZY8mKV9aGIGGHB2FvUdHcftgcg4w4Ld3WyaeTG9vilfQJV3LEqC04WvwVOl1FPohSUmOnyIWxmB22nthbPwPnGSLOBXuAJjvoxcLAMWGJuefo+O48gSbZjCvfrHnk7mZDJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k1jVj5aypZvAtQ2fLKC+dD8lHE4keg5995ELcuMCN2I=;
 b=KE831HZBn/XzObisB8xrZXhP/4fXyxBdaIKfFMbvqbkATp/tlVcvMJORyloD0Vmab2qWFwtYDJZevqVDnqDGJknreU4v0LxTFgVYE4J/dPgZ4ZCAmqETkCAVr1Dt2ka4d2ORDJ3wt7euyiG7F7hxNcM0d6Y2raP/JQ7MecOA8KljfxFgkbKFJugAz/Slu/GoKM5eLpRi5ElBLZjol5QX2xXjOhcFmty9+sTv24R5KQOFmrLWJtYQzibymp0R6QA2L7Rk7+zre0bEZ7Dw5xUC2gH4GCAOLPWkWAgK2TrFRNUMG6tQ1KV3hDb2wNUjjHe7iHnuFaO2/ZThc7IyfcLnug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k1jVj5aypZvAtQ2fLKC+dD8lHE4keg5995ELcuMCN2I=;
 b=Um6EWg0xDjwxUOE4/iZbx792dF4PM4Y7scmKAtaLhxWK50HdlYXH+LTH2bsaJUZC2F4c0uLC6Pw6nVhynw7Vs+n9gJVLtbOKuwCUvxSglL1gJnB0F9p6mXKlgjha5TzjXGPKXrL/mhY20USxxQj8i0BHvYWxzFbnsLq4DhA8klc=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MN2PR10MB3246.namprd10.prod.outlook.com (2603:10b6:208:122::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Wed, 26 Jan
 2022 20:29:11 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3%5]) with mapi id 15.20.4930.017; Wed, 26 Jan 2022
 20:29:10 +0000
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
Subject: Re: [PATCH v4 65/66] mm: Remove the vma linked list
Thread-Topic: [PATCH v4 65/66] mm: Remove the vma linked list
Thread-Index: AQHX5r/8JI3RkHfoRE+zvsTKv6UgjqxsfGiAgAmcyIA=
Date:   Wed, 26 Jan 2022 20:29:10 +0000
Message-ID: <20220126202857.y53bz24zom2znb5i@revolver>
References: <20211201142918.921493-1-Liam.Howlett@oracle.com>
 <20211201142918.921493-66-Liam.Howlett@oracle.com>
 <5a83c2ad-82d7-9c56-89cf-5a2184386adc@suse.cz>
In-Reply-To: <5a83c2ad-82d7-9c56-89cf-5a2184386adc@suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5ff2b403-a6e6-43cb-505b-08d9e10a82c8
x-ms-traffictypediagnostic: MN2PR10MB3246:EE_
x-microsoft-antispam-prvs: <MN2PR10MB324636889690FCBD673FC439FD209@MN2PR10MB3246.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TgdjBKWy79TUZ2C/QGBZuRhQSOD17JwgrknXAPV7VO3IPCrbtthSKAYq9NM3l+2du73OTqRw7Zgdu1zKUCUDAw9OcpcxDWwBHp3TRa/N4rIqWogypkysoBlDCh9OsguqBESLm1PkwM/ObN7bjYdyQC4fJ9MIroKlF09RrPwP/2KdhtWITh5Y5tmv6Rf4h6yQOOaVS3nV3K/Ygz8sZ00PCFqC/z/8keWwcymhrrj3ipz5x3zG9wOJvqVc+nGjXXczIXbU8vYellio9UYy16M9yhZWk2x1TnZg44gIXzE/VeaXcq9lEPN659TWNQ1y2jOPYVdGUfRLF7RfCO7ZdYolF0OjiJql2f1FgCTBglv+pM2FuZxPjRrHb7ifIVHKXXiASJYvOfg47n8NF35v7RseDpvA2BkiNJBJdzwmD67qrC5GjYGyjc2LzJmpjGmlP2g++HrVBAXeHOTw4BySQbq2vc0sgw2FfvqiTuNTkoXnxPc4Hdd4ZoaIbbV2v+j/mfJ4Ltm5D/VzKMfwJrM0dDwiNGhrCqNiyLWk49Bgh54jOIgsEO+V1PpPNg8/T0wm181F9qkDNJMZK4PyTD3UMizvg6W7hgu5rL/Jmihb04WFNETfqfQNW613vPYTpenf0iN4mspKy4xRGri5l+skSzpTOt0gEKHRaogewAnuGTHQjdHNQB4b/0pUTnpfPtv//ZxhgjalRlsThLDRy5fMRcNNmyLZac/c481DmQq45zX5flJ+VeQ1dda+1bqhhSt9d0FO
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(6506007)(508600001)(33716001)(6916009)(71200400001)(53546011)(54906003)(6486002)(86362001)(83380400001)(66446008)(76116006)(26005)(186003)(2906002)(1076003)(38100700002)(91956017)(9686003)(6512007)(5660300002)(38070700005)(44832011)(8676002)(316002)(64756008)(66476007)(122000001)(66556008)(66946007)(7416002)(4326008)(8936002)(20210929001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OBPML40t+FirJGuQpJpF6SAkf1V9QAxmJi5WTY6r0YK1mL38ErwdT+I+w0dI?=
 =?us-ascii?Q?58Viw8pzIqA3+Lcv1Frxk0mL7u9z9ETXijCiaXLAj32VKpP9C4hYsqz9f1FY?=
 =?us-ascii?Q?0EqYJIAwkJRbYnZZNUsUn7MJMOv4z6MxXUUj7RPfCzBnax3KFFoUq4E/sf3m?=
 =?us-ascii?Q?NOR3Ld6VIQPxdpuu6VHseDom6lkrFdmDmeFar0y8eZr5uBD9diljmp33FB6y?=
 =?us-ascii?Q?ReeL171fH6c2vmgNlM6H4zhKZwFheNzmD8fjFaDqa+GebJ9sauiT351iE58W?=
 =?us-ascii?Q?OiDKYXG8u8PBrl6f+aZ0vsKeTj53Wh/9KO6WPDgfeRdS5VxbIjFvb/lQGXa3?=
 =?us-ascii?Q?IKBBtylt5Lm+gJjEHUG1idnzc5mLH4vaIA/Fov1GQoZjGasZbQ5OYegiTl7c?=
 =?us-ascii?Q?WMv9cRv5z9qIYVNG8eUzTvuXEouGlGGDbhqpKiKC3WwUNh9tsZPrfn4eGTaV?=
 =?us-ascii?Q?wgs/yK1pqByYNhqRE2epRJfb32K7c9fuiu5+BG2NCJzErwmZ56xZNAbE8Xeb?=
 =?us-ascii?Q?03iBLiAh/GvsXrpFS1TwkhoRm2wKe/2dCghFJhK+Gt04zWWmvzglbEUCXGaM?=
 =?us-ascii?Q?GmnMPzfuXURl0S8Ii7lG6xeL2RNePvaPCNlSApVIBznIFptjOk5L3lEQ9GT7?=
 =?us-ascii?Q?iGz5IzQoJZYGbME4kApuYTHFxEeCfYBfexh0MshDIY7lYQ5EoEcqiqM7Ln/Y?=
 =?us-ascii?Q?Bu3Re2A5V8q46PDTsRmWfJnDM9dcPQ4upFS16Ir3tPq8g6W1xRddQ+oYGB3r?=
 =?us-ascii?Q?SHkHcZKD/3COxDTkLIoxXbK+/1dUJkk5D+PSAdkKOTKRuYTf+rWbwr+0r0iT?=
 =?us-ascii?Q?TcEq7joI0KPtW50jbZrZQXZuMtk7FoGGMIpHHxTMNCQdQDlEhQVYnksLDRpu?=
 =?us-ascii?Q?AABI/Ex3uCZzZfos9RFd3kfBlYIsIBCpXHIBud7pxpsJBfVgAGW17NTcDhzi?=
 =?us-ascii?Q?t9rM6HD4BdI6DtI9YinN92P4rgR77tlKPRozcdFq/Sgl0CVvd10efPqT0ePZ?=
 =?us-ascii?Q?at9HGcN4ixkm6F0MzJrxaN/N6KlQc9vwd2HUq0HZbiZxWRXCCtzEBO731/ZD?=
 =?us-ascii?Q?9SVnzEu2Ubj/1zrwnzIcTkmILXT1GfF4nWFYmThwaDIW01LYnhM/Z2KCuzLy?=
 =?us-ascii?Q?F2WfErB8+jyCGgShDXUmokl60vWR8i1anoKfQSqN8Etgf8hMbE8t3yyT925W?=
 =?us-ascii?Q?g4iGLg54bBlEQGIY9xP9xvhD8FS4glSxhmTkgLxPUoL/qN+T86TYCCj+gJ2J?=
 =?us-ascii?Q?+2uSpTvwlzPenjt9hFpVOZBBV+Bifl2KgOuWLKrWhH3BR03G0hPvVG3eUX7h?=
 =?us-ascii?Q?gjW8wTkOA2T8dBubxHoSwc8cdlThMN5Z60DpddyS/Jk0iodnRvdOiG2JN5MG?=
 =?us-ascii?Q?k6PohM+thKdKKGJ/ANUCrctwOimMngaWVfXg657e51NEGLFFxks+0NT5Fhxf?=
 =?us-ascii?Q?chnAk+mrd45Svh8b+XkdLU5FSauXXiTvYF03omS6JE61u7DUJHwK2RTELB4G?=
 =?us-ascii?Q?iQFQAregze6NMry5uELcvtiJEPKmBLS2daF0Z2E+zPEMuNhN0gxPWRmBO4iV?=
 =?us-ascii?Q?jQJqQKqjU+VRmuMkxcJL2fieOBsAhwrxKj+SEGvTR3jceotMBnaACeNNer8y?=
 =?us-ascii?Q?LKlqYR2fZKcPJf9hM39CkMM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <84D448508231AC4C92F853F8FA865585@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ff2b403-a6e6-43cb-505b-08d9e10a82c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2022 20:29:10.8786
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7W4d6PG59X84PB08G9tg5Q3zm+H7/AsKnwjcUn1SsgTlMdw4xmO7tKducpmwOvnyo/NSt5tE7RyprGFeozu+UA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3246
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10239 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 spamscore=0 bulkscore=0 mlxscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201260119
X-Proofpoint-GUID: LMFZaq0BBrDTXBYJ1kOCfAzNeFEgk1E7
X-Proofpoint-ORIG-GUID: LMFZaq0BBrDTXBYJ1kOCfAzNeFEgk1E7
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Vlastimil Babka <vbabka@suse.cz> [220120 12:41]:
> On 12/1/21 15:30, Liam Howlett wrote:
> > From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> >=20
> > Replace any vm_next use with vma_find().
> >=20
> > Update free_pgtables(), unmap_vmas(), and zap_page_range() to use the
> > maple tree.
>=20
> > Use the new free_pgtables() and unmap_vmas() in do_mas_align_munmap().
> > At the same time, alter the loop to be more compact.
> >=20
> > Now that free_pgtables() and unmap_vmas() take a maple tree as an
> > argument, rearrange do_mas_align_munmap() to use the new table to hold
> > the lock
>=20
> table or tree?

tree, thanks.

>=20
> > Remove __vma_link_list() and __vma_unlink_list() as they are exclusivel=
y
> > used to update the linked list
> >=20
> > Rework validation of tree as it was depending on the linked list.
> >=20
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
>=20
> git grep shows that some usages of 'vm_next' and 'vm_prev' remain after t=
his
> patch, including some exotic arch code.

I must have missed them being added during the development cycle of
maple tree.. except parisc; parisc has a block of code left in an #if 0
so it's not lost - Good thing it's in CVS now so it's safe :)

Thanks, riscv will require a new patch.

damon test code will require a new patch - I will add this to the damon
conversion patch.

>=20
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -398,12 +398,21 @@ void free_pgd_range(struct mmu_gather *tlb,
> >  	} while (pgd++, addr =3D next, addr !=3D end);
> >  }
> > =20
> > -void free_pgtables(struct mmu_gather *tlb, struct vm_area_struct *vma,
> > -		unsigned long floor, unsigned long ceiling)
> > +void free_pgtables(struct mmu_gather *tlb, struct maple_tree *mt,
> > +		   struct vm_area_struct *vma, unsigned long floor,
> > +		   unsigned long ceiling)
> >  {
> > -	while (vma) {
> > -		struct vm_area_struct *next =3D vma->vm_next;
> > +	MA_STATE(mas, mt, vma->vm_end, vma->vm_end);
> > +
> > +	do {
> >  		unsigned long addr =3D vma->vm_start;
> > +		struct vm_area_struct *next;
> > +
> > +		/*
> > +		 * Note: USER_PGTABLES_CEILING may be passed as ceiling and may
> > +		 * be 0.  This will underflow and is okay.
> > +		 */
> > +		next =3D mas_find(&mas, ceiling - 1);
> > =20
> >  		/*
> >  		 * Hide vma from rmap and truncate_pagecache before freeing
> > @@ -422,7 +431,7 @@ void free_pgtables(struct mmu_gather *tlb, struct v=
m_area_struct *vma,
> >  			while (next && next->vm_start <=3D vma->vm_end + PMD_SIZE
> >  			       && !is_vm_hugetlb_page(next)) {
> >  				vma =3D next;
> > -				next =3D vma->vm_next;
> > +				next =3D mas_find(&mas, ceiling - 1);
> >  				unlink_anon_vmas(vma);
> >  				unlink_file_vma(vma);
> >  			}
> > @@ -430,7 +439,7 @@ void free_pgtables(struct mmu_gather *tlb, struct v=
m_area_struct *vma,
> >  				floor, next ? next->vm_start : ceiling);
> >  		}
> >  		vma =3D next;
> > -	}
> > +	} while (vma);
> >  }
> > =20
> >  void pmd_install(struct mm_struct *mm, pmd_t *pmd, pgtable_t *pte)
> > @@ -1602,17 +1611,19 @@ static void unmap_single_vma(struct mmu_gather =
*tlb,
> >   * ensure that any thus-far unmapped pages are flushed before unmap_vm=
as()
> >   * drops the lock and schedules.
> >   */
> > -void unmap_vmas(struct mmu_gather *tlb,
> > +void unmap_vmas(struct mmu_gather *tlb, struct maple_tree *mt,
> >  		struct vm_area_struct *vma, unsigned long start_addr,
> >  		unsigned long end_addr)
> >  {
> >  	struct mmu_notifier_range range;
> > +	MA_STATE(mas, mt, vma->vm_end, vma->vm_end);
> > =20
> >  	mmu_notifier_range_init(&range, MMU_NOTIFY_UNMAP, 0, vma, vma->vm_mm,
> >  				start_addr, end_addr);
> >  	mmu_notifier_invalidate_range_start(&range);
> > -	for ( ; vma && vma->vm_start < end_addr; vma =3D vma->vm_next)
> > +	do {
> >  		unmap_single_vma(tlb, vma, start_addr, end_addr, NULL);
> > +	} while ((vma =3D mas_find(&mas, end_addr - 1)) !=3D NULL);
> >  	mmu_notifier_invalidate_range_end(&range);
> >  }
> > =20
> > @@ -1627,8 +1638,11 @@ void unmap_vmas(struct mmu_gather *tlb,
> >  void zap_page_range(struct vm_area_struct *vma, unsigned long start,
> >  		unsigned long size)
> >  {
> > +	struct maple_tree *mt =3D &vma->vm_mm->mm_mt;
>=20
> Well looks like that's also an option to avoid a new parameter :)
>=20
> > +	unsigned long end =3D start + size;
> >  	struct mmu_notifier_range range;
> >  	struct mmu_gather tlb;
> > +	MA_STATE(mas, mt, vma->vm_end, vma->vm_end);
> > =20
> >  	lru_add_drain();
> >  	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma, vma->vm_mm,
> > @@ -1636,8 +1650,9 @@ void zap_page_range(struct vm_area_struct *vma, u=
nsigned long start,
> >  	tlb_gather_mmu(&tlb, vma->vm_mm);
> >  	update_hiwater_rss(vma->vm_mm);
> >  	mmu_notifier_invalidate_range_start(&range);
> > -	for ( ; vma && vma->vm_start < range.end; vma =3D vma->vm_next)
> > +	do {
> >  		unmap_single_vma(&tlb, vma, start, range.end, NULL);
> > +	} while ((vma =3D mas_find(&mas, end - 1)) !=3D NULL);
> >  	mmu_notifier_invalidate_range_end(&range);
> >  	tlb_finish_mmu(&tlb);
> >  }
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index dde74e0b195d..e13c6ef76697 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -74,9 +74,10 @@ int mmap_rnd_compat_bits __read_mostly =3D CONFIG_AR=
CH_MMAP_RND_COMPAT_BITS;
> >  static bool ignore_rlimit_data;
> >  core_param(ignore_rlimit_data, ignore_rlimit_data, bool, 0644);
> > =20
> > -static void unmap_region(struct mm_struct *mm,
> > +static void unmap_region(struct mm_struct *mm, struct maple_tree *mt,
> >  		struct vm_area_struct *vma, struct vm_area_struct *prev,
> > -		unsigned long start, unsigned long end);
> > +		struct vm_area_struct *next, unsigned long start,
> > +		unsigned long end);
> > =20
> >  /* description of effects of mapping type and prot in current implemen=
tation.
> >   * this is due to the limited x86 page protection hardware.  The expec=
ted
> > @@ -173,10 +174,8 @@ void unlink_file_vma(struct vm_area_struct *vma)
> >  /*
> >   * Close a vm structure and free it, returning the next.
>=20
> No longer returning the next.

ack

>=20
> >   */
> > -static struct vm_area_struct *remove_vma(struct vm_area_struct *vma)
> > +static void remove_vma(struct vm_area_struct *vma)
> >  {
> > -	struct vm_area_struct *next =3D vma->vm_next;
> > -
> >  	might_sleep();
> >  	if (vma->vm_ops && vma->vm_ops->close)
> >  		vma->vm_ops->close(vma);
>=20
> <snip>
>=20
> >   */
> >  struct anon_vma *find_mergeable_anon_vma(struct vm_area_struct *vma)
> >  {
> > +	MA_STATE(mas, &vma->vm_mm->mm_mt, vma->vm_end, vma->vm_end);
> >  	struct anon_vma *anon_vma =3D NULL;
> > +	struct vm_area_struct *prev, *next;
> > =20
> >  	/* Try next first. */
> > -	if (vma->vm_next) {
> > -		anon_vma =3D reusable_anon_vma(vma->vm_next, vma, vma->vm_next);
> > +	next =3D mas_walk(&mas);
> > +	if (next) {
> > +		anon_vma =3D reusable_anon_vma(next, vma, next);
> >  		if (anon_vma)
> >  			return anon_vma;
> >  	}
> > =20
> > +	prev =3D mas_prev(&mas, 0);
> > +	VM_BUG_ON_VMA(prev !=3D vma, vma);
> > +	prev =3D mas_prev(&mas, 0);
> >  	/* Try prev next. */
> > -	if (vma->vm_prev)
> > -		anon_vma =3D reusable_anon_vma(vma->vm_prev, vma->vm_prev, vma);
> > +	if (prev)
> > +		anon_vma =3D reusable_anon_vma(prev, prev, vma);
> > =20
> >  	/*
> >  	 * We might reach here with anon_vma =3D=3D NULL if we can't find
> > @@ -1906,10 +1825,10 @@ struct vm_area_struct *find_vma_intersection(st=
ruct mm_struct *mm,
> >  					     unsigned long start_addr,
> >  					     unsigned long end_addr)
> >  {
> > -	MA_STATE(mas, &mm->mm_mt, start_addr, start_addr);
> > +	unsigned long index =3D start_addr;
> > =20
> >  	mmap_assert_locked(mm);
> > -	return mas_find(&mas, end_addr - 1);
> > +	return mt_find(&mm->mm_mt, &index, end_addr - 1);
>=20
> Why is this now changed again?

I found this with one of your previous comments, I have a fix.

>=20
> >  }
> >  EXPORT_SYMBOL(find_vma_intersection);
> > =20
> > @@ -1923,8 +1842,10 @@ EXPORT_SYMBOL(find_vma_intersection);
> >   */
> >  inline struct vm_area_struct *find_vma(struct mm_struct *mm, unsigned =
long addr)
> >  {
> > -	// Note find_vma_intersection will decrease 0 to underflow to ULONG_M=
AX
> > -	return find_vma_intersection(mm, addr, 0);
> > +	unsigned long index =3D addr;
> > +
> > +	mmap_assert_locked(mm);
> > +	return mt_find(&mm->mm_mt, &index, ULONG_MAX);
>=20
> And here.

Ditto.

>=20
> >  }
> >  EXPORT_SYMBOL(find_vma);
> > =20
> > @@ -2026,7 +1947,7 @@ int expand_upwards(struct vm_area_struct *vma, un=
signed long address)
> >  	if (gap_addr < address || gap_addr > TASK_SIZE)
> >  		gap_addr =3D TASK_SIZE;
> > =20
> > -	next =3D vma->vm_next;
> > +	next =3D vma_find(mm, vma->vm_end);
> >  	if (next && next->vm_start < gap_addr && vma_is_accessible(next)) {
> >  		if (!(next->vm_flags & VM_GROWSUP))
> >  			return -ENOMEM;
> > @@ -2072,8 +1993,6 @@ int expand_upwards(struct vm_area_struct *vma, un=
signed long address)
> >  				vma->vm_end =3D address;
> >  				vma_store(mm, vma);
> >  				anon_vma_interval_tree_post_update_vma(vma);
> > -				if (!vma->vm_next)
> > -					mm->highest_vm_end =3D vm_end_gap(vma);
> >  				spin_unlock(&mm->page_table_lock);
> > =20
> >  				perf_event_mmap(vma);
> > @@ -2100,7 +2019,7 @@ int expand_downwards(struct vm_area_struct *vma, =
unsigned long address)
> >  		return -EPERM;
> > =20
> >  	/* Enforce stack_guard_gap */
> > -	prev =3D vma->vm_prev;
> > +	find_vma_prev(mm, vma->vm_start, &prev);
> >  	/* Check that both stack segments have the same anon_vma? */
> >  	if (prev && !(prev->vm_flags & VM_GROWSDOWN) &&
> >  			vma_is_accessible(prev)) {
> > @@ -2235,20 +2154,22 @@ EXPORT_SYMBOL_GPL(find_extend_vma);
> >   *
> >   * Called with the mm semaphore held.
>=20
> Above this, the comment talks about vma list, update?

I will update the comment.

>=20
> >   */
> > -static void remove_vma_list(struct mm_struct *mm, struct vm_area_struc=
t *vma)
> > +static inline void remove_mt(struct mm_struct *mm, struct maple_tree *=
detached)
> >  {
> >  	unsigned long nr_accounted =3D 0;
> > +	unsigned long index =3D 0;
> > +	struct vm_area_struct *vma;
> > =20
> >  	/* Update high watermark before we lower total_vm */
> >  	update_hiwater_vm(mm);
> > -	do {
> > +	mt_for_each(detached, vma, index, ULONG_MAX) {
> >  		long nrpages =3D vma_pages(vma);
> > =20
> >  		if (vma->vm_flags & VM_ACCOUNT)
> >  			nr_accounted +=3D nrpages;
> >  		vm_stat_account(mm, vma->vm_flags, -nrpages);
> > -		vma =3D remove_vma(vma);
> > -	} while (vma);
> > +		remove_vma(vma);
> > +	}
> >  	vm_unacct_memory(nr_accounted);
> >  	validate_mm(mm);
> >  }=
