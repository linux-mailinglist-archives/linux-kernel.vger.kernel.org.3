Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECB6E5783BF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 15:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233716AbiGRNdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 09:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233699AbiGRNdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 09:33:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB8E311C03;
        Mon, 18 Jul 2022 06:33:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 57FF6615E9;
        Mon, 18 Jul 2022 13:33:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AAD1C341C0;
        Mon, 18 Jul 2022 13:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658151216;
        bh=nHiNKNkka8ODegJm3GpruB//oq/yRLOrqdvgbyC08U4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GLIp7Z0G2x2/x//4ZpBoX2pxBM0GzJQdkM/A7jsIc+SLUz9R6lmCee5kNdgaBbDFQ
         7arWEtN0KI04IflJZpy5NuOvvpqGLUbvKt/ttT7a/ihBkhIFVDYEkqPTFnh0BKRqOk
         6d9SUku6O/gH0ElC5sglMRLoRtJCz3C4KYwcFaoNJmJkObYLs0/tuTPm9M6UFuLz0E
         FnjddTPsqCT+J0U++Up5W9340L3H+yz4tTucEXaOb0DcA1RaV21yq56wA9Qmzz5nC/
         6CsrtebjIROdXOZPOaGo/t6SIYu1TjkF4lcL3m5c8RfGBqEdgnWvbSfeSQEQra4P+n
         vzQigrSpa/7HQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 33FFF40374; Mon, 18 Jul 2022 10:33:33 -0300 (-03)
Date:   Mon, 18 Jul 2022 10:33:33 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     James Clark <james.clark@arm.com>
Cc:     Ian Rogers <rogers.email@gmail.com>,
        Ian Rogers <irogers@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH] perf python: Avoid deprecation warning on distutils
Message-ID: <YtVhLasCbE/52kYI@kernel.org>
References: <20220615014206.26651-1-irogers@google.com>
 <c0b64785-55f2-111c-cec7-a7a90f68f8ac@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0b64785-55f2-111c-cec7-a7a90f68f8ac@arm.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Jul 18, 2022 at 01:50:22PM +0100, James Clark escreveu:
> On 15/06/2022 02:42, Ian Rogers wrote:
> > Fix the following DeprecationWarning:
> > 
> > tools/perf/util/setup.py:31: DeprecationWarning: The distutils
> > package is deprecated and slated for removal in Python 3.12. Use
> > setuptools or check PEP 632 for potential alternatives
> > 
> > Note: the setuptools module may need installing, for example:
> > sudo apt install python-setuptools

Thanks, applied, added this to the cset log:

    Reviewer comments:

    James said:

    Tested it with python 2.7 and 3.8 by running "make install-python_ext PYTHON=..."

    Committer notes:

    Tested with:

     $ make -k BUILD_BPF_SKEL=1 PYTHON=python2 O=/tmp/build/perf-urgent -C tools/perf install-bin ; perf test python

     $ make -k BUILD_BPF_SKEL=1 PYTHON=python3 O=/tmp/build/perf-urgent -C tools/perf install-bin ; perf test python

     $ make -k BUILD_BPF_SKEL=1 O=/tmp/build/perf-urgent -C tools/perf install-bin ; perf test python


- Arnaldo

 > 
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/setup.py | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/tools/perf/util/setup.py b/tools/perf/util/setup.py
> > index c255a2c90cd6..5a3c74bce836 100644
> > --- a/tools/perf/util/setup.py
> > +++ b/tools/perf/util/setup.py
> > @@ -11,7 +11,7 @@ def clang_has_option(option):
> >      return [o for o in cc_output if ((b"unknown argument" in o) or (b"is not supported" in o))] == [ ]
> >  
> >  if cc_is_clang:
> > -    from distutils.sysconfig import get_config_vars
> > +    from sysconfig import get_config_vars
> >      vars = get_config_vars()
> >      for var in ('CFLAGS', 'OPT'):
> >          vars[var] = sub("-specs=[^ ]+", "", vars[var])
> > @@ -28,10 +28,10 @@ if cc_is_clang:
> >          if not clang_has_option("-ffat-lto-objects"):
> >              vars[var] = sub("-ffat-lto-objects", "", vars[var])
> >  
> > -from distutils.core import setup, Extension
> > +from setuptools import setup, Extension
> >  
> > -from distutils.command.build_ext   import build_ext   as _build_ext
> > -from distutils.command.install_lib import install_lib as _install_lib
> > +from setuptools.command.build_ext   import build_ext   as _build_ext
> > +from setuptools.command.install_lib import install_lib as _install_lib
> >  
> >  class build_ext(_build_ext):
> >      def finalize_options(self):
> 
> Tested it with python 2.7 and 3.8 by running "make install-python_ext PYTHON=..."
> 
> Reviewed-by: James Clark <james.clark@arm.com>

-- 

- Arnaldo
