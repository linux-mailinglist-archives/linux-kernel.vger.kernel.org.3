Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA1A5B10A4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 01:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbiIGXsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 19:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiIGXsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 19:48:01 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E9CA7ABD;
        Wed,  7 Sep 2022 16:48:01 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-127dca21a7dso12746242fac.12;
        Wed, 07 Sep 2022 16:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date;
        bh=w1jsb9wOLkTivNg7H4Hec7LMmj4ViVYdB0XbI1tSz6Q=;
        b=YRQVcKMby3Lds4fI1dduM5cnu84BBJmqE+V/8aoNSsKHyJUvL3NSmRNZktPhQk1CA+
         1rhFzop7CfNMnPjf8jsb0zQIkyYvQyZa2aQ7Jz7a3VLwGyzXl2/VDk1QKwu1JrCrCuTJ
         R1HdxuEGGk1/2j508/saF+5jSg+UEy2yZv6cEnVImDYJvHx7sg0wm6ewRqWBzpZ+hAmO
         nwzixxJ7JxIvI7qI1RVAI66UKySJJPJP2/cK+yeUwDYCYxotEyZ4gaXyTgm09VbKI3Nq
         CkxlP61i7lOgiMmUppwzNFw/Jw/UIYW/KfBualPJ1UbCWKQVvlVwVw5JPsEbPV0Wq0Yw
         Ugtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=w1jsb9wOLkTivNg7H4Hec7LMmj4ViVYdB0XbI1tSz6Q=;
        b=P9b8u0IdN4c8xH9GxNBvZX5KKpsj3972dzV9QMhrUEnQiZTSRHHONFLKP24rk06diC
         3o9gGPTWuJk32ZyqHhJ9pvVecgZJVS6UoHrEfwhOXVDeMxkR5Mua7IMymrlE6UnKdiR0
         pDJdvCubuSGupWjXaaZ1IE8UJ1Db5vXShifoOAWNNZ496x9JSSCPFSr22dfMB0iFm3O4
         dvzgeljtO5mpZzAHXJ7bKcoCoaaNK158iyfAwU7n6aVpXl8sDC9hooGDCm1LGHb1rxt7
         UUfAITJSrevB9seBeN4mVAFxhPEUV19Li/FDjZ76KG97DY/e2y99FoS+y8uuJDRdBRYi
         NPvg==
X-Gm-Message-State: ACgBeo0p5usGW+pActuYNbrCh57zATfFyu0gyE2Ws/N/Yjwdb6REAvA+
        iBwTfMH1azzRN+X9nfc4ghM=
X-Google-Smtp-Source: AA6agR6aDYxIORrlxVEIh/LKtjt+J4FbgrE3PqkkkgAjnjOoRvsRESt4PhxUQGT51MezedGJdeypDg==
X-Received: by 2002:aca:2109:0:b0:345:7ad9:dbb5 with SMTP id 9-20020aca2109000000b003457ad9dbb5mr370923oiz.66.1662594480279;
        Wed, 07 Sep 2022 16:48:00 -0700 (PDT)
