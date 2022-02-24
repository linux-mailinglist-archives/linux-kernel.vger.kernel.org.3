Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 552A94C2789
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 10:09:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232547AbiBXJJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 04:09:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232516AbiBXJIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 04:08:53 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A27661A028D;
        Thu, 24 Feb 2022 01:08:23 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id em10-20020a17090b014a00b001bc3071f921so5127443pjb.5;
        Thu, 24 Feb 2022 01:08:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=vp6Yhgon85sRx5zs1fUJrp2yQFTvtxuQ2h20Nw2I3I0=;
        b=gkRKkA0Ow5/Kzw+pHAv/XmOdq5wnozgHTkefq1702oGFFCv8oBqBrvuWnF9qVy+2ix
         /SMaqr3MBfurEmdnh2m25DYpApmsLcYXY1VVwd4TiVfknkd68FqitIFLkmIduVlmZaOp
         kLgwtFWJlyA7we4w15SJWnYmf5sv0+mUaE9wO2zExsMatwmAu8IZE0TrZFqJOZP5qWwW
         VXOgZxaFeMFw69BbwonGyY69W9bUMig0HzMG9zSigd5HKqCgG1n+VDo11CV+1rrItixR
         jLVQK1iAncKpQOj6I/SqTvoll8ND8n+wjRdGoUTX+UJILmbo302nFynVoYRZpzjNy3SL
         xkRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vp6Yhgon85sRx5zs1fUJrp2yQFTvtxuQ2h20Nw2I3I0=;
        b=sDziJ7I2sLDP6WoG8j0FXy2lXEbuM0nukXtw2PmvZ3HLkCyWTI3iftScBKQ63HJ2Xe
         SkqU31FgCrbJA+mSQTx4gB4eBHjBBdihPSpv0RpfVp1Ifn4nc+CfTNCSDB7/7mndA6Zu
         cHTU913F4W+qYOIbKYM76bd1rMTDgrTA/x9NDA88myLYF62xy30gOVFgD565t7C1WXev
         p3V2Jed6QDPnknHxq2a4/jmGPhWC65F4v/HdTUH8JZ291aPq3CxCpxGl0GLcIkH5JPzC
         C6WvFLol5LAo5FlZW6j7h4LnTSDC+I07/n+d7SwqhVX8ja9j8MLjin8FJXB+KAtkUe0m
         P8WQ==
X-Gm-Message-State: AOAM5334OzFJQ+FAtYi6DBkQtUxjlFWa/7LCa8YkQ8qNaKavsMOwY0am
        S5mY3p8udXS/W0xwAqzXjmY=
X-Google-Smtp-Source: ABdhPJwtn4ynE6cl6pNe4B+KHuxHXfKgocSy6KCzR7C1MUduqO9Ikqjg4jgS/3DhBcrNkVcD97KdYw==
X-Received: by 2002:a17:90a:6c66:b0:1bc:52a2:18e8 with SMTP id x93-20020a17090a6c6600b001bc52a218e8mr1828468pjj.180.1645693703118;
        Thu, 24 Feb 2022 01:08:23 -0800 (PST)
Received: from localhost.localdomain ([162.219.34.248])
        by smtp.gmail.com with ESMTPSA id nn14sm2023999pjb.45.2022.02.24.01.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 01:08:22 -0800 (PST)
From:   "Wang Jianchao (Kuaishou)" <jianchao.wan9@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Josef Bacik <jbacik@fb.com>, Tejun Heo <tj@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC V5 0/16] blk: blk-rq-qos framework refactor and cleanup
Date:   Thu, 24 Feb 2022 17:06:38 +0800
Message-Id: <20220224090654.54671-1-jianchao.wan9@gmail.com>
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

This patchset is working on our v4.18 kernel to provide the capacity
for upgrade blk-rq-qos policies on the fly w/o needing to restart
machine and applications.

In previous discussion, the modularization has been rid of. Please
refer to the link:
https://www.spinics.net/lists/linux-block/msg79958.html

Right now, patchset is to make blk-rq-qos policies pluggable through
a new sysfs interface, /sys/block/xxx/queue/qos. Then we can open/close
policy per device and needn't to iterate the rqos list and allocate
memory for them if we don't use.

The blktest has passed along with a new test case which switches
rqos policies with running fio in cgroups. Refer to following link,

