Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 476D048EC04
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 15:51:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242047AbiANOvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 09:51:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237563AbiANOvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 09:51:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC83DC061574;
        Fri, 14 Jan 2022 06:51:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A650EB8262B;
        Fri, 14 Jan 2022 14:51:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C758C36AE5;
        Fri, 14 Jan 2022 14:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642171901;
        bh=yaOizYp7PqICnKbARXVt6Mn6FZ+YHOUAoV2+IK4tmiw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CQuyq2XeyO/ZVqqJ03lbcrYTW49tCagXH8m5AOyKHsEuwIt8xWcTnM9/Ai9OzlYPX
         bwRngRNMxKIEIOof2lpqsWdXoOj0pOD9qujfiWx3xlxDQXFNX67IegUzuCGVIZe6dr
         1PYgjk+7Jx4jmTie63tel8L4G9FDADGCmCOnp3koxVslgMSBB4NME2VOoraDpoZ0VB
         vLW8YQzYe4+cgJgIBeZMV+YXzGptqbbkHkWyzrJZLW4pwu1/vNSr/W+Dr4b8ZPa2OG
         dKCjsswx2/sM3qnKuJ2LUFG6aqmXkz+TrPeW9mUyipMG2qbTojT3k1CfY05+A1fBJY
         zn9ddk0iGUCRQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id CC62840714; Fri, 14 Jan 2022 11:51:38 -0300 (-03)
Date:   Fri, 14 Jan 2022 11:51:38 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Thomas Richter <tmricht@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        svens@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com
Subject: Re: [PATCH] tools/perf: Fix perf test 7 Simple expression parser on
 s390
Message-ID: <YeGN+mT1yjJ60php@kernel.org>
References: <20211124090343.9436-1-tmricht@linux.ibm.com>
 <CAP-5=fXdOQUNDTXvt7GHRvu_7jyTPp_53f8_5DzDCXWCpWLtEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fXdOQUNDTXvt7GHRvu_7jyTPp_53f8_5DzDCXWCpWLtEQ@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Nov 24, 2021 at 07:41:40AM -0800, Ian Rogers escreveu:
> On Wed, Nov 24, 2021 at 1:04 AM Thomas Richter <tmricht@linux.ibm.com> wrote:
> >
> > Commit fdf1e29b6118 ("perf expr: Add metric literals for topology.")
> > fails on s390:
> >  # ./perf test -Fv 7
> >    ...
> >  # FAILED tests/expr.c:173 #num_dies >= #num_packages
> >    ---- end ----
> >    Simple expression parser: FAILED!
> >  #
> >
> > Investigating this issue leads to these functions:
> >  build_cpu_topology()
> >    +--> has_die_topology(void)
> >         {
> >            struct utsname uts;
> >
> >            if (uname(&uts) < 0)
> >                   return false;
> >            if (strncmp(uts.machine, "x86_64", 6))
> >                   return false;
> >            ....
> >         }
> >
> > which always returns false on s390. The caller build_cpu_topology()
> > checks has_die_topology() return value. On false the
> > the struct cpu_topology::die_cpu_list is not contructed and has zero
> > entries. This leads to the failing comparison: #num_dies >= #num_packages.
> > s390 of course has a positive number of packages.
> >
> > Fix this by adding s390 architecture to support CPU die list.

Thanks, applied.

- Arnaldo


> > Output after:
> >  # ./perf test -Fv 7
> >   7: Simple expression parser                                        :
> >   --- start ---
> >   division by zero
> >   syntax error
> >   ---- end ----
> >   Simple expression parser: Ok
> >  #
> > Cc: Ian Rogers <irogers@google.com>
> > Fixes: fdf1e29b6118 ("perf expr: Add metric literals for topology.")
> >
> > Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> 
> Reviewed-by: Ian Rogers <irogers@google.com>
> 
> Thanks!
> Ian
> 
> > ---
> >  tools/perf/util/cputopo.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/util/cputopo.c b/tools/perf/util/cputopo.c
> > index 51b429c86f98..aad7a9e6e31b 100644
> > --- a/tools/perf/util/cputopo.c
> > +++ b/tools/perf/util/cputopo.c
> > @@ -165,7 +165,8 @@ static bool has_die_topology(void)
> >         if (uname(&uts) < 0)
> >                 return false;
> >
> > -       if (strncmp(uts.machine, "x86_64", 6))
> > +       if (strncmp(uts.machine, "x86_64", 6) &&
> > +           strncmp(uts.machine, "s390x", 5))
> >                 return false;
> >
> >         scnprintf(filename, MAXPATHLEN, DIE_CPUS_FMT,
> > --
> > 2.31.1
> >

-- 

- Arnaldo
