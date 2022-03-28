Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 943284E9C3B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 18:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240701AbiC1Qa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 12:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237772AbiC1Qa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 12:30:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA2E27B1E
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 09:28:47 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1648484925;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KElUiPZJmlu+bscSLCKI3jUJiul+biPhPcK8ScQBm7g=;
        b=2UhoFhYL98/AhB/ZNcs2xDZ6kJliAONaMSCORQCj75F4WZ+IZjAWjMQzgbnK/QqYG1WwSG
        DpTlE+hl3LIGKqrjK8mPQuFhWV2qLw6tYhFJsyyq4ah2LGhpyqVad3uRVlhLkSfHH85jbY
        BOqeTuYlPIy9zxcpdlR7xxAcpqnGVj9WqZiIIKW1XTR/SuoYsdtONLTGUgF/PoTf7WRqDw
        rGKI3FPE6g4nl9F7+ONu+h1Gysq7czEHfc1L//5RvrYWYXBAdDMLuGxRUb1hTxt/nB9Bvv
        e4pTef6u88KquXmSd8jrHcQHgPzJaQKRVwTFImF6cLcf5MBEbol3G+Pq1a0eoA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1648484925;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KElUiPZJmlu+bscSLCKI3jUJiul+biPhPcK8ScQBm7g=;
        b=5omu/EAIJwCEMPl6keG5xaAyoGqmxWMlt7/4NWmCwm4H8G5uIhqAiV6PFeOco+scojvIF9
        AS6kEE5VCQpaXXDw==
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Oleg Nesterov <oleg@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ben Segall <bsegall@google.com>,
        Borislav Petkov <bp@alien8.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH] signal/x86: Delay calling signals in atomic
In-Reply-To: <8735j2xigt.fsf@email.froward.int.ebiederm.org>
References: <Ygq5aBB/qMQw6aP5@linutronix.de>
 <8735j2xigt.fsf@email.froward.int.ebiederm.org>
Date:   Mon, 28 Mar 2022 18:28:44 +0200
Message-ID: <87tubif3cz.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 28 2022 at 09:25, Eric W. Biederman wrote:
> Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:
> Further this code is buggy.  TIF_NOTIFY_RESUME is not the correct
> flag to set to enter into exit_to_usermode_loop.  TIF_NOTIFY_RESUME is
> about that happens after signal handling.  This very much needs to be
> TIF_SIGPENDING with recalc_sigpending and friends updated to know about
> "task->force_info".
>
> Does someone own this problem?  Can that person please fix this
> properly?
>
> I really don't think it is going to be maintainable for PREEMPT_RT to
> maintain a separate signal delivery path for faults from the rest of
> linux.

Fair enough. Let me queue a revert and go back to the drawing board.

Thanks,

        tglx
