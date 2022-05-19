Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB8C752D6BE
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 17:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240305AbiESPC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 11:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240361AbiESPCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 11:02:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6446C3C739
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 08:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2ablpVa++YpadMG5z08UnWMBCFJ/J7RIPdQIjewlPx0=; b=vKUuHYlm9JP9mXq1W5HmtJYPPZ
        yf0KLMXB7GvOBF6FQy/MJTdHx+P6GGGTCbSOlskeONe74qt/6jcq+Z/OooBg7tpaneTLe+c3tCX4z
        xXNeKlTmeAViYl/ZsYzz2WytxMwihND8ZVJTqPLsmU1Ef1byLLpBfBJDXwt1GzOUsf704By+/HfK9
        V1cuPX+wR1Mok7bsTfqHRZquhmGUcae49Q4LZyHtP087g4Nqp1hn2nMAGPjsk3dmql56st3FnjkSx
        +Utioun4nhhqrpLo7tfDnuCkU7Hl37JQ4ti+QhIokdMN9wZ1NoHEyOvyb+yB1eKpLjzc4OBSJT0dE
        ZZxzBOZg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nrhda-00CoRu-Me; Thu, 19 May 2022 15:00:26 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3BB6B980BD3; Thu, 19 May 2022 17:00:26 +0200 (CEST)
Date:   Thu, 19 May 2022 17:00:26 +0200
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
Message-ID: <20220519150026.GK2578@worktop.programming.kicks-ass.net>
References: <20220503100051.2799723-1-frederic@kernel.org>
 <20220503100051.2799723-4-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220503100051.2799723-4-frederic@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 03, 2022 at 12:00:33PM +0200, Frederic Weisbecker wrote:
> @@ -895,6 +899,10 @@ static void noinstr rcu_eqs_exit(bool user)
>   *
>   * If you add or remove a call to rcu_idle_exit(), be sure to test with
>   * CONFIG_RCU_EQS_DEBUG=y.
> + *
> + * FIXME: This function should be noinstr but the below local_irq_save() is
> + * unsafe because it involves illegal RCU uses through tracing and lockdep.
> + * This must be fixed first.
>   */
>  void rcu_idle_exit(void)
>  {

Urgh, except this one... I'm sure I fixed that at some point. Clearly
that never made it in :/
