Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83EBD4B8BC1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 15:45:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235191AbiBPOpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 09:45:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232255AbiBPOpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 09:45:17 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A554E2A64FD;
        Wed, 16 Feb 2022 06:45:01 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id m7so2630406pjk.0;
        Wed, 16 Feb 2022 06:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1F66TZRHixBJhWJDA1wqf0MkGIRq2glJtxmL3Bgsx8k=;
        b=VNKUhwcIPHPpNKDnAMkX/UB7NiQyH5rb6TujlDZg2KwAQzFUWWNg4Ol1I50Fx4y9ec
         4o2XBQleC1mbIRwQy2G9w4fl2F0pmqyntG1UcXniAQa4LMWDWCd4tiiRP5dpqBhDY+P7
         Fukx2G2pKsNDKrcuWSPCcDsF79ot1Kd1MLXjFk0kYIZMcJsDW1ikYs25s75MEU/5ga5/
         IKX0rjCc91lM69+BDwGkt+KYp3kdpJ/e+pQPIR7Ced9Fjl2GbQEqWFz4sTApwjtiMbVI
         V6mZIUqb7TmfS+OX0++bUsvK/3QLSWG99yAKLb1MedNrn0gNiHk/81B9LaW2pgLpdSyt
         funA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1F66TZRHixBJhWJDA1wqf0MkGIRq2glJtxmL3Bgsx8k=;
        b=tckDeOvgsOQtrOMHryfT3f0KFiCTcO7UFSPhe9E/SRewqpZzh7qA9ARhD08B7I0rkG
         D7BHY/dlbAO3qoEDCF8OLPnWR5ZCfQuKYuJU+QADb94j1DeQ11oWeJkbepzD+4DZzHcX
         sVDjNN2yj3Dnt3PT5T6AwZf2BWvUKITyN8fA/uzlDNfX4AUaF0wQbPtcSI3qE1XGCzM3
         0Hx+/0xqpLl+J5aUWuI6025bNdktMmEY0DQGyDlSSc2lk0YMODKDewARCB/bq/908jX4
         EoLMx+ckNKMuktTik0E0X4+IUIUGcv+/A5/UfQMCLFLXVpCUBMo96BvZIcGYIRrISkZM
         GyEA==
X-Gm-Message-State: AOAM530Umsj8lO7bI55n7cjAVEjLgkwKdlEOu5TIPIL/HUCEwRo5XwVi
        488ygnHGCfElAOhQnM3RUkERsnWnunYrI4EoNdo=
X-Google-Smtp-Source: ABdhPJyU2NC32cj/tCH25+OOO7OrOvS2Ym7r7gjiIxQqph2k4MWMAGhPY7zjmOx4M0GNSHpq7y8e7ahusianuY4kOcQ=
X-Received: by 2002:a17:90a:b10a:b0:1bb:82a7:5d69 with SMTP id
 z10-20020a17090ab10a00b001bb82a75d69mr2113166pjq.111.1645022701114; Wed, 16
 Feb 2022 06:45:01 -0800 (PST)
MIME-Version: 1.0
References: <20220210085225.551891-1-tz.stoyanov@gmail.com>
 <YguaF9kmFyoZ1ZhC@krava> <Yg0CBc4gEQDX4/WD@kernel.org>
In-Reply-To: <Yg0CBc4gEQDX4/WD@kernel.org>
From:   Tzvetomir Stoyanov <tz.stoyanov@gmail.com>
Date:   Wed, 16 Feb 2022 16:44:44 +0200
Message-ID: <CAPpZLN56Ew2AvKk6kC-B6sQPAE+JRsnXRPkfWxSEBiR-JdzSHA@mail.gmail.com>
Subject: Re: [PATCH] libperf: Add API for allocating new thread map
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Jiri Olsa <olsajiri@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

On Wed, Feb 16, 2022 at 3:54 PM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> Em Tue, Feb 15, 2022 at 01:18:31PM +0100, Jiri Olsa escreveu:
> > On Thu, Feb 10, 2022 at 10:52:25AM +0200, Tzvetomir Stoyanov (VMware) w=
rote:
> > > The existing API perf_thread_map__new_dummy() allocates new thread ma=
p
> > > for one thread. I couldn't find a way to reallocate the map with more
> > > threads, or to allocate a new map for more than one thread. Having
> > > multiple threads in a thread map is essential for some use cases.
> > > That's why a new API is proposed, which allocates a new thread map
> > > for given number of threads:
> > >  perf_thread_map__new()
> >
> > I'm ok with that, just wondering if we should call it 'perf_thread_map_=
_new_nr'
> > because we already have perf_cpu_map__new(const char *cpu_list) so
> > it might be better to keep perf_cpu_map and perf_thread_map in sync
>
> > Arnaldo, thoughts on this?
>
> Agreed on trying to have similar semantics for the default, main
> constructor, so we probably need perf_thread_map__new(const char *thread_=
list).
>
> In tools/perf/util/thread_map.c, from where tools/lib/threadmap.c came
> from we have many alternative constructors:
>
> =E2=AC=A2[acme@toolbox perf]$ grep 'struct perf_thread_map \*thread_map__=
new' tools/perf/util/thread_map.c
> struct perf_thread_map *thread_map__new_by_pid(pid_t pid)
> struct perf_thread_map *thread_map__new_by_tid(pid_t tid)
> struct perf_thread_map *thread_map__new_all_cpus(void)
> struct perf_thread_map *thread_map__new_by_uid(uid_t uid)
> struct perf_thread_map *thread_map__new(pid_t pid, pid_t tid, uid_t uid)
> static struct perf_thread_map *thread_map__new_by_pid_str(const char *pid=
_str)
> struct perf_thread_map *thread_map__new_by_tid_str(const char *tid_str)
> struct perf_thread_map *thread_map__new_str(const char *pid, const char *=
tid,
> struct perf_thread_map *thread_map__new_event(struct perf_record_thread_m=
ap *event)
> =E2=AC=A2[acme@toolbox perf]$
>
> The one you want is almost:
>
>         thread_map__new_by_tid_str(const char *tid_str)
>
> but perhaps it would be better to have:
>
> struct perf_thread_map *thread_map__new_array(int nr_threads, pid_t *arra=
y);

I like the idea, this API is flexible enough for most of the use
cases. I'll submit the next version of the patch with this
implementation.

>
> But yeah, if your logic needs to first allocate space for the thread_map
> and then populate it, make it so that array =3D=3D NULL is supported for
> that case, then thread_map__new_array() will not touch it and set
> everything to -1, to be populated later using perf_thread_map__set_pid().
>
> With that thread_map__new_by_tid_str() could be reimplemented as a
> wrapper around thread_map__new_array(). :-)
>
> While we're on this, shouldn't we rename 'thread' in
> tools/lib/perf/include/perf/threadmap.h and threadmap.c to be 'idx' to
> avoid confusion?

You mean the input parameter "int thread", in these APIs ?
  perf_thread_map__set_pid()
  perf_thread_map__comm()
  perf_thread_map__pid()
It makes sense to me, as this is the index in the thread map. I can
submit a separate patch with this renaming.

>
> - Arnaldo
>
> > jirka

Thanks!

[ ... ]


--=20
Tzvetomir (Ceco) Stoyanov
VMware Open Source Technology Center
