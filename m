Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7965F4D576B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 02:35:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345384AbiCKBgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 20:36:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345332AbiCKBf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 20:35:59 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C5A18A799
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 17:34:56 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22B0Iakh032732;
        Fri, 11 Mar 2022 01:34:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=oulgMJnNc/9q8/horExKUgsS+XbvCikCNHonhGRc6kw=;
 b=XUFzIBVQv01n/Tsl4jP6JtDUYTYu10A56k1WZJNvQekzF6oaPNbSu0wdGy/x1hMecsqg
 KOPQ1Ed7+aExMvl2+/PjDocJSkELLuYBeHTWUygSJU/9hFci2lEBPmDYMXpYf4M4ylWG
 kpQhFYIqz6Gs31vJ/sLaTSTZ3PU9eyExaSYrspHnJ35uuQGrAGc8b/OA9yjJEq6ZboJ9
 EWm43zdR2qKUgVXNl0QGE+mDmNkB8PdzP0MZW26NMKFEbtz7A+ifbLEOnuc6Y/Eiw2Cp
 DbSwUTsDR8r5FzwtXqvG8EDYORFtWyQ2JD7Zls3NvkCzACqTer0lyrj8mOAmLKO60UQM 1g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ekxn2q5c7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Mar 2022 01:34:29 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22B1FnYC059976;
        Fri, 11 Mar 2022 01:34:28 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2045.outbound.protection.outlook.com [104.47.56.45])
        by aserp3030.oracle.com with ESMTP id 3ekwwds00h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Mar 2022 01:34:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fIz5cttzwjLzwwcakY2FPe+r97r3xbvH2vFPu1AWAPW9qLf8IaQjM4SMHX/be/7euF83PYwJ8wR5S8JIF882tUfEwkOnFhU4y15FQy/X6k25lq65lK9mEvjTednXkEK3tjc77tj1AwZ8bzq9f5EzeQ8xU9ucikXz/3wuHnucq+uhOGIOdvju1fsUm8vEoSWkElfHhYoyz/UKZSbPogqOhjuvgk5oku9pmMzxG2rXt5wI3LNYbZpoPWCbL3g78/qJ9HEEkwNCv4n5Jbd2DjtSFKLrAWtU3p+mclm16k4X1cgCSnNRIPdgxJkuQvAk+QLIA/RVObY9T4c2emQ6EqRKmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oulgMJnNc/9q8/horExKUgsS+XbvCikCNHonhGRc6kw=;
 b=jYsKwtjPbFJOO3ixW6+sjnZ2VRvgf2ySaizhCvv+RXMGbQCXlx+fkl16ypGYAWp2qeAtgXxeJUkaxatvAfthCAh/A8OnjR1YYo03pdbehyJodNIiuCAeeYl17Lrg9VUkudbIu0w0PlV/jCS2kCh6GClZGdRkM8UBBXkmWwu5w7Mba9GGsMYN+Mz0wZzgzCZj+6cZiIsW2sp2yHL0wa0+31SSgTAV6KzBnD6k9s5jgSU2p5jiGGR5/ej6/kR1PSW9Pr55AgKCLdpZ9VfEcq7Iav4F9efY3YhDKPKtJYYJXjwpy1MeOusaAqx2heAf+5sHX+pOUivgDjrtotNhq5bPfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oulgMJnNc/9q8/horExKUgsS+XbvCikCNHonhGRc6kw=;
 b=h8H7IdeBDHEC4ecEwlRkAkqdFuWaqfICvcF2hcec0WK3OdYrFtMP6/ijeZP+MhXnmVh+Cg67tMXDpmLZIstN4lrMzZbv/yy2vpkVtGf6MO+vZg3LQCEWVMAoF07DkFihEBssrYfpopuJQJj/hbH8B+SSISwpwp0sBLYPFADT7DE=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SA2PR10MB4505.namprd10.prod.outlook.com (2603:10b6:806:112::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Fri, 11 Mar
 2022 01:34:26 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8df4:1db9:57f2:a96a]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8df4:1db9:57f2:a96a%3]) with mapi id 15.20.5038.027; Fri, 11 Mar 2022
 01:34:26 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Suren Baghdasaryan <surenb@google.com>
