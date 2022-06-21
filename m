Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80013553D52
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 23:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355224AbiFUVP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 17:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356700AbiFUVOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 17:14:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20FA3344D7;
        Tue, 21 Jun 2022 14:01:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1EB9660E17;
        Tue, 21 Jun 2022 21:01:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80709C3411C;
        Tue, 21 Jun 2022 21:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655845263;
        bh=WT4SOxCLaIR0gYHkVAL25jmyZOnuo2xSnBmePJjtpcw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=l5PqjmlAOTto2xaG15RwrnEcOogpugolWBH0n4c3mOytGz46EH8i/lhp5y4BVI8IE
         qbQnOSFqxn2oB3xSWSVE0KgOtWEoifbD4+i/GcnZkXgKn7FAHoR+AcZ+VyK8+Jy40B
         l4g+duaq4NnY4yknd9ia9kuLwynS5qO2SstmrlYre5i9KlQa0jviCAgRIvnhZTv6jZ
         kdWLDB+VA7kGaZVNp+xBcEl1J88HdAXIiEm5uK6qOep9DjbBW/TqzvW1z5/RRPixEl
         6OZAc1LmnG/vd7bIFF1snYLc7xgMMMlnOvXgz4B5/aLCdqVvC116Nnofj+Q5A51Awf
         9CNWe+Us1XcaQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 184435C0AE0; Tue, 21 Jun 2022 14:01:03 -0700 (PDT)
Date:   Tue, 21 Jun 2022 14:01:03 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, rostedt@goodmis.org
Subject: Re: [PATCH rcu 11/12] torture: Flush printk() buffers before
 powering off
Message-ID: <20220621210103.GO1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220620225814.GA3842995@paulmck-ThinkPad-P17-Gen-1>
 <20220620225817.3843106-11-paulmck@kernel.org>
 <8735fyc42v.fsf@jogness.linutronix.de>
 <20220620232838.GZ1790663@paulmck-ThinkPad-P17-Gen-1>
 <87v8suphdy.fsf@jogness.linutronix.de>
 <20220621181335.GJ1790663@paulmck-ThinkPad-P17-Gen-1>
 <87ilotagdw.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ilotagdw.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLACK autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2022 at 10:58:27PM +0206, John Ogness wrote:
> On 2022-06-21, "Paul E. McKenney" <paulmck@kernel.org> wrote:
> > The patch below will cause rcutorture to implicitly test this
> > functionality, unless told otherwise, for example, by using the
> > --bootargs "torture.printk_shutdown_bug_workaround" kvm.sh
> > argument.
> >
> > Thoughts?
> 
> I feel like this is dirtying the torture.* bootarg namespace a
> bit. Also, I am not sure how useful it is as a dynamic option. I assume
> that users would generally avoid using it, so its very existence might
> just be more noise in the documentation and code. It is an unusual
> feature:
> 
> "In case some bug shows up, here is a flag to avoid it."
> 
> I personally would just drop the patch and rely on a correctly
> functional kernel. But I am also not an rcutorture user. If _you_ think
> that such a flag is useful, feel free to include the patch.

Fair points!

The main value to me is to avoid me having to pile through code to relearn
the incantation pr_flush(1000, true).  Which, now that you mention it,
could be dealt with by adding a comment:

	// pr_flush(1000, true); // If needed to flush printk() buffers.

This definitely will not go into the upcoming merge window, so there is
plenty of time to give it some thought.

> > commit 204bf1e2a5a2fb68c15b4b64793ad0896db6f705
> > Author: Paul E. McKenney <paulmck@kernel.org>
> > Date:   Tue Jun 21 11:02:25 2022 -0700
> >
> >     torture: Optionally flush printk() buffers before powering off
> >     
> >     The rcutorture test suite produces quite a bit of console output at
> >     the end of a test.  This means that the new-in-2022 printk() kthreads
> >     are likely to be in the process of flushing output at the time of the
> >     torture_shutdown() function's call to kernel_power_off().  Normally,
> >     rcutorture relies on printk() to flush any pending output upon shutdown,
> >     the better to detect bugs in this area, for example, the one introduced
> >     by 8e274732115f ("printk: extend console_lock for per-console locking").
> >     However, once such a bug is detected and reported, it is necessary to
> >     test the rest of the system, without noise from the already-reported bug.
> >     
> >     This commit therefore adds a torture.printk_shutdown_bug_workaround
> >     kernel parameter, which causes torture_shutdown() to invoke pr_flush(),
> >     and print an informative message on the console, immediately before
> >     invoking kernel_power_off().  When this kernel parameter is not specified,
> >     it is up to printk() to flush its own buffers.
> >     
> >     Suggested-by: John Ogness <john.ogness@linutronix.de>
> >     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> Reviewed-by: John Ogness <john.ogness@linutronix.de>

Thank you!

							Thanx, Paul
