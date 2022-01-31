Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6604A4A4D72
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 18:42:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381061AbiAaRmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 12:42:55 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:27460 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1381015AbiAaRms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 12:42:48 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20VFwplb006232;
        Mon, 31 Jan 2022 17:41:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=SXXubXI22bzg4EZirPX8M7YUq+MSH4aWEr/P3+lOTLs=;
 b=gOw41gJd5eL/KzAZt6yEnIgv6WqDi+Tv09EcohaOtHj1eivlfxNyDdLiJPNzVa8wof2T
 41IO8TGF3aSg8984Lj+sJV7P4Hz6pwpBFhf6A43TQPcpBRLb2wQ0nEXNGLxESANvusFE
 T4mG7d2YpiI6bv97gI2rTlJFo5FeMSOGKwCm1w7NcNu7XgEwPfCdjWLiF5w3tjCoUjsw
 rkDM4gzL3NSHOs7XhMm+ejr9ya3D9TBarewvx9XjzlHUV9gVZ8U3fe036jYNeX4O7WiH
 kLSnwHeY4YlsiPtknlffRSe33PZorBBt+GE9g7twKyWdTmCVaboqZ0fYJmpKBGC3fMSW ZA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxj9w8g80-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Jan 2022 17:41:30 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20VHZcUO098503;
        Mon, 31 Jan 2022 17:41:30 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2043.outbound.protection.outlook.com [104.47.73.43])
        by aserp3030.oracle.com with ESMTP id 3dvumdxgs8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Jan 2022 17:41:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZPik+cW6vNAYZ9R8UIvL+J6FDfs6jPLLyWM48FcxeLZT8Gy5BZF1ZwlWoSSMR1FpIskzzP8a8jmL2w11wCZpaX20uaF5/1IdsvnJoTlAOptdp4t1Szw93llSopSWC8fKZ6txXJ3qVd/2xcrDIUZZyxMPx/VSlTTDhfSEMk8hYLtuCbsrw0SIuwS7goBVuRydH14rFBPW2rj93HIXfArQUdOz2tntSPXFNniXuFIgRTt3JIdDIoCHrme4/lYBklJedzhOQCxmqZxrsdI/Yc9TnZGzC0BS2wnsUy401nV4PR56l3PHsVAJoR3PAmCISZgavK5O9iVFpJiWZ3oM57f7bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SXXubXI22bzg4EZirPX8M7YUq+MSH4aWEr/P3+lOTLs=;
 b=hERsFm1ME/9NgvcXJm9FhYuM44UQez2ynp5WOieSldreyxVuIjhvTufndfUHFeyBIlGQ9/Jof3Cbu+BgYuA1bErL3I0S7GmNi2XXthfvipvc8YZM8v+uSlznyfhwoCdXhAE/s6tVJL+hztIHTUq+0pG3uIAF3MoGZWOgQC3Rfv8uogwUtBhDWHW2fJiJOh66wQ32N5kHsIFxMKFjJ5ocn6nftgjqu5Sq9Zbx+5+Ymgixz9DlH3g5t/cI9kAQ9P6wumGFN17JGd/rwTt7D1OVp4UB55y08D/afNB8CNKbTQXWlFVPto0B7tX2rFSvbrAEJAz+exRSBtsKXpjJyJYnIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SXXubXI22bzg4EZirPX8M7YUq+MSH4aWEr/P3+lOTLs=;
 b=jb+6H9toX/g7Oric+4d+DRt8DeYo3nMgZvmC5sdqARlGsrX565AYlTjhzcNLmbMbRmn5UMrDoqpBlH5qecl5d+Y1zOWOsta9cbr52bp92b01qo6S/HsXrzQHoYKV14LNsDH0oRVFCxNThW9Pr3jk6Qr5BRqe9ev0WDLYHzCQsvo=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM6PR10MB2748.namprd10.prod.outlook.com (2603:10b6:5:b1::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Mon, 31 Jan
 2022 17:41:27 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3%5]) with mapi id 15.20.4930.022; Mon, 31 Jan 2022
 17:41:27 +0000
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
Subject: Re: [PATCH v4 39/66] binfmt_elf: Take the mmap lock when walking the
 VMA list
Thread-Topic: [PATCH v4 39/66] binfmt_elf: Take the mmap lock when walking the
 VMA list
Thread-Index: AQHX5r/wBRw8/eAyxEKQw67sBbOunqxqd/aAgBNODoA=
Date:   Mon, 31 Jan 2022 17:41:27 +0000
Message-ID: <20220131174121.4swfexon5ezu7b4i@revolver>
References: <20211201142918.921493-1-Liam.Howlett@oracle.com>
 <20211201142918.921493-40-Liam.Howlett@oracle.com>
 <c7fdc80d-4c6f-da67-098d-04435b05b0bc@suse.cz>
