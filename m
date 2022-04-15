Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97964502744
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 11:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351699AbiDOJUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 05:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236043AbiDOJUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 05:20:31 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C91A731365
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 02:18:01 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id q22so1417057iod.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 02:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k941AYOO2t7LtokllmOIeH8IQ1ddJzfk+UJa9dbxTPg=;
        b=p6h5RxQzfxt67AMPPPWG9OTLQJblgkUUeshnVzjiJwADa8EqN97vlJqdEPu1GimhK5
         J/zL+50lu2GtKKy0FR72hUkUgqSeuONxMaBjkm9BAWh30+asoWUeh98Jz9qCo9zvVz4V
         L761IYZBJC0BLdOG+pBG1m1nEsG1wXZXjxtsf2EWjiD93htjtxOiT6J7AZdq/+jtzyPq
         PT7exx+n5Tex5dnw8dka7y7VtIGqFGGFxOwQu4nYmfUaPeKOR8dYVB6iVSBnLeb1mrYd
         eiyWtrU2SevzVgvmZCDJyzndh/NNRwuyBcAwO6kPN/GLlvk/L40FMrWuDDwIVhn3pBr6
         gHUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k941AYOO2t7LtokllmOIeH8IQ1ddJzfk+UJa9dbxTPg=;
        b=exrrgmHcFwe90Gt1GuuOBK/9oDsQnKHL+x7Q6OuUssYEoKrLv68gNap1elLuVLLioe
         0KPwBvmacK+yqq3E3n+Pby9ZxdMAXcQOcBmp29N8/vDwgoZ0vwzPaCHmKRkKb+eNXBtn
         6LjUT0mXlXUyFHNK70rhp76cM1GhdFyBuF0jdd4f+6+rtihynw72kPAD48mb7WcFXhYm
         v8A7G6Tmyr2cJC4uWO/TyzO3zjs1B2O2QdnumGn4H5djEY3j76CAznmErSdIT2i0msyQ
         oTaFon6kW2blyAKAj1bKTVPI2n1tJK0qx7j/m7mW1kMyk+YBysCgMuhWPaZ+7YJbcGMX
         fK9g==
X-Gm-Message-State: AOAM531jKItZ/Km9D3M4j+7Ovp6Tf5v28RgAQ7yK6WrvQ/P8JFKIF5U0
        /357TLXizot6U75nZ72IZiC/y1xN8W7Qk76ryhQRkw==
X-Google-Smtp-Source: ABdhPJxFmnsCRZMgyu1pbqAtZKBFVMSLQ5yiaJUTDH2WjkVU3jiiNbp7BXqae63ArIMySjufXFNtMdPurQkttPhCZno=
X-Received: by 2002:a05:6638:4e:b0:328:58ef:944d with SMTP id
 a14-20020a056638004e00b0032858ef944dmr438873jap.259.1650014281007; Fri, 15
 Apr 2022 02:18:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220401182512.249282-1-nogikh@google.com> <20220414142457.d22ce3a11920dc943001d737@linux-foundation.org>
 <Ylkr2xrVbhQYwNLf@elver.google.com>
In-Reply-To: <Ylkr2xrVbhQYwNLf@elver.google.com>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Fri, 15 Apr 2022 11:17:50 +0200
Message-ID: <CANp29Y4ZkN92wnaWew65L_K5o6WZFXEFCVSQiVhDFkY_fKUB=g@mail.gmail.com>
Subject: Re: [PATCH v3] kcov: don't generate a warning on vm_insert_page()'s failure
To:     Marco Elver <elver@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Taras Madan <tarasmadan@google.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Marco, thank you very much for these answers!
I was unfortunately a bit overloaded lately, so was postponing a reply
(given that the patch is very good to have, but not urgent).

