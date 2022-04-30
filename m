Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB54515B9C
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 10:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237506AbiD3JCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 05:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231579AbiD3JCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 05:02:20 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72FDC1CFDA
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 01:58:59 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id a15-20020a17090ad80f00b001dc2e23ad84so451107pjv.4
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 01:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vrGWcSkCWGKydUFGKRCceiEF9kb4AnxKeN78L3HE5IY=;
        b=K2zqU2Bdnxe3Qas6KdIZ3fVBxp/YqTlYfsuYZ4xOQWyOGEkma53oNhpe/pA4xnHiI8
         3o/ZxqOxMQn1SuxFn9/YyFIysqJaI4EDEHd+i77MZ+u7dDMd9fmZLPAhVH03zqrTrM4c
         V5Feh3vcqCEQWr/BZqDZdDUQJNwYdA6wFqGsE0k5m2MNY92giBG4rgWoM6SeLJ7Mj+ES
         caiBlupi6h8z+in1vCE+nbxbEnD01mbGSDuQ+y9iOVDTMTGGncKhaAqVbIGKoAtM4MMh
         wkvR7aBavwRMzHCr17rOKsLafJIgU+ykrnhFKo52T4Ou0K027qg8yLbrV9ZYbMwj9ONW
         MSTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vrGWcSkCWGKydUFGKRCceiEF9kb4AnxKeN78L3HE5IY=;
        b=lSG3p7pXxgsqvlonahe/typmqgoj12LXTMGQ3bvmPV5oNKwVcIHKVHi7B3wWD9LVtG
         wD0WQZ/UC6831jbsPgu1QxIZHNsS2uwFLCuL3K6STDT/uJDrlZKOmnu4WOLIDK30iPTY
         nx7d8VYJ2Rmo5Qbvi7800AyNPiDcuYC8jDMJ612LL9o6xC38ATQNMuKPEYeDGehDKWsn
         M/+Q3NvqFMxvf00tPjECokRjPv7AUCY+Vt7WOVdD+kUTrbFO4BpShXnKhmyF71mK9VlW
         E7yQkEXWR3Ctq45gXNiRfvK6O0Lwdnq/U1xLDu0KcoKG3f/sO0X/jdsWXht6QwNxRuvM
         4VvQ==
X-Gm-Message-State: AOAM532EOrhd9I3SYKf+XB4sHC3Z7dHAL5NkFPuV3y3FcnHNmtlVfnP9
        Z8p8G9rDJ+JiGY31sLg+dUX5yQ==
X-Google-Smtp-Source: ABdhPJwTQ3p8kZD1B3X2ICD6xViFTKuEBLQQ3p6J01stdV9tl58vy7fHSPeQ7O2DVFJLRd6O6c5HIQ==
X-Received: by 2002:a17:90b:17ca:b0:1d9:a666:b02c with SMTP id me10-20020a17090b17ca00b001d9a666b02cmr3288513pjb.219.1651309139046;
        Sat, 30 Apr 2022 01:58:59 -0700 (PDT)
Received: from localhost.localdomain ([240e:390:e65:5bb0:6169:3d99:b5ff:4a84])
        by smtp.gmail.com with ESMTPSA id c14-20020a62e80e000000b0050dc76281desm1026782pfi.184.2022.04.30.01.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Apr 2022 01:58:58 -0700 (PDT)
From:   Hao Jia <jiahao.os@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org, Hao Jia <jiahao.os@bytedance.com>
Subject: [PATCH v4 0/2] sched/core: Avoid obvious double update_rq_clock warning
Date:   Sat, 30 Apr 2022 16:58:41 +0800
Message-Id: <20220430085843.62939-1-jiahao.os@bytedance.com>
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

v3->v4:
   - Modify some code formats and commit messages.
   - Add Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com> for
     patch 1.
   - Add Reviewed-by: Daniel Bristot de Oliveira <bristot@redhat.com>
     for patch 2.

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
[v3] https://lore.kernel.org/all/20220427080014.18483-1-jiahao.os@bytedance.com/

Hao Jia (2):
  sched/core: Avoid obvious double update_rq_clock warning
  sched/deadline: Remove superfluous rq clock update in push_dl_task()

 kernel/sched/core.c     |  6 +++---
 kernel/sched/deadline.c | 13 ++++---------
 kernel/sched/rt.c       |  5 +++--
 kernel/sched/sched.h    | 28 ++++++++++++++++++++++++----
 4 files changed, 34 insertions(+), 18 deletions(-)

-- 
2.32.0

