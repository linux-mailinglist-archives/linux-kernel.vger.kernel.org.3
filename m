Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82FE14F46E5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 01:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359205AbiDEUwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 16:52:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382805AbiDEMQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 08:16:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF9BA88A9
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 04:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XBZuSG+JHst9HFkbutDHf2wbYfSy/4wg9i8vqyibB2I=; b=gs0iUbkuT8el0MYUrZ7D6TCLHN
        i9+eyhX+gKXPwOda5vmRx2LKNVt8PDkfjoG4TiMl6QE8YHYJbqkX01k6IEcgeH8iHfDzgdNn+tj1z
        HE9suWNSA/RYuSoKkZbasehZ0Bks7/9htTf1pqkJba2VwOuQn9oc5ylQJljK9wDn18sAeO4jPbh5M
        88Kc7i4181JECr25M8o5rH8Xj1kg7UNWB7BbwxdF/j3eskA3+ric0bWOyt/Kj47/VVPIAJnQttiBI
        +X2tAsRurlXDVgj8T0w9VmdHnbS9BXN7KRk1DZjH9a6itHoAnhANP9d5Ygm3xmyPLxiHiat0RB1iX
        JVXhs6LQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nbhMB-006e6v-Mr; Tue, 05 Apr 2022 11:28:21 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BE8EA3001EA;
        Tue,  5 Apr 2022 13:28:16 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 86EF6203C0C50; Tue,  5 Apr 2022 13:28:16 +0200 (CEST)
Date:   Tue, 5 Apr 2022 13:28:16 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
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
Message-ID: <Ykwn0MpcrZ/N+LOG@hirez.programming.kicks-ass.net>
References: <Yh/b19JikC+Vnm8i@linutronix.de>
 <20220314185429.GA30364@redhat.com>
 <YjBO8yzxdmjTGNiy@linutronix.de>
 <20220315142944.GA22670@redhat.com>
 <YkW55u6u2fo5QmV7@linutronix.de>
 <20220405101026.GB34954@worktop.programming.kicks-ass.net>
 <20220405102849.GA2708@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220405102849.GA2708@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2022 at 12:29:03PM +0200, Oleg Nesterov wrote:
> On 04/05, Peter Zijlstra wrote:
> >
> > As is, I think we can write task_is_stopped() like:
> >
> > #define task_is_stopped(task)	((task)->jobctl & JOBCTL_STOP_PENDING)
> >
> > Because jobctl is in fact the canonical state.
> 
> Not really. JOBCTL_STOP_PENDING means that the task should stop.
> 
> And this flag is cleared right before set_special_state(TASK_STOPPED)
> in do_signal_stop(), see task_participate_group_stop().

Argh! More work then :-( Still, I really want to not have p->__state be
actual unique state.

