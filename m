Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA64546BB16
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 13:31:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236246AbhLGMfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 07:35:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbhLGMfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 07:35:03 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAE22C061574
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 04:31:32 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id p18so9302080plf.13
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 04:31:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9lUHPB2WqXOAiBVqz8lwa/VPd4K7gsmHbCi4yQjtOaM=;
        b=HNiWO1c3kMKRbeu2DaGLDy7I/MrSOxg2gaUn8hn69XVnosy5Ayco+V+mkD/+LX2sMy
         gXXEmlouLJejEGgBE8EL6o7oDSaqz74AO7hMWVQAhOEXuBIyGGH83IZH/ZCMM98mynTs
         uLLtKQyQfqp303jxbqU7NVpqEebLgee3ArVdxZ+f3ykhHwwDhgEdCPMyAlir/mX8Rgt4
         dG66rd1Y297aZNseC1OZDERoAvCBchQSe00ckQ7UaIv/YMcZ9R4USEt1w8R85P50fH6B
         dsQUDerOWzWpnMJXbgO8RZZ5M4rljtCtgURIaoAtUVxUjmgmZyfSjKu85kVv9Hd3l96n
         yXTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9lUHPB2WqXOAiBVqz8lwa/VPd4K7gsmHbCi4yQjtOaM=;
        b=7NLzyw38B4wHqHOSl7e/xi/i4iHANL1b2fLl6soRSNqiXx+f+yI5ceVqLnwndI0mBH
         1seaWZ/BvalsFB+tCLYoFoTFrS+gDR5L3lW6RxUFyhWwDPaWWKkbdZIAeZIIBmfjSKmB
         FkcYw2ecReZbzTXvOaVRKppf4U02+BQJrGW3KXRB5fAAg88e7BFj4Vgo5m3gZdf67DGA
         oCFso4ijdLN1ps2WQbBsT7nIHD+lMdi/U7cAtjecOJxIa/X7dagCSFqIXZJuFZo2w1jC
         QyiYtDcNv+ChSR7j5vAcj1nIeMAfWYD1F1mq1XHdsTZOgEofdx/4XdvCkCfw8FnBvTfJ
         wSPw==
X-Gm-Message-State: AOAM533UXOhPV2CjQ2VXDBAEBVpOzMNnAV/L/5laNC2Vvp1dfrhS1w5O
        xWydhlOZrJEEyl1KsxUnka0ZlQ==
X-Google-Smtp-Source: ABdhPJxRqF9LmXTEfjJkOQk1MHm9tH1NF6gJzZJvl8VwPZdkgYJ9gfpen0t0m56M0kNOD0cAPLJM+g==
X-Received: by 2002:a17:903:186:b0:141:eda2:d5fa with SMTP id z6-20020a170903018600b00141eda2d5famr50587035plg.63.1638880291999;
        Tue, 07 Dec 2021 04:31:31 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([103.207.71.6])
        by smtp.gmail.com with ESMTPSA id n6sm13150000pgk.43.2021.12.07.04.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 04:31:31 -0800 (PST)
Date:   Tue, 7 Dec 2021 20:31:18 +0800
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
Message-ID: <20211207123118.GA255238@leoy-ThinkPad-X240s>
References: <20211021134530.206216-1-leo.yan@linaro.org>
 <20211021134530.206216-5-leo.yan@linaro.org>
 <202110210848.35971643C6@keescook>
 <20211101152835.GB375622@leoy-ThinkPad-X240s>
 <YapEUlcyDZ6TuE6n@arm.com>
 <20211205135103.GA42658@leoy-ThinkPad-X240s>
 <Ya9J8HnMWxBy3MJv@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ya9J8HnMWxBy3MJv@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 07, 2021 at 11:48:00AM +0000, Catalin Marinas wrote:
> On Sun, Dec 05, 2021 at 09:51:03PM +0800, Leo Yan wrote:
> > On Fri, Dec 03, 2021 at 04:22:42PM +0000, Catalin Marinas wrote:
> > > What's the cost of always enabling CONFIG_PID_IN_CONTEXTIDR? If it's
> > > negligible, I'd not bother at all with any of the enabling/disabling.
> > 
> > Yes, I compared performance for PID tracing with always enabling and
> > disabling CONFIG_PID_IN_CONTEXTIDR, and also compared with using
> > static key for enabling/disabling PID tracing.  The result shows the
> > cost is negligible based on the benchmark 'perf bench sched'.
> > 
> > Please see the detailed data in below link (note the testing results
> > came from my Juno board):
> > https://lore.kernel.org/lkml/20211021134530.206216-1-leo.yan@linaro.org/
> 
> The table wasn't entirely clear to me. So the dis/enb benchmarks are
> without this patchset applied.

Yes, dis/enb metrics don't apply this patchset.

> There seems to be a minor drop but it's
> probably noise. Anyway, do we need this patchset or we just make
> CONFIG_PID_IN_CONTEXTIDR default to y?

Good point.  I remembered before we had discussed for making
CONFIG_PID_IN_CONTEXTIDR to 'y', but this approach is not always valid,
especially when the profiling process runs in non-root PID namespace,
in this case, hardware tracing data (e.g. Arm SPE or CoreSight) cannot
trust the PID values from tracing since the PID conflicts between
different PID namespaces.

So this patchset is to add the fundamental mechanism for dynamically
enabling and disable PID tracing into CONTEXTIDR.  Based on it, we can
use helpers to dynamically enable PID tracing _only_ when process runs
in root PID namespace.

> > > Another question: can you run multiple instances of SPE for different
> > > threads on different CPUs? What happens to the global contextidr_in_use
> > > key when one of them stops?
> > 
> > No, I only can launch one instance for Arm SPE event via perf tool; when
> > I tried to launch a second instance, perf tool reports failure:
> > 
> > The sys_perf_event_open() syscall returned with 16 (Device or resource
> > busy) for event (arm_spe_0/load_filter=1,store_filter=1/u).
> [...]
> > Alternatively, I'd like give several examples for contextidr_in_use key
> > values when run different perf modes.
> [...]
> > Hope these three cases can demonstrate the usage for contextidr_in_use
> > static key.
> 
> OK, so we can have multiple uses of PID in CONTEXTIDR. Since
> static_branch_inc() is refcounted, we get away with this but the
> downside is that a CPU won't notice until its next thread switch.

Yes, it's true that after static key is decreased to 0, any CPUs in
the system will notice for the '0' value until the next context
switch.  But I think this will not introduce issue, please see the
flow:

  Step 1: Perf tool: enable event (Arm SPE or CoreSight event)
  Step 2: Perf tool: enable PID tracing when setup AUX buf
  Step 3: Profiling, run specific program or for all CPUs;
          it can have many context switch and all relevant PIDs
          are stored into CONTEXTIDR.
  Step 4: Perf tool: disable PID tracing when free AUX buf
  Step 5: Perf tool: disable event

The latency you mentioned is introduced between step 4 and step 5,
but it doesn't impact any PID tracing for step 3.

And when the CPU will switch context, it will detect the static key is
decreased to zero so it can skip PID tracing.  Thus it also will not
introduce any redundant PID tracing.

Do I miss any potential issue?

Thanks,
Leo
> 
> -- 
> Catalin
