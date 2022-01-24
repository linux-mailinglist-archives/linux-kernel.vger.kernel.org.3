Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 695CC499EA7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 00:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1836923AbiAXWlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 17:41:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1457507AbiAXVlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 16:41:45 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE1B8C07E32E;
        Mon, 24 Jan 2022 12:29:14 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id s5so24675107ejx.2;
        Mon, 24 Jan 2022 12:29:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9I3YHstC6+idIYnPGdM7ftHMXhOmWb2w8X2hO2PCQA4=;
        b=aebn4RQTSizEoCO5tYOY0wfuCNx5Gr5k+YJCuBu86z1ZV0Pk6uqjr2k8aT33tbFO/t
         gPMROzf+a5Q3W0YKigShLsod3A5qMAeV7Cj9BnLNvuTsottjauQ5i4r/kmkQ2KNVpGEW
         AE9w/LCS0VM2JcnSr9LkZVITT3YktXAHX8rJJefKLteOtnUyurApAMaEW/FG8bWJb7E0
         MEfiPPuAvjEYaaq0xXeM40LoKiC/6QzDnq0Dg33XoL5XOg2pc7QuNtGsEo67DmmswKv/
         G2ykziTn7+oG/I+KNA+AunoT8Sil2CxeR60ucfjaYRyxt9E+z94EqPEMOI2KqXDNFHNg
         YX/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9I3YHstC6+idIYnPGdM7ftHMXhOmWb2w8X2hO2PCQA4=;
        b=taG5oesfw6SB73YgNe261E9EytAJSb6Za9umbbOirIXOzCNVk2qWDS+hh2yXwda4FT
         /RDFb8jLNij0InZx0VeT01xWJ9xb362elPPRPOxJZQ7Sf3cgBVM0QDWdNe3+1WK5DAMR
         cPRo5qm0jfq2mnNj5p86k8WQRV2BPsSITD9zLsjhrJK5BI3Vugfj2tiZ9uGpSw2EpYn0
         pZwQRXlrWCDog3qUbYLj91DhlPkzTTyRUswiZ08LC/tTHWGE3soI2Jkt115ohMIYohm5
         FMq/To1AOAq5vlv++9EKMviJew0xdCZLk3HdrkPama731isHIzoVMb4KnGJWOzn8huKV
         XRXg==
X-Gm-Message-State: AOAM533poaXbpV024+R4R9K7s43Xm8Y2gJVNAMlLyDkaZNl0FyEgyTqO
        rhlI6in0u3WE1FcJo6bwQXg=
X-Google-Smtp-Source: ABdhPJwa5kh9iwPNoKVMC1LR954fiigN9v+L/woUMk894ZYA/f8Ie+QDxOQ99l+LpLpETRV/zOU20Q==
X-Received: by 2002:a17:906:6a17:: with SMTP id qw23mr3177512ejc.620.1643056153260;
        Mon, 24 Jan 2022 12:29:13 -0800 (PST)
Received: from hamza-OptiPlex-7040 ([39.48.137.139])
        by smtp.gmail.com with ESMTPSA id w25sm7066709edv.68.2022.01.24.12.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 12:29:12 -0800 (PST)
Date:   Tue, 25 Jan 2022 01:29:07 +0500
From:   Ameer Hamza <amhamza.mgc@gmail.com>
To:     James Clark <james.clark@arm.com>
Cc:     German Gomez <german.gomez@arm.com>, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, rickyman7@gmail.com,
        alexey.v.bayduraev@linux.intel.com, adrian.hunter@intel.com,
        leo.yan@linaro.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org
Subject: Re: [PATCH] perf session: check for null pointer before derefernce
Message-ID: <20220124202907.GA5741@hamza-OptiPlex-7040>
References: <20220124150001.93145-1-amhamza.mgc@gmail.com>
 <7c068167-e8bb-74f3-97d9-dd0c5858ee19@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c068167-e8bb-74f3-97d9-dd0c5858ee19@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022 at 03:30:17PM +0000, James Clark wrote:
> 
> 
> On 24/01/2022 15:00, Ameer Hamza wrote:
> > Move null pointer check before dereferncing the variable
> > 
> > Addresses-Coverity: 1497622 ("Derereference before null check")
> > 
> > Signed-off-by: Ameer Hamza <amhamza.mgc@gmail.com>
> > ---
> >  tools/perf/util/session.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> > index f19348dddd55..e1014ab62c10 100644
> > --- a/tools/perf/util/session.c
> > +++ b/tools/perf/util/session.c
> > @@ -1503,11 +1503,11 @@ static int machines__deliver_event(struct machines *machines,
> >  			++evlist->stats.nr_unknown_id;
> >  			return 0;
> >  		}
> > -		dump_sample(evsel, event, sample, perf_env__arch(machine->env));
> >  		if (machine == NULL) {
> >  			++evlist->stats.nr_unprocessable_samples;
> >  			return 0;
> >  		}
> > +		dump_sample(evsel, event, sample, perf_env__arch(machine->env));
> >  		return evlist__deliver_sample(evlist, tool, event, sample, evsel, machine);
> >  	case PERF_RECORD_MMAP:
> >  		return tool->mmap(tool, event, sample, machine);
> > 
> 
> Hi Ameer,
> 
> This mistake was made recently, but I don't think your change is the desired behavior.
> 
> It should be possible to dump stuff if machine is null. null or an empty string
> should be passed to dump_sample(). It looks like some of the printfs still attempt to
> show something in this case, although I didn't check them all.

Hi James,

Thank you for your response. I understand your point.

Do you think following changes would be ok?

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index f19348dddd55..210eeee3dd70 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1503,11 +1503,12 @@ static int machines__deliver_event(struct machines *machines,
                        ++evlist->stats.nr_unknown_id;
                        return 0;
                }
-               dump_sample(evsel, event, sample, perf_env__arch(machine->env));
                if (machine == NULL) {
                        ++evlist->stats.nr_unprocessable_samples;
+                       dump_sample(evsel, event, sample, perf_env__arch(NULL));
                        return 0;
                }
+               dump_sample(evsel, event, sample, perf_env__arch(machine->env));
                return evlist__deliver_sample(evlist, tool, event, sample, evsel, machine);
        case PERF_RECORD_MMAP:
                return tool->mmap(tool, event, sample, machine);

Thanks,
Hamza
