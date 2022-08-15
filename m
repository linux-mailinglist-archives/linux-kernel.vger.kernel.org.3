Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 217E2592A92
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 10:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241523AbiHOHvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 03:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbiHOHvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 03:51:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 63FE7654B
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 00:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660549902;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hp3uyGPXcpLuAdNod/9L2q00klzDxUmOl5bo+pr6VVw=;
        b=fmeHKuy1S6lbbLXeSwCOvouyV6v0Pt9prEn/7/yUfC7kIDYZZxoe+Qd7TcAuHal8ADyedM
        7CPYW5yH7LHbQVVeV44nfNau6ygimX5yHJSjJlkObo51VF5Ic4uVGlaA40pW/Ye7cZnsK/
        gdn2gTZRqtdsa6ljDKqSvjfu9yysY9E=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-465-oHdWK9YrMmyAHGn57D487w-1; Mon, 15 Aug 2022 03:51:40 -0400
X-MC-Unique: oHdWK9YrMmyAHGn57D487w-1
Received: by mail-ed1-f69.google.com with SMTP id i5-20020a05640242c500b0043e50334109so4312152edc.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 00:51:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=hp3uyGPXcpLuAdNod/9L2q00klzDxUmOl5bo+pr6VVw=;
        b=aN3xJOguxcuQWvprGeYHMP4opcNCC6aPkFMJunH5/47iymGgz4nx1knPXogmaiaZzC
         7VcwMxLkn6duUxhmL5SBCMB+OOqN5GHYok6wwEQECW2JEvbqxXia92IIDSvw1tcDxSdB
         btph4F+fLljEdBJ+h9emWOKEXiWvPQMtk8TFRZZCj15pJQ6Qj8kowKUjpdmhabMp1bsp
         2GzImEpHbc3N1d5R4tSsXesqzFyCah/cGYMzQcQkidAE+NtROaI8elwT0yTmEN+KSEdV
         +SIWRkHCtflR6EEIdonWmF5Y7OW9M5v5MUWDJws2VuL1ryrHcCUa3YBA+cHvRjg8nfv1
         MyZA==
X-Gm-Message-State: ACgBeo2ll/Bq2WR3c1RoFHq06GjHN4p4mRBVo58igBlPeu7gThZ/NbjG
        jO/a7onfmeL2ws24xaPKNdMnKL9ot6sSRU7/A94JRNLv3pDf35Zv3sYcarPqlFYx8wo5ThRAJL1
        +SxOv16G2/jdSVF0u1p5ZYu35
X-Received: by 2002:a17:906:7e43:b0:738:6395:8d94 with SMTP id z3-20020a1709067e4300b0073863958d94mr824918ejr.54.1660549899500;
        Mon, 15 Aug 2022 00:51:39 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6PVP+y8neT4WpPY/h9v2xQUtcZLA87z76J7kvB5fPAed5AXtSSLU/CQf+SIM5x/ZyB5J6dXg==
X-Received: by 2002:a17:906:7e43:b0:738:6395:8d94 with SMTP id z3-20020a1709067e4300b0073863958d94mr824903ejr.54.1660549899254;
        Mon, 15 Aug 2022 00:51:39 -0700 (PDT)
Received: from redhat.com ([2.54.169.49])
        by smtp.gmail.com with ESMTPSA id gt20-20020a170906f21400b0072abb95c9f4sm3717936ejb.193.2022.08.15.00.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 00:51:38 -0700 (PDT)
