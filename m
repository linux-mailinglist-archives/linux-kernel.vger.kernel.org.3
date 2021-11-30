Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 379164636C1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 15:33:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242164AbhK3Ogb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 09:36:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242219AbhK3Og3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 09:36:29 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74C1AC06174A;
        Tue, 30 Nov 2021 06:33:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 1C148CE1A11;
        Tue, 30 Nov 2021 14:33:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 168D5C53FC7;
        Tue, 30 Nov 2021 14:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638282784;
        bh=gNsifwcpSxHo4eTNGo101IyK5aaP95Eyilkrt2KaoFw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rq2Ku/6wp6r1gu9t/AdrgpjwPdX9YH6fySjibiL0Ev4cOrIAzOzJXuS/xfVe+2IQi
         l8LJH+fdmkdc8LyR0dWE3pVpU4HhGENRgAs2DpmaGxptnJBaDrN+P5HsmnrbDwy8TU
         EWBdq8NcfOuf/TZYQNycPth5mPP2DktzynsJrbPMg+TEGDYZeC9Hn6E8WbrhHHYCqR
         APoqcsgspLRMAyyjQXUgeV7OqwkNF/9tpEaI0HLeJjHbvd1t2SF4JbV88MZh9xBFJ3
         PInxagdl7fJSiCVZD+WiuYY4cFSc5vKmStumT2YGsln86vdZ2QI2T4HR3KWHRXSRFf
         NAPdjgvbCJuBw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 29CE340002; Tue, 30 Nov 2021 11:33:01 -0300 (-03)
Date:   Tue, 30 Nov 2021 11:33:01 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     James Clark <james.clark@arm.com>
Cc:     Jaroslav =?utf-8?B?xaBrYXJ2YWRh?= <jskarvad@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: Re: [FYI][PATCH 1/1] tools build: Remove needless libpython-version
 feature check that breaks test-all fast path
Message-ID: <YaY2HSVLmY9XZofB@kernel.org>
References: <YaYmeeC6CS2b8OSz@kernel.org>
 <4df4b76a-fbb5-89d8-fbef-fa844d8c1d3b@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4df4b76a-fbb5-89d8-fbef-fa844d8c1d3b@arm.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Nov 30, 2021 at 02:18:54PM +0000, James Clark escreveu:
> 
> 
> On 30/11/2021 13:26, Arnaldo Carvalho de Melo wrote:
> > Since 66dfdff03d196e51 ("perf tools: Add Python 3 support") we don't use
> > the tools/build/feature/test-libpython-version.c version in any Makefile
> > feature check:
> > 
> >   $ find tools/ -type f | xargs grep feature-libpython-version
> >   $
> > 
> > The only place where this was used was removed in 66dfdff03d196e51:
> > 
> >   -        ifneq ($(feature-libpython-version), 1)
> >   -          $(warning Python 3 is not yet supported; please set)
> >   -          $(warning PYTHON and/or PYTHON_CONFIG appropriately.)
> >   -          $(warning If you also have Python 2 installed, then)
> >   -          $(warning try something like:)
> >   -          $(warning $(and ,))
> >   -          $(warning $(and ,)  make PYTHON=python2)
> >   -          $(warning $(and ,))
> >   -          $(warning Otherwise, disable Python support entirely:)
> >   -          $(warning $(and ,))
> >   -          $(warning $(and ,)  make NO_LIBPYTHON=1)
> >   -          $(warning $(and ,))
> >   -          $(error   $(and ,))
> >   -        else
> >   -          LDFLAGS += $(PYTHON_EMBED_LDFLAGS)
> >   -          EXTLIBS += $(PYTHON_EMBED_LIBADD)
> >   -          LANG_BINDINGS += $(obj-perf)python/perf.so
> >   -          $(call detected,CONFIG_LIBPYTHON)
> >   -        endif
> > 
> > And nowadays we either build with PYTHON=python3 or just install the
> > python3 devel packages and perf will build against it.
> 
> I just tried this and found a combo that doesn't work and fails with this
> error (unrelated to this change): 
> 
>   Makefile.config:812: No 'python-config' tool was found: disables Python support - please install python-devel/python-dev
> 
> The combo is when the python2 runtime is installed, but the python3 devtools
> are installed. I didn't realise this when I added the python 3 autodetection,
> I only fixed the issue for a system that was solely python3.
> 
> Do you think I should fix this? Currently the workaround is PYTHON=python3,
> maybe it's enough of an edge case that it's ok?

We have a workaround, so perhaps you can just send a patch improving the
warning about python-config, suggesting to maybe using PYTHON=python3 on
the make command line?

But I won't complain if you want to provide something better :-)

> Reviewed-by: James Clark <james.clark@arm.com>

Thanks, adding it to the patch,

Regards,

- Arnaldo
