Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C60B453108D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 15:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236162AbiEWNMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 09:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236032AbiEWNMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 09:12:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BAF62669
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 06:12:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A1C9AB810AD
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 13:12:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B828C385AA;
        Mon, 23 May 2022 13:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653311531;
        bh=sQH8pLW5zGb26Lk/aNAhQwXPoKxk9hGgY13tGh91Y8E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GJuQJe0W/QoCP7IgYE3761/xx8U8nHQ5ffbzxvwoEgEef4EqohCB+YfZdkI89zPIg
         hEeUGxe1YejKbyn8wvPaRYvuwKmU15AGXZp38gHzJFxOwBXgMt2KcZ/KViB9NM32VB
         Si/VZiT1y29luyB2gPdpP7ITK6Xngr5tHEtBbGNUuYDgQj0q/7rETy8Z8wpSKPMjuL
         MzauARYGuHGMorIpqlXylJHwrOadIwT5yFRYoOHypj0fb3xYfjSS3XYOuaR32Fzogk
         ZtEP5sNOy62vVQF9obCzDZeYVx6Odlj04uXuI7Q+Haa0HW/r8qZqMjP++JebohSPMr
         8oQHgIwP49mYg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5AD50400B1; Mon, 23 May 2022 10:12:09 -0300 (-03)
Date:   Mon, 23 May 2022 10:12:09 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] perf inject: Minor improvements
Message-ID: <YouIKVUs2S0KSjT8@kernel.org>
References: <20220520132404.25853-1-adrian.hunter@intel.com>
 <YotC+NbrBENmqtAh@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YotC+NbrBENmqtAh@krava>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, May 23, 2022 at 10:16:56AM +0200, Jiri Olsa escreveu:
> On Fri, May 20, 2022 at 04:23:59PM +0300, Adrian Hunter wrote:
> > Hi
> > 
> > Here are patches for 2 minor improvements for perf inject:
> > 1. Keep some features sections from input file
> > 2. Keep a copy of kcore_dir
> > 
> > 
> > Adrian Hunter (5):
> >       perf header: Add ability to keep feature sections
> >       libperf: Add preadn()
> >       perf inject: Keep some features sections from input file
> >       perf data: Add has_kcore_dir()
> >       perf inject: Keep a copy of kcore_dir
> 
> LGTM
> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>

Thanks, applied.

- Arnaldo

 
> thanks,
> jirka
> 
> > 
> >  tools/lib/perf/include/internal/lib.h |   2 +
> >  tools/lib/perf/lib.c                  |  20 +++++
> >  tools/perf/builtin-inject.c           | 162 +++++++++++++++++++++++++++++++++-
> >  tools/perf/util/data.c                |  14 +++
> >  tools/perf/util/data.h                |   1 +
> >  tools/perf/util/header.c              |  62 +++++++++++--
> >  tools/perf/util/header.h              |  15 ++++
> >  7 files changed, 264 insertions(+), 12 deletions(-)
> > 
> > 
> > Regards
> > Adrian

-- 

- Arnaldo
