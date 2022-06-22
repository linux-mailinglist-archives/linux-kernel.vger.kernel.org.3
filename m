Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21E9C556EA6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 00:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240583AbiFVWvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 18:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234148AbiFVWvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 18:51:42 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D047B40918
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 15:51:40 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id c1so27038017qvi.11
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 15:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vxTNAYJ4O+qH9++5m/81/N4BghOLqFhDV+f14pSf7+0=;
        b=cESB4b31Kv+EzfxJELRh90ImU3KvmUq/cHHZRwYtGhfw5oPGDM7Jn9rs4/RtwQcab/
         3C9Ev4eFsxpQHXkND3xNw7Guz/ZuH5Q4ksOe//RdzMm+Sn4ENfTjFnowSct8xO5b9oim
         jSgovOiHDgfFEy1/GAIlE09QbbfzQ6Gi6Anpo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vxTNAYJ4O+qH9++5m/81/N4BghOLqFhDV+f14pSf7+0=;
        b=yklJ/5lzih6caoaxZEvdm8zGt057l9zxth7tiSKeYv98xmhBIQHPy85xqJO4EOUqdT
         y2aBXhW9+1UOJ/nSIEx50Dr1E8kWlYnIL5dSPc9MqK4TUVF0Cq3d97ghsynTUfvOD31K
         1rukUjM2983OluQDBZ+WI0brrdPfRMm6Ox/vWhXtX7xv2M5f5dpyzU/28ly9fP8OYT1b
         LhmVYjQ9x6YJatGHKs2FAA7ycbR6NRVPocDJiUsJgTu9040zlhRinvGccyFhzBYfQzQ2
         l3vx6EMXxRmI3uhs7IMUpKhSyGv4u2FkJr8ryrQ+871tPjs/+wS//O+hJT1KvIjBSVrG
         UQrQ==
X-Gm-Message-State: AJIora8laSlV1o8Z/EWVrWptsEd44MhTr0BHB521e1Q6n+jC1mcUJGhl
        n47tg5bRkvRQhGrn+TMx0xdMZw==
X-Google-Smtp-Source: AGRyM1uAPOSu5jqUSslgE/tt4h5Q26efYhgpCw52HSo0cwuaxiNRJfCX3bWUI+b7nF14n0xMW0sylg==
X-Received: by 2002:a05:6214:21ea:b0:464:5c51:7afe with SMTP id p10-20020a05621421ea00b004645c517afemr29629720qvj.21.1655938299764;
        Wed, 22 Jun 2022 15:51:39 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id k66-20020a37a145000000b006ab91fd03fasm1794022qke.19.2022.06.22.15.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 15:51:39 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        urezki@gmail.com, neeraj.iitr10@gmail.com, frederic@kernel.org,
        paulmck@kernel.org, rostedt@goodmis.org, vineeth@bitbyteword.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH v2 0/8] Implement call_rcu_lazy() and miscellaneous fixes
Date:   Wed, 22 Jun 2022 22:50:53 +0000
Message-Id: <20220622225102.2112026-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.37.0.rc0.104.g0611611a94-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hello!
Please find the next improved version of call_rcu_lazy() attached.  The main
difference between the previous version is that it is now using bypass lists,
and thus handling rcu_barrier() and hotplug situations, with some small changes
to those parts.

I also don't see the TREE07 RCU stall from v1 anymore.

In the v1, we some numbers below (testing on v2 is in progress). Rushikesh,
feel free to pull these patches into your tree. Just to note, you will also
need to pull the call_rcu_lazy() user patches from v1. I have dropped in this
series, just to make the series focus on the feature code first.

Following are power savings we see on top of RCU_NOCB_CPU on an Intel platform.
The observation is that due to a 'trickle down' effect of RCU callbacks, the
system is very lightly loaded but constantly running few RCU callbacks very
often. This confuses the power management hardware that the system is active,
when it is in fact idle.

For example, when ChromeOS screen is off and user is not doing anything on the
system, we can see big power savings.
Before:
Pk%pc10 = 72.13
PkgWatt = 0.58
CorWatt = 0.04

After:
Pk%pc10 = 81.28
PkgWatt = 0.41
CorWatt = 0.03

Further, when ChromeOS screen is ON but system is idle or lightly loaded, we
can see that the display pipeline is constantly doing RCU callback queuing due
to open/close of file descriptors associated with graphics buffers. This is
attributed to the file_free_rcu() path which this patch series also touches.

This patch series adds a simple but effective, and lockless implementation of
RCU callback batching. On memory pressure, timeout or queue growing too big, we
initiate a flush of one or more per-CPU lists.

Similar results can be achieved by increasing jiffies_till_first_fqs, however
that also has the effect of slowing down RCU. Especially I saw huge slow down
of function graph tracer when increasing that.

One drawback of this series is, if another frequent RCU callback creeps up in
the future, that's not lazy, then that will again hurt the power. However, I
believe identifying and fixing those is a more reasonable approach than slowing
RCU down for the whole system.

Disclaimer: I have intentionally not CC'd other subsystem maintainers (like
net, fs) to keep noise low and will CC them in the future after 1 or 2 rounds
of review and agreements.

Joel Fernandes (Google) (7):
  rcu: Introduce call_rcu_lazy() API implementation
  fs: Move call_rcu() to call_rcu_lazy() in some paths
  rcu/nocb: Add option to force all call_rcu() to lazy
  rcu/nocb: Wake up gp thread when flushing
  rcuscale: Add test for using call_rcu_lazy() to emulate kfree_rcu()
  rcu/nocb: Rewrite deferred wake up logic to be more clean
  rcu/kfree: Fix kfree_rcu_shrink_count() return value

Vineeth Pillai (1):
  rcu: shrinker for lazy rcu

 fs/dcache.c                   |   4 +-
 fs/eventpoll.c                |   2 +-
 fs/file_table.c               |   2 +-
 fs/inode.c                    |   2 +-
 include/linux/rcu_segcblist.h |   1 +
 include/linux/rcupdate.h      |   6 +
 kernel/rcu/Kconfig            |   8 ++
 kernel/rcu/rcu.h              |   8 ++
 kernel/rcu/rcu_segcblist.c    |  19 +++
 kernel/rcu/rcu_segcblist.h    |  24 ++++
 kernel/rcu/rcuscale.c         |  64 +++++++++-
 kernel/rcu/tree.c             |  35 +++++-
 kernel/rcu/tree.h             |  10 +-
 kernel/rcu/tree_nocb.h        | 217 +++++++++++++++++++++++++++-------
 14 files changed, 345 insertions(+), 57 deletions(-)

-- 
2.37.0.rc0.104.g0611611a94-goog

