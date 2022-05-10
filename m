Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F645521EC8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 17:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345637AbiEJPfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 11:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345763AbiEJPeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 11:34:36 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E06F52F8
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 08:29:48 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id n8so12993971qke.11
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 08:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FOe0QpIsq707T7oDbRf/pCSk/0RB38He1yJY5ChwDp8=;
        b=aIpZsyJf5arHu4Vr+y4gUngRQHnYs8ayU/4r6iHRz9x7KLZYtVJa7rzJAZVGmnN4Z3
         fYqgefyNWghW0QllgfeEfAYaJuJVbjjrbIfAvLTM4KICsEiX8VT2m1BDJ8eqgfANQddd
         1SS/KGzOfRACH29I2AkLAFUy9+7ibARRraCxVzuWayfHm0AhiyPNOL5p7+fFQSkziMaw
         BZjovDcs3K6cvmWvNL+GRHlhtldCWF65/b1GyAeIX0vlNUFoIWQUAfKs9JOeCPMCv7SX
         fy8df3gGpt6SG3JJ1yFO8DlhdGXLeMqt/Rawi0Dv+Z0qXe4nlEgaBobxeUeHzK86LEh/
         NJoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FOe0QpIsq707T7oDbRf/pCSk/0RB38He1yJY5ChwDp8=;
        b=wuYQWmjui3f54kOqXgXAppJeS4JHgpDEXj94MJ/DdQ9KnhmoRUUUIHLH41ATNRh6+i
         ZM6wmgML71BdTXfsNR3bXfX6XjgOQvmhQGWMQ4a6rGWGA5BJEfnPDe4iVF7YNQCKhN/4
         5u49wt4RStSaU6pzsFEuCLNsZGn+ORq3UlCSDXutBq7b2Fn4AAEkIOTzHeEwuj8hcm69
         eGZZQ3M7KuEnvIwjnzdbzYdUR22BXwqdQJondfCgY+1retQ0eSyQFvl6eW8s//MtS8Jx
         Ikp1h4JMzHMx5NsgE4h2P9Ue8xzBr+LjTC7OWzFEB4/Bkqf5UdRCmgZWvz4Cj26bcbls
         ln+Q==
X-Gm-Message-State: AOAM531KDvhuKwpLFnYxz2/0tktf2GIbe8576AjB+gFzKbxUldQJvxl0
        blxoz5yInLFoI3ookZGNSe3PnA==
X-Google-Smtp-Source: ABdhPJz7P4w38kJJscJ6fsGKxsfaMwr8NNE5cJTqRO1jGuOjYPzOH30aSGiRTwfV4Gye4m4oDorByg==
X-Received: by 2002:a05:620a:cd7:b0:69f:b1a7:d1eb with SMTP id b23-20020a05620a0cd700b0069fb1a7d1ebmr15562058qkj.5.1652196588031;
        Tue, 10 May 2022 08:29:48 -0700 (PDT)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id l1-20020ae9f001000000b0069fd35d2abcsm8811440qkg.112.2022.05.10.08.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 08:29:47 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Minchan Kim <minchan@kernel.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v2 0/6] zswap: accounting & cgroup control
Date:   Tue, 10 May 2022 11:28:41 -0400
Message-Id: <20220510152847.230957-1-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changelog

- Refresh and update meminfo documentation (Andrew)
- Discussions around stat sharing opportunities with zram. But agreed
  that zswap is a cache and zram a backend that could theoretically be
  stacked, so they need to be understandable separately. (Minchan)

Overview

Zswap can consume nearly a quarter of RAM in the default
configuration, yet it's neither listed in /proc/meminfo, nor is it
accounted and manageable on a per-cgroup basis.

This makes reasoning about the memory situation on a host in general
rather difficult. On shared/cgrouped hosts, the consequences are
worse. First, workloads can escape memory containment and cause
resource priority inversions: a lo-pri group can fill the global zswap
pool and force a hi-pri group out to disk. Second, not all workloads
benefit from zswap equally. Some even suffer when memory contents
compress poorly, and are better off going to disk swap directly. On a
host with mixed workloads, it's currently not possible to enable zswap
for one workload but not for the other.

This series implements the missing global accounting as well as cgroup
tracking & control for zswap backing memory:

- Patch 1 refreshes the very out-of-date meminfo documentation in
  Documentation/filesystems/proc.rst.

- Patches 2-4 clean up related and adjacent options in Kconfig. Not
  actual dependencies, just things I noticed during development.

- Patch 5 adds meminfo and vmstat coverage for zswap consumption and
  activity.

- Patch 6 implements per-cgroup tracking & control of zswap memory.

Based on v5.18-rc4-mmots-2022-04-26-19-34-5-g5e1fdb02de7a.

 Documentation/admin-guide/cgroup-v2.rst |  21 ++
 Documentation/filesystems/proc.rst      | 161 +++++----
 drivers/block/zram/Kconfig              |   3 +-
 fs/proc/meminfo.c                       |   7 +
 include/linux/memcontrol.h              |  54 +++
 include/linux/swap.h                    |   5 +
 include/linux/vm_event_item.h           |   4 +
 init/Kconfig                            | 123 -------
 mm/Kconfig                              | 523 +++++++++++++++++++-----------
 mm/memcontrol.c                         | 196 ++++++++++-
 mm/vmstat.c                             |   4 +
 mm/zswap.c                              |  50 ++-
 12 files changed, 753 insertions(+), 398 deletions(-)


