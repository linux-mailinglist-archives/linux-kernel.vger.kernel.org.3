Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FBA0463D59
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 19:01:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245225AbhK3SE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 13:04:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238677AbhK3SEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 13:04:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 839DBC061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 10:01:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3B656B81B0E
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 18:01:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E96F5C53FC1;
        Tue, 30 Nov 2021 18:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638295264;
        bh=ko+gmmoDumMYl11pG/N6xsVrFtiXGWjiaJCYCIHtycU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=iDfpcKxo7I7FeINcCWvgdcARsRNQn1D+9HxZdcgbyNSsoupsxvabixCjqUMGlpw6B
         VfWTQWIjlQ2k7mDPkvFwRdR2G22Kl+5T8Ja4K2mO+BsI3dXCoz2vIPxdGUH5kXCUCK
         hIla/jeVxFmI2VBQafmk48pTqNIKT9h0Rs7PCcU72KanIqD9wZ+xojotd86DyOxUJX
         L9IAyGUE8nYEnXpNkRre8PbEmJDrc56BOXu6czgGKO7b0iU1v9SvNtm43t4Dz6cwk3
         DXaUuSz/tB1ZMSOoQTnGddPRw32ZhaBJO+FqV89BJYrys8xO4nglwZH6g/+9K0EMhy
         1N8ux1bukpxnA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 90F295C0367; Tue, 30 Nov 2021 10:01:03 -0800 (PST)
Date:   Tue, 30 Nov 2021 10:01:03 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 0/2] workqueue: Fix hotplug races
Message-ID: <20211130180103.GV641268@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20211130000612.591368-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211130000612.591368-1-frederic@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 01:06:10AM +0100, Frederic Weisbecker wrote:
> While triggering rcutorture splats, I couldn't trace down to the exact
> cause due to the issue being tracing-unfriendly. But looking at the code,
> those two potential races look like plausible causes and also after
> these two patches, I couldn't reproduce the rcutorture issues again (yet...).
> 
> Frederic Weisbecker (2):
>   workqueue: Fix unbind_workers() VS wq_worker_running() race
>   workqueue: Fix unbind_workers() VS wq_worker_sleeping() race
> 
>  kernel/workqueue.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)

This series passed 1500 hours of TREE01 with rcupdate.rcu_expedited=1
and also with Frederic's fix for expedited RCU grace periods, so:

Tested-by: Paul E. McKenney <paulmck@kernel.org>

							Thanx, Paul
