Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74D174B53BF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 15:51:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242158AbiBNOtg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 09:49:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355374AbiBNOte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 09:49:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB7034D633;
        Mon, 14 Feb 2022 06:49:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 62D8AB80E94;
        Mon, 14 Feb 2022 14:49:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11EFEC340E9;
        Mon, 14 Feb 2022 14:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644850161;
        bh=tW5tpOyD9L8lrf0v8sM7CbDrJrETT01Kr4ZyOCo19kw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ogW0c8kQiioskibNJS4YjOrrZOfjr6yd/JLEfz7wfD+bIaUKH0DuvNrKiBudoJiUv
         ZvdBf3a4Tn7YDG2qVFV91viJCSBk08YrhBfz+RFr9jZ82VK9nrOvqKE9hnZwzqsLbo
         2HS4o7Q7/NIQL3sWzIj794somI7G619oPA9P3W6gFVvX8gpuK60O9YsVC75QDMHlTR
         3f5SwgqOGVBEUDfHSY5XzzxiD54ZvnEjzzWy0S80A9Mcs4FPcV9xDJ3WW4zU1hfxd2
         Azn8NhIuaRm7MCDLYCEsSGJEK/XMASGJDyXAnV57Pt48Utnv4mDUAmYNYssCFhngAU
         w/qIem7yVEVrQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id C65C45C034B; Mon, 14 Feb 2022 06:49:20 -0800 (PST)
Date:   Mon, 14 Feb 2022 06:49:20 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Yu Liao <liaoyu15@huawei.com>, linux-kernel@vger.kernel.org,
        liwei391@huawei.com, rcu@vger.kernel.org
Subject: Re: Question about nohz and sysidle
Message-ID: <20220214144920.GW4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <b881759b-d281-fdc3-71b7-4429d84cd734@huawei.com>
 <b6dc758b-492d-1000-24e5-643e38d3166e@huawei.com>
 <20220214105744.GA663287@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220214105744.GA663287@lothringen>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2022 at 11:57:44AM +0100, Frederic Weisbecker wrote:
> On Mon, Feb 14, 2022 at 05:40:55PM +0800, Yu Liao wrote:
> 
> Hi Yu Liao,
> 
> > 
> > On 2022/2/14 16:28, Yu Liao wrote:
> > > Hi Frederic,
> > > 
> > > I'm working on an issue about nohz. When NO_HZ_FULL is enabled, CPU 0
> > > handles the timekeeping duty on behalf of all other CPUs, which means
> > > CPU 0 never stop tick even in sysidle state. This is a powersaving
> > > issue.
> > > 
> > > I found your patchset (nohz: Support sysidle) in the below link.
> > > https://lore.kernel.org/all/1406569056-30217-1-git-send-email-fweisbec@gmail.com/
> > > 
> > > But these patches haven't been merged into mainline yet and sysidle
> > > state detection has been removed by commit fe5ac724d81a (rcu: Remove
> > > nohz_full full-system-idle state machine) as well.
> > > 
> > > I tried your patches and it does work, why are we no longer working on
> > > stopping timekeeping duty when all full dynticks CPUs are idle?
> 
> Because it was not a priority at that time. There were so many things to handle
> first (and we are not even done yet) that we postponed that feature until
> someone ever comes up with powersaving issues on nohz_full. We were waiting for
> you :)
> 
> It's possible to unearth this. I think the first step will be to merge the
> RCU dynticks counters into context tracking, something that was on my queue
> anyway, and then revive this:
> 
> 	https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/commit/?h=sysidle.2017.05.11a&id=fe5ac724d81a3c7803e60c2232718f212f3f38d4

Given a valid use case, getting that functionality back would be fine
by me.  But yes, properly merging RCU dynticks into context tracking
would reduce the resulting idle-entry/exit performance penalty, so it
would be good to do that first.

							Thanx, Paul
