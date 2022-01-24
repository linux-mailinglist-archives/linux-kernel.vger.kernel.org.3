Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E63614979F6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 09:06:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241060AbiAXIGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 03:06:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233770AbiAXIGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 03:06:16 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB7E9C06173B
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 00:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wJ6QD3BuoJQ8BQIzxedxfuDJJlPS03gECmKyQ57iA0U=; b=fVYeADUeb5tqoelotfGdqOj7I5
        3OlzpbFNKtPLJlZUzwDqvLGbdxieHpz5UrOuYKIeGtnPBqhMU7vvCmix75iz3Gddl3WLkflsN5CRl
        x/+oNuw+gudQ+qRyeP33dQkl25x8peTjRPVow/nEWWLynU1+9WSwXf0xXMYx35U6528klbQQkGtr6
        sh7HguUVcUGp7h2TQKJVv+cNbFn4ENljT/1scj0/OAqufZ03qvfyF346VNNIShB/K9uHl6SX1XQ15
        Bp/1Qb+f6p7LVDXRRn3gOdbD1CHtFdZUyWt1tzI/EjCewKB4Em9R/5sPvuFMRiyBWOcQpMSLXU17w
        kgy50vGA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nBuMH-00374T-2Y; Mon, 24 Jan 2022 08:05:49 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id AD17598624A; Mon, 24 Jan 2022 09:05:48 +0100 (CET)
Date:   Mon, 24 Jan 2022 09:05:48 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Laight <David.Laight@aculab.com>,
        Joe Perches <joe@perches.com>, Dennis Zhou <dennis@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Nicholas Piggin <npiggin@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Alexey Klimov <aklimov@redhat.com>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH 47/54] sched: replace cpumask_weight with
 cpumask_weight_eq where appropriate
Message-ID: <20220124080548.GJ20638@worktop.programming.kicks-ass.net>
References: <20220123183925.1052919-1-yury.norov@gmail.com>
 <20220123183925.1052919-48-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220123183925.1052919-48-yury.norov@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 23, 2022 at 10:39:18AM -0800, Yury Norov wrote:
> kernel/sched code uses cpumask_weight() to compare the weight of
> cpumask with a given number. We can do it more efficiently with
> cpumask_weight_eq because conditional cpumask_weight may stop
> traversing the cpumask earlier, as soon as condition is met.
> 

Same as with the other patch, you're just making the code more difficult
to read for no reason.
