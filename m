Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E607471397
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 12:26:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbhLKL0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 06:26:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbhLKL0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 06:26:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA680C061714;
        Sat, 11 Dec 2021 03:26:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 45D2FB80935;
        Sat, 11 Dec 2021 11:26:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E464AC004DD;
        Sat, 11 Dec 2021 11:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639221960;
        bh=PHU+6bwJbN3vxmPhHKk0TqqTJ4YRMYdtHRcfi13UnRk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aJtXOJ2unJiHbtj1GfKOgVvh20x6DQ6LA8xQt39M2qxUEof7hg29khlLh7cxVQTip
         8iyg8FSUIFu6SJzaVysHqyB3p1eJ/D4Q67I8uIv6VlLbEDmvAvNbzWimpFdeIuBg0F
         6RmbPuwF5dd2+mEQOIEGN2Uu5nGHIqQ430bK0BKYIAdmtmOnbFVVokudbwm/QJ/m0q
         aYtnEoWjil0+l8FBJyOpCOdhLopCnJAO3nZptUL5TryqTlQf570PPTGKq9aq9BXXnk
         VbBQJaa0xhsX8qHQI53dYOQJH5O1ZctKcgSdpkRmbqMtcA/K5BGxlOOIci86slQxyW
         vxyZ+hI3ky0dg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 57173405D8; Sat, 11 Dec 2021 08:25:57 -0300 (-03)
Date:   Sat, 11 Dec 2021 08:25:57 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>, Song Liu <song@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf tools: Fix NULL vs IS_ERR_OR_NULL() checking
Message-ID: <YbSKxcj7Ld+0JQ/F@kernel.org>
References: <20211211053856.19827-1-linmq006@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211211053856.19827-1-linmq006@gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Dec 11, 2021 at 05:38:53AM +0000, Miaoqian Lin escreveu:
> The function trace_event__tp_format_id may return ERR_PTR(-ENOMEM).
> Use IS_ERR_OR_NULL to check tp_format.

Thanks, applied.

- Arnaldo

 
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
>  tools/perf/util/python.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index 563a9ba8954f..7f782a31bda3 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
> @@ -461,7 +461,7 @@ get_tracepoint_field(struct pyrf_event *pevent, PyObject *attr_name)
>  		struct tep_event *tp_format;
>  
>  		tp_format = trace_event__tp_format_id(evsel->core.attr.config);
> -		if (!tp_format)
> +		if (IS_ERR_OR_NULL(tp_format))
>  			return NULL;
>  
>  		evsel->tp_format = tp_format;
> -- 
> 2.17.1

-- 

- Arnaldo
