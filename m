Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6A7E4D6F62
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 15:01:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232043AbiCLOCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 09:02:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232035AbiCLOCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 09:02:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44BB4207C23;
        Sat, 12 Mar 2022 06:01:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CCF9160F4D;
        Sat, 12 Mar 2022 14:01:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 038DEC340EB;
        Sat, 12 Mar 2022 14:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647093699;
        bh=EWppwMs4zXpEN1MUilMlk2HIwVVsI6O1KIb2Pombqes=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Tpc6BDfubwAqCRrdsJAor20gfFOxbfaKF61aFOf73iiyBbgeqPFAYQ7vwMXl6Qb2S
         EvKUrqQ9RIzQZqj1Ovy5rDv8FHRLPoHm7HY2WNZtzbXiD0bH6uOL3tVGvstGcw+gbE
         AvlTVLmoq4K56Z6CerZnO9IRGAlv86nVH1UKe77L3MJ5FyCgMtTwCKjalCkkrHxG92
         QRZv83LZUjEel4m23aNuN5J/259Ngm9G5QFjYILNpXiFhltMcI5NXdYEoWYfIjSEup
         0f2etc9piB2j94FKecuGUhdMDJbkN/25XZNjAm0+9ctB/Oy128giFMA0xSftMx29+9
         SbGFLGwUadi4w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E0BC0403C8; Sat, 12 Mar 2022 11:01:36 -0300 (-03)
Date:   Sat, 12 Mar 2022 11:01:36 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, coresight@lists.linaro.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/1] perf: Set build-id using build-id header on new
 mmap records
Message-ID: <YiynwIfRqPZUGf2W@kernel.org>
References: <20220304090956.2048712-1-james.clark@arm.com>
 <YiPJN1yaFKILinpE@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YiPJN1yaFKILinpE@krava>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Mar 05, 2022 at 09:33:59PM +0100, Jiri Olsa escreveu:
> On Fri, Mar 04, 2022 at 09:09:55AM +0000, James Clark wrote:
> > Changes since v1:
> >  * Add read lock around dso find
> >  * Bracket style fix
> > 
> > Hi,
> > 
> > We are seeing an issue with doing Coresight decode off target where
> > initially the correct dso from ~/.debug is used, but after a new thread
> > in the perf.data file is passed with its mmap record, the local version
> > of the dso is picked up instead. This happens if the binary exists in the
> > same path on both devices, for example /bin/ls.
> > 
> > Initially when parsing the build-ids in the header, the dso for /bin/ls
> > will be created, and the file will correctly point to
> > ~/.debug/bin/ls/2f15ad836be3339dec0e2e6a3c637e08e48aacbd/elf, but for any
> > new threads or mmaps that are also for /bin/ls, they will not have a
> > build-id set so they point to /bin/ls on the local machine rather than the
> > debug folder.
> > 
> > To fix this I made it possible to look up which existing dsos have
> > build id's set that originate from the header and then copy that build-id
> > onto the new dso if the name matches. Another way to do it would
> > be to stop comparing the mmap id so it matches on filename only, but I
> > think we do want to differentiate between different mmaps, even if they
> > have the same name, which is how it works in this version.
> > 
> > Applies to perf/core 56dce8681
> > 
> > James Clark (1):
> >   perf: Set build-id using build-id header on new mmap records
> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>

Thanks, applied.

- Arnaldo

