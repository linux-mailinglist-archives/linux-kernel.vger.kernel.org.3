Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0DBC47AAD3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 15:01:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233295AbhLTOBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 09:01:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231355AbhLTOBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 09:01:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5238AC061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 06:01:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA2E761155
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 14:01:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6F6AC36AE8;
        Mon, 20 Dec 2021 14:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640008910;
        bh=AkghpouVEQBWq+J5J3/TJlgBCWrju8lEwOVB020GmJw=;
        h=From:To:Cc:Subject:Date:From;
        b=nwQMEza4O4dXlSzxdu1qqviTQwoVG86HJibZr1dlzn1FUVL894BSAiQNDUfReap26
         CxMHJaQ4fL6snInAEoeARgbKHd0LBy6zhlf3UQoKCMHOiSGZpF0bGuT5QXqJ71xcNM
         0LNTHYfRtVc5OdPfWWgmT62BNNKKMQq7ZRTQX9GHSo2HGXdC8dOi0T9nCExLN/9VcV
         aLq98j+DDldtXLY7utOcm/TBHMOwvzPIMCWPi0n1ZSZXqcf9fUYdmlAPyDMM/FSwWE
         n+Hleqa7ubbOnImzEPIP84S1TiY/UQngVNT4qirLzyVitdtEdzdlgEJHlzThNx9cML
         9BZ3spKTxLxsQ==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        James Morse <james.morse@arm.com>,
        David Laight <David.Laight@ACULAB.COM>,
        Sami Tolvanen <samitolvanen@google.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Quentin Perret <qperret@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [GIT PULL] arm64: Support dynamic preemption v3
Date:   Mon, 20 Dec 2021 15:01:37 +0100
Message-Id: <20211220140142.922323-1-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I haven't seen much comments on the static key based version from Mark
so I don't know which direction we'll eventually take. I still hope we
can focus on a unified static call based implementation, considering
there are other users waiting on arm64 static calls.

So here is a rebase against the latest tip:sched/core and arm64 static
call proposal.

git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
	preempt/arm-v4

HEAD: 6fc1c7e3d83c4e06b019b041894d9bb25f37ac6c

Thanks,
	Frederic
---

Frederic Weisbecker (3):
      sched/preempt: Prepare for supporting !CONFIG_GENERIC_ENTRY dynamic preemption
      arm64: Implement IRQ exit preemption static call for dynamic preemption
      arm64: Implement HAVE_PREEMPT_DYNAMIC

Ard Biesheuvel (2):
      static_call: Use non-function types to refer to the trampolines
      arm64: implement support for static call trampolines


 arch/Kconfig                         |  1 -
 arch/arm64/Kconfig                   |  3 ++
 arch/arm64/include/asm/preempt.h     | 23 ++++++++++-
 arch/arm64/include/asm/static_call.h | 40 +++++++++++++++++++
 arch/arm64/kernel/entry-common.c     | 15 +++++--
 arch/arm64/kernel/patching.c         | 77 ++++++++++++++++++++++++++++++++++--
 arch/arm64/kernel/vmlinux.lds.S      |  1 +
 include/linux/entry-common.h         |  3 +-
 include/linux/static_call.h          |  4 +-
 include/linux/static_call_types.h    | 11 ++++--
 kernel/sched/core.c                  |  6 ++-
 11 files changed, 168 insertions(+), 16 deletions(-)