On Fri, Apr 15, 2022 at 10:25 AM Marco Elver <elver@google.com> wrote:
>
> On Thu, Apr 14, 2022 at 02:24PM -0700, Andrew Morton wrote:
> > On Fri,  1 Apr 2022 18:25:12 +0000 Aleksandr Nogikh <nogikh@google.com> wrote:
> >
> > > vm_insert_page()'s failure is not an unexpected condition, so don't do
> > > WARN_ONCE() in such a case.
> > >
> > > Instead, print a kernel message and just return an error code.
> >
> > (hm, I thought I asked this before but I can't find it)
> >
> > Under what circumstances will this failure occur?
>
> It looks like syzbot was able to generate an OOM situation:
>
>  | [  599.515700][T23028] oom-kill:constraint=CONSTRAINT_MEMCG,nodemask=(null),cpuset=syz1,mems_allowed=0-1,oom_memcg=/syz1,task_memcg=/syz1,task=syz-executor.1,pid=23028,uid=0
>  | [  599.537757][T23028] Memory cgroup out of memory: Killed process 23028 (syz-executor.1) total-vm:56816kB, anon-rss:436kB, file-rss:8888kB, shmem-rss:48kB, UID:0 pgtables:88kB oom_score_adj:1000
>  | [  599.615664][T23028] ------------[ cut here ]------------
>  | [  599.652858][T23028] vm_insert_page() failed
>  | [  599.662598][T23028] WARNING: CPU: 0 PID: 23028 at kernel/kcov.c:479 kcov_mmap+0xbe/0xe0
>  | [  599.900577][T23028] Modules linked in:
>  | [  599.904480][T23028] CPU: 1 PID: 23028 Comm: syz-executor.1 Tainted: G        W         5.17.0-syzkaller-12964-gccaff3d56acc #0
>  | [  599.956099][T23028] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
>  | [  600.092674][T23028] RIP: 0010:kcov_mmap+0xbe/0xe0
>  | [  600.097559][T23028] Code: 48 81 c3 00 10 00 00 49 39 dc 77 c9 31 c0 5b 5d 41 5c 41 5d 41 5e c3 48 c7 c7 e9 4a 5b 8b c6 05 5a fc 28 0c 01 e8 bd c6 a0 07 <0f> 0b eb d2 4c 89 f7 e8 66 28 e8 07 b8 ea ff ff ff eb d1 66 66 2e
>  | [  600.117319][T23028] RSP: 0018:ffffc9000c1cfc30 EFLAGS: 00010282
>  | [  600.135794][T23028] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
>  | [  600.163986][T23028] RDX: ffff888051f40000 RSI: ffffffff815fce18 RDI: fffff52001839f78
>  | [  600.188615][T23028] RBP: ffff88804fc6e210 R08: 0000000000000000 R09: 0000000000000000
>  | [  600.196616][T23028] R10: ffffffff815f77ee R11: 0000000000000000 R12: 0000000000200000
>  | [  600.214229][T23028] R13: ffff8880646c2500 R14: ffff8880646c2508 R15: ffff88804fc6e260
>  | [  600.252864][T23028] FS:  00005555570e4400(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
>  | [  600.283249][T23028] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  | [  600.335749][T23028] CR2: 0000001b2c436000 CR3: 000000004ef16000 CR4: 00000000003506f0
>  | [  600.390781][T23028] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>  | [  600.430312][T23028] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000600
>  | [  600.441698][T23028] Call Trace:
>  | [  600.447877][T23028]  <TASK>
>  | [  600.451890][T23028]  mmap_region+0xba5/0x14a0
>  | [  600.486043][T23028]  do_mmap+0x863/0xfa0
>  | [  600.490544][T23028]  vm_mmap_pgoff+0x1b7/0x290
>  | [  600.505607][T23028]  ksys_mmap_pgoff+0x40d/0x5a0
>  | [  600.522165][T23028]  do_syscall_64+0x35/0x80
>  | [  600.526655][T23028]  entry_SYSCALL_64_after_hwframe+0x44/0xae
>  | [  600.532936][T23028] RIP: 0033:0x7f5be4889092
>  | [  600.537407][T23028] Code: 00 00 00 00 00 0f 1f 00 41 f7 c1 ff 0f 00 00 75 27 55 48 89 fd 53 89 cb 48 85 ff 74 3b 41 89 da 48 89 ef b8 09 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 66 5b 5d c3 0f 1f 00 48 c7 c0 b8 ff ff ff 64
>  | [  600.560042][T23028] RSP: 002b:00007fffde76b318 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
>  | [  600.569079][T23028] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007f5be4889092
>  | [  600.577107][T23028] RDX: 0000000000000003 RSI: 0000000000200000 RDI: 0000000000000000
>  | [  600.587064][T23028] RBP: 0000000000000000 R08: 00000000000000db R09: 0000000000000000
>  | [  600.596119][T23028] R10: 0000000000000001 R11: 0000000000000246 R12: 00007f5be499c1dc
>  | [  600.604977][T23028] R13: 0000000000000003 R14: 00007f5be499c1d0 R15: 0000000000000032
>  | [  600.613026][T23028]  </TASK>
>  | [  600.616066][T23028] Kernel panic - not syncing: panic_on_warn set ...
>
> > Why do we emit a message at all?  What action can the user take upon
> > seeing the message?
>
> The message is mainly for the benefit of the test log, in this case the
> fuzzer's log so that humans inspecting the log can figure out what was
> going on. KCOV is a testing tool, so I think being a little more chatty
> when KCOV unexpectedly is about to fail will save someone debugging
> time.
>
> We don't want the WARN, because it's not a kernel bug that syzbot should
> report, and failure can happen if the fuzzer tries hard enough (as
> above).
>
> > Do we have a Fixes: for this?
>
> The WARN was moved with b3d7fe86fbd0 ("kcov: properly handle subsequent
> mmap calls"), so that'd be the only commit a backport would cleanly
> apply to.
>
> > From the info provided thus far I'm unable to determine whether a
> > -stable backport is needed.  What are your thoughts on this?
>
> The main problem is it only makes fuzzers try to report this as a bug
> (which it is not). Backporting to kernels that have b3d7fe86fbd0 would
> be reasonable, but wouldn't bother creating backports for older kernels.
>
> Thanks,
> -- Marco

I agree with all these points and don't really have anything to add.