CC:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "mhocko@suse.com" <mhocko@suse.com>,
        "shy828301@gmail.com" <shy828301@gmail.com>,
        "rientjes@google.com" <rientjes@google.com>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "guro@fb.com" <guro@fb.com>, "riel@surriel.com" <riel@surriel.com>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "kirill@shutemov.name" <kirill@shutemov.name>,
        "aarcange@redhat.com" <aarcange@redhat.com>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "christian@brauner.io" <christian@brauner.io>,
        "hch@infradead.org" <hch@infradead.org>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "david@redhat.com" <david@redhat.com>,
        "jannh@google.com" <jannh@google.com>,
        "shakeelb@google.com" <shakeelb@google.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "christian.brauner@ubuntu.com" <christian.brauner@ubuntu.com>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "jengelh@inai.de" <jengelh@inai.de>,
        "timmurray@google.com" <timmurray@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-team@android.com" <kernel-team@android.com>,
        "syzbot+2ccf63a4bd07cf39cab0@syzkaller.appspotmail.com" 
        <syzbot+2ccf63a4bd07cf39cab0@syzkaller.appspotmail.com>
Subject: Re: [PATCH 1/1] mm: fix use-after-free bug when mm->mmap is reused
 after being freed
Thread-Topic: [PATCH 1/1] mm: fix use-after-free bug when mm->mmap is reused
 after being freed
Thread-Index: AQHYIqlYsobTZLgdX0GF48T/8G2rKqyjuEyAgAABMACAABh/AIAVFxAAgAAJZ4CAAGLHAIAAE0UAgAAidgA=
Date:   Fri, 11 Mar 2022 01:34:26 +0000
Message-ID: <20220311013212.elje3fqgdob4mnum@revolver>
References: <20220215201922.1908156-1-surenb@google.com>
 <20220224201859.a38299b6c9d52cb51e6738ea@linux-foundation.org>
 <YhhZsv+czqQPKvvN@casper.infradead.org>
 <CAJuCfpEUro2jxmx-AB2A-mVcNxz6s3oAyow1sEXY5RyPP+83dA@mail.gmail.com>
 <20220310155454.g6lt54yxel3ixnp3@revolver>
 <CAJuCfpHk+1snrPx-_qvj=kjSOS+o=L90evAQ1gD5hj6XxB=a3g@mail.gmail.com>
 <20220310222206.dttvvlgfqysrcl2s@revolver>
 <CAJuCfpHoMtJdJgXCs45Oi=BUFWVcw76J5Kk-6_1ZuXVvZM_vpA@mail.gmail.com>