https://patchwork.kernel.org/project/linux-block/patch/20220224085340.53854-1-jianchao.wan9@gmail.com/

When do the test above, I find the queue freezing mechanism has
not been able to protect the whole blk_mq_submit_bio(). I guess it
should be for saving some cpu cyles. But queue freezing is the basis
for patchset. So I add it back as the 1st patch which maybe unacceptable.

The 2nd ~ 8th provide the new API and adapt the code of blk-wbt,
blk-iolatency, blk-iocost and blk-ioprio to use the new API. And
finally, the /sys/block/xxx/queue/qos is exposed.

The following patches on blk-wbt may break its original assumpation.

The 9th patch is to expose 'wbt_lat_nsec' when 'wbt' police is opened.
And some code cleanup is also there as some interfaces needn't to be
exposed.

The 10th patch gets rid of the following actions, enable wbt by default,
disable wbt when bfq is enabled. The user should be responsible for
selecting different policies.

The 11th patch gets rid of the rqos debugfs interfaces registeration
when queue is initialized as there is not any default policies any more.

The 12th patch rename blk-rq-qos's queue_depth_changed callback to
setting_changed, then we can involve the cache state changing.

The 13th patch involve the cache state changing into setting_changed callback,
then the last exposed interface of wbt is get rid of.

The 14th patch cleanup the blk-wbt.h as there is nothing need to be exposed.

The 15th patch moves the rqos debugfs registeration interfaces to blk-rq-qos.c

The 16th patch adds a new CONFIG_BLK_RQ_QOS to control the whole blk-rq-qos code.


Changes since v4:
 - add 1st patch to protect the whole blk_mq_submit_bio path.
 - add sysfs_lock around the rq_qos_queue_depth_changed()
 - add qos_lock to protect the rqos list
 - add patches to clean up the blk-wbt
 - add new config to control blk-rq-qos's code

Changes since v3:
 - Fix some code sytle issues
 - Rename policies to blk-wbt, blk-iolat, blk-iocost, blk-ioprio

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

Wang Jianchao(16)
	blk: make the whole blk_mq_submit_bio under
    blk/rq-qos: prepare to make blk-rq-qos pluggable
    blk-wbt: make wbt pluggable
    blk-iolatency: make iolatency pluggable
    blk-iocost: make iocost pluggable
    blk-ioprio: make ioprio pluggable
    blk/rq-qos: get rid of unused interfaces of rqos
    blk/rq-qos: export the sysfs for switching qos
    blk-wbt: show wbt_lat_us sysfs interface only when wbt
    blk-wbt: get rid of wbt_enable/disable_default()
    blk/rq-qos: get rid of debugfs register in
    blk/rq-qos: change queue_depth_changed to
    blk-wbt: move cache setting to
    blk-wbt: cleanup the blk-wbt.h
    blk/rq-qos: move the rqos debugfs code to blk-rq-qos.c
    blk/rq-qos: add config to control the whole blk-rq-qos

 15 files changed, 488 insertions(+), 172 deletions(-)
 block/Kconfig              |   7 ++
 block/Makefile             |   3 +-
 block/bfq-iosched.c        |   2 -
 block/blk-cgroup.c         |  11 --
 block/blk-core.c           |   1 +
 block/blk-iocost.c         |  83 +++++++------
 block/blk-iolatency.c      |  44 ++++---
 block/blk-ioprio.c         |  53 +++++----
 block/blk-ioprio.h         |  19 ---
 block/blk-mq-debugfs.c     |  67 +----------
 block/blk-mq-debugfs.h     |  17 +--
 block/blk-mq-sched.c       |   1 -
 block/blk-mq.c             |  22 ++--
 block/blk-rq-qos.c         | 285 +++++++++++++++++++++++++++++++++++++++++++-
 block/blk-rq-qos.h         | 124 +++++++------------
 block/blk-settings.c       |   6 +-
 block/blk-sysfs.c          |  82 ++-----------
 block/blk-wbt.c            | 288 ++++++++++++++++++++++++++++-----------------
 block/blk-wbt.h            | 134 ---------------------
 block/blk.h                |  12 +-
 block/elevator.c           |   3 -
 include/linux/blkdev.h     |   7 +-
 include/trace/events/wbt.h |   3 +-
 23 files changed, 668 insertions(+), 606 deletions(-)

