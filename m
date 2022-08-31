Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 683E45A851B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 20:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232395AbiHaSLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 14:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232058AbiHaSKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 14:10:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 620BF5853C;
        Wed, 31 Aug 2022 11:10:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AC14BB82012;
        Wed, 31 Aug 2022 18:09:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A649C433D6;
        Wed, 31 Aug 2022 18:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661969357;
        bh=EZCaHFNfWzzK81BUJHas2+EH26hcxKcbRtxd2gbUdDc=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=TiKAENTnjrECd4Xna+cz74y6FT50vB1jrnin5uWfY3H6yBAPla+EoG+VfhwEnWl7W
         i/keiA4tAA+Z6luGjr4Tk1MA9GFTj67WyWbJzkdulbseyT5UhFG7hliYO//j6epMq0
         8a0WF/3580uBOjx3H2sxYxqp+PY14z/gyKt4R0Yk8beNVbswINe3QqBLIiKXPnlG5F
         PxiD7mOpj0QsCAVm6dti5PjU0yEGa7S+NaqXui81Tadnu8vnaNz4xO90OHgQ1evCPh
         Ditl9sokGanELEXbpCnyMqfsgX5J4rHOgYSU7matcT0NmW/QXeZBQm+ssAFs0AtR8X
         IvDByMozyJW4g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id F0DA15C015D; Wed, 31 Aug 2022 11:09:16 -0700 (PDT)
Date:   Wed, 31 Aug 2022 11:09:16 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org
Subject: [PATCH rcu 0/7] kvfree_rcu updates for v6.1
Message-ID: <20220831180916.GA2693797@paulmck-ThinkPad-P17-Gen-1>
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

This series contains a few kvfree_rcu() updates:

1.	Back off upon fill_page_cache_func() allocation failure, courtesy
	of Michal Hocko.

2.	Fix kfree_rcu_shrink_count() return value, courtesy of "Joel
	Fernandes (Google)".

3.	Update KFREE_DRAIN_JIFFIES interval, courtesy of "Uladzislau Rezki
	(Sony)".

						Thanx, Paul

------------------------------------------------------------------------

 b/kernel/rcu/tree.c |   17 +++++++++--------
 kernel/rcu/tree.c   |   25 ++++++++++++++++++++-----
 2 files changed, 29 insertions(+), 13 deletions(-)
