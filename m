Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 966E04B9679
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 04:16:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232508AbiBQDPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 22:15:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231329AbiBQDP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 22:15:29 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB672727B1;
        Wed, 16 Feb 2022 19:15:15 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id qe15so4294255pjb.3;
        Wed, 16 Feb 2022 19:15:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=LmgepXP/Vtuh5oVHO9dtuvcfXAWSOUVOBIqTArmUnB4=;
        b=kj/jTVICqbtyVh4P9EU3cDaIFy+nJu84K7xiBHnUb9RUeXjlweD4oqmGigQDGNWByf
         1aQ3DCXOk+dT6RKLaSJn79HAQJ2yuMWBwb7de9rFrW+T1whFG9g66bM1KF9sUyKhdhHU
         /0dkD9Hf32ZuMdEPbXVZaQgNYPB3dwRgrBRxaAZHcQaM5BfWz10mHtBej3VmCH3iSBo9
         u9cIaUsFtqHfgihMQA7ofMoE1Wz6h93FiYIqOVuamwmAFfBrS/maSzQo0jmZeK4lVr7r
         dYzRXaCRUR3Gy6AX4THgZn2NWR89ovEZlZvrE4czogVaks+MoJKgLJo2cuIq8LglKLhN
         hx7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LmgepXP/Vtuh5oVHO9dtuvcfXAWSOUVOBIqTArmUnB4=;
        b=Nkl3EA5iK8qUXH8XGR3TkEauPQIcncEFyFrnqbVzFg5QLsgAn2BtNxXrHtASZds04a
         m7OD6Fjz1M6Q0YJd6yfI0eOOUjw1l0muNeuRjRR9SHQJzeTocVn9SelkS5CAwR3pkxbq
         XW77IcJxAlsxmViNjIrMpvpcPZZA4J8jVMJOq+27fRDpl45u1iB3k5765SFHUblrGXBT
         TjGiBYtOX0E3eurKjfxDOVCDEU1ZGp8N2TI1rtgQdtMU8Ofpn1MFjYGeH4+WfiAj5+Xa
         AdA+f9h0AamRvzFOiQu9UKSJJFs55lnYG3ywXXgF68TNky3uQYrsNeJsx3aqHhmmcki2
         bp2w==
X-Gm-Message-State: AOAM531Fjmpyh+O51kh9qtrKlJZ54ESriL1hwQ4LU5odSZN+5Rzvj3Eu
        mbwpWuhk1X56cObsJWLhrTw=
X-Google-Smtp-Source: ABdhPJx2zsmexVDBX/XeYLm2KRhRqgPZJ5fxjvUiqGjSA3rJ8fD9Jtrm1YKyUo2KXvi/OO1i0gdPNA==
X-Received: by 2002:a17:902:9684:b0:14d:85a7:6eda with SMTP id n4-20020a170902968400b0014d85a76edamr912134plp.111.1645067715224;
        Wed, 16 Feb 2022 19:15:15 -0800 (PST)
Received: from localhost.localdomain ([162.219.34.248])
        by smtp.gmail.com with ESMTPSA id cu21sm421018pjb.50.2022.02.16.19.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 19:15:14 -0800 (PST)
From:   "Wang Jianchao (Kuaishou)" <jianchao.wan9@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Josef Bacik <jbacik@fb.com>, Tejun Heo <tj@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC V4 0/6] blk: make blk-rq-qos policies pluggable and modular
Date:   Thu, 17 Feb 2022 11:13:43 +0800
Message-Id: <20220217031349.98561-1-jianchao.wan9@gmail.com>
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

