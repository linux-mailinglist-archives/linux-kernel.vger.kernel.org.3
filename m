Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB0858DB47
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 17:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244304AbiHIPjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 11:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238009AbiHIPjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 11:39:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED863C5A;
        Tue,  9 Aug 2022 08:39:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 89839612A3;
        Tue,  9 Aug 2022 15:39:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDE14C433D6;
        Tue,  9 Aug 2022 15:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660059543;
        bh=pfGxlai/gQ8q5M4UhIltp0q/iYXJpDj1pBiy5hYxVEI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ER6+rN1Pklc1K+BbltD08L/2w0TnI3lSCVNvggVd1JuA6SH+WuIb4rGyGG7vys1tg
         om+SA/UfbbflGFdZCEbvc0VitYP4YJdxpcoDHjEQflKFkHh+bbgRkbBA5D8AEg4iVg
         xjHWU+ki+mdhes7crbBwc1llDXtqw/9Ae5rZ7HHCnIsDWNm3Kiq3Ej0aibDfqVYO+E
         KlssYhOfOS55D6NLmZB2rP1hJ/yyApZeeTcoEY7mR0nLvNi5zZ5ILTb3UDp9kkTwLj
         37XSrz6VplAh+tzb1aySAhKubLavRAJHjJZM9QwA5A9SabgfGNg3c1fNdA6RTE/+rg
         cbiemdAvnle+w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 49B274035A; Tue,  9 Aug 2022 12:39:01 -0300 (-03)
Date:   Tue, 9 Aug 2022 12:39:01 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Sandipan Das <sandipan.das@amd.com>,
        Claire Jensen <cjense@google.com>, Alyssa Ross <hi@alyssa.is>,
        Like Xu <likexu@tencent.com>,
        James Clark <james.clark@arm.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Claire Jensen <clairej735@gmail.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v7 2/2] perf test: Json format checking
Message-ID: <YvJ/la5+PkhHrGE0@kernel.org>
References: <20220805200105.2020995-1-irogers@google.com>
 <20220805200105.2020995-3-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220805200105.2020995-3-irogers@google.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Aug 05, 2022 at 01:01:05PM -0700, Ian Rogers escreveu:
> From: Claire Jensen <cjense@google.com>
> 
> Add field checking tests for perf stat JSON output.
> Sanity checks the expected number of fields are present, that the
> expected keys are present and they have the correct values.
> 
> Signed-off-by: Claire Jensen <cjense@google.com>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/Makefile.perf                      |   3 +-
>  .../tests/shell/lib/perf_json_output_lint.py  |  96 ++++++++++++
>  tools/perf/tests/shell/stat+json_output.sh    | 147 ++++++++++++++++++
>  3 files changed, 245 insertions(+), 1 deletion(-)
>  create mode 100644 tools/perf/tests/shell/lib/perf_json_output_lint.py
>  create mode 100755 tools/perf/tests/shell/stat+json_output.sh
> 
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index 5053b563bf9c..b4c5160d3e85 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -1005,7 +1005,8 @@ install-tests: all install-gtk
>  		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell'; \
>  		$(INSTALL) tests/shell/*.sh '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell'; \
>  		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/lib'; \
> -		$(INSTALL) tests/shell/lib/*.sh '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/lib'
> +		$(INSTALL) tests/shell/lib/*.sh '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/lib' \
> +		$(INSTALL) tests/shell/lib/*.py '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/lib'


Next time please test installing it, since this is adding a new file:

  INSTALL tests
install: omitting directory '/home/acme/libexec/perf-core/tests/shell/lib'
install: cannot stat 'install': No such file or directory
make[2]: *** [Makefile.perf:999: install-tests] Error 1
make[2]: *** Waiting for unfinished jobs....


Fixed with:

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index b4c5160d3e85a161..e5921b3471535d45 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -1005,7 +1005,7 @@ install-tests: all install-gtk
 		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell'; \
 		$(INSTALL) tests/shell/*.sh '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell'; \
 		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/lib'; \
-		$(INSTALL) tests/shell/lib/*.sh '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/lib' \
+		$(INSTALL) tests/shell/lib/*.sh '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/lib'; \
 		$(INSTALL) tests/shell/lib/*.py '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/lib'
 
 install-bin: install-tools install-tests install-traceevent-plugins
