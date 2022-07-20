Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54FE157BAC3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 17:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233511AbiGTPrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 11:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231917AbiGTPrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 11:47:23 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D98B41D30
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 08:47:22 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id x23-20020a05600c179700b003a30e3e7989so1553420wmo.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 08:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mWnAaZCfU7C7OmxHqnYWgl+iLsNs720nTVq22EtgHY0=;
        b=sIAZtEguKhFTVPEcL45Kz2Y7TjZTXwniuvUqVOFt6zTUcFdJADS0J8AqBdnyMplZjY
         exEHIpC5cGIigKdZRLIrpUGSld8LfBC+X94IatTDzW+dLDf1k6TIHWW6ATZVIngS1Oos
         nXNorTzk3OQ+4Bw6EpGvQnLBrkMxd5it3oR2PPezjhMG5Q19ijxeGtIEqA74Qr5sjlGW
         N88s/rNDien3FWAJVSLrlCkT2frzA2AlziXYuogGSjxppzEPV90/SDc6MNYJGwkKv/to
         DVOUTZLRibFdeN8jUFaxX1PaFm9GcCgplfvOEKFNijKoimUdpo/tP/OlK08U7ey7KuN7
         RXiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mWnAaZCfU7C7OmxHqnYWgl+iLsNs720nTVq22EtgHY0=;
        b=yVu2HQqnVKcRzce6NW+NPs/fVGo+40EpxfevrHd4yKgQUemODx1kKQV/y9qroMBRRC
         CJSVcYOmuDohwit6Ua+RNpP++V54qkSOLRcGetoK4+jbT3BWFw9sSoYHHvicJ6tJkd1D
         PYw6bMjFVnN0noQcFUnTNQuXh5QVpZihsxrW4HAHD9gUgwyMKVWPP47FasM/yQ5Rkl5A
         VqY6XuJZzCe/Eb6yYMG1HUk+aABUhSqZLoY2ABZEj/Wa6Xl0mKf65qoEMhwW6yCnJUPR
         21CF2FbrM7+qxXbNErmS0UlXbjzjXLIM5wPSxfufsJlTJu6jmAtDXXEYuizU7EfhraD8
         +Blg==
X-Gm-Message-State: AJIora/gciU/Iq2DTRE4puXA+qadnrkGOpDk8oRpBFFEjsadYKkXf8Fx
        jsg+Xryj600Ht3IrM0sfb3slaptBeg6Usfb0pnAOEA==
X-Google-Smtp-Source: AGRyM1uVihkw2Sdalue9OE0oAHLSWWUsyLw0DH9Y+XMIaKbggZq5DpgzwDU0hZoWHWE5Iq2mk7j/ulCfYP4kQSqFlzU=
X-Received: by 2002:a7b:ce13:0:b0:3a3:102c:23d3 with SMTP id
 m19-20020a7bce13000000b003a3102c23d3mr4391193wmc.67.1658332040566; Wed, 20
 Jul 2022 08:47:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220704150514.48816-1-elver@google.com> <CANpmjNP0hPuhXmZmkX1ytCDh56LOAmxJjf7RyfxOvoaem=2d8Q@mail.gmail.com>
In-Reply-To: <CANpmjNP0hPuhXmZmkX1ytCDh56LOAmxJjf7RyfxOvoaem=2d8Q@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 20 Jul 2022 08:47:08 -0700
Message-ID: <CAP-5=fXgYWuHKkfAxxTeAzTuq7PLwMd6UvBu+J+6tnqHwraSCA@mail.gmail.com>
Subject: Re: [PATCH v3 00/14] perf/hw_breakpoint: Optimize for thousands of tasks
To:     Marco Elver <elver@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-perf-users@vger.kernel.org,
        x86@kernel.org, linux-sh@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 6:41 AM Marco Elver <elver@google.com> wrote:
>
> On Mon, 4 Jul 2022 at 17:05, Marco Elver <elver@google.com> wrote:
> >
> > The hw_breakpoint subsystem's code has seen little change in over 10
> > years. In that time, systems with >100s of CPUs have become common,
> > along with improvements to the perf subsystem: using breakpoints on
> > thousands of concurrent tasks should be a supported usecase.
> [...]
> > Marco Elver (14):
> >   perf/hw_breakpoint: Add KUnit test for constraints accounting
> >   perf/hw_breakpoint: Provide hw_breakpoint_is_used() and use in test
> >   perf/hw_breakpoint: Clean up headers
> >   perf/hw_breakpoint: Optimize list of per-task breakpoints
> >   perf/hw_breakpoint: Mark data __ro_after_init
> >   perf/hw_breakpoint: Optimize constant number of breakpoint slots
> >   perf/hw_breakpoint: Make hw_breakpoint_weight() inlinable
> >   perf/hw_breakpoint: Remove useless code related to flexible
> >     breakpoints
> >   powerpc/hw_breakpoint: Avoid relying on caller synchronization
> >   locking/percpu-rwsem: Add percpu_is_write_locked() and
> >     percpu_is_read_locked()
> >   perf/hw_breakpoint: Reduce contention with large number of tasks
> >   perf/hw_breakpoint: Introduce bp_slots_histogram
> >   perf/hw_breakpoint: Optimize max_bp_pinned_slots() for CPU-independent
> >     task targets
> >   perf/hw_breakpoint: Optimize toggle_bp_slot() for CPU-independent task
> >     targets
> [...]
>
> This is ready from our side, and given the silence, assume it's ready
> to pick up and/or have a maintainer take a look. Since this is mostly
> kernel/events, would -tip/perf/core be appropriate?

These are awesome improvements, I've added my acked-by to every
change. I hope we can pull these changes, as you say, into tip.git
perf/core and get them into 5.20.

Thanks,
Ian

> Thanks,
> -- Marco
