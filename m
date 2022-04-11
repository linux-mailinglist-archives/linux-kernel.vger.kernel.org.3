Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 295704FB3F9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 08:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245058AbiDKGvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 02:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231299AbiDKGvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 02:51:00 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 021A118361
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 23:48:47 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id AD80A1F388;
        Mon, 11 Apr 2022 06:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1649659726; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Q6Qt/7zIphtgdljo33ozWKYZbX8UCtN64PZbxI4ynqw=;
        b=vWvVnerv/tjfxZAbDG7/Zv0b0LO+/8VrLmtaLRBB8lyuUhhsc2YBPSNDMLSyIg9Kf1P0hn
        pJv15RXG45PZEKGst8+awsZmMyCxeR4+AxRAIGNzGe1Kaa50KAqNRM/DZfyueIjN8Tmr34
        IaCOQBI01Q5L6EZG60GGKCjRarPHU1s=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 1BDC2A3B83;
        Mon, 11 Apr 2022 06:48:44 +0000 (UTC)
Date:   Mon, 11 Apr 2022 08:48:38 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Joel Savitz <jsavitz@redhat.com>, Nico Pache <npache@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rafael Aquini <aquini@redhat.com>,
        Waiman Long <longman@redhat.com>, Baoquan He <bhe@redhat.com>,
        Christoph von Recklinghausen <crecklin@redhat.com>,
        Don Dutile <ddutile@redhat.com>,
        "Herton R . Krzesinski" <herton@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Ingo Molnar <mingo@redhat.com>,
        Darren Hart <dvhart@infradead.org>, stable@kernel.org
Subject: Re: [PATCH v8] oom_kill.c: futex: Don't OOM reap the VMA containing
 the robust_list_head
Message-ID: <YlPPRrGrX2ECe8QY@dhcp22.suse.cz>
References: <20220408032809.3696798-1-npache@redhat.com>
 <20220408081549.GM2731@worktop.programming.kicks-ass.net>
 <ee07a31c-c514-4a88-599f-14a30e93f32e@redhat.com>
 <87k0bzk7e5.ffs@tglx>
 <CAL1p7m4ukBQdQihkeSTjGHTM+HAF-GVf=QSnNPhRmetC213ANg@mail.gmail.com>
 <87sfqni77s.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sfqni77s.ffs@tglx>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 08-04-22 23:41:11, Thomas Gleixner wrote:
[...]
> Coming back to your original question.
> 
> What's the difference between a process shared and a process private
> futex in the context of a multi threaded process?
> 
>   - The process shared must obviously have a shared mapping
> 
>   - The process private has no need for a shared mapping because
>     all threads share the same address space.
> 
> What do they have in common?
> 
>   - All of them are threads in the kernel POV
> 
>   - All of them care about the unexpected exit/death of some other
>     thread vs. locking
> 
> So why would a process private robust mutex be any different from a
> process shared one?

Purely from the OOM POV they are slightly different because the OOM
killer always kills all threads which share the mm with the selected
victim (with an exception of the global init - see __oom_kill_process).
Note that this is including those threads which are not sharing signals
handling.
So clobbering private locks shouldn't be observable to an alive thread
unless I am missing something.

On the other hand I do agree that delayed oom_reaper execution is a
reasonable workaround and the most simplistic one. If I understand your
example code then we would need to evaluate the whole robust list and
that is simply not feasible because that would require a #PF in general
case.

HTH
-- 
Michal Hocko
SUSE Labs
