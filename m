Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF934B6C22
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 13:38:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237705AbiBOMis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 07:38:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbiBOMir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 07:38:47 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE52869CF8;
        Tue, 15 Feb 2022 04:38:37 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id ki18-20020a17090ae91200b001b8be87e9abso1767311pjb.1;
        Tue, 15 Feb 2022 04:38:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=4x5A716mj+zEhGl7gOIgN6+n2BW6656LjfYHdjUp6NA=;
        b=LtyMpZUVvjy6QznHcU4jrAfUQrh16mEH2fTxY2JvoeWhF8fERit41YQtoF3A7t5pr2
         24V2D0wr2SwW0YYGO0uXvgRPZjcjb02X/QnfI4br8kwRZ5wkuaX9tJJQD72v58ODCP4t
         oz5T3zsttdVPcA6UwxEjaOy9bt2WodiUUBt413pPSFmrJ6KscmCZ2oWddNT4jLhGZAJN
         p260TY1yv9QSSqm6bbkd4M3KN1PryRJcN091sSVd/tCONp5FmnY8ncWIb1Ljvg18u5Je
         Z8trs2x+CyahYY1w+lOgaPJgoZ/Zqcyjm2lBlK3O6szgt5C5MHRQ1RIBR9zbc9p514P/
         ssbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4x5A716mj+zEhGl7gOIgN6+n2BW6656LjfYHdjUp6NA=;
        b=4jWMW0vw1I0n2Oe4LSWw9mNAp7hfzvh6QI2PHnAcEVF1ybcw2JkTydtCfpWUpo3TN1
         EAgKnWhxugyLZnf+A1ohSu3LDNjFdYihTUiumaCMvw+7EKuy30AnbZQvCBTj9v2x6g86
         w3w4wsuE4bHutm6JwwXp2FTeLs5rPBJ/svXzz1Eq1kFGUUfgTcQF/2f/fbNNnnZB1fJ8
         hiBpJq6t1xw0Fga1Xu33Dj4NbWgZmzTEdjN/3L90QayAIqlw9ukPSJm7UY1rSEYcj0n8
         W9FE/CntLWG2DKda5S57zmvD31xkph+ocyC0UrWpamfejyxni+Xf0UDgzZ0Ba9zRMFlk
         g0RQ==
X-Gm-Message-State: AOAM530z4dOl5mNTB2A2owrz1cWxuOjXTkgNXSCazmH22s5AbjvX3LP2
        1t02tcceRZi9dDEAeOTbgx8=
X-Google-Smtp-Source: ABdhPJyqlvw6+qdu4Dpm2m+IOMI6xJWfTxv9apdaQweqUcKWc3YCywhlw1juRuu/ayMt7zc2cqIk1w==
X-Received: by 2002:a17:90a:7f03:b0:1b8:8d90:b194 with SMTP id k3-20020a17090a7f0300b001b88d90b194mr4241533pjl.2.1644928716824;
        Tue, 15 Feb 2022 04:38:36 -0800 (PST)
Received: from localhost.localdomain ([162.219.34.248])
        by smtp.gmail.com with ESMTPSA id q8sm44017803pfl.143.2022.02.15.04.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 04:38:36 -0800 (PST)
From:   "Wang Jianchao (Kuaishou)" <jianchao.wan9@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     hch@infradead.org, Josef Bacik <jbacik@fb.com>,
        Tejun Heo <tj@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC V2 0/6] blk: make blk-rq-qos policies pluggable and modular
Date:   Tue, 15 Feb 2022 20:36:59 +0800
Message-Id: <20220215123705.58968-1-jianchao.wan9@gmail.com>
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

Changes since v1:
 - Just make iocost and iolatency pluggable, then we needn't to export
   those interfaces
 - Remove the iostat rqos policy
 - Rename module of blk-ioprio to io-prio to avoid rename ioprio.c file

WangJianchao(6):
	blk: make blk-rq-qos support pluggable and modular
    blk-wbt: make wbt pluggable
    blk-iolatency: make iolatency pluggable
    blk-iocost: make iocost pluggable
    blk-ioprio: make ioprio pluggable and modular
    blk: remove unused interfaces of blk-rq-qos

block/Kconfig          |   2 +-
 block/Makefile         |   3 +-
 block/blk-cgroup.c     |  11 ---
 block/blk-core.c       |   2 +
 block/blk-iocost.c     |  59 ++++++++------
 block/blk-iolatency.c  |  33 ++++++--
 block/blk-ioprio.c     |  50 +++++++-----
 block/blk-ioprio.h     |  19 -----
 block/blk-mq-debugfs.c |  18 +----
 block/blk-rq-qos.c     | 312 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 block/blk-rq-qos.h     | 104 +++++++++++--------------
 block/blk-sysfs.c      |   9 +--
 block/blk-wbt.c        |  36 +++++++--
 block/blk-wbt.h        |   8 +-
 block/blk.h            |   6 --
 block/elevator.c       |   3 +
 block/genhd.c          |   2 -
 include/linux/blkdev.h |   4 +
 18 files changed, 501 insertions(+), 180 deletions(-)

