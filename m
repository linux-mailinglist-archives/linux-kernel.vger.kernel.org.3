Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA24E4CE534
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 15:16:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231790AbiCEORP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 09:17:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231835AbiCEORO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 09:17:14 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D789922F971
        for <linux-kernel@vger.kernel.org>; Sat,  5 Mar 2022 06:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2srIXyqFX0R0SF2dFt8yUC6cRtgAGc2dzX/ElrpejHs=; b=n40OjDPZ8S3FQEykfZUglhU9nI
        IJiCwdq6iM45vAbbBxXzDT08UJ9ETd60cCQh2X0ENle1pLM1v7uzZ696lrlxdswdUxQjwz6ILeqYA
        4TiZ02C6ML8vOTUkiNPkKX4awFS4WqYJWEDanTXkAHoiMISSscS63pvrNLOCNLa+gt1yasdA132Fv
        ClFkc8muqHE+U5En9Qf6XDWJUfAVbp7uXGMUkqFDVh6fKpDqMP2lDHvixNgoxWxXBIXDL6FbCtXyz
        8RROQRSYD20vagNa4L4Giyt64eOjxGbBEFpWL4k0jQdJn3kslZX8qIIHHDXbp6OoIlnWODz7++R2Y
        dUU1AsTg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nQVCV-00FXJF-Px; Sat, 05 Mar 2022 14:16:03 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 68B0D9865F2; Sat,  5 Mar 2022 15:16:03 +0100 (CET)
Date:   Sat, 5 Mar 2022 15:16:03 +0100
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
Subject: Re: [PATCH 09/19] rcu/context-tracking: Remove rcu_irq_enter/exit()
Message-ID: <20220305141603.GY11184@worktop.programming.kicks-ass.net>
References: <20220302154810.42308-1-frederic@kernel.org>
 <20220302154810.42308-10-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220302154810.42308-10-frederic@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2022 at 04:48:00PM +0100, Frederic Weisbecker wrote:
>  void ct_irq_enter_irqson(void)
>  {
> -	rcu_irq_enter_irqson();
> +	unsigned long flags;
> +
> +	local_irq_save(flags);
> +	ct_irq_enter();
> +	local_irq_restore(flags);
>  }
>  
>  void ct_irq_exit_irqson(void)
>  {
> -	rcu_irq_exit_irqson();
> +	unsigned long flags;
> +
> +	local_irq_save(flags);
> +	ct_irq_exit();
> +	local_irq_restore(flags);
>  }

I know you're just copying code around, but this is broken per
construction :/

On the irq_enter site, local_irq_save() will hit a tracepoint, which
requires RCU, which will only be made available by the ct_irq_enter().
Same in reverse for the exit case.
