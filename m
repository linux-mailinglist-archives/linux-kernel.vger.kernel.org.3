Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 877E64DDBAC
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 15:30:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237262AbiCRObA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 10:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237019AbiCROa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 10:30:57 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7058D4B1CB
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 07:29:38 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id p17so7071513plo.9
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 07:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+mCPG5dYcMcn5OmQuL4zvbFmpk8fieiPl0n7S53AQl8=;
        b=bK0nd7PFyHCG6nbFSsTzkGYuvphh9UG6IAdBxWnfbULGiOtDqhd8Af4GseM1nABz0G
         PyXVeGUfRCz6Sk7L8puZoolmDXz6dOKD3JCQr2ygGfDFiU+rWbajtKn2JT7jC2FGuHVq
         Q8izlOZ69MlSVCzQE6Ypq5yohH9hXvrxM8KkstUtODIcSshOGiDhZjNplFA4O5kv+/Qv
         MOd5ygGfVT4Od3RMNlrOj0DPb+PnQsUbkqbrtHh66q46cdZb/zItZZbPH1DfI+QOCmKo
         zyRe2Tgjn5trvvRkt+XEsGDB4CvgJU9zKM5StwcVtVu55VEg/B0FICVVbE1YZ1zid7op
         Tj7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+mCPG5dYcMcn5OmQuL4zvbFmpk8fieiPl0n7S53AQl8=;
        b=q9c0kQcDviIxnJUMT0XrNwF4LEWf3G+5Y2ZndioafUBcfAnTYQ3a6ZR/RroHl/TYRj
         xCguOBWjhesEP0UeF4vY5adQxH2R1C9/Ljl+jbXE8duUKBhQKfythNOSBoYXHlt/zr91
         d+aQ3Z2lUbIrS7Pr9tge2lqWKiHKiKWveVdacug56OUmcvYoBbvyFeNCq1aLU2FzeM3W
         9+wdMtOpQI2VbB1bebfZJmSCBcWXolrrW6sAOt964X9aVzTqz2M9F/fze4da6jvn+q6e
         F1vGI5Zf5lX+iEPjT9mcas8Oc1eORtRCf0EBNC/0sV6IRamSDINSc17XIPsCTeWctMII
         vDiQ==
X-Gm-Message-State: AOAM5329umkCxUQZJBvmw/9h6zEuZy5v3YslUlZ84SzTcO+JKkhsCplb
        xCxfxbMf+rcqO4BAYuVGZrzlEyvqdW0=
X-Google-Smtp-Source: ABdhPJw9Hh4++W/sRJPwxiGUJeoBkDtyY9IFgorvlPWENFXmMr0CIVcW/2n68L/sQEoDuWyKTZmRDg==
X-Received: by 2002:a17:90b:4785:b0:1c6:ad62:dda3 with SMTP id hz5-20020a17090b478500b001c6ad62dda3mr4004360pjb.232.1647613777728;
        Fri, 18 Mar 2022 07:29:37 -0700 (PDT)
Received: from localhost ([47.251.4.198])
        by smtp.gmail.com with ESMTPSA id oo16-20020a17090b1c9000b001b89e05e2b2sm9032045pjb.34.2022.03.18.07.29.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Mar 2022 07:29:37 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>
Subject: [PATCH V4 0/7] x86/entry: Clean up entry code
Date:   Fri, 18 Mar 2022 22:30:09 +0800
Message-Id: <20220318143016.124387-1-jiangshanlai@gmail.com>
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
entry_INT80_compat use idtentry macro.

This patchset is highly related to XENpv, because it does the extra
cleanup to convert SWAPGS to swapgs after major cleanup is done.

The patches are the 4th version to pick patches from the patchset
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

Changed from V3:
	Only reorder the int80 thing as the last patch to make patches
	ordering more natural. (Both orders are correct)

Changed from V2:
	Make the patch of folding int80 thing as the first patch
	Add more changelog in "Switch the stack after error_entry() returns"

Changed from V1
	Squash cleanup patches converting SWAPGS to swapgs into one patch

	Use my official email address (Ant Group).  The work is backed
	by my company and I was incorrectly misunderstood that
	XXX@linux.alibaba.com is the only portal for opensource work
	in the corporate group.

[V3]: https://lore.kernel.org/lkml/20220315073949.7541-1-jiangshanlai@gmail.com/
[V2]: https://lore.kernel.org/lkml/20220303035434.20471-1-jiangshanlai@gmail.com/
[V1]: https://lore.kernel.org/lkml/20211208110833.65366-1-jiangshanlai@gmail.com/

Lai Jiangshan (7):
  x86/traps: Move pt_regs only in fixup_bad_iret()
  x86/entry: Switch the stack after error_entry() returns
  x86/entry: move PUSH_AND_CLEAR_REGS out of error_entry
  x86/entry: Move cld to the start of idtentry
  x86/entry: Don't call error_entry for XENPV
  x86/entry: Convert SWAPGS to swapgs and remove the definition of
    SWAPGS
  x86/entry: Use idtentry macro for entry_INT80_compat

 arch/x86/entry/entry_64.S        |  61 +++++++++++++-----
 arch/x86/entry/entry_64_compat.S | 105 +------------------------------
 arch/x86/include/asm/idtentry.h  |  47 ++++++++++++++
 arch/x86/include/asm/irqflags.h  |   8 ---
 arch/x86/include/asm/proto.h     |   4 --
 arch/x86/include/asm/traps.h     |   2 +-
 arch/x86/kernel/traps.c          |  17 ++---
 7 files changed, 100 insertions(+), 144 deletions(-)

-- 
2.19.1.6.gb485710b

