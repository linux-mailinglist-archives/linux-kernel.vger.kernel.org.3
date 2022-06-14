Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB7154B300
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 16:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343601AbiFNORu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 10:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243464AbiFNORU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 10:17:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD51633369;
        Tue, 14 Jun 2022 07:17:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 46C90B81884;
        Tue, 14 Jun 2022 14:17:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E947BC3411B;
        Tue, 14 Jun 2022 14:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655216233;
        bh=tYNgbjUfrjSeCeaqOE2KwZiNed7+BUPn3hOIyTA2PdY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=BIlLtMV51qW4D/04XC51Fsswc4qnqb5TDqXUDIupz4Q1q2oIhlNSxI4L87e2sBiYN
         VeUvJ7mSDX6ALRH0Zo8Rv7k2t/B8cEtuPvwOp0ux6JMojYPgN7SfrmHunduVpH/qZv
         9x3Scoh66ynTBbptkNINmCIpJ+iUiDls70ryW0A1pdGmTecGSWs2cpRYdrN0PjPIJP
         qlr7IXfGWhe6INBsLMp6Lbsi6oT9o2J+1VaJ+/VMKBRFKAiHcAkLPLdGHXAQlpIDNy
         dww3VbxGHkSk+dMQn3xBGB2bdTs+kiW9cF4GLGuQvM/7X+RsgVinGk9QRwgs2upqBR
         RGbAeGKZV2+9Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 8D6D55C0678; Tue, 14 Jun 2022 07:17:12 -0700 (PDT)
Date:   Tue, 14 Jun 2022 07:17:12 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "zhangfei.gao@foxmail.com" <zhangfei.gao@foxmail.com>
Cc:     Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Matthew Wilcox <willy@infradead.org>,
        "mtosatti@redhat.com" <mtosatti@redhat.com>,
        Auger Eric <eric.auger@redhat.com>,
        "chenxiang (M)" <chenxiang66@hisilicon.com>
Subject: Re: Commit 282d8998e997 (srcu: Prevent expedited GPs and blocking
 readers from consuming CPU) cause qemu boot slow
Message-ID: <20220614141712.GR1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <tencent_E306F58EAEC1D188ED6D5F358A269F34C707@qq.com>
 <20220613035711.GY1790663@paulmck-ThinkPad-P17-Gen-1>
 <20220613041652.GA3976000@paulmck-ThinkPad-P17-Gen-1>
 <tencent_F82250B6E3D51A9AC0D2BE1AE43A4E060909@qq.com>
 <20220613121831.GA1790663@paulmck-ThinkPad-P17-Gen-1>
 <tencent_65C7D0A04984EDB6A79A5E5379DA7E835206@qq.com>
 <20220613145900.GC1790663@paulmck-ThinkPad-P17-Gen-1>
 <7b6c983b21d44119b61716a66de397ed@huawei.com>
 <f9684a69-5467-a440-abd1-7cf5ad3a81f7@quicinc.com>
 <tencent_8FD344DA7FC376C7D1204604DA7689DA4906@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tencent_8FD344DA7FC376C7D1204604DA7689DA4906@qq.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2022 at 10:03:35PM +0800, zhangfei.gao@foxmail.com wrote:
> 
> 
> On 2022/6/14 下午8:19, Neeraj Upadhyay wrote:
> > 
> > > 
> > > 5.18-rc4 based               ~8sec
> > > 
> > > 5.19-rc1                     ~2m43sec
> > > 
> > > 5.19-rc1+fix1                 ~19sec
> > > 
> > > 5.19-rc1-fix2                 ~19sec
> > > 
> > 
> > If you try below diff on top of either 5.19-rc1+fix1 or 5.19-rc1-fix2 ;
> > does it show any difference in boot time?
> > 
> > --- a/kernel/rcu/srcutree.c
> > +++ b/kernel/rcu/srcutree.c
> > @@ -706,7 +706,7 @@ static void srcu_schedule_cbs_snp(struct srcu_struct
> > *ssp, struct srcu_node *snp
> >   */
> >  static void srcu_gp_end(struct srcu_struct *ssp)
> >  {
> > -       unsigned long cbdelay;
> > +       unsigned long cbdelay = 1;
> >         bool cbs;
> >         bool last_lvl;
> >         int cpu;
> > @@ -726,7 +726,9 @@ static void srcu_gp_end(struct srcu_struct *ssp)
> >         spin_lock_irq_rcu_node(ssp);
> >         idx = rcu_seq_state(ssp->srcu_gp_seq);
> >         WARN_ON_ONCE(idx != SRCU_STATE_SCAN2);
> > -       cbdelay = !!srcu_get_delay(ssp);
> > +       if (ULONG_CMP_LT(READ_ONCE(ssp->srcu_gp_seq),
> > READ_ONCE(ssp->srcu_gp_seq_needed_exp)))
> > +               cbdelay = 0;
> > +
> >         WRITE_ONCE(ssp->srcu_last_gp_end, ktime_get_mono_fast_ns());

Thank you both for the testing and the proposed fix!

> Test here:
> qemu: https://github.com/qemu/qemu/tree/stable-6.1
> kernel:
> https://github.com/Linaro/linux-kernel-uadk/tree/uacce-devel-5.19-srcu-test
> (in case test patch not clear, push in git tree)
> 
> Hardware: aarch64
> 
> 1. 5.18-rc6
> real    0m8.402s
> user    0m3.015s
> sys     0m1.102s
> 
> 2. 5.19-rc1
> real    2m41.433s
> user    0m3.097s
> sys     0m1.177s
> 
> 3. 5.19-rc1 + fix1 from Paul
> real    2m43.404s
> user    0m2.880s
> sys     0m1.214s
> 
> 4. 5.19-rc1 + fix2: fix1 + Remove "if (!jbase)" block
> real    0m15.262s
> user    0m3.003s
> sys     0m1.033s
> 
> When build kernel in the meantime, load time become longer.
> 
> 5. 5.19-rc1 + fix3: fix1 + SRCU_MAX_NODELAY_PHASE 1000000
> real    0m15.215s
> user    0m2.942s
> sys    0m1.172s
> 
> 6. 5.19-rc1 + fix4: fix1 + Neeraj's change of srcu_gp_end　
> real    1m23.936s
> user    0m2.969s
> sys    0m1.181s

And thank you for the testing!

Could you please try fix3 + Neeraj's change of srcu_gp_end?

That is, fix1 + SRCU_MAX_NODELAY_PHASE 1000000 + Neeraj's change of
srcu_gp_end.

Also, at what value of SRCU_MAX_NODELAY_PHASE do the boot
times start rising?  This is probably best done by starting with
SRCU_MAX_NODELAY_PHASE=100000 and dividing by (say) ten on each run
until boot time becomes slow, followed by a binary search between the
last two values.  (The idea is to bias the search so that fast boot
times are the common case.)

> More test details: https://docs.qq.com/doc/DRXdKalFPTVlUbFN5

And thank you for these details.

							Thanx, Paul
