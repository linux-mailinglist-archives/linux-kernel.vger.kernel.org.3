Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D36A484E4F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 07:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbiAEGTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 01:19:51 -0500
Received: from beige.elm.relay.mailchannels.net ([23.83.212.16]:42779 "EHLO
        beige.elm.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229861AbiAEGTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 01:19:48 -0500
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 4311A120FFA
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 06:19:46 +0000 (UTC)
Received: from pdx1-sub0-mail-a305.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 6A9B0120DCC
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 06:19:45 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from pdx1-sub0-mail-a305.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.121.9.225 (trex/6.4.3);
        Wed, 05 Jan 2022 06:19:46 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Print-Ruddy: 0f8fc3552b106d4e_1641363586119_358816705
X-MC-Loop-Signature: 1641363586119:445547311
X-MC-Ingress-Time: 1641363586118
Received: from kmjvbox (c-98-207-114-56.hsd1.ca.comcast.net [98.207.114.56])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kjlx@templeofstupid.com)
        by pdx1-sub0-mail-a305.dreamhost.com (Postfix) with ESMTPSA id 4JTK8J1RSmz1Pb
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 22:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=templeofstupid.com;
        s=templeofstupid.com; t=1641363584; bh=DdLVDGCXyiVR7k/+OIBTxOcBchQ=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=Rde473Xaj8mKAB79jbYwfTvgdUOLcM/rebNbONuCwbgGfVEZsS6SO7UL43G1dHbh/
         JMUBMkyaG7Q6SvtLmsU5HCW0sq9/BUfYGKZhH/jQrdutliwQJeMe1NCO7NnDmQx8mn
         TJcYx70NOP8QyDX05ujZgnyO9S40WluLooMRDMTQ=
Received: from johansen (uid 1000)
        (envelope-from kjlx@templeofstupid.com)
        id e00d9
        by kmjvbox (DragonFly Mail Agent v0.9);
        Tue, 04 Jan 2022 22:19:42 -0800
Date:   Tue, 4 Jan 2022 22:19:42 -0800
From:   Krister Johansen <kjlx@templeofstupid.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Riccardo Mancini <rickyman7@gmail.com>,
        Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 01/20] perf nsinfo: fix refcounting
Message-ID: <20220105061942.GA20464@templeofstupid.com>
References: <cover.1626343282.git.rickyman7@gmail.com>
 <55223bc8821b34ccb01f92ef1401c02b6a32e61f.1626343282.git.rickyman7@gmail.com>
 <YPCGONcQx5SxEKdY@kernel.org>
 <YPCKeDvyLOQzKTln@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YPCKeDvyLOQzKTln@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 15, 2021 at 04:20:24PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Thu, Jul 15, 2021 at 04:02:16PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Thu, Jul 15, 2021 at 06:07:06PM +0200, Riccardo Mancini escreveu:
> > > ASan reports a memory leak of nsinfo during the execution of the perf
> > > test "31: Lookup mmap thread".
> > > The leak is caused by a refcounted variable being replaced without
> > > dropping the refcount.
> 
> > > This patch makes sure that the refcnt of nsinfo is decreased whenever
> > > a refcounted variable is replaced with a new value.
> 
> > So, there are multiple fixes in just one patch, I'll split it into
> > three, no need to resend.
> 
> > I'll try and check if finding Fixes: for the three is easy, that way
> > stable@vger.kernel.org will figure out which of the supported releases
> > need each of them.
> 
> The second is at the end of this message, and looking at it I think
> there is a problem with where this nsinfo reference is stored, it should
> be in the 'struct map', that is per-thread, not in the 'struct dso',
> that may be shared by multiple 'struct map's in different cgroups, so we
> can't set dso->nsinfo in map__new(), right? Kristen?

Apologies for the long delayed reply, and for the hassle that this has
caused.

You're right, Arnaldo, that namespace mapping could differ on a per
thread basis.  If the dso objects are intended to be read by multiple
threads with different views of the target process's namespaces.  With
containers, though, there might be many different versions of the same
object with the same filename, and the only ways we can disambiguate are
through the build-ids or by ensuring that the dso refers to a single
pid and mount namespace.  I may have erred in assuming that all of
perf's threads would be able to access the target namespace via the same
identifiers.  Is that what's going on here?

-K


> commit 280f3933661f9ca9563ed04ce82313fdbcbb8f75
> Author: Riccardo Mancini <rickyman7@gmail.com>
> Date:   Thu Jul 15 18:07:06 2021 +0200
> 
>     perf map: Fix dso->nsinfo refcounting
>     
>     ASan reports a memory leak of nsinfo during the execution of
>     
>       # perf test "31: Lookup mmap thread"
>     
>     The leak is caused by a refcounted variable being replaced without
>     dropping the refcount.
>     
>     This patch makes sure that the refcnt of nsinfo is decreased whenever a
>     refcounted variable is replaced with a new value.
>     
>     Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
>     Fixes: bf2e710b3cb8445c ("perf maps: Lookup maps in both intitial mountns and inner mountns.")
>     Cc: Ian Rogers <irogers@google.com>
>     Cc: Jiri Olsa <jolsa@redhat.com>
>     Cc: Krister Johansen <kjlx@templeofstupid.com>
>     Cc: Mark Rutland <mark.rutland@arm.com>
>     Cc: Namhyung Kim <namhyung@kernel.org>
>     Cc: Peter Zijlstra <peterz@infradead.org>
>     Link: http://lore.kernel.org/lkml/55223bc8821b34ccb01f92ef1401c02b6a32e61f.1626343282.git.rickyman7@gmail.com
>     Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
> index 8af693d9678cefe0..72e7f3616157ead4 100644
> --- a/tools/perf/util/map.c
> +++ b/tools/perf/util/map.c
> @@ -192,6 +192,8 @@ struct map *map__new(struct machine *machine, u64 start, u64 len,
>  			if (!(prot & PROT_EXEC))
>  				dso__set_loaded(dso);
>  		}
> +
> +		nsinfo__put(dso->nsinfo);
>  		dso->nsinfo = nsi;
>  
>  		if (build_id__is_defined(bid))
> 
