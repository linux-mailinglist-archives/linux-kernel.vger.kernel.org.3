Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07E5C540415
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 18:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345193AbiFGQvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 12:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344228AbiFGQvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 12:51:17 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D4FF5D37
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 09:51:16 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-30c87716af6so152164577b3.22
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 09:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=o0iZsHQ0w1pzGlhdlimhaec4r2w9hzpwWG2GpMn3EMQ=;
        b=OmbO1I14NanBrKt0FdpC2NTCDJpwz34ZNg+udo7ufulw4wzH8+6qdwXmzYiRud8dgl
         H4fGd9ztV7KGrTzVhGt0BfeRhSMqmrEzAXKdjHlXNA8QMGX11NdyFs69PTFZuos98kzq
         UuMzL9aKp3DDEeBnd6ry89HY9wlen6rOWsSYi6ecHKyigI+ITpBGik/BsMoJ4zA2uH2Q
         ZWvpcg89RtVbZ//Dr6NHFj6hkIkOkYWGgZQHoVsMXwslo48H2dhOd6ACZD+Z5TwKkWUh
         fPKaPVoeSC5DDDBZAFB2wHobe264YygSL7/nPsaMEx50lZwXm9Ab0CyQLzyMVVSSqC+7
         sHFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=o0iZsHQ0w1pzGlhdlimhaec4r2w9hzpwWG2GpMn3EMQ=;
        b=Uo1mcuiIPGSBZYgyrayzjXeX/sT0BsH2UCpBuIneQpTMcQxs2Iny3jSA2CIdNhyyLj
         KT0dE2/H+XHTkO9PSpRH1hPozaDABOhBGESklNlJjlvdiGo9l0g4Oc7LE8ydP6kydTqk
         fQ3fnUznu7bjFDWEnxK8BcQt60Nn8ti4SZBrMdWESScUoAyei0PcDmwL+pU5tHjmBAA9
         mIRANbDRgZxbXq+tlbsxkx5rpfg9YebDqe6a4aCRthEHesFdallFmPf/aeu94FPIgZI+
         VtvZhyh5l/S+5YOwqpwi1V0c9uQiQIaVkySzF32AZuujw8atcxSx4kkSZCtxCG8pjYj/
         2mcA==
X-Gm-Message-State: AOAM531oqPbLcz2lIbZM7LaQxxZIn3L8r6N5HZzvh8d6t+CECeUM/XzD
        tGCDO/FzidTFBHU8YQoNrgckd2LxAogUcuquVg==
X-Google-Smtp-Source: ABdhPJysQZgWCIBcQcZgbAPodFjVXMmm6FLeZKxkdgidkgdm9q/dWOw/xW0kfcLA9ACqPsqnVIIHO6siNslKHvzWdA==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:7091:8518:ec1e:93dc])
 (user=kaleshsingh job=sendgmr) by 2002:a81:1615:0:b0:30c:245e:71ff with SMTP
 id 21-20020a811615000000b0030c245e71ffmr33123428yww.406.1654620676147; Tue,
 07 Jun 2022 09:51:16 -0700 (PDT)
Date:   Tue,  7 Jun 2022 09:50:42 -0700
Message-Id: <20220607165105.639716-1-kaleshsingh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: [PATCH v3 0/5] KVM nVHE Hypervisor stack unwinder
From:   Kalesh Singh <kaleshsingh@google.com>
To:     mark.rutland@arm.com, broonie@kernel.org, maz@kernel.org
Cc:     will@kernel.org, qperret@google.com, tabba@google.com,
        surenb@google.com, tjmercier@google.com, kernel-team@android.com,
        Kalesh Singh <kaleshsingh@google.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Jones <drjones@redhat.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Keir Fraser <keirf@google.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Oliver Upton <oupton@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This v3 of the nVHE hypervisor stack unwinder. The previous versions were
posted at:
v2: https://lore.kernel.org/r/20220502191222.4192768-1-kaleshsingh@google.com/
v1: https://lore.kernel.org/r/20220427184716.1949239-1-kaleshsingh@google.com/

The version is rebased on 5.19-rc1 which resolves the previously unmerged
dependencies, and adds some reviewed tags from Mark Brown.

The cover letter are copied below for convenience.

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


base-commit: f2906aa863381afb0015a9eb7fefad885d4e5a56
-- 
2.36.1.255.ge46751e96f-goog

