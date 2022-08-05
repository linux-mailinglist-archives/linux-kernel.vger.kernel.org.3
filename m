Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 455CA58B0B8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 22:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241492AbiHEUFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 16:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241135AbiHEUFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 16:05:35 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FA7313F03
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 13:05:33 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id v3so4432735wrp.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 13:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=PM5hUhADUoMwtalBw6Eig07GWVzUbmCd+8RcHTozsME=;
        b=G3AUWOo7R4sI30YxZCszf3HdxZPYzpBkHVbil2oiiHw2KM841TWltwgfAvCUtWCWVZ
         HNZQALs1bnrgvq1NAGSmb8l7bFFuOjZH4lTaTrH0joKhDfePXAdk5r0V59DYlMfhqiyj
         JQQ0xoHac972J9WiA41+wJherDBW5kBbq+uCs/WZIwndAsQQcy9EMa467qic47CB4YUo
         SLYCIPEEDMn4ldKCIVGzsolR23tD9ngxQhK36PeGBxM9OrGu2oNQn6K24iKGpWevp15b
         nLgOCPnYTjsezw6g2SQTCry+5NgYuEk6RUMts28iF2xgPf8d7/sinn3h2JyQBJuuc288
         3Iog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=PM5hUhADUoMwtalBw6Eig07GWVzUbmCd+8RcHTozsME=;
        b=QclTi93c2OdELGdtQbJxvraQ8zBrYjZsb2pjmbKYVjI7KypbIIds+zDCQRB1VgA7NT
         b9jYBytmW01z/VvLowOZWj/hJEh1q6ReU60mgEXVc6+sEV8nsORmaTvmMi5lDkR4DQeH
         gHuN85YTMqU33ZWYLLOvY9ZUWo4K9GhH8cA3pfV4AwAyeXnTXVEqgMHVhMwmTYwZ75eQ
         xui5pPPCqofmwz8fHRw/7VwNfacNYN/ynZRfMZO0E54nIU467tBG/budT4mLJogqic0D
         FtkSEcCwgg5G0EdIp2heSLLIuLRVrUaGZwGwBLMLCz/9VOXALMkYD+qn0Z3N9Lu59CpL
         Il/Q==
X-Gm-Message-State: ACgBeo2NyanCx0bjrNEIm4Qv/aFcV60c42ZQ4uyRsU5nPL0K4ul/iW7n
        cT+xmHERybAcI6tujKyH5oQXvNDbZ27zHcy2HzDwKw==
X-Google-Smtp-Source: AA6agR7SS6qapQgkXkP+3I/5oFJ+D3/f0jnKPqksUgSrgL++y9AhvlzQBDkRbQWjMWYakO+6G6sNFyt4Do74V13oCaQ=
X-Received: by 2002:a5d:6d4e:0:b0:21e:660e:55bf with SMTP id
 k14-20020a5d6d4e000000b0021e660e55bfmr4924028wri.343.1659729931853; Fri, 05
 Aug 2022 13:05:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220707201213.331663-1-irogers@google.com> <20220707201213.331663-3-irogers@google.com>
 <YtV/+yRsA9SJuntp@kernel.org> <YtWAQqXFp98+N9ej@kernel.org> <YtWBBSHK2hAtykro@kernel.org>
In-Reply-To: <YtWBBSHK2hAtykro@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 5 Aug 2022 13:05:19 -0700
Message-ID: <CAP-5=fXX3wAddCw1+e8hsnqOexs20L3=7b1A=izK45bmhnUHWg@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] perf test: Json format checking
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Sandipan Das <sandipan.das@amd.com>,
        Claire Jensen <cjense@google.com>, Alyssa Ross <hi@alyssa.is>,
        Like Xu <likexu@tencent.com>,
        James Clark <james.clark@arm.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Claire Jensen <clairej735@gmail.com>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, Jul 18, 2022 at 8:49 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Mon, Jul 18, 2022 at 12:46:10PM -0300, Arnaldo Carvalho de Melo escrev=
eu:
> > Em Mon, Jul 18, 2022 at 12:44:59PM -0300, Arnaldo Carvalho de Melo escr=
eveu:
> > > Em Thu, Jul 07, 2022 at 01:12:13PM -0700, Ian Rogers escreveu:
> > > > From: Claire Jensen <cjense@google.com>
> > > >
> > > > Add field checking tests for perf stat JSON output.
> > > > Sanity checks the expected number of fields are present, that the
> > > > expected keys are present and they have the correct values.
> > >
> > > it isn't installing the lib:
> > >
> > > [root@five ~]# perf test -v json
> > >  91: perf stat JSON output linter                                    =
:
> > > --- start ---
> > > test child forked, pid 4086678
> > > Checking json output: no args python3: can't open file '/var/home/acm=
e/libexec/perf-core/tests/shell/lib/perf_json_output_lint.py': [Errno 2] No=
 such file or directory
