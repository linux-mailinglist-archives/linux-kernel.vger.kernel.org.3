Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29AA24CBCD6
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 12:37:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232310AbiCCLhe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 06:37:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232252AbiCCLhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 06:37:32 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD8E68FBA;
        Thu,  3 Mar 2022 03:36:46 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id qa43so9935969ejc.12;
        Thu, 03 Mar 2022 03:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LjHGDTCZOcYLYAe7xmxFomMAUWHczw2l0y9qfi6T96M=;
        b=VhRuH7UzjjPiVUS7RYLsvKkOeRnjMnmCG4YPRZp5MKztpc0o2XEi5N1S9ZP2rUPckZ
         Fv077zWiNLNtMFxC/LZF76jGv3bs2ZTEICU1qJS3oXmlELYclXjgOXCZ+ZXUQIFjzqt3
         FnByicDXosWgbWcoTRDGuEDPnPBNLAy4tpOtaAbL8HN4u5Z0vIrgkcL9u/0zG0JE9Z6U
         SDj/rGMVjd7bWWZ0wMbXcavdtiErWoJgHmCJWZrDtwW/gKvm6NUUKZJX2Vac4S2vLbOW
         fRshkVe2+gqgFpc47iihPBJ4TSl08RXko08YOGRa3S/C+xF09FV2TpB9xK8TZphnCAm/
         +LWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LjHGDTCZOcYLYAe7xmxFomMAUWHczw2l0y9qfi6T96M=;
        b=Z2Ljr6H9QeT7wvQQ7mVebciIFpaoIc2dpvwJfuKPjvhLAKEEzEd8nhINRq/bU+D9oB
         mSTZzOzDmip/SfGzeMIM769ppgjcJW9EKekZA8DCCpjm3tQpSMEiEb2e7nwO3/HhScNl
         LUZD7S+vGaOr6nAaYNEVCgzDb1cwsSJmSUs6/5c9ta2jubMOrSydsid2NiEX9v12TAND
         xDI1hW5EuCCOjiihq3/NDuVea7DVbwGcF3GTTDMdekVpgHuqM+I2RnGMN7njGRAyP/46
         dH6Djl9uHCM6FXUAyoSW4bH7rnZVn5QMwy9KWDkrjMVPwD8IWlh8yMECm1xukzMTroHV
         v6HA==
X-Gm-Message-State: AOAM533Qc2HsK82RLy/JxlDkYyuWv/9LGPZi/P0uX0MP7u7eN7C53ZpP
        kjNmmV22d63StVhja+NkwpQ=
X-Google-Smtp-Source: ABdhPJwEuXnMH1YmBnzdPilbCrAHHv6IX9lUr0Cg55ZXNrUJmJLZhJjBuAt+590D0EEdlBugMI0aMA==
X-Received: by 2002:a17:906:4752:b0:6ce:61d9:b632 with SMTP id j18-20020a170906475200b006ce61d9b632mr27339254ejs.694.1646307404475;
        Thu, 03 Mar 2022 03:36:44 -0800 (PST)
Received: from krava ([193.85.244.190])
        by smtp.gmail.com with ESMTPSA id a21-20020a170906275500b006d10c07fabesm605492ejd.201.2022.03.03.03.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 03:36:44 -0800 (PST)
Date:   Thu, 3 Mar 2022 12:36:41 +0100
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
Message-ID: <YiCoSbYHDF8jesxp@krava>
References: <20220224171955.862983-1-james.clark@arm.com>
 <20220224171955.862983-2-james.clark@arm.com>
 <YhwAPrOP/ky4HLfC@krava>
 <3dc14ad9-8ce1-a2e3-3bab-953b79af82be@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3dc14ad9-8ce1-a2e3-3bab-953b79af82be@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2022 at 04:20:00PM +0000, James Clark wrote:
