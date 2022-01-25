Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B34B49B874
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 17:21:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236667AbiAYQVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 11:21:21 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:34414 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1583443AbiAYQSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 11:18:25 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20PG4lQh013043;
        Tue, 25 Jan 2022 16:17:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=AQ/ZWDoiikcNZ46C4F3GusFocxafo++aaIRyGitsT/c=;
 b=I6xADU89dS6YIZzuXKmmZwvPfFFYVRLKPqrBcL1q44MuDY1aNpKAVSdx3Brg0b/iISOZ
 QBUl+EZzHRcNWKtHMKrHWgOrjXQtZHhFeU8A4jj//RRDe24UkYk9x7DOklYf/UC8BUPn
 aFE5UXsWD9MLSNMjYERhc8IJouk2fQyZFhQnxkw/h6pFfWiFKJt2dIeiUArJVB9kPTL5
 ciETzWmsomnkg29/FLZUHINhhPbRFf/rksLGbioI9EGSUtPPr+zzc0pjvNGp+HdvmEJg
 8IOZDEqj6j8yklX+XF0y4RYFeAnscrCEZW/cBSu/WCjnF3aQazK91yn5bk83g24Aukry UA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dsxaabk63-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jan 2022 16:17:11 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20PGB0S7018705;
        Tue, 25 Jan 2022 16:17:10 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by userp3030.oracle.com with ESMTP id 3dr71y8k3p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jan 2022 16:17:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ni4UR2piuOTM4nF5tbpqHcbiKftuwxUGFJgAp9kJH5zOPxAlL98QCbbbrHhYlrF3Nd8inrI9DqfjKoQJDq94u1LqVHDp9SiShLbKLeQq/TUyf7zJRn9iH8IFhOS3aCvOdmtlzRWGbvFWn4H7SDrG+skunhazemLICYRIYUgwnjWH3A6Fx9RdnyzY7pWbnmwl+e9kgySTsysUxZZHK6CsYtSJNoCXQadEabAAxFw1f81MkzZMm9kEV/K6MhsW/yneShv8ajF8jmwUFJ2h2URz6xAbX4OlqRqw0F97rPJr4ZooqTK4AuXhM12xYo6WmxHAjj8/o+GFKMvpzeyRnUxzNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AQ/ZWDoiikcNZ46C4F3GusFocxafo++aaIRyGitsT/c=;
 b=gmEzQqE0PJ0PftcSdy0kPmONbwp3byPRY5YepVl54NIQC43ez6rR1T0rlJgveDIsrxihoiwIEaQ0MDjjeXyBYTPJvwk9muOX7T911q78x3U5HaFrp1wXblWDmI0qk0jdeNTsftqzaYQtQxcfB5HgpZG29aUJHP/adUyVNy44eInIU9gVXRi08WiD5Vk4Q5XxsPWdtMuxqAs2IY8unqP2fPxOIUSWImVOstT0VGgbp0+LsYELsFt9U06iwB3BPd+gwYnCcX5pj3mjeAW5aj8OQiqaqa66qvNgbHRqg2iIGmo1LwyOGyILhiXXDBQrzdLG08TAhdVP4vt06E8hEx70bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AQ/ZWDoiikcNZ46C4F3GusFocxafo++aaIRyGitsT/c=;
 b=sE4wZlXKN7jb9qlueWcTLK2kac4uZVQx0ZzfBBzPw6qFeCZ8iaiJmWSwD+X2aCU8yvgz1RdhGU42FgjpRpohxQX51r+DlEOadpmOfLJ5zMEdJ7iaHYJue8r1fhf6doCEq5nZpOnoxmlN2C+XBE2vRUPCBk+20ynFM4VKEXK5r8A=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BN8PR10MB3330.namprd10.prod.outlook.com (2603:10b6:408:c1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Tue, 25 Jan
 2022 16:17:07 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3%5]) with mapi id 15.20.4909.019; Tue, 25 Jan 2022
 16:17:07 +0000
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
Subject: Re: [PATCH v4 33/66] xtensa: Remove vma linked list walks
Thread-Topic: [PATCH v4 33/66] xtensa: Remove vma linked list walks
Thread-Index: AQHX5r/vRpDQ3tKIRkGBusNvbzhALKxo/v6AgAtBcIA=
Date:   Tue, 25 Jan 2022 16:17:07 +0000
Message-ID: <20220125161653.dxn2trj5rykvm62c@revolver>
References: <20211201142918.921493-1-Liam.Howlett@oracle.com>
 <20211201142918.921493-34-Liam.Howlett@oracle.com>
 <c4c90bfb-5e94-84fb-aec8-cc0edb9b7efb@suse.cz>