> > > test child finished with -2
> > > ---- end ----
> > > perf stat JSON output linter: Skip
> > > [root@five ~]#
> > >
> > > I'm trying to fix, but please test it after installing...
> >
> >
> > It should:
> >
> > install-tests: all install-gtk
> >         $(call QUIET_INSTALL, tests) \
> >                 $(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_S=
Q)/tests'; \
> >                 $(INSTALL) tests/attr.py '$(DESTDIR_SQ)$(perfexec_instd=
ir_SQ)/tests'; \
> >                 $(INSTALL) tests/pe-file.exe* '$(DESTDIR_SQ)$(perfexec_=
instdir_SQ)/tests'; \
> >                 $(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_S=
Q)/tests/attr'; \
> >                 $(INSTALL) tests/attr/* '$(DESTDIR_SQ)$(perfexec_instdi=
r_SQ)/tests/attr'; \
> >                 $(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_S=
Q)/tests/shell'; \
> >                 $(INSTALL) tests/shell/*.sh '$(DESTDIR_SQ)$(perfexec_in=
stdir_SQ)/tests/shell'; \
> >                 $(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_S=
Q)/tests/shell/lib'; \
> >                 $(INSTALL) tests/shell/lib/*.sh '$(DESTDIR_SQ)$(perfexe=
c_instdir_SQ)/tests/shell/lib'
> >
> > /me checking...
>
> The patch below is needed, but then should we mix .py and .sh in that
> directory?
>
> =E2=AC=A2[acme@toolbox perf]$ git diff
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index 8f0b1fb39984fb7b..65e5ba767fd6210e 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -1006,6 +1006,7 @@ install-tests: all install-gtk
>                 $(INSTALL) tests/shell/*.sh '$(DESTDIR_SQ)$(perfexec_inst=
dir_SQ)/tests/shell'; \
>                 $(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)=
/tests/shell/lib'; \
>                 $(INSTALL) tests/shell/lib/*.sh '$(DESTDIR_SQ)$(perfexec_=
instdir_SQ)/tests/shell/lib'
> +               $(INSTALL) tests/shell/lib/*.py '$(DESTDIR_SQ)$(perfexec_=
instdir_SQ)/tests/shell/lib'
>
>  install-bin: install-tools install-tests install-traceevent-plugins
>
> =E2=AC=A2[acme@toolbox perf]$
>
> And then, after that I'm getting:
>
> [root@five ~]# perf test json
>  91: perf stat JSON output linter                                    : FA=
ILED!
> [root@five ~]# perf test -v json |& tail -20
> {"core" : "S0-D0-C15", "aggregate-number" : 2, "counter-value" : "2675.00=
0000", "unit" : "", "event" : "stalled-cycles-backend", "event-runtime" : 2=
864158, "pcnt-running" : 100.00, "metric-value" : 0.341252, "metric-unit" :=
 "backend cycles idle"}
>
> {"core" : "S0-D0-C15", "aggregate-number" : 2, "counter-value" : "233533.=
000000", "unit" : "", "event" : "instructions", "event-runtime" : 2865528, =
"pcnt-running" : 100.00, "metric-value" : 0.297920, "metric-unit" : "insn p=
er cycle"}
>
> {"core" : "S0-D0-C15", "aggregate-number" : 2, "metric-value" : 0.192975,=
 "metric-unit" : "stalled cycles per insn"}
>
> {"core" : "S0-D0-C15", "aggregate-number" : 2, "counter-value" : "50214.0=
00000", "unit" : "", "event" : "branches", "event-runtime" : 2865638, "pcnt=
-running" : 100.00, "metric-value" : 17.295742, "metric-unit" : "M/sec"}
>
> {"core" : "S0-D0-C15", "aggregate-number" : 2, "counter-value" : "1513.00=
0000", "unit" : "", "event" : "branch-misses", "event-runtime" : 1564989, "=
pcnt-running" : 54.00, "metric-value" : 3.013104, "metric-unit" : "of all b=
ranches"}
>
> Traceback (most recent call last):
>   File "/var/home/acme/libexec/perf-core/tests/shell/lib/perf_json_output=
_lint.py", line 92, in <module>
>     check_json_output(expected_items)
>   File "/var/home/acme/libexec/perf-core/tests/shell/lib/perf_json_output=
_lint.py", line 53, in check_json_output
>     raise RuntimeError(f'wrong number of fields. counted {count} expected=
 {expected_items}'
> RuntimeError: wrong number of fields. counted 3 expected 8 in '{"core" : =
"S0-D0-C0", "aggregate-number" : 2, "metric-value" : 0.094345, "metric-unit=
" : "stalled cycles per insn"}
> '
> test child finished with -1
> ---- end ----
> perf stat JSON output linter: FAILED!
> [root@five ~]#
>
> Can you please check and send a v7?

Done. Sorry for the delay:
https://lore.kernel.org/lkml/20220805200105.2020995-1-irogers@google.com/

Thanks,
Ian

> - Arnaldo
