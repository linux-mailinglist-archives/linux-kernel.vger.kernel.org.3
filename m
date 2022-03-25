Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3AE84E6F71
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 09:29:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354948AbiCYIa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 04:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355049AbiCYIau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 04:30:50 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6494417E14
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 01:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Q+wJi6qwvOm1r3gx4t9QFKOneXZsav/Fvj23R1aQp1A=; b=Cb9OzTZsoQFeB0Qh57eumaahAN
        UsWCGhjolARqgAGvSrwVVQlUkb/kxCyMWCXU9X0AFcbgLFo6bYhrWT4X1+/U08cEiWQ+blRQGz2o2
        8GPd55VmAOqLxleQ6EPox6CgPeItPDH+WAAbS2t98Zp++vaLh647UmcuXq+ZUsWexBwYG/9UAhg8C
        uooivwsK5TS9E9zWP+qL6yJSObiBbII4gv8ci38iiiMPyLvbyL3aBkVq0OvQT/bFQRj9wGhvvKwqn
        6h3L3Ue6cFrasGf1AtHHVLhQrcjODGLevcdVamB5MxeJBNw7Ch3SaUTsPFaKCEtKdT3cEHFWWHGOR
        xyLG0DbQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nXfJZ-004K0e-6l; Fri, 25 Mar 2022 08:28:57 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7843D9862A6; Fri, 25 Mar 2022 09:28:55 +0100 (CET)
Date:   Fri, 25 Mar 2022 09:28:55 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Stephane Eranian <eranian@google.com>
Cc:     linux-kernel@vger.kernel.org, kim.phillips@amd.com,
        acme@redhat.com, jolsa@redhat.com, songliubraving@fb.com,
        rafael@kernel.org, ravi.bangoria@amd.com, Sandipan.Das@amd.com
Subject: Re: [PATCH v7 00/13] perf/x86/amd: Add AMD Fam19h Branch Sampling
 support
Message-ID: <20220325082855.GL8939@worktop.programming.kicks-ass.net>
References: <20220322221517.2510440-1-eranian@google.com>
 <20220324145902.GG8939@worktop.programming.kicks-ass.net>
 <CABPqkBTVFNOW0Y-suYVRjf07aBC41gEw1m4Ym78sR39BRzLDcQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPqkBTVFNOW0Y-suYVRjf07aBC41gEw1m4Ym78sR39BRzLDcQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2022 at 10:31:38PM -0700, Stephane Eranian wrote:
> On Thu, Mar 24, 2022 at 7:59 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Tue, Mar 22, 2022 at 03:15:04PM -0700, Stephane Eranian wrote:
> > > V7 makes the following changes:
> > >    - rebased to 5.17-rc8
> > >    - Restrict BRS to be used only with RETIRED_TAKEN_BRANCH event in order to
> > >      avoid adding more skid to other events in case that are monitored
> > >      concurrently
> > >    - fixed bugs in the perf tool enhanced error handling for IBS and BRS
> >
> > But afaict you failed to pick up the build fixes I did in my tree :/ Let
> > me try and be careful preserving those while munging this in.
> 
> Sorry. I missed that. I can resubmit if you prefer.

Nah, fixed it up again.. Even converted to static_call() this time.

Could you please test this branch?

  https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/log/?h=perf/amd

I've since done more Changelog edits, and I should do a comment with the
static_call_mod() usage, but I think this ought to work.

At least it now actually builds...
