Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEA464C05D7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 01:19:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233024AbiBWATU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 19:19:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232818AbiBWATT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 19:19:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C433B4D610;
        Tue, 22 Feb 2022 16:18:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5F3A761260;
        Wed, 23 Feb 2022 00:18:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A27BFC340E8;
        Wed, 23 Feb 2022 00:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645575531;
        bh=NXaPAr7gqysLvEwXoD5p+AxNR61/szVonKZdFsJ2fSI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kLLcYCAgKrzMva/spRnrXevdY72OCm5QGpGVev+QDYQwjDwtoJNamqMiUrIyVn3dL
         2XkM64hpmar83i+U/m56IOxwIFYl7+RNvnZFLnBdUzt/TZGrGGcVOJwjb8uKXmAAs7
         eycp1USER8xiKjm9MXW8JAMVNITeXEF7tZi6inWLLxjBfQv2WyQAQW+UvlS2+0h5qL
         iwEvWRWKMDYQ+ybGN36rN37Aj2EcZo8SAFMhAMBa99vpbn09TQdd/IRn55xDNlgfHd
         Qk0W6chOY4lYswxm68BZ/149kqC1lGPiEOvms5NUslHajrpKAZeepKK/g23IKZdbHQ
         eL2l6WpcHHsNw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 87604400FE; Tue, 22 Feb 2022 21:18:49 -0300 (-03)
Date:   Tue, 22 Feb 2022 21:18:49 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     German Gomez <german.gomez@arm.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH] perf script: Fix error when printing 'weight' field
Message-ID: <YhV9aXx3VhXUkCcT@kernel.org>
References: <20220221171707.62960-1-german.gomez@arm.com>
 <YhPh5pHMGeP8Arx6@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YhPh5pHMGeP8Arx6@krava>
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

Em Mon, Feb 21, 2022 at 08:46:32PM +0100, Jiri Olsa escreveu:
> On Mon, Feb 21, 2022 at 05:17:06PM +0000, German Gomez wrote:
> > In SPE traces the 'weight' field can't be printed in perf-script because
> > the 'dummy:u' event doesn't have the WEIGHT attribute set.
> > 
> > Use evsel__do_check_stype(..) to check this field, as it's done with
> > other fields such as "phys_addr".
> > 
> > Before:
> > 
> > $ perf record -e arm_spe_0// -- sleep 1
> > $ perf script -F event,ip,weight
> > Samples for 'dummy:u' event do not have WEIGHT attribute set. Cannot print 'weight' field.
> > 
> > After:
> > 
> > $ perf script -F event,ip,weight
> >    l1d-access:               12 ffffaf629d4cb320
> >    tlb-access:               12 ffffaf629d4cb320
> >        memory:               12 ffffaf629d4cb320
> > 
> > Fixes: b0fde9c6e291 ("perf arm-spe: Add SPE total latency as PERF_SAMPLE_WEIGHT")
> > Signed-off-by: German Gomez <german.gomez@arm.com>
> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>

Thanks, applied to perf/urgent.

- Arnaldo

 
> thanks,
> jirka
> 
> > ---
> >  tools/perf/builtin-script.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> > index 9e032343f..6ce581067 100644
> > --- a/tools/perf/builtin-script.c
> > +++ b/tools/perf/builtin-script.c
> > @@ -463,7 +463,7 @@ static int evsel__check_attr(struct evsel *evsel, struct perf_session *session)
> >  		return -EINVAL;
> >  
> >  	if (PRINT_FIELD(WEIGHT) &&
> > -	    evsel__check_stype(evsel, PERF_SAMPLE_WEIGHT_TYPE, "WEIGHT", PERF_OUTPUT_WEIGHT))
> > +	    evsel__do_check_stype(evsel, PERF_SAMPLE_WEIGHT_TYPE, "WEIGHT", PERF_OUTPUT_WEIGHT, allow_user_set))
> >  		return -EINVAL;
> >  
> >  	if (PRINT_FIELD(SYM) &&
> > -- 
> > 2.25.1
> > 

-- 

- Arnaldo
