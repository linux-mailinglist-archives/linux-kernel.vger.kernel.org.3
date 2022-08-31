Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C26585A852F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 20:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbiHaSNY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 14:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232556AbiHaSMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 14:12:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15799EF028;
        Wed, 31 Aug 2022 11:11:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 32898B82012;
        Wed, 31 Aug 2022 18:10:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D306AC433D6;
        Wed, 31 Aug 2022 18:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661969440;
        bh=Um7hXeS6vQK09WX+PG5funUKMt/4G4ogUs7bwEjtQc0=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=QinwrbNhA9YOsLj9eUJsuDqmqrZ/dX1ZwQeXXOrAbi7jlO/Pef8sOlHUV1mY5fBYi
         ffKAVJsLDU+xz1qOb5fNb8KUreUiNfnABa3tIwv4E12+RJ1QJZJz84Z1L1tA5gqwjO
         SpGPBLAVhE+BfyEVwpVbLUr1Q8AnI0OQzStuHS/ga3cMn9eQ57CXBfh6FKODKgVL3c
         JRPyg1MUO5f4WDxu1gI+KSbgROgmI9A6RSHyltqO2idRS1T5xPLp2ZZOnaEeEbqHiQ
         u05JmvVuWs63LGC+u8Pz/UHm1ULwTyMud4D8kLJ0DfKen3lFl91McPQu5KfsgvpEpn
         DGJOoeGM4bLXw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 83DFC5C015D; Wed, 31 Aug 2022 11:10:40 -0700 (PDT)
Date:   Wed, 31 Aug 2022 11:10:40 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org
Subject: [PATCH rcu 0/7] Callback-offload (nocb) updates for v6.1
Message-ID: <20220831181040.GA2694278@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This series provides NOCB-CPU updates:

1.	Choose the right rcuog/rcuop kthreads to output, courtesy
	of Zqiang.

2.	Add CPU number to CPU-{,de}offload failure messages.

3.	Simplify rcu_init_nohz() cpumask handling, courtesy of Zhen Lei.

						Thanx, Paul

------------------------------------------------------------------------

 b/kernel/rcu/tree_nocb.h |    6 +++---
 kernel/rcu/tree_nocb.h   |   36 +++++++++++-------------------------
 2 files changed, 14 insertions(+), 28 deletions(-)
