Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ACB05AFB56
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 06:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbiIGEgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 00:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiIGEf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 00:35:57 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9713A83F1B
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 21:35:56 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id oo12-20020a17090b1c8c00b001faa0b549caso10446645pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 21:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date;
        bh=ARY6z7c/YNSdIuDysr3yMfPrF2u31pVSHbSH5GcWfeE=;
        b=q9iz05jUj6H8xeR7Sm+d7zjR+v2lZM1+/kobuusBNoE0JoCXsnK5bvzGtwyNvIi+8U
         GH0rPOO/xKYtM5rIULeimIKEZZVJeN/gEjimKq/+hEkeS7sgv9BRF1RCpPU7KRJNQYSM
         /IzUDL95+VcFL2q0Hl1EA+8A4hiMO8I4UOYJkfJk31lHrFMFpY3kU6ZhV5p0RvFXs2Fc
         UlZLfi/vZLQbZVH2VXXNbSO7/GoY43Xu+6nJQn00xcfl2xayw4LodDd3F6zHSD8U1xOT
         jmaT8lo9ciYyboax/cu4Uy4QhBL7yP5SMSve8KtYnM2oG0G9+Ws+S3Z7uRssba6RB5BT
         8dcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=ARY6z7c/YNSdIuDysr3yMfPrF2u31pVSHbSH5GcWfeE=;
        b=0iu8EkHeQ3rn661wAL3sDRDtpHI1YjsH5Gbt0pQ1vWkmmuqHIuaJgp6+6/GoBrLset
         V2EXEgbUg3qljsQcBeN9CvBTah1L8LVz2cKA15UkZzwedO4r8KlQWARkOq5C3MMnNEZm
         QM0MU23eX6cHisNp4EKTj0Ab2iNqjNUam7369VhFr3edmsENn/T9XIMucg5EiJDhQiCW
         yCMG9apuNr8IAm7qqSskuJzvylnL1wwbi4SSYl+wDjNUd3G59YRWNy2PXYEYYZ3JzoqE
         7b23chu+mUl5uq03OeUv1u34ci55BMbnbq9S+V5dAZCK6kwqz6RwgYFdYnDHawqFr0gf
         11LQ==
X-Gm-Message-State: ACgBeo1NFI9Q0b0VjVNyHtzrJJKBetU+wq+ro8ZiFN8GEk1yNfIaUsmb
        0HJi9+n4NTZZRnk7X9b/wQ6jrEfDliTobw==
X-Google-Smtp-Source: AA6agR4RN/+AWtypu7tKu3vEW1cNt2tGz6dzgwmT/rIEWRZ6fGu1/x0neVk1AwsgO1V3Ikni4DvzdVJzEwX3Vg==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:262e])
 (user=shakeelb job=sendgmr) by 2002:a63:525a:0:b0:42b:28a9:8a34 with SMTP id
 s26-20020a63525a000000b0042b28a98a34mr1724012pgl.269.1662525356139; Tue, 06
 Sep 2022 21:35:56 -0700 (PDT)
Date:   Wed,  7 Sep 2022 04:35:34 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220907043537.3457014-1-shakeelb@google.com>
Subject: [PATCH 0/3] memcg: reduce memory overhead of memory cgroups
From:   Shakeel Butt <shakeelb@google.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <songmuchun@bytedance.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Shakeel Butt <shakeelb@google.com>
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

Currently a lot of memory is wasted to maintain the vmevents for memory
cgroups as we have multiple arrays of size NR_VM_EVENT_ITEMS which can
be as large as 110. However memcg code uses small portion of those
entries. This patch series eliminate this overhead by removing the
unneeded vmevent entries from memory cgroup data structures.

Shakeel Butt (3):
  memcg: extract memcg_vmstats from struct mem_cgroup
  memcg: rearrange code
  memcg: reduce size of memcg vmstats structures

 include/linux/memcontrol.h |  37 +---------
 mm/memcontrol.c            | 145 ++++++++++++++++++++++++++++---------
 2 files changed, 113 insertions(+), 69 deletions(-)

-- 
2.37.2.789.g6183377224-goog

