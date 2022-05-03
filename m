Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEEB9517C36
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 05:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbiECDYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 23:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbiECDYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 23:24:02 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9352F10FD8
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 20:20:28 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id iq2-20020a17090afb4200b001d93cf33ae9so1094453pjb.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 20:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h50XDSyKixSxM+z0LW5l4U/wJvmofE6DIDaRFzdf6Ag=;
        b=TcyGN4xpYSuKm3q0wZOEg+HeSREDfAnufCFQNhVFSWhXs94V5KYhHXeTUKxksz1U66
         0ngEAjWO0uP/V9MLW1RZ4Ws73T6nudcrpJtckG6I0SIQV4wkyc+Nq4e6rr+0oYIUuZV8
         ins6WCIjSEFo+4CyzxjLyBrPeAynz3puz8iIBaNDOE8bYjGa9j5wa0nBKka6vfuRctNb
         JhaL4KfEMdb5iWeyOxUsLJegogB7JQbR4BwVBoID+iHzq0zrpsjT5MfT18BPBlupzmOq
         YMxLSWm90/7oL+P88aZJz2IExiGwl6yrANB4R6SWVPkXT4/gQh6RreqlfkXbQKXk6Iov
         imiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h50XDSyKixSxM+z0LW5l4U/wJvmofE6DIDaRFzdf6Ag=;
        b=nQk3Q/wNR4/FgPYs/FIq6Kfh47X4L6ey35ZEYoop6z4y25OZqRqVYdgiH81EqoQLYU
         RcIJaLhQBfZNg8zpck78LPkqZzkPYj1pGgVP4HTIXGJ5meSFneWQJWn9TNng5GPgBi/w
         tf8vPMXXKqiAPC9GgTKAkuBYyEgmIfiwoZf/QiHgH06e5vODixin3T8j0RibUFrrWpAV
         ah31p7pW8H8veLb4IqLXOyCkNl6hhTq2MfEcNT1MWsDuu+6qOc142PTYW+amlS1GNK7u
         2iXtfs94pinBNZInC3WZilt+Dtcd8hqWk746OI2IJfrBCWWz2HIxTleDCWiwQMDwUTYj
         Yg7w==
X-Gm-Message-State: AOAM533juDZLlcPPmza9SzrLHTA29ZSRUJSKT9wgSHyRmAZZ432uTkMR
        BcZH2j79CIA1PKBFY+Lh0PgEtYzeh4k=
X-Google-Smtp-Source: ABdhPJwPfhJOlINjCLaBHIOYM70opmaVw9A2E1c0+iVw5s+ao5qlt2gDM7aX/za+klXta6RgcDcWyw==
X-Received: by 2002:a17:902:778a:b0:158:da0f:f299 with SMTP id o10-20020a170902778a00b00158da0ff299mr14692035pll.29.1651548027881;
        Mon, 02 May 2022 20:20:27 -0700 (PDT)
Received: from localhost ([47.251.4.198])
        by smtp.gmail.com with ESMTPSA id n19-20020a6563d3000000b003c14af5063dsm12047310pgv.85.2022.05.02.20.20.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 May 2022 20:20:27 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Juergen Gross <jgross@suse.com>, x86@kernel.org,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>
Subject: [PATCH V7 0/6] x86/entry: Clean up entry code
Date:   Tue,  3 May 2022 11:21:01 +0800
Message-Id: <20220503032107.680190-1-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <jiangshan.ljs@antgroup.com>

This patchset moves the stack-switch code to the place where
error_entry() return, unravels error_entry() from XENpv and makes
entry_INT80_compat() uses idtentry macro.

This patchset is highly related to XENpv, because it does the extra
cleanup to convert SWAPGS to swapgs after major cleanup is done.

The patches are the 7th version to pick patches from the patchset
https://lore.kernel.org/lkml/20211126101209.8613-1-jiangshanlai@gmail.com/
which converts ASM code to C code.  These patches are prepared for that
purpose.  But this patchset has it own value: it simplifies the stack
switch, avoids leaving the old stack inside a function call, and
separates XENpv code with native code without adding new code.

