Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E99EE58EF5B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 17:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233117AbiHJPUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 11:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233130AbiHJPUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 11:20:37 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D97B15FE8
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 08:20:37 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-31f63772b89so127700327b3.6
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 08:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc;
        bh=KP56zBh4EvBGEqVoL4D6U15kXFJ7buVHE9QkBLEHtC8=;
        b=QbxkmY4fxPn3ZPa+rAkuSv6hX1Y2IrikvlfpUUM2ufZ7ccAYugsIGg+LtUZqgR2QGX
         svVH9ejDQKcJbIi1K/WYMLViIWxD7Rk9YK/i1XwFk/7+JIN0ZvLBSHv9VsNOqMxqcQJH
         W3n4ZF3MSkTGn7m+Qev5pRr7tmKXhNeIoKoqJvk1GBG5VWR5mJRACvq2xDJvh6iC/7qc
         SYPSEJUHGVbCom3QjS2hzzF/8TyEtPVEryfx29btpx6/qBh/kkvnsMjN1RMNDXQ8UsRr
         drcdl1YKDxFd1dIupQ7BCi7j4a1TcFHm07P3uI/a+8RrfaZv5oowE88Pl+6qD0RO3rmZ
         vG/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc;
        bh=KP56zBh4EvBGEqVoL4D6U15kXFJ7buVHE9QkBLEHtC8=;
        b=g4QXfX9g0WPPM3Nb6/8iDgLrxt8MbDU7wn1T6jaZWAp0e+FGHuK+OgAkkHTy9Xz0Cl
         h2w2F7HhX5nk+vWrejuFxqUk1z+4ivyxE9SF+RfisoJFg/LnyiNeoYo4WXBgAFfBS3NN
         OY7G6HWNA8ObPODKSSD9VjfZWKiaGV/kzNwrURQE2MAogsbh37sM18QHJffwBZDKTLRZ
         kAPy3XK9fl+TAS9RiOYUH4aqZWk/Ld2QEMijPUStc/qT4u2UhtfNmQqvJ1qm7ymsn82k
         JtnDkj/TzZsY2feHDdb1/G4UMLMUrLb9GgNNgAPYS2u/WIFuptei7mLDVE/CUV3pSY3u
         /WiQ==
X-Gm-Message-State: ACgBeo2yLwfqXDLj+9LjSFdP9a9OzYTORWYOoZQwjBkku0JoX5xOv8V2
        tSre8Rb+ivdY7g4dY/biWfL3jv3Ildw=
X-Google-Smtp-Source: AA6agR7cyzY1meKb7HLA3MEnjHTZxWSNYuEhyHK9bPPEI4pmYPqJHKxQVCBhTq2SL952pVdPq5WojJYtnD0=
X-Received: from pgonda1.kir.corp.google.com ([2620:15c:29:203:b185:1827:5b23:bbe2])
 (user=pgonda job=sendgmr) by 2002:a25:41c4:0:b0:67b:a826:7c71 with SMTP id
 o187-20020a2541c4000000b0067ba8267c71mr19812460yba.486.1660144836339; Wed, 10
 Aug 2022 08:20:36 -0700 (PDT)
Date:   Wed, 10 Aug 2022 08:20:22 -0700
Message-Id: <20220810152033.946942-1-pgonda@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.559.g78731f0fdb-goog
Subject: [V3 00/11] KVM: selftests: Add simple SEV test
From:   Peter Gonda <pgonda@google.com>
To:     kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, marcorr@google.com,
        seanjc@google.com, michael.roth@amd.com, thomas.lendacky@amd.com,
        joro@8bytes.org, mizhang@google.com, pbonzini@redhat.com,
        andrew.jones@linux.dev, vannapurve@google.com,
        Peter Gonda <pgonda@google.com>
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

This patch series combines the work Michael Roth has done in supporting
SEV guests in selftests and the work Sean Christopherson suggested to
allow ucalls from SEV guests. And the work Sean has sent to consolidate
the ucall boilerplate code. Along with a very simple version of the
SEV selftests Michael originally proposed.

V3
 * Addressed more of andrew.jones@ in ucall patches.
 * Fix build in non-x86 archs.

V2
 * Dropped RFC tag
 * Correctly separated Sean's ucall patches into 2 as originally
   intended.
 * Addressed andrew.jones@ in ucall patches.
 * Fixed ucall pool usage to work for other archs

V1
 * https://lore.kernel.org/all/20220715192956.1873315-1-pgonda@google.com/

Michael Roth (6):
  KVM: selftests: move vm_phy_pages_alloc() earlier in file
  KVM: selftests: sparsebit: add const where appropriate
  KVM: selftests: add hooks for managing encrypted guest memory
  KVM: selftests: handle encryption bits in page tables
  KVM: selftests: add support for encrypted vm_vaddr_* allocations
  KVM: selftests: add library for creating/interacting with SEV guests

Peter Gonda (3):
  tools: Add atomic_test_and_set_bit()
  KVM: selftests: Add ucall pool based implementation
  KVM: selftests: Add simple sev vm testing

Sean Christopherson (2):
  KVM: selftests: Consolidate common code for popuplating
  KVM: selftests: Consolidate boilerplate code in get_ucall()

 tools/arch/x86/include/asm/atomic.h           |   7 +
 tools/include/asm-generic/atomic-gcc.h        |  15 +
 tools/testing/selftests/kvm/.gitignore        |   1 +
 tools/testing/selftests/kvm/Makefile          |   3 +
 .../selftests/kvm/include/kvm_util_base.h     |  25 ++
 .../testing/selftests/kvm/include/sparsebit.h |  36 +--
 .../selftests/kvm/include/ucall_common.h      |  14 +-
 .../selftests/kvm/include/x86_64/sev.h        |  47 +++
 .../testing/selftests/kvm/lib/aarch64/ucall.c |  38 +--
 tools/testing/selftests/kvm/lib/kvm_util.c    | 267 +++++++++++++-----
 tools/testing/selftests/kvm/lib/riscv/ucall.c |  43 +--
 tools/testing/selftests/kvm/lib/s390x/ucall.c |  40 +--
 tools/testing/selftests/kvm/lib/sparsebit.c   |  48 ++--
 .../testing/selftests/kvm/lib/ucall_common.c  | 139 +++++++++
 .../selftests/kvm/lib/x86_64/processor.c      |  15 +-
 tools/testing/selftests/kvm/lib/x86_64/sev.c  | 249 ++++++++++++++++
 .../testing/selftests/kvm/lib/x86_64/ucall.c  |  39 +--
 .../selftests/kvm/x86_64/sev_all_boot_test.c  | 131 +++++++++
 18 files changed, 911 insertions(+), 246 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/include/x86_64/sev.h
 create mode 100644 tools/testing/selftests/kvm/lib/ucall_common.c
 create mode 100644 tools/testing/selftests/kvm/lib/x86_64/sev.c
 create mode 100644 tools/testing/selftests/kvm/x86_64/sev_all_boot_test.c

-- 
2.37.1.559.g78731f0fdb-goog

