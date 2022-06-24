Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B10C3559B4C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 16:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231940AbiFXORr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 10:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbiFXORn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 10:17:43 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E443B4F9D0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 07:17:41 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A287A21AF3;
        Fri, 24 Jun 2022 14:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1656080260; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=NUWT7Az6AfDgXDht5tXPsuar4v3himkpXGRyfkP9Eq0=;
        b=FwKP6IqEXM3nftv3QLRFKinPQfArT91WC30EG6S/Ei4HAOCkEtPixTbbOba1aWAzcA7tMc
        XZagoP2lZtpjv6lqadbBF1CUnG2NXzphU63LYw3QqVAFojN+yNdiSNUEa9wW0lQtcU27Jl
        bfMAMruD0DlVaSYZ1aqss/7mNA9YMjs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1656080260;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=NUWT7Az6AfDgXDht5tXPsuar4v3himkpXGRyfkP9Eq0=;
        b=pwxKx5gUZuOwqQ4dPUKBB7900p0G22soIBpb9syIi2l4O/kZWIEOcVIgX0FxqJx74gnWOa
        vhDfq8P5y7um+aBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8014513ACA;
        Fri, 24 Jun 2022 14:17:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 07jgHoTHtWKoHQAAMHmgww
        (envelope-from <iivanov@suse.de>); Fri, 24 Jun 2022 14:17:40 +0000
From:   "Ivan T. Ivanov" <iivanov@suse.de>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Ivan T. Ivanov" <iivanov@suse.de>
Subject: [PATCH 0/1] arm64: Add stack unwinder unit tests
Date:   Fri, 24 Jun 2022 17:09:59 +0300
Message-Id: <20220624141000.88120-1-iivanov@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is my initial arm64 unwinder test support. Code is based on s390
unwinder tests, while errors introduced are mine. I am hopping that it
will be useful for testing and validating upcoming arm64
arch_stack_walk_reliable() support.

This patch is was tested on top of latest Madhavan work [1].

As expected unwinding trough IRQ fails. Here is the output of current
statue of affair:

