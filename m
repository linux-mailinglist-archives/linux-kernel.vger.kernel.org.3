Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 691A4513E81
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 00:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352866AbiD1Wbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 18:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236003AbiD1Wbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 18:31:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9334BF325
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 15:28:20 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651184899;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EFA6DqZLHdPOCQIGZcGCciOwwWk55ohfPcNvagOTdMU=;
        b=D8WhQIomo7Mnf+ksYxbBv9teF6l3D55xsR+jrPZpJQjbLQOmBIY4J+DpFv8TTC1CpBt9kD
        gBrcyw7PPwOteNqYJFUZUNkLKNVnpY+cTVPliG63Jv01tZx1p3S0W9bE3GbUAgMjsAP8bX
        TFBdcD+Rmkng9dh64DZcy6c5gQ2i/mH0cbz2xvAce8ZJyL5vrgVo8kl5YvNZjOMgBc6k4L
        DqZulQGLOtMQgIN8NJYpMQE7FLF7FO/afwrxzp1FaXSB/1Kt9x9r5XDUTNlOCTiC4Gr/3R
        Gj/ZUoxvTLHT4gdIEs6ZpMHZNX33VmeqY7lSePA49r1r1iNPg7P+aP/DBSeX5A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651184899;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EFA6DqZLHdPOCQIGZcGCciOwwWk55ohfPcNvagOTdMU=;
        b=HG3giyrcg1aGX7ckHTs6nLDex0VSRwrUXl2VUsmtP00vXR6wVwFRnWeieur9moOSLxSeM+
        vAGlIdlKOsH2+aDA==
To:     Jens Axboe <axboe@kernel.dk>, Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] task_work: allow TWA_SIGNAL without a rescheduling IPI
In-Reply-To: <bf6cc541-4de7-3258-ebb8-caa3a8249bc7@kernel.dk>
References: <543452ca-f82e-4f00-cd51-88bb9723a975@kernel.dk>
 <33a6de15-f487-b12b-8ffe-af978ebb03c3@kernel.dk>
 <20220428090836.GQ2731@worktop.programming.kicks-ass.net>
 <bf6cc541-4de7-3258-ebb8-caa3a8249bc7@kernel.dk>
Date:   Fri, 29 Apr 2022 00:28:18 +0200
Message-ID: <87wnf8onb1.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28 2022 at 06:21, Jens Axboe wrote:
> On 4/28/22 3:08 AM, Peter Zijlstra wrote:
>> On Mon, Apr 25, 2022 at 07:52:31PM -0600, Jens Axboe wrote:
>>> On 4/22/22 8:34 AM, Jens Axboe wrote:
>>>> Some use cases don't always need an IPI when sending a TWA_SIGNAL
>>>> notification. Add TWA_SIGNAL_NO_IPI, which is just like TWA_SIGNAL,
>>>> except it doesn't send an IPI to the target task. It merely sets
>>>> TIF_NOTIFY_SIGNAL and wakes up the task.
>> 
>> Could you perphaps elaborate on those use-cases? How do they guarantee
>> the task_work is ran before userspace?
>
> The task is still marked as having task_work, so there should be no
> differences in how it's run before returning to userspace. That would
> not have delivered an IPI before, if it was in the kernel.
>
> The difference would be in the task currently running in userspace, and
> whether we force a reschedule to ensure the task_work gets run now.
> Without the forced reschedule, running of the task_work (from io_uring)
> becomes more cooperative - it'll happen when the task transitions to the
> kernel anyway (eg to wait for events).

I can see why you want that, but that needs to be part of the change log
and it also needs a comprehensive comment for TWA_SIGNAL_NO_IPI.

@TWA_SIGNAL_NO_IPI works like @TWA_SIGNAL.... does not really explain
much.

Thanks,

        tglx
