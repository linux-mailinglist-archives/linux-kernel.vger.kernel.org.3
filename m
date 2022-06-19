Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C531F550B3F
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 16:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235412AbiFSO4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 10:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbiFSO4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 10:56:10 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B666151
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 07:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1655650564;
        bh=pnznaJlUUw5UBc3QJfxsKk4RuHhE+IQR6hwAEmf56w8=;
        h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
        b=BOIFFD4ko8JJb5lZUONikZ3taV6j8f4aQwIw+t9eKca7CgeI8utXq6D25hlAbDJJB
         a5EZyvwYGvcaDcckNETZhgLOb3cK4Vo2knF2xwxky/QtPLukZTMfsYhkukpIY4IwVS
         Rhp1Ny/uxAzynFj9vyFcR/d36PjlKo1mQ42//cII=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.178.20] ([77.8.203.205]) by mail.gmx.net (mrgmx105
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N5mGB-1ne4591gcd-017Eiw; Sun, 19
 Jun 2022 16:56:04 +0200
Message-ID: <3a043ef5-89b8-8d1e-5ffa-1a26510c03a8@gmx.de>
Date:   Sun, 19 Jun 2022 16:56:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-US
To:     linux-mm@kvack.org
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>
From:   =?UTF-8?Q?Toralf_F=c3=b6rster?= <toralf.foerster@gmx.de>
Subject: kernel splat: 5.18.5: age allocation failure:
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:14eb4V+4rxWOqdNuzlyTEHNdLwnL59AYME2dO1QcBAs/03M2FsD
 4EQKvLfLM7+JaeRSOzTly8PzWjZF6fKozAsDiomHapv4SatVNbxyEF325NIWGiFq4dMPs55
 4l+b+PZlHcXjFvCaZIT/Q0cA1KeTNn684w+t+cq/6XMGs10w/S5Wui4okvblU2j/f8NbwSf
 eSf4CqFjmcltxkYJ0sR0g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gxA34ga3zAs=:NrKnClHsYlsD5ptsLQzIfE
 O2BjyLfPYS2+nBam4wBe2AhAmv34xyBdeMaRqc/vvulp8RSkDT1zcbJBomra12hvo0jUZpzY7
 M9OCSDs/tzJxfg5rcxpx7Eh+Ac4Lwr9kdI+JSd4pmU3ma0CA0vWUCdrfBPGZiu7MdDJHIeYWW
 3k7eVR8db7dOnDwmJuhOaE9mQsClPBUAmOZr6tBk+nFX63XXDAW155dnCOvOb6e7SZEzHFRAC
 dm0feW+r3iQgHUHU1r47te//6FsbuaPjnv+MeDbjRruYwniXm9pz8hsKcEDeSuSmsBnBxO5jT
 OCKoDKtQrbCSZK5R3F5LbYtHs2rZ61XT11Kz6xmK6EE19Jz/UskiBos5K4CwfIn0n1O81oX2X
 LCv25em8Bdx3U0z//UAriSc7iNt3/V75OnnXC2y+JPP9yFosdEUANHNnHyFOrSmeVmsp6GWvg
 z6aTCLdZTWQIsa2usKZYaVNIqm5GvWXlZ/kTCW8pAAZsXBHVzdHw9dlZxaf+DIomorW+93kRG
 pSO0KmT/w4vY+7WRjJHVorahjoRlYyPXX/OXZKTFktvwOsO/e3pk8l8gTx4nDn2Uqf2JKm+Nq
 1shDj+CWunULP+K6z/CKHwzN06n+mQUl/1y5wcNv7sw0HNRcNCAHvQNRJ/flZSRdagknrhMca
 CgbwdKEEU+kbJN21r76Y8DQ7JAsM5g/HMM2YjE8CUEhbGmdg9BDDLWxVou/lTih1ipoDxeltH
 riiCtPK2cB2iE5b3XidsmdNFppJy9Q2vxN5Wa5uQw3xvKOttH+XkW1nd5DmMoLrdF5sspZAfT
 BWvepkTO058xODozYJZmW4Jjjfb7rmiIcd9tEl3028OymOUgEL5M2L0Di3plqSMPliZ9PmJsV
 Gb26+yvzTReEW20Z14ykUTu0EWOFaRvjLKoEHssOywDA8iEmBuxR5Bc6V2EP3FRioa+0fhz6D
 ZZ2x1/H0fK9PWB/dzmrXLSvyFszoV1zcL7Cc+9x9oPvM0cDqwZfqAAFriBH4QRk0+Js0wPkJq
 fkyLce8gsvuyrOXl+sbCJbePywELW08Le1zyyMWgIAiUhTdlVpzMb8n48DveTqdwhIdZdJyEg
 pxg7vtxLw+f/M9y4jnOqYwChXJSOX1CfoXYK8VLnpcXf5Ez7hYCkuh9Yw==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Got this at a hardened stable Gentoo:


mr-fox ~/linux # uname -a
Linux mr-fox 5.18.5 #7 SMP PREEMPT_DYNAMIC Thu Jun 16 14:14:17 CEST 2022
x86_64 AMD Ryzen 9 5950X 16-Core Processor AuthenticAMD GNU/Linux


Jun 18 16:37:01 mr-fox CROND[12470]: pam_unix(crond:session): session
closed for user root
Jun 18 16:37:06 mr-fox kernel: 20.p: page allocation failure: order:8,
mode:0x40dc0(GFP_KERNEL|__GFP_COMP|__GFP_ZERO),
nodemask=3D(null),cpuset=3D/,mems_allowed=3D0
Jun 18 16:37:06 mr-fox kernel: CPU: 6 PID: 26170 Comm: 20.p Tainted: G
               T 5.18.5 #7
Jun 18 16:37:06 mr-fox kernel: Hardware name: ASUS System Product
Name/Pro WS 565-ACE, BIOS 0502 01/15/2021
Jun 18 16:37:06 mr-fox kernel: Call Trace:
Jun 18 16:37:06 mr-fox kernel:  <TASK>
Jun 18 16:37:06 mr-fox kernel:  dump_stack_lvl+0x38/0x50
Jun 18 16:37:06 mr-fox kernel:  warn_alloc+0x146/0x170
Jun 18 16:37:06 mr-fox kernel:  ? __alloc_pages_direct_compact+0x1fd/0x2d0
Jun 18 16:37:06 mr-fox kernel:
__alloc_pages_slowpath.constprop.0+0xb80/0xbb0
Jun 18 16:37:06 mr-fox kernel:  ? mmap_region+0x28b/0x610
Jun 18 16:37:06 mr-fox kernel:  __alloc_pages+0x2a4/0x2d0
Jun 18 16:37:06 mr-fox kernel:  kmalloc_order+0x2c/0xb0
Jun 18 16:37:06 mr-fox kernel:  ioctx_alloc+0x4dd/0x7d0
Jun 18 16:37:06 mr-fox kernel:  __x64_sys_io_setup+0x32/0xc0
Jun 18 16:37:06 mr-fox kernel:  do_syscall_64+0x68/0xa0
Jun 18 16:37:06 mr-fox kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xae
Jun 18 16:37:06 mr-fox kernel: RIP: 0033:0x7fa16f2b9a09
Jun 18 16:37:06 mr-fox kernel: Code: 08 44 89 e0 5b 41 5c c3 66 0f 1f 84
00 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c
8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d e7 c3 0e 00 f7
d8 64 89 01 48
Jun 18 16:37:06 mr-fox kernel: RSP: 002b:00007fff2282dca8 EFLAGS:
00000246 ORIG_RAX: 00000000000000ce
Jun 18 16:37:06 mr-fox kernel: RAX: ffffffffffffffda RBX:
0000000000000001 RCX: 00007fa16f2b9a09
Jun 18 16:37:06 mr-fox kernel: RDX: 00007fa16f2b9a09 RSI:
00007fa16f0e3010 RDI: 0000000000000001
Jun 18 16:37:06 mr-fox kernel: RBP: 00007fa16f1b46c0 R08:
0000000000000000 R09: 00007fa16f3a35e0
Jun 18 16:37:06 mr-fox kernel: R10: 0000000000000000 R11:
0000000000000246 R12: 0000000000000000
Jun 18 16:37:06 mr-fox kernel: R13: 00007fa16f0e3010 R14:
00007fa16f0e3010 R15: 00007fff2282dcf4
Jun 18 16:37:06 mr-fox kernel:  </TASK>
Jun 18 16:37:06 mr-fox kernel: Mem-Info:
Jun 18 16:37:06 mr-fox kernel: active_anon:800676 inactive_anon:4257809
isolated_anon:102\x0a active_file:14441603 inactive_file:8046961
isolated_file:0\x0a unevictable:2012 dirty:487 writeback:0\x0a
slab_reclaimable:3471538 slab_unreclaimable:882099\x0a mapped:140612
shmem:729255 pagetables:12907 bounce:0\x0a kernel_misc_reclaimable:0\x0a
free:688749 free_pcp:1641 free_cma:0
Jun 18 16:37:06 mr-fox kernel: Node 0 active_anon:3202704kB
inactive_anon:17031236kB active_file:57766412kB inactive_file:32187844kB
unevictable:8048kB isolated(anon):408kB isolated(file):0kB
mapped:562448kB dirty:1948kB writeback:0kB shmem:2917020kB shmem_thp:
0kB shmem_pmdmapped: 0kB anon_thp: 0kB writeback_tmp:0kB
kernel_stack:12448kB pagetables:51628kB all_unreclaimable? no
Jun 18 16:37:06 mr-fox kernel: Node 0 DMA free:11264kB boost:0kB min:4kB
low:16kB high:28kB reserved_highatomic:0KB active_anon:0kB
inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB
writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB
free_pcp:0kB local_pcp:0kB free_cma:0kB
Jun 18 16:37:06 mr-fox kernel: lowmem_reserve[]: 0 3166 128716 128716
Jun 18 16:37:06 mr-fox kernel: Node 0 DMA32 free:585996kB boost:0kB
min:1660kB low:4900kB high:8140kB reserved_highatomic:0KB
active_anon:8244kB inactive_anon:244840kB active_file:930524kB
inactive_file:230312kB unevictable:0kB writepending:0kB
present:3311464kB managed:3245920kB mlocked:0kB bounce:0kB free_pcp:0kB
local_pcp:0kB free_cma:0kB
Jun 18 16:37:06 mr-fox kernel: lowmem_reserve[]: 0 0 125550 125550
Jun 18 16:37:06 mr-fox kernel: Node 0 Normal free:2157736kB boost:0kB
min:65912kB low:194472kB high:323032kB reserved_highatomic:12288KB
active_anon:3194460kB inactive_anon:16786396kB active_file:56835888kB
inactive_file:31957532kB unevictable:8048kB writepending:1948kB
present:130796544kB managed:128569012kB mlocked:8048kB bounce:0kB
free_pcp:6520kB local_pcp:0kB free_cma:0kB
Jun 18 16:37:06 mr-fox kernel: lowmem_reserve[]: 0 0 0 0
Jun 18 16:37:06 mr-fox kernel: Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB
0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 2*4096kB (M) =3D
11264kB
Jun 18 16:37:06 mr-fox kernel: Node 0 DMA32: 19341*4kB (UME) 12552*8kB
(UME) 7392*16kB (UME) 3507*32kB (UME) 1454*64kB (UME) 414*128kB (UME)
104*256kB (ME) 10*512kB (M) 0*1024kB 0*2048kB 0*4096kB =3D 586068kB
Jun 18 16:37:06 mr-fox kernel: Node 0 Normal: 65181*4kB (UMEH) 61080*8kB
(UMEH) 19124*16kB (UMEH) 12005*32kB (UMEH) 6511*64kB (UMEH) 2009*128kB
(UME) 173*256kB (ME) 0*512kB 0*1024kB 1*2048kB (H) 0*4096kB =3D 2159700kB
Jun 18 16:37:06 mr-fox kernel: Node 0 hugepages_total=3D0 hugepages_free=
=3D0
hugepages_surp=3D0 hugepages_size=3D1048576kB
Jun 18 16:37:06 mr-fox kernel: Node 0 hugepages_total=3D0 hugepages_free=
=3D0
hugepages_surp=3D0 hugepages_size=3D2048kB
Jun 18 16:37:06 mr-fox kernel: 23229218 total pagecache pages
Jun 18 16:37:06 mr-fox kernel: 9771 pages in swap cache
Jun 18 16:37:06 mr-fox kernel: Swap cache stats: add 3647493, delete
3637625, find 37193692549/37193401872
Jun 18 16:37:06 mr-fox kernel: Free swap  =3D 268069112kB
Jun 18 16:37:06 mr-fox kernel: Total swap =3D 268435448kB
Jun 18 16:37:06 mr-fox kernel: 33531000 pages RAM
Jun 18 16:37:06 mr-fox kernel: 0 pages HighMem/MovableOnly
Jun 18 16:37:06 mr-fox kernel: 573427 pages reserved
Jun 18 16:37:06 mr-fox kernel: 0 pages hwpoisoned


=2D-
Toralf