In-Reply-To: <c4c90bfb-5e94-84fb-aec8-cc0edb9b7efb@suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a6bf6f62-8cfc-4321-eaad-08d9e01e2208
x-ms-traffictypediagnostic: BN8PR10MB3330:EE_
x-microsoft-antispam-prvs: <BN8PR10MB3330B1040BD887864C5FC36AFD5F9@BN8PR10MB3330.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bbo0fbG5ZUjV2FhZcYH9PEMpx63RPX5fK8UsupAIzYxapefO//HHuicIHvhlBvcQxzaxPwrXOWJ27VJEcr89jiEZAqBp7qL8Stn6DA7Vm8AUrhrhosjO4+mJZ1CoDrnIvSPR9Mv3baUiaF2it4PUvuxOTGFqJUIS4/0+YUxgg9EG5+ZxG51nN350OHzcDQYqY4NZLmXt5k0j8hZF6PMzG69eXXiOAzy9SLoEQc6tsXX7fAwslOkqcZTpyi04DR1mrwaoZQbcVH+q3sfYHSgPOx+7eIMOymShgsJ2e7bmcyF77QaLd3wa5uuIGW4esVMJj84ZlnaE1es7Y9VGhLn0rrJhHFMtNsZqXS4px0dQCt8emoVdZz334e2gqVvmo6+kPFhWXlFW3nGNjlQBezxqnSMXlqV+JhT7jt/HbHF7nrrSelg9xyDzTfL1zZU7UJSRtaP5JqvvmkL3mRaYWqibQ6aRYqsZ+AKQGhZGl5k49Blwdnl1m5t4QNUl9zwUkpMUS54yVlqNSV3TrQ777aR01q854fQa672je9lorJSN4QWuDvxDTVgqK0LEbC4U+wPDdLgSBE6bgcDFi5qq98syLz/ZUdh8ClQCpyy3M4W/NnIi/BH0g6kXkW0iLwXqXZWHV01LmjSdJPBXtiXzPSBphYj7LXWkFaSGnw6l8XW+Zho8FhDlNt/O4+StSrUr6h5Z1IiPSbml0dQYSRRhmvejCg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(508600001)(6506007)(83380400001)(53546011)(186003)(38070700005)(44832011)(86362001)(5660300002)(26005)(1076003)(6916009)(4326008)(8936002)(7416002)(6512007)(316002)(9686003)(6486002)(66556008)(8676002)(66946007)(91956017)(76116006)(33716001)(54906003)(122000001)(64756008)(71200400001)(2906002)(38100700002)(66476007)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IOSZVgJYramgn+YnBvGGMC42o2imKc+UWIt0uIWtCvORhgNVSlpRhJKO3R8q?=
 =?us-ascii?Q?/8Tveuxwpbubc38sIauhCqA8pQOt9yI3wO77qbQaQTTrIPB2gPv9J4Q+O6oM?=
 =?us-ascii?Q?o3LnBSobIShrSXSWFoVNf/mw2F5+U9dULEEVDo2NYqecBqdKTZuNMwYqg6ZE?=
 =?us-ascii?Q?rHe5tzWRDF8983NCmI7rL4smi4fxsqqwO1Ys8kTISJH1iFr1Ojz1Oxpko/fm?=
 =?us-ascii?Q?NKAjaBIBfG0J8rzWCOFFWQsnfp3zgp1j16vOD4kvoRYKng0mq1xEJsVIoTfj?=
 =?us-ascii?Q?TVUzO/zHMwU0W4kTRjse3P+ZVNCBaSWU85Dvpx8prlXC8a7RnsACJPHd24vh?=
 =?us-ascii?Q?TTn14s4cI8qwcJH64CJgf/0wYOdtShyvXTqBMfSshhJ26W2HnZb+45dTSwTI?=
 =?us-ascii?Q?6MCPD4aKkwTBm7ioRUq10AQCkAy+EXJQlP9FBp+q6mgMVLP0lORzQBZWg9Y0?=
 =?us-ascii?Q?pYZjWsKzzCuFzR2QRXVvk5IC+yurrNx4gz5oh6YaZLisKHfrbIM/z+f3l0cq?=
 =?us-ascii?Q?e2QsCRr91E0JlrZ42L0IwD1PmLPbf3oX4qV4R5nLwcbRUilImCZYRO7CdL2E?=
 =?us-ascii?Q?Ji0EtqKO9GTy/N7s7z9bKjleqV2HRjZDQA+KL32iq5zYSvcjE3g0MV+pUUeL?=
 =?us-ascii?Q?gKbyKs/sohigRuta+tSttueFx147uR8pTKkIcFateK0FPxDzwvkUFQUdMmN4?=
 =?us-ascii?Q?Hfs28V+5WDjIhgWSTdz/FxGDHwg6rAqCdI6fWlCqmTzovWbZ3QCBAsa6qhmA?=
 =?us-ascii?Q?1woCxYxH8AuRdEAsEQnifgJEDfU4I1M7Jlx2NBzLFuypIKemmnuZc4L7u75b?=
 =?us-ascii?Q?UYsAkkKCySm4o3+xUV84gkbX/z6b9ooDeluWFtP2n/4Ey/RE64XMv+nCvVWN?=
 =?us-ascii?Q?9BgexObH4ukGg244zMx9KC7jYYIw3jhAtIH54FvP+aaLYX/EmoZGm+wWCG0l?=
 =?us-ascii?Q?n0oIbJSRIuI04nOONxVF9SgChv5BE1AC6/W/t4GpW24HFZiWk3wR6+Frq/iS?=
 =?us-ascii?Q?kj4f3aWrY9LrbT2jtLOOZ4+RmL1IOc80XaMel/aLW2rjhEocLrV8xckCbipb?=
 =?us-ascii?Q?BzHB2a4RQHfWEYf2DmDxMOitkLaF6/zAofwsFOIz5S9i0/W4R5hy9Uw1CzFM?=
 =?us-ascii?Q?yar17if/egr9NvO0+j8ElU0I/0PpBtwnPilO3f8AXtUHyqc72Bv+E5/I4sxA?=
 =?us-ascii?Q?+GbAlBy+Qu14hCH04tGAa8vCiVGwfEchP1SpbXn7PTyZB1tgsQRXXvqlytx+?=
 =?us-ascii?Q?sLHhExbWf0ov0/XxC1F9NOkXV3tJsAdEgbZS8ioHD5YLrYIH5a1elunay1k2?=
 =?us-ascii?Q?aeaznmSAw8Gj51JWXiPawVf5yEHpW+bhQtgNJELfxBF8W83xzTMf6zUGg34s?=
 =?us-ascii?Q?xzQyn4/tkubFrPWlEfhU/7TyJsKl+uom73abOLWt/zRRMWtXeI4E7MMwJ1xU?=
 =?us-ascii?Q?XL9GQt21EN2JC/I9ymUyL3Nh00UK//lFxQUJOHhSLEU0Sn7Q7nPQiWJJO/N3?=
 =?us-ascii?Q?VvmcWVuRGCpUIFCOn/bai8DKFDfuWVWPEwBV03HVUE7rdq941grnwcwlpREy?=
 =?us-ascii?Q?Qo7/WlsTYBS/7Y+lcZtqzZtAPBOlAZm/QO+qT+qtupeYELr1HJBZypX49qeg?=
 =?us-ascii?Q?Sa2v4IOKcBmyIAiF3eW2vE4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CA9966BF7B0BCD409D19E2A080DF40FD@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6bf6f62-8cfc-4321-eaad-08d9e01e2208
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2022 16:17:07.3661
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GOnQBBI/22q9RNiCfhaKMEElg7Y//figWoGfl25+0T8FintwKJ+Jo3ElHGF+V4WbUGK9NtTHqUcNElg2bX8Byw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3330
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10238 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=798
 adultscore=0 spamscore=0 bulkscore=0 mlxscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201250104
