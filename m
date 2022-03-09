Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD724D394E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 19:55:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236438AbiCISzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 13:55:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235550AbiCISzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 13:55:46 -0500
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B28C88D69E;
        Wed,  9 Mar 2022 10:54:47 -0800 (PST)
Received: by mail-yb1-f170.google.com with SMTP id g1so6340046ybe.4;
        Wed, 09 Mar 2022 10:54:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZbXguUA3SAuK+Qqg58CaspcW6OAlxtt0qvmLSsMJ9ok=;
        b=c1lrVoJkoq+65QcVYPEdVKLR1VZPBZQ/QDoDE0LUcioDfJPbYn6YVsEijo7BE47H4/
         ZvYPehd0Ze907HZPub4sKVgKIIs7ANjRU4tPdUcmrvoPFIuVj5ipbe/vgMkZQGS/kx/b
         zzhe0SmDNE4GIgVHcUrdbM+aiiKcbMu5y7em5f0M0zridtbyGQmJDoOuecqxSnx9Saiy
         9N7AmdfLN9fPEgN2E754W4Ml4/nyfqiIEFTCa1ivFy9H7eZKcxNDbeCFFmESo0mpRDLz
         okWUGV/t2UMQzDfUVD3OoKEqYLF2iDUoy505+u1W17FZOfzLFRf9DxbLRwtZTUtuOpaL
         uVEA==
X-Gm-Message-State: AOAM530Zp5xDjN9rLalijCwYz7cVCehS0/YOjK99ggG1NXKwibrlyZit
        4tZwr0fHZpkcTcyUWVy6kfCwM8KUBG4O9Ox20UI=
X-Google-Smtp-Source: ABdhPJySslQluMapftZwOdQuwtvKtkaH3gpq/5V55iNkRKUk3CWTKt28vTn174ahSJl2cFeLrBHio+MzDgNAc95EAoI=
X-Received: by 2002:a25:fe10:0:b0:625:262f:e792 with SMTP id
 k16-20020a25fe10000000b00625262fe792mr950349ybe.365.1646852086908; Wed, 09
 Mar 2022 10:54:46 -0800 (PST)
MIME-Version: 1.0
References: <20220309012351.616826-1-Jinzhou.Su@amd.com> <YiisRXfrIco8hnXf@amd.com>
In-Reply-To: <YiisRXfrIco8hnXf@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 9 Mar 2022 19:54:35 +0100
Message-ID: <CAJZ5v0ioLFryuiE7pg1ywvj22TSpV6N9ADak3rQG8z8GYqF+rw@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] Add tracer tool for AMD P-State driver
To:     Huang Rui <ray.huang@amd.com>,
        "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>
Cc:     "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "srinivas.pandruvada@linux.intel.com" 
        <srinivas.pandruvada@linux.intel.com>,
        "dsmythies@telus.net" <dsmythies@telus.net>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "todd.e.brandt@linux.intel.com" <todd.e.brandt@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "Yuan, Perry" <Perry.Yuan@amd.com>,
        "Meng, Li (Jassmine)" <Li.Meng@amd.com>
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

On Wed, Mar 9, 2022 at 2:32 PM Huang Rui <ray.huang@amd.com> wrote:
>
> On Wed, Mar 09, 2022 at 09:23:47AM +0800, Su, Jinzhou (Joe) wrote:
> > Hello,
> >
> > intel_pstate_tracer is a useful tool to analyze the performance of
> > intel_pstate driver. We upstream out AMD P-state driver into Linux
> > kernel recently and like to use similar tool to tune the performance
> > of the driver.
> >
> > I modified intel_pstate_tracer.py then it could import as a module to
> > analyze AMD P-State trace event. Other trace event also can benifit from
> > this change once they need this tool.
> >
> > intel_pstate_tracer could be used as the same way as before and the
> > original functionality isn't broken.
> >
> > Changes from V2->V3
> >
> > -fix typo in amd-pstate RST
> >
> > Changes from V1->V2
> >
> > -Add tracer documentation in amd-pstate RST
> >
> > -fix typo in amd_pstate_trace.py
> >
> > -add "Co-developed-by" in patch 1/4
> >
> > Thanks,
> > Joe
> >
> > Jinzhou Su (4):
> >   cpufreq: amd-pstate: Add more tracepoint for AMD P-State module
> >   tools/power/x86/intel_pstate_tracer: make tracer as a module
> >   tools/power/x86/amd_pstate_tracer: Add tracer tool for AMD P-state
> >   Documentation: amd-pstate: add tracer tool introduction
>
> Series are Reviewed-by: Huang Rui <ray.huang@amd.com>

All patches in the series have been applied as 5.18 material, thanks!
