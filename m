Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 655F74D1CBC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 17:06:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348067AbiCHQHH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 11:07:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230462AbiCHQHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 11:07:05 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E1FA5007F
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 08:06:08 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 228FxDS2009809;
        Tue, 8 Mar 2022 16:06:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=kbuNcMMErxCUhnd1eLJtrZ+tmOQFuSlLwLx8YCDXOJM=;
 b=DTQSbkngDtEwmbYyPLRJR8ZEbWx2PxhA7KfKPddQ5waPQvGPSvvLbNY2dfqWFacIdPR7
 /40IarQESYJUf/4HwroFKXbh5FKHtd21r+7kFR17fOqY1u5hJepx3TBlQ/sQ0KOgijqE
 XpgHlqcOi4ZKETdOEEZ/TlXmhGPEYdN22r/7u3H5XxH09UJ/BGY+1l3s/rtyeq+Hn1JK
 gSjxGecx6s3Dwff1/vEvdzGBjM7X2VVheOqLVrAINPdN+fNedrTdMdh3KwAH6G0OI7Rt
 NpxXo5LUtSjqsqSnr38Kbz0KPbnVZ8UJcA1FNnybMRKVualeKmTyayJbiPVKxFTfWLtN zA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ekx9cfayn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Mar 2022 16:06:02 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 228G0hXd072089;
        Tue, 8 Mar 2022 16:06:01 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by userp3020.oracle.com with ESMTP id 3envvknd3h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Mar 2022 16:06:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XD81RVwHu/5egdeuTcEmdbPGLlBeaFlrqztzLpRVU4A5eEqWUX+D5DE2DFvdBeaKs+p6k4XEpFzdjUvgYVYMjWK0A3IDlOF75nRfjHBnNR8fEoBNWAtl5QsQa7Cm6Lf3MDaAMNR3ucE/zQPjGJWD/nKzh3iOUlbx2Ulrmm3cT9+eku7iOjsbkmm0+DjOvlOZRU+s2adFDtnYz81XyxH/SlkUpOq9wKAgiA8Z0JndohU0atD54ZF3phK+DD4AOagv/wtDJHPqCgNK7vzISGYfzLsWDxvHxYY9rojVyFGvXX0yuGG4ry9SWOEVv0t87718ofgFfEv410m8c+4YSr4KQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kbuNcMMErxCUhnd1eLJtrZ+tmOQFuSlLwLx8YCDXOJM=;
 b=iV6Nl4DbRXHZML33uxcybb7tpvPLq23Yz7q+YzDs4Cp3ioQBTWq9p/ZoUn2+IFeLlCUHBKuhR/a8OgLWrExy3fFjBpC81bNYbXXYnYememXrBctmUYe0FZQZHIeFgSSlGSSgX5+sTaRQHph4VVi7XwZtYMfyDdFHA3b9+jWJGv8LlmginPed7uPUthRSyVc83vnDPWij439i2rX9fPL8ySuMOQqXzQGqSAjUV/Ij7nHzmH2Ra67uCCvd1pvhwIB/UDDmJnBN17rhclnemWc4D5d5Ev6aJDT8xDOuQZ5h3LKjmdVB5pyoMAyTh5cQ0zCYBT6s0UjOK+fUhGA3eOrrtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kbuNcMMErxCUhnd1eLJtrZ+tmOQFuSlLwLx8YCDXOJM=;
 b=hFcS9mMUZg4d+zsi/BX0XxPinuThmku2qvJcPOHDApjokGIF27BCYTVeH4G+F/1d4wN0R77PMieXb2ZypXGVjW5ZAUTeZ804VRWTZJW5Am8jMDAv2JHfj4/6mIFqOHyOyRGmGXnRYJhbhyGMg4pRF1SvZmS19yMopk8r6InbkDc=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM5PR10MB1513.namprd10.prod.outlook.com (2603:10b6:3:12::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.16; Tue, 8 Mar
 2022 16:05:59 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8df4:1db9:57f2:a96a]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8df4:1db9:57f2:a96a%3]) with mapi id 15.20.5038.027; Tue, 8 Mar 2022
 16:05:59 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Hugh Dickins <hughd@google.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH mmotm] mempolicy: mbind_range() set_policy() after
 vma_merge()
