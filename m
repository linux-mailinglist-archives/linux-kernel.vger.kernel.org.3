Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B222555161
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 18:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359721AbiFVQjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 12:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359574AbiFVQjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 12:39:17 -0400
Received: from mail.codeweavers.com (mail.codeweavers.com [50.203.203.244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F9F7369C0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 09:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=codeweavers.com; s=6377696661; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=dnWIYXrLBvscXxO/tfjq0vzMqbp5Cf42JxTMCSeW13c=; b=cjFCGLODDwuy9Ww/ravkoWbsq
        ED+2xNmdCb2VIaoIpgNaPxV0CFVLTAP245hzG1G1tpli5YR+k4HfzuwBzYgAKsMFC2XWNQK8QBoSR
        PPI50A/YShjZwS+02hT+0OyoKeCOOs5PoJv0zWgck05hRUYqCtB3exKX1HPPhI287w+J0=;
Received: from [10.69.141.126] (helo=localhost)
        by mail.codeweavers.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <schapla@codeweavers.com>)
        id 1o43Nq-00026d-0K; Wed, 22 Jun 2022 11:39:14 -0500
Date:   Wed, 22 Jun 2022 12:39:00 -0400
From:   "Shawn M. Chapla" <schapla@codeweavers.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH] perf data: Prefer sampled CPU when exporting JSON
Message-ID: <YrNFpHjzAM9lWFp3@cw.chapla.email>
References: <20220526201506.2028281-1-schapla@codeweavers.com>
 <YrMqY3KDWowLw3Ii@cw.chapla.email>
 <YrNDph39sfEi4bOM@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YrNDph39sfEi4bOM@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2022 at 01:30:30PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Wed, Jun 22, 2022 at 10:42:43AM -0400, Shawn M. Chapla escreveu:
> > On Thu, May 26, 2022 at 04:14:47PM -0400, Shawn M. Chapla wrote:
> > > When CPU has been explicitly sampled (via --sample-cpu), prefer this
> > > sampled value over the thread CPU value when exporting to JSON.
> 
> > > Signed-off-by: Shawn M. Chapla <schapla@codeweavers.com>
> > > ---
> > >  tools/perf/util/data-convert-json.c | 5 ++++-
> > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/tools/perf/util/data-convert-json.c b/tools/perf/util/data-convert-json.c
> > > index f1ab6edba446..613d6ae82663 100644
> > > --- a/tools/perf/util/data-convert-json.c
> > > +++ b/tools/perf/util/data-convert-json.c
> > > @@ -149,6 +149,7 @@ static int process_sample_event(struct perf_tool *tool,
> > >  	struct convert_json *c = container_of(tool, struct convert_json, tool);
> > >  	FILE *out = c->out;
> > >  	struct addr_location al, tal;
> > > +	u64 sample_type = __evlist__combined_sample_type(evsel->evlist);
> > >  	u8 cpumode = PERF_RECORD_MISC_USER;
> > >  
> > >  	if (machine__resolve(machine, &al, sample) < 0) {
> > > @@ -168,7 +169,9 @@ static int process_sample_event(struct perf_tool *tool,
> > >  	output_json_key_format(out, true, 3, "pid", "%i", al.thread->pid_);
> > >  	output_json_key_format(out, true, 3, "tid", "%i", al.thread->tid);
> > >  
> > > -	if (al.thread->cpu >= 0)
> > > +	if ((sample_type & PERF_SAMPLE_CPU))
> > > +		output_json_key_format(out, true, 3, "cpu", "%i", sample->cpu);
> > > +	else if (al.thread->cpu >= 0)
> > >  		output_json_key_format(out, true, 3, "cpu", "%i", al.thread->cpu);
> > >  
> > >  	output_json_key_string(out, true, 3, "comm", thread__comm_str(al.thread));
> > > -- 
> > > 2.36.1
> > > 
> > 
> > Just checking in to see if anyone has had a chance to take a look at
> > this yet.
> 
> Seems sensible, applying to perf/core for 5.20.
> 
> - Arnaldo

Thank you! I appreciate it.

Cheers,
Shawn
