Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF7B856C41A
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 01:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240318AbiGHUiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 16:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239891AbiGHUiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 16:38:20 -0400
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F7D39E;
        Fri,  8 Jul 2022 13:38:20 -0700 (PDT)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-10c0052da61so36613fac.12;
        Fri, 08 Jul 2022 13:38:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UjVd1XkbkANkjR5Bsgl6puPps0K5SQjeSgIiynnBvz4=;
        b=f1lx6jQnN7WQuw4sm3aWu3r5wUsegxfmxgLa6Jpn/bJjkMuBmm154t0JJfQl7U6V4z
         /hbqirSdGbNmruYEXgkQwcuRC82HTOKOnxdWfZH62TGNDQOjwrok/NRTUMKhCNms+rPQ
         mr3ddcxYHOF2EYix38aaP/TP3Gj5C7MP+pH8bnlPIRaIZFHMSbh4KlRPID0WOUG6n9N4
         yQrr7/iaABtK5tujf8Be7X/fKOdpePn2G/SuU/USOTeo1QyawnkQ7tm1Rx1rAtWoDjTL
         sflcq6HOwf6V/1yyyfcn3j/Kg5Hc7pxQh/XPlYKWawyBbkJEkldiBr4EeAnnYTdZ5hIM
         Fwzw==
X-Gm-Message-State: AJIora+AwgXX3ADOMHh6hNa91LdYOaDQB4EAXeDRcg7JoSL/xrXWB61I
        0ruBTJ5X+pWeyefll9891iUPh7xEy2v82RszwxA=
X-Google-Smtp-Source: AGRyM1vXjH7bIiEh+WpGXSTQO+gPtd83pCggdxsIVu5ULO1XgvZxMd9QTJjdDAqMESn0xiWtg2N3TRHXGL9oKCgUUHE=
X-Received: by 2002:a05:6870:2f15:b0:108:c28d:3304 with SMTP id
 qj21-20020a0568702f1500b00108c28d3304mr1028943oab.92.1657312699603; Fri, 08
 Jul 2022 13:38:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220706210613.1987767-1-mpratt@google.com>
In-Reply-To: <20220706210613.1987767-1-mpratt@google.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 8 Jul 2022 13:38:08 -0700
Message-ID: <CAM9d7cjTUQtLLfj-eZiKgjByDzduBnkWM87srmH6EJKiRa3mdA@mail.gmail.com>
Subject: Re: [PATCH] perf: uapi: fix PERF_RECORD_SAMPLE format documentation
To:     Michael Pratt <mpratt@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Tejun Heo <tj@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
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

Hello,

On Wed, Jul 6, 2022 at 2:06 PM Michael Pratt <mpratt@google.com> wrote:
>
> The documented format of PERF_RECORD_SAMPLE does not match the actual
> format emitted by perf_output_sample:
>
> * The cgroup field is missing entirely.
> * The data_page_size and code_page_size fields are output before the aux
>   data, but are documented before.
>
> Fixes: 6546b19f95ac ("perf/core: Add PERF_SAMPLE_CGROUP feature")
> Fixes: 8d97e71811aa ("perf/core: Add PERF_SAMPLE_DATA_PAGE_SIZE")
> Fixes: 995f088efebe ("perf/core: Add support for PERF_SAMPLE_CODE_PAGE_SIZE")
> Signed-off-by: Michael Pratt <mpratt@google.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung
