Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4461946E384
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 08:52:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232760AbhLIHza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 02:55:30 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:57896 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232321AbhLIHz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 02:55:29 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id DD9C6212BF;
        Thu,  9 Dec 2021 07:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1639036315; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=x/7/rcnJctjFhlP0Z/jKgO0KxVAnZ5tPslNFyeLkqJo=;
        b=XLMyk2a6AQ19NvR+UE/nfaizC0vafoipHNbhLdO3kyCYjpyAzHBmkFgPhNSdnsPJIDoB/P
        w0s+mUejR0couT27WARaEw+ii5ZU8FpKYpJNrh1fffVnYFw4XrYUJHbvRY09axSQSA7k0l
        88uMOcMi/cUez75J21BM/QmEgF3EwjQ=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 714D5A3B85;
        Thu,  9 Dec 2021 07:51:55 +0000 (UTC)
Date:   Thu, 9 Dec 2021 08:51:54 +0100
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
Message-ID: <YbG1mu0CLONo+Z7l@dhcp22.suse.cz>
References: <20211207214902.772614-1-jsavitz@redhat.com>
 <20211207154759.3f3fe272349c77e0c4aca36f@linux-foundation.org>
 <YbB0d6T8RbHW48sZ@dhcp22.suse.cz>
 <YbDX16LAkvzgYHpH@dhcp22.suse.cz>
 <CAL1p7m4ka1v-Zoi-RpDy5ME-bMikGPX5V_4Hod-Y0KHOq_G8zA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL1p7m4ka1v-Zoi-RpDy5ME-bMikGPX5V_4Hod-Y0KHOq_G8zA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 08-12-21 21:59:29, Joel Savitz wrote:
> On Wed, Dec 8, 2021 at 11:05 AM Michal Hocko <mhocko@suse.com> wrote:
[...]
> > I have had a closer look and I guess I can see what you are trying to
> > achieve. futex_exit_release is normally called from exit_mm context. You
> > are likely seeing a situation when the oom victim is blocked and cannot
> > exit. That is certainly possible but it shouldn't be a permanent state.
> > So I would be more interested about your particular issue and how long
> > the task has been stuck unable to exit.
> 
> Before applying this patch I never saw a task eventually exit during
> the reproduction of this system state.

What has happened to the oom victim and why it has never exited?

Side note. I have noticed that you have sent v2 with minor changes. It
is usualy better to resolve review feedback before posting a new
version. Discussion gets rather hard to follow otherwise.

Thanks!
-- 
Michal Hocko
SUSE Labs
