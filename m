Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A882F4FC4BE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 21:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349499AbiDKTLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 15:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349421AbiDKTLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 15:11:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B21636179;
        Mon, 11 Apr 2022 12:08:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0F49BB8182A;
        Mon, 11 Apr 2022 19:08:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1F43C385A3;
        Mon, 11 Apr 2022 19:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649704124;
        bh=/uLswY1Ogxto367uh/Q5JyXgkYDtYi+G+fGwpDT12zw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lv5yWxFgnHyXNF8hO9MtQRITMaEdqiZ6WeCUnFHTIneWAGFK5TzAq2TCpwFz6p4Vh
         a2D+hOGTQzTo5mPNUlslIHikcDc7Sd6GN/q/Owj1h1Q+l+4e6eSYtrPmZpFapLHD81
         VrS/YYac2Bz+Hu7WqWAVcOO5xtpp1fW54A37k7PpU7Ohs3Eq1WQAw+e57ceXeBWecE
         DqQqtidO4Ck7OX2ZJCSKw+cVrzFjvRXJhYVbXoZ3jDeYHQa7bRtfPjeHi3BHpIj/mj
         otbRhsTKHT92y05qsO6ebTz8gudVQ6vTX9Y3PTobfRRUwY5Z2CVIGhMJBW4jPSCz/l
         +xN7Hqtrgzefw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2A50B40407; Mon, 11 Apr 2022 16:08:42 -0300 (-03)
Date:   Mon, 11 Apr 2022 16:08:42 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     carsten.haitzler@foss.arm.com, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, suzuki.poulose@arm.com,
        mathieu.poirier@linaro.org, mike.leach@linaro.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/3] perf test: Shell - Limit to only run executable
 scripts in tests
Message-ID: <YlR8urE9UL99eBIv@kernel.org>
References: <20220309122859.31487-1-carsten.haitzler@foss.arm.com>
 <20220410012410.GA14326@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220410012410.GA14326@leoy-ThinkPad-X240s>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Apr 10, 2022 at 09:24:10AM +0800, Leo Yan escreveu:
> On Wed, Mar 09, 2022 at 12:28:57PM +0000, carsten.haitzler@foss.arm.com wrote:
> > From: Carsten Haitzler <carsten.haitzler@arm.com>
> > 
> > Perf test's shell runner will just run everything in the tests
> > directory (as long as it's not another directory or does not begin
> > with a dot), but sometimes you find files in there that are not shell
> > scripts - perf.data output for example if you do some testing and then
> > the next time you run perf test it tries to run these. Check the files
> > are executable so they are actually intended to be test scripts and
> > not just some "random junk" files there.
> > 
> > Signed-off-by: Carsten Haitzler <carsten.haitzler@arm.com>
> 
> Reviewed-by: Leo Yan <leo.yan@linaro.org>

Thanks, applied.

- Arnaldo

 
> > ---
> >  tools/perf/tests/builtin-test.c |  4 +++-
> >  tools/perf/util/path.c          | 14 +++++++++++++-
> >  tools/perf/util/path.h          |  1 +
> >  3 files changed, 17 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
> > index fac3717d9ba1..3c34cb766724 100644
> > --- a/tools/perf/tests/builtin-test.c
> > +++ b/tools/perf/tests/builtin-test.c
> > @@ -296,7 +296,9 @@ static const char *shell_test__description(char *description, size_t size,
> >  
> >  #define for_each_shell_test(entlist, nr, base, ent)	                \
> >  	for (int __i = 0; __i < nr && (ent = entlist[__i]); __i++)	\
> > -		if (!is_directory(base, ent) && ent->d_name[0] != '.')
> > +		if (!is_directory(base, ent) && \
> > +			is_executable_file(base, ent) && \
> > +			ent->d_name[0] != '.')
> >  
> >  static const char *shell_tests__dir(char *path, size_t size)
> >  {
> > diff --git a/tools/perf/util/path.c b/tools/perf/util/path.c
> > index caed0336429f..ce80b79be103 100644
> > --- a/tools/perf/util/path.c
> > +++ b/tools/perf/util/path.c
> > @@ -86,9 +86,21 @@ bool is_directory(const char *base_path, const struct dirent *dent)
> >  	char path[PATH_MAX];
> >  	struct stat st;
> >  
> > -	sprintf(path, "%s/%s", base_path, dent->d_name);
> > +	snprintf(path, sizeof(path), "%s/%s", base_path, dent->d_name);
> >  	if (stat(path, &st))
> >  		return false;
> >  
> >  	return S_ISDIR(st.st_mode);
> >  }
> > +
> > +bool is_executable_file(const char *base_path, const struct dirent *dent)
> > +{
> > +	char path[PATH_MAX];
> > +	struct stat st;
> > +
> > +	snprintf(path, sizeof(path), "%s/%s", base_path, dent->d_name);
> > +	if (stat(path, &st))
> > +		return false;
> > +
> > +	return !S_ISDIR(st.st_mode) && (st.st_mode & S_IXUSR);
> > +}
> > diff --git a/tools/perf/util/path.h b/tools/perf/util/path.h
> > index 083429b7efa3..d94902c22222 100644
> > --- a/tools/perf/util/path.h
> > +++ b/tools/perf/util/path.h
> > @@ -12,5 +12,6 @@ int path__join3(char *bf, size_t size, const char *path1, const char *path2, con
> >  
> >  bool is_regular_file(const char *file);
> >  bool is_directory(const char *base_path, const struct dirent *dent);
> > +bool is_executable_file(const char *base_path, const struct dirent *dent);
> >  
> >  #endif /* _PERF_PATH_H */
> > -- 
> > 2.32.0
> > 

-- 

- Arnaldo
