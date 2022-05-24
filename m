Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2C1C532FA8
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 19:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239976AbiEXRbh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 24 May 2022 13:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234928AbiEXRbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 13:31:34 -0400
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC85BE33;
        Tue, 24 May 2022 10:31:33 -0700 (PDT)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-f1d2ea701dso23094797fac.10;
        Tue, 24 May 2022 10:31:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=INBclGQUnAgmL/1YH+NfJhitfY2TwRtlpANpDvmKtu8=;
        b=DAJ0s0TL/y1Y4A2/AaCkr4o0eL0SfCIIXSwrBICfL0N1WddU6VUaRpQ9ZzbPmENw9g
         mWJZ9FQd+GDDbipRG9okcHZGWfhJNloCuFznVtBiRyYaB0Zzsa6VQPNPYJfFAqDq277r
         BKql4sjjCUBteRBawWhk2R2M7x5E7CV4qkPX+bIyCVd8aDzceyG3MAAVmqkLWJTphpZY
         V/Txa+tuJrm+64NpSCuLpZt1qtxhddVlAXJ2SJ7t00dCbK3IA3z6h8IFmFr0Zt328fhw
         ntb7G3pBu2eo+cvjGC7wWCcZJXsmzi1oBFVuWvN3M3BJkdvWBLHs0Ku9FxD1Exsd1N15
         Pi7w==
X-Gm-Message-State: AOAM532fnhDqg2+owZBlsUvqQ9QMjv89d2yhvYZChEdl0eDYJXezYZRT
        bGrpJNM4R+l63xLyxTaanD8A9Iahwf1ALAc7lh2fH9JS
X-Google-Smtp-Source: ABdhPJy7tGg1nqbuZDJD22VAoGMen3mHOaLa+izprn8iO5pNVMR4PamIr8sDloYiBfh16hEDDPiyVc67lIC1yArhhnA=
X-Received: by 2002:a05:6871:215:b0:f1:8bf5:23ab with SMTP id
 t21-20020a056871021500b000f18bf523abmr3101128oad.92.1653413492438; Tue, 24
 May 2022 10:31:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220521010811.932703-1-namhyung@kernel.org> <20220521010811.932703-2-namhyung@kernel.org>
 <YouDHRXZYqZSEutp@kernel.org>
In-Reply-To: <YouDHRXZYqZSEutp@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 24 May 2022 10:31:21 -0700
Message-ID: <CAM9d7ciqYsj+eGp9VqT6qQjmnzUjjrvbH8g7TgNE02k_Fifr5w@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf lock: Add -t/--thread option for report
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
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

Hi Arnaldo,

On Mon, May 23, 2022 at 5:50 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
> Applied both and added this:
>
> ⬢[acme@toolbox perf]$ git diff
> diff --git a/tools/perf/Documentation/perf-lock.txt b/tools/perf/Documentation/perf-lock.txt
> index b43222229807672c..656b537b2fba078f 100644
> --- a/tools/perf/Documentation/perf-lock.txt
> +++ b/tools/perf/Documentation/perf-lock.txt
> @@ -64,6 +64,27 @@ REPORT OPTIONS
>  --combine-locks::
>         Merge lock instances in the same class (based on name).
>
> +-t::
> +--threads::
> +    The -t option is to show per-thread lock stat like below:
> +
> +      $ perf lock report -t -F acquired,contended,avg_wait
> +
> +                    Name   acquired  contended   avg wait (ns)
> +
> +                    perf     240569          9            5784
> +                 swapper     106610         19             543
> +                  :15789      17370          2           14538
> +            ContainerMgr       8981          6             874
> +                   sleep       5275          1           11281
> +         ContainerThread       4416          4             944
> +         RootPressureThr       3215          5            1215
> +             rcu_preempt       2954          0               0
> +            ContainerMgr       2560          0               0
> +                 unnamed       1873          0               0
> +         EventManager_De       1845          1             636
> +         futex-default-S       1609          0               0
> +
>  INFO OPTIONS
>  ------------

Thanks a lot for doing this!
Namhyung
