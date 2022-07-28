Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24E3D584660
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 21:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233308AbiG1T0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 15:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiG1T0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 15:26:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 647E31D307;
        Thu, 28 Jul 2022 12:26:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1D838B81E8E;
        Thu, 28 Jul 2022 19:26:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B275C43470;
        Thu, 28 Jul 2022 19:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659036378;
        bh=G5RmgkQuI/HuMNQZK4HcIFiZADuFadEIvY/ZvFD18KQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Agou3H6BzcOJqyM2EOPksIhTLMHGBBzj4AHHMnp7OO9qUK6/CWD82/Zo6bFeqbBmx
         yqYjBT6K40oYDOMlqC508+fLObM1dxqrswojO9EbyOCYWHoY7zWO1QFBT/j7Ysz4ZO
         4WHn+8Vtt46oifLmyXbVP4h0El4NHIBvuoPKxbEYvRPw85ycIBAAyuVfFBoxlavo7Z
         dblUgOA0qwnRgY2bo7C0W1yg3PNAKrvHokTW0dLM97sdQNVBROJxnRinsCFpPqh1IQ
         TNRqAi89mDQdbB+1qk4qfKPfawjwGNzCMecL//NhZKnnIRYzSjoD77inDeWMfkIxDm
         9sHo1gyCHVn3w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 8E68C405DD; Thu, 28 Jul 2022 16:26:15 -0300 (-03)
Date:   Thu, 28 Jul 2022 16:26:15 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf: python: Fix build when PYTHON_CONFIG is user
 supplied
Message-ID: <YuLi14u3DQ+ShH9w@kernel.org>
References: <20220728093946.1337642-1-james.clark@arm.com>
 <CAP-5=fXnR=LSk-bO02V7HzWTTCrsbnM1w63_YYqSMEgy0vM-PQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fXnR=LSk-bO02V7HzWTTCrsbnM1w63_YYqSMEgy0vM-PQ@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jul 28, 2022 at 09:37:32AM -0700, Ian Rogers escreveu:
> On Thu, Jul 28, 2022 at 2:40 AM James Clark <james.clark@arm.com> wrote:
> >
> > The previous change to Python autodetection had a small mistake where
> > the auto value was used to determine the Python binary, rather than the
> > user supplied value. The Python binary is only used for one part of the
> > build process, rather than the final linking, so it was producing
> > correct builds in most scenarios, especially when the auto detected
> > value matched what the user wanted, or the system only had a valid set
> > of Pythons.
> >
> > Change it so that the Python binary path is derived from either the
> > PYTHON_CONFIG value or PYTHON value, depending on what is specified by
> > the user. This was the original intention.
> >
> > This error was spotted in a build failure an odd cross compilation
> > environment after commit 4c41cb46a732fe82 ("perf python: Prefer
> > python3") was merged.
> >
> > Fixes: 630af16eee495f58 ("perf tools: Use Python devtools for version autodetection rather than runtime")
> > Signed-off-by: James Clark <james.clark@arm.com>
> 
> Acked-by: Ian Rogers <irogers@google.com>

Thanks, applied.

- Arnaldo

 
> Thanks,
> Ian
> 
> > ---
> >  tools/perf/Makefile.config | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> > index d3c254c0f5c6..a69da9f34486 100644
> > --- a/tools/perf/Makefile.config
> > +++ b/tools/perf/Makefile.config
> > @@ -265,7 +265,7 @@ endif
> >  # defined. get-executable-or-default fails with an error if the first argument is supplied but
> >  # doesn't exist.
> >  override PYTHON_CONFIG := $(call get-executable-or-default,PYTHON_CONFIG,$(PYTHON_AUTO))
> > -override PYTHON := $(call get-executable-or-default,PYTHON,$(subst -config,,$(PYTHON_AUTO)))
> > +override PYTHON := $(call get-executable-or-default,PYTHON,$(subst -config,,$(PYTHON_CONFIG)))
> >
> >  grep-libs  = $(filter -l%,$(1))
> >  strip-libs  = $(filter-out -l%,$(1))
> > --
> > 2.28.0
> >

-- 

- Arnaldo
