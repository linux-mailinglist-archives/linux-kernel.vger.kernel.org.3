Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D786D4894D5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 10:12:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242657AbiAJJMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 04:12:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242647AbiAJJMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 04:12:13 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 330E0C06173F;
        Mon, 10 Jan 2022 01:12:06 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id pf13so4169237pjb.0;
        Mon, 10 Jan 2022 01:12:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=HJ7JuODY9UEzKv7IRgMJSQpt1P1N+tggBzUPSi28s3M=;
        b=Ei0oovjeY7TfMhgNPYRJS7dr2q2+74q/EStJ0YYVVpUeBIPenAEbrKnQKsXEogSmGu
         ZAiHJmt0/imwLVlvvUH71EgQQ1vDx3zgcLQwwiQoTVGaYXtHuqF7crxMZhlS+OfK0XKT
         Aj4glP/pdEmX1k8sYXrzfcnPLUaH4ivQaBBaFNwek7Vq5B0aQmjxKb8o8sOUKXp1uomq
         4DoZ/Vv4qZ8k+bdzRM92hltQ7I+cTAcavjcY7nlzS1JcaC4CeInnlaz2/dCQsEvSO5Tk
         A7CXhz+1c32SvC6N8Onik+RLxbPtJr6OBQFUCCmXdIGPgmGHHFWDDBemX0HIQhjgbepk
         VrVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HJ7JuODY9UEzKv7IRgMJSQpt1P1N+tggBzUPSi28s3M=;
        b=Aboy2QovZhYaTOxNGjbJizYkHEpSs2QBZRxJwBMxw/wJ3nWGbkzYOIBNfW75bzlZuj
         /64iq5aeguvliX67VxksVrRCUMNTToe2KjE0v6lSGtjf8aeu12N4IrTXqqQKLWuFF7VQ
         tngPNPuBsZrjnQJgQ9ATXvMSfjtOiVhDhxcNTZ7kViqJhtTj50N/Fl6OzEyX2T+1ySx2
         FOd25V3YhOblQcyV3rhf/Q4BQ5m16rkdjE+I0ZIQs1RAjK444GbqbqRtWu7omQ59sfPs
         obb9MYkfTobsH73M4/INtzUiFM+5ol6oc7Uqat5bl1dLLmrHkv/tL5nLn5sno5t2RfoX
         SH3g==
X-Gm-Message-State: AOAM531YlzE+6NRR4x9fWnjXEv3WPBjUDA6TE/8B6niv0YMFjOA0R/eD
        rY9GQwNoxE/QxoNXksYg/I0=
X-Google-Smtp-Source: ABdhPJyLDDNQ0vUUwvS4KN5YTMTMyzHFNvtFwnvt5KUegGeh6Ua+aq40Y5RGEcpv70z2XMMH4mttIg==
X-Received: by 2002:a17:90a:c582:: with SMTP id l2mr2391320pjt.78.1641805925757;
        Mon, 10 Jan 2022 01:12:05 -0800 (PST)
Received: from localhost.localdomain ([162.219.34.250])
        by smtp.gmail.com with ESMTPSA id j22sm6293910pfj.29.2022.01.10.01.12.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 01:12:05 -0800 (PST)
From:   Wang Jianchao <jianchao.wan9@gmail.com>
To:     axboe@kernel.dk
Cc:     jbacik@fb.com, tj@kernel.org, bvanassche@acm.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/13] blk: make blk-rq-qos policies pluggable and modular
Date:   Mon, 10 Jan 2022 17:10:33 +0800
Message-Id: <20220110091046.17010-1-jianchao.wan9@gmail.com>
X-Mailer: git-send-email 2.17.1
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
kernel. We can close all of the blk-rq-qos policy if we needn't any of them.
At the moment, the request_queue.rqos list is empty, we needn't to waste cpu
cyles on them.

In addition, a new simple policy is introduced in this patchset which is to
observe the IO statistics per cgroup. A new interface, 'blkio.iostat' is
added into blkio cgroup directories. A very simple tool in following link

            https://github.com/jianchwa/iostat-cgrp.git

