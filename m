Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1996955D3CD
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344530AbiF1Jv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 05:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344491AbiF1Jvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 05:51:43 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE8F2BB3D
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 02:51:43 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id B553A1FD50;
        Tue, 28 Jun 2022 09:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1656409901; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Nv3GhukGgUnIZkRzen+HbLRhRFVrkufiUI5WwB64rbs=;
        b=RSlMJQSz9U3bUE9NtANP5s04nyAIJC/RBPA2K885jLaum9DkoL33xRmQ7yZXu8y7CfXNwf
        756oL5sJzyB2HEFUyZdVks8wcHFsvIPC4WlK3cb3ra4hE2SVVvfeWMRpdvE5zHwuIEMCfw
        2LRmR8cCYfXhlVwB7PHceJQ7DkRdq4c=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 563C72C141;
        Tue, 28 Jun 2022 09:51:41 +0000 (UTC)
Date:   Tue, 28 Jun 2022 11:51:37 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: re. Spurious wakeup on a newly created kthread
Message-ID: <YrrPKU2y4liY91u9@alley>
References: <20220622140853.31383-1-pmladek@suse.com>
 <YraWWl+Go17uPOgR@mtj.duckdns.org>
 <CAHk-=wiC7rj1o7vTnYUPfD7YxAu09MZiZbahHqvLm9+Cgg1dFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiC7rj1o7vTnYUPfD7YxAu09MZiZbahHqvLm9+Cgg1dFw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 2022-06-25 10:01:35, Linus Torvalds wrote:
> On Fri, Jun 24, 2022 at 10:00 PM Tejun Heo <tj@kernel.org> wrote:
> For example, the reason that quoted patch cannot be right is that this
> code pattern:
> 
>   while (wait_for_completion_interruptible(&worker->ready_to_start))
>     ;
> 
> is not valid kernel code. EVER. There is absolutely no way that can be correct.
> 
> Either that code can take a signal, or it cannot. If it can take a
> signal, it had better react to said signal. If it cannot, it must not
> use an interruptble sleep - since now that loop turned into a
> kernel-side busy-loop.

I agree that the code is ugly and does not make sense.

JFYI, I did it this way because I wanted to calm down the hung task
detector. kthreads ignore signals so that I did not think about
this aspect. I though that I saw this trick somewhere.

Do not ask me why I wanted to calm down the hung task detector.
I quess that I felt overloaded and wished a calm day
or something like this. I agree that it does not make
much sense.

Best Regards,
Petr