In-Reply-To: <CAJuCfpHoMtJdJgXCs45Oi=BUFWVcw76J5Kk-6_1ZuXVvZM_vpA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6d84ba1b-a360-479f-21ef-08da02ff4782
x-ms-traffictypediagnostic: SA2PR10MB4505:EE_
x-microsoft-antispam-prvs: <SA2PR10MB4505C8F1BF49350A1ED1D077FD0C9@SA2PR10MB4505.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4ZsNRYnw6Zl+FBG8JbAXH2B0iUFQumDAPBJeVRpxGQDBMfignFRlX/STF9vGSanT7S/kFIQVH/hPhrhspsgdqJzlgHLtT9NCwm5M77D9fH8r7hu7Ihfmv0U6g9Dvku8srGbkjXFQgJl6r/F9BNlgwk1UN/FG8iggwaENHVGYakrPf6BN94HW6VPVfAkSbsb05FQMHYEdIqAGLbCy7WWXYNbihClOTs8c4BKYYmooNQ1gfQ8vvNyzPrJ9IzJmz1GE+RUZwZzAHljz8DfPgbeEe7tnGeMFeOMl4zN44J5gfgFTf4ssD0+W9H1czLOG7pwApTibTGvu3kzR6npWQ1fCrR6Ed/V7Maha75vzhULgm7/1rYej2kVCGOgs8fGCiim2lxN8xHwlHlsx70INvzw46g4mXAF86rc/kljmikBLtXryhPtmIk0OtId5xDK04rqO+fBSB049koOsgEfEQfdrhlzwNcOmOIW+g4PVv/1OPMv8Lv+jceilSmTRcpdOklS4KJeSrJugaG/fnHUYs5sR4IJ+12d+0DHNxr2o63MWVjJoF9nBlI2w9tFUrKRjU3E36R4GjY/E8/Xwgf5rWjuoaCQbGxM5WDeCKPHcZa/EfQ6hSWVvwe2/ovQxVodiq9LRvsI+cCZDbNBDW+ytOo5LthGdShfszhyYCQITkLEzt4MfYr5QYPjjVtxWRhLa/a26jo6a7eVRd6DCCPp3AE8mUA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(186003)(38070700005)(66946007)(33716001)(38100700002)(2906002)(6512007)(26005)(54906003)(6506007)(1076003)(53546011)(9686003)(71200400001)(44832011)(6916009)(86362001)(6486002)(91956017)(7416002)(508600001)(66556008)(66446008)(8676002)(66476007)(316002)(4326008)(76116006)(122000001)(8936002)(83380400001)(64756008)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LAGiiu5o/nUeXrjeW4YL33j4j5jGYoeLkrkvTBqyaGpKg9B9lRMnUi4WiGpg?=
 =?us-ascii?Q?4g3HKOwVm76kx/ajUXGM9XQkQiRmcACuZJZgM/1Nr61MKmNDA0W+p9borDHk?=
 =?us-ascii?Q?K6aL9Z7R0UA/gTaniZjdavskKYj+SSkv2k26oKiRkBz26VDV/eBfQhtnvZN+?=
 =?us-ascii?Q?KotP7Zc0fhqoTQNe7gyXH1RlVLRx46RHgNaqvnGkKBujlfp4InutVt2sfRQ2?=
 =?us-ascii?Q?X47lyjQSVLZTx8PLYmw3qnyT3WzmKxXhrvRhohoRCBG5BlIWGntLDIvCvf7h?=
 =?us-ascii?Q?wyGIGm6ZorwcWl1U1fvZ5/TRKroQqnNTdfh2NBVzu5I8gr1UC3OqvJX2jo9Z?=
 =?us-ascii?Q?gFzcSu432rrt4XxJsOfCcTZGc4Vpm9hGyy37jQ28AoRLftuEmwJ759ccm4Hx?=
 =?us-ascii?Q?8BfxbEqKCVaqZrAjcmGjGC/9mABpiIkRtUcwsFsGnzTdn+8QNozxa2yv3SMz?=
 =?us-ascii?Q?zSqnxK6pQfQbT2Ub+zQcFNXxY0gDDS4B3ljRlGwP4jYn9JQorCX7yIR37SI+?=
 =?us-ascii?Q?7OKzUxnIgIUKVxfOjFydzA0eESpIOlN8i1EPGMIaHWSlY7n6NNpk2CqcM3yC?=
 =?us-ascii?Q?UP6w8BpvVAo6nbGY3vxKX3jNWrEGR/deeGmbaLzr/VdZSBHeEIUhDyuMO3rn?=
 =?us-ascii?Q?C1rDuEeDhosKP+JIHxZINOdMn2JF/GTAac+zS7jDE0ps1XKkGWOyK8cBd78D?=
 =?us-ascii?Q?xuGrWDEK0lmVxoqFiRAPW86WCtniVBXO/43mREcumLG7fsaBWNDgcYWKHpOA?=
 =?us-ascii?Q?sKa1x21uP34UnuFzeV55Lz/h0MBTxZa1r1vw7cHs9caOX6npEr/FiD05Ee1f?=
 =?us-ascii?Q?VXsOxhmkRkqqKQ9nMOxnLhanNAnU4R8oizRElkt0MfZDUbLopYOf6ovSXl0c?=
 =?us-ascii?Q?hPYHdfGM1ndiBKHMGIsnAMPIG72xMuKfhUqvZgWDuvE0Uv4RY12VJyKKeGvl?=
 =?us-ascii?Q?xuzOP7+YZrpYEErZrmByDc5CIKDzFsk5biquu8/OkoHtvwXDvwgPgrxKafa7?=
 =?us-ascii?Q?V60oCNeooXJRvvv36J5x4VXnaJktqK7HNVQ/wdt/R86Pg51sqQ3qu4MPZOHD?=
 =?us-ascii?Q?mZrVnrctHpVhYkMv6YQ2Seqff6oevm+WPPV3k5uUlFao8yUylh/4E7px/oRQ?=
 =?us-ascii?Q?CGAP8IlJbBs4TVbrt2KblCky4cnfzxHCCGeTLU3jDXuCbNRgwp+q8VFBUkvE?=
 =?us-ascii?Q?ofT5ckRdSEp2i1p/JkdQ+z3DgRhuhOSAPB36kpwKoltAIN0/jdzmjGxJm8L7?=
 =?us-ascii?Q?BNXZR9/oG4Ugj/aWSX8DtCtpaFuB2izygIue9l/VBLXbQRCvnWszh2dNsqi1?=
 =?us-ascii?Q?tXhBYqzC/tssC5xWicDp9JjbGsq3cZrkd93Q0GE0DpMCI83cbXqKcOv9h5aR?=
 =?us-ascii?Q?TwhhBKVs/SflT0/CCocwsWVd1/P38zWuzJTXdp/Jz9iTbX70QR0N1TX+BspL?=
 =?us-ascii?Q?lMerLv3E1yfTQvZYp+6HqmxGxWqCktt2HCf7UThqRFWgW/CY+jkhMw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <377041B47F8A8D44ABA70B8C7950CCE6@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d84ba1b-a360-479f-21ef-08da02ff4782
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2022 01:34:26.5192
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bNmZrjdP0Wm163vkNiHoSOXQ5N8xMCckdITCdP3SDEHrJhXTvv0H9L6/Q/2WxxLIBHoYYfGk+0EVldmDAzfLbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4505
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10282 signatures=692556
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 phishscore=0 bulkscore=0 adultscore=0 malwarescore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203110005
X-Proofpoint-ORIG-GUID: 7ZKuJwSrbtCLiCe6yJMdvzoLPVClzBmQ
X-Proofpoint-GUID: 7ZKuJwSrbtCLiCe6yJMdvzoLPVClzBmQ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Suren Baghdasaryan <surenb@google.com> [220310 18:31]:
> On Thu, Mar 10, 2022 at 2:22 PM Liam Howlett <liam.howlett@oracle.com> wr=
ote:
> >
> > * Suren Baghdasaryan <surenb@google.com> [220310 11:28]:
> > > On Thu, Mar 10, 2022 at 7:55 AM Liam Howlett <liam.howlett@oracle.com=
> wrote:
> > > >
> > > > * Suren Baghdasaryan <surenb@google.com> [220225 00:51]:
> > > > > On Thu, Feb 24, 2022 at 8:23 PM Matthew Wilcox <willy@infradead.o=
rg> wrote:
> > > > > >
> > > > > > On Thu, Feb 24, 2022 at 08:18:59PM -0800, Andrew Morton wrote:
> > > > > > > On Tue, 15 Feb 2022 12:19:22 -0800 Suren Baghdasaryan <surenb=
@google.com> wrote:
> > > > > > >
> > > > > > > > After exit_mmap frees all vmas in the mm, mm->mmap needs to=
 be reset,
