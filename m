Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 879F655A052
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 20:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbiFXRbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 13:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbiFXRbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 13:31:10 -0400
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D322F64D
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 10:31:09 -0700 (PDT)
Received: by mail-oi1-f169.google.com with SMTP id e131so4375974oif.13
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 10:31:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CynFqUJ9uA3lR6FKHcs/aiiOSzQMnn/sAq5ba4a97jU=;
        b=WE+eW38w19GpJvs2IK4vwi36dCn7Jei7mgLTjTYbxeXoi5/0+IrcMTmYwwO/gPAjdp
         v3TYJzLbZF62cX2C424lZeDTlmIHps3UizILlBz616lqGYvHZKp5RTwDJbhOoiqUFqnz
         8Xa4emdo9aMHKS/yG6Tv4P6y/fynjoQ0TxVEsjnOsK6DFIboYE1L67g+kv2PwCdu4KAw
         pqhTO53N1bOOpCAp6nw+vyo50u+XPbXipMYAQFKIv0hA2odySdde/qwblSuXK5Vo0l8+
         ++Bwf33hLTJNui2i9feS196SS7liAKprLGKybo9WmGcqBytscjCGxWjHEG+pmgzYsaiZ
         /uCA==
X-Gm-Message-State: AJIora8T3Kj4Nvuf2Q18VNj9BiRkuqkCvOzSCej5jguhGaRiDW2HfGwx
        iu1feWsamut2CwLu/VZVDcGbBUjtq6h+K42SB4eR2POoncQ=
X-Google-Smtp-Source: AGRyM1sIH5vqb/GJyyR0NIaXxydurP749RlKNQgIPWsQjsGooT4qtdVx2OcMhadRFeoc0jYps7HJptFNfCuWrRnqDic=
X-Received: by 2002:aca:bb56:0:b0:32f:2160:bfd8 with SMTP id
 l83-20020acabb56000000b0032f2160bfd8mr123209oif.92.1656091868834; Fri, 24 Jun
 2022 10:31:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220602224754.602074-1-namhyung@kernel.org> <YpojK0iaPofkAzd4@google.com>
In-Reply-To: <YpojK0iaPofkAzd4@google.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 24 Jun 2022 10:30:57 -0700
Message-ID: <CAM9d7cjGiBEW0jfoc6iaXnHGhvQZVM-aRke=kdgJEbfSPAt+ug@mail.gmail.com>
Subject: Re: [PATCH] perf/core: Call LSM hook after copying perf_event_attr
To:     Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        James Morris <jmorris@namei.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Fri, Jun 3, 2022 at 8:05 AM Joel Fernandes <joel@joelfernandes.org> wrote:
>
> On Thu, Jun 02, 2022 at 03:47:54PM -0700, Namhyung Kim wrote:
> > It passes the attr struct to the security_perf_event_open() but it's
> > not initialized yet.
> >
> > Fixes: da97e18458fb ("perf_event: Add support for LSM and SELinux checks")
> > Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  kernel/events/core.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > index 7858bafffa9d..e035545f624f 100644
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -12033,12 +12033,12 @@ SYSCALL_DEFINE5(perf_event_open,
> >       if (flags & ~PERF_FLAG_ALL)
> >               return -EINVAL;
> >
> > -     /* Do we allow access to perf_event_open(2) ? */
> > -     err = security_perf_event_open(&attr, PERF_SECURITY_OPEN);
> > +     err = perf_copy_attr(attr_uptr, &attr);
> >       if (err)
> >               return err;
> >
> > -     err = perf_copy_attr(attr_uptr, &attr);
> > +     /* Do we allow access to perf_event_open(2) ? */
> > +     err = security_perf_event_open(&attr, PERF_SECURITY_OPEN);
>
> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Any chance you can pick this up?

Thanks,
Namhyung
