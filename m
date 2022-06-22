Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 064AA555158
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 18:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359367AbiFVQai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 12:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359088AbiFVQag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 12:30:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B039A369FB
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 09:30:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6F9EDB8204A
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 16:30:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2222C3411B;
        Wed, 22 Jun 2022 16:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655915433;
        bh=542m7t8Yiznwwy2EoaktYiSEKKitBnHVc1Sn9F+Pulg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SowLFcrlt4Gm/uLC3J1tSKlZdSvV9x4Sc/86A+eCBC7rE5mgovAA/819dutXhM2vD
         uTNRCRdU+lBtQEFtwIodzusxm6FcB/R8x3ErYu/C3xaZAffrXaC7gusvPQBDwphY0v
         VIkJkAy8e8h8JsJ+LHQmL8kvEJ2+sy4jsZ4j/O0GR3v6IuelQp0r+WsjHgOT0sy4FW
         ratvm8rUnEi+RnygSkItopeRzu7AEfsKmZygzxtdwIPitYmifJ4qrZadPTKlOAd6Tx
         19Ehj3Cc1HscP3iphM+5MKsvjLWfp0cd0Uo/bHc1nv87LxAbaMuh4tfz8GreS9q3Jw
         e9l0vq21vYTCg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 543DF4096F; Wed, 22 Jun 2022 13:30:30 -0300 (-03)
Date:   Wed, 22 Jun 2022 13:30:30 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     "Shawn M. Chapla" <schapla@codeweavers.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH] perf data: Prefer sampled CPU when exporting JSON
Message-ID: <YrNDph39sfEi4bOM@kernel.org>
References: <20220526201506.2028281-1-schapla@codeweavers.com>
 <YrMqY3KDWowLw3Ii@cw.chapla.email>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YrMqY3KDWowLw3Ii@cw.chapla.email>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Jun 22, 2022 at 10:42:43AM -0400, Shawn M. Chapla escreveu:
> On Thu, May 26, 2022 at 04:14:47PM -0400, Shawn M. Chapla wrote:
> > When CPU has been explicitly sampled (via --sample-cpu), prefer this
> > sampled value over the thread CPU value when exporting to JSON.

> > Signed-off-by: Shawn M. Chapla <schapla@codeweavers.com>
> > ---
> >  tools/perf/util/data-convert-json.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/perf/util/data-convert-json.c b/tools/perf/util/data-convert-json.c
> > index f1ab6edba446..613d6ae82663 100644
> > --- a/tools/perf/util/data-convert-json.c
> > +++ b/tools/perf/util/data-convert-json.c
> > @@ -149,6 +149,7 @@ static int process_sample_event(struct perf_tool *tool,
> >  	struct convert_json *c = container_of(tool, struct convert_json, tool);
> >  	FILE *out = c->out;
> >  	struct addr_location al, tal;
> > +	u64 sample_type = __evlist__combined_sample_type(evsel->evlist);
> >  	u8 cpumode = PERF_RECORD_MISC_USER;
> >  
> >  	if (machine__resolve(machine, &al, sample) < 0) {
> > @@ -168,7 +169,9 @@ static int process_sample_event(struct perf_tool *tool,
> >  	output_json_key_format(out, true, 3, "pid", "%i", al.thread->pid_);
> >  	output_json_key_format(out, true, 3, "tid", "%i", al.thread->tid);
> >  
> > -	if (al.thread->cpu >= 0)
> > +	if ((sample_type & PERF_SAMPLE_CPU))
> > +		output_json_key_format(out, true, 3, "cpu", "%i", sample->cpu);
> > +	else if (al.thread->cpu >= 0)
> >  		output_json_key_format(out, true, 3, "cpu", "%i", al.thread->cpu);
> >  
> >  	output_json_key_string(out, true, 3, "comm", thread__comm_str(al.thread));
> > -- 
> > 2.36.1
> > 
> 
> Just checking in to see if anyone has had a chance to take a look at
> this yet.

Seems sensible, applying to perf/core for 5.20.

- Arnaldo
