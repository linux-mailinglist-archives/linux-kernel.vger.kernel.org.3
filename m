Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2B6958ECBC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 15:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231771AbiHJNGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 09:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232580AbiHJNF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 09:05:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87EEE54662;
        Wed, 10 Aug 2022 06:05:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4C1E1B81C11;
        Wed, 10 Aug 2022 13:05:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5988C433D6;
        Wed, 10 Aug 2022 13:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660136754;
        bh=iL1pcQ1UCvjHw2tHMD8Xe73O/Xs5rV9iq6M/B8XsBGo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ol8YaxFX6N6Y1SQVrFWYtePyxKmUu8izcCF2xYRxj7xtVUqfUSYwWfCKMe9g+844p
         H7NQST4gtA4v4XqjExGcNYf0QXUbinJisvlFz6DaLWUjoeOHWScfOt2BvkcKBoi97p
         McHQWBzkPq+sh4Ou65zBzCNr6GLJH1tnqLngQE14H2r1SD1BPHprIS++yJ9KtYrW39
         8q/NH8fRdV99oiDFqXqu2JCHHIt88wTYZWPV7fG9T11tSe+w190yNa890scgI/OS0Z
         On7ByggJoODWxVVPqcrpXjRGRGvx/tKVb2+WavXd5UdXB8kiZuz2tCZ76yo4yAzYTu
         jenjPDt85sHQg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 57E2D4035A; Wed, 10 Aug 2022 10:05:49 -0300 (-03)
Date:   Wed, 10 Aug 2022 10:05:49 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Brian Robbins <brianrob@linux.microsoft.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf inject jit: Ignore memfd and anonymous mmap
 events if jitdump present
Message-ID: <YvOtLXXJ1O60N8Hg@kernel.org>
References: <20220805220645.95855-1-brianrob@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220805220645.95855-1-brianrob@linux.microsoft.com>
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

Em Fri, Aug 05, 2022 at 03:06:45PM -0700, Brian Robbins escreveu:
> Some processes store jitted code in memfd mappings to avoid having rwx
> mappings.  These processes map the code with a writeable mapping and a
> read-execute mapping.  They write the code using the writeable mapping
> and then unmap the writeable mapping.  All subsequent execution is
> through the read-execute mapping.
> 
> perf inject --jit ignores //anon* mappings for each process where a
> jitdump is present because it expects to inject mmap events for each
> jitted code range, and said jitted code ranges will overlap with the
> //anon* mappings.
> 
> Ignore /memfd: and [anon:* mappings so that jitted code contained in
> /memfd: and [anon:* mappings is treated the same way as jitted code
> contained in //anon* mappings.

Removed v1, applied this one.

- Arnaldo
 
> Signed-off-by: Brian Robbins <brianrob@linux.microsoft.com>
> ---
>  tools/perf/util/jitdump.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
> index a23255773c60..4e6632203704 100644
> --- a/tools/perf/util/jitdump.c
> +++ b/tools/perf/util/jitdump.c
> @@ -845,8 +845,13 @@ jit_process(struct perf_session *session,
>  	if (jit_detect(filename, pid, nsi)) {
>  		nsinfo__put(nsi);
>  
> -		// Strip //anon* mmaps if we processed a jitdump for this pid
> -		if (jit_has_pid(machine, pid) && (strncmp(filename, "//anon", 6) == 0))
> +		/*
> +		 * Strip //anon*, [anon:* and /memfd:* mmaps if we processed a jitdump for this pid
> +		 */
> +		if (jit_has_pid(machine, pid) &&
> +			((strncmp(filename, "//anon", 6) == 0) ||
> +			 (strncmp(filename, "[anon:", 6) == 0) ||
> +			 (strncmp(filename, "/memfd:", 7) == 0)))
>  			return 1;
>  
>  		return 0;
> -- 
> 2.25.1

-- 

- Arnaldo
