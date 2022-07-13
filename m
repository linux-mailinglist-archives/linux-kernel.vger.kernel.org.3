Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B664572EC1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 09:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbiGMHHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 03:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbiGMHHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 03:07:13 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C9B7BBD3B
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 00:07:12 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id o31-20020a17090a0a2200b001ef7bd037bbso2182114pjo.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 00:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K+tELvoFN/jC1Zp7hb52deJSxuYVi0jGo6aErK5pMA4=;
        b=Pzi+Mbdcj9PJ+icOu1HrIeU69tO2Hs3pb7MmRmLjkvpQ27PTjJSCXoDF5ayPdm/J0j
         asy2BOhK5s9+3EUABIH7e8EO6cMoUEVyfOPBAt6LefF0y9OIN+tS8nBOi/4lqlnwixXx
         vA2/B6CNVN8/e/GMVk3eBcjsF8pSTw1pUAe0WhEprPxV7PpNP1HVXEYWGhrJjnr6xLU7
         OUFQO5P9MHHFHD9W1eEO/tdMTerzYPLzCa+mMXMEVyl2rFNTwJb8Ypj3tXcCS1vGl2wP
         z65+NIa1FIJ5viEfrcj/p/r2niOdM1io0kAZ0CMRKn+r7iMiHKII9qfxUzaEwxoMICgV
         2Alg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K+tELvoFN/jC1Zp7hb52deJSxuYVi0jGo6aErK5pMA4=;
        b=ON3fS7dGHykjrUqDr28rjDGmpj83nUeNih4rLkrahsSWnGENqwQmEV60piOJ5fhryM
         nyW7IA/KafRby+aWLIHNKZ6vdxwcONn17lTAZBt6pwW4u9hGS1XnAUHg/UGpQ8/TFxnh
         I469RpLUHEcx4yHUqJ9lJrwOkSaz1Eqg2UYUbDfgSLrY0pGazH6Pcnt8qlSlisTUPg/l
         yJwSrDN8dXOeoVawOn7Pxj163wi7siq3LVdu/oxZjmdULAcjSahMkMqu4M48bm0n0LQw
         pp+9M6vT646FN/DNonPIhCG6Hux2Rfdg3j1inWiTuw6pwwuOE83Tex0Ntc4nz1H0nXR9
         Lm8w==
X-Gm-Message-State: AJIora/kCXZ+fSaLC7nLRJKFgUJXvOUHNhtaA+c9pm7BwOBs/pcDB2AD
        yPKh6d2/zDLr8HpiqaXy+Ev4ZehVL5w=
X-Google-Smtp-Source: AGRyM1t8oz+4VptoFqjNiFqS+6ET7xp4+JPzyv6eBUts404OD9rKTtS9e915XbVorZ43AafZrwch5Q==
X-Received: by 2002:a17:90a:e008:b0:1ef:831a:1fff with SMTP id u8-20020a17090ae00800b001ef831a1fffmr8455187pjy.221.1657696032041;
        Wed, 13 Jul 2022 00:07:12 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (193-116-203-247.tpgi.com.au. [193.116.203.247])
        by smtp.gmail.com with ESMTPSA id d11-20020a170902cecb00b0016bd5da20casm8099061plg.134.2022.07.13.00.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 00:07:11 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "linux-kernel @ vger . kernel . org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 00/12] locking/qspinlock: simplify code generation
Date:   Wed, 13 Jul 2022 17:06:52 +1000
Message-Id: <20220713070704.308394-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.35.1
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

This accounts for comments from last post. Thanks for the feedback.

Thanks,
Nick

v2:
- Remove BUILD_BUG_ON contradiction
- Add Longman's for pending bit for !paravirt case
- Make queued_spin_lock_mcs_queue __always_inline
- Drop cmpxchg_acquire->trylock patch that changed generated
  code slightly (and had wild indenting).
- Fix dropped acquire memory ordering in pv_wait_node cleanup
  (and renamed it to pv_wait_node_acquire).


Nicholas Piggin (12):
  locking/qspinlock: remove pv_node abstraction
  locking/qspinlock: inline mcs_spinlock functions into qspinlock
  locking/qspinlock: split common mcs queueing code into its own
    function
  locking/qspinlock: move pv lock word helpers into qspinlock.c
  locking/qspinlock: be less clever with the preprocessor
  locking/qspinlock: merge qspinlock_paravirt.h into qspinlock.c
  locking/qspinlock: remove arch qspinlock_paravirt.h includes
  locking/qspinlock: stop renaming queued_spin_lock_slowpath to
    native_queued_spin_lock_slowpath
  locking/qspinlock: rename __pv_init_lock_hash to pv_spinlocks_init
  locking/qspinlock: paravirt use simple trylock in case idx overflows
  locking/qspinlock: separate pv_wait_node from the non-paravirt path
  locking/qspinlock: simplify pv_wait_head_or_lock calling scheme

 arch/alpha/include/asm/Kbuild                 |   1 -
 arch/arc/include/asm/Kbuild                   |   1 -
 arch/arm/include/asm/mcs_spinlock.h           |  24 -
 arch/arm64/include/asm/Kbuild                 |   1 -
 arch/hexagon/include/asm/Kbuild               |   1 -
 arch/ia64/include/asm/Kbuild                  |   1 -
 arch/m68k/include/asm/Kbuild                  |   1 -
 arch/microblaze/include/asm/Kbuild            |   1 -
 arch/mips/include/asm/Kbuild                  |   1 -
 arch/nios2/include/asm/Kbuild                 |   1 -
 arch/parisc/include/asm/Kbuild                |   1 -
 arch/powerpc/include/asm/Kbuild               |   1 -
 arch/powerpc/include/asm/qspinlock.h          |  45 +-
 arch/powerpc/include/asm/qspinlock_paravirt.h |   7 -
 arch/powerpc/include/asm/spinlock.h           |   2 +-
 arch/s390/include/asm/Kbuild                  |   1 -
 arch/sh/include/asm/Kbuild                    |   1 -
 arch/sparc/include/asm/Kbuild                 |   1 -
 arch/um/include/asm/Kbuild                    |   1 -
 arch/x86/hyperv/hv_spinlock.c                 |   2 +-
 arch/x86/include/asm/Kbuild                   |   1 -
 arch/x86/include/asm/qspinlock.h              |  19 +-
 arch/x86/include/asm/qspinlock_paravirt.h     |  72 --
 arch/x86/kernel/kvm.c                         |   2 +-
 arch/x86/kernel/paravirt-spinlocks.c          |  71 ++
 arch/x86/kernel/paravirt.c                    |   2 +-
 arch/x86/xen/spinlock.c                       |   2 +-
 arch/xtensa/include/asm/Kbuild                |   1 -
 include/asm-generic/mcs_spinlock.h            |  13 -
 include/asm-generic/qspinlock.h               |   6 +
 kernel/locking/mcs_spinlock.h                 | 121 ---
 kernel/locking/qspinlock.c                    | 835 ++++++++++++++----
 kernel/locking/qspinlock_paravirt.h           | 562 ------------
 33 files changed, 764 insertions(+), 1038 deletions(-)
 delete mode 100644 arch/arm/include/asm/mcs_spinlock.h
 delete mode 100644 arch/powerpc/include/asm/qspinlock_paravirt.h
 delete mode 100644 arch/x86/include/asm/qspinlock_paravirt.h
 delete mode 100644 include/asm-generic/mcs_spinlock.h
 delete mode 100644 kernel/locking/mcs_spinlock.h
 delete mode 100644 kernel/locking/qspinlock_paravirt.h

-- 
2.35.1

