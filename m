Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA5F452DF82
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 23:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234919AbiESVng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 17:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235456AbiESVnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 17:43:32 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A9925A093
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 14:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xf0dkSbS7vl8+kZlPUH0NLEwqyPxeRT7Yvvt86KsZXc=; b=F9bdOpow/83Xv2enAqhV+18nID
        crj9dHJMiQ5Y+0j9/ABpKCIFkb+g/+GVX3EEliQbYrz6aXgbxX2pUuRfpqJaEzK3mstzny7kHHZFA
        ND5ai27Hycjhc0zp88mCAnvmwlVBDkGILSNhI5XMa1QjlBnWZfTsdu4OJVGFIpy1EaavFv98iyz8H
        swYKue7IVRB4AmFIV4npIfTy83ZNQOE8Stxb/aSFx/wh3yvjnSnFKus82olIU1uZK+IWTiwQUYeFm
        prBHFWyZJzVDF8BBbasfwLI39Q7iCTltiJS9gi7RuqKCwgTh0xsZYgtv6Owf1zXZVfnXxEoti5IND
        k+dJoroQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nrnvF-0028gX-CG; Thu, 19 May 2022 21:43:05 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id BC7DB980F70; Thu, 19 May 2022 23:43:03 +0200 (CEST)
Date:   Thu, 19 May 2022 23:43:03 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Frederic Weisbecker <frederic@kernel.org>
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
Message-ID: <20220519214303.GC6479@worktop.programming.kicks-ass.net>
References: <20220503100051.2799723-1-frederic@kernel.org>
 <20220503100051.2799723-4-frederic@kernel.org>
 <20220519150026.GK2578@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220519150026.GK2578@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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

I found my patches and brushed them off, see here:

  https://lkml.kernel.org/r/20220519212750.656413111@infradead.org
