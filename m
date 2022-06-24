Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD89D559F12
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 19:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbiFXRFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 13:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231400AbiFXRFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 13:05:47 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA1195D108
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 10:05:45 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 23so5492947ybe.8
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 10:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZIPazKmSsD26XWJDudnBcSzWESOQebME2fbkS0xWFAE=;
        b=ZT8/bZUMdVEcLuC1UUVyX3uDPk7EQ1xFxdjgEIyJolBUUEmp91wMIr7tSMXYICg7O3
         aiDzcAiFvFvcQqxElKgz+8FHfBjpwSjJIGbwBK1ZyH9tvCAfGp7EuRH+AHlIpT0Nov6o
         SaRWF/Es+NNu2GAFCPfW+KJ5+8LLrmhmxsfYM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZIPazKmSsD26XWJDudnBcSzWESOQebME2fbkS0xWFAE=;
        b=xwnAyXzZGBbVBIMNlGN36f9S+vpZrUJRsZ4t47U7qwJya/na/o45dGh9IfkEfAVMmF
         MJmNs4wA8jPS1+OALhwjdBhDt7HWyHVCEsOu4xffRrImJPPZyJd8nEi5HoFfGqy4SFef
         ajlhI6ZHP24mZNWJC5oxpXkl2Msc0qTqo2HRtljE+4HllmYYOU18v3GZSdVoidN+kaRm
         15mH/8Aro9vAv8ajtjDJkoQIFSNJzxMqAWi07j2LesolNNTv6sAZ7TXLqemQOBpW1vd5
         hdbyhNOJplHPKHnreNfzdRckiWjJneki8w4GTLqqTJojw4DH38qUKlJ1X2vZiursemnB
         zeNQ==
X-Gm-Message-State: AJIora8cuBDiXh3oKEY60ief4Ls67QxLtqFcxLy1zH2BId/u1Fbm5P1h
        eBZZqTHdjAYqGv3egNpW92KT9JWiy83joWFLlrMi
X-Google-Smtp-Source: AGRyM1sHDc2cW7clSCW0XylBGUiRR0RTkYDBhReAvtAFsWXBx2x2LeTFy4BM0fMgkJ61RgRmxJo/gZaREWNynpNDYpE=
X-Received: by 2002:a5b:c4:0:b0:669:15d4:8b68 with SMTP id d4-20020a5b00c4000000b0066915d48b68mr122544ybp.473.1656090344842;
 Fri, 24 Jun 2022 10:05:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220624160117.3206-1-nikita.shubin@maquefel.me>
In-Reply-To: <20220624160117.3206-1-nikita.shubin@maquefel.me>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Fri, 24 Jun 2022 10:05:34 -0700
Message-ID: <CAOnJCU+2mOMj7MPzLKVZQ46gRs=ghxP6FK6oWkss0DfN_si3DQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] RISC-V: Create unique identification for SoC PMU
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Anup Patel <anup@brainfault.org>,
        =?UTF-8?B?Sm/Do28gTcOhcmlvIERvbWluZ29z?= 
        <joao.mario@tecnico.ulisboa.pt>, linux <linux@yadro.com>,
        Nikita Shubin <n.shubin@yadro.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 24, 2022 at 9:01 AM Nikita Shubin <nikita.shubin@maquefel.me> wrote:
>
> From: Nikita Shubin <n.shubin@yadro.com>
>
> This series aims to provide matching vendor SoC with corresponded JSON bindings.
>
> The ID string is proposed to be in form of MVENDORID-MARCHID-MIMPID, for example
> for Sifive Unmatched the corresponding string will be:
>
> 0x489-0x8000000000000007-0x[[:xdigit:]]+,v1,sifive/u74,core
>
> Where MIMPID can vary as all impl supported the same number of events, this might not
> be true for all future SoC however.
>
> Also added 3 counters which are standart for all RISC-V implementations and SBI firmware
> events prerry names, as any firmware that supports SBI PMU should also support firmare
> events.
>
> Link: https://github.com/riscv-non-isa/riscv-sbi-doc/blob/master/riscv-sbi.adoc
> Link: https://patchwork.kernel.org/project/linux-riscv/list/?series=648017
> ---
> v3->v4:
> - drop pmuid in riscv_pmu_sbi, we are using /proc/cpuinfo
> - rework util/header.c to use /proc/cpuinfo
> - add SBI firmware events
> - add firmware and std arch events to U74 pmu bindings
> - change U74 id string and description in mapfile.csv
> ---
> Nikita Shubin (5):
>   drivers/perf: riscv_pmu_sbi: perf format
>   perf tools riscv: Add support for get_cpuid_str function
>   perf arch events: riscv arch std event files
>   perf arch events: riscv sbi firmare std event files
>   perf vendor events riscv: add Sifive U74 JSON file
>
>  drivers/perf/riscv_pmu_sbi.c                  |  20 +++
>  tools/perf/arch/riscv/util/Build              |   1 +
>  tools/perf/arch/riscv/util/header.c           | 109 ++++++++++++++
>  tools/perf/pmu-events/arch/riscv/mapfile.csv  |  17 +++
>  .../pmu-events/arch/riscv/riscv-generic.json  |  20 +++
>  .../arch/riscv/riscv-sbi-firmware.json        | 134 ++++++++++++++++++
>  .../arch/riscv/sifive/u74/firmware.json       |  68 +++++++++
>  .../arch/riscv/sifive/u74/generic.json        |  11 ++
>  .../arch/riscv/sifive/u74/instructions.json   |  92 ++++++++++++
>  .../arch/riscv/sifive/u74/memory.json         |  32 +++++
>  .../arch/riscv/sifive/u74/microarch.json      |  57 ++++++++
>  11 files changed, 561 insertions(+)
>  create mode 100644 tools/perf/arch/riscv/util/header.c
>  create mode 100644 tools/perf/pmu-events/arch/riscv/mapfile.csv
>  create mode 100644 tools/perf/pmu-events/arch/riscv/riscv-generic.json
>  create mode 100644 tools/perf/pmu-events/arch/riscv/riscv-sbi-firmware.json
>  create mode 100644 tools/perf/pmu-events/arch/riscv/sifive/u74/firmware.json
>  create mode 100644 tools/perf/pmu-events/arch/riscv/sifive/u74/generic.json
>  create mode 100644 tools/perf/pmu-events/arch/riscv/sifive/u74/instructions.json
>  create mode 100644 tools/perf/pmu-events/arch/riscv/sifive/u74/memory.json
>  create mode 100644 tools/perf/pmu-events/arch/riscv/sifive/u74/microarch.json
>
> --
> 2.35.1
>

Thanks Nikita for reworking on the patches. It is good to specify that
this series now depends
on Anup's patch[1] that adds the mvendorid/mimpid to the /proc/cpuinfo.

[1] https://lkml.org/lkml/2022/6/20/498

-- 
Regards,
Atish
