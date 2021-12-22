Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1AAC47CF69
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 10:38:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243984AbhLVJiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 04:38:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbhLVJiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 04:38:08 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25AD5C061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 01:38:08 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id r17so3670403wrc.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 01:38:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=YlU2ackM6giw8VPdrM+qe3wXVGgYdL9B735ic8Aj79s=;
        b=fiDkBK5ALlOebvL8k1kzvEMZ0i6gq8pIz7Pi4fkCpgLXs8+xxCCBLy2v5Sdyd5FfCi
         RHo0tki1/QtNi7gLojvi2y+MJ3apxCBYHy5zdC0CjgUdrp7qYYbVkx8HK9VXWfTX5+Jz
         Dc9SY2WFXQ/0bJ7KJqnxqoEpTzMc4HRHJJOOVy6kRg6M5LGZO+COY1mzX3xiTLfEx9bV
         EJejvGvJrj3Y9E6QAN3Uvk5JhdDKgztPtN4ZbbrGNzgYWbw5+x8bQBemwHg6TKhjM1bk
         Bc7XZDnGgZ98OVdZ5OOuK1c1d5mmd2lp6QWAyvErueGldOUxN/1NwWlwMF4BFea3Lodc
         rGdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=YlU2ackM6giw8VPdrM+qe3wXVGgYdL9B735ic8Aj79s=;
        b=uwpcjE7N/i2fDjxmy0HYctyV8K4rkQJooLcuzvvGmdi7t6cgTLGfImre7qKcl13Z6B
         y5eOdowwbQtFwxM/sLiPoPOOmcLcuKWx4czSqPcIm/CEBk+cqv8r6bO7Ivf8aXnFM8su
         0wBFBQLS6RHt6n1LvXV6vLqk8G30912vCH5YFCFUFsgGUixG6uDWtMfjDClW1A+p6bww
         pL2QI5nNIS7676Mlgw2nKIAzS6Pkoa9hYrtJ3RBvdJj37Ig0gZiJyIADiS1UKb7CB7+8
         iLTfBbcHzwV9K2FJTHXPvLEPMqlbosjpyRbj7PhjHKVIxcA1FMbwGjQzXw03GMMlEafl
         Jl2g==
X-Gm-Message-State: AOAM531mQDApDHAcC8MSZoLT8WjCFvPAtS4K9CQWnTk0RkODyoznTwt8
        zn52T9rNc8IlaBf7rPRSiJr01w==
X-Google-Smtp-Source: ABdhPJy4o5jW8tX/BRVxpC+cyVdOyWh1f1ItFIR7/ortL9hp0oaOAodT3ZSWU27J0Equ2yrDIpkxVw==
X-Received: by 2002:adf:ec85:: with SMTP id z5mr1518747wrn.568.1640165886667;
        Wed, 22 Dec 2021 01:38:06 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:917b:d0f8:bb57:d63b])
        by smtp.gmail.com with ESMTPSA id u19sm1253430wmq.30.2021.12.22.01.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 01:38:05 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org,
        rickyiu@google.com, odin@uged.al
Cc:     sachinp@linux.vnet.ibm.com, naresh.kamboju@linaro.org,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v2 0/3] sched/pelt: Don't sync hardly *_sum with *_avg
Date:   Wed, 22 Dec 2021 10:37:59 +0100
Message-Id: <20211222093802.22357-1-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rick reported performance regressions in bugzilla because of cpu
frequency being lower than before:
    https://bugzilla.kernel.org/show_bug.cgi?id=215045

He bisected the problem to:
commit 1c35b07e6d39 ("sched/fair: Ensure _sum and _avg values stay consistent")

More details are available in commit message of patch 1.

This patchset reverts the commit above and adds several checks when
propagating the changes in the hierarchy to make sure that we still have
coherent util_avg and util_sum.

Dietmar found a simple way to reproduce the WARN fixed by 
commit 1c35b07e6d39 ("sched/fair: Ensure _sum and _avg values stay consistent")
by looping on hackbench in several different sched group levels.

This patchset as run on the reproducer with success but it probably needs
more tests by people who faced the WARN before.

The changes done on util_sum have been also applied to runnable_sum and
load_sum which faces the same rounding problem although this has not been
reflected in measurable performance impact.

Changes for v2:
- fix wrong update of load_sum
- move a change from patch 3 to patch 2
- update patch 3 commit message

Vincent Guittot (3):
  sched/pelt: Don't sync hardly util_sum with uti_avg
  sched/pelt: Don't sync hardly runnable_sum with runnable_avg
  sched/pelt: Don't sync hardly load_sum with load_avg

 kernel/sched/fair.c | 113 +++++++++++++++++++++++++++++---------------
 1 file changed, 75 insertions(+), 38 deletions(-)

-- 
2.17.1

