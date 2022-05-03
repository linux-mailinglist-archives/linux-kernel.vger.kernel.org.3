Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D227518D6E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 21:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242139AbiECTvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 15:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233678AbiECTvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 15:51:12 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC4B3EA86
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 12:47:39 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id k126so7045814wme.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 12:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EJuEir8WaQdx+AmMhItnX2XU1VcFLfAnu7382m6sqak=;
        b=XvH6ljkdXQ4W7AQb7m3MjxmpuHDXFZ1lpOtEaWkjtqTp+CytnkJ+EMas3DQqX5wGtV
         w4pJXR3Bkhif1hyXU3lqDyjv4ln2JNNHZmzEZKC/v3nfa840DIzNPIkcdguaE4it37+u
         tH1jTnGE1qTgSVyZOxjsIvnbtfsfS5n/HJheyvn5p3/rH0syRc08/39w0DdA+dKWhD7+
         CnmjsHTmcxlDXmwkanmhmKJWUGWhfkIJiREdQ+Sd6ZB2o5kLnfezQklB/P+TOssbMFcm
         NskgceFG7WVb0Ea+9MZzYk9BT+YlyPePg2RLOpDlXhlrwEPu+FFTFdw2dn6S1VifQTZp
         smFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EJuEir8WaQdx+AmMhItnX2XU1VcFLfAnu7382m6sqak=;
        b=McxD4n16C0WMmmEMBW1USqpE0aOZH1cp45zAKtoCbpCNnNLJLySim8L4kpgtLMJXUj
         wSddxJ0iIZuOErunuSkYWhiMMC28+2RTTSYhivqvMiAGdCRReA+KkdAEKhBP27UCGLmy
         e9B4X9GMX/Hnui1CKNV6eJgh5BWsSjI21P+RRLv2cglDK4IoLByznNwajEZBPmbV/01r
         ZX6AIVrYsQKuF/EFGD26kCqEX7dTgGUqr3/2+nTXeXwjrFCVEaA6nRouv+UlsbR0VbNB
         cgmit/6odNDT4nqd/29QYZznNYOUsQkIuOCq+wPu3SSz+Rea4YelGjU6xVfuJEUFZWai
         Q1YQ==
X-Gm-Message-State: AOAM533wJpkrGW7W4xTnyQ0Wsf78OS559eKfs97/c61RQ2MEO5y8aRAr
        hJS4szKACSOyXv72M45w1c5NXxalAaZJVJh8Vo7xdg==
X-Google-Smtp-Source: ABdhPJxy7nFk3Qg/rRk0SS+7UUm+WSXA/XPDIfZ+TT3+yvbWOaCGNaMpBJGdibzONyW75MJqG4tZ9y/qBFWqh+M/Al4=
X-Received: by 2002:a05:600c:27c6:b0:394:783:2077 with SMTP id
 l6-20020a05600c27c600b0039407832077mr4756853wmb.182.1651607257693; Tue, 03
 May 2022 12:47:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220428075730.797727-1-irogers@google.com> <96b5c9f4-f0a0-0019-8059-3e833c95b011@linux.intel.com>
 <YmqXGCMbBOLcd261@kernel.org>
In-Reply-To: <YmqXGCMbBOLcd261@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 3 May 2022 12:47:25 -0700
Message-ID: <CAP-5=fWQMVVFZ=4WLWJkojZARHnmYp+AgTOodG_W=qqNZFw6iA@mail.gmail.com>
Subject: Re: [PATCH 1/7] perf vendor events intel: Update CLX events to v1.15
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     "Liang, Kan" <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        James Clark <james.clark@arm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2022 at 6:31 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Thu, Apr 28, 2022 at 09:12:26AM -0400, Liang, Kan escreveu:
> >
> >
> > On 4/28/2022 3:57 AM, Ian Rogers wrote:
> > > Events are generated for CascadeLake Server v1.15 with
> > > events from:
> > > https://download.01.org/perfmon/CLX/
> > >
> > > Using the scripts at:
> > > https://github.com/intel/event-converter-for-linux-perf/
> > >
> > > This change updates descriptions, adds INST_DECODED.DECODERS and
> > > corrects a counter mask in UOPS_RETIRED.TOTAL_CYCLES.
> > >
> > > Signed-off-by: Ian Rogers<irogers@google.com>
> >
> > Thanks Ian. For the whole series,
> >
> > Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
>
> Thanks, applied.
>
> - Arnaldo

Thanks Arnaldo, it looks like CLX was accidentally skipped.

Ian
