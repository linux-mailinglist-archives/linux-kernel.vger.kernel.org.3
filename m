Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3870463DF8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 19:44:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245566AbhK3SrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 13:47:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239001AbhK3SrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 13:47:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54444C061574;
        Tue, 30 Nov 2021 10:44:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BA652B818F9;
        Tue, 30 Nov 2021 18:44:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 755BEC53FCC;
        Tue, 30 Nov 2021 18:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638297841;
        bh=yzwzdvZPVaXvumoAuMDXivXL3sY8OxSX0FQtSCsIB1Q=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Oxq2g5zyWfwC6jHkw/kNS3pL7MMvPQBBhlu3nEGppKb41J6xw3meGxedtYWyJXp88
         8uQqluaB8OG3yu1Xu8GW78URZL2YJGfYfNDmy/10jXswPZ0Ef8iVnyoZWDI9CHsS7x
         p1tiiwWsP8W9X0TK6ElbI8wlft2PHkOjogf7RE5ukfSezyk1BBiTG/Fwl9gmpYc07u
         hnELVr2LTQRfBo3tXYNjNr0eiDBvd12Pj4S9cgSziyncVQgePZO/VzyFagqID8PRYF
         NVAxNz03RYqOcUtTSKtDJsaN+Pnvzdky/STxkgNbYM1gl5O7zMuuMsfyU38u1nPx+C
         vq/4DMutPVKyA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 3ADC95C0367; Tue, 30 Nov 2021 10:44:01 -0800 (PST)
Date:   Tue, 30 Nov 2021 10:44:01 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Neeraj Upadhyay <quic_neeraju@quicinc.com>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: Re: [PATCH] rcu/exp: Mark current CPU as exp-QS in IPI loop second
 pass
Message-ID: <20211130184401.GX641268@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20211130162108.605092-1-frederic@kernel.org>
 <dee700be-bad1-e497-ccfc-916b98d7d593@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dee700be-bad1-e497-ccfc-916b98d7d593@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 10:31:57PM +0530, Neeraj Upadhyay wrote:
> 
> 
> On 11/30/2021 9:51 PM, Frederic Weisbecker wrote:
> > While looping through the rnp's CPUs to IPI for an expedited grace
> > period, a first pass excludes the current CPU and the CPUs in dynticks
> > idle mode. The workqueue will report their QS on their behalf later.
> > 
> > The second pass processes the IPIs and also ignores the current CPU,
> > assuming it has been previously included in the group of CPUs whose
> > QS are to be reported by the workqueue.
> > 
> > Unfortunately the current CPU may have changed between the first and
> > second pass, due to the rnp lock being dropped, re-enabling preemption.
> > As a result the current CPU, if different in the second pass, may be
> > ignored by the expedited grace period. No IPI will be sent to it
> > so it won't be requested to report an expedited quiescent state.
> > 
> > This ends up in an expedited grace period stall.
> > 
> > Fix this with including the current CPU in the second round in the group
> > of CPUs to report a QS for by the workqueue.
> > 
> > Fixes: b9ad4d6ed18e ("rcu: Avoid self-IPI in sync_rcu_exp_select_node_cpus()")
> > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > Cc: Uladzislau Rezki <urezki@gmail.com>
> > Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
> > Cc: Boqun Feng <boqun.feng@gmail.com>
> > Cc: Josh Triplett <josh@joshtriplett.org>
> > Cc: Joel Fernandes <joel@joelfernandes.org>
> > ---
> 
> Reviewed-by: Neeraj Upadhyay <quic_neeraju@quicinc.com>

Applied, thank you both!

							Thanx, Paul

> Thanks
> Neeraj
> 
> 
> >   kernel/rcu/tree_exp.h | 1 +
> >   1 file changed, 1 insertion(+)
> > 
> > diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> > index a96d17206d87..237a79989aba 100644
> > --- a/kernel/rcu/tree_exp.h
> > +++ b/kernel/rcu/tree_exp.h
> > @@ -387,6 +387,7 @@ static void sync_rcu_exp_select_node_cpus(struct work_struct *wp)
> >   			continue;
> >   		}
> >   		if (get_cpu() == cpu) {
> > +			mask_ofl_test |= mask;
> >   			put_cpu();
> >   			continue;
> >   		}
> > 
