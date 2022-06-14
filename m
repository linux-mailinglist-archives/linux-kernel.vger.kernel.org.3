Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB1C454BCEE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 23:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240904AbiFNVoJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 17:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231695AbiFNVoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 17:44:08 -0400
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DCBD275C7;
        Tue, 14 Jun 2022 14:44:07 -0700 (PDT)
Received: by mail-oi1-f178.google.com with SMTP id bf7so12050989oib.11;
        Tue, 14 Jun 2022 14:44:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8QMsUtIyEnI6GxBkF9iHYVsdk25z9ZpByq01YYX9ysg=;
        b=U+9FTiDgexv7UAmKgVfX/D1ndon1vQ/6UaK4lhGUbH5N+80R5YVsLk6qVNe/YD5ci5
         hU4o9FU2+bfhKIv3GUGmAhSOQsag25FCGlaLz18Og3d4PMMB0Osx74pXwgm7NBUujcYl
         wvPYFX0qsSzNfkp/FX/BOhPGVhIkmuHMNVi+I1zsmhkUqdzzFYN7Jm1zFn/uW9qa7rhs
         vMZO81RyxpaWVv4d7UKkQN9hTblpk2tXaTvAyO4uCkWKzgCA2yhf4kFTEbQqX5z6nQtP
         7Kd5+PC5QqYVpFdsL0lAtPtU8ZfS3zD9FIsrWgKMxNrxWanVoD1r8256iQVf43NUuGsj
         A4XQ==
X-Gm-Message-State: AOAM533V8tcvC77iNlxmAoE/lSnS7zsWz9FyUYzr59FpdUWL3u/kPP78
        6TF47u/+tz3m8F/V8Q2v3yjL7clBvD/mrnQLG5o=
X-Google-Smtp-Source: ABdhPJx0GRPfywd6bkowa8JZnSN+9Oe1XgrNO3hMIS2tkcqC7REp+48SEf0mFA5J4AyJ3FXtED8jcNZ+hzsANBKnvzw=
X-Received: by 2002:aca:bb56:0:b0:32f:2160:bfd8 with SMTP id
 l83-20020acabb56000000b0032f2160bfd8mr3158871oif.92.1655243046655; Tue, 14
 Jun 2022 14:44:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220613094605.208401-1-yangjihong1@huawei.com> <20220613094605.208401-2-yangjihong1@huawei.com>
In-Reply-To: <20220613094605.208401-2-yangjihong1@huawei.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 14 Jun 2022 14:43:55 -0700
Message-ID: <CAM9d7ch-VL6siA7g79pN1OSgus4X2C0D2tptAt5u04KUqxOUTg@mail.gmail.com>
Subject: Re: [RFC 01/13] perf kwork: New tool
To:     Yang Jihong <yangjihong1@huawei.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>
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

Hello,

On Mon, Jun 13, 2022 at 2:48 AM Yang Jihong <yangjihong1@huawei.com> wrote:
>
> The perf-kwork tool is used to trace time properties of kernel work
> (such as irq, softirq, and workqueue), including runtime, latency,
> and timehist, using the infrastructure in the perf tools to allow
> tracing extra targets:
>
>   # perf kwork -h
>
>    Usage: perf kwork [<options>] {record|report|latency|timehist}
>
>       -D, --dump-raw-trace  dump raw trace in ASCII
>       -f, --force           don't complain, do it
>       -k, --kwork <kwork>   list of kwork to profile (irq, softirq, workqueue etc)
>       -v, --verbose         be more verbose (show symbol address, etc)
>
>   # perf kwork record -- sleep 1
>   [ perf record: Woken up 0 times to write data ]
>   [ perf record: Captured and wrote 1.696 MB perf.data ]
>
>   # perf kwork report -h
>
>    Usage: perf kwork report [<options>]
>
>       -C, --cpu <cpu>       list of cpus to profile
>       -i, --input <file>    input file name
>       -n, --name <name>     event name to profile
>       -s, --sort <key[,key2...]>
>                             sort by key(s): runtime, max, freq
>       -S, --with-summary    Show summary with statistics
>           --time <str>      Time span for analysis (start,stop)
>
>   # perf kwork latency -h
>
>    Usage: perf kwork latency [<options>]
>
>       -C, --cpu <cpu>       list of cpus to profile
>       -i, --input <file>    input file name
>       -n, --name <name>     event name to profile
>       -s, --sort <key[,key2...]>
>                             sort by key(s): avg, max, freq
>           --time <str>      Time span for analysis (start,stop)
>
>   # perf kwork timehist -h
>
>    Usage: perf kwork timehist [<options>]
>
>       -C, --cpu <cpu>       list of cpus to profile
>       -g, --call-graph      Display call chains if present
>       -i, --input <file>    input file name
>       -k, --vmlinux <file>  vmlinux pathname
>       -n, --name <name>     event name to profile
>           --kallsyms <file>
>                             kallsyms pathname
>           --max-stack <n>   Maximum number of functions to display backtrace.
>           --symfs <directory>
>                             Look for files with symbols relative to this directory
>           --time <str>      Time span for analysis (start,stop)

I think you can add this and the documentation when you
actually add the functionality later.

Thanks,
Namhyung
