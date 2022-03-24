Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 938DF4E6B46
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 00:42:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347300AbiCXXoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 19:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356422AbiCXXnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 19:43:01 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2AB3BA31C
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 16:41:27 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2e5bcae3665so47681817b3.16
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 16:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=YM5HWwtsuon+nq2pjNDv8Dl1s4yCw5MepRNvjajdRw8=;
        b=B+BmeYhFUl732dOfJ3g/AH0DUva74mBYCMxNYvLXJmUf3f3DsoL8nrpaQnli+1YQVz
         5WPtDROMaecvyIqMTYigAL9o6AiMZI6EPdXxBi04Hmpjmu4/PIkNfRi3FLCE0afTj2KJ
         Z4hMpnUrglfvmrCGGh+Za6gJ3gkGaQEXmcH+lIboOCX+uxSXopXcOoR8ARexTDcNygmD
         ZEPsPg6vBK60p4AXrTn9EbpUx1D3+mG2ZoigPFAQqVrWvMtYVTYWPnAOnt/eVb4/BokG
         vZmHhLqv3FPdcV2W0BD6D9RSE2csfCyAHSHvQLotBn1aIVhhKzfP3UWE34NB2sCHSdDn
         R4SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=YM5HWwtsuon+nq2pjNDv8Dl1s4yCw5MepRNvjajdRw8=;
        b=vHkeQKNxIwLZEXc/3ZxXs6liW/SeYGDTa9yDBvq3ZmAKy7cdUFICCbhBwNtKbrL+uk
         T2/JpkVrB9oaA1WJnZF8h8n2tktvUjUmbXatr0sCz91RoFphqlv00kJPoTchZ74xWX0f
         v9TO+7BEqCKD1aTiofIK4Cy0XfXLnMeL4FIffVuIAgUcvTp+3qmZ20GEEdUR3Y+y16s6
         B0urqJeh94W9eH7ZkxOh+ICDZtVUPbXTXqMZ0baxJEWzQ5h5e28qKeYXCpkwa98Vm3qC
         /oaVmWu6ZDpoL5d4ZuufDdMhkalneQ9p+quw2RUUUQdZRna4ybigqUVbT3UlVQhJjUPN
         H6KA==
X-Gm-Message-State: AOAM533DYcv5FtlbsQrXmsGSYDhsAYQYYqjjZ1i0r9hIVVPuxMcNUptl
        wEOaV16raM/P4t6ujrpjHSnCaMQivI8=
X-Google-Smtp-Source: ABdhPJyHyZ2WgjGriCBsdHXAi1Do5BWOgO1m6A0z6NLZii0z+HW4WqZQi+VdPnE4P9A//WlpZMKlDtuZSEs=
X-Received: from haoluo.svl.corp.google.com ([2620:15c:2cd:202:f3eb:bf7b:2da4:12c9])
 (user=haoluo job=sendgmr) by 2002:a81:1bc3:0:b0:2e3:aa1:f553 with SMTP id
 b186-20020a811bc3000000b002e30aa1f553mr7547386ywb.491.1648165287205; Thu, 24
 Mar 2022 16:41:27 -0700 (PDT)
Date:   Thu, 24 Mar 2022 16:41:21 -0700
Message-Id: <20220324234123.1608337-1-haoluo@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
Subject: [PATCH RFC bpf-next 0/2] Mmapable task local storage.
From:   Hao Luo <haoluo@google.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     yhs@fb.com, KP Singh <kpsingh@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hao Luo <haoluo@google.com>
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

Some map types support mmap operation, which allows userspace to
communicate with BPF programs directly. Currently only arraymap
and ringbuf have mmap implemented.

However, in some use cases, when multiple program instances can
run concurrently, global mmapable memory can cause race. In that
case, userspace needs to provide necessary synchronizations to
coordinate the usage of mapped global data. This can be a source
of bottleneck.

It would be great to have a mmapable local storage in that case.
This patch adds that.

Mmap isn't BPF syscall, so unpriv users can also use it to
interact with maps.

Currently the only way of allocating mmapable map area is using
vmalloc() and it's only used at map allocation time. Vmalloc()
may sleep, therefore it's not suitable for maps that may allocate
memory in an atomic context such as local storage. Local storage
uses kmalloc() with GFP_ATOMIC, which doesn't sleep. This patch
uses kmalloc() with GFP_ATOMIC as well for mmapable map area.

Allocating mmapable memory has requirment on page alignment. So we
have to deliberately allocate more memory than necessary to obtain
an address that has sdata->data aligned at page boundary. The
calculations for mmapable allocation size, and the actual
allocation/deallocation are packaged in three functions:

 - bpf_map_mmapable_alloc_size()
 - bpf_map_mmapable_kzalloc()
 - bpf_map_mmapable_kfree()

BPF local storage uses them to provide generic mmap API:

 - bpf_local_storage_mmap()

And task local storage adds the mmap callback:

 - task_storage_map_mmap()

When application calls mmap on a task local storage, it gets its
own local storage.

Overall, mmapable local storage trades off memory with flexibility
and efficiency. It brings memory fragmentation but can make programs
stateless. Therefore useful in some cases.

Hao Luo (2):
  bpf: Mmapable local storage.
  selftests/bpf: Test mmapable task local storage.

 include/linux/bpf.h                           |  4 +
 include/linux/bpf_local_storage.h             |  5 +-
 kernel/bpf/bpf_local_storage.c                | 73 +++++++++++++++++--
 kernel/bpf/bpf_task_storage.c                 | 40 ++++++++++
 kernel/bpf/syscall.c                          | 67 +++++++++++++++++
 .../bpf/prog_tests/task_local_storage.c       | 38 ++++++++++
 .../bpf/progs/task_local_storage_mmapable.c   | 38 ++++++++++
 7 files changed, 257 insertions(+), 8 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/task_local_storage_mmapable.c

-- 
2.35.1.1021.g381101b075-goog