> 
> 
> On 27/02/2022 22:50, Jiri Olsa wrote:
> > On Thu, Feb 24, 2022 at 05:19:55PM +0000, James Clark wrote:
> >> MMAP records that occur after the build-id header is parsed do not have
> >> their build-id set even if the filename matches an entry from the
> >> header. Set the build-id on these dsos as long as the MMAP record
> >> doesn't have its own build-id set.
> >>
> >> This fixes an issue with off target analysis where the local version of
> >> a dso is loaded rather than one from ~/.debug via a build-id.
> > 
> > nice catch :)
> > 
> >>
> >> Reported-by: Denis Nikitin <denik@chromium.org>
> >> Signed-off-by: James Clark <james.clark@arm.com>
> >> ---
> >>  tools/perf/util/dso.h    |  1 +
> >>  tools/perf/util/header.c |  1 +
> >>  tools/perf/util/map.c    | 16 ++++++++++++++--
> >>  3 files changed, 16 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
> >> index 011da3924fc1..3a9fd4d389b5 100644
> >> --- a/tools/perf/util/dso.h
> >> +++ b/tools/perf/util/dso.h
> >> @@ -167,6 +167,7 @@ struct dso {
> >>  	enum dso_load_errno	load_errno;
> >>  	u8		 adjust_symbols:1;
> >>  	u8		 has_build_id:1;
> >> +	u8		 header_build_id:1;
> >>  	u8		 has_srcline:1;
> >>  	u8		 hit:1;
> >>  	u8		 annotate_warned:1;
> >> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> >> index 6da12e522edc..571d73d4f976 100644
> >> --- a/tools/perf/util/header.c
> >> +++ b/tools/perf/util/header.c
> >> @@ -2200,6 +2200,7 @@ static int __event_process_build_id(struct perf_record_header_build_id *bev,
> >>  
> >>  		build_id__init(&bid, bev->data, size);
> >>  		dso__set_build_id(dso, &bid);
> >> +		dso->header_build_id = 1;
> >>  
> >>  		if (dso_space != DSO_SPACE__USER) {
> >>  			struct kmod_path m = { .name = NULL, };
> >> diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
> >> index 1803d3887afe..4ae91e491e23 100644
> >> --- a/tools/perf/util/map.c
> >> +++ b/tools/perf/util/map.c
> >> @@ -127,7 +127,7 @@ struct map *map__new(struct machine *machine, u64 start, u64 len,
> >>  
> >>  	if (map != NULL) {
> >>  		char newfilename[PATH_MAX];
> >> -		struct dso *dso;
> >> +		struct dso *dso, *header_bid_dso;
> >>  		int anon, no_dso, vdso, android;
> >>  
> >>  		android = is_android_lib(filename);
> >> @@ -185,7 +185,19 @@ struct map *map__new(struct machine *machine, u64 start, u64 len,
> >>  
> >>  		if (build_id__is_defined(bid))
> >>  			dso__set_build_id(dso, bid);
> >> -
> >> +		else {
> > 
> > nit please add { } to the if clause as well
> > 
> >> +			/*
> >> +			 * If the mmap event had no build ID, search for an existing dso from the
> >> +			 * build ID header by name. Otherwise only the dso loaded at the time of
> >> +			 * reading the header will have the build ID set and all future mmaps will
> >> +			 * have it missing.
> >> +			 */
> >> +			header_bid_dso = __dsos__find(&machine->dsos, filename, false);
> > 
> > is this 'perf top' safe? I think dso should be added in the
> > same thread, but please check and add comment why we don't
> > need locking in here
> 
> Seems like there are multiple synthesize_threads_workers using the same machine->dsos object so
> I think locking is needed.
> 
> At first I thought of doing this:
> 
>   diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
>   index 4ae91e491e23..b87b81e3d41c 100644
>   --- a/tools/perf/util/map.c
>   +++ b/tools/perf/util/map.c
>   @@ -192,7 +192,9 @@ struct map *map__new(struct machine *machine, u64 start, u64 len,
>                            * reading the header will have the build ID set and all future mmaps will
>                            * have it missing.
>                            */
>   +                       down_read(&machine->dsos.lock);
>                           header_bid_dso = __dsos__find(&machine->dsos, filename, false);
>   +                       up_read(&machine->dsos.lock);
>                           if (header_bid_dso && header_bid_dso->header_build_id) {
>                                   dso__set_build_id(dso, &header_bid_dso->bid);
>                                   dso->header_build_id = 1;
> 
> But then I was wondering why it doesn't need a write lock all the way from machine__findnew_dso_id() to
> dso__put()? At the moment there are writes to the dso like dso__set_loaded(), dso->nsinfo = nsi and
> dso__set_build_id(), so another thread could find the dso in a partially constructed state.

I think that's fine, machine__findnew_dso_id takes the dso ref so
the real 'release' is when the machine object goes down at dsos__purge

> 
> Not sure if this is an issue currently without my patch, but at least with it they would have to be found
> with header_build_id already set to 1 otherwise it will mess things up.

as for the partial changes I think it's also fine, because it happens
at separate places.. we'd need to investigate specific example to see
if there's a problem

> 
> Extending the write lock outside of machine__findnew_dso_id() is difficult because it already
> releases it before it returns. Does it need to be changed so that machine__findnew_dso_id() takes all the
> arguments needed to construct it inside the lock?

the change above should do it.. as for top threads I don't think
it actually matters because there's events processing and hists
processing, and I did not find them clashing in this.. but there's
some setup session code that touches this, so it's better to be safe

thanks,
jirka
