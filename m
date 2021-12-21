Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC6347BD23
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 10:47:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236542AbhLUJrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 04:47:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236538AbhLUJrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 04:47:18 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 779C3C061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 01:47:18 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id c4so25689323wrd.9
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 01:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=gnb5xXTow6QOQxr546IJxnYGdzln0ObDHEG7LPQA7DQ=;
        b=OJWO/HC+qStbfbAkBxRMuF8vTG781NR0zJTJ1GbfZHq+aLDAkXq/vsEWPj2baGlBbF
         HpMPsXY7jNwroukWwYxuAqETWVn3B7p8e5YIza6TsZrv+iclVNkP5UFoIPtRh7cIUE5i
         wBl04jGtsEZ3EvkWOFaxoDxV6nYUmv62YF9+YQqrILUxJTAIsKgJneLd1LCa/cLZNtc0
         iYqt4Vd3utYKdnidIYo+KkdN4inxLBAkp/j2kdRr5KH/H0S+grmrFNMboUlvegMmJ2SJ
         hiBKb9o37Xez/F1xJzfXZ2d3Pz1vwzLl+mFX+UBigFsRScuTHSHSSLOrtCwkderKhxRy
         80sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gnb5xXTow6QOQxr546IJxnYGdzln0ObDHEG7LPQA7DQ=;
        b=IZexTlJLHF4LWoCUxUjsiFHbzEYZ1Zi1KYcr8w9a8xahuXVpHUKXsCxdMHc8M4oTtx
         JMdxyHjdkc9ub0gYUZHvd6bd3Y30RDwR1Y+BQ3+ZnsL74IZjB9uGIonKQu8Re9IPMoAz
         kzxJsQUEuVQFwAyxTFekZ2hkkqmqy4PkilC8Dxpw6J716qvwTvPhn4kGotOlv9MgFate
         FWjE8EKXAgDHB1vvBja5tmOtPJs0zPf2oZ3Hj18dIgvME9Dlhp8QTJkBzTlLHYZbMsDD
         HeopdilByi79Au8YqL6YWUufWhiukdCm413v7tgsjw9Yz/JjNCpxbaNUtuppYdz/VSE6
         GSCA==
X-Gm-Message-State: AOAM531g4RIkwSIHNa9dIdEfdE4wR9Hrrpg8KMuNbdxqsD48hhmVZnvA
        GGFVylksALwk5tnUhePYze31NEXoRbxuUQ==
X-Google-Smtp-Source: ABdhPJw3yf3mlNcfvlDfWg4gLjXSP3PFKQ2aK2UvR+VKHmogmW7IIB6ozC7IbRrG+JvtAcsrX9rShA==
X-Received: by 2002:adf:fb06:: with SMTP id c6mr1871341wrr.625.1640080036969;
        Tue, 21 Dec 2021 01:47:16 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:d88d:8149:7104:fe7f])
        by smtp.gmail.com with ESMTPSA id l36sm2094926wms.16.2021.12.21.01.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 01:47:16 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org,
        rickyiu@google.com, odin@uged.al
Cc:     sachinp@linux.vnet.ibm.com, naresh.kamboju@linaro.org,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 0/3] sched/pelt: Don't sync hardly *_sum with *_avg
Date:   Tue, 21 Dec 2021 10:46:50 +0100
Message-Id: <20211221094653.10776-1-vincent.guittot@linaro.org>
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

Vincent Guittot (3):
  sched/pelt: Don't sync hardly util_sum with uti_avg
  sched/pelt: Don't sync hardly runnable_sum with runnable_avg
  sched/pelt: Don't sync hardly runnable_sum with runnable_avg

 kernel/sched/fair.c | 113 +++++++++++++++++++++++++++++---------------
 1 file changed, 75 insertions(+), 38 deletions(-)

-- 
2.17.1

