Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2177521D49
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 16:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345381AbiEJPBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 11:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345495AbiEJPBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 11:01:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3097A2BE532;
        Tue, 10 May 2022 07:24:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F170A6178F;
        Tue, 10 May 2022 14:24:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D559C385A6;
        Tue, 10 May 2022 14:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652192657;
        bh=Pc46AuG13t873MQN9JMMXmwCqYFzgX3gktX+Clx2xJ0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=SgRYJI5+Fy88ZZRFej4EMh0HZBYJwKDdgfnTD7JllCWtmfJG++8Qg6D1kkBXms5Dr
         HCzm1pcepruOinNgMjLnEkqvH03MHvjRYds9S63IhpB6BopivPO9A9ZCu+j0h4DidW
         pMohA3xAwQTj9WL+tuvKJp6uaASmRDEF+vOfJ1yla+KV68bzlcbz5LYfLtHrh+b7u+
         vE35wr2N1sSiYYi3wWerICw5+fmA52qHEJ7YQhSvv2aoqaHbZxclXpLgPd83JytVqf
         DkHBTNBCPiu1qdWhark0xD/yvhCQFh/gXKmQI0ejvkE4bHb2H1MRvSwIjw40Elrpst
         i0WCtlJdzdoJQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id E425A5C0602; Tue, 10 May 2022 07:24:16 -0700 (PDT)
Date:   Tue, 10 May 2022 07:24:16 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Alison Chaiken <achaiken@aurora.tech>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraj.iitr10@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH] rcu/nocb: Add an option to ON/OFF an offloading from RT
 context
Message-ID: <20220510142416.GR1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220507223247.GK1790663@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YSyYRSRQwfMTJU1dowMaxrj6Daa17-BMx4syoPV05bZFg@mail.gmail.com>
 <20220508213222.GL1790663@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YQ9t8gxp9cKCpba+e4NZ6ohPr8jHxJYuqRBFRtvSDa0Lw@mail.gmail.com>
 <20220509033740.GM1790663@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YSbWetMt2_-m4G9Nt5S8ybATihB+5FMJMMo3jKDG4pPjg@mail.gmail.com>
 <20220509181417.GO1790663@paulmck-ThinkPad-P17-Gen-1>
 <YnldSkaWu40cVimj@pc638.lan>
 <20220509183934.GQ1790663@paulmck-ThinkPad-P17-Gen-1>
 <20220510100946.5fdff700@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220510100946.5fdff700@gandalf.local.home>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2022 at 10:09:46AM -0400, Steven Rostedt wrote:
> On Mon, 9 May 2022 11:39:34 -0700
> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
> > This allows your current RCU_NOCB_CPU_CB_BOOST with something like
> > this in place of the "default n":
> > 
> > 	default y if PREEMPT_RT
> > 	default n if !PREEMPT_RT
> 
> BTW, I don't think you need the !PREEMPT_RT, because all configs are
> 'n' by  default. That is:
> 
> 	default y if PREEMPT_RT
> 
> should be good enough.

Good point, thank you!

That said, there is a lot of "default n" in a lot of Kconfig files.
And I am OK making this explicit.  So Uladzislau's choice.  ;-)

							Thanx, Paul
