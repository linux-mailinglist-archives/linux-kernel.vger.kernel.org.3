Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 792D54C05CE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 01:17:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbiBWARU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 19:17:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiBWARS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 19:17:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 498BA4C42F
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 16:16:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D879761295
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 00:16:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24416C340E8;
        Wed, 23 Feb 2022 00:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645575410;
        bh=IfJ0A6W4odMqfWAuTFyGgLeQeK9RTCZE2nzukCzpgwo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gx5LL5tQelWrgwB2WtG/RWMgFJ6juCb2GtefL38y00ZaDrqkxQGO0NWPfYb/EpuRD
         t1BukWyurJtUPd8fppnYYwnARQW0FJwcX/IYgeKnYLKBYTOJY3Ky5vtg6F7JWF2pza
         AJu6wpXJKauUAdZWDlmCsR+2fHBbdJ9ouRjar68VHASBhWy6hhDXbuArX5do0zwumf
         xyEXcARS0giq18hKfJdJJYlvGWFd+4uEtI0Yein5AM/G/ORn7aOE/Iw5syyFt62L0C
         bmcFwl1RkK5brtLC1MjZwq81Y7ySNDpoZMH5iprAs2qX+/D7PGgAu2xSd0RKyEFHr7
         LPF1l76LZyZbQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 932AB400FE; Tue, 22 Feb 2022 21:16:47 -0300 (-03)
Date:   Tue, 22 Feb 2022 21:16:47 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Antonov <alexander.antonov@linux.intel.com>,
        Alexei Budankov <abudankov@huawei.com>
Subject: Re: [PATCH core v2] perf data: Adding error message if
 perf_data__create_dir fails
Message-ID: <YhV8772BjLAK56/z@kernel.org>
References: <20220222091417.11020-1-alexey.v.bayduraev@linux.intel.com>
 <YhVeSsxjpALcANeX@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YhVeSsxjpALcANeX@krava>
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

Em Tue, Feb 22, 2022 at 11:06:02PM +0100, Jiri Olsa escreveu:
> On Tue, Feb 22, 2022 at 12:14:17PM +0300, Alexey Bayduraev wrote:
> > Adding proper return codes for all cases of data directory creation
> > failure and adding error message output based on these codes.
> > 
> > Signed-off-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>

Thanks, applied.

- Arnaldo

 
> thanks,
> jirka
> 
> > ---
> >  tools/perf/builtin-record.c | 4 +++-
> >  tools/perf/util/data.c      | 8 ++++++--
> >  2 files changed, 9 insertions(+), 3 deletions(-)
> > 
> > diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> > index 0bc6529814b2..0b4abed555d8 100644
> > --- a/tools/perf/builtin-record.c
> > +++ b/tools/perf/builtin-record.c
> > @@ -1186,8 +1186,10 @@ static int record__mmap_evlist(struct record *rec,
> >  
> >  	if (record__threads_enabled(rec)) {
> >  		ret = perf_data__create_dir(&rec->data, evlist->core.nr_mmaps);
> > -		if (ret)
> > +		if (ret) {
> > +			pr_err("Failed to create data directory: %s\n", strerror(-ret));
> >  			return ret;
> > +		}
> >  		for (i = 0; i < evlist->core.nr_mmaps; i++) {
> >  			if (evlist->mmap)
> >  				evlist->mmap[i].file = &rec->data.dir.files[i];
> > diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
> > index f5d260b1df4d..dc5d82ea1c30 100644
> > --- a/tools/perf/util/data.c
> > +++ b/tools/perf/util/data.c
> > @@ -52,12 +52,16 @@ int perf_data__create_dir(struct perf_data *data, int nr)
> >  		struct perf_data_file *file = &files[i];
> >  
> >  		ret = asprintf(&file->path, "%s/data.%d", data->path, i);
> > -		if (ret < 0)
> > +		if (ret < 0) {
> > +			ret = -ENOMEM;
> >  			goto out_err;
> > +		}
> >  
> >  		ret = open(file->path, O_RDWR|O_CREAT|O_TRUNC, S_IRUSR|S_IWUSR);
> > -		if (ret < 0)
> > +		if (ret < 0) {
> > +			ret = -errno;
> >  			goto out_err;
> > +		}
> >  
> >  		file->fd = ret;
> >  	}
> > -- 
> > 2.19.0
> > 

-- 

- Arnaldo
