Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E27A544978
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 12:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236096AbiFIKvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 06:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiFIKvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 06:51:02 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53AF61402C
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 03:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JGoWaephDFozlkUCBSd0X3zmZYAdxYyVCGf2SvalTAU=; b=Ij+16SK9AAUozisViq+kWDPwxA
        iVsZKjlEF2/UXdM/fqqclERRPwfmU5kP84lY+uJXgJHjJ86ceNDUXcHToEbs7bkQXNQfdkZdDRAoW
        R07cG4sxZsFdEvIC2TINcIhx1K37Kxu2qhmm4g0taspF1/rgs8woZtPOrhMhdXEMQIi6Yf0LtjGqC
        Yse2FcvEMY6u7ivhKsqT37PBaxL92jyKfv0oAgyV6r3JgIAR0x3CVhPOt6CHPKHBn305h7J6siU+7
        hsmr1R/Pjy0e6lGDMJ6Etu8nTLZzGP5f6CmlUSIA8hyb440SWhGKTee6wT7zm4BhNPqY2hnttAegS
        1MkqvaUg==;
Received: from dhcp-077-249-017-003.chello.nl ([77.249.17.3] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nzFjx-006LuP-RG; Thu, 09 Jun 2022 10:50:14 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 71E709816EE; Thu,  9 Jun 2022 12:50:13 +0200 (CEST)
Date:   Thu, 9 Jun 2022 12:50:13 +0200
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
Subject: Re: [PATCH 02/20] context_tracking: Add a note about noinstr VS
 unsafe context tracking functions
Message-ID: <YqHQZRbZMF5VnDVu@worktop.programming.kicks-ass.net>
References: <20220608144037.1765000-1-frederic@kernel.org>
 <20220608144037.1765000-3-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220608144037.1765000-3-frederic@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 08, 2022 at 04:40:19PM +0200, Frederic Weisbecker wrote:
> +/*
> + * OBSOLETE:
> + * This function should be noinstr but the below local_irq_restore() is
> + * unsafe because it involves illegal RCU uses through tracing and lockdep.
> + * This is unlikely to be fixed as this function is obsolete. The preferred
> + * way is to call __context_tracking_enter() through user_enter_irqoff()
> + * or context_tracking_guest_enter(). It should be the arch entry code
> + * responsibility to call into context tracking with IRQs disabled.
> +
> + */

whitespace fail there, methinks.

>  void context_tracking_enter(enum ctx_state state)
>  {
>  	unsigned long flags;
