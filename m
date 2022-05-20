Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91BF752EC19
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 14:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349283AbiETMcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 08:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349270AbiETMcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 08:32:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A771B1632B8;
        Fri, 20 May 2022 05:32:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 51E84B82B41;
        Fri, 20 May 2022 12:32:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA2CBC385A9;
        Fri, 20 May 2022 12:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653049959;
        bh=fAEdgqMEdnQTAHFprj1rFAfr5TzMf8KKvVtECUecqXM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NKH/tOGboM7ia5MkeSzgP/aTkCBmn3o/VjPvMBq+dAna0x3clRrkfu4PhYh2EDaB5
         oTbyV8CzQzEnQ5kcsdZxJQUtioQsW7sJtEqLw6rZZjnhwYvsCxEo/fRbLwNdUbS8iw
         vVOwTMFjqbYpuzyJAAxcocjwY1kpNSw6aM43bn5wNeKn+KH0FfcPc86zSCBT5VFfk5
         C5ExlE4iYTo9EjUcgWmWq1+tgdPzkJrsZoxalPtIZyr9rf1RL7Dp1+r0LDjfUhoIdu
         tTKGlyboaN9ZEN+JL5g2PaAZZvCle705v+OTQO7V5APs7WbrAoLo2r1lnp8HuLEdOP
         N6oly8pOMdz9Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 01E2A400B1; Fri, 20 May 2022 09:32:36 -0300 (-03)
Date:   Fri, 20 May 2022 09:32:36 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     German Gomez <german.gomez@arm.com>
Cc:     James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, broonie@kernel.org,
        leo.yan@linaro.org, mathieu.poirier@linaro.org,
        john.garry@huawei.com, Will Deacon <will@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 0/2] perf: arm64: Tools support for Dwarf unwinding
 through SVE functions
Message-ID: <YoeKZFXO6zqFaqme@kernel.org>
References: <20220517102005.3022017-1-james.clark@arm.com>
 <YoO4Hiue7PmJ9KOS@kernel.org>
 <995099d3-a170-69dc-d12e-c9b2e4753f35@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <995099d3-a170-69dc-d12e-c9b2e4753f35@arm.com>
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

Em Fri, May 20, 2022 at 12:46:24PM +0100, German Gomez escreveu:
> 
> On 17/05/2022 15:58, Arnaldo Carvalho de Melo wrote:
> > Em Tue, May 17, 2022 at 11:20:01AM +0100, James Clark escreveu:
> >> Changes since v1:
> >>
> >>   * Split patchset into kernel side and Perf tool changes
> > Thanks, now I'll wait for the kernel side to be merged.
> >
> > - Arnaldo
> >  
> 
> Hi,
> 
> I think we also need to fix the below import (it's trying to import the
> perf_regs.h from the kernel, not the tools/ dir).

Sure, that is why it is important to do a:

make -C tools/perf build-test

before posting patches, as it will do, among other tests, a detached tarball test using:

⬢[acme@toolbox perf-urgent]$ make help | grep perf
  perf-tar-src-pkg    - Build perf-5.18.0-rc7.tar source tarball
  perf-targz-src-pkg  - Build perf-5.18.0-rc7.tar.gz source tarball
  perf-tarbz2-src-pkg - Build perf-5.18.0-rc7.tar.bz2 source tarball
  perf-tarxz-src-pkg  - Build perf-5.18.0-rc7.tar.xz source tarball
  perf-tarzst-src-pkg - Build perf-5.18.0-rc7.tar.zst source tarball
⬢[acme@toolbox perf-urgent]$

That will pick just what is in tools/perf/MANIFEST and that doesn´t
include the kernel headers, just what is in tools/ then building with
this patchkit would fail.

To recap:

⬢[acme@toolbox perf-urgent]$ make perf-tarxz-src-pkg
  TAR
  PERF_VERSION = 5.18.rc7.gc645054ef517
⬢[acme@toolbox perf-urgent]$ ls -la perf-5.18.0-rc7.tar.xz
-rw-r--r--. 1 acme acme 2364832 May 20 09:32 perf-5.18.0-rc7.tar.xz
⬢[acme@toolbox perf-urgent]$ tar tvf perf-5.18.0-rc7.tar.xz | tail
-rw-rw-r-- root/root      7364 2022-05-20 09:32 perf-5.18.0-rc7/tools/perf/util/vdso.c
-rw-rw-r-- root/root       639 2022-05-20 09:32 perf-5.18.0-rc7/tools/perf/util/vdso.h
-rw-rw-r-- root/root      1793 2022-05-20 09:32 perf-5.18.0-rc7/tools/perf/util/zlib.c
-rw-rw-r-- root/root      2672 2022-05-20 09:32 perf-5.18.0-rc7/tools/perf/util/zstd.c
drwxrwxr-x root/root         0 2022-05-20 09:32 perf-5.18.0-rc7/tools/scripts/
-rw-rw-r-- root/root      1091 2022-05-20 09:32 perf-5.18.0-rc7/tools/scripts/Makefile.arch
-rw-rw-r-- root/root      5905 2022-05-20 09:32 perf-5.18.0-rc7/tools/scripts/Makefile.include
-rw-rw-r-- root/root      5288 2022-05-20 09:32 perf-5.18.0-rc7/tools/scripts/utilities.mak
-rw-r--r-- acme/acme        41 2022-05-20 09:32 perf-5.18.0-rc7/HEAD
-rw-r--r-- acme/acme        46 2022-05-20 09:32 perf-5.18.0-rc7/PERF-VERSION-FILE
⬢[acme@toolbox perf-urgent]$

- Arnaldo
 
> diff --git a/tools/perf/util/libunwind/arm64.c b/tools/perf/util/libunwind/arm64.c
> index 15f60fd09424..014d82159656 100644
> --- a/tools/perf/util/libunwind/arm64.c
> +++ b/tools/perf/util/libunwind/arm64.c
> @@ -24,7 +24,7 @@
>  #include "unwind.h"
>  #include "libunwind-aarch64.h"
>  #define perf_event_arm_regs perf_event_arm64_regs
> -#include <../../../../arch/arm64/include/uapi/asm/perf_regs.h>
> +#include <../../../arch/arm64/include/uapi/asm/perf_regs.h>
>  #undef perf_event_arm_regs
>  #include "../../arch/arm64/util/unwind-libunwind.c"
> 

-- 

- Arnaldo
