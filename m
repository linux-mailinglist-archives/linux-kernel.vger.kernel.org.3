Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA4694FBB13
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 13:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345914AbiDKLiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 07:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346054AbiDKLiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 07:38:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F57255A9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 04:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=r3bnlJstcdyr89MnrBaCHYI2cIl+7UQCsfgoEyyWox4=; b=WNw2+XP6tvq9vXrZKduELNOXBc
        XM1DMFIhvZD/It+LujIjohcSEIpGHuqB9Eg4nH3s/KDDGfshyUjt+dWktU2UhWvTOTNVCwMzzOmqu
        CLdn73W7MfroREngspVNvOrQwqD8ikGYoJ6gC8inCGQkufSjtn0j7nxAgbcGWXQYtBCX7qU55SS2Z
        xrmqvKWlBfQrZoDk6LFKFTv/1yJZAP0a1sOY36z/JYSVfya9DqxsPahYt9eEjxSC0ONFhlepMjOJh
        ke+QNBh4frtWBz2AW00HeYomWhjCOfJmdXjWt09Easy0svTrY+smv+7o3HBrVHSGsYJ5V3m3jdfRn
        3oYjftQw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ndsKM-00CHdR-Jc; Mon, 11 Apr 2022 11:35:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DEF09300212;
        Mon, 11 Apr 2022 13:35:23 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8F75D2C7EA781; Mon, 11 Apr 2022 13:35:23 +0200 (CEST)
Date:   Mon, 11 Apr 2022 13:35:23 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org, Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH v2] ptrace: fix ptrace vs tasklist_lock race on
 PREEMPT_RT.
Message-ID: <YlQSe6m2tidxwHt0@hirez.programming.kicks-ass.net>
References: <20220315142944.GA22670@redhat.com>
 <YkW55u6u2fo5QmV7@linutronix.de>
 <20220405101026.GB34954@worktop.programming.kicks-ass.net>
 <20220405102849.GA2708@redhat.com>
 <Ykwn0MpcrZ/N+LOG@hirez.programming.kicks-ass.net>
 <20220407121340.GA2762@worktop.programming.kicks-ass.net>
 <87v8vk8q4g.fsf@email.froward.int.ebiederm.org>
 <20220408090908.GO2731@worktop.programming.kicks-ass.net>
 <874k332wjp.fsf@email.froward.int.ebiederm.org>
 <YlCVxlTVL1pyBF08@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlCVxlTVL1pyBF08@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 08, 2022 at 10:06:30PM +0200, Peter Zijlstra wrote:

> I'll ponder if wait_task_inactive() can simplify things..

This,.. so ptrace_check_attach(), which does ptrace_freeze_traced()
already does wait_task_inactive(), but on the 'wrong' side of things.

AFAICT, if we move that up, we're almost there, except that opens up a
detach+attach race. That could be fixed by doing another
wait_task_inactive(), but we can't due to locking :/

Let's see if I can make that work without making a mess of things.
Because ensuring the task is stuck in schedule() makes the whole
saved_state thing go away -- as you noted.