Date:   Mon, 15 Aug 2022 03:51:34 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Andres Freund <andres@anarazel.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
Subject: Re: upstream kernel crashes
Message-ID: <20220815034532-mutt-send-email-mst@kernel.org>
References: <20220814212610.GA3690074@roeck-us.net>
 <CAHk-=wgf2EfLHui6A5NbWoaVBB2f8t-XBUiOMkyjN2NU41t6eA@mail.gmail.com>
 <20220814223743.26ebsbnrvrjien4f@awork3.anarazel.de>
 <CAHk-=wi6raoJE-1cyRU0YxJ+9ReO1eXmOAq0FwKAyZS7nhvk9w@mail.gmail.com>
 <1c057afa-92df-ee3c-5978-3731d3db9345@kernel.dk>
 <20220815013651.mrm7qgklk6sgpkbb@awork3.anarazel.de>
 <CAHk-=wikzU4402P-FpJRK_QwfVOS+t-3p1Wx5awGHTvr-s_0Ew@mail.gmail.com>
 <20220815071143.n2t5xsmifnigttq2@awork3.anarazel.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220815071143.n2t5xsmifnigttq2@awork3.anarazel.de>
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2022 at 12:11:43AM -0700, Andres Freund wrote:
> Hi,
> 
> On 2022-08-14 20:18:44 -0700, Linus Torvalds wrote:
> > On Sun, Aug 14, 2022 at 6:36 PM Andres Freund <andres@anarazel.de> wrote:
> > >
> > > Some of the symptoms could be related to the issue in this thread, hence
> > > listing them here
> > 
> > Smells like slab corruption to me, and the problems may end up being
> > then largely random just depending on who ends up using the allocation
> > that gets trampled on.
> > 
> > I wouldn't be surprised if it's all the same thing - including your
> > network issue.
> 
> Yea. As I just wrote in
> https://postgr.es/m/20220815070203.plwjx7b3cyugpdt7%40awork3.anarazel.de I
> bisected it down to one commit (762faee5a267). With that commit I only see the
> networking issue across a few reboots, but with ebcce4926365 some boots oops
> badly and other times it' "just" network not working.
> 
> 
> [    2.447668] general protection fault, probably for non-canonical address 0xffff000000000800: 0000 [#1] PREEMPT SMP PTI
> [    2.449168] CPU: 1 PID: 109 Comm: systemd-udevd Not tainted 5.19.0-bisect8-00051-gebcce4926365 #8
> [    2.450397] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/29/2022
> [    2.451670] RIP: 0010:kmem_cache_alloc_node+0x2b4/0x430
> [    2.452399] Code: 01 00 0f 84 e7 fe ff ff 48 8b 50 48 48 8d 7a ff 83 e2 01 48 0f 45 c7 49 89 c7 e9 d0 fe ff ff 8b 45 28 48 8b 7d 00 48 8d 4a 40 <49> 8b 1c 04 4c 89 e0 65 48 0f c7 0f 0f 94 c0 84 c0 0f 84 cd fd ff
> [    2.455454] RSP: 0018:ffffa2b40040bd60 EFLAGS: 00010246
> [    2.456181] RAX: 0000000000000800 RBX: 0000000000000cc0 RCX: 0000000000001741
> [    2.457195] RDX: 0000000000001701 RSI: 0000000000000cc0 RDI: 000000000002f820
> [    2.458211] RBP: ffff8da7800ed500 R08: 0000000000000000 R09: 0000000000000011
> [    2.459183] R10: 00007fd02b8b8b90 R11: 0000000000000000 R12: ffff000000000000
> [    2.460268] R13: 0000000000000000 R14: 0000000000000cc0 R15: ffffffff934bde4b
> [    2.461368] FS:  00007fd02b8b88c0(0000) GS:ffff8da8b7d00000(0000) knlGS:0000000000000000
> [    2.462605] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    2.463436] CR2: 000055a42d2ee250 CR3: 0000000100328001 CR4: 00000000003706e0
> [    2.464527] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [    2.465520] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [    2.466509] Call Trace:
> [    2.466882]  <TASK>
> [    2.467218]  copy_process+0x1eb/0x1a00
> [    2.467827]  ? _raw_spin_unlock_irqrestore+0x16/0x30
> [    2.468578]  kernel_clone+0xba/0x400
> [    2.470455]  __do_sys_clone+0x78/0xa0
> [    2.471006]  do_syscall_64+0x37/0x90
> [    2.471526]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> [    2.472267] RIP: 0033:0x7fd02bf98cb3
> [    2.472889] Code: 1f 84 00 00 00 00 00 64 48 8b 04 25 10 00 00 00 45 31 c0 31 d2 31 f6 bf 11 00 20 01 4c 8d 90 d0 02 00 00 b8 38 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 35 41 89 c0 85 c0 75 2a 64 48 8b 04 25 10 00
> [    2.475504] RSP: 002b:00007ffc6a3abf08 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
> [    2.476565] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007fd02bf98cb3
> [    2.477554] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000001200011
> [    2.478574] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> [    2.479608] R10: 00007fd02b8b8b90 R11: 0000000000000246 R12: 0000000000000001
> [    2.480675] R13: 00007ffc6a3ac0c0 R14: 0000000000000000 R15: 0000000000000001
> [    2.481686]  </TASK>
> [    2.482119] Modules linked in:
> [    2.482704] ---[ end trace 0000000000000000 ]---
> [    2.483456] RIP: 0010:kmem_cache_alloc_node+0x2b4/0x430
> [    2.484282] Code: 01 00 0f 84 e7 fe ff ff 48 8b 50 48 48 8d 7a ff 83 e2 01 48 0f 45 c7 49 89 c7 e9 d0 fe ff ff 8b 45 28 48 8b 7d 00 48 8d 4a 40 <49> 8b 1c 04 4c 89 e0 65 48 0f c7 0f 0f 94 c0 84 c0 0f 84 cd fd ff
> [    2.487024] RSP: 0018:ffffa2b40040bd60 EFLAGS: 00010246
> [    2.487817] RAX: 0000000000000800 RBX: 0000000000000cc0 RCX: 0000000000001741
> [    2.488805] RDX: 0000000000001701 RSI: 0000000000000cc0 RDI: 000000000002f820
> [    2.489869] RBP: ffff8da7800ed500 R08: 0000000000000000 R09: 0000000000000011
> [    2.490842] R10: 00007fd02b8b8b90 R11: 0000000000000000 R12: ffff000000000000
> [    2.491905] R13: 0000000000000000 R14: 0000000000000cc0 R15: ffffffff934bde4b
> [    2.492975] FS:  00007fd02b8b88c0(0000) GS:ffff8da8b7d00000(0000) knlGS:0000000000000000
> [    2.494140] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    2.495082] CR2: 000055a42d2ee250 CR3: 0000000100328001 CR4: 00000000003706e0
> [    2.496080] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [    2.497084] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [    2.498524] systemd-udevd (109) used greatest stack depth: 13688 bytes left
> [    2.503905] general protection fault, probably for non-canonical address 0xffff000000000000: 0000 [#2] PREEMPT SMP PTI
> [    2.505504] CPU: 0 PID: 13 Comm: ksoftirqd/0 Tainted: G      D           5.19.0-bisect8-00051-gebcce4926365 #8
> [    2.507037] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/29/2022
> [    2.508313] RIP: 0010:rcu_core+0x280/0x920
> [    2.508968] Code: 3f 00 00 48 89 c2 48 85 c0 0f 84 2b 03 00 00 49 89 dd 48 83 c3 01 0f 1f 44 00 00 48 8b 42 08 48 89 d7 48 c7 42 08 00 00 00 00 <ff> d0 0f 1f 00 65 8b 05 64 f5 ad 6c f6 c4 01 75 97 be 00 02 00 00
> [    2.511684] RSP: 0000:ffffa2b40007fe20 EFLAGS: 00010202
> [    2.512410] RAX: ffff000000000000 RBX: 0000000000000002 RCX: 0000000080170011
> [    2.513497] RDX: ffff8da783372a20 RSI: 0000000080170011 RDI: ffff8da783372a20
> [    2.514604] RBP: ffff8da8b7c2b940 R08: 0000000000000001 R09: ffffffff9353b752
> [    2.515667] R10: ffffffff94a060c0 R11: 000000000009b776 R12: ffff8da78020c000
> [    2.516650] R13: 0000000000000001 R14: ffff8da8b7c2b9b8 R15: 0000000000000000
> [    2.517628] FS:  0000000000000000(0000) GS:ffff8da8b7c00000(0000) knlGS:0000000000000000
> [    2.518840] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    2.519645] CR2: 0000557194db70f8 CR3: 0000000100364006 CR4: 00000000003706f0
> [    2.520641] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [    2.521629] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [    2.522592] Call Trace:
> [    2.522963]  <TASK>
> [    2.523299]  __do_softirq+0xe1/0x2ec
> [    2.523883]  ? sort_range+0x20/0x20
> [    2.524404]  run_ksoftirqd+0x25/0x30
> [    2.524944]  smpboot_thread_fn+0x180/0x220
> [    2.525519]  kthread+0xe1/0x110
> [    2.526001]  ? kthread_complete_and_exit+0x20/0x20
> [    2.526673]  ret_from_fork+0x1f/0x30
> [    2.527182]  </TASK>
> [    2.527518] Modules linked in:
> [    2.528005] ---[ end trace 0000000000000000 ]---
> [    2.528662] RIP: 0010:kmem_cache_alloc_node+0x2b4/0x430
> [    2.529524] Code: 01 00 0f 84 e7 fe ff ff 48 8b 50 48 48 8d 7a ff 83 e2 01 48 0f 45 c7 49 89 c7 e9 d0 fe ff ff 8b 45 28 48 8b 7d 00 48 8d 4a 40 <49> 8b 1c 04 4c 89 e0 65 48 0f c7 0f 0f 94 c0 84 c0 0f 84 cd fd ff
> [    2.532396] RSP: 0018:ffffa2b40040bd60 EFLAGS: 00010246
> [    2.533201] RAX: 0000000000000800 RBX: 0000000000000cc0 RCX: 0000000000001741
> [    2.534376] RDX: 0000000000001701 RSI: 0000000000000cc0 RDI: 000000000002f820
> [    2.535398] RBP: ffff8da7800ed500 R08: 0000000000000000 R09: 0000000000000011
> Begin: Loading e[    2.536401] R10: 00007fd02b8b8b90 R11: 0000000000000000 R12: ffff000000000000
> [    2.537641] R13: 0000000000000000 R14: 0000000000000cc0 R15: ffffffff934bde4b
> ssential drivers[    2.538737] FS:  0000000000000000(0000) GS:ffff8da8b7c00000(0000) knlGS:0000000000000000
> [    2.540028] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  ... done.[    2.540843] CR2: 0000557194db70f8 CR3: 000000015080c002 CR4: 00000000003706f0
> [    2.541953] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> 
> [    2.542924] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [    2.543902] Kernel panic - not syncing: Fatal exception in interrupt
> [    2.544967] Kernel Offset: 0x12400000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> [    2.546637] ---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---
> 
> 
> If somebody knowledgeable staring at 762faee5a267 doesn't surface somebody I
> can create a kernel with some more debugging stuff enabled, if somebody tells
> me what'd work best here.
> 
> 
> Greetings,
> 
> Andres Freund


It is possible that GCP gets confused if ring size is smaller than the
device maximum simply because no one did it in the past.

So I pushed just the revert of 762faee5a267 to the test branch.
Could you give it a spin?

-- 
MST