> > > > > > > > otherwise it points to a vma that was freed and when reused=
 leads to
> > > > > > > > a use-after-free bug.
> > > > > > > >
> > > > > > > > ...
> > > > > > > >
> > > > > > > > --- a/mm/mmap.c
> > > > > > > > +++ b/mm/mmap.c
> > > > > > > > @@ -3186,6 +3186,7 @@ void exit_mmap(struct mm_struct *mm)
> > > > > > > >             vma =3D remove_vma(vma);
> > > > > > > >             cond_resched();
> > > > > > > >     }
> > > > > > > > +   mm->mmap =3D NULL;
> > > > > > > >     mmap_write_unlock(mm);
> > > > > > > >     vm_unacct_memory(nr_accounted);
> > > > > > > >  }
> > > > > > >
> > > > > > > After the Maple tree patches, mm_struct.mmap doesn't exist.  =
So I'll
> > > > > > > revert this fix as part of merging the maple-tree parts of li=
nux-next.
> > > > > > > I'll be sending this fix to Linus this week.
> > > > > > >
> > > > > > > All of which means that the thusly-resolved Maple tree patche=
s might
> > > > > > > reintroduce this use-after-free bug.
> > > > > >
> > > > > > I don't think so?  The problem is that VMAs are (currently) par=
t of
> > > > > > two data structures -- the rbtree and the linked list.  remove_=
vma()
> > > > > > only removes VMAs from the rbtree; it doesn't set mm->mmap to N=
ULL.
> > > > > >
> > > > > > With maple tree, the linked list goes away.  remove_vma() remov=
es VMAs
> > > > > > from the maple tree.  So anyone looking to iterate over all VMA=
s has to
> > > > > > go and look in the maple tree for them ... and there's nothing =
there.
> > > > >
> > > > > Yes, I think you are right. With maple trees we don't need this f=
ix.
> > > >
> > > >
> > > > Yes, this is correct.  The maple tree removes the entire linked lis=
t...
> > > > but since the mm is unstable in the exit_mmap(), I had added the
> > > > destruction of the maple tree there.  Maybe this is the wrong place=
 to
