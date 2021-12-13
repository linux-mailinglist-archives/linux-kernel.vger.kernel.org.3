Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4936473157
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 17:12:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236838AbhLMQME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 11:12:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240528AbhLMQMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 11:12:01 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3915BC061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 08:12:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Jk8NhKQN65JiCdf+e1tO/EZHgE3Y8HsbZkOR3nz05Rk=; b=YyGk9smbNWKlouHUYmcVbisesX
        YwFAgpINtpmX/LAd7Hoyp6yiJ/BCEbjyIudnUGAroQafQ2yAKqcSwNh7djiozoWhFR1dBmYHQ9Kl4
        X059EsheMj9tIZU9b10k2IpbRLcewtWY0h3tn10tpgF1YRBau4tlvojup0JzYBev7RIH7CtQQYhbY
        5YOcLlUj0qImdp2Uq9PJrDhni1gZsuP1sCK5fb8TfPaOWRQXcVzLPB/t4aXtdgKO+HfzGcJyOa7DE
        jsOr00NTV+dmcND6ufSCvy9Hr+q2pCOBOFwrWdwWV96V0rAHmW3hWPl9KJz9BZo9HQF9IZcNkSUiu
        WBeaD/rw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mwnvZ-0019JI-TJ; Mon, 13 Dec 2021 16:11:50 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id C80749816DE; Mon, 13 Dec 2021 17:11:49 +0100 (CET)
Date:   Mon, 13 Dec 2021 17:11:49 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marco Elver <elver@google.com>
Cc:     will@kernel.org, boqun.feng@gmail.com,
        linux-kernel@vger.kernel.org, x86@kernel.org, mark.rutland@arm.com,
        keescook@chromium.org, hch@infradead.org,
        torvalds@linux-foundation.org, axboe@kernel.dk, paulmck@kernel.org
Subject: Re: [PATCH v2 0/9] refcount: Improve code-gen
Message-ID: <20211213161149.GX16608@worktop.programming.kicks-ass.net>
References: <20211210161618.645249719@infradead.org>
 <Ybc6dDpZ/lxwlUqA@hirez.programming.kicks-ass.net>
 <Ybdb2g63B3ZeJ0LR@elver.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ybdb2g63B3ZeJ0LR@elver.google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 03:42:34PM +0100, Marco Elver wrote:
> On Mon, Dec 13, 2021 at 01:20PM +0100, Peter Zijlstra wrote:
> > 
> > Also, since this will conflict most mighty with Marco's kcsan work in
> > the rcu tree, I've written the below patch as a replacement for the
> > instrumentation patch in that series.
> > 
> > It depends on other bits in that series so it cannot be applied here,
> > but will come in handy when trying to resolve the merge conflict.
> > 
> > ---
> > Subject: locking/atomics, kcsan: Add instrumentation for barriers
> > From: Peter Zijlstra <peterz@infradead.org>
> > Date: Thu Dec 9 17:08:16 CET 2021
> > 
> > Adds the required KCSAN instrumentation for barriers of atomics.
> > 
> > [adapted from https://lkml.kernel.org/r/20211130114433.2580590-17-elver@google.com]
> > Originally-by: Marco Elver <elver@google.com>
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> Thanks!
> 
> I wanted to test this, but can't quite figure out which branches I need
> to merge together to get it to apply. I assume -rcu + your series? Or
> the updated series not yet sent?

I think I applied the patches from your series up-to, but not including,
the atomic-instrument patch, then the first few patches of this posting
which cause the rejects and then this patch.

I've not attempted the actual git-merge or did much testing on the
results.

