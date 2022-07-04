Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F09B5658C6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 16:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234028AbiGDOid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 10:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231871AbiGDOib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 10:38:31 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE452AD9
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 07:38:29 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id j1-20020a17090aeb0100b001ef777a7befso3234643pjz.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 07:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=POnyZivHE4qmamrFmTC5NDAfkP0Thqs66b2pTo/1y8c=;
        b=RpUKhSLiHckZ2zSv5Nd3lPkaK3srr8C4Bm2bou9sd9lLmYfrcdTk7tEDy9BId1i0Vb
         BCf1pIvyUXgHkk1D2uUoWhFb2AEQMblrO5P0IxVIgAE8I87+u9ujvW5k71sayV4dTMLf
         DNZTwLmIsH3JOxMrnEry/wry6UoTjz8Xe2pbhv9ChIN2GddV+jYSCVWW1ecYym66MpF0
         xCqWm2wDqNGWeAA8jhV9WmUVLLDWkqg+l4X1plfVWORm7NBhnXAZsOLs2NZJmIE2ZzJi
         vgpBQGXZMuFrV4388igO26oo+gb0UHIo2e4AuW9mdVmnYhRV79pkQqhkEcw2KZqVT9x9
         LK+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=POnyZivHE4qmamrFmTC5NDAfkP0Thqs66b2pTo/1y8c=;
        b=WCTSa3bCchPfZKk8cf5ni12ByQf8E0/jab2+WeEALaQLql+Qt8GBkwGZY6nYaxFLub
         QMXakN6DyvtY+f80cM3KyjCgxISUWgm8dnQXQoOtOjby9eDFz0/rpA4NkLd12kRn4FcG
         /cwjp3glwUl37ITL0pI2Ujli6+KG/rcz2eCxvHnsXONl4ladexJVguXmuiVvtv7Q0RkI
         IXRV4nUp1WccX8XLyr6CSfzLoktntTPGCwwkK8igiPfvN7eMWLgIPLZA5Qd+JE6v7ng6
         88yxJ+apqUqcmLY5Vduw9cigOB5qbxGI2b5elv79LWFfhrleM20ELUmSpWyF47IAGB1f
         WD2w==
X-Gm-Message-State: AJIora/MUwj3DWIU/nHkgYXFDRmj2oUs8ydtjmdi2TuuFnwadjmc5vmz
        OX+XQnKYaQUws2tkAf0wMwg=
X-Google-Smtp-Source: AGRyM1u41wRm1xkfknh2J1M64iDGvb4HXrKJQvDoWHQnc6WP3zx0/K1yx45fgFZIGv7XD2QTRKGhMQ==
X-Received: by 2002:a17:90b:3b84:b0:1ec:e86c:3c34 with SMTP id pc4-20020a17090b3b8400b001ece86c3c34mr34988039pjb.174.1656945508825;
        Mon, 04 Jul 2022 07:38:28 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com ([203.221.247.188])
        by smtp.gmail.com with ESMTPSA id u13-20020a63454d000000b0040d2224ae04sm20534365pgk.76.2022.07.04.07.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 07:38:28 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 00/13] locking/qspinlock: simplify code generation
Date:   Tue,  5 Jul 2022 00:38:07 +1000
Message-Id: <20220704143820.3071004-1-npiggin@gmail.com>
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

Hi,

Been recently looking a bit closer at queued spinlock code, and
found it's a little tricky to follow especially the pv generation.
This series tries to improve the situation. It's not well tested
outside powerpc, but it's really the x86 pv code that is the
other major complexity that should need some review and testing.
Opinions?

Thanks,
Nick

Nicholas Piggin (13):
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
  locking/qspinlock: Use queued_spin_trylock in
    pv_hybrid_queued_unfair_trylock
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
 kernel/locking/qspinlock.c                    | 834 ++++++++++++++----
 kernel/locking/qspinlock_paravirt.h           | 562 ------------
 33 files changed, 764 insertions(+), 1037 deletions(-)
 delete mode 100644 arch/arm/include/asm/mcs_spinlock.h
 delete mode 100644 arch/powerpc/include/asm/qspinlock_paravirt.h
 delete mode 100644 arch/x86/include/asm/qspinlock_paravirt.h
 delete mode 100644 include/asm-generic/mcs_spinlock.h
 delete mode 100644 kernel/locking/mcs_spinlock.h
 delete mode 100644 kernel/locking/qspinlock_paravirt.h

-- 
2.35.1

