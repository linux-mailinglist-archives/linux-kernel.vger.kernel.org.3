Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD3857A4C4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 19:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238005AbiGSRPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 13:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbiGSRPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 13:15:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05D9145F5A;
        Tue, 19 Jul 2022 10:15:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A6D85B81C36;
        Tue, 19 Jul 2022 17:15:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50B5FC341C6;
        Tue, 19 Jul 2022 17:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658250948;
        bh=4X43Kx/zJCp1qP21ZCzYs7NFsjvKx83ugGlRc/nNIgA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=dgE4eHo76T5+G0UtZ8RrMi4BqBQbu0zZFDdSVMjefQha6m9wi20xahiTg6wmIX7k9
         UoStcv7mbSc8yPGN8lqh44+c4QsQR11YzW7BIo+VxhOL5MX4UYK4eaRg58VvkmT09X
         Tfhm7hRgKLIHdNvhqshWiakjBBslowGufrtiNsGueUAQOlQ77q8YSLVxdj6jLYbtEI
         Nna8Hcd0fdcMBaylOBabuit4x69uBUfhXeKz2R/WI9/lZ9N+lULIp4cBYjljZFX7ai
         IYkRr5sSHg9L6UZK5ohslOs2z/dsI6YJRT4+CB4fkCNcVMrgQcfBwZrZ8x+iIq7s0e
         KdmroxaHGKbGw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D43205C0813; Tue, 19 Jul 2022 10:15:47 -0700 (PDT)
Date:   Tue, 19 Jul 2022 10:15:47 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Neeraj Upadhyay <quic_neeraju@quicinc.com>, frederic@kernel.org,
        josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, linux-kernel@vger.kernel.org,
        zhangfei.gao@foxmail.com, boqun.feng@gmail.com, urezki@gmail.com,
        shameerali.kolothum.thodi@huawei.com, pbonzini@redhat.com,
        mtosatti@redhat.com, eric.auger@redhat.com,
        chenxiang66@hisilicon.com, zhangfei.gao@linaro.org,
        rcu@vger.kernel.org
Subject: Re: [PATCH v3] srcu: Reduce blocking agressiveness of expedited
 grace periods further
Message-ID: <20220719171547.GQ1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220701031545.9868-1-quic_neeraju@quicinc.com>
 <87o7xlzey3.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87o7xlzey3.wl-maz@kernel.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 19, 2022 at 09:25:56AM +0100, Marc Zyngier wrote:
> Hi folks,
> 
> On Fri, 01 Jul 2022 04:15:45 +0100,
> Neeraj Upadhyay <quic_neeraju@quicinc.com> wrote:
> > 
> > Commit 640a7d37c3f4 ("srcu: Block less aggressively for expedited
> > grace periods") highlights a problem where aggressively blocking
> > SRCU expedited grace periods, as was introduced in commit
> > 282d8998e997 ("srcu: Prevent expedited GPs and blocking readers
> > from consuming CPU"), introduces ~2 minutes delay to the overall
> > ~3.5 minutes boot time, when starting VMs with "-bios QEMU_EFI.fd"
> > cmdline on qemu, which results in very high rate of memslots
> > add/remove, which causes > ~6000 synchronize_srcu() calls for
> > kvm->srcu SRCU instance.
> > 
> > Below table captures the experiments done by Zhangfei Gao and Shameer
> > to measure the boottime impact with various values of non-sleeping
> > per phase counts, with HZ_250 and preemption enabled:
> > 
> > +──────────────────────────+────────────────+
> > | SRCU_MAX_NODELAY_PHASE   | Boot time (s)  |
> > +──────────────────────────+────────────────+
> > | 100                      | 30.053         |
> > | 150                      | 25.151         |
> > | 200                      | 20.704         |
> > | 250                      | 15.748         |
> > | 500                      | 11.401         |
> > | 1000                     | 11.443         |
> > | 10000                    | 11.258         |
> > | 1000000                  | 11.154         |
> > +──────────────────────────+────────────────+
> > 
> > Analysis on the experiment results showed improved boot time
> > with non blocking delays close to one jiffy duration. This
> > was also seen when number of per-phase iterations were scaled
> > to one jiffy.
> > 
> > So, this change scales per-grace-period phase number of non-sleeping
> > polls, such that, non-sleeping polls are done for one jiffy. In addition
> > to this, srcu_get_delay() call in srcu_gp_end(), which is used to calculate
> > the delay used for scheduling callbacks, is replaced with the check for
> > expedited grace period. This is done, to schedule cbs for completed expedited
> > grace periods immediately, which results in improved boot time seen in
> > experiments. Testing done by Marc and Zhangfei confirms that this change recovers
> > most of the performance degradation in boottime; for CONFIG_HZ_250 configuration,
> > boottime improves from 3m50s to 41s on Marc's setup; and from 2m40s to ~9.7s
> > on Zhangfei's setup.
> > 
> > In addition to the changes to default per phase delays, this change
> > adds 3 new kernel parameters - srcutree.srcu_max_nodelay,
> > srcutree.srcu_max_nodelay_phase, srcutree.srcu_retry_check_delay.
> > This allows users to configure the srcu grace period scanning delays,
> > depending on their system configuration requirements.
> > 
> > Signed-off-by: Neeraj Upadhyay <quic_neeraju@quicinc.com>
> > Tested-by: Marc Zyngier <maz@kernel.org>
> > Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> 
> Is there any chance for this fix to make it into 5.19? The regression
> is significant enough on low-end systems, and I'd rather see it
> addressed.

I wasn't planning on it, based on my (possibly quite flawed) assumption
that it affected only embedded systems running in a virtual environment.
My plan was to send it in my pull request for the next merge window
next week.  My pull request is next week, yes, the merge window opens
the following Sunday.  ;-)

It has a Fixes tag, so it will be backported.

But if it is important to get it into v5.19 rather than v5.19.x for small
"x", please let me know and I will see what Linus does with the resulting
v5.19-rc7 pull request.

							Thanx, Paul
