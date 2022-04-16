Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C98D2503315
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 07:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbiDPDp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 23:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbiDPDp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 23:45:26 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E098A9948
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 20:42:55 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id n2-20020a170903404200b00158db7879ddso1514791pla.13
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 20:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:message-id:mime-version:subject:from:to:cc;
        bh=8gqRG0zSL+s/MwLzwmAZ7evCIrSOqpXierRC2ea+1Y0=;
        b=Qx/ne/Hp6I4PuAZbjON2odwjYxsJ14MHHLmDGeflAHGVykHvRh3K+GQLA4UBc8Od6v
         2uILtDy1dxIxe0biG23oiPXWA/r8HosWz6u3of0TAcKIWi/9NcsR1zUDWkFsWgVDOSnO
         7/1IiCzLw4c39fagffM3TMMFGkaTbQngkGvSJuPs1AXaHIjIx3NJimulWSFTTdWME7dw
         xKovNG3X7JUvQsRqd1ZidNrj62XIeplf16YqovY2G3+0gIZp5x7AsahN2tO6XoioagxY
         g6wdyl/TMiIEF7h0jg3V68Ei0/UhNur/mzgsyU4suUamZtxusxfCFvWR+R7/gTSbH68t
         MB3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:message-id:mime-version:subject
         :from:to:cc;
        bh=8gqRG0zSL+s/MwLzwmAZ7evCIrSOqpXierRC2ea+1Y0=;
        b=ZuH5NlMFGym6OdPuk6ws9qGXLXhUQA0qC9iPCsAJT2m2GDrtG7un6Xo0Fy1NKcWd/j
         IREzuEBHVfMTwjlCetFLIDYC02njBEreQ/ibwSbTmkzZai7LjftWr7YgmjEnb27Lskvv
         X6jfcOcIxWn6337QOX0IR1a7lymn9nBwxf2TYwc/Mj9tov+pB+UHFzcspI5i2wb3Dbp6
         1WZQX01oV3q/g7Tl7kBijWUlTYVkA5RhK7zGCuksbRcn3OpJch2KbUu/FsnQQtP5A2vi
         JINy/ziTUI85nSLPfwyEzqC3+MBLvNCU7bRbOfET1FNycgjg7mz77zmbRsswcQlPm5e/
         96yg==
X-Gm-Message-State: AOAM531AH5LUf5uLE8xwxXn2n9fdXlRfXwrwZhv1pHIUYgxjJmk/e811
        pJR9HwDsNrfTEAGV5hHRFLo8AChhnhU=
X-Google-Smtp-Source: ABdhPJw3qyK/1SGPtAQqaNm3lDkgNgcqt6njwj+5mB1ILzdNhEDS53UF4nqOQi5OEC44npQ3nVZ5IVPSUhc=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:902:8644:b0:153:9f01:2090 with SMTP id
 y4-20020a170902864400b001539f012090mr1918513plt.101.1650080574945; Fri, 15
 Apr 2022 20:42:54 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Sat, 16 Apr 2022 03:42:45 +0000
Message-Id: <20220416034249.2609491-1-seanjc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.rc0.470.gd361397f0d-goog
Subject: [PATCH 0/4] KVM: x86: APICv fixes
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Gaoning Pan <pgn@zju.edu.cn>,
        Yongkang Jia <kangel@zju.edu.cn>,
        Maxim Levitsky <mlevitsk@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 1 is brown paper bag fix for a copy+paste bug (thankfully from this
cycle).

Patch 2 fixes a nVMX + APICv bug where KVM essentially corrupts vmcs02 if
an APICv update arrives while L2 is running.  Found when testing a slight
variation of patch 3.

Patch 3 fixes a race where an APICv update that occurs while a vCPU is
being created will fail to notify that vCPU due it not yet being visible
to the updater.

Patch 4 is a minor optimization/cleanup found by inspection when digging
into everything else.

Sean Christopherson (4):
  KVM: x86: Tag APICv DISABLE inhibit, not ABSENT, if APICv is disabled
  KVM: nVMX: Defer APICv updates while L2 is active until L1 is active
  KVM: x86: Pend KVM_REQ_APICV_UPDATE during vCPU creation to fix a race
  KVM: x86: Skip KVM_GUESTDBG_BLOCKIRQ APICv update if APICv is disabled

 arch/x86/kvm/vmx/nested.c |  5 +++++
 arch/x86/kvm/vmx/vmx.c    |  5 +++++
 arch/x86/kvm/vmx/vmx.h    |  1 +
 arch/x86/kvm/x86.c        | 20 ++++++++++++++++++--
 4 files changed, 29 insertions(+), 2 deletions(-)


base-commit: 150866cd0ec871c765181d145aa0912628289c8a
-- 
2.36.0.rc0.470.gd361397f0d-goog

