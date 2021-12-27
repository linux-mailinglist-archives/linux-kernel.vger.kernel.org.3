Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2015847F9D5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 04:11:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235020AbhL0DKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Dec 2021 22:10:02 -0500
Received: from mga02.intel.com ([134.134.136.20]:32506 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235012AbhL0DKB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Dec 2021 22:10:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640574601; x=1672110601;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=Zbw31OF5Mmys3xkrygmZm/0V3U9gjJ3ZaoPpo/MsOpk=;
  b=U3xuQp89+FGwIk4W66p2ou6uyFa9ey63bjo3wgNFW9qD9b2cmnHyC6V/
   MfEhITHK7KYMhNJQZNYH91AHgYnHjCRVd6/SJpejcqBDjYn5/Ks6byH54
   GIV07RQjcHmKzXqOMQ4LLvxjELYhvpdMuzyOTshH7pslXwUNycErVzlTN
   jANAcqJFUIJMbXqLBjo2+Tv681UteH85bY6rXU+u5ETFPpMXcLqRssSCp
   TF1cxPbnRRztIEoHhOoDAwwX0QEvseIBLIFUqy6Yf9Ad6DaGW9TXJzbVK
   MFWsn877S3LnZvmVKNuAK3sSj74JHmxR3ixC0CjctYkN9wwbgS/G3uayz
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10209"; a="228458776"
X-IronPort-AV: E=Sophos;i="5.88,238,1635231600"; 
   d="scan'208";a="228458776"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2021 19:10:01 -0800
X-IronPort-AV: E=Sophos;i="5.88,238,1635231600"; 
   d="scan'208";a="523133924"
Received: from unknown (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.13.11])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2021 19:09:58 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     SeongJae Park <sj@kernel.org>
Cc:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        akpm@linux-foundation.org, dave.hansen@linux.intel.com,
        ziy@nvidia.com, shy828301@gmail.com,
        zhongjiang-ali@linux.alibaba.com, xlpang@linux.alibaba.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Minchan Kim <minchan@kernel.org>
Subject: Re: [PATCH v2 0/2] Add a new scheme to support demotion on tiered
 memory system
References: <20211223113139.20843-1-sj@kernel.org>
Date:   Mon, 27 Dec 2021 11:09:56 +0800
In-Reply-To: <20211223113139.20843-1-sj@kernel.org> (SeongJae Park's message
        of "Thu, 23 Dec 2021 11:31:39 +0000")
Message-ID: <87o8527ngb.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, SeongJae,

SeongJae Park <sj@kernel.org> writes:

> Hi,
>
> On Thu, 23 Dec 2021 15:51:18 +0800 "Huang, Ying" <ying.huang@intel.com> wrote:

[snip]

>> It's good to avoid to change the source code of an application to apply
>> some memory management optimization (for example, use DAMON +
>> madvise()).  But it's much easier to run a user space daemon to optimize
>> for the application.  (for example, use DAMON + other information +
>> process_madvise()).
>> 
>> And this kind of per-application optimization is kind of application
>> specific policy.  This kind of policy may be too complex and flexible to
>> be put in the kernel directly.  For example, in addition to DAMON, some
>> other application specific or system knowledge may be helpful too, so we
>> have process_madvise() for that before DAMON.  Some more complex
>> algorithm may be needed for some applications.
>> 
>> And this kind of application specific policy usually need complex
>> configuration.  It's hard to export all these policy parameters to the
>> user space as the kernel ABI.  Now, DAMON schemes parameters are
>> exported in debugfs so they are not considered ABI.  So they may be
>> changed at any time.  But applications need some stable and
>> well-maintained ABI.
>> 
>> All in all, IMHO, what we need is a user space per-application policy
>> daemon with the information from DAMON and other sources.
>
> I basically agree to Ying, as I also noted in the coverletter of DAMOS
> patchset[1]:
>
>     DAMON[1] can be used as a primitive for data access aware memory
>     management optimizations.  For that, users who want such optimizations
>     should run DAMON, read the monitoring results, analyze it, plan a new
>     memory management scheme, and apply the new scheme by themselves.  Such
>     efforts will be inevitable for some complicated optimizations.
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=fda504fade7f124858d7022341dc46ff35b45274
>
> That is, I believe some programs and big companies would definitely have their
> own information and want such kind of complicated optimizations.  But, such
> optimizations would depend on characteristics of each program and require
> investment of some amount of resources.  Some other programs and users wouldn't
> have such special information, and/or resource to invest for such
> optimizations.  For them, some amount of benefit would be helpful enough even
> though its sub-optimal.
>
> I think we should help both groups, and DAMOS could be useful for the second
> group.  And I don't think DAMOS is useless for the first group.  They could use
> their information-based policy in prallel to DAMOS in some cases.  E.g., if
> they have a way to predict the data access pattern of specific memory region
> even without help from DAMON, they can use their own policy for the region but
> DAMOS for other regions.
>
> Someone could ask why not implement a user-space implementation for the second
> group, then.  First of all, DAMOS is not only for the user-space driven virtual
> memory management optimization, but also for kernel-space programs and any
> DAMOS-supportable address spaces including the physical address space.  And,
> another important goal of DAMOS for user space driven use case in addition to
> reducing the redundant code is minimizing the user-kernel context switch
> overhead for passing the monitoring results information and memory management
> action requests.
>
> In summary, I agree the user space per-application policy daemon will be useful
> for the specialized ultimate optimizations, but we also need DAMOS for another
> common group of cases.
>
> If I'm missing something, please feel free to let me know.

I guess that most end-users and quite some system administrators of
small companies have no enough capability to take advantage of the
per-application optimizations.  How do they know the appropriate region
number and proactive reclaim threshold?

So per my understanding, Linux kernel
need provide,

1. An in-kernel general policy that is obviously correct and benefits
   almost all users and applications, at least no regression.  No
   complex configuration or deep knowledge is needed to take advantage
   of it.

2. Some way to inspect and control system and application behavior, so
   that some advanced and customized user space policy daemons can be
   built to satisfy some advanced users who have the enough knowledge
   for the applications and systems, for example, oomd.

Best Regards,
Huang, Ying
