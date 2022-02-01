Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1147A4A6687
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 21:56:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbiBAUzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 15:55:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbiBAUzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 15:55:40 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B16B9C06173B
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 12:55:39 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id y3-20020a1709029b8300b0014c8bcb70a1so6107025plp.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 12:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=P0fhmv9LunS75BE8jJrWpX2XAenYYbzr/blDuojXLgY=;
        b=njk9lbaWPVy1YcoQkD++10xy9Pcs66jQhwNO0JLKsPQmGvEyAVsHzj2TlO0ynzeON6
         wbG9qGdCoW6NH1lq1ZUf3Hn+x4S8UfSRgI1GTggeFpg3Wo6tbIsKuUvJW2Kv6FeCiFEi
         6oahXtgvhujNvHCf9/JQV8QMlDzbDmHcMRovKzA/fRSb8gKItWGg/5PAk9vtQHcyQbPG
         d7x4UPwfVcxrEgkopAf+pvzyOZJvY1aVXJgTCat/RnDJRPa63BYQObEqknom0FbFPkE+
         RoAVCZMCjYZYavsN1cTYmOuB2qYzwhc47dRgOZZ4/qX3aQHOcu62j1EvVyWfm9P37diS
         M4gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=P0fhmv9LunS75BE8jJrWpX2XAenYYbzr/blDuojXLgY=;
        b=QhT+O8J4N/7xucyYAmcLxhe1qaLduHx5YZ7o4iqZnCfGGw3enbBXqTLXXGCaWeqcHa
         rcD4lN5QYhCd6XkKZP+HaE2o7T6lphNonQ0ZL0TayKpVC2vQoOOix/nUOesWYz+uhSkp
         NMHlQ0tnWFXhRGJfL1aCsQt/aZkzDoU6MrGczXl6sQJ3/jj8nJkj54fsRqw2ZiMCI7Rj
         oJ1BnKJWPXtbzb/fANBCbR8oyzwygQWZtNKMF2lFbjfO4wLGXaNkPaVxoV6KCye2WYHG
         h1CMTd7no7lRIUgpdBMQvDfcZ9xZVc2xDT51vHGgZQG6O6/a+XxsXpwkB+cw+l0cNTvR
         g3yA==
X-Gm-Message-State: AOAM531yiHi8HC5bDEzU7G/eGbKqmqg+A2HL3NBLob88tZU7Y5Xi+9mA
        +xT7UKJ/W09/H+/W0KDYrrIrd6t/Aec=
X-Google-Smtp-Source: ABdhPJzwiVun/CMtOP9irD+PbxlYzas1r71Z3x/IbYjCYzmYOgFJfJQdpujnottqj6N/F3KM9Fq1QXZEgsw=
X-Received: from haoluo.svl.corp.google.com ([2620:15c:2cd:202:1cdb:a263:2495:80fd])
 (user=haoluo job=sendgmr) by 2002:a17:903:1042:: with SMTP id
 f2mr27997904plc.115.1643748939163; Tue, 01 Feb 2022 12:55:39 -0800 (PST)
Date:   Tue,  1 Feb 2022 12:55:29 -0800
Message-Id: <20220201205534.1962784-1-haoluo@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.0.rc2.247.g8bbb082509-goog
Subject: [PATCH RFC bpf-next v2 0/5] Extend cgroup interface with bpf
From:   Hao Luo <haoluo@google.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Joe Burton <jevburton.kernel@gmail.com>,
        Stanislav Fomichev <sdf@google.com>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset introduces a new program type to extend the cgroup interfaces.
It extends the bpf filesystem (bpffs) to allow creating a directory
hierarchy that tracks any kernfs hierarchy, in particular cgroupfs. Each
subdirectory in this hierarchy will keep a reference to a corresponding
kernfs node when created. This is done by associating a new data
structure (called "tag" in this patchset) to the bpffs directory inodes.
File inode in bpffs holds a reference to bpf object and directory inode
may point to a tag, which holds a kernfs node.

A bpf object can be pinned in these directories and objects can choose to
enable inheritance in tagged directories. In this patchset, a new
program type "cgroup_view" is introduced, which supports inheritance.
More specifically, when a link to cgroup_view prog is pinned in a bpffs
directory, it tags the directory and connects the directory to the root
cgroup. Subdirectories created underneath has to match a subcgroup, and
when created, they will inherit the pinned cgroup_view link from the
parent directory.

The pinned cgroup_view objects can be read as files. When the object is
read, it tries to get the cgroup its parent directory is matched to.
Failure to get the cgroup's reference will not run the cgroup_view prog.
Users can implement cgroup_view program to define what to print out to
the file, given the cgroup object.

See patch 5/5 for an example of how this works.

Userspace has to manually create/remove directories in bpffs to mirror
the cgroup hierarchy. It was suggested using overlayfs to create a
hierarchy that contains both cgroupfs and bpffs. But after some
experiments, I found overlayfs is not intended to be used this way:
overlayfs assumes the underlying filesystem will not change [1], but our
underlaying fs (i.e. cgroupfs) will change and cause weird behavior. So
I didn't pursue in that direction.

This patchset v2 is only for demonstrating the high level design. There
are a lot of places in its implementation that can be improved. Cgroup_view
is a type of bpf_iter, because seqfile printing has been supported well
in bpf_iter, although cgroup_view is not iterating kernel objects.

Changes v1->v2:
 - Complete redesign. v1 implements pinning bpf objects in cgroupfs[2].
   v2 implements object inheritance in bpffs. Due to its simplicity,
   bpffs is better for implementing inheritance compared to cgroupfs.
 - Extend selftest to include a more realistic use case. The selftests
   in v2 developed a cgroup-level sched performance metric and exported
   through the new prog type.

[1] https://www.kernel.org/doc/html/latest/filesystems/overlayfs.html#changes-to-underlying-filesystems
[2] https://lore.kernel.org/bpf/Ydd1IIUG7%2F3kQRcR@google.com/

Hao Luo (5):
  bpf: Bpffs directory tag
  bpf: Introduce inherit list for dir tag.
  bpf: cgroup_view iter
  bpf: Pin cgroup_view
  selftests/bpf: test for pinning for cgroup_view link

 include/linux/bpf.h                           |   2 +
 kernel/bpf/Makefile                           |   2 +-
 kernel/bpf/bpf_iter.c                         |  11 +
 kernel/bpf/cgroup_view_iter.c                 | 114 ++++++++
 kernel/bpf/inode.c                            | 272 +++++++++++++++++-
 kernel/bpf/inode.h                            |  55 ++++
 .../selftests/bpf/prog_tests/pinning_cgroup.c | 143 +++++++++
 tools/testing/selftests/bpf/progs/bpf_iter.h  |   7 +
 .../bpf/progs/bpf_iter_cgroup_view.c          | 232 +++++++++++++++
 9 files changed, 829 insertions(+), 9 deletions(-)
 create mode 100644 kernel/bpf/cgroup_view_iter.c
 create mode 100644 kernel/bpf/inode.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/pinning_cgroup.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_iter_cgroup_view.c

-- 
2.35.0.rc2.247.g8bbb082509-goog

