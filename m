Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0929564011
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 14:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231753AbiGBMYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 08:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiGBMYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 08:24:33 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D026BF6D;
        Sat,  2 Jul 2022 05:24:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 8B923CE09B0;
        Sat,  2 Jul 2022 12:24:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75EB2C34114;
        Sat,  2 Jul 2022 12:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656764667;
        bh=ZNZ46I/+Tr07uSTHn6YEkrryLZvZ1I/wq2wEZHBWH40=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HPSRInqT2D7eP9FEvp3X2tAdQJo9SMTBhXqP/cUv1eEp563XLbVzaKQeHlpEcul0w
         d2awAdZzMttSGOskUWs5dBhp8rPaYfi3RTrrHb7SXtVQyxAwj2hVDlJ/uUdsGPEZWd
         A0BmM0CxnOD48zWbhOt39xsJLqPriM3QKAWUjMVlHr8KP2M3iBYTI3X4gzovo+EjTc
         p4itBJLUbTPOLNUP/uTtqJm9h36Y5TCbcaaFcdFe9p/hXagm4z4bSzxDmiFQ6yHZWJ
         zoJLmqUVXM96XGJQ/XS7Sf3PzCn81u5/dWjKSWrD1beDJiKskLbMYUntW3vJM/j855
         p9Y571QpQNRrw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id BBAFB4096F; Sat,  2 Jul 2022 09:24:24 -0300 (-03)
Date:   Sat, 2 Jul 2022 09:24:24 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>,
        Dominique Martinet <asmadeus@codewreck.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf parse: Allow names to start with digits
Message-ID: <YsA4+A7TSjzUKDWK@kernel.org>
References: <20220612061508.1449636-1-asmadeus@codewreck.org>
 <YsAUqwzeO8U6cIJA@codewreck.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YsAUqwzeO8U6cIJA@codewreck.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Jul 02, 2022 at 06:49:31PM +0900, Dominique Martinet escreveu:
> Hello,
> 
> just making sure my mail didn't get lost -- would anyone have time to
> look at this?
> 
> I don't mind if it's slow or another solution is taken, I'd just like to
> be able to use 9p probes with perf eventually :)

Jiri, seems ok, can you please review?

Thanks,

- Arnaldo
 
> Thanks!
> 
> Dominique Martinet wrote on Sun, Jun 12, 2022 at 03:15:08PM +0900:
> > Tracepoints can start with digits, although we don't have many of these:
> > 
> > $ rg -g '*.h' '\bTRACE_EVENT\([0-9]'
> > net/mac802154/trace.h
> > 53:TRACE_EVENT(802154_drv_return_int,
> > ...
> > 
> > net/ieee802154/trace.h
> > 66:TRACE_EVENT(802154_rdev_add_virtual_intf,
> > ...
> > 
> > include/trace/events/9p.h
> > 124:TRACE_EVENT(9p_client_req,
> > ...
> > 
> > Just allow names to start with digits too so e.g. perf probe -e '9p:*'
> > works
> > 
> > Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
> > ---
> >  tools/perf/util/parse-events.l | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
> > index 5b6e4b5249cf..4133d6950d29 100644
> > --- a/tools/perf/util/parse-events.l
> > +++ b/tools/perf/util/parse-events.l
> > @@ -211,7 +211,7 @@ bpf_source	[^,{}]+\.c[a-zA-Z0-9._]*
> >  num_dec		[0-9]+
> >  num_hex		0x[a-fA-F0-9]+
> >  num_raw_hex	[a-fA-F0-9]+
> > -name		[a-zA-Z_*?\[\]][a-zA-Z0-9_*?.\[\]!]*
> > +name		[a-zA-Z0-9_*?\[\]][a-zA-Z0-9_*?.\[\]!]*
> >  name_tag	[\'][a-zA-Z_*?\[\]][a-zA-Z0-9_*?\-,\.\[\]:=]*[\']
> >  name_minus	[a-zA-Z_*?][a-zA-Z0-9\-_*?.:]*
> >  drv_cfg_term	[a-zA-Z0-9_\.]+(=[a-zA-Z0-9_*?\.:]+)?

-- 

- Arnaldo
