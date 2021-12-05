Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BBDD468B42
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 14:51:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234332AbhLENys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 08:54:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234182AbhLENyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 08:54:47 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 329CDC061714
        for <linux-kernel@vger.kernel.org>; Sun,  5 Dec 2021 05:51:20 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id y13so31826851edd.13
        for <linux-kernel@vger.kernel.org>; Sun, 05 Dec 2021 05:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yZRp/P0z+SfnrCvymT1hO4NZCYhrmUdNuC+3ZEb626M=;
        b=BbtamD8tRhD9PaogXzLHMcnTmmY6F8akHApUvH3/6KOhOvPaaQnLB66+tahElMLKeX
         EWXQt5knKzFpgkrXKsKQsC9pHVzmnoYwvAYtmIFwOZrEMD2dQq8iGIIuO5yxAKdLJDLo
         JjQywnffto78HlzMbGPbwRsrWvPe0I67mfXuhtFVjJUiYSbcW4nq9zKqxdvsEV1C8JZJ
         EIvVSg434drtuI3CgKCtAr0rWWvKfLUwXCrHMCvoNroHXLfZSwePgdcttqI9A+VWCgP8
         8Z9o9vWpFdbQHLnjCOUefIgkM1h8zwbgNzRcAMaTGSop+ha6ZFamwV8BpUsYnKLsl7xl
         B8Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yZRp/P0z+SfnrCvymT1hO4NZCYhrmUdNuC+3ZEb626M=;
        b=0dEowUuaQeWNLPHilsYP76rSg9tgKtfSd457A8r0zuiI/2p4K9oGobXkRnazDGTtkF
         sPcnxz490PrH9f5bxf5Q/BgXQ9uL6bnC4/4woeMqa73y2UDHBU96L/nx9KvJ2DiY0Y4H
         8IJTlTfNDGUKaE+OU6blKgwtWLGYHlPBDS5wwWGyRi5zUlIZEfDq/MH5ZwSo47PDXBMw
         8iME0AhfFqIi8cxFtABouAPO7kPzioKYeAYYHRCb1TAx7Gd6SkmGkv8yg+ufllktu8Oi
         QIjMU7r/zdyrSwiRQpN9bJuUQ8ygQUjvx21xlmck6zKi0S++Y89Ul2IS/1xPMhA6pJh1
         XzBw==
X-Gm-Message-State: AOAM530mCTr297bKm/dK6o/cx1TrtN8EHQxytt+K5siGO0200Gt+8JBf
        N+QUv6SZhdjvBdFSLBFUyFSPRg==
X-Google-Smtp-Source: ABdhPJweYu2Ow+S039Z4VffiMugkCJPIAcQreCs+suGXSVdwWgTLA2K4vqXjvtIKTF/kz/CEX1m1CA==
X-Received: by 2002:aa7:dc14:: with SMTP id b20mr44653314edu.133.1638712278531;
        Sun, 05 Dec 2021 05:51:18 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([104.245.96.202])
        by smtp.gmail.com with ESMTPSA id bd12sm5832378edb.11.2021.12.05.05.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Dec 2021 05:51:17 -0800 (PST)
Date:   Sun, 5 Dec 2021 21:51:03 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Kees Cook <keescook@chromium.org>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        James Morse <james.morse@arm.com>,
        Marc Zyngier <maz@kernel.org>, Joey Gouly <joey.gouly@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        James Clark <james.clark@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFCv1 4/4] perf: arm_spe: Dynamically switch PID tracing to
 contextidr
Message-ID: <20211205135103.GA42658@leoy-ThinkPad-X240s>
References: <20211021134530.206216-1-leo.yan@linaro.org>
 <20211021134530.206216-5-leo.yan@linaro.org>
 <202110210848.35971643C6@keescook>
 <20211101152835.GB375622@leoy-ThinkPad-X240s>
 <YapEUlcyDZ6TuE6n@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YapEUlcyDZ6TuE6n@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Catalin,

