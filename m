Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7EA346CAAF
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 02:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234690AbhLHCBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 21:01:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233974AbhLHCBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 21:01:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEB07C061574
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 17:58:22 -0800 (PST)
Received: from mail.kernel.org (unknown [198.145.29.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 58B00B81EBF
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 01:58:21 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9386C60E98;
        Wed,  8 Dec 2021 01:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1638928699;
        bh=UHBVM39wbjqenKtvco+63lP4qWtUsYPVUFf21pmCGkU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NOXMljeOqG0L1T/Hm4N9sMFXEMlV3KiuhihWAed98uC3qDQFF0dAmdSuUmpsT5OUx
         QNJn2Z4XDJrsr3nd90fLur2Yi+iUKnKXOOIeWCNXRTrxv6JF2NaGsngYV8pZ0LvSf9
         4GWqffd7Ge5/lwjfHi0yZyKYKf0HHMtODwdDruEE=
Date:   Tue, 7 Dec 2021 17:58:16 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Nico Pache <npache@redhat.com>
Cc:     Joel Savitz <jsavitz@redhat.com>, linux-kernel@vger.kernel.org,
        Waiman Long <longman@redhat.com>, linux-mm@kvack.org,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH] mm/oom_kill: wake futex waiters before annihilating
 victim shared mutex
Message-Id: <20211207175816.8c45ff5b82cb964ade82d6f1@linux-foundation.org>
In-Reply-To: <ce63e509-dedf-ce00-cd12-2c67a3e650ba@redhat.com>
References: <20211207214902.772614-1-jsavitz@redhat.com>
        <20211207154759.3f3fe272349c77e0c4aca36f@linux-foundation.org>
        <ce63e509-dedf-ce00-cd12-2c67a3e650ba@redhat.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Dec 2021 19:46:57 -0500 Nico Pache <npache@redhat.com> wrote:

> 
> 
> On 12/7/21 18:47, Andrew Morton wrote:
> > (cc's added)
> > 
> > On Tue,  7 Dec 2021 16:49:02 -0500 Joel Savitz <jsavitz@redhat.com> wrote:
> > 
> >> In the case that two or more processes share a futex located within
> >> a shared mmaped region, such as a process that shares a lock between
> >> itself and a number of child processes, we have observed that when
> >> a process holding the lock is oom killed, at least one waiter is never
> >> alerted to this new development and simply continues to wait.
> > 
> > Well dang.  Is there any way of killing off that waiting process, or do
> > we have a resource leak here?
> 
> If I understood your question correctly, there is a way to recover the system by
> killing the process that is utilizing the futex; however, the purpose of robust
> futexes is to avoid having to do this.

OK.  My concern was whether we have a way in which userspace can
permanently leak memory, which opens a (lame) form of denial-of-service
attack.

> >From my work with Joel on this it seems like a race is occurring between the
> oom_reaper and the exit signal sent to the OMM'd process. By setting the
> futex_exit_release before these signals are sent we avoid this.

OK.  It would be nice if the patch had some comments explaining *why*
we're doing this strange futex thing here.  Although that wouldn't be
necessary if futex_exit_release() was documented...
