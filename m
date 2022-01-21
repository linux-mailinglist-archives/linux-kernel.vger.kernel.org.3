Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 430564965A3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 20:32:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232480AbiAUTc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 14:32:27 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:63494 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232207AbiAUTc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 14:32:26 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20LGx9Ar010419;
        Fri, 21 Jan 2022 19:31:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=oNJbkagNi9gf9l7CGVVMW1gdll61bReY7gRf2VqyKLE=;
 b=Ommef+7TdP9n4YTsCNRvKVOG3NF9d+K+KY4T6HAGF6s1rbdbHUkE26IvMxLrm9wIK0Bh
 6qWSA/ilkUgKF8F/4kLbE/Ae4smPuL7knP8smVQT+YYpuDZdkQbVUITIIWj9jLyNGEFC
 w4LKde9S2ilg9vrhk6q7Ma9vGGCuIA4TI59JqqCqfr2c76iWPi7N4oy76laohXT+HHvW
 Cww1K17i2F4DgQlkkZmTqRzHui9YC+wQTma5a0/7yC4/TZDcpaLgk204eoRsv1Cj2Mkc
 iCgt3QQOskA9BggCcHR1Nb9ZhLs9BFk4HmKNecO15vWqIYzALnD/LX7Sk2jP9bfycCj6 YQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dqhyktb34-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Jan 2022 19:31:29 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20LJV3qC124872;
        Fri, 21 Jan 2022 19:31:27 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by aserp3030.oracle.com with ESMTP id 3dqj06euwv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Jan 2022 19:31:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bUHWkT3UEsvqdlKZC6LnyixyibZJOOT/VTXriDWP94trcJjy0whK/vIYn+oeRhtsS89DrK78PMUfvire2WFjjMEh5kyhvzv0MO1ghpnCCgmkXebTMvb+ObFb3Hnfyo0Zh+Qqw8NUW8IJUXwjXuvvBg2JSxG+fKmqPAGB9yraB0plKZjdvkuYrnNwWZy4o/Ztqlt5udEgltUvTyOLeKlq2H55OK+mWBAO0ip93tRH+kKFAhRJKNs2/3t+Uw3kszOG4f5HJb/G5UcivND6lMtQls4U0MmQ5n5VUZkLZjLoPfxXW354Isda8kRhAFzASyDf/m+Sf6RkE+TiPGI2HfzPdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oNJbkagNi9gf9l7CGVVMW1gdll61bReY7gRf2VqyKLE=;
 b=BjhBGSU/NUcgjfF3AAJwbIqjQVm1uP7AtsO+/Gj7wR9IsX4zZyA4xMqw2084Ux5OoofbEz1mXvqbb0llZj51TnYkD8fNqssKF/3yDiouJoUdVtRBqbSMKwFDZvswfaVIeCn/+1jpIKAGfMM2l2DXqzAWGw0DczafN/ze3F4rfemVf4BYjP5vDnk1tgoNbsjJIdXPqMIKl09TO9FMNG9Ix7GOlPw97G8HRjGKZY7Yxk/JvRUu+Cy1YhqRTqBE6FPwTzDZN7nsj9RZsdYAoBpwEdPkhJy6br//hsCZeRlp/enWvwbZ0KJqcrnTg8jJcO9AW/GC0KI37MWSZKWDzUd/Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oNJbkagNi9gf9l7CGVVMW1gdll61bReY7gRf2VqyKLE=;
 b=f6yYrmK3SBYi7sKp27/PNTVNNS+Be2ltL0u42VGXnuhYe1H/9wW0Juu5g92yJrjUeYctWF4rDeMvEQGk/V40+Ds1QermQrzroJwfaQIPF0V2V5VkeyvREZQEt+cdW2cos6ew4bf7g2UaTtZv63KwhUTTOL8sQrmkBCf3W66EbXk=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BL0PR10MB2914.namprd10.prod.outlook.com (2603:10b6:208:79::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Fri, 21 Jan
 2022 19:31:25 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3857:3a25:3444:fdd3%5]) with mapi id 15.20.4909.012; Fri, 21 Jan 2022
 19:31:25 +0000
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
Subject: Re: [PATCH v4 26/66] mm/mmap: Reorganize munmap to use maple states
Thread-Topic: [PATCH v4 26/66] mm/mmap: Reorganize munmap to use maple states
Thread-Index: AQHX5r/tjgB33/Z9lUan012gbRJWW6xo4fiAgAVLc4A=
Date:   Fri, 21 Jan 2022 19:31:24 +0000
Message-ID: <20220121193117.mdwcfg22pphwjsub@revolver>
References: <20211201142918.921493-1-Liam.Howlett@oracle.com>
 <20211201142918.921493-27-Liam.Howlett@oracle.com>
 <e7476b15-d35e-8af0-24f2-9a7bbe082035@suse.cz>
