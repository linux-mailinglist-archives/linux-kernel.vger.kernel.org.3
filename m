Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B659D57BD7B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 20:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234107AbiGTSNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 14:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbiGTSNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 14:13:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6148462A6E;
        Wed, 20 Jul 2022 11:13:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0E6DBB821A1;
        Wed, 20 Jul 2022 18:13:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85EB0C3411E;
        Wed, 20 Jul 2022 18:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658340793;
        bh=CgStLfCKjyIYWBnn6givVwyNuwRa1/okEDuLzlPg1w0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=WBxdRACguRqmQ5GK7Meq5XeCmY2DDWjtzEHvsK9wQDsr17OA+7Y2qa3r4EvNngD42
         Q3WQPjQXSbQP995zvtFeOvqeXR7D4CuZG+OM8oLXDzfiQoJFd3jiW7PehKGcamjU6R
         rLvAWjJLqXNmPrAYlYR0nnhJyAdVTDuQFlDHhXDGaf/imf7hlBLtDbewsb/ZPJGU3M
         3Qua7tf8CcXTOGC2E55wyiGni+vJx8SQE42QjngrzV1xuED8i7dLyCvmdluoHZCc35
         4LSnsp6hWfjAZvk+D1TY+FLH7mMwgah4MnWQ4plzceoclJHFBuo9gT99pP97mdvhhY
         trhkutzB6xpsg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 1CB735C0570; Wed, 20 Jul 2022 11:13:13 -0700 (PDT)
Date:   Wed, 20 Jul 2022 11:13:13 -0700
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
Message-ID: <20220720181313.GK1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220701031545.9868-1-quic_neeraju@quicinc.com>
 <87o7xlzey3.wl-maz@kernel.org>
 <20220719171547.GQ1790663@paulmck-ThinkPad-P17-Gen-1>
 <875yjs45g0.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875yjs45g0.wl-maz@kernel.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 20, 2022 at 08:19:11AM +0100, Marc Zyngier wrote:
> Hi Paul,
> 
> On Tue, 19 Jul 2022 18:15:47 +0100,
> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> > 
> > On Tue, Jul 19, 2022 at 09:25:56AM +0100, Marc Zyngier wrote:
> > >
> > > Is there any chance for this fix to make it into 5.19? The regression
> > > is significant enough on low-end systems, and I'd rather see it
> > > addressed.
> > 
> > I wasn't planning on it, based on my (possibly quite flawed) assumption
> > that it affected only embedded systems running in a virtual environment.
> 
> Not quite. This affects any system running virtual machines based on
> KVM and using QEMU as the VMM (the machines I run this on don't quite
> qualify as "embedded").
> 
> > My plan was to send it in my pull request for the next merge window
> > next week.  My pull request is next week, yes, the merge window opens
> > the following Sunday.  ;-)
> > 
> > It has a Fixes tag, so it will be backported.
> > 
> > But if it is important to get it into v5.19 rather than v5.19.x for small
> > "x", please let me know and I will see what Linus does with the resulting
> > v5.19-rc7 pull request.
> 
> I think that the sooner we address this in an upstream kernel, the
> better, and I'd definitely support you sending this to Linus for -rc7!

Given your and Zhangfei's Tested-by, if testing continues to go well,
I will send a pull request to Linus before the end of this week.

							Thanx, Paul

> Thanks,
> 
> 	M.
> 
> -- 
> Without deviation from the norm, progress is not possible.
