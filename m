Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B73925AF66B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 22:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbiIFU5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 16:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbiIFU4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 16:56:48 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD8399247;
        Tue,  6 Sep 2022 13:56:45 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-127dca21a7dso3942602fac.12;
        Tue, 06 Sep 2022 13:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date;
        bh=JLKbHHTVrfhdQxKJcLepz8hjtNrJiGDZhh85/uIQM0Q=;
        b=I7Jn10IrZ3Kl5W47zzd+T28Pm+YKxVY0TzhwWFXt8BajHUReYryLrAEr1mjjxEDy7w
         DTpei9wXbmLYYkesYjGslbe/+5znIlaGIALl9Q5OM6GCofsJJBcF8JTJR54agGL4k01k
         JTZqxX0YBTYyMvSj+svEkErrrprgkhBQE/7zB/a4N0YI84sNwAkYUUYKRocqN+FYawns
         /Xh9TsoVx5fE8OlGuSD/I1dD6ba7B2WVPem5bsbdhQ+hjmfjEZ5qgnDL5ApzHwpyNEW+
         TwzwZpo2g6m8CxPIzEmkqEq6oJNaPz3W9PouzLVl4pfULNqTjBdy2RaNhSinU5qYmRyR
         LcYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=JLKbHHTVrfhdQxKJcLepz8hjtNrJiGDZhh85/uIQM0Q=;
        b=HbsBKy/J1cEzPlRfOUbelba4tb9+QkaaeUP0c6fx3QIQASqOMfTlILEf5W2LQtGb9h
         i5eoDu/9vACNVQS9n6uXvklGVxZdpdRxwWvfejk8p1eyfklrBaVugwYmCfW28vg232iW
         VHlamVytqvBA6veaB+Eaevr64MpLEPYId1nudVA8IIY0IPNJKe9VnybFIORUy959TV06
         rgTjVAykeyOdKpbuIAxjJbf/l5WMYHp6z+afR5bWBbO+N6GC5faoskAfxxBhXhvEbuVf
         kKyzRjJKcaXAeHQK7jP2ARwVF3I/986/JiplRUx7WyAOI+zXRbRAQ5iEA5g1YLOmr3yj
         R8IA==
X-Gm-Message-State: ACgBeo0G0EV7k/qDi4crwePA5A1UZjo0PAWKb/DmqpfprIijxLQqp4FO
        CaM8hklOLFQbhIlYb8TeOwailUEGJ/g=
X-Google-Smtp-Source: AA6agR5UJZ5K0bvXhuNUQdD3brO0ZbixHxxcymP6/oBLCK1I7qbhwn9+76sWUFaCU3Y/6DN0zWDmbw==
X-Received: by 2002:a05:6870:59d:b0:f3:627:e2b0 with SMTP id m29-20020a056870059d00b000f30627e2b0mr79456oap.47.1662497804367;
        Tue, 06 Sep 2022 13:56:44 -0700 (PDT)
Received: from [127.0.0.1] ([187.19.239.21])
        by smtp.gmail.com with ESMTPSA id d8-20020a056870e24800b0011e4c574dfcsm7606906oac.40.2022.09.06.13.56.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Sep 2022 13:56:43 -0700 (PDT)
Date:   Tue, 06 Sep 2022 17:56:37 -0300
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
To:     Marco Elver <elver@google.com>, Namhyung Kim <namhyung@kernel.org>
CC:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>
Subject: Re: [PATCH] perf test: Skip sigtrap test on old kernels
User-Agent: K-9 Mail for Android
In-Reply-To: <CANpmjNMHX2S-29Tyw+zKyaWT7saAiEegxbJapQFs7duJTTncdw@mail.gmail.com>
References: <20220903000210.1112014-1-namhyung@kernel.org> <CANpmjNMPh5QjdxXtrCc5FApjgzV=81CNNiwbeg_rE3NxN_WCZw@mail.gmail.com> <YxdA1CVzy9hzE3i1@kernel.org> <CAM9d7ci2ZujdY75DUtZA+f=fru7yh8VJrj8-r2RgZetu57u61A@mail.gmail.com> <CANpmjNMHX2S-29Tyw+zKyaWT7saAiEegxbJapQFs7duJTTncdw@mail.gmail.com>
Message-ID: <F172EC4B-1CFC-46A5-9DC3-146EDF8F5BDF@gmail.com>
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



