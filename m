Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1F8E4979F4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 09:06:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236210AbiAXIF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 03:05:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233770AbiAXIF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 03:05:57 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3042DC06173B
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 00:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l7vj3bqDeqqqQNc8THrJbak7O/EIdT8VwyiXzgQX1uU=; b=Z94PNBFdv24ZIwwujUERibQscT
        gv5D6k+HGZtQ8wQY4EcAkeNlepwLwqx8998CDbOX4AByqGHjvFhGHU6FZTvxiF9oGXhoTJuX5GNPo
        zSp8NtuY9ivaA33Ey2U5hIG5woeYpZeHlPauYbCI4N5tbJNO20q3HvdTFN4SagL+97cQL5nJHM8c9
        LxwM49anHeeHn2vrr8OOn6chhYOpyqesCZ752qvLhUAicc7yQ7kZLWDg0drqHMhwKIhJa0YEGjMIn
        V+42XnsGn90kpGYacJ8XO08wTcGuubbJoFMu5hSLCyQTWm7hQEfBkrj+yc0oiSRWbs5YiMshykRNs
        wpCBMgQA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nBuLb-00373q-Hg; Mon, 24 Jan 2022 08:05:08 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9E42B98624A; Mon, 24 Jan 2022 09:05:05 +0100 (CET)
Date:   Mon, 24 Jan 2022 09:05:05 +0100
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
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: Re: [PATCH 41/54] arch/x86: replace cpumask_weight with
 cpumask_weight_eq where appropriate
Message-ID: <20220124080505.GI20638@worktop.programming.kicks-ass.net>
References: <20220123183925.1052919-1-yury.norov@gmail.com>
 <20220123183925.1052919-42-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220123183925.1052919-42-yury.norov@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 23, 2022 at 10:39:12AM -0800, Yury Norov wrote:
> smpboot code in somw places calls cpumask_weight() to compare the weight
> of cpumask with a given number. We can do it more efficiently with
> cpumask_weight_eq() because conditional cpumask_weight may stop traversing
> the cpumask earlier, as soon as condition is met.

Why use a more complicated API for code that has no performance
requirements?

From where I'm sitting this is a net negative for making the code harder
to read.
