Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1002158F20F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 20:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233182AbiHJSAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 14:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233297AbiHJSAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 14:00:35 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-eastusazon11010001.outbound.protection.outlook.com [52.101.51.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E26237DB
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 11:00:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K39qCi15UM1+VqOOc+4AVx/9cMh06a2A/ghf7hkfU052M9leoWNn6enpNf/Kl/zj1z1+NzzN16UwanpnERy7xduuhFgBGm6I9nh9y/n6/aB3h9rtvJzbjQNlBTn4BOiqcN8Gi0KEvArSXjfcssluvdFGoepvVZqTMFm197yy4QZeqIw4dKVAn9suaCzHhnZfr1ktoCFxhdRtyEoZgNEagvWhHYM76H6TpB/5HDQz3naKr9Q8fsPGrsTWsUwy4xj8lnikSqnc8XBK7W6Yn9HYmTX+UoIi/xJC3FhezlpQy1q40i8N7n+ydUWCxGp89W0sofIT0t3jEKqBcSBK0HePPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GSybfqhm77nGJ9sou2MJaSweQxuYXDsvoEHeZicSX0c=;
 b=OK9+rPDiGzw7v4BLBxofJMxLxagbrjjlG2Y5Ym/HMSwq+g34+iOf7bunjiQRFYpgqLNFy/5pFmN1UdskrAl0myU5UYWgqcfm5/bR1aonymUsVtOF8JIsec65J/FfklvDpzNk6nUr2qA2RE9z6os2KdNQJIjde4VZOMpV36CXqLsobJ1wEyJXm9o7bspkJEbiLiPTQhwt1BJKVzaxXpNho+wwQokj3YalselIBzgaT8CH2Fdl4yXH9IfO3y8C/SH/eNBUR6Fj40cMZyp/xw95Pu/i6tsgRjl2JuJ1mHKqaAlFiAtpBegaAPBcPIumxmK2V6K+IKVgtg06NVrdmOejEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GSybfqhm77nGJ9sou2MJaSweQxuYXDsvoEHeZicSX0c=;
 b=O2ElNaL2JJHoj+AVBvqfvYbTZd2FqDsOnxjFhrnZYqbnDDHnkDNYdWnLSjDmyUdLqfGKZtDILRzrgZBb2pdKxubQGBNzBM9maVdaAo1t7eXTUmc/JfydE509xkahaUmJvVXSi9FD4SofLwuUPcS9VsLyyhGo/8+C4S4jPFGohXo=
Received: from BYAPR05MB3960.namprd05.prod.outlook.com (2603:10b6:a02:88::12)
 by CY4PR05MB3127.namprd05.prod.outlook.com (2603:10b6:903:f6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.9; Wed, 10 Aug
 2022 18:00:30 +0000
Received: from BYAPR05MB3960.namprd05.prod.outlook.com
 ([fe80::959e:de9c:2ea:213a]) by BYAPR05MB3960.namprd05.prod.outlook.com
 ([fe80::959e:de9c:2ea:213a%5]) with mapi id 15.20.5438.010; Wed, 10 Aug 2022
 18:00:30 +0000
From:   Vishnu Dasa <vdasa@vmware.com>
To:     "Dae R. Jeong" <threeearcat@gmail.com>
CC:     Bryan Tan <bryantan@vmware.com>,
        Pv-drivers <Pv-drivers@vmware.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: general protection fault in add_wait_queue_exclusive
Thread-Topic: general protection fault in add_wait_queue_exclusive
Thread-Index: AQHYlRRQe6QNgCTs2ECELt3nMSLYtq2om/6A
Date:   Wed, 10 Aug 2022 18:00:30 +0000
Message-ID: <8596EA8E-A791-4908-B60B-CC3237A0C7CF@vmware.com>
References: <YswA4H+2l9qkIsrq@archdragon>
In-Reply-To: <YswA4H+2l9qkIsrq@archdragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9c02c6b2-61ee-433b-f004-08da7afa3683
x-ms-traffictypediagnostic: CY4PR05MB3127:EE_
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TGQW+u/bBb5m3QSQPXiwodJODF70MvtkELg6BK/jlM3BQa18JJ49wVjGw9tZx0YXK9SoQx35O8Tb9HZs9bojRMeG4bJUPDDs5TOMXqmTIkNNwuOSNwJ6lwJUGLI/LLmt2VKbQmKgwzqCgAcq7JxILUndOUhGscIrOemkcgz7LQniYI9qiEDknpX3POqC0jOv/1CtCYJnVoTycECjz9vBpMtiNtTe2BuEBs+vmsyGaRnJeSlUt7+oO4o9UWO1JbL1ZNbYQSPS5QXXxGl4b93hj9z4cFruCgyl8I327eyKeOuTYBDBfWpVf9O3SrzCItSc1hruxvO6usW0V6uYluXwLiFWzO7xrWMVP36KznXbrm9uAWAa1npfvHemZ49GxF0jJb5z/6lrjgs8+Ub0XSikwlRLu8XUDvFFENlEz+3s8atjOT6m9t/ytm95IE5OnOPx9Pwyo63wCBVcm2+zifFuoooWN552kDeJlFsWztHgEd2GCvXbVFiV+Vbvap1RfMw5jrgeWyMBc2a6Pp6EOKM6yKXYddo1oTBjgzZaSdWJX9ogGdET9Liw3SulO8ctKooAhe1NXo/yVK56P6co/+SHhEyjb80kYwiWsHVHezvUTdw2ehUw8yqJOqfOAkRu4eVmxK++ZUxKW4+mAObLrWKeBLG2Koca+Cd8MGA6zTxnE2P7drmky2F7cZhABflCj7hPvHdPRZoQvrzfoK3C21NbQenEWjcsegOlCLmgInw+gl7HIsk7of1MFvW9r6JJr4nhO3UyB0DwFCIzF43nK2z7+2SLPZH/i7KLMoLNPVQ+6VVcaCT+A6X8ipxlTykz9oGGfPTaxL8jZrm5Y/MwSlP5XQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR05MB3960.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(396003)(366004)(39860400002)(346002)(136003)(36756003)(38070700005)(66946007)(66476007)(64756008)(53546011)(66556008)(66446008)(38100700002)(76116006)(8676002)(6512007)(6506007)(2906002)(54906003)(6916009)(478600001)(4326008)(86362001)(6486002)(45080400002)(316002)(41300700001)(71200400001)(186003)(122000001)(2616005)(83380400001)(33656002)(8936002)(5660300002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?51PyuSzxF/IM0D2YTv/xtlPsvfg+4uoDCtd2iXWDtKK7nMvodNC8QwRbuPnJ?=
 =?us-ascii?Q?sGj/hx5heLUJ70jCkA3MzeTam9j2WX0/5gH3ey9MedrhlqFM3hZnSL30gFPU?=
 =?us-ascii?Q?15TQFrcrCK0JZS0D58BEeBo2h0UJsDuSW27gqXHlL5ImClCgDVMGQUcl3DR4?=
 =?us-ascii?Q?UtWObb66U/ZYTE/GwAjljdm49oCjHMZiCBqe2pOs/ACNXDA2GaZ1bhSCEhHw?=
 =?us-ascii?Q?AeEnCc5XNsNf3vx8UNeYM+zYQOLRq3vj6rVIy4t7breBYIBEK+qPfRE2AZAL?=
 =?us-ascii?Q?/sNNan/mNQBgI1E48Sw83BjU/QkwUzJa1b4IQHRagb3d6X9pHk19TStCSlxq?=
 =?us-ascii?Q?CIsYzCKfxlw1BwcYYsQuUJ3CdwK0XgT3N4f0hQlvbwGiwh6ZP2eTipfSAG0n?=
 =?us-ascii?Q?mpqSnzSIQww50Isds8Ne1kOwKXCIF/VnDVbTJO1slq+F0/XKkBD/mhKAkIeB?=
 =?us-ascii?Q?Wk7eNJuhd69QUVtECm4YqFs3xYYIy8eBiQ0vQIahgaJO/ilmTruwye1SgYiD?=
 =?us-ascii?Q?blGKxFCDsU2Kuo+Fsg/zq1e73M3D7dR340tt5ctI9HYiggeN+c0hS8ysi/Pl?=
 =?us-ascii?Q?3qqSK+OAjaWvyLrWEapITDeci6b21+XGQMTdWyCiqpzwZcrRG/wulngurQ3z?=
 =?us-ascii?Q?Qn6OAk9UQSfe36wOyQjzayCwsq4km5/oJMA1jaSLxVJcxxdop2Ow31nSkMDs?=
 =?us-ascii?Q?nv/Ev3vmOAOx50I+lSbpDWOOETbTQ8HxSlPBr3RjuNkti+xU+GwIYYBRTbTO?=
 =?us-ascii?Q?clahGZuy9ZBreuzruiwfhdN5Dz7a7xmt7bjC127JWzBR5M+2trlYNiSRyuBw?=
 =?us-ascii?Q?9rl+T81l4Hvak3h83cfEWd5w2l9maYZNzN067tblIvXQOf1AQUW3LJZwmrrb?=
 =?us-ascii?Q?09T7dKHb6WqVcAoySivP62ZEsFK5tXc8Sv+UWQ2GSTEAdtiIxuGYM5xQTMPB?=
 =?us-ascii?Q?8Rlm2l+k8xVcTz1gadkdQ341r5IvHbBC0t5f1RNWviqzDMZ+OjKDzjoC8PcH?=
 =?us-ascii?Q?RpR1d/BNnsuJk8UD46Lhi1pjdWozLcU31PB6VW7jwDQWoT5RnGOka5Hpoadh?=
 =?us-ascii?Q?O1dY8tqNasYR9Mff/1lzyM391DpSsm0JHT8xbt1bUtLMQ7AAiVSpiadKwZlH?=
 =?us-ascii?Q?xZP3SVIeRp35Q01tIDLAEEQhHh+cP+1gftt4WDJCuJ3fkgNjtG9H9JamakDS?=
 =?us-ascii?Q?GYordwmHKSXrBTdRoX8AQCkDIlYKDeaUEs6X96CzMWVsuEKKf1XnW281qxod?=
 =?us-ascii?Q?Q/XQ18dlIeabtDXxoCBE+esjkec8pxab0hRLrYYdeASbbefNU+ScaoCgpwzn?=
 =?us-ascii?Q?US1lHl+cpB//pm4igb5ONKfBza6Mw+2lWOCO+iLvzun63MhL1ALFalJPBBNU?=
 =?us-ascii?Q?ky6E+fqUh5OCziy3nv2bAQLkMjD4vfwn1HGkZvfAyRePjAYieSWM7uqnhTX7?=
 =?us-ascii?Q?rTTL4QbfMLk39ajwtjxb2utL9EkZI5AU6VOzAVA9DaDSft6JFQ6FVim6uZZT?=
 =?us-ascii?Q?V/HE36WsuPDFz1BLInSkNIH5qb5DrBkoKBd2Lg3CzJKDKlLoFK32vBWhgOcc?=
 =?us-ascii?Q?45ItFFcIzFN3tFEmbvoyUsmTQsuWHgHHb4Uo5pF/Ev1vGpcq+lsfcPY/wjvm?=
 =?us-ascii?Q?g4wjJdcGRWeyTB3qI9Zya/VVEGSh//a67i/nwEkxNpXr?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E8D0AFD108D406428DF3F4D85032DAEB@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR05MB3960.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c02c6b2-61ee-433b-f004-08da7afa3683
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2022 18:00:30.0906
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3X6fWF2cINbsDT8g3xbxkQmB4e5OOeS7eeE4oQJJGjdWg+vf+iVdOdURp42qT8p875NhuLz0ktJ2eOKHLee5lQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR05MB3127
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for reporting this.  We have filed an internal bug and will look =
into it.

Regards,
Vishnu

> On Jul 11, 2022, at 3:52 AM, Dae R. Jeong <threeearcat@gmail.com> wrote:
>=20
> Hello,
>=20
> We observed a crash "general protection fault in
> add_wait_queue_exclusive" during fuzzing.
>=20
> Unfortunately, we have not found a reproducer for the crash yet. We
> will inform you if we have any update on this crash.
>=20
>=20
> Detailed crash information is attached at the end of this email.
>=20
> Best regards,
> Dae R. Jeong
> ------
>=20
> - Kernel commit:
> 92f20ff72066d
>=20
> - Crash report:
> general protection fault, probably for non-canonical address 0xdffffc0000=
000019: 0000 [#1] PREEMPT SMP KASAN
> KASAN: null-ptr-deref in range [0x00000000000000c8-0x00000000000000cf]
> CPU: 2 PID: 14077 Comm: syz-executor.0 Not tainted 5.19.0-rc3-32288-g0f3b=
08299494 #15
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-=
g155821a1990b-prebuilt.qemu.org 04/01/2014
> RIP: 0010:__lock_acquire+0xf3/0x5e00 kernel/locking/lockdep.c:4926
> Code: 89 bc 24 88 00 00 00 0f 85 02 27 00 00 83 3d 1b 16 66 10 00 0f 84 9=
7 43 00 00 83 3d d6 ea f9 0e 00 74 31 48 89 f8 48 c1 e8 03 <42> 80 3c 00 00=
 74 17 e8 81 63 86 00 48 8b bc 24 88 00 00 00 49 b8
> RSP: 0018:ffffc9000ea575e0 EFLAGS: 00010002
> RAX: 0000000000000019 RBX: 0000000000000001 RCX: 1ffff92001d4aedc
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000000000c8
> RBP: ffffc9000ea57970 R08: dffffc0000000000 R09: 0000000000000001
> R10: fffffbfff2394d5e R11: 0000000000000000 R12: 0000000000000000
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000001
> FS:  00007f44e25aa700(0000) GS:ffff8880b9300000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000056077effb180 CR3: 0000000028845000 CR4: 00000000003506e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
> <TASK>
> lock_acquire+0x1a4/0x4a0 kernel/locking/lockdep.c:5672
> __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
> _raw_spin_lock_irqsave+0xb3/0x100 kernel/locking/spinlock.c:162
> add_wait_queue_exclusive+0x3c/0x130 kernel/sched/wait.c:33
> ep_ptable_queue_proc+0x1b1/0x370 fs/eventpoll.c:1259
> poll_wait include/linux/poll.h:49 [inline]
> vmci_host_poll+0xf8/0x2b0 drivers/misc/vmw_vmci/vmci_host.c:174
> vfs_poll include/linux/poll.h:88 [inline]
> ep_item_poll fs/eventpoll.c:853 [inline]
> ep_insert fs/eventpoll.c:1522 [inline]
> do_epoll_ctl+0x2f84/0x4a90 fs/eventpoll.c:2141
> __do_sys_epoll_ctl fs/eventpoll.c:2192 [inline]
> __se_sys_epoll_ctl fs/eventpoll.c:2183 [inline]
> __x64_sys_epoll_ctl+0x19d/0x230 fs/eventpoll.c:2183
> do_syscall_x64 arch/x86/entry/common.c:51 [inline]
> do_syscall_64+0x4e/0xa0 arch/x86/entry/common.c:82
> entry_SYSCALL_64_after_hwframe+0x46/0xb0
> RIP: 0033:0x478dc9
> Code: f7 d8 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 48 89 f8 48 89 f=
7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff=
 ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f44e25a9be8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e9
> RAX: ffffffffffffffda RBX: 0000000000781408 RCX: 0000000000478dc9
> RDX: 0000000000000004 RSI: 0000000000000001 RDI: 0000000000000003
> RBP: 00000000f477909a R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000020000240 R11: 0000000000000246 R12: 0000000000781500
> R13: 0000000000781414 R14: 0000000000781408 R15: 00007ffc45fbf120
> </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:__lock_acquire+0xf3/0x5e00 kernel/locking/lockdep.c:4926
> Code: 89 bc 24 88 00 00 00 0f 85 02 27 00 00 83 3d 1b 16 66 10 00 0f 84 9=
7 43 00 00 83 3d d6 ea f9 0e 00 74 31 48 89 f8 48 c1 e8 03 <42> 80 3c 00 00=
 74 17 e8 81 63 86 00 48 8b bc 24 88 00 00 00 49 b8
> RSP: 0018:ffffc9000ea575e0 EFLAGS: 00010002
> RAX: 0000000000000019 RBX: 0000000000000001 RCX: 1ffff92001d4aedc
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000000000c8
> RBP: ffffc9000ea57970 R08: dffffc0000000000 R09: 0000000000000001
> R10: fffffbfff2394d5e R11: 0000000000000000 R12: 0000000000000000
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000001
> FS:  00007f44e25aa700(0000) GS:ffff8880b9300000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000056077effb180 CR3: 0000000028845000 CR4: 00000000003506e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

