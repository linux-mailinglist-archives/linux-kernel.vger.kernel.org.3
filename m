Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E091530887
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 06:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbiEWE4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 00:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbiEWE4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 00:56:32 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2095.outbound.protection.outlook.com [40.107.94.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5731D11833
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 21:56:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e8PG3U35+duOmiidBDmPeFEXANKrQrmzZYOC/+Sabeg5+cJhD2NegFpVGh77sgfxa/ovsr63UZIkDk3HHcFiziQ5UWqoGh5cDGsNthK2s0qNkPLxNomjHWOBVuvdI3Si3LPBCRQWoJszwlFzq+lsQfZKiYM/pXDXfv4JhSj+zvpOpv5q9ypITZSKRrIeW+jMC9CJ3ABp7ZpMCXAwMOvTxo16sSv/kTfCjnbRhAHMyXQVEns9HpunIH5N2/4VcDTetJ053mlPErqf/7LzG7c5WXj1RUgc6oN64bUwOgFHdpV1tUthME4/g3wYHOW1EaDZgerAJG6O0NcjQeTwQmMxWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xIkLgWvPDZ7Q2fQThpbd2pdyxg6A9DnOZpKQuPUYk0k=;
 b=If3qd4DcysSw7WdN0aP9Z1+5eN6yZZ38paLBoH0/Xq3gLzc96rDilQ5DVFqWENqI3R/37kb1g6LDfo/a2TsnEsEDSkuisDVURob7iCzkYG+ZemAolayaUA2kZByzzg1ktmAk4meUWWvAestI35UI71Pbwtbgg41C9SwGAg/Miw9jlxBjcgP31LdzuBbHVl5QRdFoyLTibIIBGzHOUkx6GpEHnR+SUk/Q2WuTmY8q7+skOGyZvdELOG+Po5GJQgM6qr6HoMF6ja2NARaa7u1sDOTa8ceNXRdSOu72buiHf9TwFHxfLuqCr9vXEqbcqovfCEh746v8aveS9q532IWyBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=purdue.edu; dmarc=pass action=none header.from=purdue.edu;
 dkim=pass header.d=purdue.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=purdue0.onmicrosoft.com; s=selector2-purdue0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xIkLgWvPDZ7Q2fQThpbd2pdyxg6A9DnOZpKQuPUYk0k=;
 b=Ow/0lo0V92ClzaAEZFuCnJ5LaI+KrMm9YXRQUa47SNiRir9F8/gFQYHr96EvL5KBiil0SeEAEqg5Y4w4XRhrH39AppVBouvu3ZvteeWzlahe798Ql/u7WLZ8hoFCnvWuvw99QOmXlhAOq0oumXFd7OgCgXQaCX82IAl3znBTa1M=
Received: from MWHPR2201MB1072.namprd22.prod.outlook.com
 (2603:10b6:301:33::18) by BN6PR22MB0978.namprd22.prod.outlook.com
 (2603:10b6:404:150::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.22; Mon, 23 May
 2022 04:56:25 +0000
Received: from MWHPR2201MB1072.namprd22.prod.outlook.com
 ([fe80::a9e9:b100:2a55:23aa]) by MWHPR2201MB1072.namprd22.prod.outlook.com
 ([fe80::a9e9:b100:2a55:23aa%3]) with mapi id 15.20.5273.022; Mon, 23 May 2022
 04:56:25 +0000
From:   "Liu, Congyu" <liu3101@purdue.edu>
To:     Dmitry Vyukov <dvyukov@google.com>
CC:     "andreyknvl@gmail.com" <andreyknvl@gmail.com>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kcov: fix race caused by unblocked interrupt
Thread-Topic: [PATCH] kcov: fix race caused by unblocked interrupt
Thread-Index: AQHYajHoHiVYwAN8JUi5UTY5PvyBWK0kVeGAgAAA0wCABFjck4AAWi6AgACIm5aAARCogIABNT4a
Date:   Mon, 23 May 2022 04:56:25 +0000
Message-ID: <MWHPR2201MB10728DF36CE7C9B30C704E08D0D49@MWHPR2201MB1072.namprd22.prod.outlook.com>
References: <20220517210532.1506591-1-liu3101@purdue.edu>
 <CACT4Y+Z+HtUttrd+btEWLj5Nut4Gv++gzCOL3aDjvRTNtMDEvg@mail.gmail.com>
 <CACT4Y+bAGVLU5QEUeQEHth6SZDOSzy0CRKEJQioC0oKHSPaAbA@mail.gmail.com>
 <MWHPR2201MB10724669E6D80EDFDB749478D0D29@MWHPR2201MB1072.namprd22.prod.outlook.com>
 <CACT4Y+bXyiwEznZkAH5vRNd6YK3gi4aCncQLYt3iMWy43+T4EQ@mail.gmail.com>
 <MWHPR2201MB10723CCBB4869738E4BDFC36D0D29@MWHPR2201MB1072.namprd22.prod.outlook.com>
 <CACT4Y+Y_iHMn=EB=uBUopQ_5k4btJGAd-TR7Mo-DnUqquUcvng@mail.gmail.com>
In-Reply-To: <CACT4Y+Y_iHMn=EB=uBUopQ_5k4btJGAd-TR7Mo-DnUqquUcvng@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: be9991d4-5ca0-3787-aeae-f86b63c09c90
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=purdue.edu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b5f133a4-f4bd-4e5c-5af3-08da3c7896e8
x-ms-traffictypediagnostic: BN6PR22MB0978:EE_
x-microsoft-antispam-prvs: <BN6PR22MB097876731B398433BF0D3151D0D49@BN6PR22MB0978.namprd22.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NeFS5TYmqydb+c6G2iIR3OBJDKoFPgLrHkoj0QOxzZKE5EoYb1tHHhMRvw3+TzjqrmQztOjzbSCZCIOf41zcPLqQ4yrYKNQt13m/hj+1IeWzOozpEUbrIsOs0kT4ntTG8DR+HQeaH71kECnhrVRsJ5sKn0v8AMwOZH2cpIctQ25o9cVOfZ/ShEB98wiPv4Lz2CC7zDMAotBwGStRgdBVc/rpEFbaAygl4e5obpBHOPN/60H0IbZ/v6WdKeGmKD9RVu0+2seVDBHM465s1sUWLfgsgEklOaLZ7HraoLZfyQv8U7tJkTLeRft3iVL/Ok/zbTDD/pArKdaR82/D2Lc6TEOG75LKHbNIHn+CaVyEOoAYPphigIb0ZuueWNi1kG5O0cBKJdvIMHndsGqpPyVTMUUwMMHVf4bkFLSQCcxfd+DQrOQVoVY9QuJus9ZUxHVYFBCxYcnE+bFTm1BXu2EnHmeHAAcDVwDUrENIR2Z4iWSHpeoNI12elYvxqEAgviIab2OxD0hIfKe+GYaMd4tGTDQkEKEhoUCqDetxheNRdrOGq5MbKfKZ+gkZHZMW7H93/vTyQrjGKqjUhR3s6BhMHXUfLeWMBZ5y1A6U2RDPA27E/RDpkUEbmt8vRXQqNxS4bJGH4CDHLvOvKbOhYuYNCI2jOfphgQPeSgDBjCp4nQRdTp7cFtNOGXnbHFypwpbn2KE+yy37IklaKv3VF4JJKzNyeTp74rqlM6ywyJl/tcDVWO0eDXcHTRBx2QCXy1peJ9DYXY5UNEnq6y9g2oUO+6taYlcVenJ+MrvtD6frtqE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR2201MB1072.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(786003)(75432002)(6916009)(54906003)(91956017)(38100700002)(122000001)(66446008)(64756008)(5660300002)(52536014)(8936002)(4326008)(66476007)(66556008)(66946007)(76116006)(8676002)(86362001)(71200400001)(7696005)(38070700005)(6506007)(55016003)(53546011)(33656002)(26005)(30864003)(83380400001)(9686003)(2906002)(966005)(508600001)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+IjCSOc/y+3Yl9k7Lev5jyXhS8IdP2vNNYu3NnVk1CRtS7dnyOjDgrRjVuUa?=
 =?us-ascii?Q?qj0b+GZWEJYWO675dmTvrJHv2p3uWJqvTCkHQBsfnyMJ9QUoq8lgDAvMPd5g?=
 =?us-ascii?Q?azH9VDG3vJ3IeD4oVnr4PGszcwHgOcHeEtYjSHLlDwG9M/uzmWFMrsGhmnHt?=
 =?us-ascii?Q?6GkKaoir2hlw8/jHogCXRUwZQrUDx1TpTkZASNktQrcO+t4w+nkmUlj50Est?=
 =?us-ascii?Q?akZpGBObNpBaZTA7NpOec2d4cAsye32HyDyJYhP0gv6Tf/VTYecgvrv61LSS?=
 =?us-ascii?Q?qTZGLmREYqjrqtN3M/i3DFxFZ/zPst+bKKFhhZ2N8UrLn7BZudBB1pYc32ZO?=
 =?us-ascii?Q?UxhUTQDUhaoxIUfg9K5Vjd10S1qxPI6eLRiscrbhhwjjB0MjvR7RiGxukDjl?=
 =?us-ascii?Q?EegbqFAPaUBvZ3xImbw15OEXTN1bAyRDhHN/lxvgZ0T+hLsY19gQIQil2So9?=
 =?us-ascii?Q?G3lQlb5hXl1P8hn2kC3LQTQpIN5uy5slEcC8UX27eVcqEULMgtycozy25jho?=
 =?us-ascii?Q?MB1XlPrB3qrsaqTvWKcnRHgFajykDwc7kML20wLEK/3cf9FqNdXoCc8mBwNH?=
 =?us-ascii?Q?DM08yyaY6dE5VqZV9v7U/iTjemhb2nsjdDXcYUsH03GwY45MiQ7Xvx58Y/q3?=
 =?us-ascii?Q?ccWLg2yVgszv+EtP041m77CLiPm+H+An/rtJJGC1YjfDItqvEK9+tkcglRFu?=
 =?us-ascii?Q?d3cSJ+mjDiV2XPCofCCHG/x1Od9MxbvcGT3e3XQmIKavPwfz8bZ8acgR0hDn?=
 =?us-ascii?Q?/LGXIjtH1+gomRpE4PSLkAaHBP4f0z+ZI7UkZRPf03lScljZaTTCdpLlO+a3?=
 =?us-ascii?Q?4ajUr4V54xdOpsZgIiTlwUa+ioic8MtWlShtXRpwjlB41keAVXq6zF3cyd+C?=
 =?us-ascii?Q?VElFIlVMM3WL/VL3bT1AFffFnYmISaNjAAMcxdYdUvJTfCijktdunSTDgfdq?=
 =?us-ascii?Q?IgWZZLMzaJJ5w1yNAw4G9bR4axDCEisaU1W/C/kS9xs1KowWTIN6VPsfwVEJ?=
 =?us-ascii?Q?ySy55FAteqhs88dcuTF4myti6cQlgqPcyizgnTI3bkItzEkXeVmRcd6IVRex?=
 =?us-ascii?Q?Zz+QuuRuxxm+6FE6SC1QH9Fww1yiAPQkg3DgOJx7bX5pimJ07KhL6CRcvsnq?=
 =?us-ascii?Q?rkA72QmE54dV1Awa3ujQJQMlu3Quhy559j2BDc0HGTV7ev/f8cNeS2/5iFHh?=
 =?us-ascii?Q?N18+snxXpNPTeDH7YFWnBi6qN67W4caBgVHy6w+eNck/IeGHugT34PGQwZ2D?=
 =?us-ascii?Q?yE2S648db/dqYJkdl+Hgfyr3pYZUOsOqoEJHdcCuVEEhXYyYuQLGrVGSE7cM?=
 =?us-ascii?Q?aZ5RGtHGxBHJ34vI0rBGiR6WtIkJOgaOanRCyYcq/wrMxZiTMtaGb3UNsZcz?=
 =?us-ascii?Q?Gx2N2UEDbhdSpS3hucHj9WYAcGA7xVCF82QWOKiBIMUS/2oyRPdf3XPsrDfD?=
 =?us-ascii?Q?rTv981+5yvWTabCFhEMRi67OCY4tK3GO2R57P4u/ZTezSMq63k28csUdqXBZ?=
 =?us-ascii?Q?DI0D+PHCOiIlZacvrS+J4ovLXmJeTYcCvub792FWLGl7Cdp4NqsY79TUJZ95?=
 =?us-ascii?Q?ZCMCS/6Kn/D/F68fcIKWAYlZKVXp99F/PVRVeKZj7HHyvZ0HkR3Pt5Afzm5Z?=
 =?us-ascii?Q?/hA/hgpkqXOE9C0rQw+JrwlD4OdwtBBBk8bgXEOJlFSGAAhNdb484YIx1BGS?=
 =?us-ascii?Q?JA24S3Lp2ePHyrp+mDfjrterNXbQ6mAVuMG3pgCtUrcVmOsd?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: purdue.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR2201MB1072.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5f133a4-f4bd-4e5c-5af3-08da3c7896e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2022 04:56:25.1586
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4130bd39-7c53-419c-b1e5-8758d6d63f21
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3xzh1KpTwc4t1jGTOZVfaZmOWS494iAva+68bLEWpdx6IvnZpGtQ+UD8x/TeLqrNPecSdeyp7sqIHgUjFUvcgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR22MB0978
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Swapping the order of writing pc/incrementing pos sounds good to me.
I will then send two new patches.

________________________________________
From: Dmitry Vyukov <dvyukov@google.com>
Sent: Sunday, May 22, 2022 5:09
To: Liu, Congyu
Cc: andreyknvl@gmail.com; kasan-dev@googlegroups.com; linux-kernel@vger.ker=
nel.org
Subject: Re: [PATCH] kcov: fix race caused by unblocked interrupt

On Sat, 21 May 2022 at 19:01, Liu, Congyu <liu3101@purdue.edu> wrote:
>
> I just collected some call stacks when `__sanitizer_cov_trace_pc` is recu=
rsively invoked by checking `kcov_writing` flag.
>
> Here are some examples:

Thanks for collecting these.
This is early interrupt code.

I would like to avoid adding more overhead to
__sanitizer_cov_trace_pc() function if possible since it's called for
every basic block.

One alternative is to rearrange irq entry/exit code so that in_task()
starts returning false for all that code. However, this may be tricky
since the irq entry/exit code are subtle beasts.

trace_hardirqs_off_finish() is defined in trace_preemptirq.c:
https://elixir.bootlin.com/linux/v5.18-rc7/source/kernel/trace/trace_preemp=
tirq.c#L61
I think we could mark this file as KCOV_SANITIZE :=3D n in the Makefile.
This would be good for other reasons: currently this code still adds
random coverage pieces at random places even with your patch (it only
prevents overwriting but not adding).

However, this will not work for _find_first_zero_bit() since it's a
very common function used in lots of places.
So what do you think if we additionally swap the order of writing
pc/incrementing pos? It would need some explanatory comment as to why
we are doing this.


> __sanitizer_cov_trace_pc+0xe4/0x100
> trace_hardirqs_off_finish+0x21f/0x270
> irqentry_enter+0x2b/0x50
> sysvec_apic_timer_interrupt+0xb/0xc0
> asm_sysvec_apic_timer_interrupt+0x12/0x20
> __sanitizer_cov_trace_pc+0x91/0x100
> file_update_time+0x68/0x520
> pipe_write+0x1279/0x1ac0
> new_sync_write+0x421/0x650
> vfs_write+0x7ae/0xa60
> ksys_write+0x1ee/0x250
> do_syscall_64+0x3a/0xb0
> entry_SYSCALL_64_after_hwframe+0x44/0xae
>
> __sanitizer_cov_trace_pc+0xe4/0x100
> _find_first_zero_bit+0x52/0xb0
> __lock_acquire+0x1ac2/0x4f70
> lock_acquire+0x1ab/0x4f0
> _raw_spin_lock+0x2a/0x40
> rcu_note_context_switch+0x299/0x16e0
> __schedule+0x1fd/0x2320
> preempt_schedule_irq+0x4e/0x90
> irqentry_exit+0x31/0x80
> asm_sysvec_apic_timer_interrupt+0x12/0x20
> __sanitizer_cov_trace_pc+0x75/0x100
> xas_descend+0x16b/0x340
> xas_load+0xe5/0x140
> pagecache_get_page+0x179/0x18d0
> __find_get_block+0x478/0xd00
> __getblk_gfp+0x32/0xb40
> ext4_getblk+0x1cf/0x680
> ext4_bread_batch+0x80/0x5a0
> __ext4_find_entry+0x460/0xfc0
> ext4_lookup+0x4fc/0x730
> __lookup_hash+0x117/0x180
> filename_create+0x186/0x490
> unix_bind+0x322/0xbc0
> __sys_bind+0x20c/0x260
> __x64_sys_bind+0x6e/0xb0
> do_syscall_64+0x3a/0xb0
> entry_SYSCALL_64_after_hwframe+0x44/0xae
>
>
> __sanitizer_cov_trace_pc+0xe4/0x100
> prandom_u32+0xd/0x460
> trace_hardirqs_off_finish+0x60/0x270
> irqentry_enter+0x2b/0x50
> sysvec_apic_timer_interrupt+0xb/0xc0
> asm_sysvec_apic_timer_interrupt+0x12/0x20
> __sanitizer_cov_trace_pc+0x9a/0x100
> __es_remove_extent+0x726/0x15e0
> ext4_es_insert_delayed_block+0x216/0x580
> ext4_da_get_block_prep+0x88f/0x1180
> __block_write_begin_int+0x3ef/0x1630
> block_page_mkwrite+0x223/0x310
> ext4_page_mkwrite+0xbf7/0x1a30
> do_page_mkwrite+0x1a7/0x530
> __handle_mm_fault+0x2c71/0x5240
> handle_mm_fault+0x1bc/0x7b0
> do_user_addr_fault+0x59b/0x1200
> exc_page_fault+0x9e/0x170
> asm_exc_page_fault+0x1e/0x30
>
> Looks like `asm_sysvec_apic_timer_interrupt` is culprit.
>
> ________________________________________
> From: Dmitry Vyukov <dvyukov@google.com>
> Sent: Saturday, May 21, 2022 4:45
> To: Liu, Congyu
> Cc: andreyknvl@gmail.com; kasan-dev@googlegroups.com; linux-kernel@vger.k=
ernel.org
> Subject: Re: [PATCH] kcov: fix race caused by unblocked interrupt
>
> On Sat, 21 May 2022 at 05:59, Liu, Congyu <liu3101@purdue.edu> wrote:
> >
> > Hi Dmitry,
> >
> > Sorry for the late reply. I did some experiments and hopefully they cou=
ld be helpful.
> >
> > To get the PC of the code that tampered with the buffer, I added some c=
ode between `area[pos] =3D ip;` and `WRITE_ONCE(area[0], pos);`: First, som=
e code to delay for a while (e.g. for loop to write something). Then read `=
area[0]` and compare it with `pos`. If they are different, then `area[pos]`=
 is tampered. A mask is then added to `area[pos]` so I can identify and ret=
rieve it later.
> >
> > In this way, I ran some test cases then get a list of PCs that tampered=
 with the kcov buffer, e.g., ./include/linux/rcupdate.h:rcu_read_lock, arch=
/x86/include/asm/current.h:get_current, include/sound/pcm.h:hw_is_interval,=
 net/core/neighbour.c:neigh_flush_dev, net/ipv6/addrconf.c:__ipv6_dev_get_s=
addr, mm/mempolicy.c:__get_vma_policy...... It seems that they are not from=
 the early interrupt code. Do you think they should not be instrumented?
>
> Humm... these look strange. They don't look like early interrupt code,
> but they also don't look like interrupt code at all. E.g.
> neigh_flush_dev looks like a very high level function that takes some
> mutexes:
> https://elixir.bootlin.com/linux/v5.18-rc7/source/net/core/neighbour.c#L3=
20
>
> It seems that there is something happening that we don't understand.
>
> Please try to set t->kcov_writing around the task access, and then if
> you see it recursively already set print the current pc/stack trace.
> That should give better visibility into what code enters kcov
> recursively.
>
> If you are using syzkaller tools, you can run syz-execprog with -cover
> flag on some log file, or run some program undef kcovtrace:
> https://github.com/google/syzkaller/blob/master/tools/kcovtrace/kcovtrace=
.c
>
>
>
> > I think reordering `area[pos] =3D ip;` and `WRITE_ONCE(area[0], pos);` =
is also a smart solution since PC will be written to buffer only after the =
buffer is reserved.
> >
> > Thanks,
> > Congyu
> >
> > ________________________________________
> > From: Dmitry Vyukov <dvyukov@google.com>
> > Sent: Wednesday, May 18, 2022 4:59
> > To: Liu, Congyu
> > Cc: andreyknvl@gmail.com; kasan-dev@googlegroups.com; linux-kernel@vger=
.kernel.org
> > Subject: Re: [PATCH] kcov: fix race caused by unblocked interrupt
> >
> > On Wed, 18 May 2022 at 10:56, Dmitry Vyukov <dvyukov@google.com> wrote:
> > >
> > > On Tue, 17 May 2022 at 23:05, Congyu Liu <liu3101@purdue.edu> wrote:
> > > >
> > > > Some code runs in interrupts cannot be blocked by `in_task()` check=
.
> > > > In some unfortunate interleavings, such interrupt is raised during
> > > > serializing trace data and the incoming nested trace functionn coul=
d
> > > > lead to loss of previous trace data. For instance, in
> > > > `__sanitizer_cov_trace_pc`, if such interrupt is raised between
> > > > `area[pos] =3D ip;` and `WRITE_ONCE(area[0], pos);`, then trace dat=
a in
> > > > `area[pos]` could be replaced.
> > > >
> > > > The fix is done by adding a flag indicating if the trace buffer is =
being
> > > > updated. No modification to trace buffer is allowed when the flag i=
s set.
> > >
> > > Hi Congyu,
> > >
> > > What is that interrupt code? What interrupts PCs do you see in the tr=
ace.
> > > I would assume such early interrupt code should be in asm and/or not
> > > instrumented. The presence of instrumented traced interrupt code is
> > > problematic for other reasons (add random stray coverage to the
> > > trace). So if we make it not traced, it would resolve both problems a=
t
> > > once and without the fast path overhead that this change adds.
> >
> > Also thinking if reordering `area[pos] =3D ip;` and `WRITE_ONCE(area[0]=
, pos);`
> > will resolve the problem without adding fast path overhead.
> > However, not instrumenting early interrupt code still looks more prefer=
able.
> >
> >
> >  > Signed-off-by: Congyu Liu <liu3101@purdue.edu>
> > > > ---
> > > >  include/linux/sched.h |  3 +++
> > > >  kernel/kcov.c         | 16 ++++++++++++++++
> > > >  2 files changed, 19 insertions(+)
> > > >
> > > > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > > > index a8911b1f35aa..d06cedd9595f 100644
> > > > --- a/include/linux/sched.h
> > > > +++ b/include/linux/sched.h
> > > > @@ -1408,6 +1408,9 @@ struct task_struct {
> > > >
> > > >         /* Collect coverage from softirq context: */
> > > >         unsigned int                    kcov_softirq;
> > > > +
> > > > +       /* Flag of if KCOV area is being written: */
> > > > +       bool                            kcov_writing;
> > > >  #endif
> > > >
> > > >  #ifdef CONFIG_MEMCG
> > > > diff --git a/kernel/kcov.c b/kernel/kcov.c
> > > > index b3732b210593..a595a8ad5d8a 100644
> > > > --- a/kernel/kcov.c
> > > > +++ b/kernel/kcov.c
> > > > @@ -165,6 +165,8 @@ static notrace bool check_kcov_mode(enum kcov_m=
ode needed_mode, struct task_stru
> > > >          */
> > > >         if (!in_task() && !(in_serving_softirq() && t->kcov_softirq=
))
> > > >                 return false;
> > > > +       if (READ_ONCE(t->kcov_writing))
> > > > +               return false;
> > > >         mode =3D READ_ONCE(t->kcov_mode);
> > > >         /*
> > > >          * There is some code that runs in interrupts but for which
> > > > @@ -201,12 +203,19 @@ void notrace __sanitizer_cov_trace_pc(void)
> > > >                 return;
> > > >
> > > >         area =3D t->kcov_area;
> > > > +
> > > > +       /* Prevent race from unblocked interrupt. */
> > > > +       WRITE_ONCE(t->kcov_writing, true);
> > > > +       barrier();
> > > > +
> > > >         /* The first 64-bit word is the number of subsequent PCs. *=
/
> > > >         pos =3D READ_ONCE(area[0]) + 1;
> > > >         if (likely(pos < t->kcov_size)) {
> > > >                 area[pos] =3D ip;
> > > >                 WRITE_ONCE(area[0], pos);
> > > >         }
> > > > +       barrier();
> > > > +       WRITE_ONCE(t->kcov_writing, false);
> > > >  }
> > > >  EXPORT_SYMBOL(__sanitizer_cov_trace_pc);
> > > >
> > > > @@ -230,6 +239,10 @@ static void notrace write_comp_data(u64 type, =
u64 arg1, u64 arg2, u64 ip)
> > > >         area =3D (u64 *)t->kcov_area;
> > > >         max_pos =3D t->kcov_size * sizeof(unsigned long);
> > > >
> > > > +       /* Prevent race from unblocked interrupt. */
> > > > +       WRITE_ONCE(t->kcov_writing, true);
> > > > +       barrier();
> > > > +
> > > >         count =3D READ_ONCE(area[0]);
> > > >
> > > >         /* Every record is KCOV_WORDS_PER_CMP 64-bit words. */
> > > > @@ -242,6 +255,8 @@ static void notrace write_comp_data(u64 type, u=
64 arg1, u64 arg2, u64 ip)
> > > >                 area[start_index + 3] =3D ip;
> > > >                 WRITE_ONCE(area[0], count + 1);
> > > >         }
> > > > +       barrier();
> > > > +       WRITE_ONCE(t->kcov_writing, false);
> > > >  }
> > > >
> > > >  void notrace __sanitizer_cov_trace_cmp1(u8 arg1, u8 arg2)
> > > > @@ -335,6 +350,7 @@ static void kcov_start(struct task_struct *t, s=
truct kcov *kcov,
> > > >         t->kcov_size =3D size;
> > > >         t->kcov_area =3D area;
> > > >         t->kcov_sequence =3D sequence;
> > > > +       t->kcov_writing =3D false;
> > > >         /* See comment in check_kcov_mode(). */
> > > >         barrier();
> > > >         WRITE_ONCE(t->kcov_mode, mode);
> > > > --
> > > > 2.34.1
> > > >
