Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10C664BB960
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 13:45:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235162AbiBRMp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 07:45:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233235AbiBRMp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 07:45:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40AFD28BF6E
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 04:45:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DFC7FB8261D
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 12:45:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63BECC340E9;
        Fri, 18 Feb 2022 12:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645188307;
        bh=a3sq/NygYUTFqMl2ktNgIr56AUFq6lOd/8WtdDpT6eQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G8I9duToX0Oozx5r/ELqVaC2EpoBB+7IL0I7x1LXHS0HyjhSFfeOVYnNs6zCPrfai
         YSHhRRexFoqSgyCKStLWMhaP9oyk2va0Hoek0BvuJVbBy5JLoYy/5PheZuEhJhA+F7
         /DtrEuwIgJbZb009bZ8iztuOcbKsxGvOZmTVeUNNkA56UK4B+Or8AIarspVNM3sjr5
         nL2ubx6/n1WSmpF7vCGnlaIeadU+pFvEMxX3+k7zte6A9a3n5QGqKnhM1qNahF/aKP
         oxjC+fxUutvIQUxHfjmvgl2yIYevlJ/4/JpOxNWIeBtct5LXOtfoxSJIpI4KCkhfxm
         JB7003H5aQPxw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5B0D7400FE; Fri, 18 Feb 2022 09:45:05 -0300 (-03)
Date:   Fri, 18 Feb 2022 09:45:05 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Antonov <alexander.antonov@linux.intel.com>,
        Alexei Budankov <abudankov@huawei.com>
Subject: Re: [PATCH] perf data: Fix double free in perf_session__delete
Message-ID: <Yg+U0dRdmHvO6sku@kernel.org>
References: <20220218113008.24416-1-alexey.v.bayduraev@linux.intel.com>
 <Yg+TcWkRDowtQfqO@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yg+TcWkRDowtQfqO@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Feb 18, 2022 at 09:39:13AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Fri, Feb 18, 2022 at 02:30:08PM +0300, Alexey Bayduraev escreveu:
> > When perf_data__create_dir fails, it calls close_dir, but
> > perf_session__delete also calls close_dir and since dir.version and
> > dir.nr was initialized by perf_data__create_dir, a double free occurs.
> > This patch moves the initialization of dir.version and dir.nr after
> > successful initialization of dir.files, that prevents double freeing.
> > This behavior is already implemented in perf_data__open_dir. The patch
> > also adds a missing error message in case data directory creation fails.
> 
> Is this for perf/urgent or for perf/core? Probably perf/core as that
> record__threads_enabled(rec) call hints.
> 
> Please state for which branch the patch should be applied, something
> like;
> 
> [PATCH next] perf data: Fix double free in perf_session__delete()
> 
> Or:
> 
> [PATCH urgent] perf data: Fix double free in perf_session__delete()


So, please break this into two patches, one adding the pr_err(), because
it touches things that are not in perf/urgent, the threaded work, and
another fixing the double free at perf_session__delete(), because that
one should go in perf/urgent, as this problem predates the threaded
record patch series:

Fixes: 145520631130bd64 ("perf data: Add perf_data__(create_dir|close_dir) functions")

Please add the above fixes for the patch fixing the double free.

Always think twice when writing 'this patch also does this extra thing',
usually this is an indication the patch should be split :-)

Thanks!

- Arnaldo
 
> > Signed-off-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
> > ---
> >  tools/perf/builtin-record.c | 4 +++-
> >  tools/perf/util/data.c      | 7 +++----
> >  2 files changed, 6 insertions(+), 5 deletions(-)
> > 
> > diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> > index 0bc6529814b2..0306d5911de2 100644
> > --- a/tools/perf/builtin-record.c
> > +++ b/tools/perf/builtin-record.c
> > @@ -1186,8 +1186,10 @@ static int record__mmap_evlist(struct record *rec,
> >  
> >  	if (record__threads_enabled(rec)) {
> >  		ret = perf_data__create_dir(&rec->data, evlist->core.nr_mmaps);
> > -		if (ret)
> > +		if (ret) {
> > +			pr_err("Failed to create data directory: %s\n", strerror(errno));
> >  			return ret;
> > +		}
> >  		for (i = 0; i < evlist->core.nr_mmaps; i++) {
> >  			if (evlist->mmap)
> >  				evlist->mmap[i].file = &rec->data.dir.files[i];
> > diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
> > index f5d260b1df4d..15a4547d608e 100644
> > --- a/tools/perf/util/data.c
> > +++ b/tools/perf/util/data.c
> > @@ -44,10 +44,6 @@ int perf_data__create_dir(struct perf_data *data, int nr)
> >  	if (!files)
> >  		return -ENOMEM;
> >  
> > -	data->dir.version = PERF_DIR_VERSION;
> > -	data->dir.files   = files;
> > -	data->dir.nr      = nr;
> > -
> >  	for (i = 0; i < nr; i++) {
> >  		struct perf_data_file *file = &files[i];
> >  
> > @@ -62,6 +58,9 @@ int perf_data__create_dir(struct perf_data *data, int nr)
> >  		file->fd = ret;
> >  	}
> >  
> > +	data->dir.version = PERF_DIR_VERSION;
> > +	data->dir.files   = files;
> > +	data->dir.nr      = nr;
> >  	return 0;
> >  
> >  out_err:
> > -- 
> > 2.19.0