Thread-Topic: [PATCH mmotm] mempolicy: mbind_range() set_policy() after
 vma_merge()
Thread-Index: AQHYL4FzWFkyFnZUSku+xBH1UQyT+KyvkiKAgAAEfoCAAD4yAIAANciAgAAH1YCABZtSAA==
Date:   Tue, 8 Mar 2022 16:05:58 +0000
Message-ID: <20220308160552.d3dlcaclkqnlkzzj@revolver>
References: <319e4db9-64ae-4bca-92f0-ade85d342ff@google.com>
 <20220304184927.vkq6ewn6uqtcesma@revolver>
 <20220304190531.6giqbnnaka4xhovx@revolver>
 <6038ebc2-bc88-497d-a3f3-5936726fb023@google.com>
 <20220305020021.qmwg5dkham4lyz6v@revolver>
 <29eac73-4f94-1688-3834-8bd6687a18@google.com>
In-Reply-To: <29eac73-4f94-1688-3834-8bd6687a18@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5159c080-0626-457b-87dd-08da011d88ff
x-ms-traffictypediagnostic: DM5PR10MB1513:EE_
x-microsoft-antispam-prvs: <DM5PR10MB1513A80FAD8B280A71D97C83FD099@DM5PR10MB1513.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Rke83g/2QX1hWaPHcuxPy6+ND9NGjIZnWW2eXW0CjjbzJoqsuWgA1tUnUGKeU6K2UGgLjr+Hnebw8eG7/weS6fXHJD0JdsK0FiUCyconvc9wb6b3BQL7+6OLB6oNWLez6NPHMRmTzTtuyP69JIUL6MNF7lwrMBiLJZtFcFnoqxLG5yRngomKdUVJGDQXjzxGtXqEMrFw8UCdO7Nu6XPvpgkX/cUnTy2MTpJA2xm4IWlMdGeYH9vpaJEblX8AgyjHYYT7RMvMcNaB9VyAfcxD9sEqHOmCj8PWsGwoRAbQiw1US+p4q2ziibhPa3Pr9F0h5A08SPlJoaEN2EqpuaJKew28fm0C97ygwIDonum0HJvz0hvQdvnM1EFCsGo+aU7/eT/f6sl4aPj1KZdSrYmlL3DVi7lWPPTpa7QqfuMW9TRwfuR0b8uSSuSvhMNc7L78nMHfcPxF4EvWekbSuWyaxm0I915zWqj7YbbbONzXWdvUI0fN5ErrbbSgDCehAPOY93jdLNGbWq2y5GuVQmZ/ScmQdr59483UJ+Xf/FG78l8ntX0hWVIEGSwtoO8623XAqwd6EzYL4nsJCo5QGITsdVqBTZpZgYwG3VScWcJklnKNGjmQCTIvWfYPZAYRK90mpN7wCj605qZF4cJdXVmOhGmxHEPiqLmYn3++0VbUipoJxXqsLeiAqmt4uJ8D+wVBywfmOTc/zg7iEP0OCuLTicKiv8m7iUOtwWSzOyfrOqJQ1ipqbEqAwNiV1wP50Kpd
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(44832011)(5660300002)(66446008)(8676002)(64756008)(66476007)(66556008)(66946007)(91956017)(76116006)(2906002)(4326008)(316002)(6916009)(8936002)(54906003)(38100700002)(122000001)(186003)(86362001)(38070700005)(508600001)(6486002)(33716001)(71200400001)(6512007)(6506007)(9686003)(26005)(83380400001)(1076003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jLDRpf4wak5G3Eq4Pz9kRR/k3ebDjl3uvebqQZbRNU1EWLfOt+lPwvxAJvxe?=
 =?us-ascii?Q?fi4CGvQRvN+/3UJaGN+p4GiDkRGPlNeEddlk1KzK9Qv+CsigfZanNueCD9Qz?=
 =?us-ascii?Q?UhXPShvabQtiPeWnosaNtVJxlen4amst5EbV+UbVzLhCU7xG5n7rpT0XlLHr?=
 =?us-ascii?Q?4mUJIPFE3fORXrSgkp3te5EZy0Qa6+bsK7JcNprv95ElmhBgv0QyqW8keG54?=
 =?us-ascii?Q?ZXXatDssWgYHXAuoGWNyYORdzoe0SWfQ7Ijd/PIyRKrgp1dwRQ0Uv/a06vpF?=
 =?us-ascii?Q?cM0PPfJskGKCEXni03PP40RX7VFQmRlQVf8UaRQBLlCXuRpaBpL+FkqJjcfn?=
 =?us-ascii?Q?hHgRhceZRtVodcO38w+V5aPl0HEVR6d/tw0SH2VWFl+1qY39Dr+i9QSQzq7o?=
 =?us-ascii?Q?txHie71s3Ve/9OXupNDsDrD2+Jy4v2F4U6rHOiJeCb1+HtXGGyfXGkGQBjt8?=
 =?us-ascii?Q?SQE9P6DNQhKNoE8EqqGCkkQ8Jer04ao6J0K1m9zYan23IfqynXjJmwnwkj+P?=
 =?us-ascii?Q?kmtMqOg2VwwT5bkNB4f9kzRTvm+wrTPUVLQ+86hP7wvKs5yPPRiSLMKMml/v?=
 =?us-ascii?Q?VisC6eQHTll8lrnHbhcsBzpIbs4OJ+tYgZJH3qYHkXT4qOqfv1Cvctq/ml2E?=
 =?us-ascii?Q?ag0rMxq/wvUKfXfELGWk9LrAgfviHLQIbsCiMSYFt8OtL1TJRotuTaTncPpb?=
 =?us-ascii?Q?89UTjr1OAmrdCquRKjEIOnmFgJn3vQbWynzv0xPYDudeWxrKnI0lWOU1Asra?=
 =?us-ascii?Q?BCHjYbDAIa+lZkKf6oJdHKumNPUUOzzKkGKcFEfu+SojwgopC8mpY5jwlv5z?=
 =?us-ascii?Q?3AnVVuBaqcfkNh4tJqEgGWwdlJb74vP2/sLRfrO971mX/pQATj+5DvRHXHEi?=
 =?us-ascii?Q?FlWhuZd7D70iF84/cVBDVXuG1l6iBT7FsPgzYXd+Ak+ZgvceL4VHNpCwT6NH?=
 =?us-ascii?Q?SrHWdMFlcv9OkrYR7R4mxLnmslpd1vqEaEq0rf3Zgu1m9pbsAB2nF11lJ7BD?=
 =?us-ascii?Q?+wDHXzCvQOZvO1EtaudFdJYSTZb4yHrJ/X2k2QXFj5NiUDDfkHg0RTDVE+Ys?=
 =?us-ascii?Q?yMjxSYUWUjkZ78m6OosEdKKAyQsjcYJqfrOKG6Fzdzh8X/e8qflRq5Qb0wfN?=
 =?us-ascii?Q?l4RcBETBVDBwGHbbsVZQlD2Q1S5s14gxv1ZlSQgX+oWSEsv4FW6954NX8j7w?=
 =?us-ascii?Q?n/TSBkB+zWJMJ7PPsQ5YWkKk6MvSGlJxkvhC4QZ09jKAGg+36NZaS8ICxJeF?=
 =?us-ascii?Q?43t30f9VQIa+ALZN19FQfhk9HbQm/d4grvCO2fExWhTpQhlxUfwUworLrlCS?=
 =?us-ascii?Q?XXqvRscaka2wgXQzHgsqWRV8jUNDX4drt7Ly4BOFmq35QOvZbSCJC/iNwQf0?=
 =?us-ascii?Q?JNKIAuilnuSPzvPu4aNVc4KW35N6TDJdQFZM+aZhTlsexyDqrntPQOwyBAUG?=
 =?us-ascii?Q?ZOB8CS2uqeBYvNKb55mEs8Sr4K2qARlI0iethgoswfeVGqqs5qzimDXxUkaj?=
 =?us-ascii?Q?GMjHv6c329ygX3H4Mg7tI0n4a7UyqmXg4s0OcPaP563BBwEBNoBA33diVzzv?=
 =?us-ascii?Q?OxsY8aK3/UphlGMk00yt1wIVs8iYBbtB/lcss4kLzE4Jeut0k3MaZ49y+um3?=
 =?us-ascii?Q?ZhIOC1gfgU3RYM8STcAOiGQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2517C979A809384AB2F27ACB982B5EF2@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5159c080-0626-457b-87dd-08da011d88ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2022 16:05:58.9223
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NFAMjxZhc3KAKBt/gB+FFpNmfSEOxkX7zMt11pWZQS8K24fbDJxtgZ9ZsMMWoy6egBHRM4VH4KKhFPseWgOadA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1513
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10280 signatures=690848
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=822 bulkscore=0
 phishscore=0 malwarescore=0 suspectscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203080086
X-Proofpoint-ORIG-GUID: CJE6nYl3hX8Pf26gg33HY6D7K7aNEnK6
X-Proofpoint-GUID: CJE6nYl3hX8Pf26gg33HY6D7K7aNEnK6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Hugh Dickins <hughd@google.com> [220304 21:29]:
> On Sat, 5 Mar 2022, Liam Howlett wrote:
> > * Hugh Dickins <hughd@google.com> [220304 17:48]:
> > > On Fri, 4 Mar 2022, Liam Howlett wrote:
> > > > * Liam R. Howlett <Liam.Howlett@Oracle.com> [220304 13:49]:
> > > > > * Hugh Dickins <hughd@google.com> [220303 23:36]:
> > > >=20
> > > > I just thought of something after my initial email
> > > >=20
> > > > How does the ->set_policy() requirement on tmpfs play out for the
> > > > mpol_equal() check earlier in that for loop?
> > >=20
> > > It took me a while to page all this back in (and remind myself of
> > > what is case 8) to answer that question!
> > >=20
> > > The answer is that the mpol_equal() check at the top of the loop is o=
n
> > > an existing, unmodified vma; so it's right to assume that any necessa=
ry
> > > set_policy() has already been done.
> > >=20
> > > Whereas the mpol_equal() check being removed in this patch, is being
> > > done on a vma which may have just been extended to cover a greater ra=
nge:
> > > so although the relevant set_policy() may have already been done on a=
 part
> > > of its range, there is now another part which needs the policy applie=
d.
> >=20
> > Doesn't the policy get checked during vma_merge()?  Specifically the
> > mpol_equal(policy, vma_policy(next)) check?
>=20
> Sorry, I'm reduced to the unhelpful reply of "Yes. So?"
>=20
> If vma_merge() finds that vma's new_pol allows it to be merged with prev,
> that still requires mbind_range() (or its call to vma_replace_policy())
> to set_policy() on prev (now assigned to vma), to apply that new_pol to
> the extension of prev - vma_merge() would have checked mpol_equal(),
> but would not have done the set_policy().

I must be missing something.  If mpol_equal() isn't sufficient to ensure
we don't need to set_policy(), then why are the other vma_merge() cases
okay - such as madvise_update_vma() and mlock_fixup()?  Won't the mem
policy change in the same way in these cases?

Thanks,
Liam
