Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08F0B5371EC
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 19:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbiE2RgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 13:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbiE2RgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 13:36:15 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF4B13D18
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 10:36:14 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id rs12so16917559ejb.13
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 10:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RVcAJe5XVONjb8dc+ZXXSeKNhHu55YRYBkoQBm1t6ho=;
        b=fKu1bXFx8iKiBoFGT/CRrwehq4ecxQRl35kagL7wTgZp4/TNJJt30w7ChV4K5RzaKN
         fwEniKrOL1xkwMWf18Qkbjo7wi4P1DYO6QH0UTpXDrSBzpL2/jyMq5ltVo+zS70YoFfk
         8isqt1hzaQ9ByI7itzLo6Jb4W0NvYlf9D8+E0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RVcAJe5XVONjb8dc+ZXXSeKNhHu55YRYBkoQBm1t6ho=;
        b=zeKpp9RuFkSBI2lg1NXnK94y+FEtBb93dPyMUNENFOnnf0MsK/mPtCiXtgRoHIzPIx
         Z5wQX/S2U0fasCghfvbnxxIrAyaGzR8THCXCnIpX09SexnUDLtlL+lTrSmi6KZ5RdyCT
         0R/ryWGtCb62B1kpObHF7dpA2kngkIKLBRS8mknD0apSt8ALHDkSSMIQqNbiOtkiB7AQ
         KXK7GssA4+jmCIl3hlcogAZ9v2BYjnEC0oreACMWQGVacdSs7Ktob4RKS95ZQG9nhsvU
         U9j5TEPQi0vK7KiLhj8tg6skrDQzWsHKDdIpwg1PeXaD3MKt4PFQNt/6JHewz+Q05RoS
         WfvA==
X-Gm-Message-State: AOAM532U9aFFderU1c/yNwrQwLaLzjduaQFmXBlkaokWLs/5/vbv6YOs
        VxSvCW6Xt0h9rsTREunaLrOJyp1EKlGwe+i2hdI=
X-Google-Smtp-Source: ABdhPJwuCUB08FKqIqeV2OFD49RGivhS9xB6kxX8kcnvBCHcGx94d97vdv6gwzyEM7FH7AeIW/tInQ==
X-Received: by 2002:a17:906:5d16:b0:6fe:b420:5e9d with SMTP id g22-20020a1709065d1600b006feb4205e9dmr38478119ejt.254.1653845772688;
        Sun, 29 May 2022 10:36:12 -0700 (PDT)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com. [209.85.221.47])
        by smtp.gmail.com with ESMTPSA id rh28-20020a17090720fc00b006f3ef214ddesm3274151ejb.68.2022.05.29.10.36.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 May 2022 10:36:12 -0700 (PDT)
Received: by mail-wr1-f47.google.com with SMTP id e25so1300189wra.11
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 10:36:12 -0700 (PDT)
X-Received: by 2002:a05:6000:1b0f:b0:210:313a:ef2a with SMTP id
 f15-20020a0560001b0f00b00210313aef2amr2361937wrz.281.1653845322509; Sun, 29
 May 2022 10:28:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220529154535.371758-1-acme@kernel.org>
In-Reply-To: <20220529154535.371758-1-acme@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 29 May 2022 10:28:26 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj1+W6VXeRG7XXO7zSsTe3mACdrPY4PccMNPhC3seLELg@mail.gmail.com>
Message-ID: <CAHk-=wj1+W6VXeRG7XXO7zSsTe3mACdrPY4PccMNPhC3seLELg@mail.gmail.com>
Subject: Re: [GIT PULL] perf tools changes for v5.19: 2nd batch
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        Kate Carcia <kcarcia@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Carsten Haitzler <carsten.haitzler@arm.com>,
        Claire Jensen <cjense@google.com>,
        Dmitriy Vyukov <dvyukov@google.com>,
        Eelco Chaudron <echaudro@redhat.com>,
        Eric Lin <eric.lin@sifive.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        German Gomez <german.gomez@arm.com>,
        Ian Rogers <irogers@google.com>,
        James Clark <james.clark@arm.com>,
        Joe Mario <jmario@redhat.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        =?UTF-8?Q?Martin_Li=C5=A1ka?= <mliska@suse.cz>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 29, 2022 at 8:45 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> - Add BPF based off-CPU profiling.

I suspect this could have come with a bit more explanation of what
"off-CPU profiling" means.

It seems to be "account time when process was scheduled away to
caller", but I had to go look at the commits to figure that out.

Partly unrelated side note: I've occasionally looked for "useful perf
recipes". Not from kernel developers, but from people who solved real
performance problems using perf, giving useful examples.

                  Linus
