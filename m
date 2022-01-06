Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 913F4486B15
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 21:27:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243749AbiAFU1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 15:27:52 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:51328 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243731AbiAFU1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 15:27:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A30BF61CF3;
        Thu,  6 Jan 2022 20:27:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD3DFC36AE5;
        Thu,  6 Jan 2022 20:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641500866;
        bh=sWqBb2jFlcFgn2+XkIFTnMdqv3lUyCjYObSgykeb2Ms=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MpLA1d3FVX8cwM1nVPpqzc1JjfaqMfdfX5Gh1xo3fMpkVHw/axqmCtcGJLCFpDvwk
         UW0SRpcBZPeHDpyDdkas5XAevfFVN4sONv+8ZO9KM5ni4EDtUeSSFrpkAUKupOa0xj
         tavY0GxeZfSBbNs2RI8aj6tdXSJeiaazflp8GPMJG6WX6M7kOs5WD2R4fsfvBtz63F
         luh08TIX0bfExl5b+WQKthbhiwQXgKx5JZ9XcHWSVIVtIHLtrGX6INQP2fSdC6T6WW
         yWXljNzNdBBXYtXpsxfukWx7BWfFZYs/VoB8bCxfIxUGcthzEBLnxyXAvp5VXfn24/
         dII9e5zuK/5CA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id ACE5340B92; Thu,  6 Jan 2022 17:27:43 -0300 (-03)
Date:   Thu, 6 Jan 2022 17:27:43 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Krister Johansen <kjlx@templeofstupid.com>
Cc:     Riccardo Mancini <rickyman7@gmail.com>,
        Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 01/20] perf nsinfo: fix refcounting
Message-ID: <YddQv1O057Mw5Whv@kernel.org>
References: <cover.1626343282.git.rickyman7@gmail.com>
 <55223bc8821b34ccb01f92ef1401c02b6a32e61f.1626343282.git.rickyman7@gmail.com>
 <YPCGONcQx5SxEKdY@kernel.org>
 <YPCKeDvyLOQzKTln@kernel.org>
 <20220105061942.GA20464@templeofstupid.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220105061942.GA20464@templeofstupid.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jan 04, 2022 at 10:19:42PM -0800, Krister Johansen escreveu:
> On Thu, Jul 15, 2021 at 04:20:24PM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Thu, Jul 15, 2021 at 04:02:16PM -0300, Arnaldo Carvalho de Melo escreveu:
> > > Em Thu, Jul 15, 2021 at 06:07:06PM +0200, Riccardo Mancini escreveu:
> > > > ASan reports a memory leak of nsinfo during the execution of the perf
> > > > test "31: Lookup mmap thread".
> > > > The leak is caused by a refcounted variable being replaced without
> > > > dropping the refcount.
> > 
> > > > This patch makes sure that the refcnt of nsinfo is decreased whenever
> > > > a refcounted variable is replaced with a new value.
> > 
> > > So, there are multiple fixes in just one patch, I'll split it into
> > > three, no need to resend.
> > 
> > > I'll try and check if finding Fixes: for the three is easy, that way
> > > stable@vger.kernel.org will figure out which of the supported releases
> > > need each of them.
> > 
> > The second is at the end of this message, and looking at it I think
> > there is a problem with where this nsinfo reference is stored, it should
> > be in the 'struct map', that is per-thread, not in the 'struct dso',
> > that may be shared by multiple 'struct map's in different cgroups, so we
> > can't set dso->nsinfo in map__new(), right? Kristen?
> 
> Apologies for the long delayed reply, and for the hassle that this has
> caused.
> 
> You're right, Arnaldo, that namespace mapping could differ on a per
> thread basis.  If the dso objects are intended to be read by multiple
> threads with different views of the target process's namespaces.  With
> containers, though, there might be many different versions of the same
> object with the same filename, and the only ways we can disambiguate are
> through the build-ids or by ensuring that the dso refers to a single
> pid and mount namespace.  I may have erred in assuming that all of
> perf's threads would be able to access the target namespace via the same
> identifiers.  Is that what's going on here?

yeah, I think using build-ids, when available is the way to go, and
since we can almost take it for granted (haven't checked) that it will
be present, as I think gcc/clang adds them by default, seems the way to
go.

That or somehow have the DSO list to be perf namespace.

- Arnaldo
 
> -K
> 
> 
> > commit 280f3933661f9ca9563ed04ce82313fdbcbb8f75
> > Author: Riccardo Mancini <rickyman7@gmail.com>
> > Date:   Thu Jul 15 18:07:06 2021 +0200
> > 
> >     perf map: Fix dso->nsinfo refcounting
> >     
> >     ASan reports a memory leak of nsinfo during the execution of
> >     
> >       # perf test "31: Lookup mmap thread"
> >     
> >     The leak is caused by a refcounted variable being replaced without
> >     dropping the refcount.
> >     
> >     This patch makes sure that the refcnt of nsinfo is decreased whenever a
> >     refcounted variable is replaced with a new value.
> >     
> >     Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
> >     Fixes: bf2e710b3cb8445c ("perf maps: Lookup maps in both intitial mountns and inner mountns.")
> >     Cc: Ian Rogers <irogers@google.com>
> >     Cc: Jiri Olsa <jolsa@redhat.com>
> >     Cc: Krister Johansen <kjlx@templeofstupid.com>
> >     Cc: Mark Rutland <mark.rutland@arm.com>
> >     Cc: Namhyung Kim <namhyung@kernel.org>
> >     Cc: Peter Zijlstra <peterz@infradead.org>
> >     Link: http://lore.kernel.org/lkml/55223bc8821b34ccb01f92ef1401c02b6a32e61f.1626343282.git.rickyman7@gmail.com
> >     Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > 
> > diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
> > index 8af693d9678cefe0..72e7f3616157ead4 100644
> > --- a/tools/perf/util/map.c
> > +++ b/tools/perf/util/map.c
> > @@ -192,6 +192,8 @@ struct map *map__new(struct machine *machine, u64 start, u64 len,
> >  			if (!(prot & PROT_EXEC))
> >  				dso__set_loaded(dso);
> >  		}
> > +
> > +		nsinfo__put(dso->nsinfo);
> >  		dso->nsinfo = nsi;
> >  
> >  		if (build_id__is_defined(bid))
> > 

-- 

- Arnaldo
