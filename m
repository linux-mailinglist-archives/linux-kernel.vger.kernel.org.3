Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD3164FC657
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 23:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350026AbiDKVM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 17:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbiDKVMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 17:12:54 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC9F186E7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 14:10:37 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id w187-20020a6282c4000000b00505dfdb4613so509719pfd.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 14:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=7qBaTJN2H+g/K/DS2lTxTRvLIX27mizCmUOglWLHolA=;
        b=JW7DNpPBC9cjt7/GIl6CWQZ2uG8WI7MOXojylaEdw2qWgK0g5u4UIfErnd/i3N5ZCx
         xiEIgP8+nHN0zVYQWKhIRObeLpq4UNPEWen8c8mUwCZpVkW0rAi1TMDC3qOLePsWiauB
         oCk/HS3Oil1MmU98re9HIP0zaDF5lEa+xIRBdCCEytjX1tEjbAX1H3mLFTShBiG1QQ1v
         2NmeHng8cWZtPsqLwdAojX/pKXPy1ikWLYL0W/3utB9JmNylFruKyIUvpqXVYpglaTIt
         gORD3GgvVW4YOnWPOugdSdCUXgOL89lxkqgBPvpN9+SzCMGLl1lRkN9VkQQC6p2z2IZ/
         3zPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=7qBaTJN2H+g/K/DS2lTxTRvLIX27mizCmUOglWLHolA=;
        b=OqAR711SzkMTjkov4fSn9/nGqX2rEX07PCPPKBEgexYeZo8Hv9FCPx6ytfCuO9wl7O
         QabEpOSv8/M8G/89gaIM7ZhR0Jd3VG0m9AFhVrpl3iX3ESotW5j6r6Jn+Fyi8K39HehC
         BaskFvk047HntCIDV0S/UfR7dXyMs5vSPpq4gda5yhIxeV2VYO0AROmFKkavzLuQSqJe
         YJGf7nn+goIkU+E9SZyCIoqw/64sfEy+4HNJSy8WuI9GrhWZfYNOLocIO4tsiqZiP9Kf
         tpdyV+2aA9dmBQsE1Pl4t1T63h/vn3yuVPCWXgrYPpetPHUdBKTZG6Z1FZRVHTWtV65D
         DnIw==
X-Gm-Message-State: AOAM530NkPbf9iS+QAlAvXfrl/kfV3KHVrXM2mSWMLzFXFM3nZpcJyAO
        p6Lx1Jyk3mUx/bn++HYlaAGvwUSUBjEY7myTGxUA+Xucr5qI9ipArA/aG2JH1E9zq3FUQ/RR0i4
        LP6DrkjgJildw+Gb2lDmanVsHLdO3MSkyNXiOQWZdQcn/+vD7FqYty8NQ4Eqvz0qwav2GuQut
X-Google-Smtp-Source: ABdhPJzppFEe6VuNVq2cF+WZ1BCsPDQ1oyrsyYTVmJUmNOa+IV+fQJ3IXjUhsGRpGyXc1MHRmTlFywRKaGLN
X-Received: from bgardon.sea.corp.google.com ([2620:15c:100:202:a2d0:faec:7d8b:2e0b])
 (user=bgardon job=sendgmr) by 2002:a17:90b:3650:b0:1ca:a667:b17c with SMTP id
 nh16-20020a17090b365000b001caa667b17cmr1215356pjb.180.1649711436331; Mon, 11
 Apr 2022 14:10:36 -0700 (PDT)
Date:   Mon, 11 Apr 2022 14:10:05 -0700
Message-Id: <20220411211015.3091615-1-bgardon@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.1178.g4f1659d476-goog
Subject: [PATCH v4 00/10] KVM: x86: Add a cap to disable NX hugepages on a VM
From:   Ben Gardon <bgardon@google.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Peter Shier <pshier@google.com>,
        David Dunn <daviddunn@google.com>,
        Junaid Shahid <junaids@google.com>,
        Jim Mattson <jmattson@google.com>,
        David Matlack <dmatlack@google.com>,
        Mingwei Zhang <mizhang@google.com>,
        Jing Zhang <jingzhangos@google.com>,
        Ben Gardon <bgardon@google.com>
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