> > > > be destroying the tree tracking the VMAs (althought this patch part=
ially
> > > > destroys the VMA tracking linked list), but it brought my attention=
 to
> > > > the race that this patch solves and the process_mrelease() function=
.
> > > > Couldn't this be avoided by using mmget_not_zero() instead of mmgra=
b()
> > > > in process_mrelease()?
> > >
> > > That's what we were doing before [1]. That unfortunately has a proble=
m
> > > of process_mrelease possibly calling the last mmput and being blocked
> > > on IO completion in exit_aio.
> >
> > Oh, I see. Thanks.
> >
> >
> > > The race between exit_mmap and
> > > process_mrelease is solved by using mmap_lock.
> >
> > I think an important part of the race fix isn't just the lock holding
> > but the setting of the start of the linked list to NULL above.  That
> > means the code in __oom_reap_task_mm() via process_mrelease() will
> > continue to execute but iterate for zero VMAs.
> >
> > > I think by destroying the maple tree in exit_mmap before the
> > > mmap_write_unlock call, you keep things working and functionality
> > > intact. Is there any reason this can't be done?
> >
> > Yes, unfortunately.  If MMF_OOM_SKIP is not set, then process_mrelease(=
)
> > will call __oom_reap_task_mm() which will get a null pointer dereferenc=
e
> > or a use after free in the vma iterator as it tries to iterate the mapl=
e
> > tree.  I think the best plan is to set MMF_OOM_SKIP unconditionally
> > when the mmap_write_lock() is acquired.  Doing so will ensure nothing
> > will try to gain memory by reaping a task that no longer has memory to
> > yield - or at least won't shortly.  If we do use MMF_OOM_SKIP in such a
> > way, then I think it is safe to quickly drop the lock?
>=20
> That technically would work but it changes the semantics of
> MMF_OOM_SKIP flag from "mm is of no interest for the OOM killer" to
> something like "mm is empty" akin to mm->mmap =3D=3D NULL.

Well, an empty mm is of no interest to the oom killer was my thought.

> So, there is no way for maple tree to indicate that it is empty?

On second look, the tree is part of the mm_struct.  Destroying will
clear the flags and remove all VMAs, but that should be fine as long as
nothing tries to add anything back to the tree.  I don't think there is
a dereference issue here and it will continue to run through the motions
on an empty set as it does right now.

>=20
> >
> > Also, should process_mrelease() be setting MMF_OOM_VICTIM on this mm?
> > It would enable the fast path on a race with exit_mmap() - thought that
> > may not be desirable?
>=20
> Michal does not like that approach because again, process_mrelease is
> not oom-killer to set MMF_OOM_VICTIM flag. Besides, we want to get rid
> of that special mm_is_oom_victim(mm) branch inside exit_mmap. Which
> reminds me to look into it again.
>=20
> >
> > >
> > > [1] ba535c1caf3ee78a ("mm/oom_kill: allow process_mrelease to run
> > > under mmap_lock protection")
> > >
> > > > That would ensure we aren't stepping on an
> > > > exit_mmap() and potentially the locking change in exit_mmap() would=
n't
> > > > be needed either?  Logically, I view this as process_mrelease() hav=
ing
> > > > issue with the fact that the mmaps are no longer stable in tear dow=
n
> > > > regardless of the data structure that is used.
> > > >
> > > > Thanks,
> > > > Liam
> > > >
> > > > --
> > > > To unsubscribe from this group and stop receiving emails from it, s=
end an email to kernel-team+unsubscribe@android.com.
> > > >
> >
> > --
> > To unsubscribe from this group and stop receiving emails from it, send =
an email to kernel-team+unsubscribe@android.com.
> >=
