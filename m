Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1144964B5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 19:01:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381071AbiAUSBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 13:01:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241924AbiAUSBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 13:01:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F04C06173B;
        Fri, 21 Jan 2022 10:01:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E63161B44;
        Fri, 21 Jan 2022 18:01:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDA49C340E1;
        Fri, 21 Jan 2022 18:01:46 +0000 (UTC)
Date:   Fri, 21 Jan 2022 13:01:45 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, tglx@linutronix.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-api@vger.kernel.org, x86@kernel.org, pjt@google.com,
        posk@google.com, avagin@google.com, jannh@google.com,
        tdelisle@uwaterloo.ca, mark.rutland@arm.com, posk@posk.io
Subject: Re: [RFC][PATCH v2 0/5] sched: User Managed Concurrency Groups
Message-ID: <20220121130145.1bba70d3@gandalf.local.home>
In-Reply-To: <20220120155517.066795336@infradead.org>
References: <20220120155517.066795336@infradead.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Jan 2022 16:55:17 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> Latest version, many changes since last time, still under heavy discussion.
> 
> Seems to work with the test-case I have (below), but that still has a few gaps,
> coverage wise.

Nice work, Peter.

> 
> Still haven't done the SMP wakeup thing, finally get the idea with
> worker-timeouts but haven't yet implemented that.
> 
> Happy hacking..
> 
> ----
>

Should the below be added to samples/ ?

-- Steve
 
> #define _GNU_SOURCE
> #include <unistd.h>
> #include <sys/types.h>
> #include <sys/syscall.h>
> #include <pthread.h>
> #include <stdio.h>
> #include <stdlib.h>
> #include <errno.h>
> #include <signal.h>

[..]
