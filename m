Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7970C46D196
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 12:08:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232056AbhLHLL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 06:11:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbhLHLLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 06:11:55 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF863C061746
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 03:08:23 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id u17so1293891plg.9
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 03:08:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Vg9Y2qwD//mZgSKr3fZbhivDw/ZV22tqoORXTECSxD0=;
        b=itA2cU4V+5hxMb7u2gRFEQ1+caoQ2C6iLL4Fv57ZS4wZBzPvuhal8+Wof+IBV2ZzFb
         s2tdy0Tr/vbgqc2MIJigFoYeK2iyBV8JxxmYf5q/00Xg/nJbsoP4kmY/9BaWVuGvv2s2
         lLetMIdPIz5oRvlGXasZrXiq6C5QKp1frYuVwMsgnvETSMhtBF0wwrkQcW9lI86ig/FW
         7cskonVCDC3F55ogBf3ouGCxkQv7EJlkYJYn2787sM5cAs6rdlG8444budASlJXS7phF
         6YHtZaKt41EOOPo+aL15YJjiGRzr7l7dYwx/MybZUEc4N41Rgw7J4UKXwAxZZsXPeNft
         AJhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Vg9Y2qwD//mZgSKr3fZbhivDw/ZV22tqoORXTECSxD0=;
        b=lBu4M72yxTkClbi2fcZto6O9MfErZxSNhOkwQ368D5wicru71+mKT3/MZHY75PuC8K
         TaPUsRqMsIB1uUMvkWA45Uy8wgHoyrMLJ2zT4zcH8ZGKjA33246Gebi/DyJb7MAeZFQd
         6l4C8bsWhIq/Wn//TNvymyjPSY1nxOsDpG4KB1lTvVYlG85B58zY5Tsk0Chcx4FkkYm0
         /GZL03rNkJoVm/LWfxzGXx4yo9G/z9doIqIm0V4C3ady/84KAw8pr7TNejl7d2pCgaXa
         7reavlHJGDTuDibiLUu0vaGrzKBEIea9eunDVdQytdbJAKd88UJwbIWWOba4zhVjFQRJ
         71Pw==
X-Gm-Message-State: AOAM532puuZXH8vAtgMyiYVVUINGaQNYbUftE2Bbg6QLEGgruwyzzrL2
        +Jbq0pTi6LYhxtIVUXwXhpSQ/euGupk=
X-Google-Smtp-Source: ABdhPJyJqUq+r8DKUrbjm4AzKKBjH7UT96ssoju6KRFceh7AParCUM4v9ULbwlHtBmu1m5eyPpa1Ww==
X-Received: by 2002:a17:90a:384d:: with SMTP id l13mr6534667pjf.104.1638961702635;
        Wed, 08 Dec 2021 03:08:22 -0800 (PST)
Received: from localhost ([47.251.3.230])
        by smtp.gmail.com with ESMTPSA id h13sm3072127pfv.37.2021.12.08.03.08.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Dec 2021 03:08:22 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, xen-devel@lists.xenproject.org,
        Lai Jiangshan <laijs@linux.alibaba.com>
Subject: [PATCH 00/11] x86/entry: Clean up entry code
Date:   Wed,  8 Dec 2021 19:08:22 +0800
Message-Id: <20211208110833.65366-1-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

This patchset moves the stack-switch code to the place where
error_entry() return, distangles error_entry() from XENpv and makes
entry_INT80_compat use idtentry macro.

This patchset is highly related to XENpv, because it does the extra
cleanup to convert SWAPGS to swapgs after major cleanup is done.

After error_entry() is distangled from XENpv, a branch in sync_regs()
is removed to.

Patch 1-10 are picked from the patchset
https://lore.kernel.org/lkml/20211126101209.8613-1-jiangshanlai@gmail.com/
which coverts ASM code to C code.  These patches are prepared for that
purpose.  But this patchset has it own value: it simplifies the stack
switch, avoids leaving the old stack inside a function, and separates
XENpv code with native code without adding new code which can lead to
more cleanups.

Patch 11 is new in this patchset.

Lai Jiangshan (11):
  x86/entry: Use swapgs and native_iret directly in
    swapgs_restore_regs_and_return_to_usermode
  x86/traps: Move pt_regs only in fixup_bad_iret()
  x86/entry: Switch the stack after error_entry() returns
  x86/entry: move PUSH_AND_CLEAR_REGS out of error_entry
  x86/entry: Move cld to the start of idtentry
  x86/entry: Don't call error_entry for XENPV
  x86/entry: Convert SWAPGS to swapgs in error_entry()
  x86/entry: Use idtentry macro for entry_INT80_compat
  x86/entry: Convert SWAPGS to swapgs in entry_SYSENTER_compat()
  x86: Remove the definition of SWAPGS
  x86/entry: Remove the branch in sync_regs()

 arch/x86/entry/entry_64.S        |  65 +++++++++++++------
 arch/x86/entry/entry_64_compat.S | 104 +------------------------------
 arch/x86/include/asm/idtentry.h  |  47 ++++++++++++++
 arch/x86/include/asm/irqflags.h  |   2 -
 arch/x86/include/asm/proto.h     |   4 --
 arch/x86/include/asm/traps.h     |   2 +-
 arch/x86/kernel/traps.c          |  25 ++++----
 7 files changed, 107 insertions(+), 142 deletions(-)

-- 
2.19.1.6.gb485710b

