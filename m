Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7478562BFB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 08:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235081AbiGAGrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 02:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233921AbiGAGri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 02:47:38 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E96EF61D4D
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 23:47:37 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id m14so1516636plg.5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 23:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bLVC9it3gmaPHJbhg9kCZYOMzKfegXg+q16RKxyP15o=;
        b=JMQ3v9F3Wkvf2R+Gg79xbs9iZfEor1A698jLijhIABV4Sc/5kejA5j2sKjbs9VeSWF
         Y7ubTAvpb3wBQiHW2cCkshkd14DL4mnt88ZkS/hNI15JpVfXKstFDyBDWmGZafFDkAuR
         5vuTRKYNDw9YITuj6sX93J5CHn1dAheZ0+TIcAf8KCPJQDlcRXNbOy/gIvxAMRgRrRhP
         NO/VRDHbB/Xx1rDIIYak1ZbiXvcuTTxMt8Pp6+cg6QG8+ZGlXNKZRwac4YLO8D/kTPs8
         tSgikzYINPGBU70IwRi5gRR1hbU8KsL44tBMucfOJvvu9woKQIh1Up8YNVAyZ8aQosl4
         lHRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bLVC9it3gmaPHJbhg9kCZYOMzKfegXg+q16RKxyP15o=;
        b=kE/seQs+9gX09cJWtlKMxHEN1sxUN8+O/Kd+Y/bpgwCjm40OBahL6hTE8a1hNwresl
         K0Q79OzzuV5I8C8uIbtsnML/gWJ3aElHGNguQB4r8nELu/0wDqpDiS/nMtekX5pt/CpE
         u8x4DZg1g3OFLFmIa70bQLRazbAaOyvCSVTLghTNcWMQuafktXKhGtQieu8vB6ij8+iW
         NPGsOgqFOS52YPZrK3NZztSZ4HrDSwRyiOyAljdU6mAK2f3hiRWXjXLpKKA1xs9rh0eY
         Y6rhAuPxDOH2rqE4dkZM7vG71lG4/RXuOJb1BU2KodkFSQTTXSGeiqDtC3IBAWFX1DK8
         V9UQ==
X-Gm-Message-State: AJIora9cvLKzyH7NJjJR71d12x/5QS+FRV4486n8GmqQHeekcjTxl/cY
        ZcDb08GT4zwyAoMFStRFGQr7EA==
X-Google-Smtp-Source: AGRyM1sud3jqozmQqZwtjyntxxGBahXTtLOoRYbtLEF6tu93QeH8b1pKj1c/Zgri/AMZiBkRIqiCfQ==
X-Received: by 2002:a17:902:ec8e:b0:16a:2d25:aa5b with SMTP id x14-20020a170902ec8e00b0016a2d25aa5bmr19512859plg.69.1656658057255;
        Thu, 30 Jun 2022 23:47:37 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (n058152077154.netvigator.com. [58.152.77.154])
        by smtp.gmail.com with ESMTPSA id v14-20020aa7808e000000b00518e1251197sm15270706pff.148.2022.06.30.23.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 23:47:36 -0700 (PDT)
Date:   Fri, 1 Jul 2022 14:47:32 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: Regarding perfmon_capable()
Message-ID: <20220701064732.GA659023@leoy-ThinkPad-X240s>
References: <9be223fb-5803-b676-902a-28e1c168cd8a@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9be223fb-5803-b676-902a-28e1c168cd8a@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anshuman,

On Fri, Jul 01, 2022 at 10:37:37AM +0530, Anshuman Khandual wrote:
> Hello,
> 
> In perf event subsystem and related platform drivers registering a PMU,
> should perfmon_capable() be used directly ? OR just wondering if instead
> perf_allow_[cpu|kernel|tracepoint]() helpers should be used which also
> checks for 'sysctl_perf_event_paranoid' ? Should not both capabilities
> and 'sysctl_perf_event_paranoid' decide whether kernel/cpu/tracepoint
> events will be captured for unprivileged users.

This is an interesting but important topic, let me join the discussion.

Simply to say, sysctl_perf_event_paranoid is a control knob,
perfmon_capable() is for capabilities.  perfmon_capable() only allows
privileged Perf users to access Perf events; on the other hand,
sysctl_perf_event_paranoid can grant green light for non-privileged
users to access perf events.

Therefore, if we use function perf_allow_[cpu|kernel|tracepoint]() as
checking condition which is interfered by sysctl_perf_event_paranoid,
it's superset of perfmon_capable().

On the other hand, even a Perf event can be opened by a non-privileged
process, the low level driver still doesn't want to leak any sensitive
info in the trace data or sampling.  This is why Arm SPE driver checks
the condition perfmon_capable() and disables CONTEXTIDR tracing for
non-privileged users (no matter what's the value of
sysctl_perf_event_paranoid).

Just bear in mind for a corner case, some perf callback functions are
invoked from the kernel threads context rather than user process
context, this is why we might obeserve some strange cases that
non-privileged users might be wrongly granted some tracing
capabilities even we check with perfmon_capable() (Checking
perfmon_capable() is not wrong, but it's wrong to do the checking in
the kernel kthread context rather than user process context).

This is my understanding, just correct me if any thing mentioned
is not reliable.

Thanks,
Leo

> arch/parisc/kernel/perf.c:      if (!perfmon_capable())
> arch/powerpc/perf/imc-pmu.c:    if (!perfmon_capable())
> arch/powerpc/perf/imc-pmu.c:    if (!perfmon_capable())
> drivers/gpu/drm/i915/i915_perf.c:           i915_perf_stream_paranoid && !perfmon_capable()) {
> drivers/gpu/drm/i915/i915_perf.c:                       if (oa_freq_hz > i915_oa_max_sample_rate && !perfmon_capable()) {
> drivers/gpu/drm/i915/i915_perf.c:       if (i915_perf_stream_paranoid && !perfmon_capable()) {
> drivers/gpu/drm/i915/i915_perf.c:       if (i915_perf_stream_paranoid && !perfmon_capable()) {
> drivers/media/rc/bpf-lirc.c:            if (perfmon_capable())
> drivers/perf/arm_spe_pmu.c:     if (IS_ENABLED(CONFIG_PID_IN_CONTEXTIDR) && perfmon_capable())
> drivers/perf/arm_spe_pmu.c:     if (!perfmon_capable() &&
> 
> Although BPF might use perfmon_capabale() alone, because it was never
> dependent on 'sysctl_perf_event_paranoid' ?
> 
> - Anshuman
