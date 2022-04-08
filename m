Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9184F9267
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 11:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234037AbiDHKBb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 06:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231820AbiDHKBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 06:01:30 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EFF7280
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 02:59:27 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id B55C01F861;
        Fri,  8 Apr 2022 09:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1649411965; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y0PsAMl4/noPyoCGgn90zWHMgOGH/EHQX9wluEN2ZzE=;
        b=qvI+nJfthhLgm4/0Bg/SPiYcBdNPjZoWaTOy7+IuAL+tqk+N4AJf3/eggurasamK3fRgH3
        PdtmguuffZ/riaOvGEqgmhSQnzGF1/c36IlZ+YqfZxtAG8yDZWdH30qTm68LzpNkwdbK9l
        hB2XMMR1OSUE8fYBtEO5ZWN8HxR90Y0=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 5B2E5A3B96;
        Fri,  8 Apr 2022 09:59:25 +0000 (UTC)
Date:   Fri, 8 Apr 2022 11:59:25 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Nico Pache <npache@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Rafael Aquini <aquini@redhat.com>,
        Waiman Long <longman@redhat.com>, Baoquan He <bhe@redhat.com>,
        Christoph von Recklinghausen <crecklin@redhat.com>,
        Don Dutile <ddutile@redhat.com>,
        "Herton R . Krzesinski" <herton@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Ingo Molnar <mingo@redhat.com>,
        Joel Savitz <jsavitz@redhat.com>,
        Darren Hart <dvhart@infradead.org>, stable@kernel.org
Subject: Re: [PATCH v8] oom_kill.c: futex: Don't OOM reap the VMA containing
 the robust_list_head
Message-ID: <YlAHfU7VEI0wYAb/@dhcp22.suse.cz>
References: <20220408032809.3696798-1-npache@redhat.com>
 <20220408081549.GM2731@worktop.programming.kicks-ass.net>
 <87tub4j7hg.ffs@tglx>
 <ddf1755e-fe69-b60e-ee07-e78d663b11b2@redhat.com>
 <YlACJMp7AFaVa/Gt@dhcp22.suse.cz>
 <676fb197-d045-c537-c1f7-e18320a6d15f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <676fb197-d045-c537-c1f7-e18320a6d15f@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 08-04-22 05:40:09, Nico Pache wrote:
> 
> 
> On 4/8/22 05:36, Michal Hocko wrote:
> > On Fri 08-04-22 04:52:33, Nico Pache wrote:
> > [...]
> >> In a heavily contended CPU with high memory pressure the delay may also
> >> lead to other processes unnecessarily OOMing.
> > 
> > Let me just comment on this part because there is likely a confusion
> > inlved. Delaying the oom_reaper _cannot_ lead to additional OOM killing
> > because the the oom killing is throttled by existence of a preexisting
> > OOM victim. In other words as long as there is an alive victim no
> > further victims are not selected and the oom killer backs off. The
> > oom_repaer will hide the alive oom victim after it is processed.
> > The longer the delay will be the longer an oom victim can block a
> > further progress but it cannot really cause unnecessary OOMing.
> Is it not the case that if we delay an OOM, the amount of available memory stays
> limited and other processes that are allocating memory can become OOM candidates?

No. Have a look at oom_evaluate_task (tsk_is_oom_victim check).

-- 
Michal Hocko
SUSE Labs
