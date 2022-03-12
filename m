Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A47E4D7151
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 23:56:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232839AbiCLWz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 17:55:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbiCLWz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 17:55:56 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD97B190B67
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 14:54:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UN+I6odUaBYTA4m+e/Oxb8RNXN0nVDOuL+cCCpQwFjQ=; b=nzJJTcMaUeG4JjhS61aYzuExUL
        azyJ57kC0z7btePyzz3OHEuoNu+MvLGazR+6tqMtT/wC5/lMbf5W/HjS9FB+dpAOVc/MvfwXhrtgP
        EVf4u79WPd4LeQW5UO0vE9NAMLTbCYSwYuX+jxJl2HgPloIOAuwJmhOfL+LXEEuOhd+GWVjPZUgq9
        77001txcf7/Px0Mj71LmL96JnhBZ8aLB9EUaaEFkNtA3OnnMDItuyR4vj59tdJIgw1x6YSJ6Cd4BE
        AcqmTF9FxaKBa4yBsO1WwVjsgskRAJUjXkK1gIW1x1u6AboUgm1du7/eBw+hnilgcHCzSnDELylP2
        8oIcfkfg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nTAcm-000JUR-3K; Sat, 12 Mar 2022 22:54:12 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id CAC47987D0D; Sat, 12 Mar 2022 23:54:09 +0100 (CET)
Date:   Sat, 12 Mar 2022 23:54:09 +0100
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
        Joel Fernandes <joel@joelfernandes.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH 16/19] context_tracking: Convert state to atomic_t
Message-ID: <20220312225409.GH28057@worktop.programming.kicks-ass.net>
References: <20220302154810.42308-1-frederic@kernel.org>
 <20220302154810.42308-17-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220302154810.42308-17-frederic@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2022 at 04:48:07PM +0100, Frederic Weisbecker wrote:
> +static __always_inline int __ct_state(void)
> +{
> +	return atomic_read(this_cpu_ptr(&context_tracking.state));
> +}

One arguably horrible thing to do would be to write it like:

	return __this_cpu_read(context_tracking.state.counter);

IIRC that will actually DTRT since atomic_read() is basically defined to
be READ_ONCE() and this_cpu_read() implies the same.

Only PowerPC and s390 implement arch_atomic_read() in asm, but I don't
think they have a particularly good reason to. The only other weird case
is Alpha, where READ_ONCE() implies smp_mb() because Alpha. I'm not sure
we care about that case, hmm?

The same can be done for ct_dynticks(), which is basically the same
function with a different mask.

As mentioned elsewhere, ct_state() appears unused at the end of the
ride.
