Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB82A4D107F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 07:51:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245045AbiCHGwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 01:52:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240464AbiCHGwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 01:52:36 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 695A5220E4
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 22:51:40 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id kx6-20020a17090b228600b001bf859159bfso1407114pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 22:51:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ya8GdI9h8mc3o2xzRLAoSDdlC9J4RJbrqfbMxm2klR8=;
        b=JgBxD1dPJwwraX84O2EIyIXUmrj4Dmfs+6GuibXK1ncjgar54BUuBtAWDYkBH0285I
         lBz5sbRO/CzCk1VKqieoYDpyzxJpiihf+RryW0IcnakLTxHfYR02z2yGZugCuCFsndYd
         oqthi3KcLf8c3S4ZNy7v6jsJoxLO+AfgjRDK7G79XygW+5RzjrwdKh1X85DBb6lL5m+F
         xvPRcvTcMHojoTcI+LuvJx+YOUJqzPsxSyNAIeg75gAWverDVmEuG4HnTo9DRxxDbHp0
         4hdXZmyMbwoUYb9B40b6Tqq3aYJY4A3XxRE3uDxYWLb3vHyFUGXFg878Ei7JCLQ3oFFj
         JRvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ya8GdI9h8mc3o2xzRLAoSDdlC9J4RJbrqfbMxm2klR8=;
        b=itCuC6kVpIiVfdrmytJLkIWKDqNtEXoRggJqmf7SPFpQF0YEKbvBCOHTX/6vqGTlfs
         kv31YTNBQPssxSlDqiuAKPHwjH1DMiOvgOawVexBaMzGN6LklkMKK3jRsA9rz8hrM51O
         b+8LUTOFAShMGqFko2BM40vxu2Q8lYk77sm4J3Luh7ruwiuNdNSdukQcfaV8bmZU4O1T
         uQFoRS6+RSIoUs0LJ5IPehay7JWREw4TltxxlmP+tJK0/Y+pGVy+Sbtbp+Bt7h/BR4lP
         BMHu/cpyN+t9lsfMKgCSuuqw9FANY5Nj9inMwdsLyNRVidBtsbxkKQs/lL1m8q1ANQLt
         xS0A==
X-Gm-Message-State: AOAM533/QCyRG5G8jRq3GmbT4Kps9kcGf9FnX8si6dvDbzq9z79feWgX
        ehrh61wCjK1H3QE0NJy/Yv8=
X-Google-Smtp-Source: ABdhPJzPY/uKsDsNdaMgpqE1gitsaFf9Qcn2eTBstnVWYYmnTY/QfUPcaySI1/zwfnlTTWdKgBB+CQ==
X-Received: by 2002:a17:902:e811:b0:151:f486:a32f with SMTP id u17-20020a170902e81100b00151f486a32fmr5996878plg.141.1646722299937;
        Mon, 07 Mar 2022 22:51:39 -0800 (PST)
Received: from mi.xiaomi.com ([43.224.245.250])
        by smtp.gmail.com with ESMTPSA id 17-20020a056a00071100b004f0f941d1e8sm17166446pfl.24.2022.03.07.22.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 22:51:39 -0800 (PST)
From:   Jian Wen <wenjianhn@gmail.com>
X-Google-Original-From: Jian Wen <wenjian1@xiaomi.com>
To:     peterz@infradead.org
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        Jian Wen <wenjian1@xiaomi.com>
Subject: [PATCH 0/2] fix schedstats for idle kthreads
Date:   Tue,  8 Mar 2022 14:51:08 +0800
Message-Id: <20220308065110.636947-1-wenjian1@xiaomi.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Idle kthreads are sleeping instead of being blocked, since they are
not blocked at all.
This patch makes idle kthreads triggers the sched:sched_stat_sleep
event instead of sched:sched_stat_blocked.

Jian Wen (2):
  sched: explicitly distinguish between TASK_INTERRUPTIBLE and
    TASK_UNINTERRUPTIBLE
  sched: fix schedstats for idle kthreads

 kernel/sched/deadline.c | 5 ++---
 kernel/sched/fair.c     | 4 ++--
 kernel/sched/rt.c       | 5 ++---
 3 files changed, 6 insertions(+), 8 deletions(-)

-- 
2.25.1

