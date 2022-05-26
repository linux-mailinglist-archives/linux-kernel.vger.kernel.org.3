Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92B6C535346
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 20:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234460AbiEZSU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 14:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349222AbiEZSUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 14:20:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 651E8C03BA;
        Thu, 26 May 2022 11:20:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C5D87B821AA;
        Thu, 26 May 2022 18:19:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B857C34114;
        Thu, 26 May 2022 18:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653589198;
        bh=AV4sY7+ADpxJuDw9fhgadxalbn8NdBDUPKkU22h8dpc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iBVjaBWPP4FxfPd7GkRuTMDBV97IYTJ5n80HP2s5dFhMIGt6JTf6Pu7cn0BvAokB+
         9Qg0Gj+LURkGJRn+bxSRWRd5SqMx0Y2EzihGgs2VGxnFNS8DGfKbctxsU0XgAGmKEO
         U47chmUOStAD7VJfP50KagsW24iOYLfghC4sLI0Izh0Bj/2LMjdMbe0DQhzo3ZorDg
         +rMGscAxcLeDnHp434izJcP2EefRi7gIHYSHEsa8Fcis1E+HjrQ/15otCnmmwUv3x0
         bkAZu/JioqqAHRPCPt6Ddw392y176gYkiBLybLEBxdiba8VTkjXqsGW3cjPEfUX49v
         14LjZJkmwiOeg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id BED1F4036D; Thu, 26 May 2022 15:19:54 -0300 (-03)
Date:   Thu, 26 May 2022 15:19:54 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     James Clark <james.clark@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, broonie@kernel.org,
        german.gomez@arm.com, John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, linux-doc@vger.kernel.org
Subject: Re: [PATCH v1 4/6] perf tools: Use dynamic register set for Dwarf
 unwind
Message-ID: <Yo/EytFDKnOEiWCa@kernel.org>
References: <20220509144257.1623063-1-james.clark@arm.com>
 <20220509144257.1623063-5-james.clark@arm.com>
 <Yo+gYbLNnYGOPzGs@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Yo+gYbLNnYGOPzGs@kernel.org>
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

Em Thu, May 26, 2022 at 12:44:33PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Mon, May 09, 2022 at 03:42:52PM +0100, James Clark escreveu:
> > Architectures can detect availability of extra registers at
> > runtime so use this more complete set for unwinding. This
> > will include the VG register on arm64 in a later commit.
> > 
> > If the function isn't implemented then PERF_REGS_MASK is
> > returned and there is no change.
> 
> Committer notes:
> 
> Added util/perf_regs.c to tools/perf/util/python-ext-sources so that
> 'perf test python' passes, i.e. the perf python binding has all the
> symbols it needs, addressing:
> 
>   $ perf test -v python
>    19: 'import perf' in python                                         :
>   --- start ---
>   test child forked, pid 2037817
>   python usage test: "echo "import sys ; sys.path.append('/tmp/build/perf/python'); import perf" | '/usr/bin/python3' "
>   Traceback (most recent call last):
>     File "<stdin>", line 1, in <module>
>   ImportError: /tmp/build/perf/python/perf.cpython-310-x86_64-linux-gnu.so: undefined symbol: arch__user_reg_mask
>   test child finished with -1
>   ---- end ----
>   'import perf' in python: FAILED!
>   $

Too old to support?

  69     7.19 ubuntu:16.04-x-arm64          : FAIL gcc version 5.4.0 20160609 (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9)
    arch/arm64/util/perf_regs.c: In function 'arch__user_reg_mask':
    arch/arm64/util/perf_regs.c:151:28: error: 'HWCAP_SVE' undeclared (first use in this function)
      if (getauxval(AT_HWCAP) & HWCAP_SVE)
                                ^
    arch/arm64/util/perf_regs.c:151:28: note: each undeclared identifier is reported only once for each function it appears in
    /git/perf-5.18.0/tools/build/Makefile.build:139: recipe for target 'util' failed
    make[5]: *** [util] Error 2
    /git/perf-5.18.0/tools/build/Makefile.build:139: recipe for target 'arm64' failed
    make[4]: *** [arm64] Error 2
    /git/perf-5.18.0/tools/build/Makefile.build:139: recipe for target 'arch' failed
    make[3]: *** [arch] Error 2


⬢[acme@toolbox perf]$ find . -name "*.h" | xargs grep -w HWCAP_SVE
./arch/arm64/include/uapi/asm/hwcap.h:#define HWCAP_SVE		(1 << 22)
⬢[acme@toolbox perf]$ 

  
> > Signed-off-by: James Clark <james.clark@arm.com>
> > ---
> >  tools/perf/util/evsel.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> > index d38722560e80..a881784da966 100644
> > --- a/tools/perf/util/evsel.c
> > +++ b/tools/perf/util/evsel.c
> > @@ -875,7 +875,7 @@ static void __evsel__config_callchain(struct evsel *evsel, struct record_opts *o
> >  					   "specifying a subset with --user-regs may render DWARF unwinding unreliable, "
> >  					   "so the minimal registers set (IP, SP) is explicitly forced.\n");
> >  			} else {
> > -				attr->sample_regs_user |= PERF_REGS_MASK;
> > +				attr->sample_regs_user |= arch__user_reg_mask();
> >  			}
> >  			attr->sample_stack_user = param->dump_size;
> >  			attr->exclude_callchain_user = 1;
> > -- 
> > 2.28.0
> 
> -- 
> 
> - Arnaldo

-- 

- Arnaldo
