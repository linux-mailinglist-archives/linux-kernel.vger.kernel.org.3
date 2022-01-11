Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 489FB48AECB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 14:47:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241015AbiAKNrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 08:47:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241007AbiAKNrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 08:47:12 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A815C06173F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 05:47:12 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id e5so11062903wmq.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 05:47:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=V4Ho2IGZqdwoGMLvVsdbX6aJWa5uUyOQYVyaaJ3Cu3A=;
        b=Y8pBngNL3RVTpt6ySKbEGjfxwfDwX5TRfmIkGODc0Adjwx6WF36hvDc2dLcL8O/9Eh
         ygt8DWoVNwHOD8p9vzB2x+DWz3lPpxMhJzPuxtggsLtUc+pqfNAzSWChHvN30ifTglAe
         qqsTALhmM7R+qElP426WOnmgqAcWNCbtwyGhFvYJpzdvfEDuGYnIRzKssr06/DKdb/pZ
         0nKOZQOtmEGqEn2U2ym8/f1qiGGt+K8ztTjY9m84d3HeA4J+qRKKkqz4CfTTuXK9t7RF
         BJmJ1B6+PcoSFW9GTJcypzRHDQYZXGjw7bPn5VokxZ5pq63p+rm3/bJJrx69ZEGXO0PV
         JaBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=V4Ho2IGZqdwoGMLvVsdbX6aJWa5uUyOQYVyaaJ3Cu3A=;
        b=FQP6vF5x5R2G+/Z+MPe33rVkpDNuW3So78IQScR048qRoj9Az+68iR4rU2VO/bL2Uu
         fOmJqky1Edkx0Ls2o01/ZIhPL7JOIOBJwsigY5uNELLFutdI0oz8WRZ7XXBTZ6xTLiRv
         yb1rLO06oqY5f1hAaZ1zQ6vzitt7H3+HfPJp0pokZiW4Ej1x3gsKrEuBFA2BC9Jl5q7l
         iy5NfK7Z33uF5fm1I0A/OPP3ArJQIPp7x3ndj83wul4gQJ687MfbcE3Z9mstGUgajRmM
         qvGgWc6lg0Tg7+x6+r5BP2TaCakZKyZHb06HY8IYxpa43TSUmyqQHvxTn9RrT5BeKE4I
         Mm9Q==
X-Gm-Message-State: AOAM5330XdLEcUu0tr2Snz7cjGQA7ttNo7mjJoZXPLlRDrJartNRNksv
        24OuOrCJDkZT4ygXbEtXSRm5VQ==
X-Google-Smtp-Source: ABdhPJz4VnDxBysmfgadlrJfN1QJJpAN7dF733aeL7CaJ0TZUhZhzxmZP9158C6uzDrG7nGBD4k46g==
X-Received: by 2002:a1c:7517:: with SMTP id o23mr2564044wmc.120.1641908830813;
        Tue, 11 Jan 2022 05:47:10 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:44fe:4c24:d946:283b])
        by smtp.gmail.com with ESMTPSA id az1sm9618411wrb.104.2022.01.11.05.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 05:47:10 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org,
        rickyiu@google.com, odin@uged.al
Cc:     sachinp@linux.vnet.ibm.com, naresh.kamboju@linaro.org,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v3 0/4]   sched/pelt: Relax the sync of *_sum with *_avg
Date:   Tue, 11 Jan 2022 14:46:55 +0100
Message-Id: <20220111134659.24961-1-vincent.guittot@linaro.org>
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

Changes for v3:
- split patch 1 in 2 patches
  - One to fix rick's regression
  - One to apply same changes in other places
- some typos
- move main comment so it appears in the 1st patch 

Changes for v2:
- fix wrong update of load_sum
- move a change from patch 3 to patch 2
- update patch 3 commit message

Vincent Guittot (4):
  sched/pelt: Relax the sync of util_sum with util_avg
  sched/pelt: Continue to relax the sync of util_sum with util_avg
  sched/pelt: Relax the sync of runnable_sum with runnable_avg
  sched/pelt: Relax the sync of load_sum with load_avg

 kernel/sched/fair.c | 113 +++++++++++++++++++++++++++++---------------
 1 file changed, 75 insertions(+), 38 deletions(-)

-- 
2.17.1

