Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFFD649072C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 12:33:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239123AbiAQLdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 06:33:37 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:54680 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233803AbiAQLdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 06:33:35 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 5A3991F39A;
        Mon, 17 Jan 2022 11:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1642419214; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6AT+BcSng3mCjm3YV8NAWDfJaHk3WflmRlnyGIs2osU=;
        b=W9fQoUk6ynN8A9SUKYIzk+1u9jMKeIkiIk30Qy2MmF2K2mc8MRRpBph23eyBNuPULQJYo1
        GZAu82TYgSznNB+DKbd/DbZzZoI+YxFT4s2D4C1WyAK94WGmS9yg31YFEdl2VPXqAeuD0e
        lorOsIyOTPijwQW/AGlgGOJXgAekaRE=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id B21BBA3B84;
        Mon, 17 Jan 2022 11:33:33 +0000 (UTC)
Date:   Mon, 17 Jan 2022 12:33:33 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Joel Savitz <jsavitz@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
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
Message-ID: <YeVUDVV4Z5ur9Flh@dhcp22.suse.cz>
References: <20211207214902.772614-1-jsavitz@redhat.com>
 <20211207154759.3f3fe272349c77e0c4aca36f@linux-foundation.org>
 <YbB0d6T8RbHW48sZ@dhcp22.suse.cz>
 <YbDX16LAkvzgYHpH@dhcp22.suse.cz>
 <CAL1p7m4ka1v-Zoi-RpDy5ME-bMikGPX5V_4Hod-Y0KHOq_G8zA@mail.gmail.com>
 <YbG1mu0CLONo+Z7l@dhcp22.suse.cz>
 <CAL1p7m7mWxLE-7Qf_QjmREJ2AvfSexPvybPyHvxTUugxsPPxjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL1p7m7mWxLE-7Qf_QjmREJ2AvfSexPvybPyHvxTUugxsPPxjQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have only noticed your email now after replying to v3 so our emails
have crossed.

On Fri 14-01-22 09:39:55, Joel Savitz wrote:
> > What has happened to the oom victim and why it has never exited?
> 
> What appears to happen is that the oom victim is sent SIGKILL by the
> process that triggers the oom while also being marked as an oom
> victim.
> 
> As you mention in your patchset introducing the oom reaper in commit
> aac4536355496 ("mm, oom: introduce oom reaper"), the purpose the the
> oom reaper is to try and free more memory more quickly than it
> otherwise would have been by assuming anonymous or swapped out pages
> won't be needed in the exit path as the owner is already dying.
> However, this assumption is violated by the futex_cleanup() path,
> which needs access to userspace in fetch_robust_entry() when it is
> called in exit_robust_list(). Trace_printk()s in this failure path
> reveal an apparent race between the oom reaper thread reaping the
> victim's mm and the futex_cleanup() path. There may be other ways that
> this race manifests but we have been most consistently able to trace
> that one.

Please let's continue the discussion in the v3 email thread:
http://lkml.kernel.org/r/20220114180135.83308-1-npache@redhat.com
-- 
Michal Hocko
SUSE Labs
