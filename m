Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79ED049D029
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 17:59:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243384AbiAZQ7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 11:59:47 -0500
Received: from mail-ot1-f52.google.com ([209.85.210.52]:34369 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236746AbiAZQ7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 11:59:46 -0500
Received: by mail-ot1-f52.google.com with SMTP id b17-20020a9d4791000000b005a17fc2dfc1so2477426otf.1;
        Wed, 26 Jan 2022 08:59:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YQ5BAI7S/KVmQ/LV/p1EHUUf4M859iY+jX0AOgHG8QE=;
        b=DZ5KPyNa33M/dN2bVqZwSTD1ZVWYAYP7owdtxNXZBIcKpDfurnxYbjgRTgbzDtXF58
         DEH1CGw37ARgPcsrt8r4SCvdJSnCUSG97xEGdND/Zj/yq+RQhzi3+P1kghGpHH3B4nQm
         eofKmoA0/fsboaHbBAs8Arz6j+oMUXGAVqAxCUFMQ3LXECR+tT0aGjKUV9NI2upUPbHf
         3me7XSWtMSLx34BwWmoWninDZY1WsBRJ9LcQL5NAN3ukAzv+9ZCwU23S4salI4byRNfS
         XWAWLBnQDb9Vh9zuSNmKaYvcbLN6UJ8OBaGF++ncDnFk+6xCSJ/UpJF7p8QmhNXhvDLl
         yBog==
X-Gm-Message-State: AOAM532nkqxdBMqjjt/Y1LZY03312eQBOjd+yp+k7YFn8OuVw+jsQwop
        pc3TgyFLtBk9c1hN447WN52baSnUKA==
X-Google-Smtp-Source: ABdhPJwMUHlaE6s6swqJbVgEUfJw9eAQzgx+aBQaduDIHooIsdoIcZWSjGo489GbmMtxKCkfy9zBSA==
X-Received: by 2002:a05:6830:1508:: with SMTP id k8mr4401551otp.382.1643216385703;
        Wed, 26 Jan 2022 08:59:45 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id 59sm5170318oti.74.2022.01.26.08.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 08:59:45 -0800 (PST)
Received: (nullmailer pid 968366 invoked by uid 1000);
        Wed, 26 Jan 2022 16:59:44 -0000
Date:   Wed, 26 Jan 2022 10:59:44 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: Re: [RFC V1 03/11] arm64/perf: Update struct arm_pmu for BRBE
Message-ID: <YfF+APV2vew5AloE@robh.at.kernel.org>
References: <1642998653-21377-1-git-send-email-anshuman.khandual@arm.com>
 <1642998653-21377-4-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1642998653-21377-4-git-send-email-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022 at 10:00:45AM +0530, Anshuman Khandual wrote:
> This updates struct arm_pmu to include all required helpers that will drive

From submitting-patches.rst:

Describe your changes in imperative mood, e.g. "make xyzzy do frotz"
instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy
to do frotz", as if you are giving orders to the codebase to change
its behaviour.

> BRBE functionality for a given PMU implementation. These are the following.

Don't describe what the change is, one can read the diff for that. 
Answer why it is needed.

One thing to answer in the commit msg is why we need the hooks here.  
Have we concluded that adding BRBE hooks to struct arm_pmu for what is 
an armv8 specific feature is the right approach? I don't recall 
reaching that conclusion.

> 
> - brbe_filter	: Convert perf event filters into BRBE HW filters
> - brbe_probe	: Probe BRBE HW and capture its attributes
> - brbe_enable	: Enable BRBE HW with a given config
> - brbe_disable	: Disable BRBE HW
> - brbe_read	: Read BRBE buffer for captured branch records
> - brbe_reset	: Reset BRBE buffer
> - brbe_supported: Whether BRBE is supported or not

The function names seem pretty self-explanatory, but the text is needed, 
shouldn't it be in the struct declaration.

I'm not really a fan of patches adding dead code. That's not any less to 
review. Restructuring with 'no functional change' OTOH is helpful in 
reviewing.

> A BRBE driver implementation needs to provide these functionalities.
> 
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-perf-users@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  arch/arm64/kernel/perf_event.c | 36 ++++++++++++++++++++++++++++++++++
>  include/linux/perf/arm_pmu.h   |  7 +++++++
>  2 files changed, 43 insertions(+)
> 
> diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
> index cab678ed6618..f6a47036b0b4 100644
> --- a/arch/arm64/kernel/perf_event.c
> +++ b/arch/arm64/kernel/perf_event.c
> @@ -1015,6 +1015,35 @@ static int armv8pmu_filter_match(struct perf_event *event)
>  	return evtype != ARMV8_PMUV3_PERFCTR_CHAIN;
>  }
>  
> +static void armv8pmu_brbe_filter(struct pmu_hw_events *hw_event, struct perf_event *event)
> +{
> +}
> +
> +static void armv8pmu_brbe_enable(struct pmu_hw_events *hw_event)
> +{
> +}
> +
> +static void armv8pmu_brbe_disable(struct pmu_hw_events *hw_event)
> +{
> +}
> +
> +static void armv8pmu_brbe_read(struct pmu_hw_events *hw_event, struct perf_event *event)
> +{
> +}
> +
> +static void armv8pmu_brbe_probe(struct pmu_hw_events *hw_event)
> +{
> +}
> +
> +static void armv8pmu_brbe_reset(struct pmu_hw_events *hw_event)
> +{
> +}
> +
> +static bool armv8pmu_brbe_supported(struct perf_event *event)
> +{
> +	return false;
> +}
> +
>  static void armv8pmu_reset(void *info)
>  {
>  	struct arm_pmu *cpu_pmu = (struct arm_pmu *)info;
> @@ -1247,6 +1276,13 @@ static int armv8_pmu_init(struct arm_pmu *cpu_pmu, char *name,
>  
>  	cpu_pmu->pmu.event_idx		= armv8pmu_user_event_idx;
>  
> +	cpu_pmu->brbe_filter		= armv8pmu_brbe_filter;
> +	cpu_pmu->brbe_enable		= armv8pmu_brbe_enable;
> +	cpu_pmu->brbe_disable		= armv8pmu_brbe_disable;
> +	cpu_pmu->brbe_read		= armv8pmu_brbe_read;
> +	cpu_pmu->brbe_probe		= armv8pmu_brbe_probe;
> +	cpu_pmu->brbe_reset		= armv8pmu_brbe_reset;
> +	cpu_pmu->brbe_supported		= armv8pmu_brbe_supported;
>  	cpu_pmu->name			= name;
>  	cpu_pmu->map_event		= map_event;
>  	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_EVENTS] = events ?
> diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
> index 2512e2f9cd4e..c0dd0d6c5883 100644
> --- a/include/linux/perf/arm_pmu.h
> +++ b/include/linux/perf/arm_pmu.h
> @@ -98,6 +98,13 @@ struct arm_pmu {
>  	void		(*reset)(void *);
>  	int		(*map_event)(struct perf_event *event);
>  	int		(*filter_match)(struct perf_event *event);
> +	void		(*brbe_filter)(struct pmu_hw_events *hw_events, struct perf_event *event);
> +	void		(*brbe_probe)(struct pmu_hw_events *hw_events);
> +	void		(*brbe_enable)(struct pmu_hw_events *hw_events);
> +	void		(*brbe_disable)(struct pmu_hw_events *hw_events);
> +	void		(*brbe_read)(struct pmu_hw_events *hw_events, struct perf_event *event);
> +	void		(*brbe_reset)(struct pmu_hw_events *hw_events);
> +	bool		(*brbe_supported)(struct perf_event *event);
>  	int		num_events;
>  	bool		secure_access; /* 32-bit ARM only */
>  #define ARMV8_PMUV3_MAX_COMMON_EVENTS		0x40
> -- 
> 2.25.1
> 
> 
