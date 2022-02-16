Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD2D4B8CB2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 16:42:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235601AbiBPPmf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 10:42:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235582AbiBPPm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 10:42:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFB5F74DE2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 07:42:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DC399B81F3A
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 15:42:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01D98C004E1;
        Wed, 16 Feb 2022 15:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645026133;
        bh=Ejh8UigPECct91CA3z1fN8IKUXAs/cmG4nYA8pD9YEo=;
        h=From:To:Cc:Subject:Date:From;
        b=fmmd1hBEVTSAElzTCuVsAguuhRKDkEnpbGoXMscYJY4KvF5VW666Nredl530HgDZV
         BfnoBax+B/sxzj2ZV/yIvNMv4yEsEK9GeBLoWXm2YDjPHVCUQCBiN3n3C/LWE6l8fw
         6UjyrnI6tBJJP9B7plYyeMUU9wF5u2ku4CHlVir9mEXuKFMS71/0iQSqzSxLuLqNVA
         tzUhYyUNmqGaQEuKci7oNij8r7H3y1SnuvwkleuVnOtQQwJvruz855b9WmZPBIcV7y
         Kqtbo+XYb2miiV31UkeyezKZlasfa3X0BDL+/y44zrOCt3keeQynFL4OUelzNq7p8v
         zEHXEqS/p8FHw==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Uladzislau Rezki <uladzislau.rezki@sony.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 0/5] rcu: Bunch of cleanups
Date:   Wed, 16 Feb 2022 16:42:03 +0100
Message-Id: <20220216154208.696069-1-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Just a bit of housekeeping.

git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
	rcu/dev

HEAD: be4d4c3ba8c4ceeba9dc9df4de5451c7261161f3

Thanks,
	Frederic
---

Frederic Weisbecker (5):
      rcu: Remove rcu_is_nocb_cpu()
      rcu/nocb: Move rcu_nocb_is_setup to rcu_state
      rcu: Assume rcu_init() is called before smp
      rcu: Initialize boost kthread only for boot node prior SMP initialization
      rcu/nocb: Initialize nocb kthreads only for boot CPU prior SMP initialization


 kernel/rcu/rcu.h         |  2 --
 kernel/rcu/tree.c        | 25 +++++++++++++++++--------
 kernel/rcu/tree.h        |  3 +--
 kernel/rcu/tree_nocb.h   | 41 +++++------------------------------------
 kernel/rcu/tree_plugin.h | 16 ----------------
 5 files changed, 23 insertions(+), 64 deletions(-)
