Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 919A65228C6
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 03:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240002AbiEKBMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 21:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240100AbiEKBMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 21:12:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B14C5185CB5;
        Tue, 10 May 2022 18:12:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 52C6FB82073;
        Wed, 11 May 2022 01:12:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A14DAC385D4;
        Wed, 11 May 2022 01:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652231558;
        bh=HtE0Ap2vGg3s3s+LE5LjSjmdbZKta/dQG73tticU+zY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eT1zcJbDBczwZ8nj2Pu77bH9alH2nTx9+SZjExbnBzUyBOhKfipT2VSm/Q02Hx5Ui
         ij9I6kQLQWd+qjqm5tDzagd6i7utTfq5ebWRee4sVvnx7aS3JiGfVljnQttCLawovy
         GUByLt5AJ9o34YOmjNFY2yyMlWRAvxir6JZRfQoR/uvOHuGs8sgGFPMHcqkhIzs7uC
         lN9qSjZvAHv3v5ONlO8bDGE2bvtzTBhKYXqxr4yiuNpxi5MXNroYS3SUjiLfGWVs/f
         jSjc/VBWITrJ4bjnJDNKD2ycRP9FKhpR8+Ml7RusaQ+1FhcvvrvUO622oVf0MVK267
         G30pUlQCeH8Hg==
Date:   Tue, 10 May 2022 18:12:35 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Rik van Riel <riel@fb.com>
Cc:     "song@kernel.org" <song@kernel.org>,
        "joe.lawrence@redhat.com" <joe.lawrence@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "live-patching@vger.kernel.org" <live-patching@vger.kernel.org>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        Kernel Team <Kernel-team@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pmladek@suse.com" <pmladek@suse.com>
Subject: Re: [RFC] sched,livepatch: call klp_try_switch_task in __cond_resched
Message-ID: <20220511011235.f7cdkc6xn7redqa3@treble>
References: <6bf85ff908377508a5f5bcc7c4e75d598b96f388.camel@fb.com>
 <20220510165244.ikfh64ertnvodxb4@treble>
 <1bd15361edfd4db9fc9271d35e7bbe5edad1b87a.camel@fb.com>
 <20220510184213.l3gjweeleyg7obca@treble>
 <47440502-930F-4CBD-B859-3AC9BBFF8FC6@fb.com>
 <20220510230402.e5ymkwt45sg7bd35@treble>
 <D298A3F1-43A5-4FD5-B198-906364BF4B79@fb.com>
 <6c36c09fbf426280d13f6025f41aed4c65c042d6.camel@fb.com>
 <20220511003716.2lo6gkluwycvauda@treble>
 <bf682c8874a044a643becbb8704a4dfedadc3321.camel@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bf682c8874a044a643becbb8704a4dfedadc3321.camel@fb.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 12:46:32AM +0000, Rik van Riel wrote:
> On Tue, 2022-05-10 at 17:37 -0700, Josh Poimboeuf wrote:
> > On Wed, May 11, 2022 at 12:35:11AM +0000, Rik van Riel wrote:
> > > On Tue, 2022-05-10 at 23:57 +0000, Song Liu wrote:
> > > > 
> > > > So, if we come back to the same question: is this a bug (or a
> > > > suboptimal
> > > > behavior that worth fixing)? If so, we are open to any solution
> > > > that 
> > > > would also help PREEMPT and/or non-x86 arches. 
> > > > 
> > > Using the preempt notifiers during KLP transition should
> > > work equally well for PREEMPT and !PREEMPT. It also does
> > > not insert any additional code into the scheduler while
> > > there is no KLP transition going on.
> > 
> > As I've been saying, this is not going to work for PREEMPT because,
> > without ORC, we can't reliably unwind from an IRQ handler, so the
> > kthread won't get patched.
> > 
> Isn't the sched_out preempt notifier always run in
> process context?
> 
> What am I missing?

Maybe it's technically process context at that point.  But the important
point is that the call to the scheduler via preempt_schedule_irq()
originates from the "return from interrupt" path.

So the state of the interrupted task's stack is unknown.  For example it
could have been interrupted before the frame pointer prologue.  Or in a
leaf function which doesn't use frame pointers.

-- 
Josh
