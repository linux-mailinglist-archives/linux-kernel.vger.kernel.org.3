Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 944AD50269B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 10:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351360AbiDOI1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 04:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230490AbiDOI1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 04:27:35 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7431AA032
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 01:25:07 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id c190-20020a1c35c7000000b0038e37907b5bso7399568wma.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 01:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fVUrBKGjZU0u3Zs9QEQDJ4oPemzJ+nL7yLHZVhKUceQ=;
        b=HSwleyKRXkLiugaEE0Inxhugu4+9g6b/oeyYWxW9oyKep9HmYOrdiOul5tNWp4Qd6G
         sjtMwKA/9Dm8m5u3EbQ82KW1xiP1GEoQG6mhGb/Sa01FP12QOYgZA4xsZVoZ/GJXuVEP
         IF8pSVq5oVXDhN46KseuxgFL09kHVev4U5zme+wy6gYJ5MTot9cTXfBZ6AhKwf+KDomk
         mm5Z8JCr4Rabei/gZkw94JIRakjg73f5YbjSOWNROqh6jJ08yEZ6NOwZVt7eoM5R/clL
         bMH6SyPei8rFYX+BkZz2AuuEF/MB5vcHiXbDjLrkQJYcmAVGvb/ZKyOkfbgzCXzXmsdh
         iI9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fVUrBKGjZU0u3Zs9QEQDJ4oPemzJ+nL7yLHZVhKUceQ=;
        b=zFhRpj04PMrgxfBNrYf04TXLdZYI9CLr6OVspH+MU24DZIliuoBBruTGZ9qU+O0JLq
         E1PD1iw8D//1228OgxNCc/05vCRFc2g0GyJqo6DF5hEJu5bovmagyE4J41ii5kRC49jC
         Pk+xRjymLKIBi/UrNZ+brPEll2PNwdZSF2TvUp5DB5bFQkwxzdm3oLdytP036SAZaraI
         lMu+WxcU8M5TIvpmcMWEouQjPNraqfHhSPHyAPAIEdUbwbPsZ/5c3hhXdLAauuAPMK+/
         M4ha9d8NFOvMLKPQZEIDyviGX/n4Yx2Ft14fHity4nBerOqQypWycPdHLx5k/5hXvOTC
         Hwbw==
X-Gm-Message-State: AOAM5334tE+2o5hq+vGcQKDl/1YMQJDaHnTorb4ZHD+DWS2LZUMD/gGy
        +YeW3M/iijZRoTIKVt3I1FNL5w==
X-Google-Smtp-Source: ABdhPJyx02TEE3N+3oaUoyGu5K0Bs5kSDY1V4P5wTWQqH5bn5qNoGBmRj4M0H8cFiuR4F2mnMQvw3Q==
X-Received: by 2002:a7b:c1cc:0:b0:38e:b876:95d8 with SMTP id a12-20020a7bc1cc000000b0038eb87695d8mr2287618wmj.57.1650011106062;
        Fri, 15 Apr 2022 01:25:06 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:15:13:dcf7:562:ed76:3997])
        by smtp.gmail.com with ESMTPSA id p125-20020a1c2983000000b0038e6c62f527sm5172110wmp.14.2022.04.15.01.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 01:25:05 -0700 (PDT)
Date:   Fri, 15 Apr 2022 10:24:59 +0200
From:   Marco Elver <elver@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Aleksandr Nogikh <nogikh@google.com>, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, dvyukov@google.com,
        andreyknvl@gmail.com, glider@google.com, tarasmadan@google.com,
        bigeasy@linutronix.de
Subject: Re: [PATCH v3] kcov: don't generate a warning on vm_insert_page()'s
 failure
Message-ID: <Ylkr2xrVbhQYwNLf@elver.google.com>
References: <20220401182512.249282-1-nogikh@google.com>
 <20220414142457.d22ce3a11920dc943001d737@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220414142457.d22ce3a11920dc943001d737@linux-foundation.org>
User-Agent: Mutt/2.1.4 (2021-12-11)
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

