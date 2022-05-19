Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DBB752D701
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 17:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233770AbiESPI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 11:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240627AbiESPI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 11:08:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2870DED71A
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 08:08:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D3AA3B824A5
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 15:07:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34CC5C385AA;
        Thu, 19 May 2022 15:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652972878;
        bh=oPoYwxvatlDH4n7QwYRq0CN1OCnSLejSjaSWWYQne1Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=De0mos1dyzDtPH40PSRrD82/hfPhDozlR9BVlnW3BXhFHN4TtlD+W2Z1KkVGPD0W8
         OWq9IK5eogfsK7ja0xIMRE/GEXgTyKWLv36FBen4bt2xRwyejMbq4vUyuwe73+ra8J
         ev3sdRIB6pRZ6sxJnvcoBTEXUOozgnAJwdViwL2qEZrtyPL2qCpSIQMKufd8UHcIv5
         iy+MGXOBTsUSvFtSj8VEywwGG+kdRKWWdBrGuj8bPhrrMhpPjUYxf2DWM0xsJQrmKW
         SuEBGuOgFzZKi+kWVta7PU0iH1eOnLWKncUb88bzZHeZSraS/qp7GO+fc7fMkUrnGK
         RUPxzfeumHDcA==
Date:   Thu, 19 May 2022 17:07:55 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Nicolas Saenz Julienne <nsaenzju@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Phil Auld <pauld@redhat.com>,
        Alex Belits <abelits@marvell.com>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yu Liao <liaoyu15@huawei.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Uladzislau Rezki <uladzislau.rezki@sony.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 00/21] rcu/context-tracking: Merge RCU eqs-dynticks
 counter to context tracking v2
Message-ID: <20220519150755.GD618878@lothringen>
References: <20220503100051.2799723-1-frederic@kernel.org>
 <6690c4c7119839a784d0d96523e832a10e04fcca.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6690c4c7119839a784d0d96523e832a10e04fcca.camel@redhat.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 05:33:02PM +0200, Nicolas Saenz Julienne wrote:
> On Tue, 2022-05-03 at 12:00 +0200, Frederic Weisbecker wrote:
> > This mixes up the RCU dynticks counter and the context tracking state
> > updates into a single atomic instruction. This may serve several
> > purposes:
> > 
> > 1) Improve CPU isolation with deferring some disturbances until sensitive
> >    userspace workload completes and goes to the kernel. This can take
> >    several forms, for example smp_call_function_housekeeping() or
> >    on_each_housekeeping_cpu() to enqueue and execute work on all
> >    housekeeping CPUs. Then an atomic operation on ct->state can defer
> >    the work on nohz_full CPUs until they run in kernel (or IPI them
> >    if they are in kernel mode), see this proposal by Peter:
> >    https://lore.kernel.org/all/20210929151723.162004989@infradead.org/#r
> > 
> > 2) Unearth sysidle (https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/commit/?h=sysidle.2017.05.11a&id=fe5ac724d81a3c7803e60c2232718f212f3f38d4)
> >    This feature allowed to shutdown the tick on the last housekeeping
> >    CPU once the rest of the system is fully idle. We needed some proper
> >    fully ordered context tracking for that.
> > 
> > Inspired by Peterz: https://lore.kernel.org/all/20210929151723.162004989@infradead.org
> > 
> > Passed 100 hours of TREE01.
> > 
> > ---
> 
> For the whole series:
> 
> Reviewed-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
> Tested-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>

I hesitated to apply these but the series has changed a little, although
the fundamental bits remain.

I'll just wait for a confirmation from you on this v3.

Thanks!