X-Proofpoint-GUID: MVKwO0TrWtoivngo2Uf8DTXZkDa4IO0i
X-Proofpoint-ORIG-GUID: MVKwO0TrWtoivngo2Uf8DTXZkDa4IO0i
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Vlastimil Babka <vbabka@suse.cz> [220118 07:23]:
> On 12/1/21 15:30, Liam Howlett wrote:
> > From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> >=20
> > Use the VMA iterator instead.
> >=20
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> > ---
> >  arch/xtensa/kernel/syscall.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/arch/xtensa/kernel/syscall.c b/arch/xtensa/kernel/syscall.=
c
> > index 201356faa7e6..20ec9534e01f 100644
> > --- a/arch/xtensa/kernel/syscall.c
> > +++ b/arch/xtensa/kernel/syscall.c
> > @@ -58,6 +58,7 @@ unsigned long arch_get_unmapped_area(struct file *fil=
p, unsigned long addr,
> >  		unsigned long len, unsigned long pgoff, unsigned long flags)
> >  {
> >  	struct vm_area_struct *vmm;
> > +	VMA_ITERATOR(vmi, mm, addr)
>=20
> Need to use current->mm or it won't compile, AFAICS.

I will fix this.

>=20
> ;
> > =20
> >  	if (flags & MAP_FIXED) {
> >  		/* We do not accept a shared mapping if it would violate
> > @@ -79,7 +80,7 @@ unsigned long arch_get_unmapped_area(struct file *fil=
p, unsigned long addr,
> >  	else
> >  		addr =3D PAGE_ALIGN(addr);
> > =20
> > -	for (vmm =3D find_vma(current->mm, addr); ; vmm =3D vmm->vm_next) {
> > +	for_each_vma(vmi, vmm) {
> >  		/* At this point:  (!vmm || addr < vmm->vm_end). */
>=20
> Well if at this point !vmm then we are no longer here due to for_each_vma=
().
>=20
> >  		if (TASK_SIZE - len < addr)
> >  			return -ENOMEM;
>=20
> Thus we can miss this? But maybe it could be moved above the for loop and
> checked just once, as addr only grows inside the for loop?

Yes, it could be missed.  We could move it below, but not before as it
is to detect the VMA overrunning TASK_SIZE.  The check below will need
to break.  I think it's rare enough that it's okay to run slightly
longer when returning -ENOMEM.

>=20
> However, the loop body continues:
>=20
> >                 if (!vmm || addr + len <=3D vm_start_gap(vmm))
> >                         return addr;
>=20
> So after your patch we fail to return the unmapped area after the last vm=
a.

I will restructure the loop to avoid this issue.
