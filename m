Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB8EA5A8928
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 00:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232506AbiHaWnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 18:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiHaWnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 18:43:03 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DDBF8E0E5
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 15:43:02 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id x19so13954711pfr.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 15:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=P39KvYUQglLRPquJ1Ps6ttbmVE/Y7m2jQ9Su0nLWcXg=;
        b=lADAoWuBUvhoM2agGCCvXXr5RwrUcy8S+wN7ns1hZb2/LC8VRaakf7YYkrS+nitb06
         Vnwts+u0EnbkhlnsfsvE5IPcib/2i0wiXUnszVk4m4F238UMv3yNuji756Wakk3oLk89
         5i+8i376qxGA92I2BFQo+shnnMAhVAMa+XuzraHwRC7fda+6slVL5WZ2rLrcSNz50cFl
         ZdGgdZBd8gK17GQsT6iGtIrDXCxLECAd5hIqAEtmpvAX8yU2IN2uzwhCzV+eXA85+KHf
         Wxzpo0dY/DfkmFEIb1SMmxyncQXOgHuQzXSfEYcBWzIAhav0bskp3uL+cL7W87xiyr7m
         nYeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=P39KvYUQglLRPquJ1Ps6ttbmVE/Y7m2jQ9Su0nLWcXg=;
        b=6qYXfCiQgCL67n3iwykDtVf7vbsonEVgyzmVHebfCOcCTJQsuyBXUiZmrk6NqeqExZ
         7SWPDIbLDwX7R6Lur4z3jfEnbIjBaRdIZzip+/kturhTIV3qWOxLXwHKmbRVtGebRAZ6
         TEh7vK5oP1Ymc+YV0AcS2otZCR8RZnXFzRCaTWRH8XEULR/9BwhFAcPc+YxGXMaLuzeF
         Ur9/2pq9Ib8Bm1hNIKeF0IcfNTBRykjEEHfAzP60JQ7in89O/10XWitjrRGqGPPqJ1oM
         MCzGjrMkigxMtZB2xuV5ZMmqaSx3tSsmXjC78Vhrp1WeFPsq/YvXqEFP9GG+KXlUN59P
         TraA==
X-Gm-Message-State: ACgBeo0wRz31m+Uide1U3SJ/LYpMsvXUV+rThkgF2Nj9lp1TpcZxxKUL
        PeGji/yFeUlPchPiiJeOTjI=
X-Google-Smtp-Source: AA6agR5NHFtXZOPXHYYXvKNHhsI0VY6mVJ+RoGW4i51gihnTGZCZ3ZbmzEPN4DkKx0bhDbtTOaiqaQ==
X-Received: by 2002:a63:110:0:b0:430:77e1:9284 with SMTP id 16-20020a630110000000b0043077e19284mr367141pgb.410.1661985781406;
        Wed, 31 Aug 2022 15:43:01 -0700 (PDT)
Received: from google.com ([2620:15c:2d4:203:4a6a:d1f4:9cf7:d0fb])
        by smtp.gmail.com with ESMTPSA id o4-20020a17090a5b0400b001fe39bda429sm955776pji.38.2022.08.31.15.43.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 15:43:00 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
Date:   Wed, 31 Aug 2022 15:42:58 -0700
From:   Namhyung Kim <namhyung@kernel.org>
To:     kan.liang@linux.intel.com
Cc:     peterz@infradead.org, acme@kernel.org, mingo@redhat.com,
        eranian@google.com, mpe@ellerman.id.au,
        linux-kernel@vger.kernel.org, ak@linux.intel.com,
        andreas.kogler.0x@gmail.com, atrajeev@linux.vnet.ibm.com,
        ravi.bangoria@amd.com
Subject: Re: [PATCH 0/6] Add sample_flags to improve the perf_sample_data
 struct
Message-ID: <Yw/j8rXIRwAnXhy3@google.com>
References: <20220831145514.190514-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220831145514.190514-1-kan.liang@linux.intel.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Adding Ravi to CC)

On Wed, Aug 31, 2022 at 07:55:08AM -0700, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
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

In general, looks good!  I'd like to work on the BPF side so that it can
get the sample data for filtering.  The previous discussion was at

  https://lore.kernel.org/all/CAM9d7cjj0X90=NsvdwaLMGCDVkMJBLAGF_q-+Eqj6b44OAnzoQ@mail.gmail.com/

Thanks,
Namhyung

> 
> Kan Liang (6):
>   perf: Add sample_flags to indicate the PMU-filled sample data
>   perf/x86/intel/pebs: Fix PEBS timestamps overwritten
>   perf: Use sample_flags for branch stack
>   perf: Use sample_flags for weight
>   perf: Use sample_flags for data_src
>   perf: Use sample_flags for txn
> 
>  arch/powerpc/perf/core-book3s.c | 10 ++++++---
>  arch/x86/events/core.c          |  4 +++-
>  arch/x86/events/intel/core.c    |  4 +++-
>  arch/x86/events/intel/ds.c      | 39 ++++++++++++++++++++++++---------
>  include/linux/perf_event.h      | 15 ++++++-------
>  kernel/events/core.c            | 33 +++++++++++++++++++---------
>  6 files changed, 72 insertions(+), 33 deletions(-)
> 
> -- 
> 2.35.1
> 
> 
