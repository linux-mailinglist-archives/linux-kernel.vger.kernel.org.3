Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F31150A1C8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 16:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388958AbiDUON2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 10:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389085AbiDUOM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 10:12:59 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB143968F
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 07:10:09 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id z6-20020a17090a398600b001cb9fca3210so5296218pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 07:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nWAOIeoAUG61U2JhBd5yvRRsznrLNb1E1jHIcBreaQY=;
        b=IoigWi1kgWvXJtE4vVS9+/Wjw7iyYzXR/gX2bowqWY5VuZTlf5afhuKya1agjYzQ6D
         bvqc+qySL7KJUfm8o/GkH8OVxcCnDEkWN53IlfZ8CuEvERmaClfp0spE1Y5zdsWECf12
         JhvpuEyBGX3LZlEkbsNkp7ep+x4+2tTuK3sHvy+oBsHYc1JESNqbnof8DhofMg6uRjA4
         +I/7T/WvcTMiUqmY9xE9D3NKcOmWIo52ah+Ybca51PUUQ10INhuU+7Wihx2JGl5N9nUv
         GY3IRGvao6LB00Zu7Gsz/DzvXzUlbyMM8iVsEEUm/8+tCU3t7m0Jdr5LmQ1m9cCtmyKC
         ramg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nWAOIeoAUG61U2JhBd5yvRRsznrLNb1E1jHIcBreaQY=;
        b=GhY66+bApu4AaiCE+s1Lzxr1lv/whYx9mPt7AjpXIamgLTD7M2x9V1FgEvtd2BqAy0
         /qROTC5xXtCNLbrcPKsU4NEkrra25zbUEn0zkne/WdRsOT8eie8/rzBJYZuUxDALxrNs
         sxEwMnLrqG9M2mAZviZFz+/ki2F8UXR4/SLLs4m70WXYlrkLbsrr/t0nTtUreRM7KvfV
         dMe6TXLpPdR1KEtZq21ysTM9gWrPekjuayABEEtUhgwXpnfw53U0qymkIUZcPttk8aRy
         lqRP91LicUEPiPqs7AxtFOAJOdi4DQDw3vhr+/Iajz6zVhZnoGzUrcFkuGL802M79wlt
         Vk9A==
X-Gm-Message-State: AOAM531wYQmzoWL9BIJqfbmzvVPj47WaAdnvklo2QNO4EZktIQih5GrB
        Mln/+pbZdaiycK4oi/4FfCYzW2lz1xo=
X-Google-Smtp-Source: ABdhPJy09FYAjBd1cPfs8AKf72NAxQcmc/xZ93Na77RcLi446+ODJcqvaZi8Ea3Bk+ND6fjqE5WmbQ==
X-Received: by 2002:a17:903:285:b0:158:d693:c52c with SMTP id j5-20020a170903028500b00158d693c52cmr25833330plr.36.1650550209157;
        Thu, 21 Apr 2022 07:10:09 -0700 (PDT)
Received: from localhost ([47.251.4.198])
        by smtp.gmail.com with ESMTPSA id s3-20020a056a00194300b004f6da3a1a3bsm12180210pfk.8.2022.04.21.07.10.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Apr 2022 07:10:08 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Juergen Gross <jgross@suse.com>, x86@kernel.org,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>
Subject: [PATCH V6 0/8] x86/entry: Clean up entry code
Date:   Thu, 21 Apr 2022 22:10:47 +0800
Message-Id: <20220421141055.316239-1-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

The patches are the 6th version to pick patches from the patchset
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

[V5]: https://lore.kernel.org/lkml/20220412121541.4595-1-jiangshanlai@gmail.com/
[V4]: https://lore.kernel.org/lkml/20220318143016.124387-1-jiangshanlai@gmail.com/
[V3]: https://lore.kernel.org/lkml/20220315073949.7541-1-jiangshanlai@gmail.com/
[V2]: https://lore.kernel.org/lkml/20220303035434.20471-1-jiangshanlai@gmail.com/
[V1]: https://lore.kernel.org/lkml/20211208110833.65366-1-jiangshanlai@gmail.com/


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


Lai Jiangshan (8):
  x86/traps: Move pt_regs only in fixup_bad_iret()
  x86/entry: Switch the stack after error_entry() returns
  x86/entry: Move PUSH_AND_CLEAR_REGS out of error_entry()
  x86/entry: Move cld to the start of idtentry macro
  x86/entry: Don't call error_entry() for XENPV
  x86/entry: Convert SWAPGS to swapgs and remove the definition of
    SWAPGS
  x86/entry: Remove the branch in sync_regs()
  x86/entry: Use idtentry macro for entry_INT80_compat()

 arch/x86/entry/entry_64.S        |  71 ++++++++++++++++-----
 arch/x86/entry/entry_64_compat.S | 105 +------------------------------
 arch/x86/include/asm/idtentry.h  |  47 ++++++++++++++
 arch/x86/include/asm/irqflags.h  |   8 ---
 arch/x86/include/asm/proto.h     |   4 --
 arch/x86/include/asm/traps.h     |   2 +-
 arch/x86/kernel/traps.c          |  24 +++----
 7 files changed, 112 insertions(+), 149 deletions(-)

-- 
2.19.1.6.gb485710b

