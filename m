Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6DD24CAE80
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 20:18:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239299AbiCBTTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 14:19:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235020AbiCBTTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 14:19:04 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 130F2220D5
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 11:18:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PRQG6g+MUHSU/R8yPTlf3nRoJJmafVT52l/ZxTMw4nY=; b=Wc86twxb+Os6GNB2WIpAWPL9q2
        KN7AKUPUJpRYYsgwSJj4x391dRruhCrrD6fyR4+RNpxF9cPoIrbfW92C9bvvK52aBOt4mB08d+IN6
        vmxuvTATFik5BwFqPKuOVDfUPnv2nGAV4yRahqoLiA2Ud06ugiAMDOdvigNjroqcV2ahDdvucIuho
        GCzHWMmIw4NIrwnHAfRUGc8JX1Uap2X8l0K3jFKdapEhu+OxH7BuZzESVrv/v6qm3luanFz9W9Jxi
        xMEaY5m1VGB96asTvQ6JNjtj4pCngVoLDNvfm+UvKOHANs79TfcbYyCMY3/Bacv2Oj4+tMOaB9/dy
        WkzCsV4A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nPUUC-00AubU-Tk; Wed, 02 Mar 2022 19:18:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 51BCA30018E;
        Wed,  2 Mar 2022 20:18:06 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 14B733086C902; Wed,  2 Mar 2022 20:18:06 +0100 (CET)
Date:   Wed, 2 Mar 2022 20:18:06 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Kees Cook <keescook@chromium.org>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/19] Enable -Wshadow=local for kernel/sched
Message-ID: <Yh/C7nnElPOL3G/k@hirez.programming.kicks-ass.net>
References: <20220302043451.2441320-1-willy@infradead.org>
 <202203021030.EEEF58C2@keescook>
 <Yh+67VF0/OFSp15y@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yh+67VF0/OFSp15y@casper.infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2022 at 06:43:57PM +0000, Matthew Wilcox wrote:
> ie "__ret = freezable_schedule_timeout(__ret)" is supposed to refer to
> the inner __ret, not the outer __ret.  Which was the opposite of what
> I thought was supposed to happen.
> 
> We can fix this, of course.  Something like ...
> 
> #define ___wait_event_freezable_timeout(wq_head, condition, timeout, ret) \
> 	___wait_event(wq_head, ___wait_cond_timeout(condition, ret),      \
> 		TASK_INTERRUPTIBLE, 0, timeout,				  \
> 		ret = freezable_schedule_timeout(ret), ret)
> 
> #define __wait_event_freezable_timeout(wq_head, condition, timeout) \
> 	___wait_event_freezable_timeout(wq_head, condition, timeout, UNIQUE_ID)
> 
> ... and now all the 'ret' refer to the thing that they look like they're
> referring to.

Right; so the trick is to make sure all ___wait_event() users will have
a ret and then the inner ret can go away. The interruptible/timeout
variants all already have a ret variable, but the unconditional things
like wait_event() do not (which is where all the trouble started).

By simply adding a ret variable, even to the variants without return
value, the inner variable can go away and the shadowing goes away.
