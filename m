Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB074FE94E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 22:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233135AbiDLUIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 16:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232376AbiDLUHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 16:07:24 -0400
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 571EDB43
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 12:59:11 -0700 (PDT)
Received: by mail-wm1-x34a.google.com with SMTP id k16-20020a7bc310000000b0038e6cf00439so1712310wmj.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 12:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:message-id:mime-version:subject:from:cc;
        bh=MENr6JaFQrvHMeFq6sKLlOwf0hec/wgSr+mPRwQN+l0=;
        b=My+M5BYSA+gXTB91tN4X1vERu3Z09Qivgl3WTvb6ePAQkulgyUSvxYka18IjQJ7/t2
         Cq3sU1nQYaJpHFTSlkXVKJ8UUMQ1ubXpUcCQ9kLG6/jA2FVXaNtjfAEeMO8x+8553/Nf
         Ais3vLlINs5YtZRDph09DA+j5IOvETna5R3sGs0kMF3MZFytYhogncyb8g511D/SZFi+
         1wzdybWE20l1obqfnCfyfvIO7Ci9nqbDcij6KIFyIh8gYwxyBOdw6TqFaBkR9yCygOQZ
         5yuy6vQGqNN2MCH7lruIJHLVfjz7iwgs0kNkdc3VejPACXrgG3SpCjWHclk+HHp5nxOc
         fvUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:message-id:mime-version:subject
         :from:cc;
        bh=MENr6JaFQrvHMeFq6sKLlOwf0hec/wgSr+mPRwQN+l0=;
        b=EshjOTT//FOqG+jK4LF0A40MB0TfZe59cFIaov2MhEr4UZVDAkM0p21lHmLktw+eHP
         iVNSh43YC5O6NWlRAc9BiAZ+kD60t/MQbUIqVYepHU2mbL1ofE59p82tOhJTCCG2pn2Z
         EeIdro5OnqAqyuitxVuW8Lp8LMPHnRc5abS7IantjftY4nleKK6OndMYzq1j9eKWYO0h
         UXbc/I3s+b61x1K3A6FVV2voWoRzwEAdltPzRi1wB/c5BUakfRp38V5HKbpULQFvfq+U
         SCMongAOygWoGfLzXzgR4ykivJ//uc+FrT+I4p3JWXbk5xFVcNKFuyaiF0e7Uy1gEtcZ
         FF2w==
X-Gm-Message-State: AOAM531ZLosloYBDpFWL8gaOMDMBDLfNmixScaUa8OeLchIhNR/3vcdo
        xJCMGINeZhA69UP60fCWUDtVYiqIQTbr
X-Google-Smtp-Source: ABdhPJw2Al6hykQfZi1/dlidzpxWGtE3f4gUI8/c4WffSBjE7JfuGSFasTK/dm0mH0/G/0qN1nlYXc81X4cb
X-Received: from zhanwei.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2da8])
 (user=zhanwei job=sendgmr) by 2002:a7b:c5d1:0:b0:37f:a8a3:9e17 with SMTP id
 n17-20020a7bc5d1000000b0037fa8a39e17mr5371013wmk.109.1649793543167; Tue, 12
 Apr 2022 12:59:03 -0700 (PDT)
Reply-To: Wei Zhang <zhanwei@google.com>
Date:   Tue, 12 Apr 2022 19:58:44 +0000
Message-Id: <20220412195846.3692374-1-zhanwei@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.1178.g4f1659d476-goog
Subject: [PATCH 0/2] KVM: x86: Fix incorrect VM-exit profiling
From:   Wei Zhang <zhanwei@google.com>
Cc:     Wei Zhang <zhanwei@google.com>,
        Suleiman Souhlal <suleiman@google.com>,
        Sangwhan Moon <sxm@google.com>, Ingo Molnar <mingo@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
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

The profile=kvm boot option has been useful because it provides a
convenient approach to profile VM exits. However, it's problematic because
the profiling buffer is indexed by (pc - _stext), and a guest's pc minus a
host's _stext doesn't make sense in most cases.

When running another linux kernel in the guest, we could work around the
problem by disabling KASLR in both the host and the guest so they have the
same _stext. However, this is inconvenient and not always possible.

We're looking for a solution to this problem. A straightforward idea is to
pass the guest's _stext to the host so the profiling buffer can be indexed
correctly. This approach is quite brute, as you can see in the prototype
patches.

We had some initial discussions and here is a short summary:
1. The VM-exit profiling is already hacky. It's collecting stats about all
   KVM guests bunched together into a single global buffer without any
   separation.
2. Even if we pass _stext from the guest, there are still a lot of
   limitations: There can be only one running guest, and the size of its
   text region shouldn't exceed the size of the profiling buffer,
   which is (_etext - _stext) in the host.
3. There are other methods for profiling VM exits, but it would be really
   convenient if readprofile just works out of box for KVM profiling.

It would be awesome to hear more thoughts on this. Should we try to fix the
existing VM-exit profiling functionility? Or should we avoid adding more
hacks there? If it should be fixed, what's the preferred way? Thanks in
advance for any suggestions.

Wei Zhang (2):
  KVM: x86: allow guest to send its _stext for kvm profiling
  KVM: x86: illustrative example for sending guest _stext with a
    hypercall

 arch/x86/kernel/setup.c       |  6 ++++++
 arch/x86/kvm/x86.c            | 15 +++++++++++++++
 include/linux/kvm_host.h      |  4 ++++
 include/uapi/linux/kvm_para.h |  1 +
 virt/kvm/Kconfig              |  5 +++++
 5 files changed, 31 insertions(+)

base-commit: 42dcbe7d8bac997eef4c379e61d9121a15ed4e36
-- 
2.35.1.1178.g4f1659d476-goog

