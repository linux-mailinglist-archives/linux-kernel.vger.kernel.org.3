Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6592E511DD2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241486AbiD0QGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 12:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242344AbiD0QEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 12:04:37 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 603D936AF36
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 09:01:14 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id b189so1594738qkf.11
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 09:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9GL3COHv0leHgkc2xj8IFg2MOsyvROczlu9iqFQTi6c=;
        b=EyNosu86WZBzUC9jjE+BB/6+rRUePVNB5D6ZLweYK0cFIUWcYSagiZotbV3kGhvIlS
         aSvmf4EfGitZgrEkXNDGgBgiz1HC8zvbqhEgPDUnOPd4hguA+FT8asyo6S3j5oDYIoGo
         8i8blQjc96SokqKzFW3yhgqj9t2hCvOPMNnicEa5sb4XEiaLxO8ipgY23jPrzflTCMCj
         e/QXaswu/EhhZnxUl3ooWdUkmRJ2DPmY42IUXuA03tcMHr/j8BJn49Zny7U2+x5RZUMc
         5GK7mdC+N0Gj6dvbpJN0oMAU2pAmBPbv0TW1TyQBbPT7Db08uuswrZhBl7kJzgp+QWcy
         Qw3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9GL3COHv0leHgkc2xj8IFg2MOsyvROczlu9iqFQTi6c=;
        b=OXTHtAzyg6f7nPaVxIxISU+2EAJQzwnf1x14Go2gmoCS+jU0ngCQOlTqwaw/4l/iGg
         SmIiST1tTyWqHk6aPNKSz8ohbg6LvagAyCbuQBYajjUa5YnM0KB9F2k10CHpvVHs1VOi
         hdtbbrW0AFOfZZMAHwPJmixE+0P+04wZi3QSP0xGPP/OVPBmzACtKj4vjH60gwY8Pd56
         +dzUBwn1yM7VzO6XhysWWA9HESmVvTW9aXmvX+++61PxojS8qeCo+4jK27uxvn4gZyCg
         /lpFA4nG+eAfpXAZMvMnFYQ2fMh2pcHqJuXnlIHz3PSY8M96dstj8EevWLP0GSOHGVnP
         5tRQ==
X-Gm-Message-State: AOAM532Zhtd4JuqdG64KDX1CJj1a3yRt3aAnKkThApwnJcIz/8xkleLt
        0c35PlP3c/mMwjFTOjKICJbIMg==
X-Google-Smtp-Source: ABdhPJxf17+/YxgQAbE/TSRufq++NTLpwlkrr6HcG5ZWLe4C60zjvMCj2EQOO6Z99OmnWn9WV/8HRA==
X-Received: by 2002:a05:620a:404f:b0:69f:1160:73e6 with SMTP id i15-20020a05620a404f00b0069f116073e6mr16720445qko.690.1651075256344;
        Wed, 27 Apr 2022 09:00:56 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:f617])
        by smtp.gmail.com with ESMTPSA id v67-20020a376146000000b0069ec181a0c6sm8304072qkb.10.2022.04.27.09.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 09:00:56 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH 0/5] zswap: cgroup accounting & control
Date:   Wed, 27 Apr 2022 12:00:11 -0400
Message-Id: <20220427160016.144237-1-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zswap backing memory is currently not tracked (and limited) on a
per-cgroup basis. As a result, workloads can escape their memory
containment and cause resource priority inversions on a shared host.
E.g. a lo-pri group fills the global zswap pool and forces a hi-pri
group out to disk.

Also, zswap doesn't benefit all workloads equally. Some even suffer
when memory contents compress poorly, and are better off going to disk
swap directly. On a host with mixed workloads, it's currently not
possible to enable zswap for one workload but not for the other.

This series implements missing cgroup awareness and control for zswap
to address both issues.

More details on interface and implementation in patch 5.

Patches 1-3 clean up related and adjacent options in Kconfig. Not
dependencies, just things I noticed during development.

Based on v5.18-rc4-mmots-2022-04-26-19-34-5-g5e1fdb02de7a.

 Documentation/admin-guide/cgroup-v2.rst |  21 ++
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
 11 files changed, 648 insertions(+), 342 deletions(-)


