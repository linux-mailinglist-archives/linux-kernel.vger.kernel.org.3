Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0B5461F78
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 19:44:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238267AbhK2Srn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 13:47:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379997AbhK2Spg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 13:45:36 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6028EC049495
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 06:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SI2iTFkTDzYYUcDOPg4rBs+bvyVyq2R8CsvglYX1/L0=; b=SSRboMwoEA25CeO+Dwu5OjVYSt
        eCNX6e6DMZ7ALRUuUKw4n0JaJThPQO6j3iAlgZn3Eo4TlaIpid2MdKwK+bILk9g4pjmAzUAkZz7pd
        Mt1jigQtf0metVpRF+oGQwxWn6bAyiB9814jSinwlGhf5stRQ/JhIvPSiEu9db7BJt/niFYB2hg06
        lP1iBLN2yC6TFQAWWcCkkF9VtJFEUUZNLIUG6ypSWiY1zCTFJ9jLfnY8CxwbO7Zs9IbYJNOCxp371
        LFAiMyJLZcjDBfRlzMinv30yHCo+mbwdSDzeREhUOuvs4RwQmHE+fiUByQnyMu0p0RtjIJkXLmWBR
        FPXsWXzw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mri7x-0081dm-Gj; Mon, 29 Nov 2021 14:59:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 46CC930023F;
        Mon, 29 Nov 2021 15:59:32 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2DDEF2B2FCB21; Mon, 29 Nov 2021 15:59:32 +0100 (CET)
Date:   Mon, 29 Nov 2021 15:59:32 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Hillf Danton <hdanton@sina.com>, Boqun Feng <boqun.feng@gmail.com>,
        syzbot <syzbot+84ef57449019b1be878d@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rajatasthana4@gmail.com
Subject: Re: [syzbot] INFO: rcu detected stall in newstat
Message-ID: <YaTq1I82HEA/e6r6@hirez.programming.kicks-ass.net>
References: <0000000000003544c405c8a3026a@google.com>
 <20211128030309.1897-1-hdanton@sina.com>
 <CACT4Y+YXg=rRmCsM3i0ES_dXhFGdnS7LLwtX3YmRLjjr0haCOA@mail.gmail.com>
 <20211129131328.1960-1-hdanton@sina.com>
 <CACT4Y+ZxJUu+UrUpOwvcFOy2LubhP1HuCQybxaq-rrDsdO9bRg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+ZxJUu+UrUpOwvcFOy2LubhP1HuCQybxaq-rrDsdO9bRg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 29, 2021 at 03:15:16PM +0100, Dmitry Vyukov wrote:

> Right, I missed the "preempt leak: 00000100 -> 00000101" warning. And
> before that there is also "WARNING: inconsistent lock state" warning.
> This reminds me of the issues we had with RCU/LOCKDEP before when an
> RCU warning disabled LOCKDEP tracking, as the result LOCKDEP missed
> part of events (e.g. tracked lock, but missed subsequent unlock) and
> due to races/ordering issues it mis-reported them as nonsensical
> reports.

You're talking about how debug_locks_off() is a hot-racy-mess? That only
matters if you're triggering stuff concurrently which *mostly* doesn't
happen.

I'm also not quite sure how to fix that without globally serializing
everything, which would be super unhappy.
