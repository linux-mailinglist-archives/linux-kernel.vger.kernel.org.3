Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6C7B4E7D02
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 01:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbiCYThb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 15:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230508AbiCYThG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 15:37:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E5F262D6D
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 12:22:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C6AB161C27
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 18:27:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 096C2C2BBE4;
        Fri, 25 Mar 2022 18:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648232874;
        bh=uEuqD9UvUKQGZ5mLxpFhYM+SebgYEYrddzKoHyc3KGo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Tj2efp5+JqoJjev0O8XlYBWxGQ+eXsQBnPDtW5+oHbAnW3LPFA1UdZxK/wwszxFdJ
         8F7S/vq1DHxNLHP0i/boJCxE3ANUBP+AYlNXr4tH5TpXa2sESIvQ5Y13C1MwlGdVkm
         65lLE2BTXF6qqc/p2fu/UsOuT/anhKL7+2yD9ZUz+LH4uiWfU68fUiG1uZJ+TqP7PI
         8CGwZtG9+T+E/j/pOzFOCDZo7Tg+B3SjmjgaccfSMoAHXXojecASbl4691YLe4scB5
         RgyfwGHw9rji/U93GHFVYgVLYNKpDhGme7TkR3P0Zcj03SHadVjB/0r2YsyYZY3Y2d
         3Jb6/KJYQgZrw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 28F9940407; Fri, 25 Mar 2022 15:27:52 -0300 (-03)
Date:   Fri, 25 Mar 2022 15:27:52 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Stephane Eranian <eranian@google.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        kim.phillips@amd.com, acme@redhat.com, jolsa@redhat.com,
        songliubraving@fb.com, rafael@kernel.org, ravi.bangoria@amd.com,
        sandipan.das@amd.com
Subject: Re: [PATCH v7 10/13] perf tools: fix NULL point in evsel__env()
Message-ID: <Yj4JqAimNd1INLjB@kernel.org>
References: <20220322221517.2510440-1-eranian@google.com>
 <20220322221517.2510440-11-eranian@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220322221517.2510440-11-eranian@google.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Mar 22, 2022 at 03:15:14PM -0700, Stephane Eranian escreveu:
> evsel_env() cannot return NULL. In case evsel->evlist->env is NULL default
> to perf_env. Fixes crashes in evsel__open_strerror()
> 
> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
> Reviewed-by: Stephane Eranian <eranian@google.com>

I have this already in from a patch by Kim Phillips.

- Arnaldo

> ---
>  tools/perf/util/evsel.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 22d3267ce294..14b0e7ffa2c7 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -2965,7 +2965,7 @@ int evsel__open_strerror(struct evsel *evsel, struct target *target,
>  
>  struct perf_env *evsel__env(struct evsel *evsel)
>  {
> -	if (evsel && evsel->evlist)
> +	if (evsel && evsel->evlist && evsel->evlist->env)
>  		return evsel->evlist->env;
>  	return &perf_env;
>  }
> -- 
> 2.35.1.894.gb6a874cedc-goog

-- 

- Arnaldo
