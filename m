Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2096F53F05A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 22:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232356AbiFFUnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 16:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234343AbiFFUmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 16:42:24 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1B3AED738
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 13:38:47 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-f2bb84f9edso20573712fac.10
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 13:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=12KHJFePHvtELaFCoDutiatufKE2J0aYO+nHGRn0w7U=;
        b=XFqePO7P5W4gGPYSV2JFBsih67jDxFl6rHWGV7Gjp+gQSTUAaeLmHW0G8E04fPOr6k
         SRnRh8ggJHCbEMW0p4opnochH/ZK7by3lDcM8st+sYazL1bQfs9tcY7m5PvCyQ57QxZu
         ORgDX7mgRXbUi36JeZr1Ea2XfDKMSO8WuQGgdargTYM9vwiqxdNNNC7lfbVQN9LqaKoj
         vcCVXXFc42VZehyMEEoR25Dwf9HBwwvEjV7M8S9a8+D5Y7wW3IYI4HDlLOPbkhFqLJkb
         MxHSEam3aQnWqVAcLo+0MqjWxnaIJafSEeCX1v+TpKHT88o4cjB8Uk03veBbFE7O/sN9
         YYrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=12KHJFePHvtELaFCoDutiatufKE2J0aYO+nHGRn0w7U=;
        b=MkxDwASH29LMkf6KTtztC6hQ8kZiP3MvGrX4JE4+xV9uWVkjDhkWmSsme9B/PAVzZa
         lps+P2yaUBc/mbwTbmIoWdEu6aaCM2OaWPVmuC10y9g5g+J1ppZcCytfkNXgPlqROZsz
         fbYRAmnTRTzM1BDd1FS2O3pdcUMUARTPa0TxM5bcSWpzg2zyJ6axN9WPEJpwZT0+tGJf
         p1CzdZ2q/RpYdsOPjuewfehd9xD0AJCTBppbOmaaPus7q0NMsPYsHxlxoRm1uLbBrgIE
         8XCTdzTNeFDQAcPC3arp/6znucZK0AilQbeX3EaUcrwxLWOQeHGq48Hju8xJpZCymKqR
         W0TQ==
X-Gm-Message-State: AOAM532ZuKVdWuwWcKw+CT14lxceJX/5Rqe7wp9P9B7Ng9b8Gn26s4mZ
        eSVJzlaCerE04deihJmrQ0FR1Cm2zA==
X-Google-Smtp-Source: ABdhPJyO6fz1ThOKgBZsK8EYb+odK170hwxKGDuy0N53o3rwBvDNOYuey19adH36SsBVJmEThUqoIg==
X-Received: by 2002:a05:6870:c88a:b0:f2:8d92:318a with SMTP id er10-20020a056870c88a00b000f28d92318amr14635466oab.281.1654547926892;
        Mon, 06 Jun 2022 13:38:46 -0700 (PDT)
Received: from citadel.. (174-084-153-250.res.spectrum.com. [174.84.153.250])
        by smtp.gmail.com with ESMTPSA id j22-20020a056808035600b0032e3cca8561sm4327188oie.21.2022.06.06.13.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 13:38:46 -0700 (PDT)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH 0/8] x86 signal code cleanups
Date:   Mon,  6 Jun 2022 16:37:54 -0400
Message-Id: <20220606203802.158958-1-brgerst@gmail.com>
X-Mailer: git-send-email 2.35.3
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

The 32-bit signal code has significant differences from 64-bit, and
those are duplicated for native and compat modes.  This patch series
merges the 32-bit code into one file, and does some general cleanups
in the x86 signal code.  There should be no functional changes.

Brian Gerst (8):
  x86/signal: Remove sig parameter from frame setup functions
  x86/signal: Remove sigset_t parameter from frame setup functions
  signal/compat: Remove compat_sigset_t override
  x86: Remove __USER32_DS
  x86/signal: Merge get_sigframe()
  x86/signal: Add ABI prefixes to frame setup functions
  x86/signal/32: Merge native and compat 32-bit signal code
  x86/signal/64: Move 64-bit signal code to its own file

 arch/x86/entry/entry_64_compat.S              |   4 +-
 arch/x86/ia32/Makefile                        |   2 -
 arch/x86/include/asm/elf.h                    |   4 -
 arch/x86/include/asm/fpu/signal.h             |   7 -
 arch/x86/include/asm/segment.h                |   2 +-
 arch/x86/include/asm/sighandling.h            |   9 +
 arch/x86/include/asm/signal.h                 |   5 -
 arch/x86/kernel/Makefile                      |   4 +-
 arch/x86/kernel/signal.c                      | 654 +-----------------
 .../ia32_signal.c => kernel/signal_32.c}      | 117 ++--
 arch/x86/kernel/signal_64.c                   | 383 ++++++++++
 arch/x86/xen/xen-asm.S                        |   8 +-
 include/linux/compat.h                        |   2 -
 include/linux/syscalls.h                      |   2 +
 14 files changed, 493 insertions(+), 710 deletions(-)
 rename arch/x86/{ia32/ia32_signal.c => kernel/signal_32.c} (82%)
 create mode 100644 arch/x86/kernel/signal_64.c

-- 
2.35.3

