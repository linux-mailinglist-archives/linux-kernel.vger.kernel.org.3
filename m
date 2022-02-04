Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E56444AA393
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 23:54:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354156AbiBDWyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 17:54:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234056AbiBDWyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 17:54:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B60C06134B;
        Fri,  4 Feb 2022 14:54:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 73B6161A60;
        Fri,  4 Feb 2022 22:54:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC733C004E1;
        Fri,  4 Feb 2022 22:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644015249;
        bh=uwQXLbWhaPjyy/J2caZF9btjWvoBfJ0LSQaXFvNklkU=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=Pn6aZQxepVxMXVp6OTHli6rmi4n7qzf0iRixiMBz0L6yD8gytDhzv3aYvBcsek4Gi
         srhjXNxHsFdikdUN38ZNaVYGJ8goc6XlUQK8P9hz5+a0CQmjIROepkpS/9+7HpaHE6
         W4eaxgetKHplMfWhpZTIAL7AOgF5FsQANZJdD1BPNH8aRUrrOYa8P8TUjb2Zr/E7aF
         YbSvQY4I5Uhfd47Rze/il6hYep/iLHSh2FGVGuNZrj6xe7uVgJAto14UC/4VUssK6q
         kgoXeIdGB1ORso/yWhtUsNCeFqLyL7cyRxUrmWQIkh6kD7hUEwEpaWnNloD0D6RCr5
         2L4pFKL2ntFcA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A4B505C0418; Fri,  4 Feb 2022 14:54:09 -0800 (PST)
Date:   Fri, 4 Feb 2022 14:54:09 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org
Subject: [PATCH rcu 0/3] Expedited-grace-period updates for v5.18
Message-ID: <20220204225409.GA4193020@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_50,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This series provides updates for RCU expedited grace periods:

1.	Fix check for idle context in rcu_exp_handler, courtesy of
	Neeraj Upadhyay.

2.	Mark ->expmask access in synchronize_rcu_expedited_wait().

3.	Allow expedited RCU grace periods on incoming CPUs.

						Thanx, Paul

------------------------------------------------------------------------

 b/kernel/rcu/tree_exp.h |    2 +-
 kernel/rcu/tree_exp.h   |   17 ++++++++++++-----
 2 files changed, 13 insertions(+), 6 deletions(-)
