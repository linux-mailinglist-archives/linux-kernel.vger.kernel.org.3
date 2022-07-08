Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6F356BF1D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 20:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238708AbiGHQNz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 12:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238731AbiGHQNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 12:13:50 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 162D513F1C
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 09:13:49 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id e7so2525247qts.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 09:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maine.edu; s=google;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=RnUG7Ko06HjbYi71CaVwjXF3bhpqfgcZeEFQDpt5x3s=;
        b=Wu5RmPxxg6tL7go7Iu6d8zHec4scRhtrreROpx/RPv9G2eF8a/8hhDbsa9zgl+xLOw
         8Ea269hmV3BWiqQGKOVdz7geudg1dL+RF/lyGNoq4mAdl8uA38yZbYCmlTPkp73BfJVZ
         NVaYxeEduZ4f4bgKNocdNmMWClqG921j2d1QA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=RnUG7Ko06HjbYi71CaVwjXF3bhpqfgcZeEFQDpt5x3s=;
        b=AkTaAI4ETBQ3E7tE4okzsv5FSMEUovRKecDiiAtxH4kwHUYPx6e7jI2+OQfWJ6v8uQ
         qwn8CZ0uAN6+/jWkJuT5tw6wmt8inYH2zamdV6I0C+DvgJ5dTS8PeMQGnwDt/dGhJzuw
         A2bRKfP0Xkjry24Aq9LaW+MWDJ28ovEIxSpkV6bOg3qoswlC58FINwdKG1Ez9EuW/Xwc
         STOMXJB/Nge/V73l2gsAGthH9xPUAtBydfMf0Wwr2zHEva7B5mbSIRggf/72BoARLsKg
         vXxyRVzyu8vxbkKwQkcicMTsMgpfcUVi+PpDt45TTMdJFGqodSDOC4JA6plww6egdWMW
         CG2Q==
X-Gm-Message-State: AJIora+jp+zcu1UlLQXF/U8YbpecIwIaCzjjRwvr53G/qDoW+EMNA7nr
        1MpQGGQXJfw0yNFarBEO9/fBEw==
X-Google-Smtp-Source: AGRyM1u909y44WYXN9J5CKkPuhqLNnLPasK6IpVd51wu9PI08Ns4gJKQXxJRBXpA068ITl7dox1KkQ==
X-Received: by 2002:a05:622a:1492:b0:31e:9c7f:d607 with SMTP id t18-20020a05622a149200b0031e9c7fd607mr3522633qtx.521.1657296828056;
        Fri, 08 Jul 2022 09:13:48 -0700 (PDT)
Received: from macbook-air.local (weaver.eece.maine.edu. [130.111.218.23])
        by smtp.gmail.com with ESMTPSA id ay37-20020a05620a17a500b006af0d99c7fesm23161081qkb.132.2022.07.08.09.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 09:13:47 -0700 (PDT)
From:   Vince Weaver <vincent.weaver@maine.edu>
X-Google-Original-From: Vince Weaver <vince@maine.edu>
Date:   Fri, 8 Jul 2022 12:13:43 -0400 (EDT)
To:     Kan Liang <kan.liang@linux.intel.com>
cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [perf] unchecked MSR access error: WRMSR to 0x689 in
 intel_pmu_lbr_restore
In-Reply-To: <66961a7d-a6d8-2536-9ed3-68c2e7f4e03d@maine.edu>
Message-ID: <e71fa75-a718-ffb-c3f3-40cccf77ba9b@maine.edu>
References: <66961a7d-a6d8-2536-9ed3-68c2e7f4e03d@maine.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Jul 2022, Vince Weaver wrote:

> Let the fuzzer running a long time on 5.19-rc1 and after a few weeks it 
> triggered this weird trace.  It is repeatable (although I haven't 
> narrowed down exactly what's causing it).
> 
> It's odd in that it just dumps a <TASK>, it doesn't provide any info on 
> what the actual trigger is.
> 
> This is on a Haswell machine.

I bumped up to current git and managed to trigger this again, this time 
it actually managed to print the error message.

[ 7763.384369] unchecked MSR access error: WRMSR to 0x689 (tried to write 0x1fffffff8101349e) at rIP: 0xffffffff810704a4 (native_write_msr+0x4/0x20)
[ 7763.397420] Call Trace:
[ 7763.399881]  <TASK>
[ 7763.401994]  intel_pmu_lbr_restore+0x9a/0x1f0
[ 7763.406363]  intel_pmu_lbr_sched_task+0x91/0x1c0
[ 7763.410992]  __perf_event_task_sched_in+0x1cd/0x240
[ 7763.415879]  ? __perf_event_task_sched_out+0x75/0x5c0
[ 7763.420939]  finish_task_switch.isra.0+0x15b/0x2a0
[ 7763.425740]  ? __switch_to+0x112/0x430
[ 7763.429503]  __schedule+0x2cf/0x10d0
[ 7763.433088]  ? send_signal_locked+0xc8/0x130
[ 7763.437364]  schedule+0x4e/0xb0
[ 7763.440518]  do_wait+0x15b/0x2f0
[ 7763.443757]  kernel_wait4+0xa6/0x140
[ 7763.447337]  ? thread_group_exited+0x60/0x60
[ 7763.451608]  do_syscall_64+0x3b/0xc0
[ 7763.455199]  entry_SYSCALL_64_after_hwframe+0x46/0xb0
[ 7763.460259] RIP: 0033:0x7f9063feba26
[ 7763.463838] Code: ff e9 0e 00 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca 64 8b 04 25 18 00 00 00 85 c0 75 11 b8 3d 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 5a c3 90 48 83 ec 28 89 54 24 14 48 89 74 24
[ 7763.482587] RSP: 002b:00007ffca3875c08 EFLAGS: 00000246 ORIG_RAX: 000000000000003d
[ 7763.490161] RAX: ffffffffffffffda RBX: 000000000000000c RCX: 00007f9063feba26
[ 7763.497303] RDX: 0000000000000000 RSI: 00007ffca3875c1c RDI: 0000000000002214
[ 7763.504441] RBP: 00007ffca3875c20 R08: 00007f90640f321c R09: 00007f90640f3240
[ 7763.511577] R10: 0000000000000000 R11: 0000000000000246 R12: 000055d6ce93c4f0
[ 7763.518718] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[ 7763.525850]  </TASK>

