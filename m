Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55D5254BCFC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 23:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358102AbiFNVuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 17:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244618AbiFNVuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 17:50:08 -0400
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE4951E5F;
        Tue, 14 Jun 2022 14:50:07 -0700 (PDT)
Received: by mail-oi1-f171.google.com with SMTP id bf7so12066683oib.11;
        Tue, 14 Jun 2022 14:50:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rbu9ANmj3+6noGx1Ee66PQJHzOisWTkSaUC9Zq6x7sc=;
        b=WWkHt2SDcg0/4zopUZq5FBVGn/a3r5A+5nJh9ydvIr6BJ6kByIO6csymZYsVldBWkx
         uGqxvDCd5ManAfGVkIjpabcGkGFG2sxJmr28VE1Qtked3vTEi9yzzyj2vOwZq9KscLiz
         64JZ3aFPj8iBBhI3hAEXmDWHQG+xAiLIVWMVmzr66mJO6DOXsOylkmXLloKafu1ByNlc
         P20fmDLo+qZ2S3pUgJ4qj0yXpZ2HGRlvjH/TInQSNdD+OOfYDuzkxrewcO9FR2Bilwf8
         vNQlKXoe+oTleqJtOzu5m1K87XbRm4rxUwMpTFdtrT/f2OYsXZaCqvXb05mxpCzR2G11
         ObiA==
X-Gm-Message-State: AJIora84RVDMtUtabJthQt2Xgc57Jfa5vQlpEaphWMeIyV/k36tmgqTz
        8YKPK3qJTB2RNx+XexRgOU41JtNofdOASQpAhQc=
X-Google-Smtp-Source: AGRyM1tcQ5sWOhCbS1b3zn/LfRbw1eOdGQo4WTgzcxcRQsjhqRFSFOemEmPY43ZJECTBLuD0bhxq/QxRckIyEq4GZqA=
X-Received: by 2002:a05:6808:1385:b0:32f:729e:4869 with SMTP id
 c5-20020a056808138500b0032f729e4869mr604425oiw.5.1655243407243; Tue, 14 Jun
 2022 14:50:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220613094605.208401-1-yangjihong1@huawei.com> <20220613094605.208401-7-yangjihong1@huawei.com>
In-Reply-To: <20220613094605.208401-7-yangjihong1@huawei.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 14 Jun 2022 14:49:56 -0700
Message-ID: <CAM9d7ci9R4=LuyDJAHSqtxc3nOZG+N8e7_WKJUKtL5j3xXqqtA@mail.gmail.com>
Subject: Re: [RFC 06/13] perf kwork: Implement perf kwork report
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

On Mon, Jun 13, 2022 at 2:48 AM Yang Jihong <yangjihong1@huawei.com> wrote:
>
> Implements framework of perf kwork report, which is used to report time
> properties such as run time and frequency:
>
> test case:
>
>   Kwork Name                | Cpu  | Avg delay     | Frequency | Max delay     | Max delay start     | Max delay end       |
>  ---------------------------------------------------------------------------------------------------------------------------
>  ---------------------------------------------------------------------------------------------------------------------------
>
> Since there are no report supported events, the output is empty.
>
> Briefly describe the data structure:
> 1. "class" indicates event type. For example, irq and softiq correspond
> to different types.
> 2. "cluster" refers to a specific event corresponding to a type. For
> example, RCU and TIMER in softirq correspond to different clusters,
> which contains three types of events: raise, entry, and exit.

I'm not good at naming but how about calling it "work" instead?
It's all about kernel works anyway..

Thanks,
Namhyung


> 3. "atom" includes time of each sample and sample of the previous phase.
> (For example, exit corresponds to entry, which is used for timehist.)
>
> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
