Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF3552CD76
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 09:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232143AbiESHsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 03:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbiESHsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 03:48:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA3EB0A6E
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 00:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xSOfFdkrVYOKzCck8ZZ8FsORD92PBEUUt5o5Parxkqs=; b=Lo3OyDE9tI8cWxTY3oBP0lxbao
        h8n45i6fvCKzZiEckS1Opra3q+j9nRzAUMCYWV63UEOBrblgls5K0JrArg4BzpTx3QVcKBW1fQl7O
        buXNnAqX/8uwLNjDshw6sW9+Ap/TraCEh5QX4rqhwHtTeDF3tZMJUalmEe5vjNjy26a0RUAxzBR+C
        Sk3U4EiKlfOtWInAgKWdD6/emsrlFpMeqAO77lDq7qsuj1o7UCvBnOgU6ZRbKM6SWBm31Mc4m3zfe
        dyofvThW59/8da7O/5Kulvo6hTMJOPbC/LJ013gOFpTiuSUVz+N3mgVdcSlzM4+vMHzVfrhArHk4y
        daMaqPkQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nrasy-00CXSI-L5; Thu, 19 May 2022 07:47:52 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3E4A2980E0B; Thu, 19 May 2022 09:47:52 +0200 (CEST)
Date:   Thu, 19 May 2022 09:47:52 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH] sched/clock: Use try_cmpxchg64 in
 sched_clock_{local,remote}
Message-ID: <20220519074752.GC2578@worktop.programming.kicks-ass.net>
References: <20220518184953.3446778-1-ubizjak@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220518184953.3446778-1-ubizjak@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 08:49:53PM +0200, Uros Bizjak wrote:
> Use try_cmpxchg64 instead of cmpxchg64 (*ptr, old, new) != old in
> sched_clock_{local,remote}. x86 cmpxchg returns success in ZF flag,
> so this change saves a compare after cmpxchg (and related move
> instruction in front of cmpxchg).
> 
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>

Thanks!
