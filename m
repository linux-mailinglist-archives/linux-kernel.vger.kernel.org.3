Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 705FD517733
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 21:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358673AbiEBTQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 15:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232600AbiEBTQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 15:16:00 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08EA8B7F
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 12:12:31 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id a17-20020a258051000000b00648703d0c56so13793193ybn.22
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 12:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:cc;
        bh=uV3AMgXfaKdpLzrKDgt2Pftc7Y3s541BqTPcU4XvOsc=;
        b=f/f3SDrAnawn000xkOkHhrYZWDBT/8Cfw436AFLd7ZGxWqX2AndGj6iIOi9pFxg9Lu
         c33w4E0W3pJafd0pLQ7kM+38rflKqPdINJwxPvlkEcM9yPSifoU2cXy2eZQgwskzblUc
         ZHWFN5SCm40eX/3Ntni/B2HAKTUKBbTBwHvSx3ykdEb1t9AbkLnxKyabLTk4rSAUbfFz
         GpCR3RXHSIMIryrvEiju/VgLVKQQkM61eujNeTaggZt7ybDKDRRkndV5NPsx3+Cair4K
         fPXJuHxCkPpbMqLH8CProCushBiyS/Ic8u4Kne6k3YlaVo4L97+BQUR11iFgCmGvubgH
         je1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:cc;
        bh=uV3AMgXfaKdpLzrKDgt2Pftc7Y3s541BqTPcU4XvOsc=;
        b=n4rmBdT4sTAEC4VWDEeCQ7bOKFcY23HBEQO7nR9JWk+WlK71y0v3FZUEt/MXcGPYUV
         VvPW56ZLvDY8t3w1x2o0sqBQQm23Cbd62NxnReAOTHqxCBfbUXLOH63M4USD5klGblgf
         1xDy0p4/Q5W6VsmzJd6eFEGU6q3YbHPQKQgSue3aKL3VFojSD/X07ESAdTF0tHYmDXKp
         jh4GtXp3d/jTeA/AIDiXPrUQ6zTus4zerK9G1xkTHTNCi2EpzfFJxxDJIyayMaSq69FV
         OGAUZlBR4TTaQW9XPwhmM3vPWKTd08FXtCFrqI27DD23Y9Rcb/XD8qbbSskKIWu0WWqE
         6ktw==
X-Gm-Message-State: AOAM533uBzUCMOvuko+1FC4v1RRwuYZHs3evWd1PSFSC9uejMkNKM4Am
        KvQugjhlctnWJD9NLEj9GJSs9nVq9ZDOzGsGZg==
X-Google-Smtp-Source: ABdhPJw3anR5PV2AbjH4cWd8FKWezlG379Lha/KDbqGyzNif8TIgOLLb8qPZNat5PHuda44OzO6PJQ55Yf4E13DL8Q==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:55c:7548:7073:c14f])
 (user=kaleshsingh job=sendgmr) by 2002:a5b:b4a:0:b0:649:15ed:1b87 with SMTP
 id b10-20020a5b0b4a000000b0064915ed1b87mr10856706ybr.374.1651518750235; Mon,
 02 May 2022 12:12:30 -0700 (PDT)
Date:   Mon,  2 May 2022 12:12:00 -0700
Message-Id: <20220502191222.4192768-1-kaleshsingh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [PATCH v2 0/5] KVM nVHE Hypervisor stack unwinder
From:   Kalesh Singh <kaleshsingh@google.com>
Cc:     mark.rutland@arm.com, broonie@kernel.org, will@kernel.org,
        maz@kernel.org, qperret@google.com, tabba@google.com,
        surenb@google.com, kernel-team@android.com,
        Kalesh Singh <kaleshsingh@google.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>,
        Andrew Jones <drjones@redhat.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Keir Fraser <keirf@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MISSING_HEADERS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This v2 of the nVHE hypervisor stack unwinder. The previous version was
posted at:
v1: https://lore.kernel.org/lkml/20220427184716.1949239-1-kaleshsingh@google.com/

The series is based on arm64 for-next/core and is also dependent on
kvm-arm64/hyp-stack-guard [1].

The main changes in this version is splitting some patches into more
incremental changes, per Mark Brown

The relevant parts of the previous cover letter are copied below for
convenience.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git/log/?h=kvm-arm64/hyp-stack-guard

Thanks,
Kalesh

-------

This new version of the unwinder splits the unwinding and dumping
of the stack between the hypervisor and host:
  - The hypervisor unwinds its stack and dumps the address entries
    into a page shared with the host.
  - The host then symnolizes and prints the hyp stacktrace from
    the shared page.

The new approach doesn't depend on CONFIG_NVHE_EL2_DEBUG,
and allows dumping hyp stacktraces in prodcution environments
(!CONFIG_NVHE_EL2_DEBUG).

arm64/kernel/stacktrace.c is compiled twice: stacktrace.o for the
host kernel and stacktrace.nvhe.o for the hypervisor. This allows
reusing most of the host unwinding logic in the nVHE hypervisor.


Kalesh Singh (5):
  KVM: arm64: Factor out common stack unwinding logic
  KVM: arm64: Compile stacktrace.nvhe.o
  KVM: arm64: Add hypervisor overflow stack
  KVM: arm64: Allocate shared stacktrace pages
  KVM: arm64: Unwind and dump nVHE hypervisor stacktrace

 arch/arm64/include/asm/kvm_asm.h    |   1 +
 arch/arm64/include/asm/stacktrace.h |  58 +++++++++--
 arch/arm64/kernel/stacktrace.c      | 151 +++++++++++++++++++++++-----
 arch/arm64/kvm/arm.c                |  34 +++++++
 arch/arm64/kvm/handle_exit.c        |   4 +
 arch/arm64/kvm/hyp/nvhe/Makefile    |   3 +-
 arch/arm64/kvm/hyp/nvhe/host.S      |   9 +-
 arch/arm64/kvm/hyp/nvhe/setup.c     |  11 ++
 arch/arm64/kvm/hyp/nvhe/switch.c    |   4 +
 9 files changed, 231 insertions(+), 44 deletions(-)

-- 
2.36.0.464.gb9c8b46e94-goog

