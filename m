Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04577599A58
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 13:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348456AbiHSLAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 07:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348011AbiHSLAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 07:00:01 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 859DCF4395
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 03:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1660906799;
  x=1692442799;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LkOuWPriJ2vDP4Uo54AyQYARYOh594lLtG0oD4A5Duw=;
  b=OF3a15TR2iN+StUcfGYG4V4MMODltytvfacG7E3Lcol43DvJ6DkuTqRO
   Y1PNSdiGtrZ+hfB7nqCYo3fUq8imhFEF3o8N5AM3+1rymLoT7L3QtnhRl
   1x6/5MN3gzBXBDkeLeGWJ9bLG4eBaRIgLI1Tt4Kt4NB4PBOL2fqSQNH18
   rmsLTqchp6cNulJ81GMhhSroLynV+VeGjYbcodAEOEMV6e22AEAviZ1HL
   odwjd0zlUXPHs6edU9x7rrfhGF9gEur1BsEMGCsA3nAIxcvz8iVotpvFh
   0upCi3BPtXB2T2FtFvFnvvYIVUF2V4aynFPhYB12ZbVnWddaebFwsga4Q
   A==;
Date:   Fri, 19 Aug 2022 12:59:56 +0200
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Boqun Feng <boqun.feng@gmail.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        kernel <kernel@axis.com>, Waiman Long <longman@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] lockdep: Panic on warning if panic_on_warn is set
Message-ID: <Yv9tLO2nbRBVyXgl@axis.com>
References: <20220818114259.2203505-1-vincent.whitchurch@axis.com>
 <Yv6z3SlfpmN+ZeV1@boqun-archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Yv6z3SlfpmN+ZeV1@boqun-archlinux>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 18, 2022 at 11:49:17PM +0200, Boqun Feng wrote:
> On Thu, Aug 18, 2022 at 01:42:58PM +0200, Vincent Whitchurch wrote:
> > There does not seem to be any way to get the system to panic if a
> > lockdep warning is emitted, since those warnings don't use the normal
> > WARN() infrastructure.  Panicking on any lockdep warning can be
> > desirable when the kernel is being run in a controlled environment
> > solely for the purpose of testing.  Make lockdep respect panic_on_warn
> > to allow this, similar to KASAN and others.
> > 
> 
> I'm not completely against this, but could you explain why you want to
> panic on lockdep warning? I assume you want to have a kdump so that you
> can understand the lock bugs closely? But lockdep discovers lock issue
> possiblity, so it's not an after-the-fact detector. In other words, when
> lockdep warns, the deadlock cases don't happen in the meanwhile. And
> also lockdep tries very hard to print useful information to locate the
> issues.

I'm not trying to obtain a kdump in this case.  I test device drivers
under UML[0] and I want to make the tests stop and fail immediately if
the driver triggers any kind of problem which results in splats in the
log.  I achieve this using panic_on_warn, panic_on_taint, and oops=panic
which result in a panic and an error exit code from UML.

[0] https://lore.kernel.org/lkml/20220311162445.346685-1-vincent.whitchurch@axis.com/

For lockdep, without this patch, I would be forced to parse the logs
after each test to determine if the test trigger a lockdep splat or not.

> This patch add lockdep_panic() to a few places, and it's a pain for
> maintaining. So why do you want to panic on lockdep warning?

It's adding the call to a lot of places since there is no existing
common function indicating the end of a lockdep warning.  I can move the
already duplicated dump_stack() calls into the new function too so that
some code is removed.  The "stack backtrace" could possible be
consolidated too, but one of the call sites uses printk instead of
pr_warn so I wasn't sure if it was OK to change that to a warn too.
