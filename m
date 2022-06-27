Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB9E055E327
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234236AbiF0KSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 06:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234231AbiF0KSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 06:18:49 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2174AD5C
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 03:18:48 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 312301FD05;
        Mon, 27 Jun 2022 10:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1656325127; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3sUF1MULxxGBGqC2R8WwsBki11TfJar+6wP9cKTVjJs=;
        b=oZ0+h54GYHc+r/c5mxQSQzpeMTj0a7oeksNNUZ/Mp8YhQwtm1fLwiyQdDcO8G3TXuCNDp+
        oO1xMC+vz5DbZpcr2nCCqH3SsBT8hUrxev9pJHglbuW9ISLMhJcYg3koUjF7IdQclCpzwT
        WA1KjY5618VdBzTfp/cSv6GWOMhO/Zo=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 0A1F22C141;
        Mon, 27 Jun 2022 10:18:47 +0000 (UTC)
Date:   Mon, 27 Jun 2022 12:18:46 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: re. Spurious wakeup on a newly created kthread
Message-ID: <YrmEBjtIu/4TOaQ/@dhcp22.suse.cz>
References: <20220622140853.31383-1-pmladek@suse.com>
 <YraWWl+Go17uPOgR@mtj.duckdns.org>
 <YrllOoGRqp+Cdc9/@dhcp22.suse.cz>
 <YrloeE/LEnfYvqp3@mtj.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YrloeE/LEnfYvqp3@mtj.duckdns.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 27-06-22 17:21:12, Tejun Heo wrote:
> Hello, Michal.
> 
> On Mon, Jun 27, 2022 at 10:07:22AM +0200, Michal Hocko wrote:
> > So if somebody has woken up our thread from inside kthread() then it
> > doesn't have that pointer on the stack and I couldn't it find elsewhere
> > either. Maybe somebody has an idea where to look at.
> 
> One way could be bpftrace'ing or printking __wake_up_common() and
> friends to dump backtrace if it's trying to wake a kthread whose comm
> starts with kworker/ and doesn't have (struct worker
> *)kthread_data(task)->pool set.

I am afraid I won't have a chance for a runtime debugging. All I have at
this stage is a crash dump.
-- 
Michal Hocko
SUSE Labs
