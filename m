Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA05446D7B1
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 17:05:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236518AbhLHQJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 11:09:18 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:34604 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbhLHQJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 11:09:17 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id C47761FD26;
        Wed,  8 Dec 2021 16:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1638979544; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CvcQBSNTvvCRdBpYrU4PvbzY2eZarvbTKMbxWQBvpFo=;
        b=MDXnmweZ+FXDg5XpNVKX3/IXscxA1kWIaMVSKlpCsoZx1Ew3hATEkPZe0NRJaYjk2AKg0C
        Gxe0Tm/HJ6Iont1ZzsZBFU79SoVnUuniIHqlkRgGDMfwkLhjxcr/wvzbSMG38F2lAb/yeL
        p4mBgkvMSLHHsQCpD1GXv8DRXnQJPoE=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 53F6DA3B93;
        Wed,  8 Dec 2021 16:05:44 +0000 (UTC)
Date:   Wed, 8 Dec 2021 17:05:43 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Joel Savitz <jsavitz@redhat.com>, linux-kernel@vger.kernel.org,
        Waiman Long <longman@redhat.com>, linux-mm@kvack.org,
        Nico Pache <npache@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@collabora.com>
Subject: Re: [PATCH] mm/oom_kill: wake futex waiters before annihilating
 victim shared mutex
Message-ID: <YbDX16LAkvzgYHpH@dhcp22.suse.cz>
References: <20211207214902.772614-1-jsavitz@redhat.com>
 <20211207154759.3f3fe272349c77e0c4aca36f@linux-foundation.org>
 <YbB0d6T8RbHW48sZ@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YbB0d6T8RbHW48sZ@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 08-12-21 10:01:44, Michal Hocko wrote:
> On Tue 07-12-21 15:47:59, Andrew Morton wrote:
> > (cc's added)
> 
> Extend CC to have all futex maintainers on board.
>  
> > On Tue,  7 Dec 2021 16:49:02 -0500 Joel Savitz <jsavitz@redhat.com> wrote:
> > 
> > > In the case that two or more processes share a futex located within
> > > a shared mmaped region, such as a process that shares a lock between
> > > itself and a number of child processes, we have observed that when
> > > a process holding the lock is oom killed, at least one waiter is never
> > > alerted to this new development and simply continues to wait.
> > 
> > Well dang.  Is there any way of killing off that waiting process, or do
> > we have a resource leak here?
> > 
> > > This is visible via pthreads by checking the __owner field of the
> > > pthread_mutex_t structure within a waiting process, perhaps with gdb.
> > > 
> > > We identify reproduction of this issue by checking a waiting process of
> > > a test program and viewing the contents of the pthread_mutex_t, taking note
> > > of the value in the owner field, and then checking dmesg to see if the
> > > owner has already been killed.
> > > 
> > > This issue can be tricky to reproduce, but with the modifications of
> > > this small patch, I have found it to be impossible to reproduce. There
> > > may be additional considerations that I have not taken into account in
> > > this patch and I welcome any comments and criticism.
> 
> Why does OOM killer need a special handling. All the oom killer does is
> to send a fatal signal to the victim. Why is this any different from
> sending SIGKILL from the userspace?

I have had a closer look and I guess I can see what you are trying to
achieve. futex_exit_release is normally called from exit_mm context. You
are likely seeing a situation when the oom victim is blocked and cannot
exit. That is certainly possible but it shouldn't be a permanent state.
So I would be more interested about your particular issue and how long
the task has been stuck unable to exit.

Whether this is safe to be called from the oom killer context I cannot
really judge. That would be a question to Futex folks.
-- 
Michal Hocko
SUSE Labs
