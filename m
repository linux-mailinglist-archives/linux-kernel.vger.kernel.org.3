Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 233D15AF286
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 19:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233565AbiIFRat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 13:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239421AbiIFRaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 13:30:01 -0400
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC80C6F573
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 10:24:15 -0700 (PDT)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-11ee4649dfcso29935587fac.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 10:24:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=8W4rIretQoi8IDe/L7WE48uSMWu0lEW18CcpmYHdfes=;
        b=6DAo6tP38pH2lH2QIwf8FcgsswiN3DcvedTcNPFkxyqtems7Ja2dWbYwezVlNufvDN
         psqTIWl1EXgzG5wnNdXbNteMGLU0TdkffIEIuLOjE5RaVZt3te55xEkWLNnt8K3Zx2FC
         +v0O9VqpxbwqgChIrBfNeBwl7pU2IRlIUeIEahPbhtU4GV7KXXxa3qiWCEqEciYDVQO9
         GPZIqICXfDbunVhJTC62GkIKkRhLuEGL5S5m9rQ8d+K/bumaSRPVkSER13Tq8HQpDjEz
         lWfwyBcjdw3j/TpfsCcH+pw101AIH7AKmqJ4fSPc/HH8HqHVt9Mxr49bm/3zwcZV5fqj
         ZmMw==
X-Gm-Message-State: ACgBeo356J3P415zw+3ptCv3/GnhKJg8IV9fhp9iRiKIkO+Z5AHmvdgt
        Ul38OVRwsfkL10m9qCN9gfW0WFIBOiGf6UEpUzjqMuwE
X-Google-Smtp-Source: AA6agR59F6My0jh1Q4GFZ9KHAY15sJZ/bvv6cjy6ZI7As4qqCdUdO73hQ+P2kmEkLnzyjweTqSQLj0FSG4o9Jatilsw=
X-Received: by 2002:a05:6870:5b84:b0:10c:d1fa:2f52 with SMTP id
 em4-20020a0568705b8400b0010cd1fa2f52mr12284031oab.92.1662485054550; Tue, 06
 Sep 2022 10:24:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220905073424.3971-1-adrian.hunter@intel.com> <YxdFfVbDcwnT7DXm@kernel.org>
In-Reply-To: <YxdFfVbDcwnT7DXm@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 6 Sep 2022 10:24:03 -0700
Message-ID: <CAM9d7cg8fTPTSzcZiwgQE4eF6HdpkuZ+YkQ=fAb+iB80V8nQEw@mail.gmail.com>
Subject: Re: [PATCH V2 0/6] perf intel-pt: Support itrace option flag d+e to
 log on error
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI Arnaldo,

On Tue, Sep 6, 2022 at 6:05 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>
> Em Mon, Sep 05, 2022 at 10:34:18AM +0300, Adrian Hunter escreveu:
> > Hi
> >
> > Here are a few patches to add the ability to output the decoding debug log
> > only when there are decoding errors.
> >
> > This is motivated by the fact that a full log can be very large, so just
> > getting interesting bits is useful for analyzing errors.
> >
> > If necessary, the size of output on error is configurable via perf config,
> > and perf_config_scan() was added in the 1st patch to make that simpler.
> >
> > The 2nd patch adds the new option flag to auxtrace.
> >
> > There are a couple of very minor and essentially unrelated changes in
> > patches 3 and 4.
> >
> > The main Intel PT change is in patch 5 and there is a small example in the
> > commit message.
> >
> >
> > Changes in V2:
> >
> >       perf intel-pt: Support itrace option flag d+e to log on error
> >       Ensure log_buf is defined before use
> >
> >       perf intel-pt: Remove first line of log dumped on error
> >       Remove first line only if the buffer has wrapped
>
> Applied locally, Namhyung: I think your review comment was addressed,
> right? If so can I add your Reviewed-by to all the patches in this
> series?

Sure,

Reviewed-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

>
> - Arnaldo
>
> >
> > Adrian Hunter (6):
> >       perf tools: Add perf_config_scan()
> >       perf auxtrace: Add itrace option flag d+e to log on error
> >       perf intel-pt: Improve man page layout slightly
> >       perf intel-pt: Improve object code read error message
> >       perf intel-pt: Support itrace option flag d+e to log on error
> >       perf intel-pt: Remove first line of log dumped on error
> >
> >  tools/perf/Documentation/itrace.txt             |   1 +
> >  tools/perf/Documentation/perf-config.txt        |   7 ++
> >  tools/perf/Documentation/perf-intel-pt.txt      |  13 ++-
> >  tools/perf/util/auxtrace.c                      |  13 +++
> >  tools/perf/util/auxtrace.h                      |   3 +
> >  tools/perf/util/config.c                        |  31 +++++++
> >  tools/perf/util/config.h                        |   1 +
> >  tools/perf/util/intel-pt-decoder/intel-pt-log.c | 117 +++++++++++++++++++++++-
> >  tools/perf/util/intel-pt-decoder/intel-pt-log.h |   3 +-
> >  tools/perf/util/intel-pt.c                      |  23 ++++-
> >  10 files changed, 206 insertions(+), 6 deletions(-)
> >
> >
> > Regards
> > Adrian
>
> --
>
> - Arnaldo