Given the high cost of NX hugepages in terms of TLB performance, it may
be desirable to disable the mitigation on a per-VM basis. In the case of public
cloud providers with many VMs on a single host, some VMs may be more trusted
than others. In order to maximize performance on critical VMs, while still
providing some protection to the host from iTLB Multihit, allow the mitigation
to be selectively disabled.

Disabling NX hugepages on a VM is relatively straightforward, but I took this
as an opportunity to add some NX hugepages test coverage and clean up selftests
infrastructure a bit.

This series was tested with the new selftest and the rest of the KVM selftests
on an Intel Haswell machine.

The following tests failed, but I do not believe that has anything to do with
this series:
	userspace_io_test
	vmx_nested_tsc_scaling_test
	vmx_preemption_timer_test

Changelog:
v1->v2:
	Dropped the complicated memslot refactor in favor of Ricardo Koller's
	patch with a similar effect.
	Incorporated David Dunn's feedback and reviewed by tag: shortened waits
	to speed up test.
v2->v3:
	Incorporated a suggestion from David on how to build the NX huge pages
	test.
	Fixed a build breakage identified by David.
	Dropped the per-vm nx_huge_pages field in favor of simply checking the
	global + per-VM disable override.
	Documented the new capability
	Separated out the commit to test disabling NX huge pages
	Removed permission check when checking if the disable NX capability is
	supported.
	Added test coverage for the permission check.
v3->v4:
	Collected RB's from Jing and David
	Modified stat collection to reduce a memory allocation [David]
	Incorporated various improvments to the NX test [David]
	Changed the NX disable test to run by default [David]
	Removed some now unnecessary commits
	Dropped the code to dump KVM stats from the binary stats test, and
	factor out parts of the existing test to library functions instead.
	[David, Jing, Sean]
	Dropped the improvement to a debugging log message as it's no longer
	relevant to this series.

Ben Gardon (10):
  KVM: selftests: Remove dynamic memory allocation for stats header
  KVM: selftests: Read binary stats header in lib
  KVM: selftests: Read binary stats desc in lib
  KVM: selftests: Read binary stat data in lib
  KVM: selftests: Add NX huge pages test
  KVM: x86/MMU: Factor out updating NX hugepages state for a VM
  KVM: x86/MMU: Allow NX huge pages to be disabled on a per-vm basis
  KVM: x86: Fix errant brace in KVM capability handling
  KVM: x86/MMU: Require reboot permission to disable NX hugepages
  KVM: selftests: Test disabling NX hugepages on a VM

 Documentation/virt/kvm/api.rst                |  13 ++
 arch/x86/include/asm/kvm_host.h               |   2 +
 arch/x86/kvm/mmu.h                            |  10 +-
 arch/x86/kvm/mmu/mmu.c                        |  17 +-
 arch/x86/kvm/mmu/spte.c                       |   7 +-
 arch/x86/kvm/mmu/spte.h                       |   3 +-
 arch/x86/kvm/mmu/tdp_mmu.c                    |   3 +-
 arch/x86/kvm/x86.c                            |  17 +-
 include/uapi/linux/kvm.h                      |   1 +
 tools/testing/selftests/kvm/Makefile          |  10 +
 .../selftests/kvm/include/kvm_util_base.h     |  11 +
 .../selftests/kvm/kvm_binary_stats_test.c     |  75 +++----
 tools/testing/selftests/kvm/lib/kvm_util.c    | 125 ++++++++++-
 .../selftests/kvm/x86_64/nx_huge_pages_test.c | 198 ++++++++++++++++++
 .../kvm/x86_64/nx_huge_pages_test.sh          |  25 +++
 15 files changed, 453 insertions(+), 64 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/x86_64/nx_huge_pages_test.c
 create mode 100755 tools/testing/selftests/kvm/x86_64/nx_huge_pages_test.sh

-- 
2.35.1.1178.g4f1659d476-goog