In-Reply-To: <e7476b15-d35e-8af0-24f2-9a7bbe082035@suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bfd5209e-2405-4f80-6c62-08d9dd149cdb
x-ms-traffictypediagnostic: BL0PR10MB2914:EE_
x-microsoft-antispam-prvs: <BL0PR10MB29145DD606276ED2D51497A1FD5B9@BL0PR10MB2914.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yRD92wvtmnwyTd8ZtGANH/XkpO9rgN9WzGrpSUmzoccisWTgSaO4dltKh4qLOsa+/jBzfsgFNbfmcs+cPTuXkbHncUuraAmd0MCODeCRUXCqLZTD6RniOHxId0h1JXijdvW27t0MDSebDhjXuwMYAr3Hm147G20hNiPMZcKzgo2Ch+RwRcpaayKhtNYL0qZPgy06BU3xOo8znI+KCxvvYo/SaFtF4oxtZpqr87PaRR93NcySksdz+3+fsbBm6Kpj3Y0GpNS/Y48kyMO7nGMM7jis4WPbRkc9bqpLDxm1QaEU8ndHJ6tjNbI9ErJGGeAGvUf8fQNTfKfMMzsEDVyC0TcSXrvwlwnMT2E+F8d15lS0TwibqMBjvULmyFoGC4Wy6ZTOx7bXbMXWP103XSC1eVBHO8yIFRaTKhxR9IrOobmDAOat9mKy9TcpUDDsMVAfS4L/Y0WPEg57L8VVoyPyJ3fE2Uu7d0+oI4m1pP5voLZZosBZNFtOKSHPdcJujzTZP07a5dCNu98/6MMSz3j0+yidBergi4vXn/ibBXDI5WrKVxbj2incf4koJRENGKf7hzX0kZvKA0NPfksawiAQVPubV1lBE1gj5YfZ+KCFDiRU6VuQCyLwtTzYNzZZChxJtftm27ZZVebZoDw9Ui5dx33WJhh/Pzqlr7vKwnCw7HHiGJSDRCCjGiTP2M58CiaoJrUbiqi8kdZ4dSLY3jGFog==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(7416002)(6916009)(38070700005)(38100700002)(122000001)(83380400001)(30864003)(6512007)(9686003)(1076003)(2906002)(5660300002)(6486002)(54906003)(53546011)(4326008)(508600001)(76116006)(33716001)(64756008)(6506007)(71200400001)(91956017)(66446008)(66556008)(66476007)(66946007)(8676002)(8936002)(44832011)(316002)(186003)(26005)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NkWVqTPXCAv6tbj9L/VGlnXVxrfKnKS+rr5fynMONe7W4HhFIHn0jgkEYaTc?=
 =?us-ascii?Q?Et3TPceNb6m/YtBFjO3/0L5LJrguDmCTS6ET/NBjGBoTVMimH1jCR6R4zmvu?=
 =?us-ascii?Q?xwhkqsvconX983qXF7/3xSTph18OmMmvR15gnGY4UTB7YbhTA6Toyi5mrYiq?=
 =?us-ascii?Q?U2c3HgA559zKVWSIACZRDx7q4rDEG5sySq6qVxBOMQDHAjrP0AiZf3sgfX/u?=
 =?us-ascii?Q?WSNQnjDp1ZTTsiBSBhP4oNKDV4PpdTaMUV8JJxMbl47mM4hxbp4ubfLKBTaR?=
 =?us-ascii?Q?a/OAAKnwfgV980w544VNWaqje4bi0Gu7AwTwA+T6Qp99A/JKGbiVHTW4gopU?=
 =?us-ascii?Q?1qKTp6aHHeWp6rwSgQLWPbiESQUZKK6LX40jzV6gVAvTTmmWWK32/8LBO858?=
 =?us-ascii?Q?darkxOWZfxnAyTVf2Gp6aO58TLWhfQWPfuM2aEu0KzOlNfJvwHBdDe8xaEb/?=
 =?us-ascii?Q?tlwlb7VENcZw81WbYMljUoQl0D1YgCdadxQ736st6YwiTc5fVJp5r8/Ei16f?=
 =?us-ascii?Q?mxqkXn7N729t4tO8ksFX0hlIG695ewAQq2Qiz4cn9a+aq35XotE/Xe1154l0?=
 =?us-ascii?Q?+ZSVrr/CM2Xome1QIJllT3pCtIq5yzCvIUGXKe6W7YlfpcCH521nbp6k0DoX?=
 =?us-ascii?Q?jNdvxOXZMVW+0kuvnIl2pYbo6O+vDF7R1s6ygz517Tc/VNW7WP+sZ3KO5kDO?=
 =?us-ascii?Q?wUypKtJdh3AVCFX49lNYpou5mwaeqrlmYw5Jiv48g3z3WBbbQA1I28KnuN9c?=
 =?us-ascii?Q?cMEDh7zJu3HX5LDKHZAzSpcPNdM4xuPpSfF+zLAosDzYyLY4qhGciEKBKII3?=
 =?us-ascii?Q?QZj2OUNQ4hKbHo+WD6CaJIgp4F5DYDMpAL1Ks4wlWgKrplYpIWzjh15+Gvxl?=
 =?us-ascii?Q?mSoovb2fHdF9Qjqz5JHw2c5JtIpu26CJCoy3l580sNu/gLrC3w038GxaPcg1?=
 =?us-ascii?Q?va5NsEXtGnjNB9mI2cJi4loYQx95expQvicel/bKQVWUtkHe9lIetgmQCIm2?=
 =?us-ascii?Q?7S8rxWASdYKDihjJm4OBa7JC/RRotD7fRgZSe6ONeOnYXNVU29q5GfjPymLH?=
 =?us-ascii?Q?cxAXjxGBtdDEpKMU/NERA+BEUqW6zVC1u9+jNctzQKbNdM9GLRmjZpPo0o2b?=
 =?us-ascii?Q?N7cECxg4rY5W1Bt3QMs+LtM2rLntUUWsKJE+CCXtc5KztsxwWW41uEpgxWbq?=
 =?us-ascii?Q?1K8PWxTlJO/kCdHDlgHZotZdu7+Ad5CxPxRpKowyoqYhuk90aSiwh3BH3is2?=
 =?us-ascii?Q?4tUN9KO7MVX4H375ai3yjY47E52UBzzP5aGkv/C17jslOMQeggqqurRENx3q?=
 =?us-ascii?Q?6yjhqUjX/Z9RO5xAk7H0iGngo3h+t+9Lb8llegENbmTJUMN5Q68HKUOn8i6d?=
 =?us-ascii?Q?785ED0xAy5JJUajC/9PuCktjCQsXll3KCJmT1T3pFpnL0hKNg5JPzdFievm9?=
 =?us-ascii?Q?7kSdPRhywsKdDV5ZDriwQ/RLvETDCDwZEg3olhcx3GSAZ1vOndeOnpXND4/r?=
 =?us-ascii?Q?0dpa5HoEHovcU8PZFbyH0bc2L9INY6uGOiaH8+oDi2H6E4htEn46n60RDpn3?=
 =?us-ascii?Q?fwSBEiQF0kmCTAj/SF6Hc4ViTcytMQJLz1dEhfDibztcQ/m28HfXeFei8/Kc?=
 =?us-ascii?Q?KB7LdQSB18W+kkqYHB+HEDY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5BB9FA2F10F8EE46B0FFCE352200A23C@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfd5209e-2405-4f80-6c62-08d9dd149cdb
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2022 19:31:24.9096
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rmBFzYXVyND0SkVvTbgv87wJKn2Glpp4b0yUDjqVBnNaN/dlxE+cQHR/nVy+qPs+Szun2ZZaA6QDGcfwUjviFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB2914
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10234 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=999
 malwarescore=0 adultscore=0 suspectscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201210127
