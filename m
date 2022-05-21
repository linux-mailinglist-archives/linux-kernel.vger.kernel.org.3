Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DEF252FE73
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 19:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242650AbiEURBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 13:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbiEURBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 13:01:46 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08on2136.outbound.protection.outlook.com [40.107.100.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 065AE27150
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 10:01:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aH/f1q8wriR/0U9z5D4u0iimK7EBGjIERK+erZxZ7FnpskpeXuqqeggtTAWfK+526zxfs5HwPPZTdN89CevGTLz+Pw+86WC7sV4Zeox5iXxveiuZj/iFEp9qUFmZYsqCbolBnhqCzC0/X07tv2LTJ2zwhxbVt2MmXwfTOnyTHfRp4NWGRXMf5oZpbQs+nrJGdp1eKRmFaOB0/ClYBT9pesQ05TsReR9raAgMurpyIQTtfO3zy5xQjVVrl+RG9FjyKDKkB6a2GVIk37IxzLvKqO0RS32QR52EXKi2dJ7XSMe53kskZC+qUlQb89XaAkoIt5dEov7LYQrNMOpvXKWE+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ol7Mn0Vq4w/YCICoTGWRHFxDsjM656lYWP822BoEoSg=;
 b=SqOjZW56ul/TTVA15NE5In/rT33jkYb4T3QXGH/J1DwnzQRYrz8jw4k771qhu35UuXc6Rc+t9hIujj53hQNljQmVMoK4mTFq5l9vM6KS8Xq4VzWAcnvcSsqSV/TCYvm9EinjeesjjxoTyqhRUEvEKX0eZ2ltZjWqdF8iHXbbR4Shu3/WmP30XWZdw4pWoB6daMtT7mzERA6bCDNi/ukuVzY2cDg1exhRKZlCAJKlwghq2PqO4zKT09mt1yWozdMKsWNHNiMJQXPhYgjTCsvp1pP/t9WTXRlbBrscMRkUQzdj+SJfaCWBlGdGYZo9VhgyVDc9qxfGpqaxk5LzmDoIFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=purdue.edu; dmarc=pass action=none header.from=purdue.edu;
 dkim=pass header.d=purdue.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=purdue0.onmicrosoft.com; s=selector2-purdue0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ol7Mn0Vq4w/YCICoTGWRHFxDsjM656lYWP822BoEoSg=;
 b=Sc8yrzLrK1+5+HjDW4u2UEVlEGjtqib4LhdpYc44XHysseDhSWtosoQsMUsrIJwLU4W/hL8FW3OCdiBjDUV/gd+xzPyb+8WvXQMomEgrCf/3Uinamq5KJVNhwFQNbr//GZx9MJl0JVOV65iUU3XofH9P1wXK82nTtAjDX2gtZnQ=
Received: from MWHPR2201MB1072.namprd22.prod.outlook.com
 (2603:10b6:301:33::18) by CY4PR22MB0088.namprd22.prod.outlook.com
 (2603:10b6:903:15::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.21; Sat, 21 May
 2022 17:01:42 +0000
Received: from MWHPR2201MB1072.namprd22.prod.outlook.com
 ([fe80::a9e9:b100:2a55:23aa]) by MWHPR2201MB1072.namprd22.prod.outlook.com
 ([fe80::a9e9:b100:2a55:23aa%3]) with mapi id 15.20.5273.017; Sat, 21 May 2022
 17:01:41 +0000
From:   "Liu, Congyu" <liu3101@purdue.edu>
To:     Dmitry Vyukov <dvyukov@google.com>
CC:     "andreyknvl@gmail.com" <andreyknvl@gmail.com>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kcov: fix race caused by unblocked interrupt
Thread-Topic: [PATCH] kcov: fix race caused by unblocked interrupt
Thread-Index: AQHYajHoHiVYwAN8JUi5UTY5PvyBWK0kVeGAgAAA0wCABFjck4AAWi6AgACIm5Y=
Date:   Sat, 21 May 2022 17:01:41 +0000
Message-ID: <MWHPR2201MB10723CCBB4869738E4BDFC36D0D29@MWHPR2201MB1072.namprd22.prod.outlook.com>
References: <20220517210532.1506591-1-liu3101@purdue.edu>
 <CACT4Y+Z+HtUttrd+btEWLj5Nut4Gv++gzCOL3aDjvRTNtMDEvg@mail.gmail.com>
 <CACT4Y+bAGVLU5QEUeQEHth6SZDOSzy0CRKEJQioC0oKHSPaAbA@mail.gmail.com>
 <MWHPR2201MB10724669E6D80EDFDB749478D0D29@MWHPR2201MB1072.namprd22.prod.outlook.com>
 <CACT4Y+bXyiwEznZkAH5vRNd6YK3gi4aCncQLYt3iMWy43+T4EQ@mail.gmail.com>
In-Reply-To: <CACT4Y+bXyiwEznZkAH5vRNd6YK3gi4aCncQLYt3iMWy43+T4EQ@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 27f1dff5-781b-b168-e29a-e2c58d0d881b
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=purdue.edu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9745fced-50d0-4071-269c-08da3b4b93f5
x-ms-traffictypediagnostic: CY4PR22MB0088:EE_
x-microsoft-antispam-prvs: <CY4PR22MB008866C8B7893983057461AAD0D29@CY4PR22MB0088.namprd22.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: t4tQ9ITxJOfLmOqly2Nx9QqXTlYEiyfcgGOQDYfAfPsyMM13NZXx8h7NGXj6QILbcM4CMoMPq8NsE7NR5W11lhAnqVELniFgPQMCgHIl08qpVjDyoKTYmw6/B1stnPn68REXRwQWoXa+3KT6Uu5YCqsJgB7D/mDQxQn6WA240jHTvFM1h1ZK4c44ZDr57XBN4yGcuTjOnw9fP8IJUsj3rpqqX+HF9GKrAJWT5LZ59gc3PVERrYr8fsW7b//5g0C4uIjB79x0NRfgOwKbNYSs9K+6WTiOp+0CQco1AR40+Xx2WvmTSlWswU35W0AIycOuXglaLcbmrZWHbi0Mcnq9k5Q9cPOS30nuFQhw+i6O1qf1pewAHstjfqVXboTAOndqD3o7pfEP/VNMqil/s7kPnZFSqt4WHfEWM8sJeAqDSPKfobRc5uP8hL/efEeUTMoWnT2Ci32fO39w7ej9sXdWCfmaiWw4smXxis33O1mmo6MvjSjNeQys3JSdpRk3v1y9FJWQX71BxIRLaimPLsOJFRbaWfkyQEmXxS5g71GJUnyolJEER2x0iE9oNH1zY+Sq974Jothv+XmA/WBz9+EM3pxZVMdoNXi4BshL9K4hmlIveqTozdFGNxrv9e325we086FL2Dp5H/80GOXhbnVaHRqtYbv9vY/E+7bs4Uawab+Mt71TSMhDaEPYu465ZyuO2EQpgO9XIMS7q9pkIQv+vtivElg1jBKvVnor2uI51sitocMhQQq6RSmz8jsHxnzdL7REs0NwFya+OHatDvPhjjJ8hLiemO3smrNfY90OM+Q=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR2201MB1072.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(64756008)(66476007)(66556008)(66446008)(66946007)(76116006)(8676002)(83380400001)(8936002)(91956017)(52536014)(2906002)(4326008)(33656002)(5660300002)(186003)(122000001)(71200400001)(75432002)(9686003)(53546011)(7696005)(54906003)(38070700005)(38100700002)(786003)(316002)(86362001)(6506007)(6916009)(55016003)(966005)(508600001)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?xPl3QfnTB5+6IlBSxZOhtoXghoiynDX3rvo66N3xU6rC3jcrpGGatFz7VV?=
 =?iso-8859-1?Q?320OS9pi56k5BrmuIQu7RRwBHaBRaDtGkn30iUJnVVJEF9bJFF4kefqGQ6?=
 =?iso-8859-1?Q?PL9MH9miOcimk4Flb6LWFv2D3dP2jaMoi3v4G8g5ikZN95xJMswfotH+Av?=
 =?iso-8859-1?Q?l+Ir0trTwG2ovi4hILSSQn6LLSfLcQoe9ryBx9GK566v/m3uNgGFA3ECGZ?=
 =?iso-8859-1?Q?g9Q2tCC/+vguXeZiO8TMAFAhRK+utxGPOqQz3LyfanjG1eqbCGJiRiz6Nu?=
 =?iso-8859-1?Q?hqCI/SCdTkzuyoHMmbieJM8G0TNvwyRab0OyPUIEp/4M55w9NOmCOTqAMp?=
 =?iso-8859-1?Q?UAoaWd1dOM/KXLUQRIVVmkwbC4rjYTYDeb7mW4EuWeDJbURnqJ3jgwBE/8?=
 =?iso-8859-1?Q?ZB4ZEOHNDIQOppkRMzXzWVSVd4sW7DszaBuEmB9zL4pkSdWXDHa5XtzPaY?=
 =?iso-8859-1?Q?BYkQtdv6oDqfFhIj2UU/Dy7nWbFPbhdcAsbKD5qudaUUE1VYdA52vwCOcL?=
 =?iso-8859-1?Q?uzTLi8gHBeSFFU45HQ2jMpDEEufm5z6MCBVs8hXDv576s7g1ZKY7vYD1iX?=
 =?iso-8859-1?Q?7Vsb+tYxZ5Gt2Lr7Htl+Q45tmq7J4e01P6XbXpoTjO3oovkekC9ccrSri5?=
 =?iso-8859-1?Q?8wznbHQEVFaC9M+1cUImujLl5pNYVawO9gS6wtn/uovBnW5+vYXu7BcICT?=
 =?iso-8859-1?Q?eQCtJlKkPXPwrY/EIOZUSvUlt7Ld0r1c/6nSqIjy3ABGFE/qn6KYfsoJv+?=
 =?iso-8859-1?Q?2Md5v7Eg0Z+nHXk9maJHrPBo0t2gxQ4cB/Obk2UgQKI7b8lZVpGalCYIii?=
 =?iso-8859-1?Q?8db37T9JmVqLM4apMnE0rslf8t9CgfOu003TEYFmT2U6wsUfW828hI2BH2?=
 =?iso-8859-1?Q?PFh1vylcgS6QLkw9EVHSeJAh+LO44tFHFldNQpH+wpWyrRasCh4KFTviKn?=
 =?iso-8859-1?Q?r5FPn7/FOegsa9IyT9rolAceIfGzTBqJMInr0UmtTO3ie1w9irLTr7CP1V?=
 =?iso-8859-1?Q?9UpY7NdW3csCMBR30mwfVoVv24mZwaa8rYAhqtHuG60LVk/Ic1mpPvHC/R?=
 =?iso-8859-1?Q?FfvfEEUeN3AlIxbsoq5W3aaUVeinomKgo1JfGfKZ2sIHK7y7o+SyNjoOlG?=
 =?iso-8859-1?Q?AqbVVC1jf18eDWX34O+S9qyNi74zaRdlbA7CPPD4ItV9IbvUZToZb4QEie?=
 =?iso-8859-1?Q?0HoC4lummF83a1U08jjYRcqcpEAIxM9TpcRIuG0tn4UtWfeOJpVjsZiWiT?=
 =?iso-8859-1?Q?XMwzzpzHNxvc4lhwd+zVfWdZfpuOkYtHYP7JxeJJSUXT0Ydmju6KZl9fub?=
 =?iso-8859-1?Q?JWPjbSdQi0PmkAhQR5p+8FBk+7zRH+31kGrNpk643kWqzadXAgvNEmTG8o?=
 =?iso-8859-1?Q?0LuCzDPBsrdijFnCbyKbXSaLEiOFN44KenkNtGY3vBR1JHrNIqlUnZu9NM?=
 =?iso-8859-1?Q?w8dUW4EBDRa+JZ9675shTfHVxjsroWSNbItxlaS2UdWXNxTWSZCrflvSyI?=
 =?iso-8859-1?Q?dm0E77mxQQQBxH2S0MntdGgpaXGsNpYOs6w8O78HJqN6Hfn0HXmokwnP9E?=
 =?iso-8859-1?Q?XQHHR2oK8zAIvAAjLFmWE52OyZYetRGh36SJEI5pFRo/WHcQ6vSu/8zaOV?=
 =?iso-8859-1?Q?Oxhx/6m2cC4tP3gtaWZECrONenhKl27wbfDOnw6hj4HsDBPPeRuGrLkDJw?=
 =?iso-8859-1?Q?tmDa6s6mGl9P8/KrmMv+Hg5UsjckcW4kswneRqog0/h2v+c1Ym0l7DO2RS?=
 =?iso-8859-1?Q?zbn8R5+dI8uXzdPjiPThoWUukradMk+Wk4pc6B80O9/346?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: purdue.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR2201MB1072.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9745fced-50d0-4071-269c-08da3b4b93f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2022 17:01:41.7093
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4130bd39-7c53-419c-b1e5-8758d6d63f21
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6EMUhxYqlyCUA88nNNYRcuP36RFm+hVB6zoBeRsS7U/ar3ZJxSMOCwi+d4qYh/KdDZ0JqGsnnkY3NEftrd6a4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR22MB0088
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I just collected some call stacks when `__sanitizer_cov_trace_pc` is recurs=
ively invoked by checking `kcov_writing` flag.=0A=
=0A=
Here are some examples:=0A=
=0A=
__sanitizer_cov_trace_pc+0xe4/0x100=0A=
trace_hardirqs_off_finish+0x21f/0x270=0A=
irqentry_enter+0x2b/0x50=0A=
sysvec_apic_timer_interrupt+0xb/0xc0=0A=
asm_sysvec_apic_timer_interrupt+0x12/0x20=0A=
__sanitizer_cov_trace_pc+0x91/0x100=0A=
file_update_time+0x68/0x520=0A=
pipe_write+0x1279/0x1ac0=0A=
new_sync_write+0x421/0x650=0A=
vfs_write+0x7ae/0xa60=0A=
ksys_write+0x1ee/0x250=0A=
do_syscall_64+0x3a/0xb0=0A=
entry_SYSCALL_64_after_hwframe+0x44/0xae=0A=
=0A=
__sanitizer_cov_trace_pc+0xe4/0x100=0A=
_find_first_zero_bit+0x52/0xb0=0A=
__lock_acquire+0x1ac2/0x4f70=0A=
lock_acquire+0x1ab/0x4f0=0A=
_raw_spin_lock+0x2a/0x40=0A=
rcu_note_context_switch+0x299/0x16e0=0A=
__schedule+0x1fd/0x2320=0A=
preempt_schedule_irq+0x4e/0x90=0A=
irqentry_exit+0x31/0x80=0A=
asm_sysvec_apic_timer_interrupt+0x12/0x20=0A=
__sanitizer_cov_trace_pc+0x75/0x100=0A=
xas_descend+0x16b/0x340=0A=
xas_load+0xe5/0x140=0A=
pagecache_get_page+0x179/0x18d0=0A=
__find_get_block+0x478/0xd00=0A=
__getblk_gfp+0x32/0xb40=0A=
ext4_getblk+0x1cf/0x680=0A=
ext4_bread_batch+0x80/0x5a0=0A=
__ext4_find_entry+0x460/0xfc0=0A=
ext4_lookup+0x4fc/0x730=0A=
__lookup_hash+0x117/0x180=0A=
filename_create+0x186/0x490=0A=
unix_bind+0x322/0xbc0=0A=
__sys_bind+0x20c/0x260=0A=
__x64_sys_bind+0x6e/0xb0=0A=
do_syscall_64+0x3a/0xb0=0A=
entry_SYSCALL_64_after_hwframe+0x44/0xae=0A=
=0A=
=0A=
__sanitizer_cov_trace_pc+0xe4/0x100=0A=
prandom_u32+0xd/0x460=0A=
trace_hardirqs_off_finish+0x60/0x270=0A=
irqentry_enter+0x2b/0x50=0A=
sysvec_apic_timer_interrupt+0xb/0xc0=0A=
asm_sysvec_apic_timer_interrupt+0x12/0x20=0A=
__sanitizer_cov_trace_pc+0x9a/0x100=0A=
__es_remove_extent+0x726/0x15e0=0A=
ext4_es_insert_delayed_block+0x216/0x580=0A=
ext4_da_get_block_prep+0x88f/0x1180=0A=
__block_write_begin_int+0x3ef/0x1630=0A=
block_page_mkwrite+0x223/0x310=0A=
ext4_page_mkwrite+0xbf7/0x1a30=0A=
do_page_mkwrite+0x1a7/0x530=0A=
__handle_mm_fault+0x2c71/0x5240=0A=
handle_mm_fault+0x1bc/0x7b0=0A=
do_user_addr_fault+0x59b/0x1200=0A=
exc_page_fault+0x9e/0x170=0A=
asm_exc_page_fault+0x1e/0x30=0A=
=0A=
Looks like `asm_sysvec_apic_timer_interrupt` is culprit.=0A=
=0A=
________________________________________=0A=
From: Dmitry Vyukov <dvyukov@google.com>=0A=
Sent: Saturday, May 21, 2022 4:45=0A=
To: Liu, Congyu=0A=
Cc: andreyknvl@gmail.com; kasan-dev@googlegroups.com; linux-kernel@vger.ker=
nel.org=0A=
Subject: Re: [PATCH] kcov: fix race caused by unblocked interrupt=0A=
=0A=
On Sat, 21 May 2022 at 05:59, Liu, Congyu <liu3101@purdue.edu> wrote:=0A=
>=0A=
> Hi Dmitry,=0A=
>=0A=
> Sorry for the late reply. I did some experiments and hopefully they could=
 be helpful.=0A=
>=0A=
> To get the PC of the code that tampered with the buffer, I added some cod=
e between `area[pos] =3D ip;` and `WRITE_ONCE(area[0], pos);`: First, some =
code to delay for a while (e.g. for loop to write something). Then read `ar=
ea[0]` and compare it with `pos`. If they are different, then `area[pos]` i=
s tampered. A mask is then added to `area[pos]` so I can identify and retri=
eve it later.=0A=
>=0A=
> In this way, I ran some test cases then get a list of PCs that tampered w=
ith the kcov buffer, e.g., ./include/linux/rcupdate.h:rcu_read_lock, arch/x=
86/include/asm/current.h:get_current, include/sound/pcm.h:hw_is_interval, n=
et/core/neighbour.c:neigh_flush_dev, net/ipv6/addrconf.c:__ipv6_dev_get_sad=
dr, mm/mempolicy.c:__get_vma_policy...... It seems that they are not from t=
he early interrupt code. Do you think they should not be instrumented?=0A=
=0A=
Humm... these look strange. They don't look like early interrupt code,=0A=
but they also don't look like interrupt code at all. E.g.=0A=
neigh_flush_dev looks like a very high level function that takes some=0A=
mutexes:=0A=
https://elixir.bootlin.com/linux/v5.18-rc7/source/net/core/neighbour.c#L320=
=0A=
=0A=
It seems that there is something happening that we don't understand.=0A=
=0A=
Please try to set t->kcov_writing around the task access, and then if=0A=
you see it recursively already set print the current pc/stack trace.=0A=
That should give better visibility into what code enters kcov=0A=
recursively.=0A=
=0A=
If you are using syzkaller tools, you can run syz-execprog with -cover=0A=
flag on some log file, or run some program undef kcovtrace:=0A=
https://github.com/google/syzkaller/blob/master/tools/kcovtrace/kcovtrace.c=
=0A=
=0A=
=0A=
=0A=
> I think reordering `area[pos] =3D ip;` and `WRITE_ONCE(area[0], pos);` is=
 also a smart solution since PC will be written to buffer only after the bu=
ffer is reserved.=0A=
>=0A=
> Thanks,=0A=
> Congyu=0A=
>=0A=
> ________________________________________=0A=
> From: Dmitry Vyukov <dvyukov@google.com>=0A=
> Sent: Wednesday, May 18, 2022 4:59=0A=
> To: Liu, Congyu=0A=
> Cc: andreyknvl@gmail.com; kasan-dev@googlegroups.com; linux-kernel@vger.k=
ernel.org=0A=
> Subject: Re: [PATCH] kcov: fix race caused by unblocked interrupt=0A=
>=0A=
> On Wed, 18 May 2022 at 10:56, Dmitry Vyukov <dvyukov@google.com> wrote:=
=0A=
> >=0A=
> > On Tue, 17 May 2022 at 23:05, Congyu Liu <liu3101@purdue.edu> wrote:=0A=
> > >=0A=
> > > Some code runs in interrupts cannot be blocked by `in_task()` check.=
=0A=
> > > In some unfortunate interleavings, such interrupt is raised during=0A=
> > > serializing trace data and the incoming nested trace functionn could=
=0A=
> > > lead to loss of previous trace data. For instance, in=0A=
> > > `__sanitizer_cov_trace_pc`, if such interrupt is raised between=0A=
> > > `area[pos] =3D ip;` and `WRITE_ONCE(area[0], pos);`, then trace data =
in=0A=
> > > `area[pos]` could be replaced.=0A=
> > >=0A=
> > > The fix is done by adding a flag indicating if the trace buffer is be=
ing=0A=
> > > updated. No modification to trace buffer is allowed when the flag is =
set.=0A=
> >=0A=
> > Hi Congyu,=0A=
> >=0A=
> > What is that interrupt code? What interrupts PCs do you see in the trac=
e.=0A=
> > I would assume such early interrupt code should be in asm and/or not=0A=
> > instrumented. The presence of instrumented traced interrupt code is=0A=
> > problematic for other reasons (add random stray coverage to the=0A=
> > trace). So if we make it not traced, it would resolve both problems at=
=0A=
> > once and without the fast path overhead that this change adds.=0A=
>=0A=
> Also thinking if reordering `area[pos] =3D ip;` and `WRITE_ONCE(area[0], =
pos);`=0A=
> will resolve the problem without adding fast path overhead.=0A=
> However, not instrumenting early interrupt code still looks more preferab=
le.=0A=
>=0A=
>=0A=
>  > Signed-off-by: Congyu Liu <liu3101@purdue.edu>=0A=
> > > ---=0A=
> > >  include/linux/sched.h |  3 +++=0A=
> > >  kernel/kcov.c         | 16 ++++++++++++++++=0A=
> > >  2 files changed, 19 insertions(+)=0A=
> > >=0A=
> > > diff --git a/include/linux/sched.h b/include/linux/sched.h=0A=
> > > index a8911b1f35aa..d06cedd9595f 100644=0A=
> > > --- a/include/linux/sched.h=0A=
> > > +++ b/include/linux/sched.h=0A=
> > > @@ -1408,6 +1408,9 @@ struct task_struct {=0A=
> > >=0A=
> > >         /* Collect coverage from softirq context: */=0A=
> > >         unsigned int                    kcov_softirq;=0A=
> > > +=0A=
> > > +       /* Flag of if KCOV area is being written: */=0A=
> > > +       bool                            kcov_writing;=0A=
> > >  #endif=0A=
> > >=0A=
> > >  #ifdef CONFIG_MEMCG=0A=
> > > diff --git a/kernel/kcov.c b/kernel/kcov.c=0A=
> > > index b3732b210593..a595a8ad5d8a 100644=0A=
> > > --- a/kernel/kcov.c=0A=
> > > +++ b/kernel/kcov.c=0A=
> > > @@ -165,6 +165,8 @@ static notrace bool check_kcov_mode(enum kcov_mod=
e needed_mode, struct task_stru=0A=
> > >          */=0A=
> > >         if (!in_task() && !(in_serving_softirq() && t->kcov_softirq))=
=0A=
> > >                 return false;=0A=
> > > +       if (READ_ONCE(t->kcov_writing))=0A=
> > > +               return false;=0A=
> > >         mode =3D READ_ONCE(t->kcov_mode);=0A=
> > >         /*=0A=
> > >          * There is some code that runs in interrupts but for which=
=0A=
> > > @@ -201,12 +203,19 @@ void notrace __sanitizer_cov_trace_pc(void)=0A=
> > >                 return;=0A=
> > >=0A=
> > >         area =3D t->kcov_area;=0A=
> > > +=0A=
> > > +       /* Prevent race from unblocked interrupt. */=0A=
> > > +       WRITE_ONCE(t->kcov_writing, true);=0A=
> > > +       barrier();=0A=
> > > +=0A=
> > >         /* The first 64-bit word is the number of subsequent PCs. */=
=0A=
> > >         pos =3D READ_ONCE(area[0]) + 1;=0A=
> > >         if (likely(pos < t->kcov_size)) {=0A=
> > >                 area[pos] =3D ip;=0A=
> > >                 WRITE_ONCE(area[0], pos);=0A=
> > >         }=0A=
> > > +       barrier();=0A=
> > > +       WRITE_ONCE(t->kcov_writing, false);=0A=
> > >  }=0A=
> > >  EXPORT_SYMBOL(__sanitizer_cov_trace_pc);=0A=
> > >=0A=
> > > @@ -230,6 +239,10 @@ static void notrace write_comp_data(u64 type, u6=
4 arg1, u64 arg2, u64 ip)=0A=
> > >         area =3D (u64 *)t->kcov_area;=0A=
> > >         max_pos =3D t->kcov_size * sizeof(unsigned long);=0A=
> > >=0A=
> > > +       /* Prevent race from unblocked interrupt. */=0A=
> > > +       WRITE_ONCE(t->kcov_writing, true);=0A=
> > > +       barrier();=0A=
> > > +=0A=
> > >         count =3D READ_ONCE(area[0]);=0A=
> > >=0A=
> > >         /* Every record is KCOV_WORDS_PER_CMP 64-bit words. */=0A=
> > > @@ -242,6 +255,8 @@ static void notrace write_comp_data(u64 type, u64=
 arg1, u64 arg2, u64 ip)=0A=
> > >                 area[start_index + 3] =3D ip;=0A=
> > >                 WRITE_ONCE(area[0], count + 1);=0A=
> > >         }=0A=
> > > +       barrier();=0A=
> > > +       WRITE_ONCE(t->kcov_writing, false);=0A=
> > >  }=0A=
> > >=0A=
> > >  void notrace __sanitizer_cov_trace_cmp1(u8 arg1, u8 arg2)=0A=
> > > @@ -335,6 +350,7 @@ static void kcov_start(struct task_struct *t, str=
uct kcov *kcov,=0A=
> > >         t->kcov_size =3D size;=0A=
> > >         t->kcov_area =3D area;=0A=
> > >         t->kcov_sequence =3D sequence;=0A=
> > > +       t->kcov_writing =3D false;=0A=
> > >         /* See comment in check_kcov_mode(). */=0A=
> > >         barrier();=0A=
> > >         WRITE_ONCE(t->kcov_mode, mode);=0A=
> > > --=0A=
> > > 2.34.1=0A=
> > >=0A=
