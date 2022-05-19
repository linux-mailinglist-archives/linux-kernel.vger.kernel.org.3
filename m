Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FAAF52DF6E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 23:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245214AbiESVlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 17:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243888AbiESVlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 17:41:22 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0340F3FDBE
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 14:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=PnRbFyOR7yBy1AOl/JeZxOddOldJ8FfqgvJP/DyJT78=; b=b9Qgs17c+guxr3IeOTBOGyfYK0
        wMdjBPq8eZxgPqugZHQViBghd/LZrTjru/+jjAV4yxnqxtm7fyrwiIo6jdox6uJqj3DhJF54te9Zn
        Faay1w7suhjrOvUg3sAwZGiINQlsYqxtmjPg/6IEnXEmgBLsYNOaLngXPgkBpmcQs4Q52bPjkIe7p
        aZOQGxn3UvKRZ6N+N3oWfSSmGnxyASzEd/ZWZo3/9EZHatuTKzrh5pEl+ihTM3OSGjcwFW0rXD1pD
        anCJqVP6xf6VsedbIvunSa4UfgTgqH50IRpzDRQ7KWLHyYTTAM9rVRJgsddXxsyA1DLaE0V6ZbwLF
        OpfF7M9w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nrntN-0028dm-CY; Thu, 19 May 2022 21:41:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1F267300792;
        Thu, 19 May 2022 23:41:07 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id F1C492021C30C; Thu, 19 May 2022 23:41:06 +0200 (CEST)
Message-ID: <20220519212750.656413111@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 19 May 2022 23:27:50 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     frederic@kernel.org, paulmck@kernel.org, rjw@rjwysocki.net,
        x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        jpoimboe@kernel.org
Subject: [RFC][PATCH 0/9] Rework cpuidle vs instrumentation
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Most of these patches (with some obvious exceptions) stem from the period when
we did the entry rewrite. I might even have posted some of them, but they
landed on the floor and went unloved for a while.

Luckily, Frederic added a comment in his context tracking rework that made me
remember these.

They build and boot x86_64. Be sure to build with DEBUG_ENTRY enabled to find
noinstr violations -- I fixed all I found, but I didn't do allyesconfig builds.

Please have a look.

  git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git sched/idle

---
 arch/alpha/kernel/process.c       |  1 -
 arch/arc/kernel/process.c         |  3 ++
 arch/arm/kernel/process.c         |  1 -
 arch/arm/mach-gemini/board-dt.c   |  3 +-
 arch/arm/mach-imx/cpuidle-imx6q.c |  5 +--
 arch/arm64/kernel/idle.c          |  1 -
 arch/csky/kernel/process.c        |  1 -
 arch/csky/kernel/smp.c            |  2 +-
 arch/h8300/kernel/process.c       |  1 +
 arch/hexagon/kernel/process.c     |  1 -
 arch/ia64/kernel/process.c        |  1 +
 arch/microblaze/kernel/process.c  |  1 -
 arch/mips/kernel/idle.c           |  8 ++---
 arch/nios2/kernel/process.c       |  1 -
 arch/openrisc/kernel/process.c    |  1 +
 arch/parisc/kernel/process.c      |  2 --
 arch/powerpc/kernel/idle.c        |  5 ++-
 arch/riscv/kernel/process.c       |  1 -
 arch/s390/kernel/idle.c           |  1 -
 arch/sh/kernel/idle.c             |  1 +
 arch/sparc/kernel/leon_pmc.c      |  4 +++
 arch/sparc/kernel/process_32.c    |  1 -
 arch/sparc/kernel/process_64.c    |  3 +-
 arch/um/kernel/process.c          |  1 -
 arch/x86/coco/tdx/tdx.c           |  3 ++
 arch/x86/events/amd/brs.c         | 13 +++-----
 arch/x86/include/asm/irqflags.h   | 11 +++----
 arch/x86/include/asm/mwait.h      |  2 +-
 arch/x86/kernel/process.c         | 64 +++++++++++++++++++--------------------
 arch/xtensa/kernel/process.c      |  1 +
 drivers/acpi/processor_idle.c     | 42 ++++++++++++++-----------
 drivers/cpuidle/cpuidle.c         | 21 +++++++------
 drivers/cpuidle/poll_state.c      |  6 +++-
 include/linux/compiler_types.h    |  8 +++--
 include/linux/cpu.h               |  3 --
 include/linux/sched/idle.h        | 29 ++++++++++++++++++
 kernel/rcu/tree.c                 |  9 ++----
 kernel/sched/idle.c               | 47 ++++++++--------------------
 kernel/time/tick-broadcast.c      |  2 +-
 tools/objtool/check.c             | 15 ++++++++-
 40 files changed, 176 insertions(+), 150 deletions(-)


