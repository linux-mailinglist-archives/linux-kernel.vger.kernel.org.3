Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 609FE46BD6E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 15:20:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237018AbhLGOXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 09:23:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbhLGOXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 09:23:44 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D234DC061574
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 06:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Dc6Umx8GfzggaUiLtnc+utxyaUi99WuMF+Fg2ep+0Tw=; b=qD2GLdUcIwzJ8N0MPnmOS6M4kN
        jVNZ4qa+teTeT5hYGMSIEvPOD6yzSouvWUZZ1NBqRm9BmzPGJAGiJIQMiU/Ui6WC3RBsUq846tREA
        T43Ev5G76W9NcLI08FpY1rRqCX6FDCCu4DGPg0B+TMKa5m7UQw+UXOO7dNTWYlO5/5lq+iqwMFeZW
        68WV4ZvwN280nKQNBHVEdikGniebqj8CzdKi7aOPRBpKQM7wlQ/1PpFZWAYNut/ohkHewKSRxkknB
        l2TRyAGRRMk0FJDT/KUT/Kr/kb//I3c+EjEyFGCsAqDa90pV1ajh43mY+EPY5GiBzE3PS8q4LFCo/
        wRnH0QTg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mubJs-002mFt-4R; Tue, 07 Dec 2021 14:19:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C08713000E6;
        Tue,  7 Dec 2021 15:19:46 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 85E14201D19A6; Tue,  7 Dec 2021 15:19:46 +0100 (CET)
Date:   Tue, 7 Dec 2021 15:19:46 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Ben Segall <bsegall@google.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH 00/11] lockdep: Unbreak lockdep's selftest work on
 PREEMPT_RT.
Message-ID: <Ya9tguFHUePjEh/W@hirez.programming.kicks-ass.net>
References: <20211129174654.668506-1-bigeasy@linutronix.de>
 <20211202211253.GC16608@worktop.programming.kicks-ass.net>
 <20211206152618.avqghqegykwjnxm5@linutronix.de>
 <Ya4vkmFek71v88+t@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ya4vkmFek71v88+t@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 06, 2021 at 04:43:14PM +0100, Peter Zijlstra wrote:
> On Mon, Dec 06, 2021 at 04:26:18PM +0100, Sebastian Andrzej Siewior wrote:
> > On 2021-12-02 22:12:53 [+0100], Peter Zijlstra wrote:
> > > Thanks! (fixed up that first thiny), lemme feed it to the robots.
> > 
> > Thank you. I see bots' commit mail for 1-9. I don't see them for 10+11
> > but then I also don't see those two in your tree.
> > What should I do with them?
> 
> I've no idea wth happened there, let me go fix that.

Still now clue how they got lost, but it should be sorted now.