On Fri, Dec 03, 2021 at 04:22:42PM +0000, Catalin Marinas wrote:
> On Mon, Nov 01, 2021 at 11:28:35PM +0800, Leo Yan wrote:
> > On Thu, Oct 21, 2021 at 08:49:46AM -0700, Kees Cook wrote:
> > > On Thu, Oct 21, 2021 at 09:45:30PM +0800, Leo Yan wrote:
> > > > Now Arm64 provides API for enabling and disable PID tracing, Arm SPE
> > > > driver invokes these functions to dynamically enable it during
> > > > profiling when the program runs in root PID name space, and disable PID
> > > > tracing when the perf event is stopped.
> > > > 
> > > > Device drivers should not depend on CONFIG_PID_IN_CONTEXTIDR for PID
> > > > tracing, so this patch uses the consistent condition for setting bit
> > > > EL1_CX for PMSCR.
> > > 
> > > My own preference here would be to not bother with the new
> > > enable/disable helpers, but just open code it right here. (Save a patch
> > > and is the only user.) But I defer to the taste of arm64 maintainers. :)
> > 
> > Before I send out a new version for this patch set (for support
> > dynamic PID tracing on Arm64), I'd like to get your opinions for two
> > things:
> > 
> > - Firstly, as Kees suggested to directly use variable
> >   'contextidr_in_use' in drivers, which is exported as GPL symbol,
> >   it's not necessarily to add two helpers contextidr_{enable|disable}().
> >   What's your preference for this?
> 
> My preference would be to keep the helpers.

Okay, will keep the helpers.

> > - Secondly, now this patch set only support dynamic PID tracing for
> >   Arm64; and there would be two customers to use dynamic PID tracing:
> >   Arm SPE and Coresight ETMv4.x.  So this patch set doesn't support
> >   dynamic PID tracing for Arm32 (under arch/arm).
> > 
> >   Do you accept this patch set for enabling PID tracing on Arm64 and we
> >   can defer to support Arm32 when really need PID tracing on Arm32?
> >   Or we should enable PID dynamic tracing for Arm64 and Arm32 in one
> >   go?
> 
> If it doesn't break arm32, it's fine by me.

In next spin, I will introduce a patch for new Arm32 helpers.  Since
now we have no requirement for dynamic PID tracing, the Arm32 helpers
will be nop operations and can be used for kernel compilation.

> What's the cost of always enabling CONFIG_PID_IN_CONTEXTIDR? If it's
> negligible, I'd not bother at all with any of the enabling/disabling.

Yes, I compared performance for PID tracing with always enabling and
disabling CONFIG_PID_IN_CONTEXTIDR, and also compared with using
static key for enabling/disabling PID tracing.  The result shows the
cost is negligible based on the benchmark 'perf bench sched'.

Please see the detailed data in below link (note the testing results
came from my Juno board):
https://lore.kernel.org/lkml/20211021134530.206216-1-leo.yan@linaro.org/

> Another question: can you run multiple instances of SPE for different
> threads on different CPUs? What happens to the global contextidr_in_use
> key when one of them stops?

No, I only can launch one instance for Arm SPE event via perf tool; when
I tried to launch a second instance, perf tool reports failure:

The sys_perf_event_open() syscall returned with 16 (Device or resource busy) for event (arm_spe_0/load_filter=1,store_filter=1/u).

Alternatively, I'd like give several examples for contextidr_in_use key
values when run different perf modes.

Firstly, I added two kprobe points to monitor contextidr_in_use key
values with below commands, the first probe point is to monitor static
key's increment, and second probe point is to monitor key's
descrement:

  # perf probe --add 'arm_spe_pmu_setup_aux:45 contextidr_in_use=contextidr_in_use.key.enabled.counter:u32'
  # perf probe --add 'arm_spe_pmu_free_aux:7 contextidr_in_use=contextidr_in_use.key.enabled.counter:u32'