On September 6, 2022 5:50:05 PM GMT-03:00, Marco Elver <elver@google=2Ecom=
> wrote:
>On Tue, 6 Sept 2022 at 20:31, Namhyung Kim <namhyung@kernel=2Eorg> wrote:
>>
>> On Tue, Sep 6, 2022 at 5:45 AM Arnaldo Carvalho de Melo <acme@kernel=2E=
org> wrote:
>> >
>> > Em Sat, Sep 03, 2022 at 08:52:01AM +0200, Marco Elver escreveu:
>> > > On Sat, 3 Sept 2022 at 02:02, Namhyung Kim <namhyung@kernel=2Eorg> =
wrote:
>> > > >
>> > > > If it runs on an old kernel, perf_event_open would fail because o=
f the
>> > > > new fields sigtrap and sig_data=2E  Just skip the test if it fail=
ed=2E
>> > > >
>> > > > Cc: Marco Elver <elver@google=2Ecom>
>> > > > Signed-off-by: Namhyung Kim <namhyung@kernel=2Eorg>
>> > > > ---
>> > > >  tools/perf/tests/sigtrap=2Ec | 1 +
>> > > >  1 file changed, 1 insertion(+)
>> > > >
>> > > > diff --git a/tools/perf/tests/sigtrap=2Ec b/tools/perf/tests/sigt=
rap=2Ec
>> > > > index e32ece90e164=2E=2E7057566e6ae4 100644
>> > > > --- a/tools/perf/tests/sigtrap=2Ec
>> > > > +++ b/tools/perf/tests/sigtrap=2Ec
>> > > > @@ -140,6 +140,7 @@ static int test__sigtrap(struct test_suite *t=
est __maybe_unused, int subtest __m
>> > > >         fd =3D sys_perf_event_open(&attr, 0, -1, -1, perf_event_o=
pen_cloexec_flag());
>> > > >         if (fd < 0) {
>> > > >                 pr_debug("FAILED sys_perf_event_open(): %s\n", st=
r_error_r(errno, sbuf, sizeof(sbuf)));
>> > > > +               ret =3D TEST_SKIP;
>> > >
>> > > Wouldn't we be interested if perf_event_open() fails because it cou=
ld
>> > > actually be a bug? By skipping we'll be more likely to miss the fac=
t
>> > > there's a real problem=2E
>> > >
>> > > That's my naive thinking at least - what do other perf tests usuall=
y
>> > > do in this case?
>> >
>> > Yeah, I was going to try and check if this is the only way that, with
>> > the given arguments, perf_event_open would fail, but its better to at
>> > least check errno against -EINVAL or something?
>>
>> EINVAL would be too generic and the kernel returns it in many places=2E
>> I really wish we could have a better error reporting mechanism=2E
>>
>> Maybe we could retry perf_event_open with sigtrap and sig_data cleared=
=2E
>> If it succeeded, then we can skip the test=2E  If it still failed, then=
 report
>> the error=2E  But it still couldn't find a bug in the sigtrap code=2E
>> What do you think?
>
>Yes, that's what I meant, that it could point out an issue with
>sigtrap perf_event_open()=2E
>
>If there's no clear way to determine if it's just not supported or a
>bug, it'd be better to leave it as-is=2E

perf could go fancy and try to add a probe using a source file+line where =
older kernels would fail 8-)

Anyway, perf already does all sorts of kernel capability checks, perhaps t=
his is one of can for sure detect it's something available :-/

One new way could be to look at BTF?

>
>Some other options:
>
>1=2E Provide a way to disable certain tests, if it's known they will
>fail for otherwise benign reasons i=2Ee=2E no support=2E
>
>2=2E Provide a command line option to skip instead of fail tests where
>perf_event_open() returns some particular errnos=2E The default will be
>fail, but you can then choose to trust that failure of
>perf_event_open() means no support, and pass the option=2E
