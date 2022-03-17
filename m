Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6FEB4DC20A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 09:58:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231600AbiCQI7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 04:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231589AbiCQI7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 04:59:10 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C359862CE
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 01:57:53 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id yy13so9262997ejb.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 01:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QMtGeqomwznJI/gl46/c3T8R9lHYL30LY6nbhKixJdo=;
        b=ky4+JmWvqZMHpw5V8xhbNVGCb+92I1H9IhEXhXWydXZfF9y0kSVzDaU7eNEW4Wbke6
         N4+OIagcC/KwrvNMFWnSsYxwDubaMTepnSclg0epveGOUqkPD+d+RgfA2dyfUn+56r7S
         rPViRvRJiCPSfcqn+25qzp77eolMC5MnSNPJrWuam+/nKsnqit8TvbDD2dDT44Ub5Tnc
         tCTpxNVNifCpPbrO5DTT7nbBbqEtMqm1eWJQXlerBsG7cXqCcKVD3mWnS39y8Kd7aTpm
         oBWmdwBbXjK1wo9MOmJEMcwfV0PEYuhPe98cjPb8zlrYSe1bpVOBBOGhdgQ2qsl5MP7m
         wtsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QMtGeqomwznJI/gl46/c3T8R9lHYL30LY6nbhKixJdo=;
        b=dJiMO710SG9DdasEg6PVbxy0GEh/2XBLpo5Ej83tFJSp9rrcFKBuZR3xxE73mWlsOv
         yrWJC8KfZ6mzwIUrtquLCAtGeZndBEyHPKidUj2af2G7Jn6KgvUz0XJvZBnkG+PuXqQr
         /JsIi0pjkzF/RYnUpGAKLZskVvxU7sW9yGS0kGvhqr/8X18D5p9MrsK85Gpv7Jlu0joZ
         iqsp7jFIe6TZM2/e5PqZsfPjUEOVgLK9NsYVLdzv5mbYLgvbCsr5mIhLf64BG/NP1H6t
         TyMn4I4ATUcb3WfD+F6dGrhCtPiaiXbcqtcchHsKzKACHVUxxAjaV2jIXByAAOSu8Vdm
         c2hQ==
X-Gm-Message-State: AOAM532U1m3WV1k8CDi/247zcwQetwEfRupVIlYaSsCTcBz9EjQmhzzu
        a2HWqCfsX39pdVYgXbOc9v9c2cDKxzQ=
X-Google-Smtp-Source: ABdhPJzjY3i+XK/8tvil7JW8Rf0UfpEmWRwgazORHiUyHhikiem2Gu7w4ijoUNfeDSSUt/hqQb3rMA==
X-Received: by 2002:a17:906:c14f:b0:6da:bd6f:f03 with SMTP id dp15-20020a170906c14f00b006dabd6f0f03mr3241893ejc.561.1647507472143;
        Thu, 17 Mar 2022 01:57:52 -0700 (PDT)
Received: from krava ([193.85.244.190])
        by smtp.gmail.com with ESMTPSA id k7-20020aa7c047000000b004132d3b60aasm2242662edo.78.2022.03.17.01.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 01:57:51 -0700 (PDT)
Date:   Thu, 17 Mar 2022 09:57:49 +0100
From:   Jiri Olsa <olsajiri@gmail.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] perf evlist: Avoid iteration for empty evlist.
Message-ID: <YjL4DX+oGZQA4zbn@krava>
References: <20220316071049.2368250-1-irogers@google.com>
 <YjHvB4q7VZyKsIUU@krava>
 <CAP-5=fUkgp0G+Hj8fnO0RdMdbcKMesEHHE5SgS5OPpj_iW_D9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fUkgp0G+Hj8fnO0RdMdbcKMesEHHE5SgS5OPpj_iW_D9w@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2022 at 01:16:30PM -0700, Ian Rogers wrote:
> On Wed, Mar 16, 2022 at 7:08 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Wed, Mar 16, 2022 at 12:10:49AM -0700, Ian Rogers wrote:
> > > As seen with 'perf stat --null ..' and reported in:
> > > https://lore.kernel.org/lkml/YjCLcpcX2peeQVCH@kernel.org/
> > >
> > > Fixes: 472832d2c000 ("perf evlist: Refactor evlist__for_each_cpu()")
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > ---
> > >  tools/perf/util/evlist.c | 5 ++++-
> > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> > > index 8134d45e2164..a2dba9e00765 100644
> > > --- a/tools/perf/util/evlist.c
> > > +++ b/tools/perf/util/evlist.c
> > > @@ -354,7 +354,10 @@ struct evlist_cpu_iterator evlist__cpu_begin(struct evlist *evlist, struct affin
> > >               .affinity = affinity,
> > >       };
> > >
> > > -     if (itr.affinity) {
> > > +     if (evlist__empty(evlist)) {
> > > +             /* Ensure the empty list doesn't iterate. */
> > > +             itr.evlist_cpu_map_idx = itr.evlist_cpu_map_nr;
> >
> > I can't see the crash anymore, but I'm bit confused with the code
> >
> > if evlist is empty then itr.evsel is bogus.. and the loop code
> > __run_perf_stat is just lucky, right?
> 
> The itr.evsel is the list head, so bogus.
> 
> > I think we need to set itr.evsel to NULL and skip the loop in
> > case evlist is empty
> 
> So that's the effect of this change except that the evsel is the list
> head. I'm not sure it is worth adding the condition to setting the
> evsel to capture that given that with the end condition having been
> met it would be invalid to read it. There's a similar problem for the
> other fields of the iterator.

ah ok, I got it.. but it seems to be just evsel that's wrong,
just as a precaution, could we set it only when it's valid?
with something like below

thanks,
jirka


---
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index a2dba9e00765..76a6c70c3c40 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -346,7 +346,7 @@ struct evlist_cpu_iterator evlist__cpu_begin(struct evlist *evlist, struct affin
 {
 	struct evlist_cpu_iterator itr = {
 		.container = evlist,
-		.evsel = evlist__first(evlist),
+		.evsel = evlist__empty(evlist) ? NULL : evlist__first(evlist),
 		.cpu_map_idx = 0,
 		.evlist_cpu_map_idx = 0,
 		.evlist_cpu_map_nr = perf_cpu_map__nr(evlist->core.all_cpus),
