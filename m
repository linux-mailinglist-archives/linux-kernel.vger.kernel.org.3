Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EFBE4D64F0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 16:49:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348161AbiCKPu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 10:50:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232190AbiCKPuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 10:50:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D94A51C2D95
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 07:49:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 621D7B82C1C
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 15:49:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98F1AC340E9;
        Fri, 11 Mar 2022 15:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647013788;
        bh=vFydxBFqRh4gnkjZK63kJHNwdn3NtDUoiD8VT7M6qy4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mbh/5i5D+jJiaA3aSmvQXm/73G3kYlpZYs5WutA4kgnGS8vvFDqoyqnwAVuaRATI3
         RcKZZ5mYbt8GLob1FWxYNKI3sz5pJDJi7UwU2AMQEsejl2aLYuxRlvQ5/ZZnM4wbNY
         baGY5qk1XDaso0KIv2lbvYwdoyRElptstm0l5CQSh5rDvIq9ljdehfPXfbk1kKH0Os
         N+ULASO3hkSgWz/t0lYGR27NHbDx/fUVTjQ9+8H9ePE/AhMKtHa/ESyitvR6rqrIFq
         JyPJu7ahmb3wxPoSrrwQCbJSPkk/AmlylljQ9juyNvI5IxUWpO5lJpkjVm+aPhbvA6
         roUR6xHjUyDPg==
Date:   Fri, 11 Mar 2022 16:49:44 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Phil Auld <pauld@redhat.com>,
        Alex Belits <abelits@marvell.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yu Liao <liaoyu15@huawei.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Uladzislau Rezki <uladzislau.rezki@sony.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 05/19] context_tracking: Split user tracking Kconfig
Message-ID: <20220311154944.GD227945@lothringen>
References: <20220302154810.42308-1-frederic@kernel.org>
 <20220302154810.42308-6-frederic@kernel.org>
 <20220310194346.GT4285@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220310194346.GT4285@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2022 at 11:43:46AM -0800, Paul E. McKenney wrote:
> On Wed, Mar 02, 2022 at 04:47:56PM +0100, Frederic Weisbecker wrote:
> > Context tracking is going to be used not only to track user transitions
> > but also idle/IRQs/NMIs. The user tracking part will then become a
> > seperate feature. Prepare Kconfig for that.
> 
> s/seperate/separate/ # nit

Thanks, of course I'm never sure about that one.

> > diff --git a/arch/Kconfig b/arch/Kconfig
> > index 678a80713b21..1a3b79cfc9e3 100644
> > --- a/arch/Kconfig
> > +++ b/arch/Kconfig
> > @@ -762,7 +762,7 @@ config HAVE_ARCH_WITHIN_STACK_FRAMES
> >  	  and similar) by implementing an inline arch_within_stack_frames(),
> >  	  which is used by CONFIG_HARDENED_USERCOPY.
> >  
> > -config HAVE_CONTEXT_TRACKING
> > +config HAVE_CONTEXT_TRACKING_USER
> 
> Just checking...  This means that only some configs will see userland
> execution as being different than kernel execution, correct?  (Which
> is the case today, to be fair.)

Exactly!

Thanks!