Case 1: run perf tool with 'per-thread' mode:

  # perf record -e arm_spe_0/load_filter=1,store_filter=1/u --per-thread -- uname

Trace log shows contextidr_in_use is increment to 1 when setup AUX
buffer and it descrement to 0 when free AUX buffer (before close SPE
event).

  perf-2393    [077] d..1.   427.161612: arm_spe_pmu_setup_aux_L45: (arm_spe_pmu_setup_aux+0x130/0x200) contextidr_in_use=1
  perf-2393    [077] d..1.   427.477993: arm_spe_pmu_free_aux_L7: (arm_spe_pmu_free_aux+0x44/0xa0) contextidr_in_use=0

Case 2: perf tool runs with system-wide mode:

  # perf record -e arm_spe_0/load_filter=1,store_filter=1/u -a -- uname

The system has 128 cores, so every CPU has its own AUX buffer, thus
the static key will increase from 0 to 128; reversely, the static key
will decrease from 128 to 0 when perf tool exists:

  perf-2395    [077] d..1.   435.647270: arm_spe_pmu_setup_aux_L45: (arm_spe_pmu_setup_aux+0x130/0x200) contextidr_in_use=1
  perf-2395    [077] d..1.   435.647912: arm_spe_pmu_setup_aux_L45: (arm_spe_pmu_setup_aux+0x130/0x200) contextidr_in_use=2
  ...
  perf-2395    [077] d..1.   435.709717: arm_spe_pmu_setup_aux_L45: (arm_spe_pmu_setup_aux+0x130/0x200) contextidr_in_use=128
  perf-2395    [127] d..1.   436.734142: arm_spe_pmu_free_aux_L7: (arm_spe_pmu_free_aux+0x44/0xa0) contextidr_in_use=127
  perf-2395    [127] d..1.   436.734438: arm_spe_pmu_free_aux_L7: (arm_spe_pmu_free_aux+0x44/0xa0) contextidr_in_use=126
  perf-2395    [127] d..1.   436.734682: arm_spe_pmu_free_aux_L7: (arm_spe_pmu_free_aux+0x44/0xa0) contextidr_in_use=125
  ...
  perf-2395    [127] d..1.   436.763856: arm_spe_pmu_free_aux_L7: (arm_spe_pmu_free_aux+0x44/0xa0) contextidr_in_use=0

Case 3: perf tool runs for CPU-wise mode:

  # perf record -e arm_spe_0/load_filter=1,store_filter=1/u -C 1,3,4  -- uname

The option '-C 1,3,4' specifies to only enable Arm SPE tracing on
three CPUs (CPU1/3/4), so the contextidr_in_use key will increment for
3 times when open perf event, and decrement the static key for 3 times
when close SPE event:

  perf-2404    [077] d..1.   450.564087: arm_spe_pmu_setup_aux_L45: (arm_spe_pmu_setup_aux+0x130/0x200) contextidr_in_use=1
  perf-2404    [077] d..1.   450.564744: arm_spe_pmu_setup_aux_L45: (arm_spe_pmu_setup_aux+0x130/0x200) contextidr_in_use=2
  perf-2404    [077] d..1.   450.565369: arm_spe_pmu_setup_aux_L45: (arm_spe_pmu_setup_aux+0x130/0x200) contextidr_in_use=3
  perf-2404    [004] d..1.   451.567532: arm_spe_pmu_free_aux_L7: (arm_spe_pmu_free_aux+0x44/0xa0) contextidr_in_use=2
  perf-2404    [004] d..1.   451.567823: arm_spe_pmu_free_aux_L7: (arm_spe_pmu_free_aux+0x44/0xa0) contextidr_in_use=1
  perf-2404    [004] d..1.   451.568120: arm_spe_pmu_free_aux_L7: (arm_spe_pmu_free_aux+0x44/0xa0) contextidr_in_use=0

Hope these three cases can demonstrate the usage for contextidr_in_use
static key.

Thanks,
Leo
