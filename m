Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7088C48EBEE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 15:46:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241946AbiANOqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 09:46:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241943AbiANOp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 09:45:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68BC6C06173F;
        Fri, 14 Jan 2022 06:45:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 27866B82600;
        Fri, 14 Jan 2022 14:45:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2F07C36AE5;
        Fri, 14 Jan 2022 14:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642171554;
        bh=TQNaw/3dPJwNIlobkXQRC06IR5ojhEFC4skgtBahSXs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j+u88xKtaAMdmEYr9nnWJ/S7a6ttO+OXKtFGZf4ZjcllMltrBfDe6pL/OHUqcZIZY
         CRG80k63MbASxiqlrL6Khg174wOXdPbjR2jVXAYnFjCCTETYw8AAvDlDhqnYvdfphc
         tN7TjUOdx1VS33yq7QHk9lqcRkE4FuLHlHLrOM+M+YvZbd2Ldfa2ZU6jP+P+fYK8wN
         zW3eI6TxlzdSwAY/JCuMcOzRsZ9PHMKGIZH+FcbuBlVUB6m6EgCawRW4IOhD+nqcPa
         3T3pmIM9uo9vK7cQAmJGn0GPzFFjquSX+STlUS8iDFydCW9Rd/v2RmRCkeUn+UdM2Y
         eCnapuNfDWgIg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id CFDD440714; Fri, 14 Jan 2022 11:45:52 -0300 (-03)
Date:   Fri, 14 Jan 2022 11:45:52 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>,
        Ian Rogers <irogers@google.com>
Cc:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, ak@linux.intel.com, john.garry@huawei.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf util: Fix use after free in metric__new
Message-ID: <YeGMoG2pv2+7nQFj@kernel.org>
References: <20211208171113.22089-1-jose.exposito89@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211208171113.22089-1-jose.exposito89@gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Dec 08, 2021 at 06:11:13PM +0100, José Expósito escreveu:
> Addresses-Coverity-ID: 1494000
> Signed-off-by: José Expósito <jose.exposito89@gmail.com>

Sorry, overlooked this one, now processing.

You forgot to add:

Fixes: b85a4d61d3022608 ("perf metric: Allow modifiers on metrics")

Ian, I'm taking this one, obvious fix.

- Arnaldo

> ---
>  tools/perf/util/metricgroup.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> index fffe02aae3ed..4d2fed3aefd1 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -209,8 +209,8 @@ static struct metric *metric__new(const struct pmu_event *pe,
>  	m->metric_name = pe->metric_name;
>  	m->modifier = modifier ? strdup(modifier) : NULL;
>  	if (modifier && !m->modifier) {
> -		free(m);
>  		expr__ctx_free(m->pctx);
> +		free(m);
>  		return NULL;
>  	}
>  	m->metric_expr = pe->metric_expr;
> -- 
> 2.25.1

-- 

- Arnaldo
