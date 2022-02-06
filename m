Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE1094AAF07
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 12:36:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234383AbiBFLgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 06:36:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231858AbiBFLgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 06:36:45 -0500
X-Greylist: delayed 137 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 06 Feb 2022 03:36:44 PST
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF26C06173B
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 03:36:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 281F4B80CF3;
        Sun,  6 Feb 2022 11:36:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF723C340E9;
        Sun,  6 Feb 2022 11:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644147402;
        bh=9H1aLnXFwQuN26Qhe9WeLQmHk0RPxQNas6gi/cJ4cvE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WFNwq7g/MC3JcrRVKkHTHc3M7QV27EshenrMOIK4i4n5hbszRyFhQIAGIKKgqlCfR
         6dDXqzN2gHZ9KcjqqcWgywKC3JqKBBqzcUOYKP84A8aNPOL9SWULHb6wdTq1nBPfxo
         vAiEFzqiLsGnFkIe1u21d6CpYFgHM29DWVLNHKt86a9M4y52M4n32dPbckLiZNA7XG
         AJ4nfBKjpOACxmYdgV/C5VD+ecsLdoAW+3tiACuCMuln6xmIQnWY+Vu2xH0/Zh/iCH
         7Q8Tu3pNJ+h0w1NTzIGy5ThVr8YlC7Z8I6M+FEC8ti+qRty2ZfFxQfefYTeFzZ5Plg
         4ZB5OX/uwmbKQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 18DB8404A6; Sun,  6 Feb 2022 08:36:40 -0300 (-03)
Date:   Sun, 6 Feb 2022 08:36:40 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org, james.clark@arm.com,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf: tools: Add missing branch_sample_type
Message-ID: <Yf+yyDF+PZaBtfzt@kernel.org>
References: <1643799443-15109-1-git-send-email-anshuman.khandual@arm.com>
 <Yfq3kTb7E1cELF0L@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yfq3kTb7E1cELF0L@krava>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Feb 02, 2022 at 05:55:45PM +0100, Jiri Olsa escreveu:
> On Wed, Feb 02, 2022 at 04:27:23PM +0530, Anshuman Khandual wrote:
> > This updates branch sample type with missing PERF_SAMPLE_BRANCH_TYPE_SAVE.
> > 
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: linux-perf-users@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Suggested-by: James Clark <james.clark@arm.com>
> > Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> 
> Acked-by: Jiri Olsa <jolsa@redhat.com>

Thanks, applied.

- Arnaldo

 
> thanks,
> jirka
> 
> > ---
> >  tools/perf/util/perf_event_attr_fprintf.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/perf/util/perf_event_attr_fprintf.c b/tools/perf/util/perf_event_attr_fprintf.c
> > index 47b7531f51da..98af3fa4ea35 100644
> > --- a/tools/perf/util/perf_event_attr_fprintf.c
> > +++ b/tools/perf/util/perf_event_attr_fprintf.c
> > @@ -52,7 +52,7 @@ static void __p_branch_sample_type(char *buf, size_t size, u64 value)
> >  		bit_name(ABORT_TX), bit_name(IN_TX), bit_name(NO_TX),
> >  		bit_name(COND), bit_name(CALL_STACK), bit_name(IND_JUMP),
> >  		bit_name(CALL), bit_name(NO_FLAGS), bit_name(NO_CYCLES),
> > -		bit_name(HW_INDEX),
> > +		bit_name(TYPE_SAVE), bit_name(HW_INDEX),
> >  		{ .name = NULL, }
> >  	};
> >  #undef bit_name
> > -- 
> > 2.20.1
> > 

-- 

- Arnaldo