# modprobe test_unwind
[   14.905945]     # Subtest: test_unwind
[   14.905948]     1..1
[   14.905949]         # Subtest: test_unwind_flags
[   14.906243]         ok 1 - UWM_DEFAULT
[   14.906375]         ok 2 - UWM_REGS
[   14.906902]         ok 3 - UWM_CALLER
[   14.907010]         ok 4 - UWM_CALLER | UWM_REGS
[   14.907220]         ok 5 - UWM_THREAD
[   14.907445]         ok 6 - UWM_THREAD | UWM_CALLER
[   14.912600]     # test_unwind_flags:  test_unwind+0x70/0x280 [test_unwind]
[   14.912602]     # test_unwind_flags:  unwindme_func4+0x64/0x260 [test_unwind]
[   14.912604]     # test_unwind_flags:  unwindme_func3+0x58/0x80 [test_unwind]
[   14.912605]     # test_unwind_flags:  unwindme_func2+0x18/0x28 [test_unwind]
[   14.912606]     # test_unwind_flags:  unwindme_func1+0x18/0x28 [test_unwind]
[   14.912607]     # test_unwind_flags:  unwindme_timer_fn+0x38/0x54 [test_unwind]
[   14.912608]     # test_unwind_flags:  call_timer_fn+0x38/0x1e0
[   14.912609]     # test_unwind_flags:  run_timer_softirq+0x500/0x550
[   14.912610]     # test_unwind_flags:  __do_softirq+0x124/0x3bc
[   14.912611]     # test_unwind_flags:  irq_exit_rcu+0xf0/0x110
[   14.912611]     # test_unwind_flags:  el1_interrupt+0x3c/0x70
[   14.912612]     # test_unwind_flags:  el1h_64_irq_handler+0x18/0x28
[   14.912612]     # test_unwind_flags:  el1h_64_irq+0x64/0x68
[   14.912613]     # test_unwind_flags:  arch_cpu_idle+0x18/0x28
[   14.912614]     # test_unwind_flags:  default_idle_call+0x6c/0x1d0
[   14.912614]     # test_unwind_flags:  do_idle+0x1f0/0x290
[   14.912615]     # test_unwind_flags:  cpu_startup_entry+0x30/0x38
[   14.912615]     # test_unwind_flags:  kernel_init+0x0/0x140
[   14.912616]     # test_unwind_flags:  arch_post_acpi_subsys_init+0x0/0x28
[   14.912617]     # test_unwind_flags:  start_kernel+0x6dc/0x718
[   14.912618]     # test_unwind_flags:  __primary_switched+0xc0/0xc8
[   14.912618]     # test_unwind_flags:
[   14.912644]     # test_unwind_flags: EXPECTATION FAILED at arch/arm64/kernel/test_unwind.c:501
[   14.912644]     Expected 0 == test_unwind_irq(&u), but
[   14.912644]         test_unwind_irq(&u) == -22
[   14.912656]         not ok 7 - UWM_IRQ
[   14.924625]     # test_unwind_flags:  unwindme_func4+0xa0/0x260 [test_unwind]
[   14.924630]     # test_unwind_flags:  unwindme_func3+0x58/0x80 [test_unwind]
[   14.924632]     # test_unwind_flags:  unwindme_func2+0x18/0x28 [test_unwind]
[   14.924634]     # test_unwind_flags:  unwindme_func1+0x18/0x28 [test_unwind]
[   14.924636]     # test_unwind_flags:  unwindme_timer_fn+0x38/0x54 [test_unwind]
[   14.924638]     # test_unwind_flags:  call_timer_fn+0x38/0x1e0
[   14.924639]     # test_unwind_flags:  run_timer_softirq+0x500/0x550
[   14.924641]     # test_unwind_flags:  __do_softirq+0x124/0x3bc
[   14.924643]     # test_unwind_flags:  irq_exit_rcu+0xf0/0x110
[   14.924645]     # test_unwind_flags:  el1_interrupt+0x3c/0x70
[   14.924646]     # test_unwind_flags:  el1h_64_irq_handler+0x18/0x28
[   14.924647]     # test_unwind_flags:  el1h_64_irq+0x64/0x68
[   14.924648]     # test_unwind_flags:  arch_cpu_idle+0x18/0x28
[   14.924649]     # test_unwind_flags:  default_idle_call+0x6c/0x1d0
[   14.924650]     # test_unwind_flags:  do_idle+0x1f0/0x290
[   14.924651]     # test_unwind_flags:  cpu_startup_entry+0x30/0x38
[   14.924653]     # test_unwind_flags:  kernel_init+0x0/0x140
[   14.924654]     # test_unwind_flags:  arch_post_acpi_subsys_init+0x0/0x28
[   14.924655]     # test_unwind_flags:  start_kernel+0x6dc/0x718
[   14.924656]     # test_unwind_flags:  __primary_switched+0xc0/0xc8
[   14.924657]     # test_unwind_flags:
[   14.924677]     # test_unwind_flags: EXPECTATION FAILED at arch/arm64/kernel/test_unwind.c:501
[   14.924677]     Expected 0 == test_unwind_irq(&u), but
[   14.924677]         test_unwind_irq(&u) == -22
[   14.924724]         not ok 8 - UWM_IRQ | UWM_REGS
[   14.936710]     # test_unwind_flags:  test_unwind+0x70/0x280 [test_unwind]
[   14.936717]     # test_unwind_flags:  unwindme_func4+0x64/0x260 [test_unwind]
[   14.936720]     # test_unwind_flags:  unwindme_func3+0x58/0x80 [test_unwind]
[   14.936722]     # test_unwind_flags:  unwindme_func2+0x18/0x28 [test_unwind]
[   14.936725]     # test_unwind_flags:  unwindme_func1+0x18/0x28 [test_unwind]
[   14.936727]     # test_unwind_flags:  unwindme_timer_fn+0x38/0x54 [test_unwind]
[   14.936729]     # test_unwind_flags:  call_timer_fn+0x38/0x1e0
[   14.936732]     # test_unwind_flags:  run_timer_softirq+0x500/0x550
[   14.936734]     # test_unwind_flags:  __do_softirq+0x124/0x3bc
[   14.936736]     # test_unwind_flags:  irq_exit_rcu+0xf0/0x110
[   14.936738]     # test_unwind_flags:  el1_interrupt+0x3c/0x70
[   14.936739]     # test_unwind_flags:  el1h_64_irq_handler+0x18/0x28
[   14.936741]     # test_unwind_flags:  el1h_64_irq+0x64/0x68
[   14.936743]     # test_unwind_flags:  arch_cpu_idle+0x18/0x28
[   14.936744]     # test_unwind_flags:  default_idle_call+0x6c/0x1d0
[   14.936746]     # test_unwind_flags:  do_idle+0x1f0/0x290
[   14.936748]     # test_unwind_flags:  cpu_startup_entry+0x30/0x38
[   14.936749]     # test_unwind_flags:  secondary_start_kernel+0x198/0x1c8
[   14.936751]     # test_unwind_flags:  __secondary_switched+0xa0/0xa4
[   14.936753]     # test_unwind_flags:
[   14.936839]     # test_unwind_flags: EXPECTATION FAILED at arch/arm64/kernel/test_unwind.c:501
[   14.936839]     Expected 0 == test_unwind_irq(&u), but
[   14.936839]         test_unwind_irq(&u) == -22
[   14.936874]         not ok 9 - UWM_IRQ | UWM_CALLER
[   14.944623]     # test_unwind_flags:  unwindme_func3+0x3c/0x80 [test_unwind]
[   14.944628]     # test_unwind_flags:  unwindme_func2+0x18/0x28 [test_unwind]
[   14.944631]     # test_unwind_flags:  unwindme_func1+0x18/0x28 [test_unwind]
[   14.944633]     # test_unwind_flags:  unwindme_timer_fn+0x38/0x54 [test_unwind]
[   14.944636]     # test_unwind_flags:  call_timer_fn+0x38/0x1e0
[   14.944638]     # test_unwind_flags:  run_timer_softirq+0x500/0x550
[   14.944641]     # test_unwind_flags:  __do_softirq+0x124/0x3bc
[   14.944643]     # test_unwind_flags:  irq_exit_rcu+0xf0/0x110
[   14.944646]     # test_unwind_flags:  el1_interrupt+0x3c/0x70
[   14.944649]     # test_unwind_flags:  el1h_64_irq_handler+0x18/0x28
[   14.944650]     # test_unwind_flags:  el1h_64_irq+0x64/0x68
[   14.944652]     # test_unwind_flags:  arch_cpu_idle+0x18/0x28
[   14.944654]     # test_unwind_flags:  default_idle_call+0x6c/0x1d0
[   14.944656]     # test_unwind_flags:  do_idle+0x1f0/0x290
[   14.944657]     # test_unwind_flags:  cpu_startup_entry+0x2c/0x38
[   14.944659]     # test_unwind_flags:  secondary_start_kernel+0x198/0x1c8
[   14.944661]     # test_unwind_flags:  __secondary_switched+0xa0/0xa4
[   14.944662]     # test_unwind_flags:
[   14.944687]     # test_unwind_flags: EXPECTATION FAILED at arch/arm64/kernel/test_unwind.c:501
[   14.944687]     Expected 0 == test_unwind_irq(&u), but
[   14.944687]         test_unwind_irq(&u) == -22
[   14.944737]         not ok 10 - UWM_IRQ | UWM_CALLER | UWM_REGS
[   14.945009]         ok 11 - UWM_REGS
[   14.945174]         ok 12 - UWM_KPROBE_ON_FTRACE
[   14.945299]         ok 13 - UWM_KPROBE_ON_FTRACE | UWM_REGS
[   14.946894]     # test_unwind_flags:  test_unwind+0x70/0x280 [test_unwind]
[   14.946902]     # test_unwind_flags:  test_unwind_ftrace_handler+0x28/0x40 [test_unwind]
[   14.946904]     # test_unwind_flags:  arch_ftrace_ops_list_func+0xd8/0x1b0
[   14.946906]     # test_unwind_flags:  ftrace_call+0x4/0x2c
[   14.946908]     # test_unwind_flags:  test_unwind_ftraced_func+0x8/0x28 [test_unwind]
[   14.946910]     # test_unwind_flags:  unwindme_func4+0x1b4/0x260 [test_unwind]
[   14.946912]     # test_unwind_flags:  unwindme_func3+0x58/0x80 [test_unwind]
[   14.946915]     # test_unwind_flags:  unwindme_func2+0x18/0x28 [test_unwind]
[   14.946917]     # test_unwind_flags:  unwindme_func1+0x18/0x28 [test_unwind]
[   14.946918]     # test_unwind_flags:  test_unwind_flags+0x5c/0x288 [test_unwind]
[   14.946920]     # test_unwind_flags:  kunit_try_run_case+0x58/0xc0 [kunit]
[   14.946921]     # test_unwind_flags:  kunit_generic_run_threadfn_adapter+0x28/0x38 [kunit]
[   14.946923]     # test_unwind_flags:  kthread+0x118/0x128
[   14.946924]     # test_unwind_flags:  ret_from_fork+0x10/0x20
[   14.946925]     # test_unwind_flags:
[   15.104639]     # test_unwind_flags: EXPECTATION FAILED at arch/arm64/kernel/test_unwind.c:503
[   15.104639]     Expected 0 == unwindme_func1(&u), but
[   15.104639]         unwindme_func1(&u) == -22
[   15.104691]         not ok 14 - UWM_FTRACE
[   15.240652]         ok 15 - UWM_FTRACE | UWM_REGS
[   15.264620]         ok 16 - UWM_KRETPROBE
[   15.292603]         ok 17 - UWM_KRETPROBE | UWM_REGS
[   15.293173]     # test_unwind_flags:  test_unwind+0x70/0x280 [test_unwind]
[   15.293175]     # test_unwind_flags:  kretprobe_ret_handler+0x38/0x50 [test_unwind]
[   15.293177]     # test_unwind_flags:  __kretprobe_trampoline_handler+0xec/0x188
[   15.293178]     # test_unwind_flags:  trampoline_probe_handler+0x30/0x50
[   15.293180]     # test_unwind_flags:  __kretprobe_trampoline+0x74/0xc8
[   15.293181]     # test_unwind_flags:  test_unwind_kretprobed_func_caller+0x18/0x28 [test_unwind]
[   15.293183]     # test_unwind_flags:  test_unwind_kretprobe+0xac/0x148 [test_unwind]
[   15.293185]     # test_unwind_flags:  unwindme_func4+0xf0/0x260 [test_unwind]
[   15.293186]     # test_unwind_flags:  unwindme_func3+0x58/0x80 [test_unwind]
[   15.293187]     # test_unwind_flags:  unwindme_func2+0x18/0x28 [test_unwind]
[   15.293188]     # test_unwind_flags:  unwindme_func1+0x18/0x28 [test_unwind]
[   15.293189]     # test_unwind_flags:  test_unwind_flags+0x5c/0x288 [test_unwind]
[   15.293190]     # test_unwind_flags:  kunit_try_run_case+0x58/0xc0 [kunit]
[   15.293191]     # test_unwind_flags:  kunit_generic_run_threadfn_adapter+0x28/0x38 [kunit]
[   15.293192]     # test_unwind_flags:  kthread+0x118/0x128
[   15.293192]     # test_unwind_flags:  ret_from_fork+0x10/0x20
[   15.293193]     # test_unwind_flags:
[   15.308570]     # test_unwind_flags: EXPECTATION FAILED at arch/arm64/kernel/test_unwind.c:503
[   15.308570]     Expected 0 == unwindme_func1(&u), but
[   15.308570]         unwindme_func1(&u) == -22
[   15.308611]         not ok 18 - UWM_KRETPROBE_HANDLER
[   15.324616]         ok 19 - UWM_KRETPROBE_HANDLER | UWM_REGS
[   15.324620]     # test_unwind_flags: pass:11 fail:6 skip:2 total:19
[   15.324623]     not ok 1 - test_unwind_flags
[   15.324626] # Totals: pass:11 fail:6 skip:2 total:19
[   15.324628] not ok 1 - test_unwind

Regards,
Ivan

[1] 20220617210717.27126-1-madvenka@linux.microsoft.com

Ivan T. Ivanov (1):
  arm64: Add initial set of stack unwinder self tests

 arch/arm64/Kconfig.debug        |  12 +
 arch/arm64/kernel/Makefile      |   1 +
 arch/arm64/kernel/stacktrace.c  |  23 ++
 arch/arm64/kernel/test_unwind.c | 518 ++++++++++++++++++++++++++++++++
 include/linux/stacktrace.h      |   1 +
 5 files changed, 555 insertions(+)
 create mode 100644 arch/arm64/kernel/test_unwind.c

-- 
2.35.3

