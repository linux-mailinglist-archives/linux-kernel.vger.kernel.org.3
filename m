Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 510CA47C866
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 21:49:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235018AbhLUUtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 15:49:00 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:43748 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233546AbhLUUtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 15:49:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DE027B819E7;
        Tue, 21 Dec 2021 20:48:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70AF5C36AE9;
        Tue, 21 Dec 2021 20:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640119737;
        bh=g6gqJ+KeVGJoBQHhgVWPalUdsd+av7U2ld9ePfN05yY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Pyy+g56HvHrz4K1K6Ooxl/9OvZQ6oY47ncyGf4v8bYg8BtTpUq6d/GHBZ+9+ihQqX
         bTQxdRIVtVvyfrA+buN9aAX5kkSzcACCsvCNUM9y2e2r2VjK059oLbpkmoGJYiZnRb
         czj81XiGJFoUeA6pxhLeqS9CIZCUqepVW9C0z/hqLI13wRl6mHW7bcPPINxkLlCuPN
         L5dDOtF7AoTiQu7WePciup+zPm4e9Y6qKQwQ0vuaXSv5TeEMInvxcRx9DcTH9NZydd
         7GOzKxA3nx+UMdM0ktpbe9ZN96lrO3sMCxe2XaX8ghtza2/SJAbRplCn6OpJl8rHL+
         EnP2aFKpH8g3Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 93D0940B92; Tue, 21 Dec 2021 17:48:55 -0300 (-03)
Date:   Tue, 21 Dec 2021 17:48:55 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     John Garry <john.garry@huawei.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, peterz@infradead.org,
        mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        irogers@google.com, kan.liang@linux.intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf pmu: Fix event list for uncore PMUs
Message-ID: <YcI9twHCIiFyUDOu@kernel.org>
References: <1639670017-74918-1-git-send-email-john.garry@huawei.com>
 <YcGJJ2g+i5qWea7d@krava>
 <bbf9c0b4-c048-3adf-5282-2355aa648acf@huawei.com>
 <YcGf/d5PPqqyXxUW@krava>
 <43e185f6-9fa7-6ae1-e4fd-c90c6a50f68f@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43e185f6-9fa7-6ae1-e4fd-c90c6a50f68f@huawei.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Dec 21, 2021 at 10:14:42AM +0000, John Garry escreveu:
> On 21/12/2021 09:35, Jiri Olsa wrote:
> > On Tue, Dec 21, 2021 at 09:10:37AM +0000, John Garry wrote:
> > > On 21/12/2021 07:58, Jiri Olsa wrote:
> > > > > +	/* Different names -> never duplicates */
> > > > > +	if (strcmp(alias_a->name, alias_b->name))
> > > > > +		return false;
> > > > > +	if (!alias_a->pmu)
> > > > > +		return true;
> > > > > +	if (!alias_b->pmu)
> > > > > +		return true;
> > > > nit could be:
> > > > 
> > > > 	if (!alias_a->pmu || !alias_b->pmu)
> > > > 		return true;
> > > > 
> > > > would be great to have more comments explaining the check
> > > > 
> > > 
> > > This is just a sanity check that both strings are non-NULL as we do a
> > > strcmp() next. So would this be better:
> > > 
> > > if (!alias_a->pmu || !alias_b->pmu || !strcmp(alias_a->pmu, alias_b->pmu))
> > > 	return true
> > > 
> > > ?
> > > 
> > > It will spill a line.
> > 
> > sure, it cought my eye because the is_cpu check later is done on
> > the same line, so I started wondering what's the difference ;-)
> > 
> 
> Now thinking a bit more I am not confident that this patch is a full fix.
> 
> arm have heterogeneous CPU systems as well - which are not "hybrid" - and I
> need to ensure that aliasing is still working properly there, as I think
> that this following check would stop removing duplicates there:
> 
> +	/* uncore PMUs */
> +	if (!alias_a->is_cpu && !alias_b->is_cpu)
> +		return true;
> +	return false;

I was about to process this, do you think its better to revert the
original patch while this gets fixed?

- Arnaldo
