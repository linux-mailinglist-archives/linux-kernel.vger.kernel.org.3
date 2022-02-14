Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7157D4B543C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 16:10:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355639AbiBNPKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 10:10:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243886AbiBNPKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 10:10:19 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 249B439A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 07:10:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gWxjbdrkRGmqmtbjFFW9HNxR1us/bLZnWaqnhT7labg=; b=PEeXRgInirf88NuCQkEIcfLaWd
        tKQXFQQCU8xD2LfzbZNdRQzaN0L8eWGX0RxMCvyhpq9OYq/SYvH1YyBwyf1zrZF5eVlLeP5gBgdpW
        Lo0BVAV7eSSPBeNf5hpCMrWpQ1kEa+yHEezt4rn7X3Hgo3jcw4SD/kWrEQ2yaSXo8qDU1lWHTys99
        ZLOfQeXzH3uZfS8722Us9fLCC+ZmRclxtCYidi2ZyjGO0c0IlMkhpTt92SqbcSkgt+k4eg7jajjij
        Veu1t+8kEeg39QzeNnCF8VagIrtniDvSQtp67FrlktGiMxa2AY0r8Nfp05rkwlfmOC9x1mB3K2wEN
        qDusvu8w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nJczD-009vjC-6r; Mon, 14 Feb 2022 15:09:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 73EEA30003C;
        Mon, 14 Feb 2022 16:09:53 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5105120CE5792; Mon, 14 Feb 2022 16:09:53 +0100 (CET)
Date:   Mon, 14 Feb 2022 16:09:53 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        Huangzhaoyang <huangzhaoyang@gmail.com>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        Ingo Molnar <mingo@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv4] psi: fix possible trigger missing in the window
Message-ID: <YgpwwZvTU/llBMeC@hirez.programming.kicks-ass.net>
References: <1643093818-19835-1-git-send-email-huangzhaoyang@gmail.com>
 <YgpvwTbakWSI4TWK@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgpvwTbakWSI4TWK@cmpxchg.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2022 at 10:05:37AM -0500, Johannes Weiner wrote:
> On Tue, Jan 25, 2022 at 02:56:58PM +0800, Huangzhaoyang wrote:
> > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > 
> > When a new threshold breaching stall happens after a psi event was
> > generated and within the window duration, the new event is not
> > generated because the events are rate-limited to one per window. If
> > after that no new stall is recorded then the event will not be
> > generated even after rate-limiting duration has passed. This is
> > happening because with no new stall, window_update will not be called
> > even though threshold was previously breached. To fix this, record
> > threshold breaching occurrence and generate the event once window
> > duration is passed.
> > 
> > Suggested-by: Suren Baghdasaryan <surenb@google.com>
> > Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> 
> Hey Peter, would you mind taking this through the scheduler tree? It's
> got my and Suren's acks. It's not a recent regression so I'm thinking
> for 5.18 is fine. Thanks!

Sorry, missed it, got it now. Thanks!
