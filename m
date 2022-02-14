Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ABA94B4F21
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 12:45:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244317AbiBNLpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 06:45:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352634AbiBNLom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 06:44:42 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE687C52;
        Mon, 14 Feb 2022 03:39:07 -0800 (PST)
Date:   Mon, 14 Feb 2022 12:39:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644838746;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DXbq0tADiA1e8237ZJnCsYfJ4qqjQmGrNdy9V8g+GD8=;
        b=MIiAp1avZ4WyMS8mF/E2GKZM9OsesUa4wuZ+ixeqoeujTMMLvtQ0AQPX/wyEHQB9gFL3gf
        YrYeTAd/klUck2UDc6craKnXFy+Sm76fccwAo6r/MBtVZ/KMWhW0AZeofYEASqVkXjQmo6
        +xljGrriNUzLFvHucdjvoSnz6z3fIEzMOG2UhFTDjmIkRiKIcvkPqk3ED35MxsMUn1aJQo
        IZQUlSIEZ87Wy4TFSV7sYKZnOShkGI+wDiG7h0Cm5jiOwUAq0iYkK0GUkQ9kWR+hKG/uGw
        Bi+Acb7TuHb0o5szOLG1g1T1ncTjS22SOm8XxeNmXWxwlXt0DS8mKPL2YqBlyQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644838746;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DXbq0tADiA1e8237ZJnCsYfJ4qqjQmGrNdy9V8g+GD8=;
        b=7xLGTC0gx0WKqfra9wO5jaCeW5r8AGDWDARdETFncnR1wpChCuFG6cVivCIFOCHkRf8szn
        bg4+mhZsjdCMqCCQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH 2/8] kernel/fork: Duplicate task_struct before stack
 allocation.
Message-ID: <Ygo/WWSQHFkGn095@linutronix.de>
References: <20220125152652.1963111-1-bigeasy@linutronix.de>
 <20220125152652.1963111-3-bigeasy@linutronix.de>
 <8340d413-4951-5e62-ef5f-f396523edac7@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8340d413-4951-5e62-ef5f-f396523edac7@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-02-11 15:42:38 [-0800], Andy Lutomirski wrote:
> On 1/25/22 07:26, Sebastian Andrzej Siewior wrote:
> > alloc_thread_stack_node() already populates the task_struct::stack
> > member except on IA64. The stack pointer is saved and populated again
> > because IA64 needs it and arch_dup_task_struct() overwrites it.
> 
> I understand the problem, I think.
> 
> > 
> > Allocate thread's stack after task_struct has been duplicated as a
> > preparation.
> > 
> 
> But I don't understand this.  How does this patch relate to the problem?

So I duplicate the task-struct, assign the stack pointer in
alloc_thread_stack_node() with no need to update the stack pointer
later. Otherwise arch_dup_task_struct() would reset the pointer.

> Also, you appear to be missing a change to the free_stack and free_tsk code
> at the end of dup_task_struct().

It looks right. What am I missing?

Sebastian