In-Reply-To: <c7fdc80d-4c6f-da67-098d-04435b05b0bc@suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 65d5ca8b-0f29-4662-70c3-08d9e4e0e8c2
x-ms-traffictypediagnostic: DM6PR10MB2748:EE_
x-microsoft-antispam-prvs: <DM6PR10MB27488DAA2549594DE2061E19FD259@DM6PR10MB2748.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VimUg5RJMofOPwCFgusczzEesf+x3iKWlt5GVFt4DpEyCNqZOpG9wK4dujx6G4cN+Gd4GjIAzmevQYEO8Fgeajj44sk40CmBxHYMURES6P9gj99wqfmX/W+BbmWUUSvin5vkVELnqjSFMmfcFRbPtB+Zbr7ucp7aLC+CLHYkwI+jVpreE37lWya4rHVtOl24ichutkDlXpA0q0sn51+iXu2ihpEvgRop5ebzBQw6ToGqKNzzMUUK03/AXglW3eSInZioAlZRkMj09v+5z5OjL2lguw4zTKfL4TNb9l0b6kf12EjRnKERDZZc4QC3pnHRYiwYTfJGNwRF56KIcuQKkapLSRWql8hyrwLS52wGDF0So+Les8ZwjEhaH/pSDDib+XKyQ2fjaYbREfMP5xjthwpj96BMVLC4AAnnqGbI06MnOFxsW53UuYStXOerAMNVJS4XECud0vo4utfJWPCEdopXFMRtWuZ/Ew38roZkcIw+9yYfJw+fQDjxKdNrWW4VPFFL806u6k89jyumdJI6vdynR6xfzPaGFw0tU16xyh7ZJwOcuHzo6Jrn0h8DV7XG4jv/PSlbe4Qh0rWGzlU/fIeSOXmp+LNCLceB5vtDC8vY4uW6ULQAgPjb4h8aBYPGrzhzA6nlboeI9wrH5nH2Xv1BJzFOMDz5g+Ja6luoyC6GQnXpkXGAsF5HI2+dxTbPM3AZtwfFJjb1V9zs+sO/Og==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(53546011)(5660300002)(7416002)(6512007)(9686003)(1076003)(186003)(26005)(83380400001)(6506007)(2906002)(44832011)(122000001)(38070700005)(86362001)(316002)(38100700002)(6486002)(91956017)(6916009)(54906003)(508600001)(71200400001)(4326008)(64756008)(66446008)(33716001)(76116006)(66946007)(66556008)(8936002)(66476007)(8676002)(20210929001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VSJhFHoHubv4GTIC29B8aP/XcPUZt2ZKwxf0mJl6QkNp0+sZjt/12hjb4dEY?=
 =?us-ascii?Q?G5/o56gjt4B4hNTZy6HCc2YKQBMGrt8hZYxcf51fBCAcL3kJTwMxeGVm5vQ6?=
 =?us-ascii?Q?xyNFjdZ7rL8guVJXXyLucey4rwXueB1TQciBEL1qst3DbdU8IGqrFTW8ZqwX?=
 =?us-ascii?Q?sOpCXXawlRlW2yHNpr5LE0/6hAGVPTz/No2dNlGpddSVqJFurBlVWcmSpG3M?=
 =?us-ascii?Q?Bqw8hlF3++y5Rds3mSrARqmR6ZTXNBhIFpNUdAaW2wSfvcdtaqRn7DMGxdeA?=
 =?us-ascii?Q?guCZeiaUhA+IIPSyuh5gtiP97qQngSg+Wo5GdBeUdMkrXQdU1wJvK8CVPMJQ?=
 =?us-ascii?Q?wCqsVljDnO/ZrZhQ6y896f5r1kTgIVDIeby34puIapLVY5+E8AmGqfDLdWXc?=
 =?us-ascii?Q?ZDYJdjZ9+P3b6QTYVoVAJN1iOlt8eyJZA4GgGAyrxkHJZaCsnf8+vmArnWgu?=
 =?us-ascii?Q?z1Kw7NCPe2DWeFikNTaNDtvU8lOgM+jP/1e2JOyRXZ0McuLYQPaFB6lYkriS?=
 =?us-ascii?Q?nQ9AbuWWHumgC9mPbSmrEnKeQZRJl3FY+J1RZymv5RmcvXDd44Bv9HnoLrhb?=
 =?us-ascii?Q?50vUsZ1sz3559R6TmmxAOpZfWJrRgwkAl5940L+IzzoBNq6y1M+lR/5X29AZ?=
 =?us-ascii?Q?pF9+XXxqv3EWirEyCqGgrd5pwU8NEfDXZmVj+N/mxH/1GaG4p6pOwt9Zv+4N?=
 =?us-ascii?Q?zjtOxo+QCrB2F/OpgQSQUKcgQPMrjifnICODTkdbKh6LgyisA7ATg+qM2IKO?=
 =?us-ascii?Q?GCMlzEqx/coh1uLaZsfPpGKcM09EErg4ZhGmDw9PIU/KFZFqhW0EU+ZEyWEc?=
 =?us-ascii?Q?Y20Us9r1E3q3AoWQsqdnIM05MZ73OrGoPvKdiRqKSsh5SQPflHh/+/X+jHDr?=
 =?us-ascii?Q?YfE1JHNxJ7dw/HVrBD8g/I2oDG5/CrELjTrqReLLtaMQkUqhRbCO+yJzb8e/?=
 =?us-ascii?Q?enh8wtBapyIWhYQUMTsaAhYVhxn6vIGxnZeMQZMxUBE8HJW21Orlf9R/TA14?=
 =?us-ascii?Q?TnQWOxjYwYYPDV72LRqPpk1BWkieEUP7i+YP8B86o4M/YsF5aJubJiJRFJ0C?=
 =?us-ascii?Q?hfneFeyeAK5TnkVtJZtlRulQfx2fnfk4CoOlwg/Ee6E8vFIsrXz41r1bzfrV?=
 =?us-ascii?Q?5UZKid66QfC2y3X7+ZKUbJh6ovJsvDlW7fb5EIXPSlcH3WuWvIcX0cSa4bNk?=
 =?us-ascii?Q?YW+9Tsuu00tGxNY3u7jN/WQEcv1NhTof9kl3jrSiN1gmhQ31/uZ8i4wHEL1T?=
 =?us-ascii?Q?o4Xq7ITxrGmjjhPy5jCJ5WdhorQ83GqAE4N5tH4LODsN7gyUcwKf6xdaEPY5?=
 =?us-ascii?Q?vw88yLNOKo8NgrB7K3CXCYnL3YKWmpgjaGhEMDyFtbj0LikYFRlJoNk/ljlZ?=
 =?us-ascii?Q?DVP2g9RCEU77Sh+lExNjyQyfSV5gWoyaQjti8+7sZ/N2zedClSyjA/jN7pPw?=
 =?us-ascii?Q?6XQUaKbuHG8E/TvjbKuExggt7iA4eusbVtqVQTDpVInNVBONd2pVBBult1Lk?=
 =?us-ascii?Q?7J2VmGwlq5UpD3aQt//p3vdkVH+Gad6O+ds7YSGKeXIO7//Z5hzS7xuMcH0k?=
 =?us-ascii?Q?Yq6Rnz/d49/dgestIZPrXohXzVqIWo7y320/6b1vpcAf2RHaUSJnh4hlCyY1?=
 =?us-ascii?Q?O6ZV9MxfWvo/8uX4Cv0J4a4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D1A8DD68E2418A4D9CB8D5092E3386CE@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65d5ca8b-0f29-4662-70c3-08d9e4e0e8c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2022 17:41:27.7718
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kGiXRWuBEBb7NLqpBMhPbodd2gjTdkdOwOyJARz5jRkxgVI5pMQpzyaopp0I8hU/RwBhCIxjtGgT1nLcqsCXng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB2748
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10244 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 mlxscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201310114
X-Proofpoint-ORIG-GUID: BFC4MUAUY6afN4uGvjLPYEgeeV2aCgEb
X-Proofpoint-GUID: BFC4MUAUY6afN4uGvjLPYEgeeV2aCgEb
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Vlastimil Babka <vbabka@suse.cz> [220119 05:53]:
> On 12/1/21 15:30, Liam Howlett wrote:
> > From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> >=20
> > I'm not sure if the VMA list can change under us, but dump_vma_snapshot=
()
> > is very careful to take the mmap_lock in write mode.  We only need to
> > take it in read mode here as we do not care if the size of the stack
> > VMA changes underneath us.
> >=20
> > If it can be changed underneath us, this is a potential use-after-free
> > for a multithreaded process which is dumping core.
> >=20
> > Fixes: 2aa362c49c31 ("coredump: extend core dump note section to contai=
n file names of mapped files")
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
>=20
> To be honest this feels out of place in this series. Send separately and =
CC
> Jann who AFAICS added dump_vma_snapshot()?

Thanks.  I have moved the version Matthew sent out separately to the
start of my v5 set.

>=20
> > ---
> >  fs/binfmt_elf.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >=20
> > diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> > index d41cca755ff9..5915518c8a1d 100644
> > --- a/fs/binfmt_elf.c
> > +++ b/fs/binfmt_elf.c
> > @@ -1652,6 +1652,7 @@ static int fill_files_note(struct memelfnote *not=
e)
> >  	name_base =3D name_curpos =3D ((char *)data) + names_ofs;
> >  	remaining =3D size - names_ofs;
> >  	count =3D 0;
> > +	mmap_read_lock(mm);
> >  	for_each_vma(vmi, vma) {
> >  		struct file *file;
> >  		const char *filename;
> > @@ -1662,6 +1663,7 @@ static int fill_files_note(struct memelfnote *not=
e)
> >  		filename =3D file_path(file, name_curpos, remaining);
> >  		if (IS_ERR(filename)) {
> >  			if (PTR_ERR(filename) =3D=3D -ENAMETOOLONG) {
> > +				mmap_read_unlock(mm);
> >  				kvfree(data);
> >  				size =3D size * 5 / 4;
> >  				goto alloc;
> > @@ -1681,6 +1683,7 @@ static int fill_files_note(struct memelfnote *not=
e)
> >  		*start_end_ofs++ =3D vma->vm_pgoff;
> >  		count++;
> >  	}
> > +	mmap_read_unlock(mm);
> > =20
> >  	/* Now we know exact count of files, can store it */
> >  	data[0] =3D count;
> =
