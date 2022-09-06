Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBF705AE8EA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 14:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240309AbiIFM7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 08:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240091AbiIFM7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 08:59:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D512DFC
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 05:59:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3EC51614F4
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 12:59:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80D46C433D7;
        Tue,  6 Sep 2022 12:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662469141;
        bh=z9J4tv3orBGgkg7LciZgGFAK6VnvE7hTjODFpgPBol8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VHWJjdPovgS0HHjM8zP0C+PPUmqQsfcD1iyilRXneTLi9c9pmPtEkfxSwThsHSCly
         uFPqA5eUfWryyT3D99GngzsBzcNRycMb2zlT1H713RisCWnPLUeCT4TSMtuY7cIu4N
         9rsZgcr7A1Qv/86cn7Mu/OdqNt/vrG7l3OTFrSR6IQwMG8ewhqUYczdWBy5dyXSZRr
         hkixklDIVcD07L3ZmIhYj5a4/8MNV9eJT0BMH3RDdPko/ltOIezZJ+qAnCoz0pg8rY
         JvBoykuD9lZITAlKjd/lSgZbioy/3n/xn7RFuGT5vpISyRAKSd9YRdWB2E77+Yu8OG
         gvlYoY/1Q1nOQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C3195404A1; Tue,  6 Sep 2022 09:58:59 -0300 (-03)
Date:   Tue, 6 Sep 2022 09:58:59 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] perf dlfilter: dlfilter-show-cycles: Fix types for
 print format
Message-ID: <YxdEE331EyEBEGr4@kernel.org>
References: <20220905074735.4513-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220905074735.4513-1-adrian.hunter@intel.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Sep 05, 2022 at 10:47:35AM +0300, Adrian Hunter escreveu:
> Avoid compiler warning about format %llu that expects long long unsigned
> int but argument has type __u64.
> 
> Fixes: c3afd6e50fce ("perf dlfilter: Add dlfilter-show-cycles")
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
> 
> 
> Changes in V2:
> 
> 	Add fixes tag

Thanks, applied.

- Arnaldo

 
> 
>  tools/perf/dlfilters/dlfilter-show-cycles.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/dlfilters/dlfilter-show-cycles.c b/tools/perf/dlfilters/dlfilter-show-cycles.c
> index 9eccc97bff82..6d47298ebe9f 100644
> --- a/tools/perf/dlfilters/dlfilter-show-cycles.c
> +++ b/tools/perf/dlfilters/dlfilter-show-cycles.c
> @@ -98,9 +98,9 @@ int filter_event_early(void *data, const struct perf_dlfilter_sample *sample, vo
>  static void print_vals(__u64 cycles, __u64 delta)
>  {
>  	if (delta)
> -		printf("%10llu %10llu ", cycles, delta);
> +		printf("%10llu %10llu ", (unsigned long long)cycles, (unsigned long long)delta);
>  	else
> -		printf("%10llu %10s ", cycles, "");
> +		printf("%10llu %10s ", (unsigned long long)cycles, "");
>  }
>  
>  int filter_event(void *data, const struct perf_dlfilter_sample *sample, void *ctx)
> -- 
> 2.25.1

-- 

- Arnaldo
