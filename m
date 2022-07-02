Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9101D564130
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 17:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232297AbiGBPsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 11:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230429AbiGBPsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 11:48:10 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19CFAE089;
        Sat,  2 Jul 2022 08:48:09 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id l40-20020a05600c1d2800b003a18adff308so3095275wms.5;
        Sat, 02 Jul 2022 08:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MN4RpQIvLMBMDIcmpJI83g6KkG/xWmL6+1k6dSOoWTE=;
        b=FEgh7+XYe8XJdNY8WBTHm4GVHOMCX55J5y2/8Lcamn5yXNqSAf9wXW08TjuXRmwpHa
         GC+yRSIUXTPrS2i1BhK5U9Qn6Kp0DRzXPWA9sX8pZezcw5n5U37gSgzqfR4JpsSt7KXz
         dffdNHgadJRyeHXWd4kejgabYdyf3i4tEuvMa+EEuGAiMUrRcwgeP66KXpSFlLfBG8G2
         K5Y9pr0aSBqoibx9Lwz7ROknwvfliaSaNYbZyTEwKJgt4zvTXKJLwxA/iO4dwVmfI6lY
         LDTKtbu9RMkloTVHAZuizeRFjdNcKJZ0sd9ehlg4+pZ9IEnrVWgSXluTnUEq8RRQdUj4
         eOrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MN4RpQIvLMBMDIcmpJI83g6KkG/xWmL6+1k6dSOoWTE=;
        b=GIASXZh9rIzeXOPyYWUCG27ervHN8eLuEngrkWwDOCWsjLmwDr0vUBYQteOh0nzlMi
         r9V1uc34rvjAAzJom83lndnvvw3R9FyNKgrMzJjsZvpDW9M4XTTONjrlVRLNpEEGCtJG
         FHne+/6+QRHzO+9UzQcdyzyU510N/1eLoCc4BhiXk/b6H6k4ntyDnjgPu/RVJfhChlcm
         oZ4UKk4m/mfEFZNG+FTK+hY8yGau9avwucWD2CJVJdncqq8+H3VcZTRLvOZdyME/YKy/
         //Gjyjw489xigEE6xgc3DB7Ggd/yFXreqS0eOC579i0G2U+ucS+Bnzf7NPnomei5wimh
         ho8A==
X-Gm-Message-State: AJIora/84vVPY9hIeV1/abxNYraKZgn7SaFu6lMWzCektnHoR+39XYcN
        pfyHR2I//BGXRQX7gaez2NE=
X-Google-Smtp-Source: AGRyM1tig9SfHZp22QZHwO9gHcQ2IVkIo3dujsi7M47/qrR3nPkOtNkMFERFpbXx052Lp1i5rh5hxA==
X-Received: by 2002:a7b:c354:0:b0:39c:6753:21f8 with SMTP id l20-20020a7bc354000000b0039c675321f8mr22546570wmj.113.1656776887469;
        Sat, 02 Jul 2022 08:48:07 -0700 (PDT)
Received: from krava ([151.70.14.154])
        by smtp.gmail.com with ESMTPSA id i1-20020adffc01000000b0021b5861eaf7sm25880627wrr.3.2022.07.02.08.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Jul 2022 08:48:06 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Sat, 2 Jul 2022 17:48:03 +0200
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>
Cc:     Dominique Martinet <asmadeus@codewreck.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf parse: Allow names to start with digits
Message-ID: <YsBosxs9TVB0aLrf@krava>
References: <20220612061508.1449636-1-asmadeus@codewreck.org>
 <YsAUqwzeO8U6cIJA@codewreck.org>
 <YsA4+A7TSjzUKDWK@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YsA4+A7TSjzUKDWK@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 02, 2022 at 09:24:24AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Sat, Jul 02, 2022 at 06:49:31PM +0900, Dominique Martinet escreveu:
> > Hello,
> > 
> > just making sure my mail didn't get lost -- would anyone have time to
> > look at this?
> > 
> > I don't mind if it's slow or another solution is taken, I'd just like to
> > be able to use 9p probes with perf eventually :)
> 
> Jiri, seems ok, can you please review?

ah right, sorry, I remember looking on that before,
but forgot to respond

> 
> Thanks,
> 
> - Arnaldo
>  
> > Thanks!
> > 
> > Dominique Martinet wrote on Sun, Jun 12, 2022 at 03:15:08PM +0900:
> > > Tracepoints can start with digits, although we don't have many of these:
> > > 
> > > $ rg -g '*.h' '\bTRACE_EVENT\([0-9]'
> > > net/mac802154/trace.h
> > > 53:TRACE_EVENT(802154_drv_return_int,
> > > ...
> > > 
> > > net/ieee802154/trace.h
> > > 66:TRACE_EVENT(802154_rdev_add_virtual_intf,
> > > ...
> > > 
> > > include/trace/events/9p.h
> > > 124:TRACE_EVENT(9p_client_req,
> > > ...
> > > 
> > > Just allow names to start with digits too so e.g. perf probe -e '9p:*'
> > > works
> > > 
> > > Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
> > > ---
> > >  tools/perf/util/parse-events.l | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
> > > index 5b6e4b5249cf..4133d6950d29 100644
> > > --- a/tools/perf/util/parse-events.l
> > > +++ b/tools/perf/util/parse-events.l
> > > @@ -211,7 +211,7 @@ bpf_source	[^,{}]+\.c[a-zA-Z0-9._]*
> > >  num_dec		[0-9]+
> > >  num_hex		0x[a-fA-F0-9]+
> > >  num_raw_hex	[a-fA-F0-9]+
> > > -name		[a-zA-Z_*?\[\]][a-zA-Z0-9_*?.\[\]!]*
> > > +name		[a-zA-Z0-9_*?\[\]][a-zA-Z0-9_*?.\[\]!]*

I thought it'd clash with events like cpu/event=3/,
but lexer check numbers first, so we're fine there

it smells like it could break some events, but I couldn't
find any case of that

could you please at least add tests to tests/parse-events.c
for such case?

thanks,
jirka

> > >  name_tag	[\'][a-zA-Z_*?\[\]][a-zA-Z0-9_*?\-,\.\[\]:=]*[\']
> > >  name_minus	[a-zA-Z_*?][a-zA-Z0-9\-_*?.:]*
> > >  drv_cfg_term	[a-zA-Z0-9_\.]+(=[a-zA-Z0-9_*?\.:]+)?
> 
> -- 
> 
> - Arnaldo
