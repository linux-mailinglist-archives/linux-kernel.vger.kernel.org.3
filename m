Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE1F4F8B6E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 02:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232240AbiDGWow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 18:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232228AbiDGWou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 18:44:50 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE7CA152823
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 15:42:48 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id x3-20020a17090a6c0300b001cab7230b41so4264616pjj.9
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 15:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=6TC/fcsrdvkufWtZCTMpd2QTNgth1gYBFeUR7KMTO3o=;
        b=LTNa5mWxit+bHznZj3tr4HARnvMRLGMcNuJSn+VXMiSstVWYzjo8RrN+E1ms6VTeiU
         nFOM753PV0ux/FjpS7u2I8H53Ls+iBrNQ2VqMkJ4/013wYWzOkTOMvmPlfAViGmsT7JI
         wz5hfFfmebTV4K8w6FLtQJbWTKHCf1RVY3yK5HCK8UW5AxATe0Hhq4JXxY2zummMacbw
         7WdJ0FJA8Bcsx0SQlqs5lD1wWFqEVYOi93AQ+e8nhUdpDGM/3Zb7Qs408eH4czs6r98a
         v6ypkffmKqRINf6d0u5JEFrGrfWgcL+egNOTvvTXneQR/WkDoHb0cWVv6VuyGlMHSD9n
         t4YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=6TC/fcsrdvkufWtZCTMpd2QTNgth1gYBFeUR7KMTO3o=;
        b=MydfHOzytN45zYCyo3TgdPQL0i9S5DrPivGyskIXC3laQdjJpTRSNx2pkYR8N6U399
         2EPs58m+Yo6uvWhszRAhY2Xui6oVel1VujHvUb3+fWtdJ4wlt5d+la0kHP2xb82AF5OS
         x1LHZczMHIFIUbS3t8evBI10w9O4dHMLGcSA7FO81hlieH9uGxzIFY+6wnGwSI3Mz0x3
         Y9HE4SBQCmoJVfur8HkICtn3T/oj2HAE7urniuZzSny7qeIFQiuKC2WhW5KfONcyN9OF
         zKtdSifd61P2QcyceChoI1KfVF24pyargvXOXSw8kSubzZ5nGKN7l/FLm9G2mvuzGpcR
         x0Zw==
X-Gm-Message-State: AOAM532AE9i/Us0RFAXLi0WsT990qJ8NRMw1NHLBXL/7qiYdDpYzXLx6
        n0OaBoNIiEmTaiN8X8Um/no2npff4dP7EQC4
X-Google-Smtp-Source: ABdhPJwlNJ+NsHyswmzk8S8aUJPENy0C4JQyTzYFWx7UJ9STkknW1VVVp9zPNMHpVNXpn76wXS46DNMY8mlzVMZv
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a65:4b8f:0:b0:39c:c85d:7e7a with SMTP
 id t15-20020a654b8f000000b0039cc85d7e7amr4074145pgq.324.1649371368364; Thu,
 07 Apr 2022 15:42:48 -0700 (PDT)
Date:   Thu,  7 Apr 2022 22:42:40 +0000
Message-Id: <20220407224244.1374102-1-yosryahmed@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.1178.g4f1659d476-goog
Subject: [PATCH v2 0/4] memcg: introduce per-memcg proactive reclaim
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
        Vaibhav Jain <vaibhav@linux.ibm.com>, Huang@google.com,
        Ying <ying.huang@intel.com>,
        "=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>,
        Tim Chen <tim.c.chen@linux.intel.com>, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Yosry Ahmed <yosryahmed@google.com>
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

This patch series adds a memory.reclaim proactive reclaim interface.
The rationale behind the interface and how it works are in the first
patch.

---

Changes in V2:
- Add the interface to root as well.
- Added a selftest.
- Documented the interface as a nested-keyed interface, which makes
  adding optional arguments in the future easier (see doc updates in the
  first patch).
- Modified the commit message to reflect changes and add a timeout
  argument as a suggested possible extension
- Return -EAGAIN if the kernel fails to reclaim the full requested
  amount.

---

Shakeel Butt (1):
  memcg: introduce per-memcg reclaim interface

Yosry Ahmed (3):
  selftests: cgroup: return the errno of write() in cg_write() on
    failure
  selftests: cgroup: fix alloc_anon_noexit() instantly freeing memory
  selftests: cgroup: add a selftest for memory.reclaim

 Documentation/admin-guide/cgroup-v2.rst       | 21 +++++
 mm/memcontrol.c                               | 37 ++++++++
 tools/testing/selftests/cgroup/cgroup_util.c  | 11 ++-
 .../selftests/cgroup/test_memcontrol.c        | 94 ++++++++++++++++++-
 4 files changed, 156 insertions(+), 7 deletions(-)

-- 
2.35.1.1178.g4f1659d476-goog

