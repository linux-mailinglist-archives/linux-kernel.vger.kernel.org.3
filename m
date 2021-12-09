Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB5546F3D2
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 20:20:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbhLITYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 14:24:01 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:48040 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbhLITYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 14:24:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3F5BBB8261E;
        Thu,  9 Dec 2021 19:20:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE28EC004DD;
        Thu,  9 Dec 2021 19:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639077624;
        bh=1CyxqH3Ile4Tu0K1fbYd2p4o6u/8+0oTDj5FQH4uFX0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XTORxXtyGdai/WJ3g6ZzWBHAAHwxATXvL/zAznFNZZFPj1NGVVX9gH1LaH3rZjMaZ
         6F+qzYt95SUr5yDuX8bgT51ztaSm6F7oHISaPA04za11kGyW2pIb/hUu7+oAy0dva3
         XVSf+GWQ9BeY1fBOgEo2h7KYeWhhBhi0+zwPj/4GaHHEC6L5bNoeNoPVYWpiyHmwYQ
         KhsbYRx3SsXUKO/g53Ws3gZ9rxX7KRkpzVNctoDAtMabz70RkG7kavU2uAmcTNsIe4
         9BE/QN2y+pfXhj5vaUGF0hsmaxPK6M6VJoO2CnMzTihqG21uwYuVM+LXuo/lnG/FM4
         0iZsGyx0hhLSA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5C2F7405D8; Thu,  9 Dec 2021 16:20:22 -0300 (-03)
Date:   Thu, 9 Dec 2021 16:20:22 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Salvatore Bonaccorso <carnil@debian.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     German Gomez <german.gomez@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf dlfilter: Drop unused variable
Message-ID: <YbJW9sHObkXC5lcz@kernel.org>
References: <20211123211821.132924-1-carnil@debian.org>
 <5603b487-3e42-cfbd-200b-250c46dc0bc6@arm.com>
 <YbCS/xEis4QKbH6D@eldamar.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YbCS/xEis4QKbH6D@eldamar.lan>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Dec 08, 2021 at 12:11:59PM +0100, Salvatore Bonaccorso escreveu:
> Hi German,
> 
> On Wed, Dec 08, 2021 at 10:44:01AM +0000, German Gomez wrote:
> > 
> > On 23/11/2021 21:18, Salvatore Bonaccorso wrote:
> > > Compiling tools/perf/dlfilters/dlfilter-test-api-v0.c result in:
> > >
> > > 	checking for stdlib.h... dlfilters/dlfilter-test-api-v0.c: In function ‘filter_event’:
> > > 	dlfilters/dlfilter-test-api-v0.c:311:29: warning: unused variable ‘d’ [-Wunused-variable]
> > > 	  311 |         struct filter_data *d = data;
> > > 	      |
> > 
> > Did you get this warning when issuing "make"? From my side, it generated
> > this gcc command so I didn't get it (make DEBUG=1):
> > 
> >   gcc -c -Iinclude  -o dlfilters/dlfilter-test-api-v0.o -fpic dlfilters/dlfilter-test-api-v0.c
> > 
> > Reviewed-by: German Gomez <german.gomez@arm.com>
> 
> Only when passing -Wall (this is the case when building the kernel packages in
> Debian with additional flags, so this is why this was spotted):
> 
> gcc -Wall -c -Iinclude  -o dlfilters/dlfilter-test-api-v0.o -fpic dlfilters/dlfilter-test-api-v0.c
> dlfilters/dlfilter-test-api-v0.c: In function ‘filter_event’:
> dlfilters/dlfilter-test-api-v0.c:311:29: warning: unused variable ‘d’ [-Wunused-variable]
>   311 |         struct filter_data *d = data;
>       |
> 

So I'm applying this, its an obvious cleanup, but please CC the author
next time, I'm doing it in this reply, Adrian, ok?

- Arnaldo
