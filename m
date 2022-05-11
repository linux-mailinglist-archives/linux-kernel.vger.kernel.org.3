Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6CEF523B7A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 19:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345537AbiEKR1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 13:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345531AbiEKR1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 13:27:12 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C3E037A3B
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 10:27:10 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id o12-20020a1c4d0c000000b00393fbe2973dso3678073wmh.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 10:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5OBqBsoJ/TxRsSFzQqMPW/kr9BMkFs7GUmU5KHrm7/4=;
        b=DUZVTRT+yyDo7DUHH/QJg0TSEiL5v/fqE4I86EydXciRkX9DP98TpJ/16H1Y4s6Rhh
         QvOkoWxXOt5d0v0SxH9gf/049yEJs9CNRU4pQcPySAQn/T7n24H2GawGplBllMf+NKAd
         0YJ89dnaMevZxiu/2rtMhkQaiW1Ihpl01jnpm3g9AADQ6ZSN/tBW71BpOAPt3PaNlKKD
         TP3+RQLx1B/4Ux2QbxuealCBvzD+n62BEMiUeLIYNgyBI2rFVaAKgen+AO7Jh2AFiMGC
         32ccWgWuK+xvz8L641IFqS4z8ptXVVYws857SADKx2/OINFQGb+kruPL+0g/1lZJgVNW
         WQ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5OBqBsoJ/TxRsSFzQqMPW/kr9BMkFs7GUmU5KHrm7/4=;
        b=PaYKROo+0sYp+XyiSnbyD8xYYKEUMUVh06oQ4YZAnH4Wag+4HYa7Y5snwAOOkjjS3y
         KqI7vLHcirqAzVUWnuPN5HaunZblbwlq3SZt2abuThRUr8k52gjL/z9VU++3MfA5GfB1
         H0Gz4WssyCE+smdAbA5M1a3gdzb8NEQZtLMUJrgLscywXUePUWJWcEDOjSAUv+E6sBuZ
         f0mTVqOblFWyXGhz9Q4cI0xYNGaset9z/tGwDYljvo1CIew9rWD5bPKXvNpiKflKnRqA
         x7/AIIn51+vUJVB19Q68aE9xr7A7JPE05qEU4ISGqzqlSpH6RxBruLcDaTMyWQoX0wKk
         jJDg==
X-Gm-Message-State: AOAM5319fdMRpHWB1O8WDbMg3dCKTnKIrG6vGsfBVYNGsbEDm9Og4A7p
        pZ9aOJXUqD5MBNiNCB+AWnzSMFQVFtcv6Qx4F9rQ/g==
X-Google-Smtp-Source: ABdhPJykX8HqwOyGovzZA/NwJlbix4JvMk8CETGmkdnSAnhe/gWGei1l8Yy1LKthlTjnxvE5Zv8hHQ4cEnwCR9wN1BU=
X-Received: by 2002:a1c:19c1:0:b0:393:a19f:8f95 with SMTP id
 184-20020a1c19c1000000b00393a19f8f95mr5962936wmz.149.1652290028915; Wed, 11
 May 2022 10:27:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220511070133.710721-1-irogers@google.com> <20220511070133.710721-5-irogers@google.com>
 <35c5833b-6974-e40d-f4b3-a3b36d11d06c@linux.intel.com>
In-Reply-To: <35c5833b-6974-e40d-f4b3-a3b36d11d06c@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 11 May 2022 10:26:56 -0700
Message-ID: <CAP-5=fU3vs6c1ViZTxZECNi4jNKX0p47Lk1thTH8U_s6sQVSig@mail.gmail.com>
Subject: Re: [PATCH 4/7] perf jevents: Modify match field
To:     Xing Zhengjun <zhengjun.xing@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Felix Fietkau <nbd@nbd.name>,
        Qi Liu <liuqi115@huawei.com>, Like Xu <likexu@tencent.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Nick Forrington <nick.forrington@arm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        James Clark <james.clark@arm.com>,
        Andrew Kilroy <andrew.kilroy@arm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>, Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        ananth.narayan@amd.com, ravi.bangoria@amd.com,
        santosh.shukla@amd.com, sandipan.das@amd.com,
        Caleb Biggers <caleb.biggers@intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Kshipra Bopardikar <kshipra.bopardikar@intel.com>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 12:43 AM Xing Zhengjun
