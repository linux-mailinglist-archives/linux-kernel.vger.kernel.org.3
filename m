Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE6AF58ECCC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 15:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232236AbiHJNKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 09:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231687AbiHJNKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 09:10:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBBC4BEC;
        Wed, 10 Aug 2022 06:10:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 262176144B;
        Wed, 10 Aug 2022 13:10:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67138C433D6;
        Wed, 10 Aug 2022 13:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660137029;
        bh=sXSgjj5+4JsQMk/9Qox6+ZAQuvnEJ/J3+NWYzjJbhPE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ndzHzvgqRms/h4alSGbXbFmh+oce7SiBJ1vt6g2QWH1+sdnF7XALSFmJJE42VKRvx
         N/+HoxuaZosX9/dOFAD9C9bTOx5GePb8PDejMMGkOfWrGFu4o7yOAmOoe5SR0uGw4z
         MlnxKCbI1TCW32A5o0yb6QqlBkfyKHFG4Z5ey1olHRV53MslQojlf0mGJg183rjakm
         XAIetpwJvH2eLw1fJOtRjsa89n6jIXwrfxoV1M82Cbm+Zfx16SoSHWI2kVROBRwKwF
         tWqR4tdYaQenHKk1oKgCovH67wX3n1kSH7cGAsiqJwtBH3tF0UHpbJL2qARITQkDOH
         jKTxxEqleyWEw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0877F4035A; Wed, 10 Aug 2022 10:10:27 -0300 (-03)
Date:   Wed, 10 Aug 2022 10:10:26 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2] perf probe: Fix an error handling path in
 'parse_perf_probe_command()'
Message-ID: <YvOuQnSdT31wSPZ8@kernel.org>
References: <b71bcb01fa0c7b9778647235c3ab490f699ba278.1659797452.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b71bcb01fa0c7b9778647235c3ab490f699ba278.1659797452.git.christophe.jaillet@wanadoo.fr>
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

Em Sat, Aug 06, 2022 at 04:51:26PM +0200, Christophe JAILLET escreveu:
> If a memory allocation fail, we should branch to the error handling path in
> order to free some resources allocated a few lines above.
> 
> Fixes: 15354d546986 ("perf probe: Generate event name with line number")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>


Thanks, applied.

- Arnaldo


> ---
> Change in v2:
>  - Synch with latest -next
>  - Add A-by tag (see link below, it was old!)
> 
> v1:
>  https://lore.kernel.org/all/20200315201259.29190-1-christophe.jaillet@wanadoo.fr/
> ---
>  tools/perf/util/probe-event.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
> index 67c12d5303e7..785246ff4179 100644
> --- a/tools/perf/util/probe-event.c
> +++ b/tools/perf/util/probe-event.c
> @@ -1775,8 +1775,10 @@ int parse_perf_probe_command(const char *cmd, struct perf_probe_event *pev)
>  	if (!pev->event && pev->point.function && pev->point.line
>  			&& !pev->point.lazy_line && !pev->point.offset) {
>  		if (asprintf(&pev->event, "%s_L%d", pev->point.function,
> -			pev->point.line) < 0)
> -			return -ENOMEM;
> +			pev->point.line) < 0) {
> +			ret = -ENOMEM;
> +			goto out;
> +		}
>  	}
>  
>  	/* Copy arguments and ensure return probe has no C argument */
> -- 
> 2.34.1

-- 

- Arnaldo