X-Proofpoint-ORIG-GUID: XGRPX0VUjlHfmo-UEO1_Lgz6gB1eyLuA
X-Proofpoint-GUID: XGRPX0VUjlHfmo-UEO1_Lgz6gB1eyLuA
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Vlastimil Babka <vbabka@suse.cz> [220118 05:40]:
> On 12/1/21 15:30, Liam Howlett wrote:
> > From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> >=20
> > Remove __do_munmap() in favour of do_munmap(), do_mas_munmap(), and
> > do_mas_align_munmap().
> >=20
> > do_munmap() is a wrapper to create a maple state for any callers that
> > have not been converted to the maple tree.
> >=20
> > do_mas_munmap() takes a maple state to mumap a range.  This is just a
> > small function which checks for error conditions and aligns the end of
> > the range.
> >=20
> > do_mas_align_munmap() uses the aligned range to mumap a range.
> > do_mas_align_munmap() starts with the first VMA in the range, then find=
s
> > the last VMA in the range.  Both start and end are split if necessary.
> > Then the VMAs are unlocked and removed from the linked list at the same
> > time.  Followed by a single tree operation of overwriting the area in
> > with a NULL.  Finally, the detached list is unmapped and freed.
> >=20
> > By reorganizing the munmap calls as outlined, it is now possible to
> > avoid extra work of aligning pre-aligned callers which are known to be
> > safe, avoid extra VMA lookups or tree walks for modifications.
> >=20
> > detach_vmas_to_be_unmapped() is no longer used, so drop this code.
> >=20
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
>=20
> <snip>
>=20
> > -/* Munmap is split into 2 main parts -- this part which finds
> > - * what needs doing, and the areas themselves, which do the
> > - * work.  This now handles partial unmappings.
> > - * Jeremy Fitzhardinge <jeremy@goop.org>
> > +/*
> > + * do_mas_align_munmap() - munmap the aligned region from @start to @e=
nd.
> > + * @mas: The maple_state, ideally set up to alter the correct tree loc=
ation.
> > + * @vma: The starting vm_area_struct
> > + * @mm: The mm_struct
> > + * @start: The aligned start address to munmap.
> > + * @end: The aligned end address to munmap.
> > + * @uf: The userfaultfd list_head
> > + * @downgrade: Set to true to attempt a downwrite of the mmap_sem
>=20
> s/downwrite/write downgrade/?

Yes, thanks.

>=20
> > + *
> > + * @mas must be locked before calling this function.  If @downgrade is=
 true,
> > + * check return code for potential release of the lock.
>=20
> How is 'mas' locked? The downgrade still calls  mmap_write_downgrade(mm).=
 It
> should say "mm's mmap_lock should be write locked" no?

yes, this comment should have been updated with the change to the
locking.  In fact, it should be clear that the lock must be held so I'll
drop this part of the comments entirely.

>=20
> >   */
> > -int __do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
> > -		struct list_head *uf, bool downgrade)
> > +static int
> > +do_mas_align_munmap(struct ma_state *mas, struct vm_area_struct *vma,
> > +		    struct mm_struct *mm, unsigned long start,
> > +		    unsigned long end, struct list_head *uf, bool downgrade)
> >  {
> > -	unsigned long end;
> > -	struct vm_area_struct *vma, *prev, *last;
> > -
> > -	if ((offset_in_page(start)) || start > TASK_SIZE || len > TASK_SIZE-s=
tart)
> > -		return -EINVAL;
> > -
> > -	len =3D PAGE_ALIGN(len);
> > -	end =3D start + len;
> > -	if (len =3D=3D 0)
> > -		return -EINVAL;
> > -
> > -	 /* arch_unmap() might do unmaps itself.  */
> > -	arch_unmap(mm, start, end);
> > -
> > -	/* Find the first overlapping VMA where start < vma->vm_end */
> > -	vma =3D find_vma_intersection(mm, start, end);
> > -	if (!vma)
> > -		return 0;
> > -	prev =3D vma->vm_prev;
> > +	struct vm_area_struct *prev, *last;
> >  	/* we have start < vma->vm_end  */
> > =20
> >  	/*
> > @@ -2458,16 +2418,26 @@ int __do_munmap(struct mm_struct *mm, unsigned =
long start, size_t len,
> >  		if (error)
> >  			return error;
> >  		prev =3D vma;
> > +		vma =3D __vma_next(mm, prev);
> > +		mas->index =3D start;
> > +		mas_reset(mas);
> > +	} else {
> > +		prev =3D vma->vm_prev;
> >  	}
> > =20
> > +	if (vma->vm_end >=3D end)
> > +		last =3D vma;
> > +	else
> > +		last =3D find_vma_intersection(mm, end - 1, end);
> > +
> >  	/* Does it split the last one? */
> > -	last =3D find_vma(mm, end);
> > -	if (last && end > last->vm_start) {
> > +	if (last && end < last->vm_end) {
> >  		int error =3D __split_vma(mm, last, end, 1);
> >  		if (error)
> >  			return error;
> > +		vma =3D __vma_next(mm, prev);
>=20
> Should be needed only if last =3D=3D vma?

Yes, it's safe but probably better to do if last =3D=3D vma.  This is to do
with the linked list so it eventually is removed entirely.

>=20
> > +		mas_reset(mas);
> >  	}
> > -	vma =3D __vma_next(mm, prev);
> > =20
> >  	if (unlikely(uf)) {
> >  		/*
> > @@ -2480,22 +2450,47 @@ int __do_munmap(struct mm_struct *mm, unsigned =
long start, size_t len,
> >  		 * failure that it's not worth optimizing it for.
> >  		 */
> >  		int error =3D userfaultfd_unmap_prep(vma, start, end, uf);
> > +
> >  		if (error)
> >  			return error;
> >  	}
> > =20
> >  	/*
> > -	 * unlock any mlock()ed ranges before detaching vmas
> > +	 * unlock any mlock()ed ranges before detaching vmas, count the numbe=
r
> > +	 * of VMAs to be dropped, and return the tail entry of the affected
> > +	 * area.
> >  	 */
> > -	if (mm->locked_vm)
> > -		unlock_range(vma, end);
> > +	mm->map_count -=3D unlock_range(vma, &last, end);
> > +	/* Drop removed area from the tree */
> > +	mas_store_gfp(mas, NULL, GFP_KERNEL);
> > =20
> > -	/* Detach vmas from the MM linked list and remove from the mm tree*/
> > -	if (!detach_vmas_to_be_unmapped(mm, vma, prev, end))
> > -		downgrade =3D false;
> > +	/* Detach vmas from the MM linked list */
> > +	vma->vm_prev =3D NULL;
> > +	if (prev)
> > +		prev->vm_next =3D last->vm_next;
> > +	else
> > +		mm->mmap =3D last->vm_next;
> > =20
> > -	if (downgrade)
> > -		mmap_write_downgrade(mm);
> > +	if (last->vm_next) {
> > +		last->vm_next->vm_prev =3D prev;
> > +		last->vm_next =3D NULL;
> > +	} else
> > +		mm->highest_vm_end =3D prev ? vm_end_gap(prev) : 0;
> > +
> > +	/*
> > +	 * Do not downgrade mmap_lock if we are next to VM_GROWSDOWN or
> > +	 * VM_GROWSUP VMA. Such VMAs can change their size under
> > +	 * down_read(mmap_lock) and collide with the VMA we are about to unma=
p.
> > +	 */
> > +	if (downgrade) {
> > +		if (last && (last->vm_flags & VM_GROWSDOWN))
> > +			downgrade =3D false;
> > +		else if (prev && (prev->vm_flags & VM_GROWSUP))
> > +			downgrade =3D false;
> > +		else {
> > +			mmap_write_downgrade(mm);
> > +		}
>=20
> remove { } brackets?

Yes, thanks.

>=20
> > +	}
> > =20
> >  	unmap_region(mm, vma, prev, start, end);
> > =20
> > @@ -2505,10 +2500,61 @@ int __do_munmap(struct mm_struct *mm, unsigned =
long start, size_t len,
> >  	return downgrade ? 1 : 0;
> >  }
> > =20
> > +/*
> > + * do_mas_munmap() - munmap a given range.
> > + * @mas: The maple state
> > + * @mm: The mm_struct
> > + * @start: The start address to munmap
> > + * @len: The length of the range to munmap
> > + * @uf: The userfaultfd list_head
> > + * @downgrade: set to true if the user wants to attempt to write_downg=
rade the
> > + * mmap_sem
> > + *
> > + * This function takes a @mas that is in the correct state to remove t=
he
> > + * mapping(s).  The @len will be aligned and any arch_unmap work will =
be
> > + * preformed.
> > + * @mas must be locked. @mas may be unlocked if @degraded is true.

This comment needs updating too.

> > + *
> > + * Returns: -EINVAL on failure, 1 on success and unlock, 0 otherwise.
> > + */
> > +int do_mas_munmap(struct ma_state *mas, struct mm_struct *mm,
> > +		  unsigned long start, size_t len, struct list_head *uf,
> > +		  bool downgrade)
> > +{
> > +	unsigned long end;
> > +	struct vm_area_struct *vma;
> > +
> > +	if ((offset_in_page(start)) || start > TASK_SIZE || len > TASK_SIZE-s=
tart)
> > +		return -EINVAL;
> > +
> > +	end =3D start + PAGE_ALIGN(len);
> > +	if (end =3D=3D start)
> > +		return -EINVAL;
> > +
> > +	 /* arch_unmap() might do unmaps itself.  */
> > +	arch_unmap(mm, start, end);
> > +
> > +	/* Find the first overlapping VMA */
> > +	vma =3D mas_find(mas, end - 1);
> > +	if (!vma)
> > +		return 0;
> > +
> > +	mas->last =3D end - 1;
>=20
> Why not set this before mas_find() above? Hm but that takes its own secon=
d
> parameter instead of looking at mas->last. To be honest, I'm a bit confus=
ed
> wrt the role of mas->last in the API. Perhaps another suggestion for the
> "how to improve docs" discussion earlier. Or maybe I just missed/forgot i=
t.

Hmm, maybe the doc doesn't specifically say what it is but the header
does:

unsigned long last;             /* The last index we're operating on -
range end */

I'll have a look at the documentation to make sure it's more clear.


mas->index and mas->last represents the range.  If you walk to an entry
then mas->index is set to the start address and mas->last is the
inclusive end of that entry.  I set mas->last because we need to munmap
from the first overlapping VMA to the end of the range, but there may be
more than one VMA which would mean mas->last is less than end - 1 at
this point.

>=20
> > +	return do_mas_align_munmap(mas, vma, mm, start, end, uf, downgrade);
> > +}
> > +
>=20
> <snip>
>=20
> > diff --git a/mm/mremap.c b/mm/mremap.c
> > index 002eec83e91e..b09e107cd18b 100644
> > --- a/mm/mremap.c
> > +++ b/mm/mremap.c
> > @@ -978,20 +978,23 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsi=
gned long, old_len,
> >  	/*
> >  	 * Always allow a shrinking remap: that just unmaps
> >  	 * the unnecessary pages..
> > -	 * __do_munmap does all the needed commit accounting, and
> > +	 * do_mas_munmap does all the needed commit accounting, and
> >  	 * downgrades mmap_lock to read if so directed.
> >  	 */
> >  	if (old_len >=3D new_len) {
> >  		int retval;
> > +		MA_STATE(mas, &mm->mm_mt, addr + new_len, addr + new_len);
> > =20
> > -		retval =3D __do_munmap(mm, addr+new_len, old_len - new_len,
> > -				  &uf_unmap, true);
> > -		if (retval < 0 && old_len !=3D new_len) {
> > -			ret =3D retval;
> > -			goto out;
> > +		retval =3D do_mas_munmap(&mas, mm, addr + new_len,
> > +				       old_len - new_len, &uf_unmap, true);
> >  		/* Returning 1 indicates mmap_lock is downgraded to read. */
> > -		} else if (retval =3D=3D 1)
> > +		if (retval =3D=3D 1) {
> >  			downgraded =3D true;
> > +		} else if (retval < 0 && old_len !=3D new_len) {
> > +			ret =3D retval;
> > +			goto out;
> > +		}
> > +
> >  		ret =3D addr;
> >  		goto out;
> >  	}
> > @@ -1006,7 +1009,7 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsi=
gned long, old_len,
> >  	}
> > =20
> >  	/* old_len exactly to the end of the area..
> > -	 */
> > +	*/
>=20
> Spurious edit?
>=20

Ack

> >  	if (old_len =3D=3D vma->vm_end - addr) {
> >  		/* can we just expand the current mapping? */
> >  		if (vma_expandable(vma, new_len - old_len)) {
> > @@ -1048,9 +1051,9 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsi=
gned long, old_len,
> >  			map_flags |=3D MAP_SHARED;
> > =20
> >  		new_addr =3D get_unmapped_area(vma->vm_file, 0, new_len,
> > -					vma->vm_pgoff +
> > -					((addr - vma->vm_start) >> PAGE_SHIFT),
> > -					map_flags);
> > +					     vma->vm_pgoff +
> > +					     ((addr - vma->vm_start) >> PAGE_SHIFT),
> > +					     map_flags);
>=20
> And this?

Ack

>=20
> >  		if (IS_ERR_VALUE(new_addr)) {
> >  			ret =3D new_addr;
> >  			goto out;
>=20
> =
