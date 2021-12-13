Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59FB34734CC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 20:18:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242204AbhLMTSl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 14:18:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235389AbhLMTSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 14:18:40 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65F4BC061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 11:18:40 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id l10so4440282pgm.7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 11:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mUVCA2Xfo4yaqKwmyS/nYJ+ARGhj+MxdACGEDsQD4bM=;
        b=Wy8gPnAmEpfvuiQDYFB7qXu5s2KWy0uCMjLjYgxIYjspaFZ9zMm9R1XUVqT+Khgs4C
         l1wPNUnlc3MTE4bEUdUbOM0+B5Kc/xtFAEKEaVKnOAuvr8GR6CZ52muf5htASYn5CnuA
         98Gk7KpZShgcm7GyJv1PXdUfAxsjVwQSvr4FBjniWMZQiYW31jJUQZNLV+clQU+P1SaC
         gjxZvoojaOgvkmEUzxn984mA9nQanfIhG82GJIENr/e3hn/QZv9Rf3oI2ULPVIi4wuH5
         YeFHVhZWzxD44u6NsAoKkxg3CSe25jkQh3/r87c1zkE+SdHOd8KKEtZaZzOLXcWnllcd
         EEAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=mUVCA2Xfo4yaqKwmyS/nYJ+ARGhj+MxdACGEDsQD4bM=;
        b=FCywgwBzuf3UgUnd+rNAonFg76U10d3QlPOPMzlT6o9CIlKDA+yJ8V5tX1Id8lN3Xn
         l1FWOonG/vgsgRvEV7MmT5prCX0BmOs5Qpz1XAjr6U6NUKBR5g3mnKmtl4vOaP68FGzG
         7C23qwuTIkfsIL5kWeS6X8Y0prvUQzfpT9MyaI6OKemAcVCEOwxYSD4jxeMnjy45Nqtq
         I044ibeqr04R6JmpfRR87iTAlMSGF99Nxz2ipfpzea04OH9l5mjUZSpnK3LouGZy2VYN
         4eXeXDAdXTU7vFcQOeXAjL/4pi2fzpqZTvXRkSxfUXKJnnr9q2UOnHW3HxErgxtU+Qpw
         cFog==
X-Gm-Message-State: AOAM533tbI3F76MTSX8DFnGDiY4XlKWyo+Fs93lWIcNVCOt1eG55s3kB
        pIFScGdcf9phHtW+iwwfGOs=
X-Google-Smtp-Source: ABdhPJyyRQZ5gSJCGUFRWTmO+7VIHoFuyoGPoOVCfnnMP/ghGe91FDf0dUoCzoE4EdRGmSB3Yc89aw==
X-Received: by 2002:a05:6a00:2444:b0:4ab:15b9:20e5 with SMTP id d4-20020a056a00244400b004ab15b920e5mr108181pfj.0.1639423119729;
        Mon, 13 Dec 2021 11:18:39 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id e6sm11189930pgc.33.2021.12.13.11.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 11:18:39 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     torvalds@linuxfoundation.org, ebiederm@xmission.com,
        mkoutny@suse.com, axboe@kernel.dk, keescook@chromium.org,
        oleg@redhat.com, peterz@infradead.org, tglx@linutronix.de,
        jnewsome@torproject.org, legion@kernel.org, luto@amacapital.net,
        jannh@google.com
Cc:     linux-kernel@vger.kernel.org, security@kernel.org,
        kernel-team@fb.com
Subject: [PATCHSET v2 cgroup/for-5.16-fixes] cgroup: Use open-time creds and namespace for migration perm checks
Date:   Mon, 13 Dec 2021 09:18:27 -1000
Message-Id: <20211213191833.916632-1-tj@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

v2: 0002-cgroup-Allocate-cgroup_file_ctx-for-kernfs_open_file updated to
    drop the union and embed procs.iter as suggested by Linus.

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

The patchset is also available in the following git branch. If there's no
objetion, I will apply to cgroup/for-5.16-fixes in a few days.

 git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git review-migration-perms-1

diffstat follows. Thank you.

 kernel/cgroup/cgroup-internal.h              |   13 ++
 kernel/cgroup/cgroup-v1.c                    |    7 -
 kernel/cgroup/cgroup.c                       |   88 +++++++++-----
 tools/testing/selftests/cgroup/cgroup_util.c |    2 
 tools/testing/selftests/cgroup/test_core.c   |  165 +++++++++++++++++++++++++++
 5 files changed, 243 insertions(+), 32 deletions(-)

--
tejun

