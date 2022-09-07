Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BCAD5AFB6A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 06:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbiIGEvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 00:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiIGEu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 00:50:58 -0400
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A36E98035E;
        Tue,  6 Sep 2022 21:50:57 -0700 (PDT)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-127f5411b9cso1967622fac.4;
        Tue, 06 Sep 2022 21:50:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=+hb4KiQ5kfoaXxVbkb/vKbUjz/tUAwb2RSgxrzzGgOI=;
        b=R0g1TvTqxIiWJ1L9zqRlL2CbuOiWD/3jhmcuaB75dPPtqFyPWAt3aNnUqQWbCs/kls
         Tfo2Es4ibUxKq+jSyHRLXJcz8gWhfCINts/QoQ8KlRRNtLEtFVj9JV5V2Y8e5nFslR5I
         gs4oSyEsCmQcqo1eYMQ4LsgOM5Kfvk+Tkuj4I408eg2pMI7HPW6BpQE+VBt39P6+dNyM
         QOrYcN1vSkX3zqjglWyJGF1Mr6rtDpUkSHtIyuU4R6ia/n05VKQqGdhC2YwIRISs309p
         H/xcB+7Fglz9lHo5p7M+CyI3CdKeFBEmPt1YB8KQRoNpNbfgWRrH+54b46JU97vh4i9K
         NoFA==
X-Gm-Message-State: ACgBeo2GAK9F0bTJ60uiRm0H5S/Atzq/NVtHJFjmZnDOqLNK6xfgV1R2
        S29PssvZZLMqKMGq8ijEBZchLHsqajg0wApaKyc=
X-Google-Smtp-Source: AA6agR4cN7Bn96Itu880UgqZckUA6cvOHFzwwwg/F4CzSy5m7/48AwLjjKxxpz1Fxk/5S20w83aNRHkmXt40eRHE/Nk=
X-Received: by 2002:a05:6870:5b84:b0:10c:d1fa:2f52 with SMTP id
 em4-20020a0568705b8400b0010cd1fa2f52mr890078oab.92.1662526256949; Tue, 06 Sep
 2022 21:50:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220831124041.219925-1-jolsa@kernel.org> <CAP-5=fX-=ph8g3VKbQXSRT8SiOZ3XqQLd3T9-ZTNZ5L+ye5L-A@mail.gmail.com>
 <Yw+LCN2cX9peweWV@kernel.org> <3aa4c863-24cc-9fdf-9960-2b1983b3322b@linux.intel.com>
In-Reply-To: <3aa4c863-24cc-9fdf-9960-2b1983b3322b@linux.intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 6 Sep 2022 21:50:47 -0700
Message-ID: <CAM9d7chpoqB18r3TXPuTAA4_4TsCYq+p+j90vKspv++X1RBU+w@mail.gmail.com>
Subject: Re: [PATCH] perf script: Skip dummy event attr check
To:     Xing Zhengjun <zhengjun.xing@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Hongtao Yu <hoy@fb.com>, lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        "Liang, Kan" <kan.liang@linux.intel.com>
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

Hello,

On Tue, Sep 6, 2022 at 7:49 PM Xing Zhengjun
<zhengjun.xing@linux.intel.com> wrote:
>
> Hi,
>
> On 9/1/2022 12:23 AM, Arnaldo Carvalho de Melo wrote:
> > Em Wed, Aug 31, 2022 at 09:02:46AM -0700, Ian Rogers escreveu:
> >> On Wed, Aug 31, 2022 at 5:40 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >>>
> >>> Hongtao Yu reported problem when displaying uregs in perf script
> >>> for system wide perf.data:
> >>>
> >>>    # perf script -F uregs | head -10
> >>>    Samples for 'dummy:HG' event do not have UREGS attribute set. Cannot print 'uregs' field.
> >>>
> >>> The problem is the extra dummy event added for system wide,
> >>> which does not have proper sample_type setup.
> >>>
> >>> Skipping attr check completely for dummy event as suggested
> >>> by Namhyung, because it does not have any samples anyway.
> >>>
> >>> Reported-by: Hongtao Yu <hoy@fb.com>
> >>> Suggested-by: Namhyung Kim <namhyung@kernel.org>
> >>> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> >>
> >> Acked-by: Ian Rogers <irogers@google.com>
> >
> > Thanks, applied to perf/urgent.
> >
> > - Arnaldo
>
> I have met a similar issue on hybrid systems such as ADL, I apply the
> patch, and it works OK for the normal mode.
>   # ./perf record  --intr-regs=di,r8,dx,cx -e
> br_inst_retired.near_call:p -c 1000 --per-thread true
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.024 MB perf.data (25 samples) ]
>
> # ./perf script -F iregs |head -5
>   ABI:2    CX:0xffff90e19d024ed8    DX:0x1    DI:0xffff90e19d024ed8
> R8:0xffffba5e437e7b30
>   ABI:2    CX:0x7f5239783000    DX:0x80000000    DI:0xffff90e1801eea00
>   R8:0x71
>   ABI:2    CX:0x40    DX:0x60    DI:0xffffffff9fde5ab8    R8:0x40
>   ABI:2    CX:0x0    DX:0xffffffffffffffff    DI:0xffff90e1877408e8
> R8:0x1
>   ABI:2    CX:0xcc0    DX:0x1    DI:0xffff90e187d17c60    R8:0x40
>
> But the issue still happened when running the test in the pipe mode. In
> the pipe mode, it calls process_attr() which still checks the attr for
> the dummy event, so the issue happened.
>
>   # ./perf record -o - --intr-regs=di,r8,dx,cx -e
> br_inst_retired.near_call:p -c 1000 --per-thread true 2>/dev/null|./perf
> script -F iregs |head -5
> Samples for 'dummy:HG' event do not have IREGS attribute set. Cannot
> print 'iregs' field.
> 0x120 [0x90]: failed to process type: 64
>
> I have one test patch which can fix the pipe mode issue.
>
>   ./perf record -o - --intr-regs=di,r8,dx,cx -e
> br_inst_retired.near_call:p -c 1000 --per-thread true 2>/dev/null|./perf
> script -F iregs |head -5
>   ABI:2    CX:0xffff90e18119e278    DX:0x0    DI:0xffff90e18119f858
> R8:0xffff90e18119e278
>   ABI:2    CX:0x0    DX:0x1    DI:0xfffffa2844a91580    R8:0x402
>   ABI:2    CX:0x0    DX:0x0    DI:0x100cca    R8:0x0
>   ABI:2    CX:0x0    DX:0x0    DI:0xffffffff9e997ca5    R8:0x0
>   ABI:2    CX:0x113ce8000    DX:0xffff90e198f46600
> DI:0xffff90e189de8000    R8:0x290
>
>
> Fixes: b91e5492f9d7 ("perf record: Add a dummy event on hybrid systems
> to collect metadata records")
> Signed-off-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>
> ---
>   tools/perf/builtin-script.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index 9152e3e45b69..2d863cdb19fe 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -2429,6 +2429,8 @@ static int process_attr(struct perf_tool *tool,
> union perf_event *event,
>          }
>
>          if (evsel->core.attr.sample_type) {
> +               if (evsel__is_dummy_event(evsel))
> +                       return 0;

Maybe we can move this into evsel__check_attr().

Thanks,
Namhyung


>                  err = evsel__check_attr(evsel, scr->session);
>                  if (err)
>                          return err;
> --
> 2.25.1
>
> --
> Zhengjun Xing