<zhengjun.xing@linux.intel.com> wrote:
>
>
>
> On 5/11/2022 3:01 PM, Ian Rogers wrote:
> > The match_field function looks for json values to append to the event
> > string. As the C code processes these in order the output order matches
> > that in the json dictionary. Python json readers read the entire
> > dictionary and lose the ordering. To make the python and C output
> > comparable makee the C code first read the extra fields then append them
>
> The "makee" should be a typo.

Good catch, fixed in v2. Thanks,
Ian

> > to the event in an order not determined by their order in the file.
> >
> > Modify the pmu-events test so that test expectations match the new
> > order.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >   tools/perf/pmu-events/jevents.c | 82 ++++++++++++++++++++-------------
> >   tools/perf/tests/pmu-events.c   | 24 +++++-----
> >   2 files changed, 62 insertions(+), 44 deletions(-)
> >
> > diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
> > index e1f7c7afd435..cee61c4ed59e 100644
> > --- a/tools/perf/pmu-events/jevents.c
> > +++ b/tools/perf/pmu-events/jevents.c
> > @@ -207,21 +207,6 @@ static struct msrmap {
> >       { NULL, NULL }
> >   };
> >
> > -static struct field {
> > -     const char *field;
> > -     const char *kernel;
> > -} fields[] = {
> > -     { "UMask",      "umask=" },
> > -     { "CounterMask", "cmask=" },
> > -     { "Invert",     "inv=" },
> > -     { "AnyThread",  "any=" },
> > -     { "EdgeDetect", "edge=" },
> > -     { "SampleAfterValue", "period=" },
> > -     { "FCMask",     "fc_mask=" },
> > -     { "PortMask",   "ch_mask=" },
> > -     { NULL, NULL }
> > -};
> > -
> >   static void cut_comma(char *map, jsmntok_t *newval)
> >   {
> >       int i;
> > @@ -233,21 +218,6 @@ static void cut_comma(char *map, jsmntok_t *newval)
> >       }
> >   }
> >
> > -static int match_field(char *map, jsmntok_t *field, int nz,
> > -                    char **event, jsmntok_t *val)
> > -{
> > -     struct field *f;
> > -     jsmntok_t newval = *val;
> > -
> > -     for (f = fields; f->field; f++)
> > -             if (json_streq(map, field, f->field) && nz) {
> > -                     cut_comma(map, &newval);
> > -                     addfield(map, event, ",", f->kernel, &newval);
> > -                     return 1;
> > -             }
> > -     return 0;
> > -}
> > -
> >   static struct msrmap *lookup_msr(char *map, jsmntok_t *val)
> >   {
> >       jsmntok_t newval = *val;
> > @@ -581,6 +551,14 @@ static int json_events(const char *fn,
> >               jsmntok_t *precise = NULL;
> >               jsmntok_t *obj = tok++;
> >               bool configcode_present = false;
> > +             char *umask = NULL;
> > +             char *cmask = NULL;
> > +             char *inv = NULL;
> > +             char *any = NULL;
> > +             char *edge = NULL;
> > +             char *period = NULL;
> > +             char *fc_mask = NULL;
> > +             char *ch_mask = NULL;
> >
> >               EXPECT(obj->type == JSMN_OBJECT, obj, "expected object");
> >               for (j = 0; j < obj->size; j += 2) {
> > @@ -596,8 +574,23 @@ static int json_events(const char *fn,
> >                              "Expected string value");
> >
> >                       nz = !json_streq(map, val, "0");
> > -                     if (match_field(map, field, nz, &event, val)) {
> > -                             /* ok */
> > +                     /* match_field */
> > +                     if (json_streq(map, field, "UMask") && nz) {
> > +                             addfield(map, &umask, "", "umask=", val);
> > +                     } else if (json_streq(map, field, "CounterMask") && nz) {
> > +                             addfield(map, &cmask, "", "cmask=", val);
> > +                     } else if (json_streq(map, field, "Invert") && nz) {
> > +                             addfield(map, &inv, "", "inv=", val);
> > +                     } else if (json_streq(map, field, "AnyThread") && nz) {
> > +                             addfield(map, &any, "", "any=", val);
> > +                     } else if (json_streq(map, field, "EdgeDetect") && nz) {
> > +                             addfield(map, &edge, "", "edge=", val);
> > +                     } else if (json_streq(map, field, "SampleAfterValue") && nz) {
> > +                             addfield(map, &period, "", "period=", val);
> > +                     } else if (json_streq(map, field, "FCMask") && nz) {
> > +                             addfield(map, &fc_mask, "", "fc_mask=", val);
> > +                     } else if (json_streq(map, field, "PortMask") && nz) {
> > +                             addfield(map, &ch_mask, "", "ch_mask=", val);
> >                       } else if (json_streq(map, field, "EventCode")) {
> >                               char *code = NULL;
> >                               addfield(map, &code, "", "", val);
> > @@ -690,6 +683,23 @@ static int json_events(const char *fn,
> >               else
> >                       snprintf(buf, sizeof buf, "event=%#llx", eventcode);
> >               addfield(map, &event, ",", buf, NULL);
> > +             if (any)
> > +                     addfield(map, &event, ",", any, NULL);
> > +             if (ch_mask)
> > +                     addfield(map, &event, ",", ch_mask, NULL);
> > +             if (cmask)
> > +                     addfield(map, &event, ",", cmask, NULL);
> > +             if (edge)
> > +                     addfield(map, &event, ",", edge, NULL);
> > +             if (fc_mask)
> > +                     addfield(map, &event, ",", fc_mask, NULL);
> > +             if (inv)
> > +                     addfield(map, &event, ",", inv, NULL);
> > +             if (period)
> > +                     addfield(map, &event, ",", period, NULL);
> > +             if (umask)
> > +                     addfield(map, &event, ",", umask, NULL);
> > +
> >               if (je.desc && extra_desc)
> >                       addfield(map, &je.desc, " ", extra_desc, NULL);
> >               if (je.long_desc && extra_desc)
> > @@ -718,6 +728,14 @@ static int json_events(const char *fn,
> >               je.event = real_event(je.name, event);
> >               err = func(data, &je);
> >   free_strings:
> > +             free(umask);
> > +             free(cmask);
> > +             free(inv);
> > +             free(any);
> > +             free(edge);
> > +             free(period);
> > +             free(fc_mask);
> > +             free(ch_mask);
> >               free(event);
> >               free(je.desc);
> >               free(je.name);
> > diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
> > index b74c6ef59e51..f13368569d8b 100644
> > --- a/tools/perf/tests/pmu-events.c
> > +++ b/tools/perf/tests/pmu-events.c
> > @@ -63,33 +63,33 @@ static const struct perf_pmu_test_event bp_l2_btb_correct = {
> >   static const struct perf_pmu_test_event segment_reg_loads_any = {
> >       .event = {
> >               .name = "segment_reg_loads.any",
> > -             .event = "umask=0x80,period=200000,event=0x6",
> > +             .event = "event=0x6,period=200000,umask=0x80",
> >               .desc = "Number of segment register loads",
> >               .topic = "other",
> >       },
> > -     .alias_str = "umask=0x80,period=0x30d40,event=0x6",
> > +     .alias_str = "event=0x6,period=0x30d40,umask=0x80",
> >       .alias_long_desc = "Number of segment register loads",
> >   };
> >
> >   static const struct perf_pmu_test_event dispatch_blocked_any = {
> >       .event = {
> >               .name = "dispatch_blocked.any",
> > -             .event = "umask=0x20,period=200000,event=0x9",
> > +             .event = "event=0x9,period=200000,umask=0x20",
> >               .desc = "Memory cluster signals to block micro-op dispatch for any reason",
> >               .topic = "other",
> >       },
> > -     .alias_str = "umask=0x20,period=0x30d40,event=0x9",
> > +     .alias_str = "event=0x9,period=0x30d40,umask=0x20",
> >       .alias_long_desc = "Memory cluster signals to block micro-op dispatch for any reason",
> >   };
> >
> >   static const struct perf_pmu_test_event eist_trans = {
> >       .event = {
> >               .name = "eist_trans",
> > -             .event = "umask=0x0,period=200000,event=0x3a",
> > +             .event = "event=0x3a,period=200000,umask=0x0",
> >               .desc = "Number of Enhanced Intel SpeedStep(R) Technology (EIST) transitions",
> >               .topic = "other",
> >       },
> > -     .alias_str = "umask=0,period=0x30d40,event=0x3a",
> > +     .alias_str = "event=0x3a,period=0x30d40,umask=0",
> >       .alias_long_desc = "Number of Enhanced Intel SpeedStep(R) Technology (EIST) transitions",
> >   };
> >
> > @@ -132,13 +132,13 @@ static const struct perf_pmu_test_event uncore_hisi_ddrc_flux_wcmd = {
> >   static const struct perf_pmu_test_event unc_cbo_xsnp_response_miss_eviction = {
> >       .event = {
> >               .name = "unc_cbo_xsnp_response.miss_eviction",
> > -             .event = "umask=0x81,event=0x22",
> > +             .event = "event=0x22,umask=0x81",
> >               .desc = "A cross-core snoop resulted from L3 Eviction which misses in some processor core. Unit: uncore_cbox ",
> >               .topic = "uncore",
> >               .long_desc = "A cross-core snoop resulted from L3 Eviction which misses in some processor core",
> >               .pmu = "uncore_cbox",
> >       },
> > -     .alias_str = "umask=0x81,event=0x22",
> > +     .alias_str = "event=0x22,umask=0x81",
> >       .alias_long_desc = "A cross-core snoop resulted from L3 Eviction which misses in some processor core",
> >       .matching_pmu = "uncore_cbox_0",
> >   };
> > @@ -146,13 +146,13 @@ static const struct perf_pmu_test_event unc_cbo_xsnp_response_miss_eviction = {
> >   static const struct perf_pmu_test_event uncore_hyphen = {
> >       .event = {
> >               .name = "event-hyphen",
> > -             .event = "umask=0x00,event=0xe0",
> > +             .event = "event=0xe0,umask=0x00",
> >               .desc = "UNC_CBO_HYPHEN. Unit: uncore_cbox ",
> >               .topic = "uncore",
> >               .long_desc = "UNC_CBO_HYPHEN",
> >               .pmu = "uncore_cbox",
> >       },
> > -     .alias_str = "umask=0,event=0xe0",
> > +     .alias_str = "event=0xe0,umask=0",
> >       .alias_long_desc = "UNC_CBO_HYPHEN",
> >       .matching_pmu = "uncore_cbox_0",
> >   };
> > @@ -160,13 +160,13 @@ static const struct perf_pmu_test_event uncore_hyphen = {
> >   static const struct perf_pmu_test_event uncore_two_hyph = {
> >       .event = {
> >               .name = "event-two-hyph",
> > -             .event = "umask=0x00,event=0xc0",
> > +             .event = "event=0xc0,umask=0x00",
> >               .desc = "UNC_CBO_TWO_HYPH. Unit: uncore_cbox ",
> >               .topic = "uncore",
> >               .long_desc = "UNC_CBO_TWO_HYPH",
> >               .pmu = "uncore_cbox",
> >       },
> > -     .alias_str = "umask=0,event=0xc0",
> > +     .alias_str = "event=0xc0,umask=0",
> >       .alias_long_desc = "UNC_CBO_TWO_HYPH",
> >       .matching_pmu = "uncore_cbox_0",
> >   };
>
> --
> Zhengjun Xing
