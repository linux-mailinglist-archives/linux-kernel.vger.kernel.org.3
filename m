Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 570C146F625
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 22:47:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231927AbhLIVut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 16:50:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbhLIVus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 16:50:48 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72049C061746
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 13:47:14 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id i12so6635635pfd.6
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 13:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J9dZhEUcOohDHal2Ib8BavrJapvk4m1HbzlYYeuOFQA=;
        b=LPm8tgwBSBFWkTfhyrZxOMsCVuH2XLj9E2cG/K1TA4XZZKhYMjF9mQN+zTBPnyaEXm
         opCorLGQvCBu0+TNwccSslT0IMxgNcSAlhKEnM8iIPUZIWMdJQcyfsa62/lLRWoUE9Qx
         crr9NvNTjXkuafOWBGf6s3XzxI6U0KSNtcjw4mvR0sHY9hZH+GK+BTBR6Zp85rVKjgJT
         yHNtVvGkhhvdx7mKt1lyUpTeoD5iF/HDsujorWgdMyp+6SpX00jgiabq3VtxpHsu+k7M
         DTUQAE39sf+0aM9ySx/2w/XoMRKnnfGManjKVK0NqZM4DaQ8vAvNvQct6zBrrzadYRdh
         FA0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=J9dZhEUcOohDHal2Ib8BavrJapvk4m1HbzlYYeuOFQA=;
        b=2/sBi4AyeDYt97aHtf8RKPNV5QGPP5dZztttoiw6OU0KrbpblJXSt6vn728yGMkfoE
         7a9keJyUnaw+EI/cYfuGs9ynMvFkzZrnxyW7GgrhldMkn6xTyk0DCWmQXktv8GGezEMf
         uGxHV9BTJSfuQtTo6Q83esviXql3j7ZK+RIqism3jgs82pFzDGsIfD1AB5KsS/q/emJd
         XlfIpHEga6Sec77bEt/Atinqmxxn/K7s5uD8Ci/DfKGehRPi5tKCBhciHcb0SpxFNNaB
         oLCsQ0jf1gdPQ1IahcETTSS9+xpWk7lGkyElwm2HKloNB+bHQI7ub/iRCdPcIZAqlqLn
         F7cg==
X-Gm-Message-State: AOAM530kdIjuZLXMG7k4c6/Yo4p5p2Vq/bbv+qxzzf9EIiUqz2mPJcQ/
        jQqE7m6iEKH5lPcDMtBbF/0=
X-Google-Smtp-Source: ABdhPJyKD1rLYZofTlxV74wpLkdIpM3QjoNsK7Yq0O89NKjXTZlV/vyskmDuUy1F+S1EHNKMD+Jk2w==
X-Received: by 2002:a63:1547:: with SMTP id 7mr868159pgv.488.1639086433738;
        Thu, 09 Dec 2021 13:47:13 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id h22sm648923pfv.25.2021.12.09.13.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 13:47:13 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     torvalds@linuxfoundation.org, ebiederm@xmission.com,
        mkoutny@suse.com, axboe@kernel.dk, keescook@chromium.org,
        oleg@redhat.com, peterz@infradead.org, tglx@linutronix.de,
        jnewsome@torproject.org, legion@kernel.org, luto@amacapital.net,
        jannh@google.com
Cc:     linux-kernel@vger.kernel.org, security@kernel.org,
        kernel-team@fb.com
Subject: [PATCHSET cgroup/for-5.16-fixes] cgroup: Use open-time creds and namespace for migration perm checks
Date:   Thu,  9 Dec 2021 11:47:01 -1000
Message-Id: <20211209214707.805617-1-tj@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

cgroup process migration permission checks are performed at write time as
whether a given operation is allowed or not is dependent on the content of
the write - the PID. This currently uses current's credentials and cgroup
namespace which is a potential security weakness as it may allow scenarios
where a less privileged process tricks a more privileged one into writing
into a fd that it created.

This patchset make the perm checks use credentials and cgroup namespace
stored at the time of open and contains the following patches.

 0001-cgroup-Use-open-time-credentials-for-process-migrato.patch
 0002-cgroup-Allocate-cgroup_file_ctx-for-kernfs_open_file.patch
 0003-cgroup-Use-open-time-cgroup-namespace-for-process-mi.patch
 0004-selftests-cgroup-Make-cg_create-use-0755-for-permiss.patch
 0005-selftests-cgroup-Test-open-time-credential-usage-for.patch
 0006-selftests-cgroup-Test-open-time-cgroup-namespace-usa.patch

The patchset is also available in the following git branch.

 git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git review-migration-perms

Michal, does this also fix the original bug you were trying to fix? For now,
I didn't add Fixes / stable tags. If ppl are okay with the patchset, I'll
route it through cgroup/for-5.16-fixes.

diffstat follows. Thanks.

 kernel/cgroup/cgroup-internal.h              |   14 ++++
 kernel/cgroup/cgroup-v1.c                    |    7 +-
 kernel/cgroup/cgroup.c                       |   82 ++++++++++++++++++-------
 tools/testing/selftests/cgroup/cgroup_util.c |    2 
 tools/testing/selftests/cgroup/test_core.c   |  165 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 244 insertions(+), 26 deletions(-)

--
tejun

