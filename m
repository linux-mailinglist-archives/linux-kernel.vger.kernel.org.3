Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E05558B7E7
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 21:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232479AbiHFTVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 15:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231543AbiHFTVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 15:21:17 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA43EDFAE
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 12:21:16 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id o22so7006416edc.10
        for <linux-kernel@vger.kernel.org>; Sat, 06 Aug 2022 12:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=IvpqiVM93kaLEdGHsKbOaagoigi2QS2lVi4vBRtwFwM=;
        b=kju+zoyF8aMauoVlb/IZeP8P1G+8El13hlduY6HY9vBD2EdzRAc+bEdKko5pVbLeaH
         sFWy2yP3A7/mtu8ZIqeXE44zs/IttARZZ7hPh9aYrINrVrAuo8IWFTrCSslby4IJpLMy
         wlZitDY+fRtIeV2xbzTtsOZyJloA+93LchxWMKR87bokFnSJGH52bjvhC9WkhBhmqOsX
         iis803iyOvUiJaZ908JkcfMcpgqLA72IEexo59LaJjvGEqmnDUDoCvpia2b7x8H7Q7FR
         CbxWDZgYgvdHteGCEgQ3XxeX52iGSqfZRdIq3A2Hz9x91h05M3Rhk9X2fRizQM1+BouN
         mZjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=IvpqiVM93kaLEdGHsKbOaagoigi2QS2lVi4vBRtwFwM=;
        b=NZ55uC0OwMT4esQfoSrthB3UFsbz/Dxn/4QeV5mX3gZllRZGkn9jot1NhTWmDp/WQ+
         iDRGkO2xvRrs0xEKIntSxZe4phAWRbJbp6zk1UYEriKP6QzZ7rcfi21VJIvR5uXcj2Nt
         S/vAsFNu+qveoGP1oTGsK298CXPRFtI5myspfNqFU4uphDtxhngmYkbY/d49mzC6/6qI
         72C31ss5vGDPC9OZKje+bzkXLcHZhW80T7LK8ehB5c46PQNVLI33kFjEOdT4HY/Gz4C5
         lzpl8zEfrqda7khVKFGFWcl83Vw6T7rGTe0jBzVp/4ghDxltgWokN7LPZr0n6u3ClM5a
         MgmA==
X-Gm-Message-State: ACgBeo3SE3PlzGJ40l0K6b60OGhQLhCpYZ733z9n8ya62Ea6e34MyqbZ
        pq4qVvMpEJUij+6CMRYm04Q=
X-Google-Smtp-Source: AA6agR7Xk85UUvzalMHSrzxcmpT47uZAoGwYz7fLq45GsMHp/So49R1qGrfkswy7/uk//+bRN/Doyg==
X-Received: by 2002:a05:6402:248d:b0:437:dd4c:e70e with SMTP id q13-20020a056402248d00b00437dd4ce70emr11445160eda.75.1659813675278;
        Sat, 06 Aug 2022 12:21:15 -0700 (PDT)
Received: from gmail.com (195-38-112-141.pool.digikabel.hu. [195.38.112.141])
        by smtp.gmail.com with ESMTPSA id dm13-20020a05640222cd00b0043cb1a83c9fsm1898166edb.71.2022.08.06.12.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Aug 2022 12:21:14 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sat, 6 Aug 2022 21:21:12 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [GIT PULL] scheduler fixes
Message-ID: <Yu6/KNcTRFCHIcW2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest sched/urgent git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-2022-08-06

   # HEAD: 751d4cbc43879229dbc124afefe240b70fd29a85 sched/core: Do not requeue task on CPU excluded from cpus_mask

Various fixes: a deadline scheduler fix, a migration fix, a Sparse fix and a comment fix.

 Thanks,

	Ingo

------------------>
Ben Dooks (1):
      sched/rt: Fix Sparse warnings due to undefined rt.c declarations

Ingo Molnar (1):
      exit: Fix typo in comment: s/sub-theads/sub-threads

Mel Gorman (1):
      sched/core: Do not requeue task on CPU excluded from cpus_mask

Waiman Long (1):
      sched, cpuset: Fix dl_cpu_busy() panic due to empty cs->cpus_allowed


 include/linux/sched.h  |  2 +-
 kernel/cgroup/cpuset.c |  2 +-
 kernel/exit.c          |  2 +-
 kernel/sched/core.c    | 16 +++++++++++-----
 kernel/sched/sched.h   |  7 ++++---
 5 files changed, 18 insertions(+), 11 deletions(-)
