Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3704511320
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 10:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359230AbiD0IDl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 04:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359225AbiD0IDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 04:03:36 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62DEB641C
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 01:00:25 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id a15so920009pfv.11
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 01:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V8j+ApuhrVcYnVlPobN1VewHu/EF7NxDXwY1ULnuq08=;
        b=4a6o9kmLcL/jkiy0Jg/MgTc0lYxm4t3iRJ4AnDL1xOyQ3rd323oW1Z/8MCW2/lopNN
         ubh+4T3AH/xBgBka1C8MWM99p6m/Ro2yVDloX4o9kDPaYHnPtq+L1TFxBwZoz5EuLgmj
         BG25nxSCEBXu4qGY/Uvm6lvldWGcdfcRciJxAM/tWa11jfBOyjfw3iUFlA00DPsRHJeA
         bwCzsN2gR0bnCZf3FH8dgCpcLvVJm5g+fJqV5HB6VnA5/UnvaXxfXssAxXkG29YtyLZP
         6ijEkZa1k+bJTH0P01fxbFBcc1zkK/B21B8qdfgVPCifj622mYoR+O9jWRKagoKfJV9v
         xeuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V8j+ApuhrVcYnVlPobN1VewHu/EF7NxDXwY1ULnuq08=;
        b=5Opy15X53qXTDPvi4GcBPbTlXWd5uXJVC7SVEc8bHhSWSvxYOqSpfPAPwOKF66BZip
         1yWJTc6hWqqcdUx8h0xPNsLS3LglvACP/etzG0aERQL1bo/Ym0PJBJUoUVz8UAmFNkaO
         pb+G+y+gx48EywWhWOpQDKN78HRxMoYoiFv5WUZ9vy6Exi0fX+Kt5enqlE8UUNpuP3UQ
         +lc2ue/69NRXLM4Tym61FMIwGAfCX4Ax5+fX+ujP/piLAji470x1qpoClzp3kW3Gd9U1
         p877QHOzQfe9PQZ2boFQ8T/y3Y7qU0aE4f51oBpPepC0RNpNJbPgHEJZHjNELiN+rvE0
         i2hQ==
X-Gm-Message-State: AOAM531rgymiKDjYSKlMe0QWqcXZ/YlL0LHsMWBe2nkKnNPMu/utOwrf
        eBRzXLswglMbaEXwNPJ4vQ6LUg==
X-Google-Smtp-Source: ABdhPJwkP8dxg3zWSP/QVX6XlVfucrKTcAWmK07qxgtcKrioyg9njcYnBc7mvd7Jq2Rdxju7lBtT/g==
X-Received: by 2002:a63:8b4a:0:b0:3ab:255c:ff8e with SMTP id j71-20020a638b4a000000b003ab255cff8emr13031330pge.285.1651046424899;
        Wed, 27 Apr 2022 01:00:24 -0700 (PDT)
Received: from localhost.localdomain ([240e:390:e6b:6b80:9d6d:7735:8291:b65d])
        by smtp.gmail.com with ESMTPSA id u2-20020a62d442000000b0050d404f837fsm9543380pfl.156.2022.04.27.01.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 01:00:23 -0700 (PDT)
From:   Hao Jia <jiahao.os@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org, Hao Jia <jiahao.os@bytedance.com>
Subject: [PATCH v3 0/2] sched/core: Avoid obvious double update_rq_clock warning
Date:   Wed, 27 Apr 2022 16:00:12 +0800
Message-Id: <20220427080014.18483-1-jiahao.os@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
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

These two patches are about the kernel scheduler:

patch 1: fixed the issue that kernel may trigger WARN_DOUBLE_CLOCK warning.
patch 2: removed some no longer needed comments in the deadline scheduler
and cleaned up the code.

Thanks for suggestion from Dietmar Eggemann & Peter Zijlstra.

v2->v3:
   - Modify some descriptions and errors in the commit information.
   - Fixed a bug that might trigger the WARN_DOUBLE_CLOCK warning in
     migrate_task_rq_dl().
   - Add Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com> for
     patch 2.

v1->v2:
   - Added double_rq_clock_clear_update inline helper to clear RQCF_UPDATED
     of rq->clock_update_flags.
   - split into two separate patches.

[v1] https://lore.kernel.org/lkml/20220418090929.54005-1-jiahao.os@bytedance.com/
[v2] https://lore.kernel.org/lkml/20220422090944.52618-1-jiahao.os@bytedance.com/

Hao Jia (2):
  sched/core: Avoid obvious double update_rq_clock warning
  sched/deadline: Remove superfluous rq clock update in push_dl_task()

 kernel/sched/core.c     |  6 +++---
 kernel/sched/deadline.c | 13 ++++---------
 kernel/sched/rt.c       |  5 +++--
 kernel/sched/sched.h    | 31 +++++++++++++++++++++++++++----
 4 files changed, 37 insertions(+), 18 deletions(-)

-- 
2.32.0

