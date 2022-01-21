Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD413495B83
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 09:01:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349290AbiAUIBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 03:01:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234242AbiAUIBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 03:01:46 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2C82C061574;
        Fri, 21 Jan 2022 00:01:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mfsDPpP6pPVF19UocgRcI2BdK3UKbXxVmmByaBeSd/Y=; b=mP+Tzmm8InXQnQmaMVK7U1Xs1K
        +ZEnKQqC3sZJaWNww0V4weL3W+JU3IwiMYM5Y+dzeYrCsEIGarlyI/7QVmihiIIMFPNJcBsqBR0mx
        Dfx9f+nLTF+j6bekI4cBkhh7A56X39kkFt37SNyZUK9jP+vJNhkX/pZtF2jvSIshFB8z4uLAqRN5L
        gqXwJazIsrUv5je5kn0kQM+hMSLY65Gz+Gh2OXNcETyZNHu2D4HyLzezOrHSpLb7EWyVCwbuWQfoj
        HUqrQOTCev8btpL7S/a/8nbgGHdXhnwgUBm2jfqK2SJ3sN2kyO7hD4jrozPSxnLp4/3ZLlcX/1Eyx
        j/7R1+wQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nAorO-002XZt-8E; Fri, 21 Jan 2022 08:01:26 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 57C60984B76; Fri, 21 Jan 2022 09:01:25 +0100 (CET)
Date:   Fri, 21 Jan 2022 09:01:25 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Peter Oskolkov <posk@google.com>
Cc:     mingo@redhat.com, tglx@linutronix.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-api@vger.kernel.org, x86@kernel.org,
        pjt@google.com, avagin@google.com, jannh@google.com,
        tdelisle@uwaterloo.ca, mark.rutland@arm.com, posk@posk.io
Subject: Re: [RFC][PATCH v2 0/5] sched: User Managed Concurrency Groups
Message-ID: <20220121080125.GC20638@worktop.programming.kicks-ass.net>
References: <20220120155517.066795336@infradead.org>
 <CAPNVh5eSZHkTXUHwao1RAgdqxLJD=92A=2CDE6AN1GUgJPJvWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPNVh5eSZHkTXUHwao1RAgdqxLJD=92A=2CDE6AN1GUgJPJvWw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2022 at 09:28:11AM -0800, Peter Oskolkov wrote:
> On Thu, Jan 20, 2022 at 8:09 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > Latest version, many changes since last time, still under heavy discussion.
> 
> Thanks! I'll work on testing/integrating this patchset. I'll also
> assume that my changes that added blocked worker list
> (https://lore.kernel.org/lkml/20220113233940.3608440-5-posk@google.com/)

So the blocked list I don't mind, but I'm not sure about the use-case
you mentioned... it gets a mess vs PE, but I see why you'd want it, so i
need to think about it more.

> and server kicking
> (https://lore.kernel.org/lkml/20220113233940.3608440-6-posk@google.com/)
> are acceptable.

Still need to look at the server kicking thing...
