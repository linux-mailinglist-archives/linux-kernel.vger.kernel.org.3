Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD7550E914
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 21:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244817AbiDYTES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 15:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244789AbiDYTEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 15:04:02 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C806DB1A85
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 12:00:50 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id g23-20020aa78197000000b0050adbdbbec8so9019156pfi.23
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 12:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=u7aSCooaSdm5AbeQgc4mEIZKOx9WN8oAB22VArgUr9o=;
        b=SuyUCmC+8fnn1/O7RvexP4Bun5cSxBx1sd6O/1H7oKjQcRlUzBc7Bt5knel7INSyCT
         TE/6ByM9b+hsj1G0tr2mL+zLSAwDzapaydUgTsEV402eJbk6MFsRXuR2Zs7wSIl1kB3L
         kM1IJRVsDfkrGPtIyCOk2w0Dcm2Ui7PibJAyNe5F2X4o2o3XViG/Mb3Gb5qUL3O65dss
         oa10bPUcqXV571PY4lkn6ZsjfPx4Gr5+vTIcS9Ja1j6OtRizQTClkmTwHXynPTok2zix
         xUXMgzdz/Su53W1QXZRAn/l8NCJFbP5egoirBvhNqKzR/LvG2ktSdhYieYmOtOJnaE5h
         N+Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=u7aSCooaSdm5AbeQgc4mEIZKOx9WN8oAB22VArgUr9o=;
        b=sTmsCJ5lhKg/6WeWD0GLLNDcbnepdTXalMRuSG6ExZ26dCEnsnLpNZosCk4rNYFtL8
         6OXu5xhEjMF8YhwIgzPPGRMBdEpj5Zxe8ftFn7JzfpWebPDRo15r1qKk0GBG1g2JVJYn
         q85VlRVHlexjApuYoB5W7f5r5oPl3HuAQreds4T2EzL9Aa3RvK5+yOWu14fv+oHHlmk/
         S4c4PsmZyTn62ibxmLtebmY9y6HZHMf90u1Y8BnOO2lY4Lon3zyfzgIRrLqnsQ5RjZnt
         vWelryrX8UQgvWkg/gI5jY5F0fjve33wYBJyU4qh+Cq+jv9BdeVL5Xdfqg+ypt2bA5Pn
         Mjhw==
X-Gm-Message-State: AOAM533zKcKDS2ttYEx+InDLetFN9PMNgmVTLxFcxPiTUvW8fO0IxgmB
        Yh1SrGj0yBKi3n0HGAnNLumoEQECTHOSu61h
X-Google-Smtp-Source: ABdhPJyC6Btrh9g9zSX3rXPfqbFSX9w9P0umwQPU2xZn6+TTPWH6+X7xS5z3iAFd4B9xmvUavECuvuXybuhg3bvR
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a17:90a:bb8f:b0:1d9:650e:10f5 with SMTP
 id v15-20020a17090abb8f00b001d9650e10f5mr8800254pjr.148.1650913250098; Mon,
 25 Apr 2022 12:00:50 -0700 (PDT)
Date:   Mon, 25 Apr 2022 19:00:36 +0000
Message-Id: <20220425190040.2475377-1-yosryahmed@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
Subject: [PATCH v5 0/4] memcg: introduce per-memcg proactive reclaim
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>
Cc:     David Rientjes <rientjes@google.com>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>,
        Chen Wandun <chenwandun@huawei.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        "=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>,
        Tim Chen <tim.c.chen@linux.intel.com>, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Yosry Ahmed <yosryahmed@google.com>
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

This patch series adds a memory.reclaim proactive reclaim interface.
The rationale behind the interface and how it works are in the first
patch.

---

Changes in V5:
- Fixed comment formating and added Co-developed-by in patch 1.
- Modified selftest to work if swap is enabled or not, and retry
  multiple times to wait for background allocation before failing
  with a clear message.

Changes in V4:
mm/memcontrol.c:
- Return -EINTR on signal_pending().
- On the final retry, drain percpu lru caches hoping that it might
  introduce some evictable pages for reclaim.
- Simplified the retry loop as suggested by Dan Schatzberg.

selftests:
- Always return -errno on failure from cg_write() (whether open() or
  write() fail), also update cg_read() and read_text() to return -errno
  as well for consistency. Also make sure to correctly check that the
  whole buffer was written in cg_write().
- Added a maximum number of retries for the reclaim selftest.

Changes in V3:
- Fix cg_write() (in patch 2) to properly return -1 if open() fails
  and not fail if len == errno.
- Remove debug printf() in patch 3.

Changes in V2:
- Add the interface to root as well.
- Added a selftest.
- Documented the interface as a nested-keyed interface, which makes
  adding optional arguments in the future easier (see doc updates in the
  first patch).
- Modified the commit message to reflect changes and added a timeout
  argument as a suggested possible extension
- Return -EAGAIN if the kernel fails to reclaim the full requested
  amount.

---

Shakeel Butt (1):
  memcg: introduce per-memcg reclaim interface

Yosry Ahmed (3):
  selftests: cgroup: return -errno from cg_read()/cg_write() on failure
  selftests: cgroup: fix alloc_anon_noexit() instantly freeing memory
  selftests: cgroup: add a selftest for memory.reclaim

 Documentation/admin-guide/cgroup-v2.rst       |  21 ++++
 mm/memcontrol.c                               |  45 +++++++
 tools/testing/selftests/cgroup/cgroup_util.c  |  44 +++----
 .../selftests/cgroup/test_memcontrol.c        | 114 +++++++++++++++++-
 4 files changed, 197 insertions(+), 27 deletions(-)

-- 
2.36.0.rc2.479.g8af0fa9b8e-goog