On Thu, Apr 14, 2022 at 02:24PM -0700, Andrew Morton wrote:
> On Fri,  1 Apr 2022 18:25:12 +0000 Aleksandr Nogikh <nogikh@google.com> wrote:
> 
> > vm_insert_page()'s failure is not an unexpected condition, so don't do
> > WARN_ONCE() in such a case.
> > 
> > Instead, print a kernel message and just return an error code.
> 
> (hm, I thought I asked this before but I can't find it)
> 
> Under what circumstances will this failure occur?

It looks like syzbot was able to generate an OOM situation:

 | [  599.515700][T23028] oom-kill:constraint=CONSTRAINT_MEMCG,nodemask=(null),cpuset=syz1,mems_allowed=0-1,oom_memcg=/syz1,task_memcg=/syz1,task=syz-executor.1,pid=23028,uid=0
 | [  599.537757][T23028] Memory cgroup out of memory: Killed process 23028 (syz-executor.1) total-vm:56816kB, anon-rss:436kB, file-rss:8888kB, shmem-rss:48kB, UID:0 pgtables:88kB oom_score_adj:1000
 | [  599.615664][T23028] ------------[ cut here ]------------
 | [  599.652858][T23028] vm_insert_page() failed
 | [  599.662598][T23028] WARNING: CPU: 0 PID: 23028 at kernel/kcov.c:479 kcov_mmap+0xbe/0xe0
 | [  599.900577][T23028] Modules linked in:
 | [  599.904480][T23028] CPU: 1 PID: 23028 Comm: syz-executor.1 Tainted: G        W         5.17.0-syzkaller-12964-gccaff3d56acc #0
 | [  599.956099][T23028] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
 | [  600.092674][T23028] RIP: 0010:kcov_mmap+0xbe/0xe0
 | [  600.097559][T23028] Code: 48 81 c3 00 10 00 00 49 39 dc 77 c9 31 c0 5b 5d 41 5c 41 5d 41 5e c3 48 c7 c7 e9 4a 5b 8b c6 05 5a fc 28 0c 01 e8 bd c6 a0 07 <0f> 0b eb d2 4c 89 f7 e8 66 28 e8 07 b8 ea ff ff ff eb d1 66 66 2e
 | [  600.117319][T23028] RSP: 0018:ffffc9000c1cfc30 EFLAGS: 00010282
 | [  600.135794][T23028] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
 | [  600.163986][T23028] RDX: ffff888051f40000 RSI: ffffffff815fce18 RDI: fffff52001839f78
 | [  600.188615][T23028] RBP: ffff88804fc6e210 R08: 0000000000000000 R09: 0000000000000000
 | [  600.196616][T23028] R10: ffffffff815f77ee R11: 0000000000000000 R12: 0000000000200000
 | [  600.214229][T23028] R13: ffff8880646c2500 R14: ffff8880646c2508 R15: ffff88804fc6e260
 | [  600.252864][T23028] FS:  00005555570e4400(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
 | [  600.283249][T23028] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 | [  600.335749][T23028] CR2: 0000001b2c436000 CR3: 000000004ef16000 CR4: 00000000003506f0
 | [  600.390781][T23028] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 | [  600.430312][T23028] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000600
 | [  600.441698][T23028] Call Trace:
 | [  600.447877][T23028]  <TASK>
 | [  600.451890][T23028]  mmap_region+0xba5/0x14a0
 | [  600.486043][T23028]  do_mmap+0x863/0xfa0
 | [  600.490544][T23028]  vm_mmap_pgoff+0x1b7/0x290
 | [  600.505607][T23028]  ksys_mmap_pgoff+0x40d/0x5a0
 | [  600.522165][T23028]  do_syscall_64+0x35/0x80
 | [  600.526655][T23028]  entry_SYSCALL_64_after_hwframe+0x44/0xae
 | [  600.532936][T23028] RIP: 0033:0x7f5be4889092
 | [  600.537407][T23028] Code: 00 00 00 00 00 0f 1f 00 41 f7 c1 ff 0f 00 00 75 27 55 48 89 fd 53 89 cb 48 85 ff 74 3b 41 89 da 48 89 ef b8 09 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 66 5b 5d c3 0f 1f 00 48 c7 c0 b8 ff ff ff 64
 | [  600.560042][T23028] RSP: 002b:00007fffde76b318 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
 | [  600.569079][T23028] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007f5be4889092
 | [  600.577107][T23028] RDX: 0000000000000003 RSI: 0000000000200000 RDI: 0000000000000000
 | [  600.587064][T23028] RBP: 0000000000000000 R08: 00000000000000db R09: 0000000000000000
 | [  600.596119][T23028] R10: 0000000000000001 R11: 0000000000000246 R12: 00007f5be499c1dc
 | [  600.604977][T23028] R13: 0000000000000003 R14: 00007f5be499c1d0 R15: 0000000000000032
 | [  600.613026][T23028]  </TASK>
 | [  600.616066][T23028] Kernel panic - not syncing: panic_on_warn set ...

> Why do we emit a message at all?  What action can the user take upon
> seeing the message?

The message is mainly for the benefit of the test log, in this case the
fuzzer's log so that humans inspecting the log can figure out what was
going on. KCOV is a testing tool, so I think being a little more chatty
when KCOV unexpectedly is about to fail will save someone debugging
time.

We don't want the WARN, because it's not a kernel bug that syzbot should
report, and failure can happen if the fuzzer tries hard enough (as
above).

> Do we have a Fixes: for this?

The WARN was moved with b3d7fe86fbd0 ("kcov: properly handle subsequent
mmap calls"), so that'd be the only commit a backport would cleanly
apply to.

> From the info provided thus far I'm unable to determine whether a
> -stable backport is needed.  What are your thoughts on this?

The main problem is it only makes fuzzers try to report this as a bug
(which it is not). Backporting to kernels that have b3d7fe86fbd0 would
be reasonable, but wouldn't bother creating backports for older kernels.

Thanks,
-- Marco
