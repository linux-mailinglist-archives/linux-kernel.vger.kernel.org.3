Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1120A506F4D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 15:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347187AbiDSNvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 09:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352977AbiDSNvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 09:51:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A41E3CFDF;
        Tue, 19 Apr 2022 06:44:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 02193B8198A;
        Tue, 19 Apr 2022 13:44:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7769C385A5;
        Tue, 19 Apr 2022 13:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650375856;
        bh=IEvf1VadfccjTgyuZD9eFHxT3pNqruiC9nzVFI5CI6M=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=quAd3JUEJ3SjxeMFe61q1dJObQpSNjhpPWicWxr++OuHjdVpjb8bY64SeV8mf5pnF
         z307sYWBRu9w1cDAb4ks/4geT6NANLgf+gTqGi3j6S+v/mUNU3/b6jIGSLU9XV0C4K
         emXeOmviONadN21B1D0Vc/iBWTC504ffUykLvDvtyxc3q5XQRwTJCS52ytgiypBgbx
         GQvphiKOC+QZXsuPtRpDmfph+y3LqhM4vqqC7QkZOGafv0ZrVRYNSUPt4lGatgeFDo
         bryo/pI+Pkyd4tE6qjuvteZcM33ORvZOWAFyiI2HGfsPmWfFddLyEV4yQtFLz1ilFc
         81y3J5WwY5nFw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 549EA5C0387; Tue, 19 Apr 2022 06:44:16 -0700 (PDT)
Date:   Tue, 19 Apr 2022 06:44:16 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Benedikt Spranger <b.spranger@linutronix.de>
Subject: Re: [PATCH] rcu/torture: Change order of warning and trace dump
Message-ID: <20220419134416.GD4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220411151903.28167-1-anna-maria@linutronix.de>
 <20220411180915.GY4285@paulmck-ThinkPad-P17-Gen-1>
 <20220412152501.GA2557395@paulmck-ThinkPad-P17-Gen-1>
 <alpine.DEB.2.21.2204190829070.1508@somnus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2204190829070.1508@somnus>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2022 at 08:53:38AM +0200, Anna-Maria Behnsen wrote:
> On Tue, 12 Apr 2022, Paul E. McKenney wrote:
> 
> > On Mon, Apr 11, 2022 at 11:09:15AM -0700, Paul E. McKenney wrote:
> > > On Mon, Apr 11, 2022 at 05:19:03PM +0200, Anna-Maria Behnsen wrote:
> > > > Dumping a big ftrace buffer could lead to a RCU stall. So there is the
> > > > ftrace buffer and the stall information which needs to be printed. When
> > > > there is additionaly a WARN_ON() which describes the reason for the ftrace
> > > > buffer dump and the WARN_ON() is executed _after_ ftrace buffer dump, the
> > > > information get lost in the middle of the RCU stall information.
> > > > 
> > > > Therefore print WARN_ON() message before dumping the ftrace buffer in
> > > > rcu_torture_writer().
> > > > 
> > > > Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
> > > > Reviewed-by: Benedikt Spranger <b.spranger@linutronix.de>
> > > 
> > > Hello, Anna-Maria!
> > > 
> > > Good point, but we get caught out either way.  Either we take the chance
> > > of losing the WARN() message as you say, or we take the chance of the
> > > activity in the WARN() message overwriting needed information in the
> > > trace buffer.
> > > 
> > > Would it work to shut off tracing, do the WARN(), and only then do the
> > > rcu_ftrace_dump()?
> > 
> > And presumably you are looking at this because your testing is
> > triggering it.  This WARN() assumes that the system running rcutorture
> > is otherwise idle.  If you are (say) running kernel builds while also
> > running rcutorture, then this WARN() is expected behavior.  So if you need
> > this sort of testing, we need do something like adding another rcutorture
> > module parameter (background_load?) that suppresses this warning.
> 
> I ran into this while testing with rcutorture kvm script. And I was the
> only one working on the machine. So I do not need a parameter right
> now. I'll come back to you when my testing requirements will change :)

Sounds good, and thank you for the info!

							Thanx, Paul
