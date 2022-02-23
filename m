Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7543F4C05E3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 01:23:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234070AbiBWAYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 19:24:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231765AbiBWAYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 19:24:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B99D634679;
        Tue, 22 Feb 2022 16:23:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 55324612C3;
        Wed, 23 Feb 2022 00:23:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8791FC340E8;
        Wed, 23 Feb 2022 00:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645575829;
        bh=5BdC/hk6mQx2wiONPIjO2S8J7pPFSbEQ9KnQQgIHc1w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ob1Y5bXJWrbpwDY2/YYzbvCgBABo7khCOAMXduz7XeChqJjAimg0UvcDf5fqcff9o
         6kFj8OfcYmdUrD80sVhKLoMmUyt6xsdkiUscWwFlpyVutpT7uzL98JoW9PgXt/W7FF
         GafZn7Fg8x/OhH9lodzrd6iz/g9Vzzx3I7IHkeyLBK6aPzKdGfXl7JWlkWH0u3jhC7
         XDNSx1tB7BtPDRLm0uNkhAauIck1kKHq0M880Oy5dsryPycyTm6x4fMNhWwvrtmd3B
         j9xgzvj13NL5T9YL8MMzJ+qq8ue8qgMQwmtSc6UZwW4Wy20HUB7CeA30T4kTxdG7Y+
         RX9jBAGtTqBUA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 8CFA1400FE; Tue, 22 Feb 2022 21:23:47 -0300 (-03)
Date:   Tue, 22 Feb 2022 21:23:47 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Mahmoud Abumandour <ma.mandourr@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf data: don't mention --to-ctf if it's not supported
Message-ID: <YhV+kyk7kbuOeY/Q@kernel.org>
References: <20220220113952.138280-1-ma.mandourr@gmail.com>
 <YhQAt+iSkc2VcvEP@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YhQAt+iSkc2VcvEP@krava>
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

Em Mon, Feb 21, 2022 at 10:14:31PM +0100, Jiri Olsa escreveu:
> On Sun, Feb 20, 2022 at 01:39:52PM +0200, Mahmoud Abumandour wrote:
> > From: Mahmoud Mandour <ma.mandourr@gmail.com>
> > 
> > The option `--to-ctf` is only available when perf has libbabeltrace
> > support. Hence, on error, we shouldn't state that user must include
> > `--to-ctf` unless it's supported.
> > 
> > The only user-visible change for this commit is that when `perf` is not
> > configured to support libbabeltrace, the user is only prompted to
> > provide the `--to-json` option instead of bothe `--to-json` and
> > `--to-ctf`.
> > 
> > Signed-off-by: Mahmoud Mandour <ma.mandourr@gmail.com>
> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>

Thanks, applied.

- Arnaldo

 
> thanks,
> jirka
> 
> > ---
> >  tools/perf/builtin-data.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/tools/perf/builtin-data.c b/tools/perf/builtin-data.c
> > index b7f9dc85a407..c22d82d2a73c 100644
> > --- a/tools/perf/builtin-data.c
> > +++ b/tools/perf/builtin-data.c
> > @@ -62,10 +62,17 @@ static int cmd_data_convert(int argc, const char **argv)
> >  		pr_err("You cannot specify both --to-ctf and --to-json.\n");
> >  		return -1;
> >  	}
> > +#ifdef HAVE_LIBBABELTRACE_SUPPORT
> >  	if (!to_json && !to_ctf) {
> >  		pr_err("You must specify one of --to-ctf or --to-json.\n");
> >  		return -1;
> >  	}
> > +#else
> > +	if (!to_json) {
> > +		pr_err("You must specify --to-json.\n");
> > +	return -1;
> > +}
> > +#endif
> >  
> >  	if (to_json)
> >  		return bt_convert__perf2json(input_name, to_json, &opts);
> > -- 
> > 2.30.2
> > 

-- 

- Arnaldo
