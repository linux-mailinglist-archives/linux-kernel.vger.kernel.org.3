Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2058E4CB58E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 04:54:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbiCCDyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 22:54:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiCCDym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 22:54:42 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45AE51451CC
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 19:53:58 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id a5so3690786pfv.9
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 19:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SvfUCEnLlrDB3sIsrkTKZcGGzKpndmxrZbu5cWRKWwk=;
        b=hont9Quy8WqECiI2Al1ruh+1bgXITLBPUzJPCdQmMGigjU8dDJAkKl+YEiR/c5WdnW
         xkW2Sk8BmVe5wqwHN4zwEw/qlD7QSBspPH0bU4O29CTs5f/Stgg9gwyZ+sHTd2k0fl+P
         PWLUxWN4LqL3DVzb0V03Ye4yToMYtLMn1+nLx9OGc/TVG2F6GdfrwPBr12aEVACdAY67
         9CD/x+EfcVfomHWGOcoAUUWrBBNrkZgalg3532Fn90rYIWaoTu7+ku8f/ieRJJZWKAZJ
         KF64eEoqtOoPW+8duTfIxPOz9p2FjwH3DgtdxRl6X8aP65c+Nhu7556u3vid3ITfHk1I
         tDpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SvfUCEnLlrDB3sIsrkTKZcGGzKpndmxrZbu5cWRKWwk=;
        b=JmFOKz1p5U3sUEHc6bzfMS5PIxnxjsnZr5NQrTghj2UQvHNy9wEhAFw9CgIsdjaPml
         JhQzzoEmakqxCdA+yYpf2BHoxmtaCDcZL9CvIBALvLIcl633y0ITytGakfD0IBnZ7ZTG
         v8OmIN3Wrfc9mIz058OX16DXf9Zo2WFV8/iGAt1nd6AEEWHdTaps8/HlxXlB9DJaXQav
         nHwMLySLO3m1NrS6Q4FA8XzYDs/F3W2OnAs2E1yUXNdvntX5KUdVxcviFnTNuzsCkbIm
         UaqoFs79hl+Zrd7czlTQmsm+uEA8dRYl9Vk2CZtc9IfFOZy5Nk+o13iFfw5yW9udXfft
         ZKmA==
X-Gm-Message-State: AOAM531c7x+84LkRpOs3NkPW8030m66CLyg7BFxy70Y1OwzqKjJJocvb
        1ekBLxu3+Do/cEggljxcAKoGClI+r9I=
X-Google-Smtp-Source: ABdhPJwIQNAFoZdhZTOMaXkc47F63svH9BZ1f6vrVS+I7UMjMf7Is8LgZiZ6s9EOVXfjqt39GQlkaQ==
X-Received: by 2002:a62:1d07:0:b0:4bf:3782:22e3 with SMTP id d7-20020a621d07000000b004bf378222e3mr36424507pfd.52.1646279637556;
        Wed, 02 Mar 2022 19:53:57 -0800 (PST)
Received: from localhost ([47.251.4.198])
        by smtp.gmail.com with ESMTPSA id k12-20020a056a00168c00b004e15818cda3sm703836pfc.114.2022.03.02.19.53.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Mar 2022 19:53:57 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <jiangshan.ljs@antgroup.com>
Subject: [PATCH V2 0/7] x86/entry: Clean up entry code
Date:   Thu,  3 Mar 2022 11:54:27 +0800
Message-Id: <20220303035434.20471-1-jiangshanlai@gmail.com>
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

The patches are the version 2 of
https://lore.kernel.org/lkml/20211208110833.65366-1-jiangshanlai@gmail.com/
which are picked from the patchset
https://lore.kernel.org/lkml/20211126101209.8613-1-jiangshanlai@gmail.com/
which coverts ASM code to C code.  These patches are prepared for that
purpose.  But this patchset has it own value: it simplifies the stack
switch, avoids leaving the old stack inside a function call, and
separates XENpv code with native code without adding new code.

Changed from V1
	Squash cleanup patches converting SWAPGS to swapgs into one patch

	Use my official email address (Ant Group).  The work is backed
	by my company and I was incorrectly misunderstood that
	XXX@linux.alibaba.com is the only portal for opensource work
	in the corporate group.

PS:  I think the work is ready to be queued and I'm deeply sorry not to
resend it for more reviews for the last two months because I have been
obsessed with a boardgame and my brain power was drained.

Lai Jiangshan (7):
  x86/traps: Move pt_regs only in fixup_bad_iret()
  x86/entry: Switch the stack after error_entry() returns
  x86/entry: move PUSH_AND_CLEAR_REGS out of error_entry
  x86/entry: Move cld to the start of idtentry
  x86/entry: Don't call error_entry for XENPV
  x86/entry: Use idtentry macro for entry_INT80_compat
  x86/entry: Convert SWAPGS to swapgs and remove the definition of
    SWAPGS

 arch/x86/entry/entry_64.S        |  65 +++++++++++++------
 arch/x86/entry/entry_64_compat.S | 104 +------------------------------
 arch/x86/include/asm/idtentry.h  |  47 ++++++++++++++
 arch/x86/include/asm/irqflags.h  |   2 -
 arch/x86/include/asm/proto.h     |   4 --
 arch/x86/include/asm/traps.h     |   2 +-
 arch/x86/kernel/traps.c          |  17 ++---
 7 files changed, 102 insertions(+), 139 deletions(-)

-- 
2.19.1.6.gb485710b

