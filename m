Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4A5F4D7168
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 00:11:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232902AbiCLXMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 18:12:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231773AbiCLXMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 18:12:37 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E632A76FE
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 15:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=d71rq4MFerq18wy+/6/FrKSbqwx8ogOL8IZ4D+kzuOc=; b=KHJVgIN5dlCCS1AVSR7xIsJ+28
        zP/YdKts6T0zoG68qlxguhJLRVO8YYk3Z1UoppVLX0cNzX35jtvk6Oz/czYhhg//tO9P72Jv/9D1N
        NXDICMxRM8k5GrcSBrLIHouhTl/9r9c64Epm9GBa0o3HZhuhAj+HImR1Fq+s9K6vpjvWaX1avD4fO
        trCklydBLQQnSSLdSO8x5lE5n55OIYDQRWy4eHPANDprbL+gz6hQNcrLE65XJwejUPsjFh5sSwgcK
        ELOtbFURJr+PFoPiX2u+xWKtRUZ2ooewp++u/USZ68HaFqPzKprX5sCaiDwD2lIENM3OSAwPjMODn
        3tigDq0A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nTAsr-000Jkm-5e; Sat, 12 Mar 2022 23:10:51 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id B810A987D0D; Sun, 13 Mar 2022 00:10:48 +0100 (CET)
Date:   Sun, 13 Mar 2022 00:10:48 +0100
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
Subject: Re: [PATCH 14/19] rcu/context-tracking: Move RCU-dynticks internal
 functions to context_tracking
Message-ID: <20220312231048.GI28057@worktop.programming.kicks-ass.net>
References: <20220302154810.42308-1-frederic@kernel.org>
 <20220302154810.42308-15-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220302154810.42308-15-frederic@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2022 at 04:48:05PM +0100, Frederic Weisbecker wrote:
> +noinstr unsigned long rcu_dynticks_inc(int incby)
> +{
> +	return arch_atomic_add_return(incby, this_cpu_ptr(&context_tracking.dynticks));
> +}

noinstr implies noinline, making the above a rather sad little function;
would it perhaps be better to make it __always_inline ?

Also; I could imagine myself doing an arch special for this such that
x86 generates:

	LOCK XADD	[reg], %gs:[var]

But that's for later I suppose, it would be but a little tweak to
perpcu_add_return_op()
