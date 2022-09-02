Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91E815AA745
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 07:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234865AbiIBFdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 01:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234836AbiIBFdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 01:33:08 -0400
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA21B6D45
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 22:33:07 -0700 (PDT)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-11eb8b133fbso2493993fac.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 22:33:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=pt84umBjwKOfigfK6cE/6IkovEu3oON8xwL8DcQpMdk=;
        b=Sxry5y4/DNsEbVLf6RFwfmVP7HR0UIWiE8cqYBlBl0VkYJ7Hxp8mO3ZwaQMCpXBECB
         SVHj+K4FC9OnGK+0WljWsOho3zC1XQ3pKGsBVBKJEWCGqN7a1kxVijW2YXkqeNtDdvNL
         BHsJnetNeRWkXiqZBq8bxuv+bAZ+GZk0botls6ZgYvIwa4npqI6uMW3PzXEIF1nRAK27
         CUSFP/EIwj09fBB80sTmO8bWAfloDtEyRlWeQfX4Z3lwzecg6u2KYyVTtpM5tfBTiwHs
         NzX+lMnJW/BXgpngEEPxEROLo0TsH6fJW4Ti1wsWoF25aiVL28n9qVwG9nUbg9CZGJTS
         xNOA==
X-Gm-Message-State: ACgBeo2xVdiODJt+mOEbRlodRpeG39FBfsjbjrvjBnYjORn4Qc4h5HUx
        DsEGgMjAFvDfVWwFsKs7Eh8u79L8HvYylDRYRUA=
X-Google-Smtp-Source: AA6agR6nCprMhbyFsb5pru68odUkqCp5znhwNs9F4VNEbrOAcXuhG8I1M7GG5HoCcdiQYdbyw+dFkP7/1W+RxeAm6M8=
X-Received: by 2002:a05:6870:a184:b0:116:bd39:7f94 with SMTP id
 a4-20020a056870a18400b00116bd397f94mr1402554oaf.5.1662096786321; Thu, 01 Sep
 2022 22:33:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220901130959.1285717-1-kan.liang@linux.intel.com>
In-Reply-To: <20220901130959.1285717-1-kan.liang@linux.intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 1 Sep 2022 22:32:55 -0700
Message-ID: <CAM9d7cgGPE7q9xhdxQtgv94i+SF-3+T2txdnY8m2P0qsSVWnkQ@mail.gmail.com>
Subject: Re: [PATCH V2 0/6] Add sample_flags to improve the perf_sample_data struct
To:     Kan Liang <kan.liang@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Stephane Eranian <eranian@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>, andreas.kogler.0x@gmail.com,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>
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

On Thu, Sep 1, 2022 at 6:10 AM <kan.liang@linux.intel.com> wrote:
>
> From: Kan Liang <kan.liang@linux.intel.com>
>
> Changes since V1:
> - Update the AMD LBR code in patch 3
>
> The patch series is to fix PEBS timestamps overwritten and improve the
> perf_sample_data struct. The detailed discussion can be found at
> https://lore.kernel.org/lkml/YwXvGe4%2FQdgGYOKJ@worktop.programming.kicks-ass.net/
>
> The patch series has two changes compared with the suggestions in the
> above discussion.
> - Only clear the sample flags for the perf_prepare_sample().
>   The __perf_event_header__init_id is shared between perf_prepare_sample()
>   (used by PERF_RECORD_SAMPLE) and perf_event_header__init_id() (used by
>   other PERF_RECORD_* event type). The sample data is only available
>   for the PERF_RECORD_SAMPLE.
> - The CALLCHAIN_EARLY hack is still required for the BPF, especially
>   perf_event_set_bpf_handler(). The sample data is not available when
>   the function is invoked.
>
> Kan Liang (6):
>   perf: Add sample_flags to indicate the PMU-filled sample data
>   perf/x86/intel/pebs: Fix PEBS timestamps overwritten
>   perf: Use sample_flags for branch stack
>   perf: Use sample_flags for weight
>   perf: Use sample_flags for data_src
>   perf: Use sample_flags for txn

Maybe we can get rid of perf_sample_data_init() completely.
But it could be done later, so

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


>
>  arch/powerpc/perf/core-book3s.c | 10 ++++++---
>  arch/x86/events/amd/core.c      |  4 +++-
>  arch/x86/events/core.c          |  4 +++-
>  arch/x86/events/intel/core.c    |  4 +++-
>  arch/x86/events/intel/ds.c      | 39 ++++++++++++++++++++++++---------
>  include/linux/perf_event.h      | 15 ++++++-------
>  kernel/events/core.c            | 30 ++++++++++++++++++-------
>  7 files changed, 74 insertions(+), 32 deletions(-)
>
> --
> 2.35.1
>
