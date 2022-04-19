Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF5C25064DD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 08:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349003AbiDSG4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 02:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232364AbiDSG4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 02:56:21 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4756C275D7;
        Mon, 18 Apr 2022 23:53:40 -0700 (PDT)
Date:   Tue, 19 Apr 2022 08:53:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650351218;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VfB/lFbbIaTLc4JYRRlIfza6c66g4liJ7vVzC2/CPZI=;
        b=m2rXdSBW8SVFqLQ/JmJnhUnyHB6UN0seD8/VXjF/vOIMr8QJ0cVypZv/EWlVzCXXYcNLxW
        Q+5UuOwE7FYzs7Rar7HQQOgCZq13MUXT9sfuFVLYeg1zNnv8yGRJ4tLmEHjFyAFtvO5Olj
        2mRfU3SVYQkXYr5/p3SnbwoIybAcMffQEQlc4InX0Mp+iEfTlD04z6EdWllwrpNpEH9Q9d
        PCdmbUm1ZM24haDPDb3QnDetqz3se0GqVj4CG91OeiOwYyzRD+utuz4orG6DffE2/+OHrA
        ycX2mzw5f9mhyiDQB1hArrzVSabPTLitiQTHJCTNj5se8bQuXj/ZH8W8Sr+OWg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650351218;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VfB/lFbbIaTLc4JYRRlIfza6c66g4liJ7vVzC2/CPZI=;
        b=SRktH1B6xJ1k5gevnlUWN3E/MArZVAeyZiADNxZ5ea2fdkU8LGaQ2IAFX2l2oym1TXFQek
        4K5mK8MeCpTH6DBQ==
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
To:     "Paul E. McKenney" <paulmck@kernel.org>
cc:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Benedikt Spranger <b.spranger@linutronix.de>
Subject: Re: [PATCH] rcu/torture: Change order of warning and trace dump
In-Reply-To: <20220412152501.GA2557395@paulmck-ThinkPad-P17-Gen-1>
Message-ID: <alpine.DEB.2.21.2204190829070.1508@somnus>
References: <20220411151903.28167-1-anna-maria@linutronix.de> <20220411180915.GY4285@paulmck-ThinkPad-P17-Gen-1> <20220412152501.GA2557395@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Apr 2022, Paul E. McKenney wrote:

> On Mon, Apr 11, 2022 at 11:09:15AM -0700, Paul E. McKenney wrote:
> > On Mon, Apr 11, 2022 at 05:19:03PM +0200, Anna-Maria Behnsen wrote:
> > > Dumping a big ftrace buffer could lead to a RCU stall. So there is the
> > > ftrace buffer and the stall information which needs to be printed. When
> > > there is additionaly a WARN_ON() which describes the reason for the ftrace
> > > buffer dump and the WARN_ON() is executed _after_ ftrace buffer dump, the
> > > information get lost in the middle of the RCU stall information.
> > > 
> > > Therefore print WARN_ON() message before dumping the ftrace buffer in
> > > rcu_torture_writer().
> > > 
> > > Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
> > > Reviewed-by: Benedikt Spranger <b.spranger@linutronix.de>
> > 
> > Hello, Anna-Maria!
> > 
> > Good point, but we get caught out either way.  Either we take the chance
> > of losing the WARN() message as you say, or we take the chance of the
> > activity in the WARN() message overwriting needed information in the
> > trace buffer.
> > 
> > Would it work to shut off tracing, do the WARN(), and only then do the
> > rcu_ftrace_dump()?
> 
> And presumably you are looking at this because your testing is
> triggering it.  This WARN() assumes that the system running rcutorture
> is otherwise idle.  If you are (say) running kernel builds while also
> running rcutorture, then this WARN() is expected behavior.  So if you need
> this sort of testing, we need do something like adding another rcutorture
> module parameter (background_load?) that suppresses this warning.
> 

I ran into this while testing with rcutorture kvm script. And I was the
only one working on the machine. So I do not need a parameter right
now. I'll come back to you when my testing requirements will change :)

Thanks,

	Anna-Maria

