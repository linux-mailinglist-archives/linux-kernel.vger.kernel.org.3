Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33DC55AFE8C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 10:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbiIGIJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 04:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiIGIJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 04:09:26 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4615CE6;
        Wed,  7 Sep 2022 01:09:22 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id r4so18490248edi.8;
        Wed, 07 Sep 2022 01:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date;
        bh=nZBZtJ297XmLiu2NLiapRd+TBjFWmiba0rgJxYibHic=;
        b=mVPcYJGCFdaDYI+deWCritlXrD0tWbvzIFTIVsEocrT3R+CgiuTdOm3ey7wO5zEwBS
         F9PVZEs3+auo6qTMQMOsHhICCjGaRWMLFJEfen5ZUS+tIHPSzNf44ynfbCKviXbEk5h2
         ruK93GRIePgNAmoWIaHd/E4N9DV5NULRo/f1VzRie3dllR16Qthqg2tOcaSj2AepTLnr
         ExwH9dEL9AB8bxlW6oUSElWNPWyC88Usvu40aAPBf+g0TAtJXh6oz2ed81B35+ge4e0i
         D9l2b9xs0rG34eGd/MSEfP3oC+RTn7jxTjNqrsaHYD0kWAuwllwStYHGglH/CQgNOcoT
         +Xdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date;
        bh=nZBZtJ297XmLiu2NLiapRd+TBjFWmiba0rgJxYibHic=;
        b=GqxHpExIzpbrjnaLNKz01UkK4Ml8fKrvn5s+WHejtFxHHh+Rm6QdRAxgjMiQKYds1b
         +QjXtYbpmaEbL6NelYcPq+KdrEY8lWcu0BtbhoDx+Kp8QbKGHRHlkeQzQdFq89NWD9xJ
         0nO+HLutTDJlxzNZ3rfZL0qebHfQeVo5e7Td94Jm56kg7N8M/H09GcAtiP4IhImisV15
         VVVf+sjWOK9lT3/yk4dxDZXch2fUToqwWswCmJG+B4xBigxnuFE/fHDJ2b4ATE5Styj6
         9Nil4ARj48ZbQcyBobNeCDww1NGiFtrQPsaiVN6T0U77JF8eNTu4UXJwpMK/6pumRiTx
         c2yw==
X-Gm-Message-State: ACgBeo0+Bcr0F2ex49zCCgkT4oODGXD3CyjQye04YfX9NZwnm9tsxcpC
        I0gYPetZ2Hrrr0RPsM5SurM=
X-Google-Smtp-Source: AA6agR6T9NntUeh9DJxS7EElVcSV27CmeUyXC0LL8oGudhc3M1AA/vtzbCbpgQe2cQG0vdpjUsIvjg==
X-Received: by 2002:a05:6402:348f:b0:448:6005:68af with SMTP id v15-20020a056402348f00b00448600568afmr2083798edc.184.1662538161229;
        Wed, 07 Sep 2022 01:09:21 -0700 (PDT)
Received: from krava ([193.85.244.190])
        by smtp.gmail.com with ESMTPSA id 1-20020a170906218100b0073872f367cesm7864399eju.112.2022.09.07.01.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 01:09:20 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Wed, 7 Sep 2022 10:09:19 +0200
To:     Xing Zhengjun <zhengjun.xing@linux.intel.com>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>, Hongtao Yu <hoy@fb.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        "Liang, Kan" <kan.liang@linux.intel.com>
Subject: Re: [PATCH] perf script: Skip dummy event attr check
Message-ID: <YxhRr0tyPSpGZ+MP@krava>
References: <20220831124041.219925-1-jolsa@kernel.org>
 <CAP-5=fX-=ph8g3VKbQXSRT8SiOZ3XqQLd3T9-ZTNZ5L+ye5L-A@mail.gmail.com>
 <Yw+LCN2cX9peweWV@kernel.org>
 <3aa4c863-24cc-9fdf-9960-2b1983b3322b@linux.intel.com>
 <CAM9d7chpoqB18r3TXPuTAA4_4TsCYq+p+j90vKspv++X1RBU+w@mail.gmail.com>
 <78bedcf4-3ef8-2ccf-d846-74d0de0c67ad@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78bedcf4-3ef8-2ccf-d846-74d0de0c67ad@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 07, 2022 at 01:19:32PM +0800, Xing Zhengjun wrote:
