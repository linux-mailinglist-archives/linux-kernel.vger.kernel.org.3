Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B39E95529B2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 05:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244449AbiFUDPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 23:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242106AbiFUDPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 23:15:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE5751FCC9;
        Mon, 20 Jun 2022 20:15:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 707146102F;
        Tue, 21 Jun 2022 03:15:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA802C3411B;
        Tue, 21 Jun 2022 03:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655781349;
        bh=DWJ7U3bJ5onh5qejtXviF2uTYPEnnM4yUBhRX9yiw0k=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=m6Gn6VMkawK3Qd/gva8YurTcNnh44llHBPWLPqR7XY90KhXnLuJTVnJZcTOM1dkMf
         dcQvWtLUtFsW0JTxAF9nzgDIq9Fk5YJ92oKnScJ8InGo9QkPw61QJHPqnf+s8Z5+nY
         SuZywUIx5Eysr1K+7gpsR7O48SR62JUwyFOXPx4BzZvw3hGOKnHiM9uiCv9vCxFZHt
         3A6O492NTIIOyeA2VzpHl8hnpUtE1Ee86KrzdVmuDTrwJmEPVNc39tODYgKcjx6GcD
         4X8HEps/Oe1aYAqzHwGyYuVvWNhjqWc/hmqWRfd7Tq16rYdIpR7Pl2fMfAe7FSjZGl
         nY6LMFJs6/guQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 63DA75C0531; Mon, 20 Jun 2022 20:15:49 -0700 (PDT)
Date:   Mon, 20 Jun 2022 20:15:49 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Zhangfei Gao <zhangfei.gao@linaro.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, rostedt@goodmis.org,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH rcu 12/12] srcu: Block less aggressively for expedited
 grace periods
Message-ID: <20220621031549.GC1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220620222022.GA3839466@paulmck-ThinkPad-P17-Gen-1>
 <20220620222032.3839547-12-paulmck@kernel.org>
 <6b89e108-69e1-5fe2-67ba-3dac9ec60f83@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6b89e108-69e1-5fe2-67ba-3dac9ec60f83@linaro.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2022 at 10:00:07AM +0800, Zhangfei Gao wrote:
> 
> 
> On 2022/6/21 上午6:20, Paul E. McKenney wrote:
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
> 
> Test on 5.19-rc1 with this patch with qemu boot with -bios QEMU_EFI-2022.fd,
> seems not work, same as rc1.
> 
> real    2m42.948s
> user    0m2.843s
> sys     0m1.170s
> 
> qemu: stable-6.1
> 
> build/aarch64-softmmu/qemu-system-aarch64 -machine
> virt,gic-version=3,iommu=smmuv3 \
> -enable-kvm -cpu host -m 1024 \
> -kernel /home/linaro/Image -initrd /home/linaro/tmp/ramdisk-new.img
> -nographic -append \
> "rdinit=init console=ttyAMA0 earlycon=pl011,0x9000000 kpti=off acpi=force" \
> -bios QEMU_EFI-2022.fd

Understood.  This patch fixes some cases, but not your case.  Which is
why you guys are experimenting with additional changes.  In the meantime,
this patch helps at least some people.  I look forward to you guys have
an appropriate solution that I can pull in on top of this one.

Or, if the solution shows up quickly enough, I can replace this patch
with your guys' solution.

							Thanx, Paul

> Thanks
> > ---
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
> 
