Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 707DE47BB60
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 08:58:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235379AbhLUH6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 02:58:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33638 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230519AbhLUH6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 02:58:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640073516;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OOo7eDf8LRD7uXq7SyvCgBxZovsDTOk1ssZXNJOss1s=;
        b=PdG7HUBeaGCVDOzszHKILG/6G3PwoGK8cmyDNE4aUJ5XKDjwuofwmkWlnSiBmmN5CzbveB
        4uxxgB4lGk6UC93Xg3Plf+NLqYh8RrYKUqtluvkMN3jOJIMeBSVtTfH34UBG544bATkyjC
        9WtRgjMAn3N0GSelTHqknHldx7fhKZ0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-604-kAYlvinUPWyyXxnVgke1gg-1; Tue, 21 Dec 2021 02:58:34 -0500
X-MC-Unique: kAYlvinUPWyyXxnVgke1gg-1
Received: by mail-wm1-f69.google.com with SMTP id b75-20020a1c804e000000b0034569bde713so871511wmd.9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 23:58:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OOo7eDf8LRD7uXq7SyvCgBxZovsDTOk1ssZXNJOss1s=;
        b=UT+zeZEkLY9uQMxEMNf24ZnXXtWvL6/n1vNSo4ehSlQ/+7hb3f7Ybv8j5e7eZ/Mihz
         dpmRA14VYyjgBGYjVz504bkQiI4ME2wbRV7K92ies5DZoGh9zoiyOUYbFcMnesZBhvFV
         lQlAZOyxElU50PBsyoeYr6pSrs6rwdsAvOxBWtWFlTKrq7jjzsIZI9zev8CXQjk81SBd
         jtYIMkTkHpTW2FihIO6GcXSxvo1vylxWp3TWQHXSzCQW01040k+6LMrA4mAMCbdtAzSC
         6oT013XszXwHRBh8Qi2uwycDga5K1FBQrbBBHvr9ThgECe41GO1/bRs0DoZN4qJTfBOv
         3MUA==
X-Gm-Message-State: AOAM533Ji0kQMg7YQv/VSZ9NLFzvwiJTGoQ4/G2qfialkNizK07JFYBb
        ka9gj4ARSb3xCnJpjTa8y8Xq8axS9/u8BsLRCwzMfMB+BxUq5mvU3o1Km/y1G6dnaBHNJjm2dRb
        o5QWzfq7uzUpHu0/fACuW+73q
X-Received: by 2002:a7b:c008:: with SMTP id c8mr1634467wmb.55.1640073513530;
        Mon, 20 Dec 2021 23:58:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwzXiPWW7xkLY4uz3LGocDKMVBhtDG1YTHAbM3rG9zMGE/f1qAKNCTzgev1zvSJGIoI3sDj3w==
X-Received: by 2002:a7b:c008:: with SMTP id c8mr1634453wmb.55.1640073513294;
        Mon, 20 Dec 2021 23:58:33 -0800 (PST)
Received: from krava (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id p2sm8499739wrs.112.2021.12.20.23.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 23:58:33 -0800 (PST)
Date:   Tue, 21 Dec 2021 08:58:31 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, irogers@google.com, kan.liang@linux.intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf pmu: Fix event list for uncore PMUs
Message-ID: <YcGJJ2g+i5qWea7d@krava>
References: <1639670017-74918-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1639670017-74918-1-git-send-email-john.garry@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2021 at 11:53:37PM +0800, John Garry wrote:
> Commit 0e0ae8742207 ("perf list: Display hybrid PMU events with cpu type")
> changed the list for uncore PMUs, such that duplicate aliases are now
> listed per PMU (which they should not be), like:
> 
> ./perf list
> ...
> unc_cbo_cache_lookup.any_es
> [Unit: uncore_cbox L3 Lookup any request that access cache and found
> line in E or S-state]
> unc_cbo_cache_lookup.any_es
> [Unit: uncore_cbox L3 Lookup any request that access cache and found
> line in E or S-state]
> unc_cbo_cache_lookup.any_i
> [Unit: uncore_cbox L3 Lookup any request that access cache and found
> line in I-state]
> unc_cbo_cache_lookup.any_i
> [Unit: uncore_cbox L3 Lookup any request that access cache and found
> line in I-state]
> ...
> 
> Notice how the events are listed twice.
> 
> The named commit changed how we remove duplicate events, in that events
> for different PMUs are not treated as duplicates. I suppose this is to
> handle how "Each hybrid pmu event has been assigned with a pmu name".
> 
> Fix uncore PMU alias list by also checking if events with PMU name are not
> cpu PMUs.
> 
> Fixes: 0e0ae8742207 ("perf list: Display hybrid PMU events with cpu type")
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
> It would be helpful if someone with some of these hybrid CPU systems could
> test this change, thanks!
> 
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 6ae58406f4fc..392f6a36418b 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -1659,6 +1659,24 @@ bool is_pmu_core(const char *name)
>  	return !strcmp(name, "cpu") || is_arm_pmu_core(name);
>  }
>  
> +static bool pmu_alias_is_duplicate(struct sevent *alias_a,
> +				   struct sevent *alias_b)
> +{
> +	/* Different names -> never duplicates */
> +	if (strcmp(alias_a->name, alias_b->name))
> +		return false;
> +	if (!alias_a->pmu)
> +		return true;
> +	if (!alias_b->pmu)
> +		return true;

nit could be:

	if (!alias_a->pmu || !alias_b->pmu)
		return true;

would be great to have more comments explaining the check

thanks,
jirka

> +	if (!strcmp(alias_a->pmu, alias_b->pmu))
> +		return true;
> +	/* uncore PMUs */
> +	if (!alias_a->is_cpu && !alias_b->is_cpu)
> +		return true;
> +	return false;
> +}
> +
>  void print_pmu_events(const char *event_glob, bool name_only, bool quiet_flag,
>  			bool long_desc, bool details_flag, bool deprecated,
>  			const char *pmu_name)
> @@ -1744,12 +1762,8 @@ void print_pmu_events(const char *event_glob, bool name_only, bool quiet_flag,
>  	qsort(aliases, len, sizeof(struct sevent), cmp_sevent);
>  	for (j = 0; j < len; j++) {
>  		/* Skip duplicates */
> -		if (j > 0 && !strcmp(aliases[j].name, aliases[j - 1].name)) {
> -			if (!aliases[j].pmu || !aliases[j - 1].pmu ||
> -			    !strcmp(aliases[j].pmu, aliases[j - 1].pmu)) {
> -				continue;
> -			}
> -		}
> +		if (j > 0 && pmu_alias_is_duplicate(&aliases[j], &aliases[j - 1]))
> +			continue;
>  
>  		if (name_only) {
>  			printf("%s ", aliases[j].name);
> -- 
> 2.26.2
> 

