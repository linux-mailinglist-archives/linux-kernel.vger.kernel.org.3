Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 872D649D062
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 18:07:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243556AbiAZRH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 12:07:28 -0500
Received: from mail-oi1-f172.google.com ([209.85.167.172]:37677 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243359AbiAZRH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 12:07:26 -0500
Received: by mail-oi1-f172.google.com with SMTP id u129so813795oib.4;
        Wed, 26 Jan 2022 09:07:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XnY1SI54q5HvUc3L+SPY6gdKVBD2B5KcgxIbNLuymQc=;
        b=EtAqh8OUOU+F6gq3+ZaafcOZpzlj9NKDfPYzdCwNnYvl4d0D7OaGcM10qW04gorc0y
         UV0elecKwob/zh503fLbJ7jRCdvD2hS5Z7lsi93fnZx+i+HUJuYNbzzoVEAApNrZiLqr
         lCsPUm4W/rnH55HeHekiY0a3pa2IwwR9jQds0JkIv64vFohpxKIDzdTTaljepeddTMFZ
         1eXBgmknuCZatxn45bpo8ObPeVwDnJi56RgsBHYRW9gxStUD6+YZzWqE24/NTDtQNYzY
         zPjiLvHLYwNnnOIsHZ9ZePU1kgdl4G75FFkYVpowZZw74d0PT8dAW4H+oysKWNs199vY
         4Plg==
X-Gm-Message-State: AOAM531ApvEWPb2Ix0nqJtavt/n+TFQbOcez/lE9yW2uOZy8uYgi0IMO
        Ixxj38CBLY8EdsJdWJzq6w==
X-Google-Smtp-Source: ABdhPJxQUgzqmtQRKb4Zwd3FAlDFBkluj9T157unv63xB3jC4dyW8GP67AmuT7J4/rhyBEr02/rERQ==
X-Received: by 2002:a05:6808:152b:: with SMTP id u43mr4797879oiw.1.1643216846291;
        Wed, 26 Jan 2022 09:07:26 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id s18sm489244oie.0.2022.01.26.09.07.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 09:07:25 -0800 (PST)
Received: (nullmailer pid 978817 invoked by uid 1000);
        Wed, 26 Jan 2022 17:07:24 -0000
Date:   Wed, 26 Jan 2022 11:07:24 -0600
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
Subject: Re: [RFC V1 06/11] arm64/perf: Drive BRBE from perf event states
Message-ID: <YfF/zBS3kL/+eC1k@robh.at.kernel.org>
References: <1642998653-21377-1-git-send-email-anshuman.khandual@arm.com>
 <1642998653-21377-7-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1642998653-21377-7-git-send-email-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022 at 10:00:48AM +0530, Anshuman Khandual wrote:
> Branch stack sampling rides along the normal perf event and all the branch
> records get captured during the PMU interrupt. This just changes perf event
> handling on the arm64 platform to accommodate required BRBE operations that
> will enable branch stack sampling support.
> 
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: linux-perf-users@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  arch/arm64/kernel/perf_event.c |  6 +++++
>  drivers/perf/arm_pmu.c         | 40 ++++++++++++++++++++++++++++++++++
>  2 files changed, 46 insertions(+)
> 
> diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
> index f6a47036b0b4..11c82c8f2eec 100644
> --- a/arch/arm64/kernel/perf_event.c
> +++ b/arch/arm64/kernel/perf_event.c
> @@ -864,6 +864,12 @@ static irqreturn_t armv8pmu_handle_irq(struct arm_pmu *cpu_pmu)
>  		if (!armpmu_event_set_period(event))
>  			continue;
>  
> +		if (has_branch_stack(event)) {
> +			cpu_pmu->brbe_read(cpuc, event);

Is has_branch_stack() guaranteed to be false on arm32? If not, this will 
be a NULL function ptr. 

To add to my other comments, this patch is where I would add 
brbe_read(), etc. to arm_pmu.

Rob