Received: from [127.0.0.1] ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id w62-20020acaad41000000b0034516ca90dcsm6943533oie.23.2022.09.07.16.47.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Sep 2022 16:47:59 -0700 (PDT)
Date:   Wed, 07 Sep 2022 20:47:52 -0300
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
To:     Ian Rogers <irogers@google.com>, Jiri Olsa <olsajiri@gmail.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
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
User-Agent: K-9 Mail for Android
In-Reply-To: <CAP-5=fWVN4Fig5GEwyWwwUc9_iZyZ5rObTFkyNcuFp1GApy4tg@mail.gmail.com>
References: <20220614143353.1559597-1-irogers@google.com> <20220614143353.1559597-7-irogers@google.com> <YuZ4CEnken8U4HO5@krava> <CAP-5=fVczMiasS15UovH8kzOaNw=TC_adeqjC+xBzv8jVJ3DTQ@mail.gmail.com> <CAP-5=fWVN4Fig5GEwyWwwUc9_iZyZ5rObTFkyNcuFp1GApy4tg@mail.gmail.com>
Message-ID: <9B5AEBE0-D000-4D58-94BA-85153C5CD66F@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On September 7, 2022 7:41:19 PM GMT-03:00, Ian Rogers <irogers@google=2Eco=
m> wrote:
>On Thu, Aug 4, 2022 at 12:30 PM Ian Rogers <irogers@google=2Ecom> wrote:
>>
>> On Sun, Jul 31, 2022 at 5:39 AM Jiri Olsa <olsajiri@gmail=2Ecom> wrote:
>> >
>> > On Tue, Jun 14, 2022 at 07:33:53AM -0700, Ian Rogers wrote:
>> >
>> > SNIP
>> >
>> > > +     event =3D cpu_map_data__alloc(&syn_data, sizeof(struct perf_e=
vent_header));
>> > >       if (!event)
>> > >               return NULL;
>> > >
>> > > +     syn_data=2Edata =3D &event->data;
>> > >       event->header=2Etype =3D PERF_RECORD_CPU_MAP;
>> > > -     event->header=2Esize =3D size;
>> > > -     event->data=2Etype   =3D type;
>> > > -
>> > > -     cpu_map_data__synthesize(&event->data, map, type, max);
>> > > +     event->header=2Esize =3D syn_data=2Esize;
>> > > +     cpu_map_data__synthesize(&syn_data);
>> > >       return event;
>> > >  }
>> > >
>> > > +
>> > >  int perf_event__synthesize_cpu_map(struct perf_tool *tool,
>> > >                                  const struct perf_cpu_map *map,
>> > >                                  perf_event__handler_t process,
>> > > @@ -1891,24 +1894,20 @@ int perf_event__synthesize_event_update_nam=
e(struct perf_tool *tool, struct evse
>> > >  int perf_event__synthesize_event_update_cpus(struct perf_tool *too=
l, struct evsel *evsel,
>> > >                                            perf_event__handler_t pr=
ocess)
>> > >  {
>> > > -     size_t size =3D sizeof(struct perf_event_header) + sizeof(u64=
) + sizeof(u64);
>> > > +     struct synthesize_cpu_map_data syn_data =3D { =2Emap =3D evse=
l->core=2Eown_cpus };
>> > >       struct perf_record_event_update *ev;
>> > > -     int max, err;
>> > > -     u16 type;
>> > > -
>> > > -     if (!evsel->core=2Eown_cpus)
>> > > -             return 0;
>> >
>> > all seems fine, just looks like we no longer do this check,
>> > might not be needed anymore, as that changed in past
>>
>> This function is called in a test and in this file=2E The caller alread=
y
>> does this test and so the check is redundant plus a little confusing:
>> https://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/acme/linux=2Egit/tr=
ee/tools/perf/util/synthetic-events=2Ec?h=3Dperf/core#n2062
>> As you say, it wasn't needed any more and so I removed it=2E
>>
>> Thanks,
>> Ian
>
>Would be nice to land this imo=2E Anything outstanding?

I'll check first hour tomorrow, today was a holiday down here=2E

- Arnaldo

>
>Thanks,
>Ian
>
>> > thanks,
>> > jirka
>> >
>> > > +     int err;
>> > >
>> > > -     ev =3D cpu_map_data__alloc(evsel->core=2Eown_cpus, &size, &ty=
pe, &max);
>> > > +     ev =3D cpu_map_data__alloc(&syn_data, sizeof(struct perf_even=
t_header) + 2 * sizeof(u64));
>> > >       if (!ev)
>> > >               return -ENOMEM;
>> > >
>> > > +     syn_data=2Edata =3D &ev->cpus=2Ecpus;
>> > >       ev->header=2Etype =3D PERF_RECORD_EVENT_UPDATE;
>> > > -     ev->header=2Esize =3D (u16)size;
>> > > +     ev->header=2Esize =3D (u16)syn_data=2Esize;
>> > >       ev->type        =3D PERF_EVENT_UPDATE__CPUS;
>> > >       ev->id          =3D evsel->core=2Eid[0];
>> > > -
>> > > -     cpu_map_data__synthesize(&ev->cpus=2Ecpus, evsel->core=2Eown_=
cpus, type, max);
>> > > +     cpu_map_data__synthesize(&syn_data);
>> > >
>> > >       err =3D process(tool, (union perf_event *)ev, NULL, NULL);
>> > >       free(ev);
>> > > --
>> > > 2=2E36=2E1=2E476=2Eg0c4daa206d-goog
>> > >
