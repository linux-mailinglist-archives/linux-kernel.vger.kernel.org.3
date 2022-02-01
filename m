Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC534A5E10
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 15:15:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239140AbiBAOPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 09:15:25 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:45268 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239129AbiBAOPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 09:15:25 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 12C20210FB;
        Tue,  1 Feb 2022 14:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1643724924; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xV7svizP3OfMYOgwKWIVNwCgg62pzpKys1nXAAzkk0Y=;
        b=Jamssw3SvWmrNtmIlOjQHTDIuWJ/zqmGM3tooV00B2rIrwgQekL6zxoljkSd7X9N6OSX86
        WND1VLJ8x3yeu9GMpF/PCmya7jrvu7M3OZlzpV/gmSZ9IAHKe971tIpq4btffuXkEnp9zb
        2qg4pKHE/Icl7gLCaRkUzpyMPjG2RhQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1643724924;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xV7svizP3OfMYOgwKWIVNwCgg62pzpKys1nXAAzkk0Y=;
        b=1M3uLSehUJl3TfRqs61sMbV9+jPcG8d4LfXaHM9EgWlvSrIIPQeO+/NdgC9F5miMEtvRbz
        5Yuleo6c0o2LJFCA==
Received: from suse.de (unknown [10.163.43.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 17173A3B89;
        Tue,  1 Feb 2022 14:15:23 +0000 (UTC)
Date:   Tue, 1 Feb 2022 14:15:20 +0000
From:   Mel Gorman <mgorman@suse.de>
To:     Bharata B Rao <bharata@amd.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
        dishaa.talreja@amd.com, Wei Huang <wei.huang2@amd.com>
Subject: Re: [RFC PATCH v0 1/3] sched/numa: Process based autonuma scan
 period framework
Message-ID: <20220201141520.GB3301@suse.de>
References: <20220128052851.17162-1-bharata@amd.com>
 <20220128052851.17162-2-bharata@amd.com>
 <20220131121714.GX3301@suse.de>
 <9f95a85f-5396-b8bd-50cf-c4eeeac2a013@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <9f95a85f-5396-b8bd-50cf-c4eeeac2a013@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 01, 2022 at 05:52:55PM +0530, Bharata B Rao wrote:
> On 1/31/2022 5:47 PM, Mel Gorman wrote:
> > On Fri, Jan 28, 2022 at 10:58:49AM +0530, Bharata B Rao wrote:
> >> From: Disha Talreja <dishaa.talreja@amd.com>
> >>
> >> Add a new framework that calculates autonuma scan period
> >> based on per-process NUMA fault stats.
> >>
> >> NUMA faults can be classified into different categories, such
> >> as local vs. remote, or private vs. shared. It is also important
> >> to understand such behavior from the perspective of a process.
> >> The per-process fault stats added here will be used for
> >> calculating the scan period in the adaptive NUMA algorithm.
> >>
> > 
> > Be more specific no how the local vs remote, private vs shared states
> > are reflections of per-task activity of the same.
> 
> Sure, will document the algorithm better. However the overall thinking
> here is that the address-space scanning is a per-process activity and
> hence the scan period value derived from the accumulated per-process
> faults is more appropriate than calculating per-task (per-thread) scan
> periods. Participating threads may have their local/shared and private/shared
> behaviors, but when aggregated at the process level, it gives a better
> input for eventual scan period variation. The understanding is that individual
> thread fault rates will start altering the overall process metrics in
> such a manner that we respond by changing the scan rate to do more aggressive
> or less aggressive scanning.  
> 

I don't have anything to add on your other responses as it would mostly
be an acknowledgment of your response.

However, the major concern I have is that address-space wide decisions
on scan rates has no sensible means of adapting to thread-specific
requirements. I completely agree that it will result in more stable scan
rates, particularly the adjustments. It also side-steps a problem where
new threads may start with a scan rate that is completely inappropriate.

However, I worry that it would be limited overall because each thread
potentially has unique behaviour which is not obvious in a workload like
NAS where threads are all executing similar instructions on different
data. For other applications, threads may operate on thread-local areas
only (low scan rate), others could operate on shared only regresions (high
scan rate until back off and interleave), threads can has phase behaviour
(manager thread collecting data from worker threads) and threads can have
different lifetimes and phase behaviour. Each thread would have a different
optimal scan rate to decide if memory needs to be migrated to a local node
or not. I don't see how address-space wide statistics could every be mapped
back to threads to adapt scan rates based on thread-specific behaviour.

Thread scanning on the other hand can be improved in multiple ways. If
nothing else, they can do redundant scanning of regions that are
not relveant to a task which gets increasingly problematic when VSZ
increases. The obvious problems are

1. Scan based on page table updates, not address ranges to mitigate
   problems with THP vs base page updates

2. Move scan delay to be a per-vma structure that is kmalloced if
   necessary instead of being address space wide.

3. Track what threads access a VMA. The suggestion was to use a unsigned
   long pid_mask and use the lower bits to tag approximately what
   threads access a VMA. Skip VMAs that did not trap a fault. This would
   be approximate because of PID collisions but would reduce scanning
   of areas the thread is not interested in

4. Track active regions within VMAs. Very coarse tracking, use unsigned
   long to trap what ranges are active

In different ways, this would reduce the amount of scanning work threads
do and focuses them on regions of relevance to reduce overhead overall
without losing thread-specific details.

Unfortunately, I have not had the time yet to prototype anything.

-- 
Mel Gorman
SUSE Labs