can be used to output the result in more friendly fashion, such as,
  Device DATA       IOPS         BW       RQSZ       QLAT       DLAT Cgroup
     vda    R    16.00/s 572.00KB/s     35.75K     9.46us   250.68us test
     vdb    W   249.00/s  50.34MB/s    207.02K   254.33us   137.41ms
  Device META       IOPS         BW       RQSZ       QLAT       DLAT Cgroup
     vdb    W    44.00/s 792.00KB/s     18.00K   191.20us   225.25ms
  Device DATA       IOPS         BW       RQSZ       QLAT       DLAT Cgroup
     vda    R    33.00/s 412.00KB/s     12.48K     8.49us   180.84us test
     vdb    W    65.00/s  12.71MB/s    200.31K   432.02us   335.31ms
     vdb    W    38.00/s  12.66MB/s    341.26K   135.56us   230.27ms test
  Device META       IOPS         BW       RQSZ       QLAT       DLAT Cgroup
     vda    R     5.00/s  68.00KB/s     13.60K    12.51us   162.52us test
     vdb    W   119.00/s   2.28MB/s     19.63K    10.40ms   149.88ms
  Device DATA       IOPS         BW       RQSZ       QLAT       DLAT Cgroup
     vda    R    20.00/s 232.00KB/s     11.60K     8.71us   514.30us test
     vdb    W   183.00/s  35.02MB/s    195.96K   196.82us   129.58ms
     vdb    W     1.00/s 380.00KB/s    380.00K    48.51us   552.68ms test

As you see, there is device name, meta or data, read or write, cgroup name ,etc.
If there is no cgroup name, it indicates root cgroup which dosn't include
children cgroup's IO. This is different from non-root cgroup.

The 1st patch introduces the general interfaces to make blk-rq-qos pluggable and
modular, such as register/unregister, activate/deactivate, queue sysfs interface.

The 2nd patch make blk-wbt pluggable

The 3rd and 4th patch export some interface which is prepared for following patches
to make iolatency, iocost and ioprio modular

The 5th patch make blk-iolatency pluggable and modular. It has cgroup policy, we
can rmmod it to release a blk cgroup policy slot.

The 6th remove an unused macro

The 7th patch introduce a new macro to control the bio.bi_iocost_cost, this is
also a preparation to make iocost modular.

The 8th patch make iocost pluggable and modular

The 9th patch rename ioprio.c to ioprio-common.c as it has same name with
following ioprio.ko in Makefilea

The 10th patch make ioprio policy pluggable and modular

The 11th patch remove some unused interfaces of blk-rq-qos.c, such as
rq_qos_add/del

The 12th patch make request carry blkcg_gq, this is needned by the following
iostat policy.

The 13th patch introduce the iostat policy of blk-rq-qos.

Wang Jianchao (13)
	blk: make blk-rq-qos support pluggable and modular policy
	blk-wbt: make wbt pluggable
	blk: export following interfaces
	cgroup: export following two interfaces
	blk-iolatency: make iolatency pluggable and modular
	blk: remove unused BLK_RQ_IO_DATA_LEN
	blk: use standalone macro to control bio.bi_iocost_cost
	blk-iocost: make iocost pluggable and modular
	blk: rename ioprio.c to ioprio-common.c
	blk-ioprio: make ioprio pluggable and modular
	blk: remove unused interfaces of blk-rq-qos
	blk: make request able to carry blkcg_gq
	blk: introduce iostat per cgroup module

block/Kconfig                       |  23 ++++-
 block/Makefile                      |  13 ++-
 block/bdev.c                        |   5 -
 block/bio.c                         |   2 +-
 block/blk-cgroup.c                  |  23 +++--
 block/blk-core.c                    |   6 +-
 block/blk-iocost.c                  |  53 ++++++----
 block/blk-iolatency.c               |  39 +++++--
 block/blk-ioprio.c                  |  50 ++++++---
 block/blk-ioprio.h                  |  19 ----
 block/blk-iostat.c                  | 347 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 block/blk-merge.c                   |   9 ++
 block/blk-mq-debugfs.c              |  22 +---
 block/blk-mq.c                      |  14 +++
 block/blk-rq-qos.c                  |   4 +-
 block/blk-rq-qos.h                  |  67 +-----------
 block/blk-stat.c                    |  30 ------
 block/blk-stat.h                    |  31 +++++-
 block/blk-sysfs.c                   |   7 +-
 block/blk-wbt.c                     |  30 +++++-
 block/blk-wbt.h                     |   8 +-
 block/blk.h                         |   6 --
 block/{ioprio.c => ioprio-common.c} |   0
 include/linux/blk-cgroup.h          |   1 +
 include/linux/blk-mq.h              |   4 +-
 include/linux/blk_types.h           |   2 +-
 include/linux/blkdev.h              |   7 +-
 include/linux/cgroup.h              |   5 +-
 kernel/cgroup/cgroup.c              |   7 ++
 29 files changed, 599 insertions(+), 235 deletions(-)

