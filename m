Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9BC7562EFA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 10:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbiGAIwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 04:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235459AbiGAIwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 04:52:01 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF2F73882
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 01:50:58 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id p14so1838792pfh.6
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 01:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NpRXk4jV90bRtUR15hmt0i14ieFagLdfbHK8d4tpGTs=;
        b=SmLFiye3JATZgeKSmShf1OxL0h3l50qmqP+Z74Qih4tVfSF2Z8C2rVGTQ8902NQNl4
         FnNBcOpyp7++AySC3yYjI4h5qRyKsVXkhjwCbdSTmdsb2FBaALpnVxKrhJdvYRH+ZnLX
         C6np/a7x53soXE48sHNUcwZUBDTdoDY/AfdXDIBBl9NFKCjDF55qF5kFcTSg4lV/zKs6
         heZx9WMYM9FOZbrHorXBkWash2WrWHiR5EY/qDE/8GwUjcE6CPFPis11AEnsuJhwFxY6
         bAfGbPw4P9Mcuph3r+vW3Ee1cFYrZ76g55OBaMZHfDGTaA8nMKgzXMXVW7ydGtFHDMV4
         g9UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NpRXk4jV90bRtUR15hmt0i14ieFagLdfbHK8d4tpGTs=;
        b=Pm4jK7D58K4n4HEQPMyHPxcz/xL4xHBXQ/GpypNTowNsS306Qh85LVE77t1zmItqRi
         orGld+KHaKbVfE14aD81qvsIpUP5rhyxcfQ86DwuFtfNEUOUSpmLWK5E+CvdhV0KJfHN
         KUf2P3Tx1LrZ97IySxAYTvosVmBy96fuqDO4ktzTnOApmpnd9Jsau9EL4MjshzgMGMt8
         WZ5axikVdX6qpDpI6tVVB0vsLp30ZMxcBqlS5vg1pxQcGVc2y+qK4Al2pWcP17iURsPq
         lyV+X/z3HYFT76PCMhzI6itQaIP17/E+PAQviEyWDxaWF/0z2/6I/CPQ4qGoq2f24rtc
         WA6Q==
X-Gm-Message-State: AJIora/hGCtiUQLuf+Ts956Hnkc7LLD625tcAryJ7ESkNXZxamG0M9EU
        5DcTOZK4AIHjqk+eeyShOCo8Zw==
X-Google-Smtp-Source: AGRyM1sBoxQvPFMofEy7Amutshz9lb4eKHTinMCcn55tpYgDe6eKvXOdaS0sZMYKZjUecCppyiyNBg==
X-Received: by 2002:a65:604a:0:b0:3f9:f423:b474 with SMTP id a10-20020a65604a000000b003f9f423b474mr11219622pgp.527.1656665458008;
        Fri, 01 Jul 2022 01:50:58 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (n058152077154.netvigator.com. [58.152.77.154])
        by smtp.gmail.com with ESMTPSA id cp2-20020a170902e78200b0015e8d4eb1d7sm14952715plb.33.2022.07.01.01.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 01:50:56 -0700 (PDT)
Date:   Fri, 1 Jul 2022 16:50:52 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: Regarding perfmon_capable()
Message-ID: <20220701085052.GB659023@leoy-ThinkPad-X240s>
References: <9be223fb-5803-b676-902a-28e1c168cd8a@arm.com>
 <20220701064732.GA659023@leoy-ThinkPad-X240s>
 <54ea5d8c-74ad-c89a-929f-5d570ca351df@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54ea5d8c-74ad-c89a-929f-5d570ca351df@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 01, 2022 at 12:52:36PM +0530, Anshuman Khandual wrote:
> 
> 
> On 7/1/22 12:17, Leo Yan wrote:
> > Hi Anshuman,
> > 
> > On Fri, Jul 01, 2022 at 10:37:37AM +0530, Anshuman Khandual wrote:
> >> Hello,
> >>
> >> In perf event subsystem and related platform drivers registering a PMU,
> >> should perfmon_capable() be used directly ? OR just wondering if instead
> >> perf_allow_[cpu|kernel|tracepoint]() helpers should be used which also
> >> checks for 'sysctl_perf_event_paranoid' ? Should not both capabilities
> >> and 'sysctl_perf_event_paranoid' decide whether kernel/cpu/tracepoint
> >> events will be captured for unprivileged users.
> > 
> > This is an interesting but important topic, let me join the discussion.
> > 
> > Simply to say, sysctl_perf_event_paranoid is a control knob,
> > perfmon_capable() is for capabilities.  perfmon_capable() only allows
> > privileged Perf users to access Perf events; on the other hand,
> > sysctl_perf_event_paranoid can grant green light for non-privileged
> > users to access perf events.
> 
> Could not unprivileged users have capabilities too ? I thought that was
> the whole point for capabilities.

Agree, I might introduce confusion so just clarify.

Based on the document Documentation/admin-guide/perf-security.rst, we can
"create perf_users group for privileged Perf users".  Here privileged
users mean not only the root user, it also includes the users in
perf_users group.

> > Therefore, if we use function perf_allow_[cpu|kernel|tracepoint]() as
> > checking condition which is interfered by sysctl_perf_event_paranoid,
> > it's superset of perfmon_capable().
> 
> Right. IIUC sysctl_perf_event_paranoid was the original method for perf
> event to restrict access, where as capabilities is the new method. Hence
> both needs to be checked for compatibility purpose for the original one.
> 
> > 
> > On the other hand, even a Perf event can be opened by a non-privileged
> > process, the low level driver still doesn't want to leak any sensitive
> > info in the trace data or sampling.  This is why Arm SPE driver checks
> 
> Can/should low level PMU drivers enforce yet another layer of privilege
> check even after the core perf allowed the event to be created in the
> first place ?

Good point.  Seems to me, Perf core layer checks permission with a big
granularity, and low level driver can control permission with smaller
granularity, e.g. for a perf event, the low level driver can control
only its partial functionality used by non-privileged users.

> > the condition perfmon_capable() and disables CONTEXTIDR tracing for
> > non-privileged users (no matter what's the value of
> > sysctl_perf_event_paranoid).
> > 
> > Just bear in mind for a corner case, some perf callback functions are
> > invoked from the kernel threads context rather than user process
> > context, this is why we might obeserve some strange cases that
> > non-privileged users might be wrongly granted some tracing
> > capabilities even we check with perfmon_capable() (Checking
> > perfmon_capable() is not wrong, but it's wrong to do the checking in
> > the kernel kthread context rather than user process context).
> 
> Is not pmu->event_init() called in user process context itself. Why can
> not all privillege checking be done there and stored (if required) some
> where more platform specific e.g event->hw.config or any other platform
> data structure. Why should privilege gets checked in callbacks which
> might run in privilege contexts to create such corner cases ?

TBH, I didn't remember in details, but let's assume if Perf works in
system wide mode and it needs to enable PMU for all CPUs in the system.
IIUC, it needs to use per CPU's workqueue to enable PMU events, I think
the function event_function_call() can give hints for why some Perf flow
is not invoked in user process context.

Thanks,
Leo
