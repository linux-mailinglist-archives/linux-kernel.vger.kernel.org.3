Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 827B954C5A5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 12:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239896AbiFOKPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 06:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231751AbiFOKPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 06:15:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C5EC369FD
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 03:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=efPkYx0LzlhjjUyT3vFU9yA2v1wLteeYMERKQZflVEo=; b=AP0O+2dynyHhSJtSjsHdfYol10
        VWEThjUOrFFbAPdPZcWGdJ/dFqj3uu1wbiBSNBwHX3y5Dd9gjJdgVNa7TmipD2GDvTW/25CwA4zWD
        V+/gFF5aF9zZy5SvG8FX6fuhlekCOTwZh/0nkTPhIncMkJhSwZ22L/2z0rUlqq4Xjxg3hc1o8GwT2
        n0Kgs6ms/NkxczdnBnZ9PcHRKsYJOMg1dpnujZ97w62DqJn6PHG8THPo/FDLIE4X3U8PWctH6vWI2
        Oy1kahEXjcIHzjbnu60rEwmzWyvB879tIpjyG9JXnrEXCcf9xd+wDEkHRumLDvcwOdmhEIRuY5SFA
        h9NiPhfg==;
Received: from dhcp-077-249-017-003.chello.nl ([77.249.17.3] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o1Q3H-000y4v-HI; Wed, 15 Jun 2022 10:15:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2516530023F;
        Wed, 15 Jun 2022 12:15:07 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EFAC9201A4F6D; Wed, 15 Jun 2022 12:15:06 +0200 (CEST)
Date:   Wed, 15 Jun 2022 12:15:06 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Michael Jeanson <mjeanson@efficios.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH 0/3] selftests/rseq: fixes for RISC-V and Glibc 2.35
Message-ID: <YqmxKvckF2P14nKu@hirez.programming.kicks-ass.net>
References: <20220614154830.1367382-1-mjeanson@efficios.com>
 <581392317.60476.1655227129623.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <581392317.60476.1655227129623.JavaMail.zimbra@efficios.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2022 at 01:18:49PM -0400, Mathieu Desnoyers wrote:
> ----- On Jun 14, 2022, at 11:48 AM, Michael Jeanson mjeanson@efficios.com wrote:
> 
> > The patch series allows running the rseq selftests on a Glibc 2.35
> > system which has rseq support but no RSEQ_SIG defined for the RISC-V
> > architecture.
> > 
> > The patches were tested on both Glibc 2.33 and 2.35.
> 
> For the whole series:
> 
> Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> 
> Peter, can you pick them up through your tree ?

Sure, thanks!
