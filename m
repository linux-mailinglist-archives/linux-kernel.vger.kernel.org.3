Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEA304C5F95
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 23:51:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232131AbiB0WvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 17:51:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231910AbiB0WvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 17:51:19 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2709A5A168;
        Sun, 27 Feb 2022 14:50:42 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id i19so4709640wmq.5;
        Sun, 27 Feb 2022 14:50:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YDTIXGCC898E0pouJzNeVPLM6uvpOE0gFyvf7cP99FU=;
        b=bpBsD0oI7JOnXE8PUPG4htueqQ8IKUtr3xVJN64bWBbT+aJa27AgUoKNjQV8Pt6lEY
         ol5Ja6poxVO7o3kAoRVgumFrrAgrPymyo5PPSmcCv7P3A1GoeGSxG6R6Utuj7CdHAp5T
         5tJTK1AX43gKF32Rv9IE32zP9UJoEYMZH+iDdCbsV2Az6f0svYKlE56eAfdsL+om/ikE
         UhlxJbopIvez6aC0G3yQF3AWfCe5CaGlxcDWoJVO0Bz65yC/8f7zz+EXP1iBYYpFMZQE
         hgACdemFCFQGkJh6DXJfiAny9EtQqUdItvZgq2SeRNVruPk/g4/PI16bFsP70qlBMC7x
         Eydw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YDTIXGCC898E0pouJzNeVPLM6uvpOE0gFyvf7cP99FU=;
        b=xOyY9QO+1n/P1dAkbK9ZOyrPe2En9SWj5d9jwnNmC0xa8xNJ/ly34rsHXqgSSQ/Amv
         nlencjEtGxXKU1c+f+jOigml1rfxDXOK6CGAxK47BzhDr8u8iVsAyaPcsUN3p/neuHLa
         pSo5xQbe3H2N2JOcMKtKViitgAarMJlh5q5+zaEKfEnVJL9SWvpMXd+FkVLmj3ixqrpC
         Nts+8lX8i/PezVqweXafC4f6GMoaNu+E05WdZb7mCXYJGEueI5C8HSOx7a/mXs++8Cli
         a4DX48/8UnT0zIZX+ZeVxG8XiboXFQ7QpFjoRA4ZSMfsvfp3a3v9WpkRcLOu7Pv3SZqV
         kuKg==
X-Gm-Message-State: AOAM532udrL56YjctN03w83r5meERV38SladwA44G8RbifLzfOOJA56t
        5hSzxxAxdsJJjeZhR6fBeRo=
X-Google-Smtp-Source: ABdhPJyULYjuyLUDFVziM+kCX7h7AqzQZ0bdhT2xc+VX+1JFUYXsdeir/8Lcvsy5st20LuJLYQESaw==
X-Received: by 2002:a1c:a78b:0:b0:380:683a:d01c with SMTP id q133-20020a1ca78b000000b00380683ad01cmr11314660wme.8.1646002240599;
        Sun, 27 Feb 2022 14:50:40 -0800 (PST)
Received: from krava ([83.240.63.118])
        by smtp.gmail.com with ESMTPSA id e18-20020adfdbd2000000b001e4bbbe5b92sm9129652wrj.76.2022.02.27.14.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Feb 2022 14:50:40 -0800 (PST)
Date:   Sun, 27 Feb 2022 23:50:38 +0100
From:   Jiri Olsa <olsajiri@gmail.com>
To:     James Clark <james.clark@arm.com>
Cc:     acme@kernel.org, linux-perf-users@vger.kernel.org,
        coresight@lists.linaro.org, Denis Nikitin <denik@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] perf: Set build-id using build-id header on new mmap
 records
Message-ID: <YhwAPrOP/ky4HLfC@krava>
References: <20220224171955.862983-1-james.clark@arm.com>
 <20220224171955.862983-2-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220224171955.862983-2-james.clark@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2022 at 05:19:55PM +0000, James Clark wrote:
> MMAP records that occur after the build-id header is parsed do not have
> their build-id set even if the filename matches an entry from the
> header. Set the build-id on these dsos as long as the MMAP record
> doesn't have its own build-id set.
> 
> This fixes an issue with off target analysis where the local version of
> a dso is loaded rather than one from ~/.debug via a build-id.

nice catch :)

> 
> Reported-by: Denis Nikitin <denik@chromium.org>
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  tools/perf/util/dso.h    |  1 +
>  tools/perf/util/header.c |  1 +
>  tools/perf/util/map.c    | 16 ++++++++++++++--
>  3 files changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
> index 011da3924fc1..3a9fd4d389b5 100644
> --- a/tools/perf/util/dso.h
> +++ b/tools/perf/util/dso.h
> @@ -167,6 +167,7 @@ struct dso {
>  	enum dso_load_errno	load_errno;
>  	u8		 adjust_symbols:1;
>  	u8		 has_build_id:1;
> +	u8		 header_build_id:1;
>  	u8		 has_srcline:1;
>  	u8		 hit:1;
>  	u8		 annotate_warned:1;
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index 6da12e522edc..571d73d4f976 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -2200,6 +2200,7 @@ static int __event_process_build_id(struct perf_record_header_build_id *bev,
>  
>  		build_id__init(&bid, bev->data, size);
>  		dso__set_build_id(dso, &bid);
> +		dso->header_build_id = 1;
>  
>  		if (dso_space != DSO_SPACE__USER) {
>  			struct kmod_path m = { .name = NULL, };
> diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
> index 1803d3887afe..4ae91e491e23 100644
> --- a/tools/perf/util/map.c
> +++ b/tools/perf/util/map.c
> @@ -127,7 +127,7 @@ struct map *map__new(struct machine *machine, u64 start, u64 len,
>  
>  	if (map != NULL) {
>  		char newfilename[PATH_MAX];
> -		struct dso *dso;
> +		struct dso *dso, *header_bid_dso;
>  		int anon, no_dso, vdso, android;
>  
>  		android = is_android_lib(filename);
> @@ -185,7 +185,19 @@ struct map *map__new(struct machine *machine, u64 start, u64 len,
>  
>  		if (build_id__is_defined(bid))
>  			dso__set_build_id(dso, bid);
> -
> +		else {

nit please add { } to the if clause as well

> +			/*
> +			 * If the mmap event had no build ID, search for an existing dso from the
> +			 * build ID header by name. Otherwise only the dso loaded at the time of
> +			 * reading the header will have the build ID set and all future mmaps will
> +			 * have it missing.
> +			 */
> +			header_bid_dso = __dsos__find(&machine->dsos, filename, false);

is this 'perf top' safe? I think dso should be added in the
same thread, but please check and add comment why we don't
need locking in here

thanks,
jirka

> +			if (header_bid_dso && header_bid_dso->header_build_id) {
> +				dso__set_build_id(dso, &header_bid_dso->bid);
> +				dso->header_build_id = 1;
> +			}
> +		}
>  		dso__put(dso);
>  	}
>  	return map;
> -- 
> 2.28.0
> 
