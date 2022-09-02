Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 173FF5AA731
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 07:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiIBFYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 01:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiIBFY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 01:24:28 -0400
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E40ADB6D1C
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 22:24:26 -0700 (PDT)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-11ba6e79dd1so2242274fac.12
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 22:24:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=jwgqCvmy08yXq0jAbHqX5UfHcA4+R55Aw43jZc0DYg0=;
        b=ESja18dy20WgxfGr+IShNJVpOWkQPQpAhLz7gAArRQDfTlsvZdwYVE5QNmvonhmb6K
         zcePO3XJ6tRzgXisztKFNLjCJnfCACYgnbxv/NByfv+35JkElhheIaQj2PPZNEs70cr7
         WATDCWavHGP46ryVvmRHxdlbKFufXmzEMMTDnz5ES/jUDL8iYuuE00zpDVZJ6lI11n9H
         AuFJY9pxhhUU2aAASEaxisYSa84iQnOPitK5KJdlqWw7j2ALXKVomycswo8UX3dUjIzU
         QYYiWOFM87Ixn+SbJa6haEvZ6Rpx7ns5lbWZBZ9gXdZOZltwjhnhcVHRKBYVBi3BRJZF
         wH7g==
X-Gm-Message-State: ACgBeo0XyzE0MCInDsgVtDcpcrhu61xVyGRQ2kSLD4i3fCkSLXraI6gd
        MZXAWauVZ/zNsT8Tl9HSE1t1mXDBOEXCu2A2yxI=
X-Google-Smtp-Source: AA6agR58lX2PDL7JCmWnZQkD0ykZXGrB+uzs0vRvV6pIM3QUx07emwN7eTDMcVE54fjvZA72lMcCjYiKvHrFV2qjM74=
X-Received: by 2002:a05:6870:5b84:b0:10c:d1fa:2f52 with SMTP id
 em4-20020a0568705b8400b0010cd1fa2f52mr1375784oab.92.1662096266197; Thu, 01
 Sep 2022 22:24:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220831145514.190514-1-kan.liang@linux.intel.com>
 <Yw/j8rXIRwAnXhy3@google.com> <a751a7ea-78b6-d278-4cbb-eef17294fcf3@linux.intel.com>
In-Reply-To: <a751a7ea-78b6-d278-4cbb-eef17294fcf3@linux.intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 1 Sep 2022 22:24:15 -0700
Message-ID: <CAM9d7chy0y-22WEXyQ6cJPmJpo3w4b01W0PYTZmVnX3A6MHP1w@mail.gmail.com>
Subject: Re: [PATCH 0/6] Add sample_flags to improve the perf_sample_data struct
To:     "Liang, Kan" <kan.liang@linux.intel.com>
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 1, 2022 at 5:47 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
>
>
>
> On 2022-08-31 6:42 p.m., Namhyung Kim wrote:
> > (Adding Ravi to CC)
> >
> > On Wed, Aug 31, 2022 at 07:55:08AM -0700, kan.liang@linux.intel.com wrote:
> >> From: Kan Liang <kan.liang@linux.intel.com>
> >>
> >> The patch series is to fix PEBS timestamps overwritten and improve the
> >> perf_sample_data struct. The detailed discussion can be found at
> >> https://lore.kernel.org/lkml/YwXvGe4%2FQdgGYOKJ@worktop.programming.kicks-ass.net/
> >>
> >> The patch series has two changes compared with the suggestions in the
> >> above discussion.
> >> - Only clear the sample flags for the perf_prepare_sample().
> >>   The __perf_event_header__init_id is shared between perf_prepare_sample()
> >>   (used by PERF_RECORD_SAMPLE) and perf_event_header__init_id() (used by
> >>   other PERF_RECORD_* event type). The sample data is only available
> >>   for the PERF_RECORD_SAMPLE.
> >> - The CALLCHAIN_EARLY hack is still required for the BPF, especially
> >>   perf_event_set_bpf_handler(). The sample data is not available when
> >>   the function is invoked.
> >
> > In general, looks good!  I'd like to work on the BPF side so that it can
> > get the sample data for filtering.
>
> Thanks Namhyung. I will send out the V2 shortly. I think the BPF work
> can be on top of it.

Yep, I'll work on it once this patchset is merged.

Thanks,
Namhyung