Peter said in V3:
>	So AFAICT these patches are indeed correct.
>
>	I'd love for some of the other x86 people to also look at this,
>	but a tentative ACK on this.

[V6]: https://lore.kernel.org/lkml/20220421141055.316239-1-jiangshanlai@gmail.com/
[V5]: https://lore.kernel.org/lkml/20220412121541.4595-1-jiangshanlai@gmail.com/
[V4]: https://lore.kernel.org/lkml/20220318143016.124387-1-jiangshanlai@gmail.com/
[V3]: https://lore.kernel.org/lkml/20220315073949.7541-1-jiangshanlai@gmail.com/
[V2]: https://lore.kernel.org/lkml/20220303035434.20471-1-jiangshanlai@gmail.com/
[V1]: https://lore.kernel.org/lkml/20211208110833.65366-1-jiangshanlai@gmail.com/


Changed from V6:
	(no code changed)

	Update the changelog of patch3 and patch6

	Drop patch7 and patch8 of the V6.  The patch7/8 are nice cleanup
	patches but they are not required to convert error_entry() to C.
	The changelog of patch8 is also updated locally to avoid ambiguity
	that tglx questioned, and it will be sent separately after PeterZ's
	change to entry_INT80_compat() merged to avoid confliction.

Changed from V5:
	Add a new ASM function to wrap PUSH_AND_CLEAR_REGS rather than
	inline it in the marco idtentry to reduce text size.

	Remove the branch in sync_regs() (pick it from V1 and update
	the changelog a little)

Changed from V4:
	Update changelog largely of patch 1 and patch 2
	Update changelog slightly of other patches
	Unbreak the line of fixup_bad_iret() in patch1

	Add Reviewed-by from Juergen Gross <jgross@suse.com> in patch 6
	since he gave the Reviewed-by in one of the squashed patches.

Changed from V3:
	Only reorder the int80 thing as the last patch to make patches
	ordering more natural. (Both orders are correct)

Other interactions in V3:
	Peter raised several questions and I think I answered them and I
	don't think the code need to be updated unless I missed some
	points. (Except reordering the patches)

	Josh asked to remove UNWIND_HINT_REGS in patch5, but I think
	UNWIND_HINT_REGS is old code before this patchset and I don't
	want to do a cleanup that is not relate to preparing converting
	ASM code C code in this patchset.  He also asked to remove
	ENCODE_FRAME_POINTER in xenpv case, and I think it just
	complicates the code for just optimizing out a single assignment
	to %rbp.  I would not always stick to these reasons of mine,
	but I just keep the code unchanged since he hasn't emphasized it
	again nor other people has requested it.

Changed from V2:
	Make the patch of folding int80 thing as the first patch
	Add more changelog in "Switch the stack after error_entry() returns"

Changed from V1
	Squash cleanup patches converting SWAPGS to swapgs into one patch

	Use my official email address (Ant Group).  The work is backed
	by my company and I was incorrectly misunderstood that
	XXX@linux.alibaba.com is the only portal for opensource work
	in the corporate group.


Lai Jiangshan (6):
  x86/traps: Move pt_regs only in fixup_bad_iret()
  x86/entry: Switch the stack after error_entry() returns
  x86/entry: Move PUSH_AND_CLEAR_REGS out of error_entry()
  x86/entry: Move cld to the start of idtentry macro
  x86/entry: Don't call error_entry() for XENPV
  x86/entry: Convert SWAPGS to swapgs and remove the definition of
    SWAPGS

 arch/x86/entry/entry_64.S        | 53 ++++++++++++++++++++++----------
 arch/x86/entry/entry_64_compat.S |  2 +-
 arch/x86/include/asm/irqflags.h  |  8 -----
 arch/x86/include/asm/traps.h     |  2 +-
 arch/x86/kernel/traps.c          | 18 ++++-------
 5 files changed, 44 insertions(+), 39 deletions(-)

-- 
2.19.1.6.gb485710b

