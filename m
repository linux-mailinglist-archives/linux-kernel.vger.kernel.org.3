Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74345580112
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 16:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235552AbiGYO4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 10:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235692AbiGYO4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 10:56:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78A04E0CC;
        Mon, 25 Jul 2022 07:56:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 16F2A61226;
        Mon, 25 Jul 2022 14:56:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9561C341C6;
        Mon, 25 Jul 2022 14:56:40 +0000 (UTC)
Date:   Mon, 25 Jul 2022 10:56:39 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Andreas Schwab <schwab@suse.de>
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtla: fix double free
Message-ID: <20220725105639.295a7d7d@gandalf.local.home>
In-Reply-To: <mvmv8rll2yn.fsf@suse.de>
References: <mvmzggxl4n1.fsf@suse.de>
        <fd0888a4-099c-95fe-7e20-82be1489061f@kernel.org>
        <mvmv8rll2yn.fsf@suse.de>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Jul 2022 15:46:40 +0200
Andreas Schwab <schwab@suse.de> wrote:

> On Jul 25 2022, Daniel Bristot de Oliveira wrote:
> 
> > Hi Andreas
> >
> > On 7/25/22 15:10, Andreas Schwab wrote:  
> >> Don't call trace_instance_destroy in trace_instance_init when it fails,
> >> this is done by the caller.  
> >
> > Regarding the Subject, are you seeing a double-free error, or it is just an
> > optimization?  
> 
> A double free nowadays is almost always an error, due to better malloc
> checking.
> 
> > AFAICS, trace_instance_destroy() checks the pointers before calling free().  
> 
> That doesn't help when the pointer is not cleared afterwards.  Do you
> prefer that?
> 
> > Why am I asking? because if it is a double-free bug, we need to add the "Fixes:"
> > tag,  
> 
> It's the first time I tried running rtla, so I don't know whether it is
> a regression, but from looking at the history it appears to have been
> introduced already in commit 0605bf009f18 ("rtla: Add osnoise tool")
> 

I think the real fix is to make trace_instance_destroy() be able to be
called more than once.

void trace_instance_destroy(struct trace_instance *trace)
{
        if (trace->inst) {
                disable_tracer(trace->inst);
                destroy_instance(trace->inst);
		trace->inst = NULL;
        }

        if (trace->seq) {
                free(trace->seq);
		trace->seq = NULL;
	}

        if (trace->tep) {
                tep_free(trace->tep);
		trace->tep = NULL;
	}
}

As trace_instance_init() is doing the above allocations, it should clean it
up on error. But I also agree, this will lead to double free without
changing trace_instance_destroy() to be the above and then calling it twice.

-- Steve
