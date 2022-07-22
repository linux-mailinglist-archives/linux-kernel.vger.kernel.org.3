Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35BC557DF0A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 12:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234482AbiGVJos (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 05:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236939AbiGVJo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 05:44:27 -0400
Received: from mail-ua1-x94a.google.com (mail-ua1-x94a.google.com [IPv6:2607:f8b0:4864:20::94a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D3A2BB5E7
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 02:38:49 -0700 (PDT)
Received: by mail-ua1-x94a.google.com with SMTP id r1-20020a9f2c01000000b00383196b2690so1913940uaj.18
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 02:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=X0oN1G1OQvdRnhcJfrd3sUIzDmI1WFEM6TnugeAwxec=;
        b=fVUB4/oi7gbyKDxTGZsPWF4eo2KrGEqztpYEuwfyTvF2LUT/ZxhBNnPF9PNi8A8Jkk
         lbDXZTA56puUrxEJsQCL/Du0ubnfc2LZw7j1ZMa6SKJlIEZTEXSIMB6YNhRjwjkuWO96
         SFtMIgO6ptsJaoV8u4dnGGHvU/Qj7aut3hzaTmg5H3+JWihzbubv3MUtQf7MhGc4f+uk
         QpikzJUhTs3fAcTYyM709ntgeEVCQLKgD3lhhDNm9h97ybe+f5FC35ww5J8QnUlMYM0U
         34eMl0gsfYJybtOnIo9uNDP+JqtpUf9qNtWuvelByw6dPuOm7nb7e4wtHBbEfOWouJlo
         L6oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=X0oN1G1OQvdRnhcJfrd3sUIzDmI1WFEM6TnugeAwxec=;
        b=hlJvsqtDn2UUrbGvayuhdT0jbwHbIv2Jh7sNy1Ie0SSdE/XP8m53Sv6JS0R+hUb8iu
         V+wmCmwCaiEgd+a0GW9i6xPtfbODlRiBsT1arWKyeNggexoaAAuJnKMTu1EWt28wErRX
         +PcO5FCCb2/DMDTtLNWbUnbm8J4D3nt+BrgDM2zJTLTPC9X1NCQBsMzunfetYwA2gVYU
         Cp1UZqec7uDNqUhdPT/wJsyGBy0BaBYwzJoa+9bO3J5CxRmVkXs3RhkvDo6SLF1F5g6P
         jjUI9yOv8+CTlNh64z4QcZdS8cDZhsUz/d7vMbZ8jOxm8KMGVHOWV0eGTwShYr5GGn3S
         SJ4A==
X-Gm-Message-State: AJIora+spxI0rfKZVs/zHl/bOJXjj4EwGFp0g8//X4krNO6llJSfPsa1
        7Rfh6a9Ior0yzoaq0Z0RWu1N+8goOX0Yb5obJrRbbb2m/tIPShowjamxCYlT7FeDlUh/lPQPN9r
        dQgCln0pws7DAwdL3dYTK8sqKa0/JO0zFwZNmAXIluXivghAJzxoZy5JzfEHttMepBoM=
X-Google-Smtp-Source: AGRyM1vlkN+Ixt5tJI3A5NZlp/9LYsAuB90zSBJNNKCuzbKjP/FsQzKU398QjgVHH8OarhwgkNhE2lWeKw==
X-Received: from nhuck.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:39cc])
 (user=nhuck job=sendgmr) by 2002:a05:6102:3bc7:b0:358:3b4b:cd31 with SMTP id
 a7-20020a0561023bc700b003583b4bcd31mr773613vsv.72.1658482727792; Fri, 22 Jul
 2022 02:38:47 -0700 (PDT)
Date:   Fri, 22 Jul 2022 09:38:20 +0000
Message-Id: <20220722093823.4158756-1-nhuck@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
Subject: [PATCH 0/3] dm-verity: optionally use tasklets in dm-verity
From:   Nathan Huckleberry <nhuck@google.com>
To:     linux-kernel@vger.kernel.org, dm-devel@redhat.com,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nathan Huckleberry <nhuck@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using tasklets for disk verification can reduce IO latency.  When there are
accelerated hash instructions it is often better to compute the hash immediately
using a tasklet rather than deferring verification to a work-queue.  This
reduces time spent waiting to schedule work-queue jobs, but requires spending
slightly more time in interrupt context.

A tasklet can only be used for verification if all the required hashes are
already in the dm-bufio cache.  If verification cannot be done in a tasklet, we
fallback the existing work-queue implementation.

To allow tasklets to query the dm-bufio cache, the dm-bufio code must not sleep.
This patchset adds a flag to dm-bufio that disallows sleeping.

The following shows a speed comparison of random reads on a dm-verity device.
The dm-verity device uses a 1G ramdisk for data and a 1G ramdisk for hashes.
One test was run using tasklets and one test was run using the existing
work-queue solution.  Both tests were run when the dm-bufio cache was hot.  The
tasklet implementation performs significantly better since there is no time
waiting for work-queue jobs to be scheduled.

# /data/fio /data/tasklet.fio | grep READ
   READ: bw=181MiB/s (190MB/s), 181MiB/s-181MiB/s (190MB/s-190MB/s), io=512MiB
   (537MB), run=2827-2827msec
# /data/fio /data/workqueue.fio | grep READ
   READ: bw=23.6MiB/s (24.8MB/s), 23.6MiB/s-23.6MiB/s (24.8MB/s-24.8MB/s),
   io=512MiB (537MB), run=21688-21688msec

Nathan Huckleberry (3):
  dm-bufio: Add flags for dm_bufio_client_create
  dm-bufio: Add DM_BUFIO_GET_CANT_SLEEP
  dm-verity: Add try_verify_in_tasklet

 drivers/md/dm-bufio.c                         | 29 +++++--
 drivers/md/dm-ebs-target.c                    |  3 +-
 drivers/md/dm-integrity.c                     |  2 +-
 drivers/md/dm-snap-persistent.c               |  2 +-
 drivers/md/dm-verity-fec.c                    |  4 +-
 drivers/md/dm-verity-target.c                 | 87 ++++++++++++++++---
 drivers/md/dm-verity.h                        |  5 ++
 drivers/md/persistent-data/dm-block-manager.c |  3 +-
 include/linux/dm-bufio.h                      |  8 +-
 9 files changed, 119 insertions(+), 24 deletions(-)

-- 
2.37.1.359.gd136c6c3e2-goog

