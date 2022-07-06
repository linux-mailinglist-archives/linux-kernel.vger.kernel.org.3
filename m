Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E674569411
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 23:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234430AbiGFVPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 17:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233838AbiGFVPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 17:15:03 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C1E711B
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 14:15:02 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id bs20so20115830qtb.11
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 14:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maine.edu; s=google;
        h=from:date:to:cc:subject:message-id:mime-version;
        bh=vJ209fpIO1bKI/cgVAFnh55F4SOnFvYKatDCLV/61Dc=;
        b=ZygOd3jKHHkYe2NMJEaN2RLRmJjKSbEbhCI2qKFS4S43vA4tVxkK8r9t3II03/jJt5
         ptRzsRua71ND+YeASevoj4tBwjOyxcFD1hyvAcI7MHUk05zIAwyreMwRnP3Wgu+ONREl
         B5OsXAvM+BlGO8iU8mUYOMy4S/Jfr6WCPUsdo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:mime-version;
        bh=vJ209fpIO1bKI/cgVAFnh55F4SOnFvYKatDCLV/61Dc=;
        b=3IPIKiqTiTDRrObl6/h0Cs2wZn5MUP5z1m2KpDjRg4F31gVCZp8BhyX28ET2H0Tb1g
         sqLYhn98DN9tGJdJBvRPU6m++6pXhWXZvhrAcs29SSsOWfYErd823SRLTeEElJda+lMG
         kAogN3d1d7elOBqrRXO4bQoK/u3tzh9TMcE0Sa95C50ECjZudP3JywnJwzRcYiYDd1IU
         YVmPO1p/WKYLo58FhFPAwB8Fy2GaT2VpfQOm9kkGSFtzX23SYzaZ6/lGN3qDdkNKTuG7
         dTKMGApGJSCvA+rXGldX5OXJ3/C3CaFGxrqWPaXK1V/uD4H3HsIBQaUTFxtb5EmLkyMZ
         1VeA==
X-Gm-Message-State: AJIora9Kjo55OWjJ3A13so3rqtgDSs4KLPXRBqDvQWVOx+r2QVK1kDLZ
        gCzUMxA4k1B3eJK4Z2DbBYKdNxej32JtzA==
X-Google-Smtp-Source: AGRyM1sJL6GL2z3fqJBEZR1UlsgrNjBuNLWV+4rdrauPidzIszdFWjnWftml42c6srs3Bg7vq1e1Eg==
X-Received: by 2002:a05:6214:509e:b0:470:3fdb:3ebe with SMTP id kk30-20020a056214509e00b004703fdb3ebemr37231062qvb.81.1657142101332;
        Wed, 06 Jul 2022 14:15:01 -0700 (PDT)
Received: from macbook-air.local (weaver.eece.maine.edu. [130.111.218.23])
        by smtp.gmail.com with ESMTPSA id s7-20020a05620a254700b006a65c58db99sm32330024qko.64.2022.07.06.14.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 14:15:00 -0700 (PDT)
From:   Vince Weaver <vincent.weaver@maine.edu>
X-Google-Original-From: Vince Weaver <vince@maine.edu>
Date:   Wed, 6 Jul 2022 17:14:56 -0400 (EDT)
To:     linux-kernel@vger.kernel.org
cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [perf] odd fuzzer generated trace in intel_pmu_lbr_restore
Message-ID: <66961a7d-a6d8-2536-9ed3-68c2e7f4e03d@maine.edu>
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

Hello

Let the fuzzer running a long time on 5.19-rc1 and after a few weeks it 
triggered this weird trace.  It is repeatable (although I haven't 
narrowed down exactly what's causing it).

It's odd in that it just dumps a <TASK>, it doesn't provide any info on 
what the actual trigger is.

This is on a Haswell machine.

[2611569.407088] Call Trace:
[2611569.407092]  <TASK>
[2611569.407093]  intel_pmu_lbr_restore+0x9a/0x1f0
[2611569.407100]  intel_pmu_lbr_sched_task+0x91/0x1c0
[2611569.407103]  __perf_event_task_sched_in+0x1cd/0x240
[2611569.407107]  ? __perf_event_task_sched_out+0x75/0x5c0
[2611569.407109]  finish_task_switch.isra.0+0x188/0x2a0
[2611569.407114]  ? __switch_to+0x112/0x430
[2611569.407119]  __schedule+0x2cf/0x10d0
[2611569.407123]  ? __sysvec_irq_work+0x5b/0xc0
[2611569.407127]  schedule+0x4e/0xb0
[2611569.407129]  schedule_timeout+0x115/0x150
[2611569.407132]  ? schedule_timeout+0x115/0x150
[2611569.407135]  ? _raw_spin_unlock_irqrestore+0x23/0x40
[2611569.407138]  ? preempt_count_add+0x68/0xa0
[2611569.407141]  ? preempt_count_add+0x68/0xa0
[2611569.407144]  __wait_for_common+0x93/0x1a0
[2611569.407146]  ? usleep_range_state+0x90/0x90
[2611569.407149]  __wait_rcu_gp+0x112/0x120
[2611569.407152]  synchronize_rcu+0xc8/0xe0
[2611569.407156]  ? note_gp_changes+0x80/0x80
[2611569.407159]  perf_trace_event_unreg.isra.0+0x37/0x90
[2611569.407163]  perf_trace_destroy+0x38/0x50
[2611569.407165]  _free_event+0xf9/0x3d0
[2611569.407167]  perf_event_release_kernel+0x279/0x2d0
[2611569.407170]  perf_release+0x11/0x20
[2611569.407172]  __fput+0x8c/0x240
[2611569.407175]  task_work_run+0x5c/0x90
[2611569.407180]  exit_to_user_mode_prepare+0x125/0x130
[2611569.407183]  syscall_exit_to_user_mode+0x22/0x40
[2611569.407185]  ? __x64_sys_close+0xd/0x40
[2611569.407189]  do_syscall_64+0x48/0xc0
[2611569.407193]  entry_SYSCALL_64_after_hwframe+0x46/0xb0
[2611569.407198] RIP: 0033:0x7f92e4813cc3
[2611569.407200] Code: e9 37 ff ff ff e8 ad ef 01 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 64 8b 04 25 18 00 00 00 85 c0 75 14 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 45 c3 0f 1f 40 00 48 83 ec 18 89 7c 24 0c e8
[2611569.407202] RSP: 002b:00007fffc243bb98 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
[2611569.407205] RAX: 0000000000000000 RBX: 000000000000000c RCX: 00007f92e4813cc3
[2611569.407207] RDX: 0000000000005be0 RSI: 00007fffc243bb74 RDI: 0000000000000048
[2611569.407208] RBP: 00007fffc243bbc0 R08: 00007f92e48f7234 R09: 00007f92e48f7240
[2611569.407209] R10: 0000000000000000 R11: 0000000000000246 R12: 000056355ea124f0
[2611569.407210] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[2611569.407212]  </TASK>


