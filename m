Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF365B0BA0
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 19:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbiIGRl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 13:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiIGRl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 13:41:27 -0400
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1791F80036;
        Wed,  7 Sep 2022 10:41:24 -0700 (PDT)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-127d10b4f19so12082173fac.9;
        Wed, 07 Sep 2022 10:41:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=xGuDMmDzq7UaA8hKjq2V/tnGAyEjuyD+utX1RCUB6Qo=;
        b=BK1EBYOFR3qzrlXnotwulm+s5GHmRtUBkYpB0XgdFgH5T4ZIOigJ9HuYoZDzsXLFcs
         sb3Kz16ihmzrp1imqH2TjckcdhGYOSWLB5LcSE8CtCggcQgZWEpVvg90u6NpDpCDgk2v
         KAxj1qCNvsx29vcsuRE2/0SVJV04XJfm1cw4ETer5TFJ2UsMC3sHjcLtIMvCQFCKBqxd
         pmJ+KDDgnie8Lmo02hj0iltdpHxpjZB4d2tfWhSWj1xQRzT35DIpHZPsEOWD4m0HL0hw
         gVNlYeqhR/HBpftHB2e3ymGCUCaFEXJLdBINlRqnkGOeVyFS9FK428rv1650ZfIiuTA6
         BJgQ==
X-Gm-Message-State: ACgBeo0dVZPpcP40kD7snBkxjizKT3xw2LyYDzG9aTZZ4s14DmmGB2ip
        3NeOVVQ1I2465p7RZrwRuK4l5guXJhiLEjnS192u8ETq
X-Google-Smtp-Source: AA6agR4J+9L9211ExKe5kfIrdyxb4+ocXtS1Lzy8AaC1BZ2k1xUvKgM+KvMWwuOv4QK/Ga/Pk8Ht9oUaI9FNXittvY4=
X-Received: by 2002:a05:6870:a184:b0:116:bd39:7f94 with SMTP id
 a4-20020a056870a18400b00116bd397f94mr15316368oaf.5.1662572483092; Wed, 07 Sep
 2022 10:41:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220907064645.1197894-1-namhyung@kernel.org> <20220907064645.1197894-4-namhyung@kernel.org>
 <2546f051-95be-1d8d-133c-2dac639b317d@intel.com>
In-Reply-To: <2546f051-95be-1d8d-133c-2dac639b317d@intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 7 Sep 2022 10:41:12 -0700
Message-ID: <CAM9d7cjKo5Xzmwqk1tNFdbhiDbzDisPgBgd2m1N66j05nt5b9A@mail.gmail.com>
Subject: Re: [PATCH 3/6] perf test: Test record with --threads option
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>
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

On Wed, Sep 7, 2022 at 6:33 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 7/09/22 09:46, Namhyung Kim wrote:
> > @@ -90,6 +90,19 @@ test_per_thread() {
> >      err=1
> >      return
> >    fi
> > +  if ! perf record -e cpu-clock,cs --per-thread --threads=core ${testopt} \
> > +    -o ${perfdata} ${testprog} 2> /dev/null
>
> This does not seem to be possible, because it gives the error:
>
> --per-thread option is mutually exclusive to parallel streaming mode.
> Failed to initialize parallel data streaming masks

Oh, ok.  Let's drop this change then.

Thanks,
Namhyung