> 
> 
> On 9/7/2022 12:50 PM, Namhyung Kim wrote:
> > Hello,
> > 
> > On Tue, Sep 6, 2022 at 7:49 PM Xing Zhengjun
> > <zhengjun.xing@linux.intel.com> wrote:
> > > 
> > > Hi,
> > > 
> > > On 9/1/2022 12:23 AM, Arnaldo Carvalho de Melo wrote:
> > > > Em Wed, Aug 31, 2022 at 09:02:46AM -0700, Ian Rogers escreveu:
> > > > > On Wed, Aug 31, 2022 at 5:40 AM Jiri Olsa <jolsa@kernel.org> wrote:
> > > > > > 
> > > > > > Hongtao Yu reported problem when displaying uregs in perf script
> > > > > > for system wide perf.data:
> > > > > > 
> > > > > >     # perf script -F uregs | head -10
> > > > > >     Samples for 'dummy:HG' event do not have UREGS attribute set. Cannot print 'uregs' field.
> > > > > > 
> > > > > > The problem is the extra dummy event added for system wide,
> > > > > > which does not have proper sample_type setup.
> > > > > > 
> > > > > > Skipping attr check completely for dummy event as suggested
> > > > > > by Namhyung, because it does not have any samples anyway.
> > > > > > 
> > > > > > Reported-by: Hongtao Yu <hoy@fb.com>
> > > > > > Suggested-by: Namhyung Kim <namhyung@kernel.org>
> > > > > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > > > 
> > > > > Acked-by: Ian Rogers <irogers@google.com>
> > > > 
> > > > Thanks, applied to perf/urgent.
> > > > 
> > > > - Arnaldo
> > > 
> > > I have met a similar issue on hybrid systems such as ADL, I apply the
> > > patch, and it works OK for the normal mode.
> > >    # ./perf record  --intr-regs=di,r8,dx,cx -e
> > > br_inst_retired.near_call:p -c 1000 --per-thread true
> > > [ perf record: Woken up 1 times to write data ]
> > > [ perf record: Captured and wrote 0.024 MB perf.data (25 samples) ]
> > > 
> > > # ./perf script -F iregs |head -5
> > >    ABI:2    CX:0xffff90e19d024ed8    DX:0x1    DI:0xffff90e19d024ed8
> > > R8:0xffffba5e437e7b30
> > >    ABI:2    CX:0x7f5239783000    DX:0x80000000    DI:0xffff90e1801eea00
> > >    R8:0x71
> > >    ABI:2    CX:0x40    DX:0x60    DI:0xffffffff9fde5ab8    R8:0x40
> > >    ABI:2    CX:0x0    DX:0xffffffffffffffff    DI:0xffff90e1877408e8
> > > R8:0x1
> > >    ABI:2    CX:0xcc0    DX:0x1    DI:0xffff90e187d17c60    R8:0x40
> > > 
> > > But the issue still happened when running the test in the pipe mode. In
> > > the pipe mode, it calls process_attr() which still checks the attr for
> > > the dummy event, so the issue happened.
> > > 
> > >    # ./perf record -o - --intr-regs=di,r8,dx,cx -e
> > > br_inst_retired.near_call:p -c 1000 --per-thread true 2>/dev/null|./perf
> > > script -F iregs |head -5
> > > Samples for 'dummy:HG' event do not have IREGS attribute set. Cannot
> > > print 'iregs' field.
> > > 0x120 [0x90]: failed to process type: 64
> > > 
> > > I have one test patch which can fix the pipe mode issue.
> > > 
> > >    ./perf record -o - --intr-regs=di,r8,dx,cx -e
> > > br_inst_retired.near_call:p -c 1000 --per-thread true 2>/dev/null|./perf
> > > script -F iregs |head -5
> > >    ABI:2    CX:0xffff90e18119e278    DX:0x0    DI:0xffff90e18119f858
> > > R8:0xffff90e18119e278
> > >    ABI:2    CX:0x0    DX:0x1    DI:0xfffffa2844a91580    R8:0x402
> > >    ABI:2    CX:0x0    DX:0x0    DI:0x100cca    R8:0x0
> > >    ABI:2    CX:0x0    DX:0x0    DI:0xffffffff9e997ca5    R8:0x0
> > >    ABI:2    CX:0x113ce8000    DX:0xffff90e198f46600
> > > DI:0xffff90e189de8000    R8:0x290
> > > 
> > > 
> > > Fixes: b91e5492f9d7 ("perf record: Add a dummy event on hybrid systems
> > > to collect metadata records")
> > > Signed-off-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>
> > > ---
> > >    tools/perf/builtin-script.c | 2 ++
> > >    1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> > > index 9152e3e45b69..2d863cdb19fe 100644
> > > --- a/tools/perf/builtin-script.c
> > > +++ b/tools/perf/builtin-script.c
> > > @@ -2429,6 +2429,8 @@ static int process_attr(struct perf_tool *tool,
> > > union perf_event *event,
> > >           }
> > > 
> > >           if (evsel->core.attr.sample_type) {
> > > +               if (evsel__is_dummy_event(evsel))
> > > +                       return 0;
> > 
> > Maybe we can move this into evsel__check_attr().
> > 
> > Thanks,
> > Namhyung
> 
> Yes, the following changes in evsel__check_attr() can fix both normal and
> pipe mode issues, Otherwise, we have to patch everywhere when
> evsel__check_attr() is called.
> 
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index 13580a9c50b8..fb76e3191858 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -451,6 +451,9 @@ static int evsel__check_attr(struct evsel *evsel, struct
> perf_session *session)
>         allow_user_set = perf_header__has_feat(&session->header,
>                                                HEADER_AUXTRACE);
> 
> +       if (evsel__is_dummy_event(evsel))
> +               allow_user_set = true;
> +

hm, do you need to pass allow_user_set to UREGS check then?

jirka


---
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 13580a9c50b8..30c9cbdee98d 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -451,6 +451,9 @@ static int evsel__check_attr(struct evsel *evsel, struct perf_session *session)
 	allow_user_set = perf_header__has_feat(&session->header,
 					       HEADER_AUXTRACE);
 
+	if (evsel__is_dummy_event(evsel))
+		allow_user_set = true;
+
 	if (PRINT_FIELD(TRACE) &&
 	    !perf_session__has_traces(session, "record -R"))
 		return -EINVAL;
@@ -517,7 +520,7 @@ static int evsel__check_attr(struct evsel *evsel, struct perf_session *session)
 		return -EINVAL;
 
 	if (PRINT_FIELD(UREGS) &&
-	    evsel__check_stype(evsel, PERF_SAMPLE_REGS_USER, "UREGS", PERF_OUTPUT_UREGS))
+	    evsel__do_check_stype(evsel, PERF_SAMPLE_REGS_USER, "UREGS", PERF_OUTPUT_UREGS, allow_user_set))
 		return -EINVAL;
 
 	if (PRINT_FIELD(PHYS_ADDR) &&
