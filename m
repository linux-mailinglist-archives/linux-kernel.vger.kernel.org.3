Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 120E54ADE13
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 17:16:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352161AbiBHQQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 11:16:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239418AbiBHQQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 11:16:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14883C061576
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 08:16:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A0231616A7
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 16:16:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 951C3C340E9;
        Tue,  8 Feb 2022 16:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644337001;
        bh=6uZuyQF1JMIV625uQVYC4MiVqzaUhKo+zrnreZEwYIQ=;
        h=From:To:Cc:Subject:Date:From;
        b=ewePG98exLMuU3DRh+XzbSpVA5cBeQPqZRgT4bB0L66IvrsLGzsYuSH1VwIDNKsgD
         LICwPciwe2tVmm581uf2Dvp1BlZFei9wXm7SVnker+9DEX66zAMPH5wHFU339B75XS
         myKCiLw7NjT6uLZecA0hNGo5HPMltrpd7M2PJIoPF+TPXiidGNIfdbCB2aRgzIkL9F
         7BJ6vUW1LW2sh60HBKEVy7lY+lt8dAZtehmN1V2ij8zaJVFBeqbGBvoYNrdiDk+65e
         GaSQ5ijVT7CDnq9E+GNDCguEAjQJ+N1oXvQTny+JgjISmabdRP5Z9qoc3cLjinCweb
         f3Rm88MXOhF2g==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Menzel <pmenzel@molgen.mpg.de>
Subject: [PATCH 0/3] tick: Fix softirq related warnings
Date:   Tue,  8 Feb 2022 17:16:32 +0100
Message-Id: <20220208161635.544701-1-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some cleanups and debug rework.

git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
	timers/core

HEAD: 18b00369d58da4c73946d5f8ebed8e8c7ade89e2

Thanks,
	Frederic
---

Frederic Weisbecker (3):
      tick/rcu: Remove obsolete rcu_needs_cpu() parameters
      tick/rcu: Stop allowing RCU_SOFTIRQ in idle
      lib/irq_poll: Declare IRQ_POLL softirq vector as ksoftirqd-parking safe


 include/linux/interrupt.h | 11 ++++++++-
 include/linux/rcutiny.h   |  3 +--
 include/linux/rcutree.h   |  2 +-
 kernel/rcu/tree.c         |  3 +--
 kernel/time/tick-sched.c  | 60 ++++++++++++++++++++++++++++++++++-------------
 5 files changed, 57 insertions(+), 22 deletions(-)
