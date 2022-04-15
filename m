Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97038502965
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 14:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353033AbiDOMKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 08:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238850AbiDOMK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 08:10:29 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40501BD2EF
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 05:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=St8oWKxdlyJ9kHKLqNFtmwPsXFd7TD8AXFSNuL+0TlA=; b=nErrbw1uLhlqRUrCK061ux3rLn
        rASVg+pEIfZl7mKXt/NZL2S7DUkSI6TGBPl4czY5AwR7WYR3fSIvm5wW2KgFdUpRSPC88we1QV+VN
        3DZZWaevfTqMQvr9k5KCwR9fFkfIjn0u0FnFvYW5LvGcU7dM4FlrrYid/EDVx+RJFcp0Jsl7PXkjr
        FFr8+2BD8USLRg+x31R+nB0yXiDu1dYMN4rreY+yPWG0ZQPHMcKVmLjxOTjUz5uScsMyKyaWq2L+l
        +6NN7T1sFTgSQh8tScPlR+ziwmS7gh3iXyeeQZ3ALpE17p7VqgO+tr4K07PKKWSZkdaXiq0cK+RRB
        vYAJm6AA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nfKk0-005NH1-Up; Fri, 15 Apr 2022 12:07:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9439E3001AE;
        Fri, 15 Apr 2022 14:07:56 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 79A032C977338; Fri, 15 Apr 2022 14:07:56 +0200 (CEST)
Date:   Fri, 15 Apr 2022 14:07:56 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [patch 1/3] timekeeping: Annotate ktime_get_boot_fast_ns() with
 data_race()
Message-ID: <YllgHEhwDOYqv5IX@hirez.programming.kicks-ass.net>
References: <20220415091223.187169221@linutronix.de>
 <20220415091920.956045162@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220415091920.956045162@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 15, 2022 at 11:19:35AM +0200, Thomas Gleixner wrote:
> Accessing timekeeper::offset_boot in ktime_get_boot_fast_ns() is an
> intended data race as the reader side cannot synchronize with a writer and
> there is no space in struct tk_read_base of the NMI safe timekeeper.
> 
> Mark it so.

If offs_boot actually ever changed?
