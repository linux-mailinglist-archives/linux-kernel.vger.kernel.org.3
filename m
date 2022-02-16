Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C17C64B870C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 12:49:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232376AbiBPLtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 06:49:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231834AbiBPLts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 06:49:48 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41697195079;
        Wed, 16 Feb 2022 03:49:36 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id c4so1927773pfl.7;
        Wed, 16 Feb 2022 03:49:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=lMdBePoQlUE1rdnsGymQ1Fxz9PybQL1yjjavRNOkHdE=;
        b=OaVRdKeKWsdGhVE/mgKLSIR9TcjpQOWtan0p54ueC5qA1HClH4fBXwMrNtJiFh2ue3
         bLG6k2T4zsTDH3lJ/SRD3VrTRpYcZNgRPRRhi4fqlATV43JYCJ5god4Xz0II9fwLbV8D
         cuVkWbVmVQK44S8s7NDGXUFOTCgtbq+y/89loQJPpMI+/S2CL1tYmwjRF4pSug8pClFR
         O/x6iiLFOGJSzIKkOW/4U/ksZ3aKpioZtlcL4S251vmK+CxgrEmNunflfP4HH/BMA0om
         cuUsW6tuEXX5S0lWGOo3/IEAGweFWjFz7OAqnueqtLqmGe9C9gjA2QU0YT817HyhgC6n
         Fcsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lMdBePoQlUE1rdnsGymQ1Fxz9PybQL1yjjavRNOkHdE=;
        b=KSq3XaioVZnE1j/KQ2j98K5tYM3EAgwfcjSSHupXImWW+o1LPaws+G/ucWoxFuKY0R
         JYTA7EA7IhpgzH42Oxv2Fr/GLpOeR0GsaZivRb4UHEwMcunQn2dwjjz5JPM8o/obRDlx
         b+iZpyy9gn35184yRwX2EtoVr/2JbigI9DdIFDDPMePs4lTG9mRlYxmTy/D6CwPhoyY0
         JUx4NBV4YfXQMgIlcIFR+br5zPzS/5jl50Szqv2bO1hcJJJ+WhEvXneaitnsmrZAMsGD
         fu1Fwg7bp/f8mmlUP0pGKg+yFxcZmHEi8l9Lu2nbkDoaTgvmMgBUFuPrIdNAh4pXhJRQ
         uReQ==
X-Gm-Message-State: AOAM530d8UrhMvXtJXsPgTCeQpl0q/hzebJS5A21pq2b01o+0Y+X9/ZJ
        s8n0x5Y2otakdWi5liWzKs4=
X-Google-Smtp-Source: ABdhPJxtd1Cx1D08Vu3YFKf8sZCD0qXEJlMfNlXjrzCM77uMQSY9JAjOQn7M0TD/WjaXr+lMPz/fXQ==
X-Received: by 2002:a63:1048:0:b0:370:6352:2d9b with SMTP id 8-20020a631048000000b0037063522d9bmr1912048pgq.413.1645012175792;
        Wed, 16 Feb 2022 03:49:35 -0800 (PST)
Received: from localhost.localdomain ([61.16.102.69])
        by smtp.gmail.com with ESMTPSA id q1sm26209119pfs.112.2022.02.16.03.49.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 03:49:35 -0800 (PST)
From:   "Wang Jianchao (Kuaishou)" <jianchao.wan9@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Josef Bacik <jbacik@fb.com>, Tejun Heo <tj@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC V3 0/6] blk: make blk-rq-qos policies pluggable and modular
Date:   Wed, 16 Feb 2022 19:48:03 +0800
Message-Id: <20220216114809.84551-1-jianchao.wan9@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens

blk-rq-qos is a standalone framework out of io-sched and can be used to
control or observe the IO progress in block-layer with hooks. blk-rq-qos
is a great design but right now, it is totally fixed and built-in and shut
out peoples who want to use it with external module.

This patchset attempts to make blk-rq-qos framework pluggable and modular.
Then we can update the blk-rq-qos policy module w/o stopping the IO workload.
And it is more convenient to introduce new policy on old machines w/o udgrade
kernel. And we can close all of the blk-rq-qos policy if we needn't any of
them. At the moment, the request_queue.rqos list is empty, we needn't to
waste cpu cyles on them.

Changes since v2:
 Refactor the patches,
 - patch01 only provide new interfaces and not export the sysfs interface.
 - patch02 adapt the wbt to new interface, reserve the previous action
   when write to wbt_lat
 - export sysfs interface in last patch when all of the blk-rqos policies
   are preprared well.

Changes since v1:
 - Just make iocost and iolatency pluggable, then we needn't to export
   those interfaces
 - Remove the iostat rqos policy
 - Rename module of blk-ioprio to io-prio to avoid rename ioprio.c file

WangJianchao(6):
	blk: prepare to make blk-rq-qos pluggable and modular
    blk-wbt: make wbt pluggable
    blk-iolatency: make iolatency pluggable
    blk-iocost: make iocost pluggable
    blk-ioprio: make ioprio pluggable and modular
    blk: export the sysfs for switching qos

 block/Kconfig          |   2 +-
 block/Makefile         |   3 +-
 block/blk-cgroup.c     |  11 ---
 block/blk-iocost.c     |  49 +++++++-----
 block/blk-iolatency.c  |  33 +++++++--
 block/blk-ioprio.c     |  50 ++++++++-----
 block/blk-ioprio.h     |  19 -----
 block/blk-mq-debugfs.c |  23 ++----
 block/blk-rq-qos.c     | 303 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 block/blk-rq-qos.h     |  96 +++++++++---------------
 block/blk-sysfs.c      |   2 +
 block/blk-wbt.c        |  52 +++++++++++--
 block/blk-wbt.h        |   7 +-
 block/blk.h            |   6 --
 include/linux/blkdev.h |   4 +
 15 files changed, 488 insertions(+), 172 deletions(-)

