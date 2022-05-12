Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5B985252B4
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 18:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355774AbiELQfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 12:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiELQfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 12:35:52 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 001911CFC7
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 09:35:50 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id m1so8025068wrb.8
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 09:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=TztKdwt72p/ktvB8bFE21AfQ364YewJi5ekDXEIKiBA=;
        b=LoixVsggEnoV+tzmOjSgpHZCEKKJy0GvEPRQ6rew2XEnhTcXCygenRNY6AQYTCNPIe
         FlWw9h3+SZRnGuUHvz3LTL9Yn2g8iptpzVivM3rsIdlME1xsUVoTX9L6X52y04ydaXK5
         h4mtdALhgdB+NSIGeVqAFu2UFXBrB9aoVwyTbew8pf3u83DqvHGuwvFH4QoGap4DrXnq
         1k0l906vQ7GKHmc9JELGGRB2eJFf+iy1vP51FLw21iPMQ9zqe+nX6ac9TDyWQUNy8qa+
         Dfv50dlFRq5JxLgOy84AzaHuCdHWL0qP7dxbVvDRQmdyjQN8TRgQCKKldVGdSRL4gbyf
         ug4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TztKdwt72p/ktvB8bFE21AfQ364YewJi5ekDXEIKiBA=;
        b=bXZlMZ4uCtM03U9IB+l5tqMZFJHtK48sXRaoapF5IMWLCdmzUhpcVADQl3KMJlKa3e
         Q804ncxa0QD+cexf8NZYqlis7IqhCj40ojdH9vp+/Dnhr2VrDDqimpnx1FeKXOmKNDPa
         kye83BsjXKLAg2BxD5A0h1lg6K4PDoPTMrdgQ3/nOCVM12/qJaPGJnkQljr6qnc9EBAv
         k6OreH/DaWj5B4V83hAmdwcqV/uu1Yw8PZm6o0OIHkcfAoUp70EoW0Xb3uT3TYKb2PVl
         JrlSAHu5z1PWwaJxn7pz3NJ47eu5zToaLabP4YhkFYYK48cwi1kxhI9Iz16o2tcBSKWN
         eYHA==
X-Gm-Message-State: AOAM530ErvIRkS84dyzrFaanDSI4M07WwV7G75pHpyfXVXEovjQc+3nC
        bQg9DvwjSfFk+6vs0a6Co+nhEQ==
X-Google-Smtp-Source: ABdhPJxAlano3z0DwlFo3K3NBpEwggW0Sh0hmnxgtgxyZxZ35sJDDvTChAh66nMOIsk8qt9AvCuMyQ==
X-Received: by 2002:a05:6000:1d93:b0:20c:58f8:f530 with SMTP id bk19-20020a0560001d9300b0020c58f8f530mr459983wrb.254.1652373349448;
        Thu, 12 May 2022 09:35:49 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:253e:ae0a:544b:2cb1])
        by smtp.gmail.com with ESMTPSA id j25-20020adfa799000000b0020c5253d8dbsm21814wrc.39.2022.05.12.09.35.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 09:35:48 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, parth@linux.ibm.com
Cc:     qais.yousef@arm.com, chris.hyser@oracle.com,
        valentin.schneider@arm.com, patrick.bellasi@matbug.net,
        David.Laight@aculab.com, pjt@google.com, pavel@ucw.cz,
        tj@kernel.org, qperret@google.com, tim.c.chen@linux.intel.com,
        joshdon@google.com, Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v2 0/7]  Add latency_nice priority
Date:   Thu, 12 May 2022 18:35:27 +0200
Message-Id: <20220512163534.2572-1-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset restarts the work about adding a latency nice priority to
describe the latency tolerance of cfs tasks.

The patches [1-4] have been done by Parth:
https://lore.kernel.org/lkml/20200228090755.22829-1-parth@linux.ibm.com/

I have just rebased and moved the set of latency priority outside the
priority update. I have removed the reviewed tag because the patches
are 2 years old.

The patches [5-7] use latency nice priority to decide if a cfs task can
preempt the current running task. Patch 5 gives some tests results with
cyclictests and hackbench to highlight the benefit of latency nice
priority for short interactive task or long intensive tasks.


Change since v1:
- fix typo
- move some codes in the right patch to make bisect happy
- simplify and fixed how the weight is computed
- added support of sched core patch 7

Parth Shah (4):
  sched: Introduce latency-nice as a per-task attribute
  sched/core: Propagate parent task's latency requirements to the child
    task
  sched: Allow sched_{get,set}attr to change latency_nice of the task
  sched/core: Add permission checks for setting the latency_nice value

Vincent Guittot (3):
  sched/fair: Take into account latency nice at wakeup
  sched/fair: Add sched group latency support
  sched/core: support latency nice with sched core

 include/linux/sched.h            |   3 +
 include/uapi/linux/sched.h       |   4 +-
 include/uapi/linux/sched/types.h |  19 ++++++
 init/init_task.c                 |   1 +
 kernel/sched/core.c              |  90 ++++++++++++++++++++++++++
 kernel/sched/debug.c             |   1 +
 kernel/sched/fair.c              | 105 ++++++++++++++++++++++++++++++-
 kernel/sched/sched.h             |  34 ++++++++++
 tools/include/uapi/linux/sched.h |   4 +-
 9 files changed, 257 insertions(+), 4 deletions(-)

-- 
2.17.1

