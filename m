Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5315D5B264B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 20:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232563AbiIHSxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 14:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232500AbiIHSxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 14:53:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1492B103061;
        Thu,  8 Sep 2022 11:53:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C22C61DCB;
        Thu,  8 Sep 2022 18:53:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5375EC433C1;
        Thu,  8 Sep 2022 18:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662663179;
        bh=OfEwE92FvUQTZ2OVXWPHaUk+Ohbu1SzoKoKbJOo2mgA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GVsF88Gsv6xnzlYC4hcwd7V9Ser2eLDknyGibf4FfThXQyfwn/omW+Ct0MCVl7wlL
         INroToWOpe6rCdNKmLJXLzyJY3o3IkX7LLx2uZGuF7v8TYkSn1adHphcepHiOLN1F8
         Apr+y4uhmfH8HzSmPLiPZjFHn4xyP+KLYRyuy9FbVE5IbeW5dtnXObvjMjvEYj24px
         ztuHLIOIt1RW64mh8fm6op6GvyGXpOJ8GbdAEUqD23h2fV6EJ2N7KJQX7hSacvpHwn
         yiDlz/9z6TPFVVuTA+u8SFTb1rrXfBDEEkX+46GrdKAXZU65xDYN15YsRwmQ0OGGwW
         /9zpvb5oQ5N4Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 333FD404A1; Thu,  8 Sep 2022 15:52:57 -0300 (-03)
Date:   Thu, 8 Sep 2022 15:52:57 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Jiri Olsa <olsajiri@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        James Clark <james.clark@arm.com>,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        German Gomez <german.gomez@arm.com>,
        Colin Ian King <colin.king@intel.com>,
        Song Liu <songliubraving@fb.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v2 6/6] perf cpumap: Add range data encoding
Message-ID: <Yxo6Ccp/Hb4qAxZS@kernel.org>
References: <20220614143353.1559597-1-irogers@google.com>
 <20220614143353.1559597-7-irogers@google.com>
 <YuZ4CEnken8U4HO5@krava>
 <CAP-5=fVczMiasS15UovH8kzOaNw=TC_adeqjC+xBzv8jVJ3DTQ@mail.gmail.com>
 <CAP-5=fWVN4Fig5GEwyWwwUc9_iZyZ5rObTFkyNcuFp1GApy4tg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fWVN4Fig5GEwyWwwUc9_iZyZ5rObTFkyNcuFp1GApy4tg@mail.gmail.com>
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

Em Wed, Sep 07, 2022 at 03:41:19PM -0700, Ian Rogers escreveu:
> On Thu, Aug 4, 2022 at 12:30 PM Ian Rogers <irogers@google.com> wrote:
> >
> > On Sun, Jul 31, 2022 at 5:39 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> > >
> > > On Tue, Jun 14, 2022 at 07:33:53AM -0700, Ian Rogers wrote:
> > >
> > > SNIP
> > >
> > > > +     event = cpu_map_data__alloc(&syn_data, sizeof(struct perf_event_header));
> > > >       if (!event)
> > > >               return NULL;
> > > >
> > > > +     syn_data.data = &event->data;
> > > >       event->header.type = PERF_RECORD_CPU_MAP;
> > > > -     event->header.size = size;
> > > > -     event->data.type   = type;
> > > > -
> > > > -     cpu_map_data__synthesize(&event->data, map, type, max);
> > > > +     event->header.size = syn_data.size;
> > > > +     cpu_map_data__synthesize(&syn_data);
> > > >       return event;
> > > >  }
> > > >
> > > > +
> > > >  int perf_event__synthesize_cpu_map(struct perf_tool *tool,
> > > >                                  const struct perf_cpu_map *map,
> > > >                                  perf_event__handler_t process,
> > > > @@ -1891,24 +1894,20 @@ int perf_event__synthesize_event_update_name(struct perf_tool *tool, struct evse
> > > >  int perf_event__synthesize_event_update_cpus(struct perf_tool *tool, struct evsel *evsel,
> > > >                                            perf_event__handler_t process)
> > > >  {
> > > > -     size_t size = sizeof(struct perf_event_header) + sizeof(u64) + sizeof(u64);
> > > > +     struct synthesize_cpu_map_data syn_data = { .map = evsel->core.own_cpus };
> > > >       struct perf_record_event_update *ev;
> > > > -     int max, err;
> > > > -     u16 type;
> > > > -
> > > > -     if (!evsel->core.own_cpus)
> > > > -             return 0;
> > >
> > > all seems fine, just looks like we no longer do this check,
> > > might not be needed anymore, as that changed in past
> >
> > This function is called in a test and in this file. The caller already
> > does this test and so the check is redundant plus a little confusing:
> > https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/util/synthetic-events.c?h=perf/core#n2062
> > As you say, it wasn't needed any more and so I removed it.
> >
> > Thanks,
> > Ian
> 
> Would be nice to land this imo. Anything outstanding?

So the last two patches were outstanding, 5/6 applied cleanly, 6/6 had
some fuzzes, minimal stuff, applied, I'll push it out soon, please
check.

- Arnaldo
