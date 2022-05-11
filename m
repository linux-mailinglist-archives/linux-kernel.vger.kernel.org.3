Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 813BE522D43
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 09:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242917AbiEKH07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 03:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiEKH05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 03:26:57 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F0493AA7E
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 00:26:56 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id i17so1037563pla.10
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 00:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vJopSBEDjKmChLlyIXRU1jpkvMa7YXsWoRZ5f09Wqgs=;
        b=BmaN9GNc9aSn02JO6dx7XlD1djznE79I23XgMI4E4HiqF/SVMCvoYSdpoHn+g6684J
         ocQeV3PRbDp/y7BImUNn3brLDNHaStenJ4WslvSrI3tlV9gDsSrWjEpwHkwXuw0lWb44
         VXLtcg6w+5l2Ho1rgiIhSEdnk5Uu79QiXtqVd7I5PWjL3spGjA5PSF7/1FF0RFNgq0yV
         NrlCUajA5Uggz/Pih+UIV+g+h+u8e565n8H4XyrW6e4Ha8bxNTHDzQB+Dr9La1vkeQDa
         cQCkIrsCd07mK7M8o/k/m82FQJssIIJBD7ok4/say7IeHhYtOq77x41XsHYYOFQB3Uvm
         e/rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vJopSBEDjKmChLlyIXRU1jpkvMa7YXsWoRZ5f09Wqgs=;
        b=0JgNPNE/lFGt0uzzUF5Qge6kBlVDW3TqtITcyJWV1Xp1v46xJ+KCPjL25vBLQGcJAW
         dSKW7ny33TY2vUBL12Fflm6Azja8kuPyZR+y8UjhQOUz5cv/5l91MXXj9+4FpPmlKdtH
         4LymZFXlUzgUTM3xDslCWEQSIiMCIi+aDMoaSx2HHpIrcu+VC0+uQSiGttGh6Pu/7nt0
         kzukM2Ld2mNVrh1HXbu3kN4692vOghBEzKeAbL6EgsEDaxxoWKPoIp6rCOsLvW7EavOo
         7qxfnMhapDJx+y5az/PN8yhgpt1oWE9ApoVcrVGKciRR7jdiNWTTy5xCOTe8cyXpBGye
         zSew==
X-Gm-Message-State: AOAM532SjCofGu89fU0bwM/B/F6yL0SicUXcZiNKFJk8EyQeKe4K/BVf
        DwTvcz6QMMPWqQ48kPVnS4NOrBnyStY=
X-Google-Smtp-Source: ABdhPJwrabh71KEFQ9sODAMLDTrJik/AwHqT+lsCwwzC9p5JcC2Zb0ZpOPp8/85Jel78kBqnFPKswQ==
X-Received: by 2002:a17:90a:8b91:b0:1be:db25:eecd with SMTP id z17-20020a17090a8b9100b001bedb25eecdmr3908111pjn.10.1652254015351;
        Wed, 11 May 2022 00:26:55 -0700 (PDT)
Received: from localhost ([47.251.4.198])
        by smtp.gmail.com with ESMTPSA id 2-20020a170902c10200b0015e8d4eb2aasm937874pli.244.2022.05.11.00.26.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 May 2022 00:26:55 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>
Subject: [PATCH 0/7] x86/entry: Convert error_entry() to C code
Date:   Wed, 11 May 2022 15:27:40 +0800
Message-Id: <20220511072747.3960-1-jiangshanlai@gmail.com>
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

Add some C equivalent functions of the ASM macros and implement the whole
error_entry() as C code.

The patches are picked from the huge patchset
https://lore.kernel.org/lkml/20211126101209.8613-1-jiangshanlai@gmail.com/
which converts a large chunk of ASM code to C code.

The C version generally has better readability and easier to be
updated/improved.

This smaller patchset converts error_entry() only.
The equivalent ASM macros are not removed because they are still used by
the IST exceptions.

Changed from the old huge patchset:
	squash some patches

Lai Jiangshan (7):
  x86/entry: Introduce __entry_text for entry code written in C
  x86/entry: Move PTI_USER_* to arch/x86/include/asm/processor-flags.h
  x86: Mark __native_read_cr3() & native_write_cr3() as __always_inline
  x86/entry: Add arch/x86/entry/entry64.c for C entry code
  x86/entry: Add the C verion of SWITCH_TO_KERNEL_CR3 as
    switch_to_kernel_cr3()
  x86/traps: Add fence_swapgs_{user,kernel}_entry() and
    user_entry_swapgs_and_fence()
  x86/entry: Implement the whole error_entry() as C code

 arch/x86/entry/Makefile                |   3 +-
 arch/x86/entry/calling.h               |  10 --
 arch/x86/entry/entry64.c               | 137 +++++++++++++++++++++++++
 arch/x86/entry/entry_64.S              |  85 +--------------
 arch/x86/include/asm/idtentry.h        |   3 +
 arch/x86/include/asm/pgtable.h         |  23 +----
 arch/x86/include/asm/processor-flags.h |  15 +++
 arch/x86/include/asm/proto.h           |   1 +
 arch/x86/include/asm/special_insns.h   |   4 +-
 arch/x86/include/asm/traps.h           |   1 +
 arch/x86/kernel/traps.c                |   2 -
 include/linux/compiler_types.h         |   8 +-
 12 files changed, 172 insertions(+), 120 deletions(-)
 create mode 100644 arch/x86/entry/entry64.c

-- 
2.19.1.6.gb485710b

