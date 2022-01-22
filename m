Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00737496DFC
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 21:28:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbiAVU2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 15:28:40 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:38910 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbiAVU2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 15:28:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CBB13B80947;
        Sat, 22 Jan 2022 20:28:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6104AC004E1;
        Sat, 22 Jan 2022 20:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642883316;
        bh=xmDMeNg/NONl8eeLAcu1cyqBPjJkOu5tR9cVzTOe3pg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G5Uxj6quF9F6/UX1Ap20bpLQLByoYvWXaqOMSi7l2x1H1pF4zaZwgcjceEG3wMMhQ
         3OPd3U8buiEZPBd92erixUnyI1VwWetSMJRwI4kT9EkAK7JpLZL2rfkmHY5TefZU/f
         N/jbTFuxVVtMUc9oQv3A7An0IuEnMLaShztXpHP5rVelN9qZGupFIF3gvITL7RNd+y
         jDulDAHH+v9d/NBcFG/ls/2IkPq3GEEdYhBf9fAguoizRgeo08qDaaSH5JO+Mg90eX
         NJ5hBBRTDkUQkiqSrla9f0IbhFux43H7UAq7Kwg8oJ5gEDOmQIic96hlK2CGUKUUus
         5IqEr/NqpmPZg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 80F2540C99; Sat, 22 Jan 2022 17:26:34 -0300 (-03)
Date:   Sat, 22 Jan 2022 17:26:34 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     cgel.zte@gmail.com
Cc:     mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] tools/perf: remove redundant err variable
Message-ID: <Yexoer05bRAb9G/o@kernel.org>
References: <20220112080109.666800-1-chi.minghao@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220112080109.666800-1-chi.minghao@zte.com.cn>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Jan 12, 2022 at 08:01:09AM +0000, cgel.zte@gmail.com escreveu:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> Return value from perf_event__process_tracing_data() directly instead
> of taking this in another redundant variable.

Thanks, applied.

- Arnaldo

 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
> Signed-off-by: CGEL ZTE <cgel.zte@gmail.com>
> ---
>  tools/perf/builtin-inject.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> index 409b721666cb..fbf43a454cba 100644
> --- a/tools/perf/builtin-inject.c
> +++ b/tools/perf/builtin-inject.c
> @@ -535,12 +535,9 @@ static int perf_event__repipe_exit(struct perf_tool *tool,
>  static int perf_event__repipe_tracing_data(struct perf_session *session,
>  					   union perf_event *event)
>  {
> -	int err;
> -
>  	perf_event__repipe_synth(session->tool, event);
> -	err = perf_event__process_tracing_data(session, event);
>  
> -	return err;
> +	return perf_event__process_tracing_data(session, event);
>  }
>  
>  static int dso__read_build_id(struct dso *dso)
> -- 
> 2.25.1

-- 

- Arnaldo
