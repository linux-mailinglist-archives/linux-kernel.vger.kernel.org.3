Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF4252D6D0
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 17:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240375AbiESPFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 11:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240350AbiESPEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 11:04:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E812FE4D
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 08:04:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8ABBD61A1D
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 15:04:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DC69C385AA;
        Thu, 19 May 2022 15:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652972649;
        bh=rWxT/gORon6pJcgrnGDLEJH+UWLLJXtA2YWEYuU28gI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ncaf4TRPVx5s3HhkZMPcwmibh2XfpOgOiF1KScDXeNJArozWS0Bbn+LByYC/hkp9B
         3pZndIU4JcbJz8P7yOgqa1DkPm7wD3rpTgI4kTnFSkOLvJAJoMpiEbnU48VOmyQhIy
         I7UwGN3zXGmeJ2RRyo3vijtscxdryz8RlH+HgGdbuVcETx99OvZ1FAmUXOYBvJmgsv
         qmmJ/sxkjibD4+/VPMjcq6tdmSdU5YTcFTk2Pgp908HAgyH3FwVlizuSPRCaTJWpFW
         UqWQc2G3wH4FR86ccdp9mimvDizPew5bldLosTyLf3AIbmRMLenoCXX2yjm6WSqIjr
         lwyly7Sb1O+BQ==
Date:   Thu, 19 May 2022 17:04:06 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Phil Auld <pauld@redhat.com>,
        Alex Belits <abelits@marvell.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
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
Subject: Re: [PATCH 03/21] rcu: Add a note about noinstr VS unsafe eqs
 functions
Message-ID: <20220519150406.GB618878@lothringen>
References: <20220503100051.2799723-1-frederic@kernel.org>
 <20220503100051.2799723-4-frederic@kernel.org>
 <20220519150026.GK2578@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220519150026.GK2578@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2022 at 05:00:26PM +0200, Peter Zijlstra wrote:
> On Tue, May 03, 2022 at 12:00:33PM +0200, Frederic Weisbecker wrote:
> > @@ -895,6 +899,10 @@ static void noinstr rcu_eqs_exit(bool user)
> >   *
> >   * If you add or remove a call to rcu_idle_exit(), be sure to test with
> >   * CONFIG_RCU_EQS_DEBUG=y.
> > + *
> > + * FIXME: This function should be noinstr but the below local_irq_save() is
> > + * unsafe because it involves illegal RCU uses through tracing and lockdep.
> > + * This must be fixed first.
> >   */
> >  void rcu_idle_exit(void)
> >  {
> 
> Urgh, except this one... I'm sure I fixed that at some point. Clearly
> that never made it in :/

Most definetly the trickiest one...
