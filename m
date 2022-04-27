Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 531DC5121E2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbiD0TBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 15:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231716AbiD0TBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 15:01:23 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F24459AE77
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 11:47:23 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2f825f8c944so24256817b3.15
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 11:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:cc;
        bh=cjRVYKae2NiccbEodN7hWWhpE8I2abxiXPIpZLMEvCU=;
        b=QYrapOUYASQ9wPScJ0plESi+FWuJgR3FWaISnPDEs6022eaR3vV/BPqwUR64TdyM+l
         Wok4jTZejpYCOeFYt2K4Q7995CZTXK6AfZT5+erp8eD13WZ1cOtbQF+ub5TmTdkfE10f
         ejzEp4XbKTmkExH/AsNZ6U2v3rpV393XABjlNHOZgfwoYRebwFUnQxrYBDPQR2R4RNl4
         7t9/68MkDJ/aZnHETqiwGR5Bq9aBcXVcIsMrkulvfgWJcVmPBdhyw9bnLzgDP78TQV1v
         j4+qZqHSOufl+3FNjWGD4rCP+FnNVxfgvqFg2GfS3GKX3eJ2UXeBNW6EL8bVS2ETLPsR
         XiAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:cc;
        bh=cjRVYKae2NiccbEodN7hWWhpE8I2abxiXPIpZLMEvCU=;
        b=Enp0pys6tGQnd8xUOv/WwJRs70VP/sIq6boFQxHKZ9cSYuvbRpNzeIhVzWqTQg96sj
         bGWrDB2jX98xw9lLUqyYnXJ0OSAbT+V3abEZFKaIeTk7NavBuubhFNvTeDChrK7lgE6z
         l7LraM7dYuC7oVF2I+hC6sLEr/931EOnzg0HXs696SYnXSMG4MJU3e7iczwaB5iLuGJ0
         wqu+w/QVroYoYD+KVY1y+Si2Z9m0T/PD9LPMgu/3kFyNpmkyz/LHjnc4vWN2udJMYBU9
         Y963doR4ggSNxhAWi7qh1MkIYKQkUZW7Kg3pbjBCthSfXAEzy+W4ecx2ctUoFsHxYp8A
         H6QA==
X-Gm-Message-State: AOAM5337QUgd6g59CZj+qnMHCg1zrswDI9YnaITErFMga+Klgz43wT5I
        LafMe4vfD5yN0hrnDnMuA6rWJ4Y9+Pu94EZcFg==
X-Google-Smtp-Source: ABdhPJxoGqPPyZOA0Xpsq9Ey5x+bCBFLO5TtbxyriEJN+TpNdW/YWUQEtF/V42SaDoZ/QV2QlLorCHfiJ3QQObW7wA==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:16ec:6da0:8cc5:5f24])
 (user=kaleshsingh job=sendgmr) by 2002:a25:a148:0:b0:641:d14b:ddd3 with SMTP
 id z66-20020a25a148000000b00641d14bddd3mr28186851ybh.402.1651085243194; Wed,
 27 Apr 2022 11:47:23 -0700 (PDT)
Date:   Wed, 27 Apr 2022 11:46:55 -0700
Message-Id: <20220427184716.1949239-1-kaleshsingh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
Subject: [PATCH 0/4] KVM nVHE Hypervisor stack unwinder
From:   Kalesh Singh <kaleshsingh@google.com>
Cc:     mark.rutland@arm.com, will@kernel.org, maz@kernel.org,
        qperret@google.com, tabba@google.com, surenb@google.com,
        kernel-team@android.com, Kalesh Singh <kaleshsingh@google.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>,
        Andrew Jones <drjones@redhat.com>,
        Keir Fraser <keirf@google.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MISSING_HEADERS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This series is based on arm64 for-next/core and is also dependent
on the series at [1].

A previous version of hypervisor stack unwinding was included
in the series at [2].

This new version of the unwinder splits the unwinding and dumping
of the stack between the hypervisor and host:
  - The hyperviosr unwinds its stack and dumps the address entries
    into a page shared with the host.
  - The host then symnolizes and prints the hyp stacktrace from
    the shared page.

The new approach doesn't depend on CONFIG_NVHE_EL2_DEBUG,
and allows dumping hyp stacktraces in prodcution environments
(!CONFIG_NVHE_EL2_DEBUG).

arm64/kernel/stacktrace.c is compiled twice: stacktrace.o for the
host kernel and stacktrace.nvhe.o for the hypervisor: This allows
reusing most of the host unwinding logic in the nVHE hypervisor.

[1] https://lore.kernel.org/r/20220420214317.3303360-1-kaleshsingh@google.com/
[2] https://lore.kernel.org/r/20220314200148.2695206-1-kaleshsingh@google.com/

Thanks,
Kalesh


Kalesh Singh (4):
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
2.36.0.rc2.479.g8af0fa9b8e-goog

