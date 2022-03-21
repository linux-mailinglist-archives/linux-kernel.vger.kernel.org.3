Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC3284E2789
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 14:32:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347874AbiCUNeE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 09:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347864AbiCUNeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 09:34:02 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A6B215CB6D
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 06:32:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C6319CE185A
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 13:32:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1487FC340ED;
        Mon, 21 Mar 2022 13:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647869554;
        bh=H6Ht/pv4kwqFiq9YzeQKyb/2EXOgEV7ZKz2xNTgxD5o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G3kPBrGJARBwvDezf1szBY1638CDLUrn0ReWbH3FvxHRwRpBptLfvQZjo/i0h13rf
         CJmTNZKtCb9Ujat/EY9bwzCZMUc8uEGaWKq/vTR2HbAbypmm830TSTRvCoYzg/XKMO
         GX0GodMkoI0jj7aKQ47DfVkh3VdBJw1jPZzMR3qFfG4mNXiQAlk1sT9VBfYNSWLKAc
         dV2mEmlNk6OX6tibr3hbxkniIDxklF4NFsp0LPb71T3Cwb/PM+HazktsYiHgutJSbO
         2QSZMYuspjKzP628lpF7ft25wxhZOEic2raOZiO9V1c802/5QaLzW7I/oW4EKeaVnu
         u3RJLd8GuVBug==
Date:   Mon, 21 Mar 2022 13:32:27 +0000
From:   Will Deacon <will@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Phil Auld <pauld@redhat.com>,
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
        Joel Fernandes <joel@joelfernandes.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 16/19] context_tracking: Convert state to atomic_t
Message-ID: <20220321133226.GA10803@willie-the-truck>
References: <20220302154810.42308-1-frederic@kernel.org>
 <20220302154810.42308-17-frederic@kernel.org>
 <20220312225409.GH28057@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220312225409.GH28057@worktop.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 12, 2022 at 11:54:09PM +0100, Peter Zijlstra wrote:
> On Wed, Mar 02, 2022 at 04:48:07PM +0100, Frederic Weisbecker wrote:
> > +static __always_inline int __ct_state(void)
> > +{
> > +	return atomic_read(this_cpu_ptr(&context_tracking.state));
> > +}
> 
> One arguably horrible thing to do would be to write it like:
> 
> 	return __this_cpu_read(context_tracking.state.counter);
> 
> IIRC that will actually DTRT since atomic_read() is basically defined to
> be READ_ONCE() and this_cpu_read() implies the same.
> 
> Only PowerPC and s390 implement arch_atomic_read() in asm, but I don't
> think they have a particularly good reason to. The only other weird case
> is Alpha, where READ_ONCE() implies smp_mb() because Alpha. I'm not sure
> we care about that case, hmm?

If we don't care about the dependency ordering, then __READ_ONCE() is the
chappy to use if the types don't get in the way too much.

Will
