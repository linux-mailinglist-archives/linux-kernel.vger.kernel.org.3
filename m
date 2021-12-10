Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89AB04701EF
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 14:38:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238872AbhLJNmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 08:42:06 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:42224 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbhLJNmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 08:42:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 4B351CE2ABC;
        Fri, 10 Dec 2021 13:38:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 535BAC00446;
        Fri, 10 Dec 2021 13:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639143506;
        bh=TSZLd0cQ6W5FOQxcItdNTu6RRbzr8QhL5d5532cVRM4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QMN1s1oH0zhFZVR866WPNHX0udD2En2bJtWjo6RV+xnqn/0Nj4QOYNLiWUZvO0K5s
         b9qaKzcvq3/7wOTe2Qz3Ez1GQBAtLsrQsE91CTzcPyyfZL64p0KrU7pI7zR005mwlN
         8Z3fVtnr5LFFZHBCkRZNPNe3XSAJnHS48Yp31f7DCaQcmXkiedVuzpW7Csc+aVxqcK
         J/3udTN74rR/Y+7vJOOIMkOU6fYnC1f0sfazQymvV/zdWuF8Tn5/7dRjn8fYP5IpUA
         vrslFgPbAkOELaQsMmHVaNSP56eAxvB5HiBrpBMn3b6A3BmSe27EHXZBZa1AnwGZ1O
         p+40k+n/ktRww==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B2890405D8; Fri, 10 Dec 2021 10:38:24 -0300 (-03)
Date:   Fri, 10 Dec 2021 10:38:24 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     kajoljain <kjain@linux.ibm.com>
Cc:     German Gomez <german.gomez@arm.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v1 1/4] perf tools: Prevent out-of-bounds access to
 registers
Message-ID: <YbNYUC1poqzrWynP@kernel.org>
References: <20211201123334.679131-1-german.gomez@arm.com>
 <20211201123334.679131-2-german.gomez@arm.com>
 <6705021e-5b02-3323-7dbc-4b774f22a435@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6705021e-5b02-3323-7dbc-4b774f22a435@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Dec 10, 2021 at 02:47:49PM +0530, kajoljain escreveu:
> 
> 
> On 12/1/21 6:03 PM, German Gomez wrote:
> > The size of the cache of register values is arch-dependant
> > (PERF_REGS_MAX). This has the potential of causing an out-of-bounds
> > access in the function "perf_reg_value" if the local architecture
> > contains less registers than the one the perf.data file was recorded on.
> > 
> > Since the maximum number of registers is bound by the bitmask "u64
> > cache_mask", and the size of the cache when running under x86 systems is
> > 64 already, fix the size to 64 and add a range-check to the function
> > "perf_reg_value" to prevent out-of-bounds access.
> > 
> 
> Patch looks good to me.
> 
> Reviewed-by: Kajol Jain<kjain@linux.ibm.com>

Thanks, applied.

- Arnaldo

 
> Thanks,
> Kajol Jain
> 
> > Signed-off-by: German Gomez <german.gomez@arm.com>
> > ---
> >  tools/perf/util/event.h     | 5 ++++-
> >  tools/perf/util/perf_regs.c | 3 +++
> >  2 files changed, 7 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
> > index 95ffed663..c59331eea 100644
> > --- a/tools/perf/util/event.h
> > +++ b/tools/perf/util/event.h
> > @@ -44,13 +44,16 @@ struct perf_event_attr;
> >  /* perf sample has 16 bits size limit */
> >  #define PERF_SAMPLE_MAX_SIZE (1 << 16)
> >  
> > +/* number of register is bound by the number of bits in regs_dump::mask (64) */
> > +#define PERF_SAMPLE_REGS_CACHE_SIZE (8 * sizeof(u64))
> > +
> >  struct regs_dump {
> >  	u64 abi;
> >  	u64 mask;
> >  	u64 *regs;
> >  
> >  	/* Cached values/mask filled by first register access. */
> > -	u64 cache_regs[PERF_REGS_MAX];
> > +	u64 cache_regs[PERF_SAMPLE_REGS_CACHE_SIZE];
> >  	u64 cache_mask;
> >  };
> >  
> > diff --git a/tools/perf/util/perf_regs.c b/tools/perf/util/perf_regs.c
> > index 5ee47ae15..06a7461ba 100644
> > --- a/tools/perf/util/perf_regs.c
> > +++ b/tools/perf/util/perf_regs.c
> > @@ -25,6 +25,9 @@ int perf_reg_value(u64 *valp, struct regs_dump *regs, int id)
> >  	int i, idx = 0;
> >  	u64 mask = regs->mask;
> >  
> > +	if ((u64)id >= PERF_SAMPLE_REGS_CACHE_SIZE)
> > +		return -EINVAL;
> > +
> >  	if (regs->cache_mask & (1ULL << id))
> >  		goto out;
> >  
> > 

-- 

- Arnaldo
