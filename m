Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5277057A7A8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 21:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239044AbiGST4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 15:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238719AbiGST4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 15:56:37 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F03059258
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 12:56:33 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-31cd7ade3d6so126903087b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 12:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=4ZVCVYd33nvDbXmYz6AUV1M3rt6KeSBhimBlcmhBGXo=;
        b=lc9AQqTARh1WZm1kvYwNkL/3MWhIgLRLSGpjjdvG/1blyOgUJ+O8L1AzrUfRecO2p4
         xuDJwRyTDMVLvE0cWwwdXJn6/FEueOVEZJl36JekXzPjPLoLwUkElRf1vF+9Hb5eeCKp
         i9g+PrMitbkmV+noWmUawPDxG/2Fwzz+OSiTkTlZ/52zdWBrj+a116ToS0WJSFpV0zpO
         rdfr9FOmVuN/YnfBL3x4c+M/wJ7xf3GpdLYtmVMzCBaTELEvqU0wl81fsY8i3LQ1wM7Q
         qvkeuW+JuwRkjaPhfbzquMaukkqualLyL4tGYJSSR4YftkePZkzpGa7GExCk4wz3Fs/F
         lPGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=4ZVCVYd33nvDbXmYz6AUV1M3rt6KeSBhimBlcmhBGXo=;
        b=sSzt+qcvT9gkRSoZA0GfguzbZGb0lEjxBb+dumYSOt9NFIXz91nJQKI9efgTMGJTpr
         WdQVBdBzUr3sepKwZGMWeP9w+ajYNjwZ0JdSGt31SKTNGzgh3g36snHZ3ojCkQocVQoM
         8zRuY79upI87//lQaw3ixwJAVuUTJhPJVqkoWrlq46lYMXbblD0JFSebntjxXOsT4aW4
         cjjxk+q9HtkTQayZxwXESyPit6g68MbcZsxjOongvsQJ6j6W6QRkxDCbMgGsaRyrThik
         53jN0ASbsClIl68xEVvH+3ci1U2CylR0wB430OZzSSP0AJYwe3cVXlnvs7cnjWEOif36
         REOw==
X-Gm-Message-State: AJIora/DrIwb0Qk4pkRCR5h1f8wNCwqgsGX5YYQLRn+iaYz7JKf1Ao1r
        94yQTCwkjvRYheYI7vvcdLkgJurIcN1GS4yFBVjs
X-Google-Smtp-Source: AGRyM1togdDHBrz/Hzl7WreswK03PRkqxUYOEK+ORErJYAO/PxDUWEFD1kLTLjurVrg5osULk0o2TVRizJIWAmhsrYPA
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2d4:203:a065:9221:e40d:4fbe])
 (user=axelrasmussen job=sendgmr) by 2002:a81:58c1:0:b0:31d:6b54:3fd5 with
 SMTP id m184-20020a8158c1000000b0031d6b543fd5mr38069412ywb.7.1658260592731;
 Tue, 19 Jul 2022 12:56:32 -0700 (PDT)
Date:   Tue, 19 Jul 2022 12:56:23 -0700
Message-Id: <20220719195628.3415852-1-axelrasmussen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
Subject: [PATCH v4 0/5] userfaultfd: add /dev/userfaultfd for fine grained
 access control
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>,
        Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        Jonathan Corbet <corbet@lwn.net>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>,
        Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, zhangyi <yi.zhang@huawei.com>
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is based on torvalds/master.

The series is split up like so:
- Patch 1 is a simple fixup which we should take in any case (even by itself).
- Patches 2-6 add the feature, configurable selftest support, and docs.

Why not ...?
============

- Why not /proc/[pid]/userfaultfd? The proposed use case for this is for one
  process to open a userfaultfd which can intercept another process' page
  faults. This seems to me like exactly what CAP_SYS_PTRACE is for, though, so I
  think this use case can simply use a syscall without the powers CAP_SYS_PTRACE
  grants being "too much".

- Why not use a syscall? Access to syscalls is generally controlled by
  capabilities. We don't have a capability which is used for userfaultfd access
  without also granting more / other permissions as well, and adding a new
  capability was rejected [1].

    - It's possible a LSM could be used to control access instead. I suspect
      adding a brand new one just for this would be rejected, but I think some
      existing ones like SELinux can be used to filter syscall access. Enabling
      SELinux for large production deployments which don't already use it is
      likely to be a huge undertaking though, and I don't think this use case by
      itself is enough to motivate that kind of architectural change.

Changelog
=========

v3->v4:
  - Picked up an Acked-by on 5/5.
  - Updated cover letter to cover "why not ...".
  - Refactored userfaultfd_allowed() into userfaultfd_syscall_allowed(). [Peter]
  - Removed obsolete comment from a previous version. [Peter]
  - Refactored userfaultfd_open() in selftest. [Peter]
  - Reworded admin-guide documentation. [Mike, Peter]
  - Squashed 2 commits adding /dev/userfaultfd to selftest and making selftest
    configurable. [Peter]
  - Added "syscall" test modifier (the default behavior) to selftest. [Peter]

v2->v3:
  - Rebased onto linux-next/akpm-base, in order to be based on top of the
    run_vmtests.sh refactor which was merged previously.
  - Picked up some Reviewed-by's.
  - Fixed ioctl definition (_IO instead of _IOWR), and stopped using
    compat_ptr_ioctl since it is unneeded for ioctls which don't take a pointer.
  - Removed the "handle_kernel_faults" bool, simplifying the code. The result is
    logically equivalent, but simpler.
  - Fixed userfaultfd selftest so it returns KSFT_SKIP appropriately.
  - Reworded documentation per Shuah's feedback on v2.
  - Improved example usage for userfaultfd selftest.

v1->v2:
  - Add documentation update.
  - Test *both* userfaultfd(2) and /dev/userfaultfd via the selftest.

[1]: https://lore.kernel.org/lkml/686276b9-4530-2045-6bd8-170e5943abe4@schaufler-ca.com/T/

Axel Rasmussen (5):
  selftests: vm: add hugetlb_shared userfaultfd test to run_vmtests.sh
  userfaultfd: add /dev/userfaultfd for fine grained access control
  userfaultfd: selftests: modify selftest to use /dev/userfaultfd
  userfaultfd: update documentation to describe /dev/userfaultfd
  selftests: vm: add /dev/userfaultfd test cases to run_vmtests.sh

 Documentation/admin-guide/mm/userfaultfd.rst | 41 +++++++++++-
 Documentation/admin-guide/sysctl/vm.rst      |  3 +
 fs/userfaultfd.c                             | 69 ++++++++++++++++----
 include/uapi/linux/userfaultfd.h             |  4 ++
 tools/testing/selftests/vm/run_vmtests.sh    | 11 +++-
 tools/testing/selftests/vm/userfaultfd.c     | 69 +++++++++++++++++---
 6 files changed, 169 insertions(+), 28 deletions(-)

--
2.37.0.170.g444d1eabd0-goog

