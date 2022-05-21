Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D70952F834
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 05:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237457AbiEUD7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 23:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231646AbiEUD7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 23:59:33 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2093.outbound.protection.outlook.com [40.107.220.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 364A217CCB3
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 20:59:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vs7CqCHh+gMM4HXAhIaxRCEXBNjz5JF/+6yt6RDqxWc4/F811OmR2O2T0yIxtsV18j9Vm487lAY4vj6aoZXkKjN013m2Tu8LiqdraFRGu2/yKLiiDAfZUMC7C3n9cSRIK1DUdpMCopXkKATPaREIstgLdScELaE9BZzCX77v7NnQi8ZQp8N7oHFrrXMwOHRvRnOXr33u+6vS+vqLiiJyFMA5fVrFA1U4Qz575rYdOliTRJrfZRuytCzbjZisG0q3JjF3vEyrRqY9/QnLZCIOeyJSp0uJOkgS8n1tqs2YaWaxGYu37//Ekbe4AfV7hXcRuWcmZ5Yy7n2IfTVgUZcMIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f1fk+VS7vZY/YdCR5d8x3fPkjxvFwwedu3VhuJfmTPY=;
 b=C0hLIpo98YWbCteTIJ4jdzJZIKEUGrIxgcWSAUtxvyDNqo+EpuvXERzY72GfMfvTuOC5cEXVauiS2eBLokV0bSiZ9v1AEb6dd4tZYG20DbXOUcpuwNVRVjqpDi9vmGVy9pgoeKdl+XkpCV0gt7Y/wyFNLkhUgX1qJ83yQtttmoChbSC+kiQIkCpUntIElC0MF6SGKp4UOtEOmL4tvLZcqBSRPjQ3kwTw0bZIGvzWwiL/+rDO4jMkiN0YQfk5HP7ojWt9fOkXrzLDNmb4ISwBI4Gz0NoH6d9yTiBLHH3mPa1szwklEPspMZ+qGoS3Zrn6qypBi5w5x8zl+sjjz7C39w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=purdue.edu; dmarc=pass action=none header.from=purdue.edu;
 dkim=pass header.d=purdue.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=purdue0.onmicrosoft.com; s=selector2-purdue0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f1fk+VS7vZY/YdCR5d8x3fPkjxvFwwedu3VhuJfmTPY=;
 b=sup8Q42PK9iWg6EqhG7q0L+im1xiGbS3+vXAMHHANKE45tt4ssvysdRsFGAUaTfTdk/9AR+EaevJ6eERxsfliSkrymC2gknC2lX9shCE9k3R/HfUJWaGHx4gc9a7FR54WtEQetUDHFc56w10ak/kPlc74qrQeoO2sB5XR74JZSY=
Received: from MWHPR2201MB1072.namprd22.prod.outlook.com
 (2603:10b6:301:33::18) by DM6PR22MB1899.namprd22.prod.outlook.com
 (2603:10b6:5:22c::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.19; Sat, 21 May
 2022 03:59:29 +0000
Received: from MWHPR2201MB1072.namprd22.prod.outlook.com
 ([fe80::a9e9:b100:2a55:23aa]) by MWHPR2201MB1072.namprd22.prod.outlook.com
 ([fe80::a9e9:b100:2a55:23aa%3]) with mapi id 15.20.5273.017; Sat, 21 May 2022
 03:59:28 +0000
From:   "Liu, Congyu" <liu3101@purdue.edu>
To:     Dmitry Vyukov <dvyukov@google.com>
CC:     "andreyknvl@gmail.com" <andreyknvl@gmail.com>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kcov: fix race caused by unblocked interrupt
Thread-Topic: [PATCH] kcov: fix race caused by unblocked interrupt
Thread-Index: AQHYajHoHiVYwAN8JUi5UTY5PvyBWK0kVeGAgAAA0wCABFjckw==
Date:   Sat, 21 May 2022 03:59:28 +0000
Message-ID: <MWHPR2201MB10724669E6D80EDFDB749478D0D29@MWHPR2201MB1072.namprd22.prod.outlook.com>
References: <20220517210532.1506591-1-liu3101@purdue.edu>
 <CACT4Y+Z+HtUttrd+btEWLj5Nut4Gv++gzCOL3aDjvRTNtMDEvg@mail.gmail.com>
 <CACT4Y+bAGVLU5QEUeQEHth6SZDOSzy0CRKEJQioC0oKHSPaAbA@mail.gmail.com>
In-Reply-To: <CACT4Y+bAGVLU5QEUeQEHth6SZDOSzy0CRKEJQioC0oKHSPaAbA@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 23f74e33-808c-ea5a-2a90-797ae0dfa15e
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=purdue.edu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f96429ef-c813-4230-ebb5-08da3ade4dc4
x-ms-traffictypediagnostic: DM6PR22MB1899:EE_
x-microsoft-antispam-prvs: <DM6PR22MB1899890D9DD90900E8573DB2D0D29@DM6PR22MB1899.namprd22.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q5zgBk3YBdJUEggLAhIqdhAXIJlh+cf/kFaLXCmYFNFpfD1db6tKWUuXhpZSSQ1qyTaUxtO2szaBqG5YNfaRlueDf9vEthdwgSC5G66buPLFgLUz8Y3YhkxfafEjc5oW2idS+EvJ6lwvhps4Doljx0rhsmQGZuPKTWYeJkIA1BW+W7W3DvqIOp17yp7vD2y2BRFFm+aP9zxREmXyZTAlsnBSx1U9cxklJcMN4wWmSdl6fHL6d6fT5HYWQAC9O88TQls1kgduGnHS2Mqs2nAAM+ZqCTHcflk0EiAHJICg5sokVI1tgmGiRR6dvOchdC21oYPmVxAgRAbaNNboQeZq9swoEjpWFcqLgDwcbQI3ossuJZ0/taMPqT0FIrLsKFob8CbyNPvHDFdHjFQ4O35qojcM0VI3ogweXQwTtIgrTl1hv472HJGJR712lp1nHHz2PIz8PuVDbUPKJ+pRBNNQcONmH409cc6zN0hZZ0VLyi6RkgpyM+1U/1AKyfF76/pgRHYtv5tguT/HSUPzbGm1i5imT2Wupeu2KgI/rVNUvA/pjS399aWVKFjSsHKmHmFcvxbE8KoC003+aOoYPxFTvzlgwxb2FxwCQ6Uf1L/rUnoTCDUnYeqBJ2ajfO1YMEGdnWv0J4v8E03PCnFzca7oEKIU8MXAuku4O9nOoBwM6sCRvGkCQF55CTQVgUbf7kwdmOuUgJHGVSBwMVwlGuaOzg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR2201MB1072.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8676002)(64756008)(66556008)(71200400001)(66446008)(66476007)(66946007)(4326008)(6916009)(786003)(316002)(76116006)(54906003)(53546011)(86362001)(7696005)(9686003)(6506007)(26005)(33656002)(55016003)(91956017)(508600001)(122000001)(52536014)(186003)(83380400001)(8936002)(38070700005)(38100700002)(2906002)(75432002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?y/vqZzgxopixNtScHkiH+lxeTTk7e58D5t6dE/Q9B6F1luBc6o7GyTuydFJA?=
 =?us-ascii?Q?RwDUPx7il9LwABQAvG3BgqbyWTBVmOL7YleT4CVgxC7I+CDKKu7BwJ3SwTmN?=
 =?us-ascii?Q?dXoXHeu66AOsQbMPdMBNhFD+RtW6miKJ1BD52JY/RwXAMFw78VyTeqTyd7lA?=
 =?us-ascii?Q?PFs9U+jRXu4TRbrBhQ8PcupjgMHI3XzBxBzuivjGz5FcxYo1yVLaEhLMK8zA?=
 =?us-ascii?Q?BD+PRM00gJCgF+cy8Za6CqLKGd0RP/Pa/rMlMqHs0SSPxwMxVIaPz76jSGV3?=
 =?us-ascii?Q?k0QmALdlLzyqY1/CgDPYINUmQgA2e3I9kkCZ5Galfh7NjBOGs/ZFeCu8u63p?=
 =?us-ascii?Q?gouHLJRhrY7guX9/4vQt7yYMMnQTH7gq1jv51ykBpYYXUNEcWTABlQpFPG1A?=
 =?us-ascii?Q?1N4OFicfg9Lv/GPcWkf/DLlnfdiGyZgR5G7eBKlEu+cPzhmV850s5r+WyNdr?=
 =?us-ascii?Q?MsoNVezU73nq57EPIUPURtN3Avc2iyorBBGce0k1TmnLdIf62NUmaEI4sHJb?=
 =?us-ascii?Q?+8S7Ft2rHnNIMj3rzFQJV7MFzZMV4SpWJxCsq1r1NKxnO6dOM5GVlJCpjHIg?=
 =?us-ascii?Q?RIMxNqchCDiQrWShz1yJCWGFI4cLo1aveV3xlZL9N6NFCmRz4r7WDmQBWUQA?=
 =?us-ascii?Q?Ax0Qx30Acg5ijF1NifPLkdSGwtDcuv+Ssxj1GGebSirHLv+EIuKjs2lYF8q3?=
 =?us-ascii?Q?unnTJBFHP49OVfgqSFIXNR4CKADoIAL9yQDVzDiwV1zwr5ZnQHCt26B88P0E?=
 =?us-ascii?Q?S1CoGZu72tkboeNJn6TqZjW4udGrlAMaMcf9BK1YJkqEkenVu5AHloibbSAF?=
 =?us-ascii?Q?TqS2P3rrR9F1waUMZiMhRYrJXETSf7l+rEeHSeMS/lAmfQmaj8Ne0KwlVpiE?=
 =?us-ascii?Q?wRbPcaN+Ess0qL+68+Rd270nfMf6ts7/cvIAJNOZ585SQREtpbbwBzM0cquq?=
 =?us-ascii?Q?rhmFQ927L9/pQ0ucpTP0D5psADjuAZaRYsfXdTZy4g12j44Xs7E7KnFJpilm?=
 =?us-ascii?Q?sEj6x7QCFGwgj9SN/69ek4XoZ3O9EyX4AbjomntknPitRt7lpmdI2zpKhSt+?=
 =?us-ascii?Q?njmZALVlHtMfl1G3kop7msfph4AEJ1CiqA8UVdC3fK+VWPPUIOXZ/7z7o0ua?=
 =?us-ascii?Q?tBRsSaP93Y1cWb1ScXiiY/D3PB7JqaFR05TYuvv87uQLjA8oY2NCTBQlIKc7?=
 =?us-ascii?Q?Y/ZqwF8FGmt4XArkf2/9RC8YNwU3SIxouw22YTWMlBLB4wyoMDgXwjOSUcj5?=
 =?us-ascii?Q?3BCAp6ssBnKGqPGDVhLXUMXXE47FC6E49Hq8nRwOhXuxN7xrkXx9RU40+A9q?=
 =?us-ascii?Q?tOfNhYsppYW3O4+OAFyUBSY3ORliHEql73pBfuDt4EZxD0HpJnCx2XxQIyEA?=
 =?us-ascii?Q?j5/0UB6VmS4n1lI+kWwf22uwgpjWRAuLXRh0TIpWYJ6Or+jJ+TJXurgix5JH?=
 =?us-ascii?Q?+1QMpnYO+U4tdjDt7cCyVZynAhZoTfoSsiQW1upFSpZPKe7oVcTloSJ0BFLn?=
 =?us-ascii?Q?XP39AW6FFS1QZnsjYmOq1qw+lYnjNo1JG8R8O4c4YspM1+xOEK+vu6XkjbWY?=
 =?us-ascii?Q?Y4mDQsXSaCIfojQstLHTqg8LwmgzpX7A9CX8eSM01qA5ccCOg5IpNE32y4mw?=
 =?us-ascii?Q?pk2zGbddJiM9Z141CiPHUamlBGjsn5xxGfCRjArfC9bsh3wWrg+dVzpvRHDb?=
 =?us-ascii?Q?DzWStGMtVS8qEQWMrU1Bne/JdSvlerl5oIjnTfF6cA+F0+KD?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: purdue.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR2201MB1072.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f96429ef-c813-4230-ebb5-08da3ade4dc4
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2022 03:59:28.7935
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4130bd39-7c53-419c-b1e5-8758d6d63f21
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: prKMpB+k3U2XJlXWBz6S0pToymLrjM7/U36C9lTWdD0UqhDK2j/LbUz0tG0XAPD9P86HjHWagegdoNzMD8mPeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR22MB1899
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

Sorry for the late reply. I did some experiments and hopefully they could b=
e helpful.

To get the PC of the code that tampered with the buffer, I added some code =
between `area[pos] =3D ip;` and `WRITE_ONCE(area[0], pos);`: First, some co=
de to delay for a while (e.g. for loop to write something). Then read `area=
[0]` and compare it with `pos`. If they are different, then `area[pos]` is =
tampered. A mask is then added to `area[pos]` so I can identify and retriev=
e it later.

In this way, I ran some test cases then get a list of PCs that tampered wit=
h the kcov buffer, e.g., ./include/linux/rcupdate.h:rcu_read_lock, arch/x86=
/include/asm/current.h:get_current, include/sound/pcm.h:hw_is_interval, net=
/core/neighbour.c:neigh_flush_dev, net/ipv6/addrconf.c:__ipv6_dev_get_saddr=
, mm/mempolicy.c:__get_vma_policy...... It seems that they are not from the=
 early interrupt code. Do you think they should not be instrumented?

I think reordering `area[pos] =3D ip;` and `WRITE_ONCE(area[0], pos);` is a=
lso a smart solution since PC will be written to buffer only after the buff=
er is reserved.

Thanks,
Congyu

________________________________________
From: Dmitry Vyukov <dvyukov@google.com>
Sent: Wednesday, May 18, 2022 4:59
To: Liu, Congyu
Cc: andreyknvl@gmail.com; kasan-dev@googlegroups.com; linux-kernel@vger.ker=
nel.org
Subject: Re: [PATCH] kcov: fix race caused by unblocked interrupt

On Wed, 18 May 2022 at 10:56, Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Tue, 17 May 2022 at 23:05, Congyu Liu <liu3101@purdue.edu> wrote:
> >
> > Some code runs in interrupts cannot be blocked by `in_task()` check.
> > In some unfortunate interleavings, such interrupt is raised during
> > serializing trace data and the incoming nested trace functionn could
> > lead to loss of previous trace data. For instance, in
> > `__sanitizer_cov_trace_pc`, if such interrupt is raised between
> > `area[pos] =3D ip;` and `WRITE_ONCE(area[0], pos);`, then trace data in
> > `area[pos]` could be replaced.
> >
> > The fix is done by adding a flag indicating if the trace buffer is bein=
g
> > updated. No modification to trace buffer is allowed when the flag is se=
t.
>
> Hi Congyu,
>
> What is that interrupt code? What interrupts PCs do you see in the trace.
> I would assume such early interrupt code should be in asm and/or not
> instrumented. The presence of instrumented traced interrupt code is
> problematic for other reasons (add random stray coverage to the
> trace). So if we make it not traced, it would resolve both problems at
> once and without the fast path overhead that this change adds.

Also thinking if reordering `area[pos] =3D ip;` and `WRITE_ONCE(area[0], po=
s);`
will resolve the problem without adding fast path overhead.
However, not instrumenting early interrupt code still looks more preferable=
.


 > Signed-off-by: Congyu Liu <liu3101@purdue.edu>
> > ---
> >  include/linux/sched.h |  3 +++
> >  kernel/kcov.c         | 16 ++++++++++++++++
> >  2 files changed, 19 insertions(+)
> >
> > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > index a8911b1f35aa..d06cedd9595f 100644
> > --- a/include/linux/sched.h
> > +++ b/include/linux/sched.h
> > @@ -1408,6 +1408,9 @@ struct task_struct {
> >
> >         /* Collect coverage from softirq context: */
> >         unsigned int                    kcov_softirq;
> > +
> > +       /* Flag of if KCOV area is being written: */
> > +       bool                            kcov_writing;
> >  #endif
> >
> >  #ifdef CONFIG_MEMCG
> > diff --git a/kernel/kcov.c b/kernel/kcov.c
> > index b3732b210593..a595a8ad5d8a 100644
> > --- a/kernel/kcov.c
> > +++ b/kernel/kcov.c
> > @@ -165,6 +165,8 @@ static notrace bool check_kcov_mode(enum kcov_mode =
needed_mode, struct task_stru
> >          */
> >         if (!in_task() && !(in_serving_softirq() && t->kcov_softirq))
> >                 return false;
> > +       if (READ_ONCE(t->kcov_writing))
> > +               return false;
> >         mode =3D READ_ONCE(t->kcov_mode);
> >         /*
> >          * There is some code that runs in interrupts but for which
> > @@ -201,12 +203,19 @@ void notrace __sanitizer_cov_trace_pc(void)
> >                 return;
> >
> >         area =3D t->kcov_area;
> > +
> > +       /* Prevent race from unblocked interrupt. */
> > +       WRITE_ONCE(t->kcov_writing, true);
> > +       barrier();
> > +
> >         /* The first 64-bit word is the number of subsequent PCs. */
> >         pos =3D READ_ONCE(area[0]) + 1;
> >         if (likely(pos < t->kcov_size)) {
> >                 area[pos] =3D ip;
> >                 WRITE_ONCE(area[0], pos);
> >         }
> > +       barrier();
> > +       WRITE_ONCE(t->kcov_writing, false);
> >  }
> >  EXPORT_SYMBOL(__sanitizer_cov_trace_pc);
> >
> > @@ -230,6 +239,10 @@ static void notrace write_comp_data(u64 type, u64 =
arg1, u64 arg2, u64 ip)
> >         area =3D (u64 *)t->kcov_area;
> >         max_pos =3D t->kcov_size * sizeof(unsigned long);
> >
> > +       /* Prevent race from unblocked interrupt. */
> > +       WRITE_ONCE(t->kcov_writing, true);
> > +       barrier();
> > +
> >         count =3D READ_ONCE(area[0]);
> >
> >         /* Every record is KCOV_WORDS_PER_CMP 64-bit words. */
> > @@ -242,6 +255,8 @@ static void notrace write_comp_data(u64 type, u64 a=
rg1, u64 arg2, u64 ip)
> >                 area[start_index + 3] =3D ip;
> >                 WRITE_ONCE(area[0], count + 1);
> >         }
> > +       barrier();
> > +       WRITE_ONCE(t->kcov_writing, false);
> >  }
> >
> >  void notrace __sanitizer_cov_trace_cmp1(u8 arg1, u8 arg2)
> > @@ -335,6 +350,7 @@ static void kcov_start(struct task_struct *t, struc=
t kcov *kcov,
> >         t->kcov_size =3D size;
> >         t->kcov_area =3D area;
> >         t->kcov_sequence =3D sequence;
> > +       t->kcov_writing =3D false;
> >         /* See comment in check_kcov_mode(). */
> >         barrier();
> >         WRITE_ONCE(t->kcov_mode, mode);
> > --
> > 2.34.1
> >
