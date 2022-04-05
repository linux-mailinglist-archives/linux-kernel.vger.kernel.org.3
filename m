Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9CAA4F2713
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 10:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233349AbiDEIGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 04:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232452AbiDEHyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 03:54:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B5011EEF2
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 00:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qqcBayd3twgxHDzuUCfiVsnYaxI4OFRrgGSkwQ01Fos=; b=AgtzSG9LVE8WJXJrlLh1SM5akI
        05wDS7s7sM9L/4VBp3vjfCCuF1l73A466G8l5bkfkpvDcrD5DbIQrsDf9/jiORRaofVnUEfxExuKP
        8JoQ/7RUWSLZCSDz7em+jXPuYpoc9GEgyyGDpu6cGDSR4P0qvBUxl4JhN2kcr10HuqpvrKGD3tDY8
        LEZEw0aP5J2rv/bCjcZG/OCcUWwajk59uFPzuF4b1WPZXcq2aZ9tzrxKEd3ztkbHY7xURo4hekmUR
        9a1JKR7lGu6ncIJz1KeRn9jtYARUW1rSFJ9Q6VDAvy6d5xOekd9al9WRYAJXwbMJadMqXWCTtGoBv
        z9bIE6ag==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nbdvu-006TKy-H3; Tue, 05 Apr 2022 07:48:58 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 14053986B5B; Tue,  5 Apr 2022 09:48:56 +0200 (CEST)
Date:   Tue, 5 Apr 2022 09:48:55 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "T.J. Alumbaugh" <talumbau@chromium.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        joel@joelfernandes.org
Subject: Re: sched_core_balance() releasing interrupts with pi_lock held
Message-ID: <20220405074855.GA30877@worktop.programming.kicks-ass.net>
References: <20220308161455.036e9933@gandalf.local.home>
 <20220315174606.02959816@gandalf.local.home>
 <20220316202734.GJ8939@worktop.programming.kicks-ass.net>
 <20220316210341.GD14330@worktop.programming.kicks-ass.net>
 <20220321133037.7d0d0c7f@gandalf.local.home>
 <20220329172236.48683eb5@gandalf.local.home>
 <51b21470-cd72-7ae3-6f33-2dd2e1d6b716@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51b21470-cd72-7ae3-6f33-2dd2e1d6b716@chromium.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 04, 2022 at 04:17:54PM -0400, T.J. Alumbaugh wrote:
> 
> On 3/29/22 17:22, Steven Rostedt wrote:
> > On Mon, 21 Mar 2022 13:30:37 -0400
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> > 
> > > On Wed, 16 Mar 2022 22:03:41 +0100
> > > Peter Zijlstra <peterz@infradead.org> wrote:
> > > 
> > > > Does something like the below (untested in the extreme) help?
> > > Hi Peter,
> > > 
> > > This has been tested extensively by the ChromeOS team and said that it does
> > > appear to fix the problem.
> > > 
> > > Could you get this into mainline, and tag it for stable so that it can be
> > > backported to the appropriate stable releases?
> > > 
> > > Thanks for the fix!
> > > 
> > Hi Peter,
> > 
> > I just don't want you to forget about this :-)
> > 
> > -- Steve
> > 
> Hi Peter,
> 
> Just a note that if/when you send this out as a patch, feel free to add:
> 
> Tested-by: T.J. Alumbaugh <talumbau@chromium.org>

https://lkml.kernel.org/r/20220330160535.GN8939@worktop.programming.kicks-ass.net
