Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 387F856FEB1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 12:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbiGKKR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 06:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiGKKRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 06:17:33 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C8102DD1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 02:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5niTOBa4euUKXSYVbbIy1iFQyx/tclGje0FJLckNlNo=; b=M5ksDxEnXbh+GvS/azSzCqewCT
        j2FC9BhwrcSe4qadQSNab3wIKzMJUXK4WLFy2Ka/NfSG9sAGCRc3CbtUcyo3KgNgMxOA725Ia+68B
        pfk3S41mFZs1A/9lu5jTOPD8Y8x3kTirfq11MYJbXc7IPv/wQN9Li6SYbuMlPGdC+OOPpMIcyY2lH
        32e8S3l5E+LamWT6oTEL0mFQ0nGMPKzbecjJzKXrp1Umk+hdHs8OWm59qS2c+zUWAwjfG/OQs+9WV
        wI1f2u7ZCrhsIOJ3jt2l2x+UpOZ9XL58NncqOoac2vzOa30xc4JbSeD6ZPYEtGaJDuAg9GdgpCUzV
        JRFoyGIQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oApoi-002y68-23; Mon, 11 Jul 2022 09:35:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C0C0C3010ED;
        Mon, 11 Jul 2022 11:34:57 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A57CA2025D0C3; Mon, 11 Jul 2022 11:34:57 +0200 (CEST)
Date:   Mon, 11 Jul 2022 11:34:57 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mike Stowell <mstowell@redhat.com>
Subject: Re: [PATCH v3] locking/rtmutex: Limit # of lock stealing for non-RT
 waiters
Message-ID: <YsvuwfeY/dSngl8c@hirez.programming.kicks-ass.net>
References: <20220706135916.980580-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220706135916.980580-1-longman@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2022 at 09:59:16AM -0400, Waiman Long wrote:
> Commit 48eb3f4fcfd3 ("locking/rtmutex: Implement equal priority lock
> stealing") allows unlimited number of lock stealing's for non-RT
> tasks. That can lead to lock starvation of non-RT top waiter tasks if
> there is a constant incoming stream of non-RT lockers. This can cause
> rcu_preempt self-detected stall or even task lockup in PREEMPT_RT kernel.
> For example,
> 
> [77107.424943] rcu: INFO: rcu_preempt self-detected stall on CPU
> [ 1249.921363] INFO: task systemd:2178 blocked for more than 622 seconds.
> 
> Avoiding this problem and ensuring forward progress by limiting the
> number of times that a lock can be stolen from each waiter. This patch
> sets a threshold of 32. That number is arbitrary and can be changed
> if needed.
> 

Why not do the same thing we do for regular mutexes?
