Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8DEF4F90FB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 10:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232124AbiDHIj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 04:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbiDHIjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 04:39:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1732C3893
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 01:37:50 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649407067;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oISKE5LaMehx2C01N20eUScIwjSSk2eBrc+o245KWv4=;
        b=05bJBQvp24Dg2sKt23/aO72hj8DzDnrYfy3ByG1lOW5b56M8i/ZSL78ZRqE5WgNB7XWe3d
        qj+YrwxFGlayPpAQ21vh7p9QRVsWlDJkQQ4me8j6lhhGY7czRvwx/Vj12cxaBvQuXx2UqH
        LR4rmAZX3qtJ1q8lsDm/UXFvYn+5QVLuPGnooP/9/OJiThtX/OUBD9Vn7tHsxj5r9ZMNXg
        etLXLWeWlseVF/7ZpbzC9zf6fbJEeCcZlnpIbaquYOgq8LWEmuleDV3wHiNn/5vXMul0k+
        79mZpO0q0fj+V38HFOMJtFWWFmbagPUBO5HV0JpRtAc8TizNB/bw9bvH5TkQ6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649407067;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oISKE5LaMehx2C01N20eUScIwjSSk2eBrc+o245KWv4=;
        b=kyb36WHbPjNrcEjhfChenUP8UmFtGni5hul51e0kQQ+s63IGL2sfZuz59MpTYh36TKnamP
        OuIo2ZUSB1JAPmCw==
To:     Peter Zijlstra <peterz@infradead.org>,
        Nico Pache <npache@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Rafael Aquini <aquini@redhat.com>,
        Waiman Long <longman@redhat.com>, Baoquan He <bhe@redhat.com>,
        Christoph von Recklinghausen <crecklin@redhat.com>,
        Don Dutile <ddutile@redhat.com>,
        "Herton R . Krzesinski" <herton@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Ingo Molnar <mingo@redhat.com>,
        Joel Savitz <jsavitz@redhat.com>,
        Darren Hart <dvhart@infradead.org>, stable@kernel.org
Subject: Re: [PATCH v8] oom_kill.c: futex: Don't OOM reap the VMA containing
 the robust_list_head
In-Reply-To: <20220408081549.GM2731@worktop.programming.kicks-ass.net>
References: <20220408032809.3696798-1-npache@redhat.com>
 <20220408081549.GM2731@worktop.programming.kicks-ass.net>
Date:   Fri, 08 Apr 2022 10:37:47 +0200
Message-ID: <87tub4j7hg.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 08 2022 at 10:15, Peter Zijlstra wrote:
> On Thu, Apr 07, 2022 at 11:28:09PM -0400, Nico Pache wrote:
>> Theoretically a failure can still occur if there are locks mapped as
>> PRIVATE|ANON; however, the robust futexes are a best-effort approach.
>> This patch only strengthens that best-effort.
>> 
>> The following case can still fail:
>> robust head (skipped) -> private lock (reaped) -> shared lock
>> (skipped)
>
> This is still all sorts of confused.. it's a list head, the entries can
> be in any random other VMA. You must not remove *any* user memory before
> doing the robust thing. Not removing the VMA that contains the head is
> pointless in the extreme.
>
> Did you not read the previous discussion?

Aside of that we all agreed that giving a oom-killed task time to
cleanup itself instead of brute force cleaning it up immediately, which
is the real problem here. Can we fix that first before adding broken
heuristics?

Thanks,

        tglx


