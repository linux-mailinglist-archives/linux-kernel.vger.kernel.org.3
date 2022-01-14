Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0AE248EBF9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 15:47:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242005AbiANOrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 09:47:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233727AbiANOrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 09:47:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B350CC061574;
        Fri, 14 Jan 2022 06:47:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7674CB821B8;
        Fri, 14 Jan 2022 14:47:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C2B1C36AE5;
        Fri, 14 Jan 2022 14:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642171664;
        bh=27uxthPRWS3BTbs9jsMyrj3qXiQA2+lLgqw7CVx3CBI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XRmdGq+lpq7UuP59DXn86gYzHIEWbvzbwl93c78/Nu+aAsZaEo5BvoL0PeDedAB/s
         VuaPIxWAQeIm3YK5+QaymzX3UjSrDGsOdV6G89zyRjM0jLJWqvWxe2Sg15ELaggaeF
         FNmEC2RTRbBAHwTCKu3ykt/i1Xz8U9H83731F1uO5oYYb7N5Mw9vCx93xeZoSOkjnY
         GowTykrtQ61Xmyef50CmQ32OONFKZoLtkLI5k6j3bMv0jCdQ7dozf4Cn2fSMBgvWna
         GoUvYKoAws3go5LYgr8RLgHMYAKo3W7QDhzqRQzmBUI8IeZz8JelBwCsDDhBQqAckr
         hqXUYjVHH8Cdw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id CBB8240714; Fri, 14 Jan 2022 11:47:42 -0300 (-03)
Date:   Fri, 14 Jan 2022 11:47:42 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>,
        peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, ak@linux.intel.com, john.garry@huawei.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf util: Fix use after free in metric__new
Message-ID: <YeGNDskRtgpIFmzU@kernel.org>
References: <20211208171113.22089-1-jose.exposito89@gmail.com>
 <CAP-5=fUAR9uSAQGkukqafkoX+jz1fE8f-ziU5WeG59XT53jMWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUAR9uSAQGkukqafkoX+jz1fE8f-ziU5WeG59XT53jMWw@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Dec 08, 2021 at 09:33:14AM -0800, Ian Rogers escreveu:
> On Wed, Dec 8, 2021 at 9:11 AM José Expósito <jose.exposito89@gmail.com> wrote:
> >
> > Addresses-Coverity-ID: 1494000
> > Signed-off-by: José Expósito <jose.exposito89@gmail.com>
> 
> Acked-by: Ian Rogers <irogers@google,com>
> 
> This can only happen in the ENOMEM case, but it is a good fix.
> 
> Fixes: b85a4d61d302 (perf metric: Allow modifiers on metrics)

Sorry, I missed this one _as well_, sigh...

- Arnaldo
 
> Thanks,
> Ian
> 
> > ---
> >  tools/perf/util/metricgroup.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> > index fffe02aae3ed..4d2fed3aefd1 100644
> > --- a/tools/perf/util/metricgroup.c
> > +++ b/tools/perf/util/metricgroup.c
> > @@ -209,8 +209,8 @@ static struct metric *metric__new(const struct pmu_event *pe,
> >         m->metric_name = pe->metric_name;
> >         m->modifier = modifier ? strdup(modifier) : NULL;
> >         if (modifier && !m->modifier) {
> > -               free(m);
> >                 expr__ctx_free(m->pctx);
> > +               free(m);
> >                 return NULL;
> >         }
> >         m->metric_expr = pe->metric_expr;
> > --
> > 2.25.1
> >

-- 

- Arnaldo
