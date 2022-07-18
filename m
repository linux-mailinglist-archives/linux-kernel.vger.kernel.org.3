Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D19F5782B9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 14:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233673AbiGRMu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 08:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233249AbiGRMu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 08:50:26 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ACFE5F67;
        Mon, 18 Jul 2022 05:50:25 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BF2891042;
        Mon, 18 Jul 2022 05:50:25 -0700 (PDT)
Received: from [10.32.33.51] (e121896.warwick.arm.com [10.32.33.51])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D58C43F70D;
        Mon, 18 Jul 2022 05:50:23 -0700 (PDT)
Message-ID: <c0b64785-55f2-111c-cec7-a7a90f68f8ac@arm.com>
Date:   Mon, 18 Jul 2022 13:50:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] perf python: Avoid deprecation warning on distutils
Content-Language: en-US
To:     Ian Rogers <rogers.email@gmail.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
References: <20220615014206.26651-1-irogers@google.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <20220615014206.26651-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15/06/2022 02:42, Ian Rogers wrote:
> Fix the following DeprecationWarning:
> 
> tools/perf/util/setup.py:31: DeprecationWarning: The distutils
> package is deprecated and slated for removal in Python 3.12. Use
> setuptools or check PEP 632 for potential alternatives
> 
> Note: the setuptools module may need installing, for example:
> sudo apt install python-setuptools
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/setup.py | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/util/setup.py b/tools/perf/util/setup.py
> index c255a2c90cd6..5a3c74bce836 100644
> --- a/tools/perf/util/setup.py
> +++ b/tools/perf/util/setup.py
> @@ -11,7 +11,7 @@ def clang_has_option(option):
>      return [o for o in cc_output if ((b"unknown argument" in o) or (b"is not supported" in o))] == [ ]
>  
>  if cc_is_clang:
> -    from distutils.sysconfig import get_config_vars
> +    from sysconfig import get_config_vars
>      vars = get_config_vars()
>      for var in ('CFLAGS', 'OPT'):
>          vars[var] = sub("-specs=[^ ]+", "", vars[var])
> @@ -28,10 +28,10 @@ if cc_is_clang:
>          if not clang_has_option("-ffat-lto-objects"):
>              vars[var] = sub("-ffat-lto-objects", "", vars[var])
>  
> -from distutils.core import setup, Extension
> +from setuptools import setup, Extension
>  
> -from distutils.command.build_ext   import build_ext   as _build_ext
> -from distutils.command.install_lib import install_lib as _install_lib
> +from setuptools.command.build_ext   import build_ext   as _build_ext
> +from setuptools.command.install_lib import install_lib as _install_lib
>  
>  class build_ext(_build_ext):
>      def finalize_options(self):

Tested it with python 2.7 and 3.8 by running "make install-python_ext PYTHON=..."

Reviewed-by: James Clark <james.clark@arm.com>
