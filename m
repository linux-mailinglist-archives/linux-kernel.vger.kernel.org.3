Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1806553E73
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 00:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346787AbiFUW0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 18:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231383AbiFUW0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 18:26:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BC23313A5;
        Tue, 21 Jun 2022 15:25:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1018CB80F63;
        Tue, 21 Jun 2022 22:25:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8913C3411C;
        Tue, 21 Jun 2022 22:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655850356;
        bh=6O0+TGIwhmpdb4aH1hAuYD76++tmQ0QMm74jwV5F4KQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=JiWXTRyFAsQh0irt2QPi+JG32rA4bNgQLIMD4oiX3uiB6IiT79pjmW1+JaT4LeQqj
         0nE6MgKGTWSW9c4LsEisfEglZLXouRr2GrTxx4B8Mm7v4tQcBTYghCRCZ37yH1Sx7C
         27In1BK1hiQ1TWqHCS43BRJaZI8nexEQXiPT02mZbsYU00BMbe/JrIeEPHF1eeRvdT
         V0ayNXjZeTy09sjKbYQWsPn7WoIqMcXymVIM8W5LNy07+IV82qUvgC2Gc/tBkOvBc3
         5wURTl+fzF5L16sMU5lXsrml/z2rKHHAfnkWJsPkEari0/oAyguf+MT8Bgj/0eZQ0q
         Ahuj4+5tYw79A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 5980C5C0AE0; Tue, 21 Jun 2022 15:25:56 -0700 (PDT)
Date:   Tue, 21 Jun 2022 15:25:56 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Neeraj Upadhyay <quic_neeraju@quicinc.com>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, rostedt@goodmis.org,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH rcu 12/12] srcu: Block less aggressively for expedited
 grace periods
Message-ID: <20220621222556.GU1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220620222022.GA3839466@paulmck-ThinkPad-P17-Gen-1>
 <20220620222032.3839547-12-paulmck@kernel.org>
 <248317a0-2ef4-c619-15b5-84e2b62aab5e@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <248317a0-2ef4-c619-15b5-84e2b62aab5e@quicinc.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2022 at 03:43:30PM +0530, Neeraj Upadhyay wrote:
> 
> 
> On 6/21/2022 3:50 AM, Paul E. McKenney wrote:
> > Commit 282d8998e997 ("srcu: Prevent expedited GPs and blocking readers
> > from consuming CPU") fixed a problem where a long-running expedited SRCU
> > grace period could block kernel live patching.  It did so by giving up
> > on expediting once a given SRCU expedited grace period grew too old.
> > 
> > Unfortunately, this added excessive delays to boots of embedded systems
> > running on qemu that use the ARM IORT RMR feature.  This commit therefore
> > makes the transition away from expediting less aggressive, increasing
> > the per-grace-period phase number of non-sleeping polls of readers from
> > one to three and increasing the required grace-period age from one jiffy
> > (actually from zero to one jiffies) to two jiffies (actually from one
> > to two jiffies).
> > 
> > Fixes: 282d8998e997 ("srcu: Prevent expedited GPs and blocking readers from consuming CPU")
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > Reported-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> > Reported-by: chenxiang (M)" <chenxiang66@hisilicon.com>
> > Cc: Shameerali Kolothum Thodi  <shameerali.kolothum.thodi@huawei.com>
> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > Link: https://lore.kernel.org/all/20615615-0013-5adc-584f-2b1d5c03ebfc@linaro.org/
> > ---
> 
> 
> Reviewed-by: Neeraj Upadhyay <quic_neeraju@quicinc.com>

And I applied your Reviewed-by to the other commits you gave it for,
and thank you very much!  Much nicer to fix the bugs now than to have
to do separate patches for them later.  ;-)

							Thanx, Paul

> Thanks
> Neeraj
> 
> >   kernel/rcu/srcutree.c | 20 +++++++++++++-------
> >   1 file changed, 13 insertions(+), 7 deletions(-)
> > 
> > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > index 50ba70f019dea..0db7873f4e95b 100644
> > --- a/kernel/rcu/srcutree.c
> > +++ b/kernel/rcu/srcutree.c
> > @@ -513,7 +513,7 @@ static bool srcu_readers_active(struct srcu_struct *ssp)
> >   #define SRCU_INTERVAL		1	// Base delay if no expedited GPs pending.
> >   #define SRCU_MAX_INTERVAL	10	// Maximum incremental delay from slow readers.
> > -#define SRCU_MAX_NODELAY_PHASE	1	// Maximum per-GP-phase consecutive no-delay instances.
> > +#define SRCU_MAX_NODELAY_PHASE	3	// Maximum per-GP-phase consecutive no-delay instances.
> >   #define SRCU_MAX_NODELAY	100	// Maximum consecutive no-delay instances.
> >   /*
> > @@ -522,16 +522,22 @@ static bool srcu_readers_active(struct srcu_struct *ssp)
> >    */
> >   static unsigned long srcu_get_delay(struct srcu_struct *ssp)
> >   {
> > +	unsigned long gpstart;
> > +	unsigned long j;
> >   	unsigned long jbase = SRCU_INTERVAL;
> >   	if (ULONG_CMP_LT(READ_ONCE(ssp->srcu_gp_seq), READ_ONCE(ssp->srcu_gp_seq_needed_exp)))
> >   		jbase = 0;
> > -	if (rcu_seq_state(READ_ONCE(ssp->srcu_gp_seq)))
> > -		jbase += jiffies - READ_ONCE(ssp->srcu_gp_start);
> > -	if (!jbase) {
> > -		WRITE_ONCE(ssp->srcu_n_exp_nodelay, READ_ONCE(ssp->srcu_n_exp_nodelay) + 1);
> > -		if (READ_ONCE(ssp->srcu_n_exp_nodelay) > SRCU_MAX_NODELAY_PHASE)
> > -			jbase = 1;
> > +	if (rcu_seq_state(READ_ONCE(ssp->srcu_gp_seq))) {
> > +		j = jiffies - 1;
> > +		gpstart = READ_ONCE(ssp->srcu_gp_start);
> > +		if (time_after(j, gpstart))
> > +			jbase += j - gpstart;
> > +		if (!jbase) {
> > +			WRITE_ONCE(ssp->srcu_n_exp_nodelay, READ_ONCE(ssp->srcu_n_exp_nodelay) + 1);
> > +			if (READ_ONCE(ssp->srcu_n_exp_nodelay) > SRCU_MAX_NODELAY_PHASE)
> > +				jbase = 1;
> > +		}
> >   	}
> >   	return jbase > SRCU_MAX_INTERVAL ? SRCU_MAX_INTERVAL : jbase;
> >   }
